use debug::PrintTrait;

fn main() {
    let num_decimal = 171717_u32;
    let num_hex = 0x29ec5_u32;
    let num_octal = 0o517305;
    let num_binary = 0b101001111011000101;
    assert(num_decimal == num_hex, 'numeric literal cmp');
    assert(num_decimal == num_octal, 'numeric literal cmp');
    assert(num_decimal == num_binary, 'numeric literal cmp');
}

#[test]
fn test_main() {
    main();
}

