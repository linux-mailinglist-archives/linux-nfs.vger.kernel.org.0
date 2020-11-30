Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2811F2C8F9D
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 22:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgK3VGM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 16:06:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47200 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgK3VGM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 16:06:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUKdJit189195;
        Mon, 30 Nov 2020 21:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=edD6znce0bSHJip6QFkXt0rlFjkHQip1dIRlmM2oHhw=;
 b=grE1O+nYt38nz9zdvrojSpCHFdqspT41ISfSjhXXvmhHH1kBBqaBJXnoDFZLyVAlUGD6
 K+2n54BbLNYU5ELN7igMFIfX4Vk6erCVJUzILiZebMgMYOsGjHv6bXi+YXyb22CFfyCL
 f+Z/B5/gFRMQaG1195HQ+vdhgB5zGXC4Ng3cI0NaseCRzZr+lGqTMawicfbMNHt42g6p
 MFqpXzLLrp/JcGmSoUg6+rArIJWy7Rvaz2q4HypMrw7S68cUKxH33yyPxVt2ew71v0Ji
 1sJFKL/dlZyk0v5PVBnCDbV2Q6gJe6fG6tJ9ymYUqzFKu8LqHL1l2J0azwH2MycVTfD2 qQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 353dyqfc7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 21:05:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUKeLGs139046;
        Mon, 30 Nov 2020 21:03:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 35404m201b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 21:03:26 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AUL3PgV020865;
        Mon, 30 Nov 2020 21:03:26 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 13:03:24 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/5] nfsd: only call inode_query_iversion in the I_VERSION
 case
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1606765137-17257-1-git-send-email-bfields@fieldses.org>
Date:   Mon, 30 Nov 2020 16:03:23 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <50CF0FBE-9C58-4DAA-B524-DE15047E9FD1@oracle.com>
References: <1606765137-17257-1-git-send-email-bfields@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300133
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 30, 2020, at 2:38 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> inode_query_iversion() can modify i_version.  Depending on the =
exported
> filesystem, that may not be safe.  For example, if you're re-exporting
> NFS, NFS stores the server's change attribute in i_version and does =
not
> expect it to be modified locally.  This has been observed causing
> unnecessary cache invalidations.
>=20
> The way a filesystem indicates that it's OK to call
> inode_query_iverson() is by setting SB_I_VERSION.
>=20
> So, move the I_VERSION check out of encode_change(), where it's used
> only in FATTR responses, to nfsd4_changeattr(), which is also called =
for
> pre- and post- operation attributes.
>=20
> (Note we could also pull the NFSEXP_V4ROOT case into
> nfsd4_change_attribute as well.  That would actually be a no-op, since
> pre/post attrs are only used for metadata-modifying operations, and
> V4ROOT exports are read-only.  But we might make the change in the
> future just for simplicity.)
>=20
> Reported-by: Daire Byrne <daire@dneg.com>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

New sparse warnings after this one is applied:

/home/cel/src/linux/linux/fs/nfsd/nfsfh.h:270:24: warning: incorrect =
type in assignment (different base types)
/home/cel/src/linux/linux/fs/nfsd/nfsfh.h:270:24:    expected unsigned =
long long [assigned] [usertype] chattr
/home/cel/src/linux/linux/fs/nfsd/nfsfh.h:270:24:    got restricted =
__be32 [usertype]
/home/cel/src/linux/linux/fs/nfsd/nfsfh.h:272:24: warning: invalid =
assignment: +=3D
/home/cel/src/linux/linux/fs/nfsd/nfsfh.h:272:24:    left side has type =
unsigned long long
/home/cel/src/linux/linux/fs/nfsd/nfsfh.h:272:24:    right side has type =
restricted __be32
/home/cel/src/linux/linux/fs/nfsd/nfsfh.h:270:24: warning: incorrect =
type in assignment (different base types)
/home/cel/src/linux/linux/fs/nfsd/nfsfh.h:270:24:    expected unsigned =
long long [assigned] [usertype] chattr
/home/cel/src/linux/linux/fs/nfsd/nfsfh.h:270:24:    got restricted =
__be32 [usertype]
/home/cel/src/linux/linux/fs/nfsd/nfsfh.h:272:24: warning: invalid =
assignment: +=3D
/home/cel/src/linux/linux/fs/nfsd/nfsfh.h:272:24:    left side has type =
unsigned long long
/home/cel/src/linux/linux/fs/nfsd/nfsfh.h:272:24:    right side has type =
restricted __be32


> ---
> fs/nfsd/nfs3xdr.c |  5 ++---
> fs/nfsd/nfs4xdr.c |  6 +-----
> fs/nfsd/nfsfh.h   | 14 ++++++++++----
> 3 files changed, 13 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 2277f83da250..dfbf390ff40c 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -291,14 +291,13 @@ void fill_post_wcc(struct svc_fh *fhp)
> 		printk("nfsd: inode locked twice during operation.\n");
>=20
> 	err =3D fh_getattr(fhp, &fhp->fh_post_attr);
> -	fhp->fh_post_change =3D =
nfsd4_change_attribute(&fhp->fh_post_attr,
> -						     =
d_inode(fhp->fh_dentry));
> 	if (err) {
> 		fhp->fh_post_saved =3D false;
> -		/* Grab the ctime anyway - set_change_info might use it =
*/
> 		fhp->fh_post_attr.ctime =3D =
d_inode(fhp->fh_dentry)->i_ctime;
> 	} else
> 		fhp->fh_post_saved =3D true;
> +	fhp->fh_post_change =3D =
nfsd4_change_attribute(&fhp->fh_post_attr,
> +						     =
d_inode(fhp->fh_dentry));
> }
>=20
> /*
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 833a2c64dfe8..56fd5f6d5c44 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2298,12 +2298,8 @@ static __be32 *encode_change(__be32 *p, struct =
kstat *stat, struct inode *inode,
> 	if (exp->ex_flags & NFSEXP_V4ROOT) {
> 		*p++ =3D =
cpu_to_be32(convert_to_wallclock(exp->cd->flush_time));
> 		*p++ =3D 0;
> -	} else if (IS_I_VERSION(inode)) {
> +	} else
> 		p =3D xdr_encode_hyper(p, nfsd4_change_attribute(stat, =
inode));
> -	} else {
> -		*p++ =3D cpu_to_be32(stat->ctime.tv_sec);
> -		*p++ =3D cpu_to_be32(stat->ctime.tv_nsec);
> -	}
> 	return p;
> }
>=20
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 56cfbc361561..3faf5974fa4e 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -261,10 +261,16 @@ static inline u64 nfsd4_change_attribute(struct =
kstat *stat,
> {
> 	u64 chattr;
>=20
> -	chattr =3D  stat->ctime.tv_sec;
> -	chattr <<=3D 30;
> -	chattr +=3D stat->ctime.tv_nsec;
> -	chattr +=3D inode_query_iversion(inode);
> +	if (IS_I_VERSION(inode)) {
> +		chattr =3D  stat->ctime.tv_sec;
> +		chattr <<=3D 30;
> +		chattr +=3D stat->ctime.tv_nsec;
> +		chattr +=3D inode_query_iversion(inode);
> +	} else {
> +		chattr =3D cpu_to_be32(stat->ctime.tv_sec);
> +		chattr <<=3D 32;
> +		chattr +=3D cpu_to_be32(stat->ctime.tv_nsec);
> +	}
> 	return chattr;
> }
>=20
> --=20
> 2.28.0
>=20

--
Chuck Lever



