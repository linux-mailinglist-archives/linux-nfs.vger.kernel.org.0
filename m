Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6232F18360F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 17:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgCLQYE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 12:24:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47850 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgCLQYE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Mar 2020 12:24:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGMYdG008908;
        Thu, 12 Mar 2020 16:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=E+zOK3hL/3T9xK4LW9XyNRVIneE2b2lknBZ7coj2u1I=;
 b=pbJQlZu0dEhQnZa9uOGHkw0lG7IAZOenuYM7nlJbYdsznlFyDCbzaWxX0xOH7Rzn7T+g
 jm5GxMPesE5oyZRD1fj+Z7nKEaDWedsyuKdgabSGrdBGt3zUJeBkHAF6Q6TwyZojLoHW
 OSlDQ8dEoWdAkstYjE5iOEVfZJtEanRIFXeBuaTLn52Wq8aaUEwJvxeoyGVRnxQAJV9n
 1j/WgmRuXO9r307Z7FRtdzCH0huAYLoInWaGUUL3d/ptbf1u6+QEDJIBYAlFtLwwwZzH
 MJde58PonLR9MuSPYRDHCU2rzn68urIJuqT264NlKopo2lv6MH08fvmcWHeAKfYy6hl4 Iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yp9v6dr68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 16:24:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGM8BO085313;
        Thu, 12 Mar 2020 16:23:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2yqgvd9219-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 16:23:59 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CGNwvA014417;
        Thu, 12 Mar 2020 16:23:58 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 09:23:58 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 06/14] nfsd: define xattr functions to call in to their
 vfs counterparts
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200311195954.27117-7-fllinden@amazon.com>
Date:   Thu, 12 Mar 2020 12:23:57 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <77A441AA-E880-4C74-B662-B315D6734ED2@oracle.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-7-fllinden@amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120084
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 11, 2020, at 3:59 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> This adds the filehandle based functions for the xattr operations
> that call in to the vfs layer to do the actual work.

Before posting again, use "make C=3D1" to clear up new sparse
errors, and scripts/checkpatch.pl to find and correct whitespace
damage introduced in this series.


> Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> ---
> fs/nfsd/vfs.c | 130 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> fs/nfsd/vfs.h |  10 +++++
> 2 files changed, 140 insertions(+)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 0aa02eb18bd3..115449009bc0 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2058,6 +2058,136 @@ static int exp_rdonly(struct svc_rqst *rqstp, =
struct svc_export *exp)
> 	return nfsexp_flags(rqstp, exp) & NFSEXP_READONLY;
> }
>=20
> +#ifdef CONFIG_NFSD_V4
> +/*
> + * Helper function to translate error numbers. In the case of xattr =
operations,
> + * some error codes need to be translated outside of the standard =
translations.
> + *
> + * ENODATA needs to be translated to nfserr_noxattr.
> + * E2BIG to nfserr_xattr2big.
> + *
> + * Additionally, vfs_listxattr can return -ERANGE. This means that =
the
> + * file has too many extended attributes to retrieve inside an
> + * XATTR_LIST_MAX sized buffer. This is a bug in the xattr =
implementation:
> + * filesystems will allow the adding of extended attributes until =
they hit
> + * their own internal limit. This limit may be larger than =
XATTR_LIST_MAX.
> + * So, at that point, the attributes are present and valid, but can't
> + * be retrieved using listxattr, since the upper level xattr code =
enforces
> + * the XATTR_LIST_MAX limit.
> + *
> + * This bug means that we need to deal with listxattr returning =
-ERANGE. The
> + * best mapping is to return TOOSMALL.
> + */
> +static __be32
> +nfsd_xattr_errno(int err)
> +{
> +	switch (err) {
> +	case -ENODATA:
> +		return nfserr_noxattr;
> +	case -E2BIG:
> +		return nfserr_xattr2big;
> +	case -ERANGE:
> +		return nfserr_toosmall;
> +	}
> +	return nfserrno(err);
> +}
> +
> +__be32
> +nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
> +	      void *buf, int *lenp)
> +{
> +	ssize_t lerr;
> +	int err;
> +
> +	err =3D fh_verify(rqstp, fhp, 0, NFSD_MAY_READ);
> +	if (err)
> +		return err;
> +
> +	lerr =3D vfs_getxattr(fhp->fh_dentry, name, buf, *lenp);
> +	if (lerr < 0)
> +		err =3D nfsd_xattr_errno(lerr);
> +	else
> +		*lenp =3D lerr;
> +
> +	return err;
> +}
> +
> +__be32
> +nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, void *buf, =
int *lenp)
> +{
> +	ssize_t lerr;
> +	int err;
> +
> +	err =3D fh_verify(rqstp, fhp, 0, NFSD_MAY_READ);
> +	if (err)
> +		return err;
> +
> +	lerr =3D vfs_listxattr(fhp->fh_dentry, buf, *lenp);
> +
> +	if (lerr < 0)
> +		err =3D nfsd_xattr_errno(lerr);
> +	else
> +		*lenp =3D lerr;
> +
> +	return err;
> +}
> +
> +/*
> + * Removexattr and setxattr need to call fh_lock to both lock the =
inode
> + * and set the change attribute. Since the top-level vfs_removexattr
> + * and vfs_setxattr calls already do their own inode_lock calls, call
> + * the _locked variant. Pass in a NULL pointer for delegated_inode,
> + * and let the client deal with NFS4ERR_DELAY (same as with e.g.
> + * setattr and remove).
> + */
> +__be32
> +nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char =
*name)
> +{
> +	int err, ret;
> +
> +	err =3D fh_verify(rqstp, fhp, 0, NFSD_MAY_WRITE);
> +	if (err)
> +		return err;
> +
> +	ret =3D fh_want_write(fhp);
> +	if (ret)
> +		return nfserrno(ret);
> +
> +	fh_lock(fhp);
> +
> +	ret =3D __vfs_removexattr_locked(fhp->fh_dentry, name, NULL);
> +
> +	fh_unlock(fhp);
> +	fh_drop_write(fhp);
> +
> +	return nfsd_xattr_errno(ret);
> +}
> +
> +__be32
> +nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
> +	      void *buf, u32 len, u32 flags)
> +{
> +	int err, ret;
> +
> +	err =3D fh_verify(rqstp, fhp, 0, NFSD_MAY_WRITE);
> +	if (err)
> +		return err;
> +
> +	ret =3D fh_want_write(fhp);
> +	if (ret)
> +		return nfserrno(ret);
> +	fh_lock(fhp);
> +
> +	ret =3D __vfs_setxattr_locked(fhp->fh_dentry, name, buf, len, =
flags,
> +				    NULL);
> +
> +	fh_unlock(fhp);
> +	fh_drop_write(fhp);
> +
> +	return nfsd_xattr_errno(ret);
> +}
> +#endif
> +
> /*
>  * Check for a user's access permissions to this inode.
>  */
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 3eb660ad80d1..2d2cf5b0543b 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -76,6 +76,16 @@ __be32		do_nfsd_create(struct svc_rqst =
*, struct svc_fh *,
> __be32		nfsd_commit(struct svc_rqst *, struct svc_fh *,
> 				loff_t, unsigned long, __be32 *verf);
> #endif /* CONFIG_NFSD_V3 */
> +#ifdef CONFIG_NFSD_V4
> +__be32		nfsd_getxattr(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> +			    char *name, void *buf, int *lenp);
> +__be32		nfsd_listxattr(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> +			    void *buf, int *lenp);
> +__be32		nfsd_removexattr(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> +			    char *name);
> +__be32		nfsd_setxattr(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> +			    char *name, void *buf, u32 len, u32 flags);
> +#endif
> int 		nfsd_open_break_lease(struct inode *, int);
> __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, =
umode_t,
> 				int, struct file **);
> --=20
> 2.16.6
>=20

--
Chuck Lever



