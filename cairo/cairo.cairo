use array::ArrayTrait;

fn rotateImage90DegreesClockwise(originalImage: Array<u256> ) {

    let length: u32 = originalImage.len();

    let i: u32 = 0;
    let j: u32= length -1;

    loop {
        if(i > j) {
            break();
        }
    
    let temp: u256 = originalImage[i];
    originalImage[i] = originalImage[j];
    originalImage[j] = temp;        
    
    }
}

