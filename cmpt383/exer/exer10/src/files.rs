use std::fmt;
#[derive(Debug, Clone)]
pub struct SummationError {
    msg: String,
}

impl std::error::Error for SummationError {}
impl fmt::Display for SummationError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.msg)
    }
}
impl From<std::io::Error> for SummationError {
    fn from(e: std::io::Error) -> SummationError {
        SummationError {
            msg: format!("io::Error: {}", e),
        }
    }
}
impl From<std::num::ParseIntError> for SummationError {
    fn from(e: std::num::ParseIntError) -> SummationError {
        SummationError {
            msg: format!("ParseIntError: {}", e),
        }
    }
}


pub fn  sum_file_1 (pa: &std::path::Path )-> Result<i64, SummationError>{
    let read_file= std::fs::read_to_string(pa);
    match read_file{
        Ok(file)=>{
            let element:Vec<&str>= file.trim().split('\n').collect();
            let mut sum =0;
            for el in element{
                let is_valid = el.parse::<i64>();
                match is_valid{
                    Ok(n)=>{
                        sum += n;
                    }
                    Err(e) =>{
                        let se = SummationError::from(e);
                        return Err(se);
                    }
                }
            }
            return Ok(sum);
        }
        Err(e) =>{
            let se = SummationError::from(e);
            return Err(se);
        }
    }
}

pub fn sum_file_2 (pa: &std::path::Path )-> Result<i64, SummationError>{
    let file= std::fs::read_to_string(pa)?;
    let element:Vec<&str>= file.trim().split('\n').collect();
    let mut sum =0;
    for el in element{
        let elm = el.parse::<i64>()?;
        sum += elm;
    }
    return Ok(sum);

}
