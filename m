Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C161BC775
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2020 20:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgD1SFI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Apr 2020 14:05:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53006 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgD1SFI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Apr 2020 14:05:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SI3JGe179561;
        Tue, 28 Apr 2020 18:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vi5JgPZeW6IgAfDz5vpQSaEFGipy5i87NXmAvFjyxYM=;
 b=l6p7BpTh3GdWoTwa8iOKOTdorj4x+S6s34Adi1GKLT/RR1TIEMmoaMa91ttNtlIDbjTW
 FZd08OThR2Aak+I80m3pqQeIWSqMB5WEbMLmof4K/ZkLFFDZx6sF5kUCWk+D+YMH5SXf
 dABwrPspnsAzFi6Rq3M4dqSMVyyOV4jl+XkihMe9YlQmV2FiJcmwfh1Z/H69HYKdtB74
 bKsppaWCiceLmPDPcEoGEWJAFqjmf5w6PY53McedqvvgCYOIqw9leJWRT8eQiG9fc0jA
 vbixjdtyLhARx+uOVeoWiwW2hcwtsaLScNFc1NCKmb5U36p1yxRNE7thJztwG1DgBGu6 Ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30p2p06y4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 18:04:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SHw2g2154966;
        Tue, 28 Apr 2020 18:04:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30mxrt41vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 18:04:56 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03SI4sbo028292;
        Tue, 28 Apr 2020 18:04:54 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 11:04:54 -0700
Date:   Tue, 28 Apr 2020 21:04:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] NFSv4: Use GFP_ATOMIC under spin lock in
 _pnfs_grab_empty_layout()
Message-ID: <20200428180448.GJ2014@kadam>
References: <20200428071932.69976-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428071932.69976-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1011
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280143
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 28, 2020 at 07:19:32AM +0000, Wei Yongjun wrote:
> A spin lock is taken here so we should use GFP_ATOMIC.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  fs/nfs/pnfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> index dd2e14f5875d..d84c1b7b71d2 100644
> --- a/fs/nfs/pnfs.c
> +++ b/fs/nfs/pnfs.c
> @@ -2170,7 +2170,7 @@ _pnfs_grab_empty_layout(struct inode *ino, struct nfs_open_context *ctx)
>  	struct pnfs_layout_hdr *lo;
>  
>  	spin_lock(&ino->i_lock);
                   ^^^
> -	lo = pnfs_find_alloc_layout(ino, ctx, GFP_KERNEL);
> +	lo = pnfs_find_alloc_layout(ino, ctx, GFP_ATOMIC);
                                    ^^^
It releases the lock before allocating.  It's annotated.

regards,
dan carpenter

