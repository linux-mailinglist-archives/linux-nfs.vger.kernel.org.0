Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63474175476
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2020 08:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCBHbG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Mar 2020 02:31:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49078 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCBHbF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Mar 2020 02:31:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0227Rhvh106798;
        Mon, 2 Mar 2020 07:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Ri8h7A40DW+uVbQeQtC6y9Sx1MYlmgBF2ya0vuR0GRE=;
 b=Tupk1l8V/EgapKFZinI18DFI9MRmBo31jh3y2yVF0mfSb8ANaS8pMP2lHndS3drl0HPR
 ZZbEpeC9vavzkhEqU0Q+ozE72C4gF1T+P/fHsEsmZwepIgBojvueY+OzJjui9nywyVyl
 vsVr4LHP2nbImKcuKaU2n4e/CMsyyluXzrQHKHz5vFVRP0FRt10Yk8lBgOJXU6R75Har
 DHEiLZhszxcJvXOwYaBc9mRI3gKAuOpLwOju7BzkAbZgYy+CZnR8PMb/3Hoegt0cwVP3
 uW75/NHCNuslaUPY22xGCIPpiFIqzsEA+AWV0rCuB1CMgypR2EtiGHwtImaSxGnOy+hK 4Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2yffcu5vfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Mar 2020 07:30:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0227QZFw178044;
        Mon, 2 Mar 2020 07:30:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2yg1re6ghn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Mar 2020 07:30:56 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0227UrOl018351;
        Mon, 2 Mar 2020 07:30:53 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Mar 2020 23:30:51 -0800
Date:   Mon, 2 Mar 2020 10:30:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFS: check for allocation failure from mempool_alloc
Message-ID: <20200302073043.GA4140@kadam>
References: <20200226234320.7722-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226234320.7722-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003020057
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 26, 2020 at 11:43:20PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> It is possible for mempool_alloc to return null when using
> the GFP_KERNEL flag, so return NULL and avoid a null pointer
> dereference on the following memset of the null pointer.
> 
> Addresses-Coverity: ("Dereference null return")
> Fixes: 2b17d725f9be ("NFS: Clean up writeback code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/nfs/write.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index c478b772cc49..7ca036660dd1 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -106,6 +106,9 @@ static struct nfs_pgio_header *nfs_writehdr_alloc(void)
>  {
>  	struct nfs_pgio_header *p = mempool_alloc(nfs_wdata_mempool, GFP_KERNEL);
>  
> +	if (!p)

The fixes tag was wrong.  When I searched for the correct fixes tag,
it turned out this was intentional.  See commit 237f8306c302
("NFS: don't expect errors from mempool_alloc().") and commit 518662e0fcb9
("NFS: fix usage of mempools.").

    When passed GFP flags that allow sleeping (such as
    GFP_NOIO), mempool_alloc() will never return NULL, it will
    wait until memory is available.

regards,
dan carpenter

