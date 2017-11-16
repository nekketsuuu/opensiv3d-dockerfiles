# include <Siv3D.hpp>

void Main()
{
    const Font font(30);

    while (System::Update())
    {
        Circle(Cursor::Pos(), 100).draw();

        font(Cursor::Pos()).draw(50, 200, Palette::Orange);
    }
}
