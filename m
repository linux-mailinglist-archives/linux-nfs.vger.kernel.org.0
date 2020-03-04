Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C821C17975E
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2020 19:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgCDSAa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Mar 2020 13:00:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60986 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgCDSAa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Mar 2020 13:00:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024Hr5TM018579;
        Wed, 4 Mar 2020 18:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=iZz6zk9KnYCEHgjVk87jpPEKD3IAEJtFxeet1JkEjqM=;
 b=EU3lapkSg5PrDjmOd9+l5kZiHuIO3PsZZhg6+ZP+oAEGJ5wC6L2eINW5UIG2YJpiljZq
 rG31/MToaPNEsI4Pko2fCa/HjnM6EDWb33ISum0ruM1fB6hsZfcbJ+f0HIyOYoEXOf1Y
 pLiTSf5npQrGdmNIC52fUpknsR5cB45tDEh2MUHjt6FRFYZCnS6RcbqRhNQqwFJyqbpq
 3moiFc0M/qVeUA/DEhrPxS0nsbe7PPQeDW7KOoBBaPqfy2WtXwULhiGChTqLJ6gD8dgC
 Y+GfGKpj2A5u4MU7AdYv8jd5erL7nV6ZNgX7NiA8wPbDMZUQ/ToHVoKgvdh9dXJvt5+T SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yghn3brpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 18:00:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024HkdK7183266;
        Wed, 4 Mar 2020 18:00:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2yg1eqect9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 18:00:16 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 024I0ETc016347;
        Wed, 4 Mar 2020 18:00:14 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Mar 2020 10:00:13 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] nfsd: Fix build error
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200304131803.46560-1-yuehaibing@huawei.com>
Date:   Wed, 4 Mar 2020 13:00:12 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <BC0E3531-B282-4C04-9540-C39C6F4A1A5D@oracle.com>
References: <20200304131803.46560-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040123
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

> On Mar 4, 2020, at 8:18 AM, YueHaibing <yuehaibing@huawei.com> wrote:
> 
> fs/nfsd/nfs4proc.o: In function `nfsd4_do_copy':
> nfs4proc.c:(.text+0x23b7): undefined reference to `nfs42_ssc_close'
> fs/nfsd/nfs4proc.o: In function `nfsd4_copy':
> nfs4proc.c:(.text+0x5d2a): undefined reference to `nfs_sb_deactive'
> fs/nfsd/nfs4proc.o: In function `nfsd4_do_async_copy':
> nfs4proc.c:(.text+0x61d5): undefined reference to `nfs42_ssc_open'
> nfs4proc.c:(.text+0x6389): undefined reference to `nfs_sb_deactive'
> 
> Add dependency to NFSD_V4_2_INTER_SSC to fix this.
> 
> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> fs/nfsd/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index f368f32..fc587a5 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -136,6 +136,7 @@ config NFSD_FLEXFILELAYOUT
> 
> config NFSD_V4_2_INTER_SSC
> 	bool "NFSv4.2 inter server to server COPY"
> +	depends on !(NFSD=y && NFS_FS=m)

The new dependency is not especially clear to me; more explanation
in the patch description about the cause of the build failure
would definitely be helpful.

NFSD_V4 can't be set unless NFSD is also set.

NFS_V4_2 can't be set unless NFS_V4_1 is also set, and that cannot
be set unless NFS_FS is also set.

So what's really going on here?


> 	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2
> 	help
> 	  This option enables support for NFSv4.2 inter server to
> -- 
> 2.7.4
> 
> 

--
Chuck Lever



