Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEB9584943
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 03:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiG2BL5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 21:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2BLr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 21:11:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9480017064
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 18:11:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3DBD0203DE;
        Fri, 29 Jul 2022 01:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659057104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgbSaGbYcUqHE3Th4CqVzlHYGB9ppPM6OW/B3+eoZ8U=;
        b=Xs75W6R5HOKuLRTdyUIOB88BjPs9dcdvDz0Qc+P3cKsKfnN2OSYHWX2SvAJBeYYaUBTmC9
        d+vtBYVpWRo4y5Xlln8bW8CddqbwJfL3qR4dPVw7Qm2O4U0fedQxXhDW9N3e9o3ud5EXR6
        vaWAMEkm4Ic5/yoTgKf5ev/OgTshUNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659057104;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgbSaGbYcUqHE3Th4CqVzlHYGB9ppPM6OW/B3+eoZ8U=;
        b=Rrsful2gG8MLmepnk6ncOnHq0y0nrqFUfL9a36S6k6/aqcDnSX/y6c54WeIHocz5t4+VHQ
        P+5NkiTBqIqEk2AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9E1A13A7E;
        Fri, 29 Jul 2022 01:11:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id glCKIM4z42L6OQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 29 Jul 2022 01:11:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 05/13] NFSD: add security label to struct nfsd_attrs
In-reply-to: <58E8A202-C73C-49F6-9C3C-C145F6C6731B@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>,
 <165881793056.21666.14726745370568724977.stgit@noble.brown>,
 <58E8A202-C73C-49F6-9C3C-C145F6C6731B@oracle.com>
