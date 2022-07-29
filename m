Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC6584952
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 03:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiG2B1O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 21:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2B1N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 21:27:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B7552DD6
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 18:27:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98D27353BA;
        Fri, 29 Jul 2022 01:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659058030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbVTwG4X5iMWlDyaPZaw9ByKbTbg+CnT0fmzmRB1lJ8=;
        b=1kMfS4pZ+F/1ISMzjSbCCAamFcT7/OcMsfRz3qwWgDtLLevTL1/QYWQqJ8pHVgW2zuoc02
        OZ1yCHvgqICnBMXbHJr3g7WmVAjNGHfQ4Tq4sAIC+4e7Inp7r6pIn82Qf90ghBcI+YizfH
        IneMRj25UQ5GcdMvT85C6lJ5q4RPtcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659058030;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbVTwG4X5iMWlDyaPZaw9ByKbTbg+CnT0fmzmRB1lJ8=;
        b=fq6wm4idHNKJr/lEvadRIHXDKct4QvFgy4rqp6bS0lfoMB5Tfy6XLVb7507VWd6Ew65GVD
        S1uYET7HTbk2QpDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7510613A7E;
        Fri, 29 Jul 2022 01:27:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VsUoDG0342JKPgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 29 Jul 2022 01:27:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 11/13] NFSD: use explicit lock/unlock for directory ops
In-reply-to: <6221A20D-6623-41EB-AC9F-BEFB1F4ED925@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>,
 <165881793059.21666.9611699223923887416.stgit@noble.brown>,
 <6221A20D-6623-41EB-AC9F-BEFB1F4ED925@oracle.com>
Date:   Fri, 29 Jul 2022 11:27:06 +1000
Message-id: <165905802651.4359.17617640232417036364@noble.neil.brown.name>
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
> > When creating or unlinking a name in a directory use explicit
> > inode_lock_nested() instead of fh_lock(), and explicit calls to
> > fh_fill_pre_attrs() and fh_fill_post_attrs().  This is already done for
> > renames.
>=20
> IIUC, the antecedent of "This is already done" is only "explicit
> calls to fh_fill_pre_attrs() and fh_fill_post_attrs()" ?

The "This" is both explicit locking and explicit fh_fill* calls.
In rename it isn't inode_lock_nested(), it is lock_rename()
Maybe
   This is already done for renames, with lock_rename() as the explicit
   locking.
??

>=20
> >=20
> > Also move the 'fill' calls closer to the operation that might change the
> > attributes.  This way they are avoided on some error paths.
> >=20
> > For the v2-only code in nfsproc.c, drop the fill calls as they aren't
> > needed.
>=20
> This feels like 3 independent changes to me. At least the v2 change
> should be moved to a separate patch. Relocating the "fill attrs" calls
> seems like it could cause noticeable behavior changes, so maybe it
> belongs also in a separate patch?

Three intimately related changes that could be applied in sequence.
What would be gained by having separate patches?
To my mind, the primary issue is review effort.  Mixing unrelated
changes make review of each change harder, so keep them separate.
Mixing related changes is less of a problem as the abstraction that you
need to keep front-of-mind are fewer.
On the flip side, every patch added increases the review burden.  If I
wanted to move all calls to foo(), I wouldn't have one patch for each
call.
I think that patch is easy to review as it stands, but if you think not
I guess it could be split.

Allowing bisect to isolate the problem precisely is another reason for
keeping patches small.  If a bug were found to be caused by this patch I
doubt it would be at all hard to localise which part of the patch caused
it.

>=20
>=20
> > Having the locking explicit will simplify proposed future changes to
>=20
> ^Having^Making ?

Yes, that's probably a little clearer.

Thanks,
NeilBrown

