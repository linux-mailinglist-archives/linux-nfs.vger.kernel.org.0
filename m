Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB132CA7E3
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 17:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391776AbgLAQMw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 11:12:52 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41298 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388364AbgLAQMw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 11:12:52 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1G50gi005417;
        Tue, 1 Dec 2020 16:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=22uUZjJW7zh1mrWc50KQ4IPbV83RJ+G4hKxC1LZR8Gk=;
 b=DOmQJ5yg8/gSX5agk2i/9EQdTvydZYYXriQ0r+7rsOmE/SLlCsCslSznAIiF2xx+ztB1
 brGj9uR71VMswmgMuWmGTHzJjP12TrC87dxaWNjh6GGjHig+LBOfDGcjRqn5Gv6eeMIB
 UhjJQ1NHr6tttabbSwoIZno+Hd3wX9/Zw5n1/erk+aAVq7akNeqp8Ms6i2pWU+IZsFJJ
 dmrH8cpT/wk4eff3BQkXzkhM2D7vsWRTKA1ck10CHGbSLD61A7Qf44F6XEs9l42JF2il
 qdSgq4ioEeQ2aHm3xhpLJVBmgvmdCP7teD5XLXtxCME/kAFIqsYo2KaKOgjRIzwnux4W 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 353egkkc8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 16:12:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1G66Sn042717;
        Tue, 1 Dec 2020 16:10:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3540ey5u6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 16:10:07 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B1GA6lg024990;
        Tue, 1 Dec 2020 16:10:06 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Dec 2020 08:10:06 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 2/2] nfsd: Record NFSv4 pre/post-op attributes as
 non-atomic
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201201041427.756749-2-trondmy@kernel.org>
Date:   Tue, 1 Dec 2020 11:10:05 -0500
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <29B6726E-3AED-45D9-9411-F8AD33FF6090@oracle.com>
References: <20201201041427.756749-1-trondmy@kernel.org>
 <20201201041427.756749-2-trondmy@kernel.org>
To:     trondmy@kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=1 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010101
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond-

> On Nov 30, 2020, at 11:14 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> For the case of NFSv4, specify to the client that the the pre/post-op
> attributes were not recorded atomically with the main operation.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

I've applied this one provisionally to my tree for the next
merge window.


> ---
> fs/nfs/export.c          | 3 ++-
> fs/nfsd/nfsfh.c          | 4 ++++
> fs/nfsd/nfsfh.h          | 5 +++++
> fs/nfsd/xdr4.h           | 2 +-
> include/linux/exportfs.h | 3 +++
> 5 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index 48b879cfe6e3..7412bb164fa7 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -172,5 +172,6 @@ const struct export_operations nfs_export_ops =3D =
{
> 	.fh_to_dentry =3D nfs_fh_to_dentry,
> 	.get_parent =3D nfs_get_parent,
> 	.flags =3D EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
> -		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS,
> +		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
> +		EXPORT_OP_NOATOMIC_ATTR,
> };
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index e80a7525561d..66f2ef67792a 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -301,6 +301,10 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst =
*rqstp, struct svc_fh *fhp)
> 	fhp->fh_export =3D exp;
>=20
> 	switch (rqstp->rq_vers) {
> +	case 4:
> +		if (dentry->d_sb->s_export_op->flags & =
EXPORT_OP_NOATOMIC_ATTR)
> +			fhp->fh_no_atomic_attr =3D true;
> +		break;
> 	case 3:
> 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC)
> 			fhp->fh_no_wcc =3D true;
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 347d10aa6265..cb20c2cd3469 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -36,6 +36,11 @@ typedef struct svc_fh {
> 	bool			fh_locked;	/* inode locked by us */
> 	bool			fh_want_write;	/* remount protection =
taken */
> 	bool			fh_no_wcc;	/* no wcc data needed */
> +	bool			fh_no_atomic_attr;
> +						/*
> +						 * wcc data is not =
atomic with
> +						 * operation
> +						 */
> 	int			fh_flags;	/* FH flags */
> #ifdef CONFIG_NFSD_V3
> 	bool			fh_post_saved;	/* post-op attrs saved =
*/
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index b4556e86e97c..a60ff5ce1a37 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -748,7 +748,7 @@ static inline void
> set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
> {
> 	BUG_ON(!fhp->fh_pre_saved);
> -	cinfo->atomic =3D (u32)fhp->fh_post_saved;
> +	cinfo->atomic =3D (u32)(fhp->fh_post_saved && =
!fhp->fh_no_atomic_attr);
>=20
> 	cinfo->before_change =3D fhp->fh_pre_change;
> 	cinfo->after_change =3D fhp->fh_post_change;
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index d93e8a6737bb..9f4d4bcbf251 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -217,6 +217,9 @@ struct export_operations {
> #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree =
checking */
> #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files =
before unlink */
> #define EXPORT_OP_REMOTE_FS		(0x8) /* Filesystem is remote */
> +#define EXPORT_OP_NOATOMIC_ATTR		(0x10) /* Filesystem =
cannot supply
> +						  atomic attribute =
updates
> +						*/
> 	unsigned long	flags;
> };
>=20
> --=20
> 2.28.0
>=20

--
Chuck Lever