Date:   Fri, 29 Jul 2022 11:11:39 +1000
Message-id: <165905709969.4359.16628429620401292010@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 29 Jul 2022, Chuck Lever III wrote:
>=20
> > On Jul 26, 2022, at 2:45 AM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > nfsd_setattr() now sets a security label if provided, and nfsv4 provides
> > it in the 'open' and 'create' paths and the 'setattr' path.
> > If setting the label failed (including because the kernel doesn't
> > support labels), an error field in 'struct nfsd_attrs' is set, and the
> > caller can respond.  The open/create callers clear
> > FATTR4_WORD2_SECURITY_LABEL in the returned attr set in this case.
> > The setattr caller returns the error.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > fs/nfsd/nfs4proc.c |   61 +++++++++++++++--------------------------------=
-----
> > fs/nfsd/vfs.c      |   29 +++----------------------
> > fs/nfsd/vfs.h      |    4 ++-
> > 3 files changed, 23 insertions(+), 71 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index ee72c94732f0..83d2b645b0d6 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -64,36 +64,6 @@ MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
> > 		"idle msecs before unmount export from source server");
> > #endif
> >=20
> > -#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> > -#include <linux/security.h>
> > -
> > -static inline void
> > -nfsd4_security_inode_setsecctx(struct svc_fh *resfh, struct xdr_netobj *=
label, u32 *bmval)
> > -{
> > -	struct inode *inode =3D d_inode(resfh->fh_dentry);
> > -	int status;
> > -
> > -	inode_lock(inode);
> > -	status =3D security_inode_setsecctx(resfh->fh_dentry,
> > -		label->data, label->len);
> > -	inode_unlock(inode);
> > -
> > -	if (status)
> > -		/*
> > -		 * XXX: We should really fail the whole open, but we may
> > -		 * already have created a new file, so it may be too
> > -		 * late.  For now this seems the least of evils:
> > -		 */
> > -		bmval[2] &=3D ~FATTR4_WORD2_SECURITY_LABEL;
> > -
> > -	return;
> > -}
> > -#else
> > -static inline void
> > -nfsd4_security_inode_setsecctx(struct svc_fh *resfh, struct xdr_netobj *=
label, u32 *bmval)
> > -{ }
> > -#endif
> > -
> > #define NFSDDBG_FACILITY		NFSDDBG_PROC
> >=20
> > static u32 nfsd_attrmask[] =3D {
> > @@ -286,7 +256,10 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
> > 		  struct svc_fh *resfhp, struct nfsd4_open *open)
> > {
> > 	struct iattr *iap =3D &open->op_iattr;
> > -	struct nfsd_attrs attrs =3D { .iattr =3D iap };
> > +	struct nfsd_attrs attrs =3D {
> > +		.iattr =3D iap,
> > +		.label =3D &open->op_label,
> > +	};
> > 	struct dentry *parent, *child;
> > 	__u32 v_mtime, v_atime;
> > 	struct inode *inode;
> > @@ -407,6 +380,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> > set_attr:
> > 	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
> >=20
> > +	if (attrs.label_failed)
> > +		open->op_bmval[2] &=3D ~FATTR4_WORD2_SECURITY_LABEL;
> > out:
> > 	fh_unlock(fhp);
> > 	if (child && !IS_ERR(child))
> > @@ -448,9 +423,6 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate, stru
> > 		status =3D nfsd4_create_file(rqstp, current_fh, *resfh, open);
> > 		current->fs->umask =3D 0;
> >=20
> > -		if (!status && open->op_label.len)
> > -			nfsd4_security_inode_setsecctx(*resfh, &open->op_label, open->op_bmva=
l);
> > -
> > 		/*
> > 		 * Following rfc 3530 14.2.16, and rfc 5661 18.16.4
> > 		 * use the returned bitmask to indicate which attributes
> > @@ -788,7 +760,10 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> > 	     union nfsd4_op_u *u)
> > {
> > 	struct nfsd4_create *create =3D &u->create;
> > -	struct nfsd_attrs attrs =3D { .iattr =3D &create->cr_iattr };
> > +	struct nfsd_attrs attrs =3D {
> > +		.iattr =3D &create->cr_iattr,
> > +		.label =3D &create->cr_label,
> > +	};
> > 	struct svc_fh resfh;
> > 	__be32 status;
> > 	dev_t rdev;
> > @@ -860,8 +835,8 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> > 	if (status)
> > 		goto out;
> >=20
> > -	if (create->cr_label.len)
> > -		nfsd4_security_inode_setsecctx(&resfh, &create->cr_label, create->cr_b=
mval);
> > +	if (attrs.label_failed)
> > +		create->cr_bmval[2] &=3D ~FATTR4_WORD2_SECURITY_LABEL;
> >=20
> > 	if (create->cr_acl !=3D NULL)
> > 		do_set_nfs4_acl(rqstp, &resfh, create->cr_acl,
> > @@ -1144,7 +1119,10 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> > 	      union nfsd4_op_u *u)
> > {
> > 	struct nfsd4_setattr *setattr =3D &u->setattr;
> > -	struct nfsd_attrs attrs =3D { .iattr =3D &setattr->sa_iattr };
> > +	struct nfsd_attrs attrs =3D {
> > +		.iattr =3D &setattr->sa_iattr,
> > +		.label =3D &setattr->sa_label,
> > +	};
> > 	__be32 status =3D nfs_ok;
> > 	int err;
> >=20
> > @@ -1172,13 +1150,10 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> > 					    setattr->sa_acl);
> > 	if (status)
> > 		goto out;
> > -	if (setattr->sa_label.len)
> > -		status =3D nfsd4_set_nfs4_label(rqstp, &cstate->current_fh,
> > -				&setattr->sa_label);
> > -	if (status)
> > -		goto out;
> > 	status =3D nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
> > 				0, (time64_t)0);
> > +	if (!status)
> > +		status =3D attrs.label_failed;
>=20
> /home/cel/src/linux/klimt/fs/nfsd/nfs4proc.c:1156:24: warning: incorrect ty=
pe in assignment (different base types)
> /home/cel/src/linux/klimt/fs/nfsd/nfs4proc.c:1156:24:    expected restricte=
d __be32 [assigned] [usertype] status
> /home/cel/src/linux/klimt/fs/nfsd/nfs4proc.c:1156:24:    got int [addressab=
le] label_failed
>=20
> Let's make these a __be32 nfserr status code instead.

The value assigned to the *_failed fields are errnos, so __be32 would
not be correct.
This assignment needs to change to
        if (!status)
               status =3D nfserrno(attrs.label_failed);

Thanks,
NeilBrown


>=20
>=20
> > out:
> > 	fh_drop_write(&cstate->current_fh);
> > 	return status;
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 91c9ea09f921..e7a18bedf499 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -458,6 +458,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
> > 	host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
> >=20
> > out_unlock:
> > +	if (attr->label && attr->label->len)
> > +		attr->label_failed =3D security_inode_setsecctx(
> > +			dentry, attr->label->data, attr->label->len);
> > 	fh_unlock(fhp);
> > 	if (size_change)
> > 		put_write_access(inode);
> > @@ -496,32 +499,6 @@ int nfsd4_is_junction(struct dentry *dentry)
> > 		return 0;
> > 	return 1;
> > }
> > -#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> > -__be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > -		struct xdr_netobj *label)
> > -{
> > -	__be32 error;
> > -	int host_error;
> > -	struct dentry *dentry;
> > -
> > -	error =3D fh_verify(rqstp, fhp, 0 /* S_IFREG */, NFSD_MAY_SATTR);
> > -	if (error)
> > -		return error;
> > -
> > -	dentry =3D fhp->fh_dentry;
> > -
> > -	inode_lock(d_inode(dentry));
> > -	host_error =3D security_inode_setsecctx(dentry, label->data, label->len=
);
> > -	inode_unlock(d_inode(dentry));
> > -	return nfserrno(host_error);
> > -}
> > -#else
> > -__be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > -		struct xdr_netobj *label)
> > -{
> > -	return nfserr_notsupp;
> > -}
> > -#endif
> >=20
> > static struct nfsd4_compound_state *nfsd4_get_cstate(struct svc_rqst *rqs=
tp)
> > {
> > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > index f3f43ca3ac6b..8464e04af1ea 100644
> > --- a/fs/nfsd/vfs.h
> > +++ b/fs/nfsd/vfs.h
> > @@ -44,6 +44,8 @@ typedef int (*nfsd_filldir_t)(void *, const char *, int=
, loff_t, u64, unsigned);
> > /* nfsd/vfs.c */
> > struct nfsd_attrs {
> > 	struct iattr *iattr;
> > +	struct xdr_netobj *label;
> > +	int label_failed;
> > };
> >=20
> > int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
> > @@ -57,8 +59,6 @@ __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
> > 				struct nfsd_attrs *, int, time64_t);
> > int nfsd_mountpoint(struct dentry *, struct svc_export *);
> > #ifdef CONFIG_NFSD_V4
> > -__be32          nfsd4_set_nfs4_label(struct svc_rqst *, struct svc_fh *,
> > -		    struct xdr_netobj *);
> > __be32		nfsd4_vfs_fallocate(struct svc_rqst *, struct svc_fh *,
> > 				    struct file *, loff_t, loff_t, int);
> > __be32		nfsd4_clone_file_range(struct svc_rqst *rqstp,
> >=20
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20
>=20
