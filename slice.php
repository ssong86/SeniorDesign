    <?php
    include_once(realpath(dirname(__FILE__) . "/../../include/Page/class_path.php"));
    $path = new Path();
    include_once($path->getFilePath("class_page"));
    include_once($path->getFilePath("class_session"));
    include_once($path->getFilePath("class_video"));
    include_once($path->getFilePath("class_play"));
    include_once($path->getFilePath("class_scripts_global_settings"));

    if(isset($_GET['src']) && isset($_GET['start']) && isset($_GET['duration']) && isset($_GET['year']) && isset($_GET['gameID']) && isset($_GET['quarter']) && isset($_GET['filename'])) {
        $src =  $_GET['src'];
        $src = urldecode($src);
        #echo $src;

        $start = $_GET['start'];
        $start = urldecode($start);
        echo $start;

        $duration = $_GET['duration'];
        $duration = urldecode($duration);
        #echo $duration;

        $year = $_GET['year'];
        #echo $year;

        $gameID = $_GET['gameID'];
        #echo $gameID;

        $quarter = $_GET['quarter'];
        #echo $quarter;

        $filename = $_GET['filename'];
        $filename = urldecode($filename);
        #echo $filename;
    } else {
        throw new Exception('Invalid parameters, expected src, start, duration, year, gameID, quarter, filename');
    }
   

    #ffmpeg must be installed in /urs/local/bin for now
    #sudo chmod -R 777 2016
    //echo 'ffmpeg -i '.$src.' -ss '.$start.' -t '.$duration.' -async 1 -strict -2 -vcodec libx264 -pix_fmt yuv420p '.$filename.'.mp4';
    $dest = '/var/www/html/videos/'.$year.'/G'.$gameID.'/Q'.$quarter.'/raw/';
    echo shell_exec('echo yes | /usr/local/bin/ffmpeg -i '.$src.' -ss '.$start.' -t '.$duration.' -async 1 -strict -2 -vcodec libx264 -pix_fmt yuv420p '.$dest.$filename.'.mp4'." 2>&1");

    $v = new Video($vid);
    $v->VideoFileName = $filename;
    $v->VideoPath = $year.'/G'.$gameID.'/Q'.$quarter.'/';
    $v->GameID = $gameID;
    $v->Quarter = $quarter;
    $v->Approved = "N";
    $v->save();
    
    #install ffmpeg components
    ?>