>=20
>=20
> > locking for directories.  It also makes it easily visible exactly where
> > pre/post attributes are used - not all callers of fh_lock() actually
> > need the pre/post attributes.
> >=20
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > fs/nfsd/nfs3proc.c |    6 ++++--
> > fs/nfsd/nfs4proc.c |    6 ++++--
> > fs/nfsd/nfsproc.c  |    5 ++---
> > fs/nfsd/vfs.c      |   30 +++++++++++++++++++-----------
> > 4 files changed, 29 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> > index 774e4a2ab9b1..c2f992b4387a 100644
> > --- a/fs/nfsd/nfs3proc.c
> > +++ b/fs/nfsd/nfs3proc.c
> > @@ -256,7 +256,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> > 	if (host_err)
> > 		return nfserrno(host_err);
> >=20
> > -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> > +	inode_lock_nested(inode, I_MUTEX_PARENT);
> >=20
> > 	child =3D lookup_one_len(argp->name, parent, argp->len);
> > 	if (IS_ERR(child)) {
> > @@ -314,11 +314,13 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> > 	if (!IS_POSIXACL(inode))
> > 		iap->ia_mode &=3D ~current_umask();
> >=20
> > +	fh_fill_pre_attrs(fhp);
> > 	host_err =3D vfs_create(&init_user_ns, inode, child, iap->ia_mode, true);
> > 	if (host_err < 0) {
> > 		status =3D nfserrno(host_err);
> > 		goto out;
> > 	}
> > +	fh_fill_post_attrs(fhp);
> >=20
> > 	/* A newly created file already has a file size of zero. */
> > 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size =3D=3D 0))
> > @@ -336,7 +338,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> > 	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
> >=20
> > out:
> > -	fh_unlock(fhp);
> > +	inode_unlock(inode);
> > 	if (child && !IS_ERR(child))
> > 		dput(child);
> > 	fh_drop_write(fhp);
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 48e4efb39a9c..90af82d49119 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -264,7 +264,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> > 	if (is_create_with_attrs(open))
> > 		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
> >=20
> > -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> > +	inode_lock_nested(inode, I_MUTEX_PARENT);
> >=20
> > 	child =3D lookup_one_len(open->op_fname, parent, open->op_fnamelen);
> > 	if (IS_ERR(child)) {
> > @@ -348,10 +348,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> > 	if (!IS_POSIXACL(inode))
> > 		iap->ia_mode &=3D ~current_umask();
> >=20
> > +	fh_fill_pre_attrs(fhp);
> > 	status =3D nfsd4_vfs_create(fhp, child, open);
> > 	if (status !=3D nfs_ok)
> > 		goto out;
> > 	open->op_created =3D true;
> > +	fh_fill_post_attrs(fhp);
> >=20
> > 	/* A newly created file already has a file size of zero. */
> > 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size =3D=3D 0))
> > @@ -373,7 +375,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> > 	if (attrs.acl_failed)
> > 		open->op_bmval[0] &=3D ~FATTR4_WORD0_ACL;
> > out:
> > -	fh_unlock(fhp);
> > +	inode_unlock(inode);
> > 	nfsd_attrs_free(&attrs);
> > 	if (child && !IS_ERR(child))
> > 		dput(child);
> > diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> > index d09d516188d2..4cff332f58bb 100644
> > --- a/fs/nfsd/nfsproc.c
> > +++ b/fs/nfsd/nfsproc.c
> > @@ -287,7 +287,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> > 		goto done;
> > 	}
> >=20
> > -	fh_lock_nested(dirfhp, I_MUTEX_PARENT);
> > +	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
> > 	dchild =3D lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
> > 	if (IS_ERR(dchild)) {
> > 		resp->status =3D nfserrno(PTR_ERR(dchild));
> > @@ -403,8 +403,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> > 	}
> >=20
> > out_unlock:
> > -	/* We don't really need to unlock, as fh_put does it. */
> > -	fh_unlock(dirfhp);
> > +	inode_unlock(dirfhp->fh_dentry->d_inode);
> > 	fh_drop_write(dirfhp);
> > done:
> > 	fh_put(dirfhp);
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 8ebad4a99552..f2cb9b047766 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1369,7 +1369,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
> > 	if (host_err)
> > 		return nfserrno(host_err);
> >=20
> > -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> > +	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> > 	dchild =3D lookup_one_len(fname, dentry, flen);
> > 	host_err =3D PTR_ERR(dchild);
> > 	if (IS_ERR(dchild)) {
> > @@ -1384,10 +1384,12 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
> > 	dput(dchild);
> > 	if (err)
> > 		goto out_unlock;
> > +	fh_fill_pre_attrs(fhp);
> > 	err =3D nfsd_create_locked(rqstp, fhp, fname, flen, attrs, type,
> > 				 rdev, resfhp);
> > +	fh_fill_post_attrs(fhp);
> > out_unlock:
> > -	fh_unlock(fhp);
> > +	inode_unlock(dentry->d_inode);
> > 	return err;
> > }
> >=20
> > @@ -1460,20 +1462,22 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
> > 		goto out;
> > 	}
> >=20
> > -	fh_lock(fhp);
> > 	dentry =3D fhp->fh_dentry;
> > +	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> > 	dnew =3D lookup_one_len(fname, dentry, flen);
> > 	if (IS_ERR(dnew)) {
> > 		err =3D nfserrno(PTR_ERR(dnew));
> > -		fh_unlock(fhp);
> > +		inode_unlock(dentry->d_inode);
> > 		goto out_drop_write;
> > 	}
> > +	fh_fill_pre_attrs(fhp);
> > 	host_err =3D vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
> > 	err =3D nfserrno(host_err);
> > 	cerr =3D fh_compose(resfhp, fhp->fh_export, dnew, fhp);
> > 	if (!err)
> > 		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
> > -	fh_unlock(fhp);
> > +	fh_fill_post_attrs(fhp);
> > +	inode_unlock(dentry->d_inode);
> > 	if (!err)
> > 		err =3D nfserrno(commit_metadata(fhp));
> > 	dput(dnew);
> > @@ -1519,9 +1523,9 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ff=
hp,
> > 		goto out;
> > 	}
> >=20
> > -	fh_lock_nested(ffhp, I_MUTEX_PARENT);
> > 	ddir =3D ffhp->fh_dentry;
> > 	dirp =3D d_inode(ddir);
> > +	inode_lock_nested(dirp, I_MUTEX_PARENT);
> >=20
> > 	dnew =3D lookup_one_len(name, ddir, len);
> > 	if (IS_ERR(dnew)) {
> > @@ -1534,8 +1538,10 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *f=
fhp,
> > 	err =3D nfserr_noent;
> > 	if (d_really_is_negative(dold))
> > 		goto out_dput;
> > +	fh_fill_pre_attrs(ffhp);
> > 	host_err =3D vfs_link(dold, &init_user_ns, dirp, dnew, NULL);
> > -	fh_unlock(ffhp);
> > +	fh_fill_post_attrs(ffhp);
> > +	inode_unlock(dirp);
> > 	if (!host_err) {
> > 		err =3D nfserrno(commit_metadata(ffhp));
> > 		if (!err)
> > @@ -1555,7 +1561,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ff=
hp,
> > out_dput:
> > 	dput(dnew);
> > out_unlock:
> > -	fh_unlock(ffhp);
> > +	inode_unlock(dirp);
> > 	goto out_drop_write;
> > }
> >=20
> > @@ -1730,9 +1736,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
> > 	if (host_err)
> > 		goto out_nfserr;
> >=20
> > -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> > 	dentry =3D fhp->fh_dentry;
> > 	dirp =3D d_inode(dentry);
> > +	inode_lock_nested(dirp, I_MUTEX_PARENT);
> >=20
> > 	rdentry =3D lookup_one_len(fname, dentry, flen);
> > 	host_err =3D PTR_ERR(rdentry);
> > @@ -1750,6 +1756,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
> > 	if (!type)
> > 		type =3D d_inode(rdentry)->i_mode & S_IFMT;
> >=20
> > +	fh_fill_pre_attrs(fhp);
> > 	if (type !=3D S_IFDIR) {
> > 		if (rdentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK)
> > 			nfsd_close_cached_files(rdentry);
> > @@ -1757,8 +1764,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
> > 	} else {
> > 		host_err =3D vfs_rmdir(&init_user_ns, dirp, rdentry);
> > 	}
> > +	fh_fill_post_attrs(fhp);
> >=20
> > -	fh_unlock(fhp);
> > +	inode_unlock(dirp);
> > 	if (!host_err)
> > 		host_err =3D commit_metadata(fhp);
> > 	dput(rdentry);
> > @@ -1781,7 +1789,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
> > out:
> > 	return err;
> > out_unlock:
> > -	fh_unlock(fhp);
> > +	inode_unlock(dirp);
> > 	goto out_drop_write;
> > }
> >=20
> >=20
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20
>=20
