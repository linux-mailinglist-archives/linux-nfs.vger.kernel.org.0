Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6A82C7282
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Nov 2020 23:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389847AbgK1VuJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Nov 2020 16:50:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35944 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730572AbgK1SmR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 28 Nov 2020 13:42:17 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ASIeNnm056892;
        Sat, 28 Nov 2020 18:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=PqZnLoBYIXrmlOxFoC5hoP7Cwqsbnc9iJzNAuuV8ylI=;
 b=EmosImKEnAVUOaKvSB50+AmiZlaKJFUltKroUOe6tWZ8dT0IfbGFvn9hG+9iYM79x2AQ
 OwV2FwQLs61+SwfmNjsHC9nyqDHajU74d8UA8r+BweTA3ccIYt0U6UUy8l8FXwD+Pykp
 w87oem0Ww/TuCjINZ/S3gmoMWqFafQgYqCPUd0t/eNgKgTWqYz3r7Ewd3sieJLABXdaA
 2esisvspmIseCxZ9+3E3BgJW6IoYpipKH6bvquR4refHEZINsemYKnxAbdnLQ6+rdigt
 cHylzxPmvBEj7krt7unjXlvRcVrgZO5zoO6sNNWx0wU9tqnpjyol74XLDaF/xjGGe788 sA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 353egk94yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 28 Nov 2020 18:41:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ASIe4Tr062624;
        Sat, 28 Nov 2020 18:41:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 353ec0e3v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Nov 2020 18:41:29 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ASIfPc2019459;
        Sat, 28 Nov 2020 18:41:28 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 28 Nov 2020 10:41:24 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] nfsd: Fix kernel test robot warning
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1606571451-3655-1-git-send-email-jrdr.linux@gmail.com>
Date:   Sat, 28 Nov 2020 13:41:23 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F1972C21-8C1A-4B93-868F-2B849D224D0C@oracle.com>
References: <1606571451-3655-1-git-send-email-jrdr.linux@gmail.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011280117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011280117
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Souptick-

This looks like the same error that Coverity caught earlier this
week. AFAIK Bruce intends to address this issue with a replacement
patch:

https://lore.kernel.org/linux-nfs/20201125164738.GA7049@fieldses.org/


> On Nov 28, 2020, at 8:50 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> 
> Kernel test robot throws below warning -
> 
>>> fs/nfsd/nfs3xdr.c:299:6: warning: variable 'err' is used
>>> uninitialized whenever 'if' condition is false
>>> [-Wsometimes-uninitialized]
>           if (!v4 || !inode->i_sb->s_export_op->fetch_iversion)
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   fs/nfsd/nfs3xdr.c:304:6: note: uninitialized use occurs here
>           if (err) {
>               ^~~
>   fs/nfsd/nfs3xdr.c:299:2: note: remove the 'if' if its condition is
> always true
>           if (!v4 || !inode->i_sb->s_export_op->fetch_iversion)
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   fs/nfsd/nfs3xdr.c:293:12: note: initialize the variable 'err' to
> silence this warning
>           __be32 err;
>                     ^
>                      = 0
>   1 warning generated.
> 
> Initialize err = 0 to silence this warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
> fs/nfsd/nfs3xdr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index abb1608..47aeaee 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -290,7 +290,7 @@ void fill_post_wcc(struct svc_fh *fhp)
> {
> 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
> 	struct inode *inode = d_inode(fhp->fh_dentry);
> -	__be32 err;
> +	__be32 err = 0;
> 
> 	if (fhp->fh_post_saved)
> 		printk("nfsd: inode locked twice during operation.\n");
> -- 
> 1.9.1
> 

--
Chuck Lever



