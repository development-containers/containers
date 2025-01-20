export default (data: Lume.Data, filters: Lume.Helpers) => {
    const { title, date } = data;
  
    return (
      <header>
        <h1>{title}</h1>
        {[1,2,3,4,5].map( e => 
        <p>This is paragraph number {e}</p>)
        }

        <hr />
        {date.toString()}
      </header>
    );
  };