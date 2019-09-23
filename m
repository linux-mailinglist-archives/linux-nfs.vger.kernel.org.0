Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B184BBCB9
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2019 22:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502535AbfIWUVm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Sep 2019 16:21:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44398 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfIWUVl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Sep 2019 16:21:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8NKJ6x7182510;
        Mon, 23 Sep 2019 20:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=WgIuifTg5gIGmSTI3B9o2b9vM8FU5W1zTNyTCCWOKOs=;
 b=giV61E0hq5sGM9JSRlSxXdXBpJRBdfRpQi23877o0P8RXdNxBebFBRX6fhABSVSfSBMO
 ytVkIMYOhwtYidL2QnzUd95BnlwE+h2W/a/z6FHjy+U8rGSVMWe67jNRJTSq/Vr62ctV
 afpzOiw3OxAYFFayt/HBOjAy4AyjyfuzqXmWcIK/Qz0ESw6SKpgjuY2fmQD7mkSH/wm3
 ezRI8fkR9srbs/LFjyVZbnoSU1FxoJyLOvIdc/Dk/43f8tR7wg8x5BOVMFGEuUYKpp6F
 xInJCF0A8jEGDkE9sA6bFJXLI4eiFdyI9zwiNVzYuKp0ZRiAf44aSmYhSe2FyRqkKG8P yA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v5btpse9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 20:21:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8NKITYg173511;
        Mon, 23 Sep 2019 20:21:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2v6yvherve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 20:21:37 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8NKLaSB027639;
        Mon, 23 Sep 2019 20:21:36 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Sep 2019 13:21:36 -0700
Date:   Mon, 23 Sep 2019 13:21:35 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: generic/495: swap on sparse file over NFS
Message-ID: <20190923202135.GD736475@magnolia>
References: <20190923200036.GA5085@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923200036.GA5085@fieldses.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909230170
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909230170
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 23, 2019 at 04:00:36PM -0400, J. Bruce Fields wrote:
> I'm updating to a newer xfstests and seeing:
> 
> generic/495     - output mismatch (see
> /root/xfstests-dev/results//generic/495.out.bad)
>     --- tests/generic/495.out   2019-09-18 17:28:00.834721480 -0400
>     +++ /root/xfstests-dev/results//generic/495.out.bad 2019-09-20 13:34:01.1568
> 89741 -0400
>     @@ -1,5 +1,4 @@
>      QA output created by 495
>      File with holes
>     -swapon: Invalid argument
>      Empty swap file (only swap header)
>      swapon: Invalid argument
> 
> If I understand correctly, it's requiring swapon to fail on a sparse
> file, which isn't going to happen on NFS, where the sparsenes of the
> file isn't really the client's concern.

It looks that way to me... :)

> Is it really correct to *require* swapon to fail in this case?

Hm.  TBH I was expecting an fpunch call or something to guarantee that
we even /have/ a sparse file, since (for all we know) a filesystem could
interpret "truncate up" to imply that blocks should be speculatively
allocated all the way to the new EOF.

But no, I wouldn't expect swap-over-NFS to know or care if the file is
sparse on the server.  (Based on my limited knowledge of how that even
works...)

--D

> --b.
