Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B09BC23A16
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2019 16:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfETOdG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 May 2019 10:33:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60678 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfETOdG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 May 2019 10:33:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KESpn9096223;
        Mon, 20 May 2019 14:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=1kF8nXi1bb2JDfE2pWDUAwzQSWIRZ2NytOwtgxfIozA=;
 b=JxDLSQ6vmnOrDPZQHsoC4bRExbJm72irHUZYUPLyvcHwEmFM9Jleb9HCK0I4A1VpLWdr
 Q1SArJ0qtHNmmi7lGATVC+2yfaLXWIA/IqxBj/82g9CN4x1b/DJ+OFOLksZyMqJxUZIL
 /1WflYVsU5OZ/BTaccPwTlKuwy2G0yNQDPBOxMOWKpB/oRtCCuvW/vChttf7RjYaEGEa
 JLlpk6g6RYtPO+molacq/3zLnI+ffr9nZQ1lWZQTQ9GuG2tKT+hB6MHVqd1jYghB+697
 Ikw91EHczEKgNDabxZM2Gh2QTmJCpF7NYrubIEV4MBI0g2wx1KKowPBwcx58oiJNFLMY lA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sj9ft7cqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 14:32:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KEVTgh035522;
        Mon, 20 May 2019 14:32:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2sks1xmkcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 14:32:32 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4KEWVZi030580;
        Mon, 20 May 2019 14:32:31 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 May 2019 14:32:31 +0000
Date:   Mon, 20 May 2019 07:32:46 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Murphy Zhou <xzhou@redhat.com>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] tests/generic/54{0..3}: redirect FILEFRAG error output
 to .full too
Message-ID: <20190520143246.GI5352@magnolia>
References: <20190520062818.12421-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520062818.12421-1-xzhou@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905200096
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200096
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 20, 2019 at 02:28:18PM +0800, Murphy Zhou wrote:
> NFSv4.2 supports reflink but does not support FIBMAP. These 4 tests
> about file content can pass on NFSv4.2, but FILEFRAG complaint :
> +/mnt/testarea/scratch/test-542/file2: FIBMAP unsupported
> is breaking golden output.
> 
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>

Looks ok to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/generic/540 | 8 ++++----
>  tests/generic/541 | 8 ++++----
>  tests/generic/542 | 8 ++++----
>  tests/generic/543 | 8 ++++----
>  4 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/generic/540 b/tests/generic/540
> index 65a71f22..dc4d9485 100755
> --- a/tests/generic/540
> +++ b/tests/generic/540
> @@ -72,16 +72,16 @@ _weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
>  
>  # now reflink into the rainbow
>  echo "before reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c "reflink $testdir/file2 $roff $roff $rsz" $testdir/file3 >> $seqres.full
>  _pwrite_byte 0x64 $roff $rsz $testdir/file3.chk >> $seqres.full
>  _scratch_cycle_mount
>  
>  echo "Compare files"
>  echo "after reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  md5sum $testdir/file1 | _filter_scratch
>  md5sum $testdir/file2 | _filter_scratch
>  md5sum $testdir/file3 | _filter_scratch
> diff --git a/tests/generic/541 b/tests/generic/541
> index e7e19be4..fcb5d567 100755
> --- a/tests/generic/541
> +++ b/tests/generic/541
> @@ -74,8 +74,8 @@ _weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
>  
>  # now reflink the rainbow
>  echo "before reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c "reflink $testdir/file3 $roff $roff $rsz" $testdir/file2 >> $seqres.full
>  cp $testdir/file3.chk $testdir/file2.chk
>  _pwrite_byte 0x64 0 $roff $testdir/file2.chk >> $seqres.full
> @@ -84,8 +84,8 @@ _scratch_cycle_mount
>  
>  echo "Compare files"
>  echo "after reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  md5sum $testdir/file1 | _filter_scratch
>  md5sum $testdir/file2 | _filter_scratch
>  md5sum $testdir/file2.chk | _filter_scratch
> diff --git a/tests/generic/542 b/tests/generic/542
> index c416ab69..62b32cb5 100755
> --- a/tests/generic/542
> +++ b/tests/generic/542
> @@ -73,16 +73,16 @@ _weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
>  
>  # now reflink into the rainbow
>  echo "before reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c "reflink $testdir/file2 $soff $doff $rsz" $testdir/file3 >> $seqres.full
>  _pwrite_byte 0x64 $doff $rsz $testdir/file3.chk >> $seqres.full
>  _scratch_cycle_mount
>  
>  echo "Compare files"
>  echo "after reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  md5sum $testdir/file1 | _filter_scratch
>  md5sum $testdir/file2 | _filter_scratch
>  md5sum $testdir/file3 | _filter_scratch
> diff --git a/tests/generic/543 b/tests/generic/543
> index 50a51f89..cc7ee532 100755
> --- a/tests/generic/543
> +++ b/tests/generic/543
> @@ -75,8 +75,8 @@ _weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
>  
>  # now reflink the rainbow
>  echo "before reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c "reflink $testdir/file3 $soff $doff $rsz" $testdir/file2 >> $seqres.full
>  $XFS_IO_PROG -c "truncate $doff" $testdir/file2.chk
>  dd if=$testdir/file3.chk skip=$((soff / blksz)) count=$((rsz / blksz)) bs=$blksz >> $testdir/file2.chk 2> /dev/null
> @@ -84,8 +84,8 @@ _scratch_cycle_mount
>  
>  echo "Compare files"
>  echo "after reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  md5sum $testdir/file1 | _filter_scratch
>  md5sum $testdir/file2 | _filter_scratch
>  md5sum $testdir/file2.chk | _filter_scratch
> -- 
> 2.21.0
> 
