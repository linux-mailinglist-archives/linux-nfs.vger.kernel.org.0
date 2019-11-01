Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCDB4EC3D1
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2019 14:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfKANiy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Nov 2019 09:38:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55108 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKANiy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Nov 2019 09:38:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA1DZdgU083064;
        Fri, 1 Nov 2019 13:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=pAWPZX5GeZndrulBLbi6FyYmwNdbtqqaIrrv2rvnQtw=;
 b=eqlpi5vEBsM/i0bfKTlJ01lv/ONzTi7P9Cs2n54nycHzTJ0vlL5pMp+Sawhpalop6aDY
 V0ndHjmLQdMxNLz6Cb3f3+l1VhJD5XmGBcbX+tlHhe5FHP8gsgmEbf/lThk9AGJp56mV
 6jTXf34+iLWi0lmb4P4a9fjxCVBD1wSo05VDgJnPDLHbQ94G0LoSzmez/fjPX5cGxJQi
 yFg14kN+pkew2ZCcX0sz41LjmeYOGavRN2tAAtr4if7RZr6uMdio6/dSBaPe/Ms9nuDO
 IcflcgxtudcMM7rm08IQDsz6OwAKiGnvDCDZ6uibl7p7fhneguLPeW+VvkJQR2fizVu3 Bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vxwhg1uup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 13:38:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA1DZQH6005568;
        Fri, 1 Nov 2019 13:36:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vyqpg843y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 13:36:29 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA1DaSLo023879;
        Fri, 1 Nov 2019 13:36:28 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Nov 2019 06:36:28 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next] nfsd: Drop LIST_HEAD where the variable it declares
 is never used.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20191101114054.50225-1-maowenan@huawei.com>
Date:   Fri, 1 Nov 2019 09:36:27 -0400
Cc:     Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Dros Adamson <dros@primarydata.com>,
        jeff.layton@primarydata.com, richard.sharpe@primarydata.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E1B5E17-FF35-472B-8316-D4C01085BAE4@oracle.com>
References: <20191101114054.50225-1-maowenan@huawei.com>
To:     Mao Wenan <maowenan@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911010136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911010136
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Mao-

> On Nov 1, 2019, at 7:40 AM, Mao Wenan <maowenan@huawei.com> wrote:
>=20
> The declarations were introduced with the file, but the declared
> variables were not used.
>=20
> Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to =
nfsd")

I'm not sure a Fixes: tag is necessary here? 65294c1f2c5e
works fine without this change, and it's not something we
would need to backport into stable kernels.

This is more of a clean up patch.


> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
> fs/nfsd/filecache.c | 2 --
> 1 file changed, 2 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ef55e9b..32a9bf2 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -685,8 +685,6 @@ nfsd_file_cache_purge(struct net *net)
> void
> nfsd_file_cache_shutdown(void)
> {
> -	LIST_HEAD(dispose);
> -
> 	set_bit(NFSD_FILE_SHUTDOWN, &nfsd_file_lru_flags);
>=20
> 	lease_unregister_notifier(&nfsd_file_lease_notifier);
> --=20
> 2.7.4
>=20

--
Chuck Lever



