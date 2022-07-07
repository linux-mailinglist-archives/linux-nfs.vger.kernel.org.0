Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D8856978D
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 03:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbiGGBdq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 21:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiGGBdo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 21:33:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0142E9F7
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 18:33:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD6BA22197;
        Thu,  7 Jul 2022 01:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657157621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57LSwW2TGM4P8BLbHC8PyW9cVKrvtWX6Hzrf4YjDx/g=;
        b=dCaX6aCt6FxWSDScJ0nJvjNKUNLrSLV0FYTWu+hOBQm2FuCuwNI9/OIIVrRsztFJ2XgXa2
        7nvEq0zVOeKLHCcVfJOfj9rC2pQ4tLlPczX6JgjFwt8FdRyHQoZ0U1Sq6xg+ANxZXu96Km
        5Skwt1lhtX9DiKalAf6DK3up5L7tXD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657157621;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57LSwW2TGM4P8BLbHC8PyW9cVKrvtWX6Hzrf4YjDx/g=;
        b=hk/0jRqvyX6efYNq/2PASjaqKOarcDz7DIg/8W8KXLeZTexUjkIgPyHUqt4TwcsV+/gc/V
        NaKMjjejqdpFj1BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCBE613A7D;
        Thu,  7 Jul 2022 01:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LyGUHvQ3xmKFYQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 07 Jul 2022 01:33:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 7/8] NFSD: use (un)lock_inode instead of fh_(un)lock for
 file operations
In-reply-to: <0B0BE802-9B4A-4732-B798-2F13A8A6B93C@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>,
 <165708109260.1940.6599746560136720935.stgit@noble.brown>,
 <0B0BE802-9B4A-4732-B798-2F13A8A6B93C@oracle.com>
Date:   Thu, 07 Jul 2022 11:33:32 +1000
Message-id: <165715761295.17141.11662811730561645400@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 07 Jul 2022, Chuck Lever III wrote:
>=20
> > On Jul 6, 2022, at 12:18 AM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > When locking a file to access ACLs and xattrs etc, use explicit locking
> > with inode_lock() instead of fh_lock().  This means that the calls to
> > fh_fill_pre/post_attr() are also explicit which improves readability and
> > allows us to place them only where they are needed.  Only the xattr
> > calls need pre/post information.
> >=20
> > When locking a file we don't need I_MUTEX_PARENT as the file is not a
> > parent of anything, so we can use inode_lock() directly rather than the
> > inode_lock_nested() call that fh_lock() uses.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > fs/nfsd/nfs2acl.c   |    6 +++---
> > fs/nfsd/nfs3acl.c   |    4 ++--
> > fs/nfsd/nfs4acl.c   |    7 +++----
> > fs/nfsd/nfs4state.c |    8 ++++----
> > fs/nfsd/vfs.c       |   25 ++++++++++++-------------
> > 5 files changed, 24 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
> > index b5760801d377..9edd3c1a30fb 100644
> > --- a/fs/nfsd/nfs2acl.c
> > +++ b/fs/nfsd/nfs2acl.c
> > @@ -111,7 +111,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rq=
stp)
> > 	if (error)
> > 		goto out_errno;
> >=20
> > -	fh_lock(fh);
> > +	inode_lock(inode);
> >=20
> > 	error =3D set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
> > 			      argp->acl_access);
> > @@ -122,7 +122,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rq=
stp)
> > 	if (error)
> > 		goto out_drop_lock;
> >=20
> > -	fh_unlock(fh);
> > +	inode_unlock(inode);
> >=20
> > 	fh_drop_write(fh);
> >=20
> > @@ -136,7 +136,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rq=
stp)
> > 	return rpc_success;
> >=20
> > out_drop_lock:
> > -	fh_unlock(fh);
> > +	inode_unlock(inode);
> > 	fh_drop_write(fh);
> > out_errno:
> > 	resp->status =3D nfserrno(error);
> > diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> > index 35b2ebda14da..9446c6743664 100644
> > --- a/fs/nfsd/nfs3acl.c
> > +++ b/fs/nfsd/nfs3acl.c
> > @@ -101,7 +101,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqst=
p)
> > 	if (error)
> > 		goto out_errno;
> >=20
> > -	fh_lock(fh);
> > +	inode_lock(inode);
> >=20
> > 	error =3D set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
> > 			      argp->acl_access);
> > @@ -111,7 +111,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqst=
p)
> > 			      argp->acl_default);
> >=20
> > out_drop_lock:
> > -	fh_unlock(fh);
> > +	inode_unlock(inode);
> > 	fh_drop_write(fh);
> > out_errno:
> > 	resp->status =3D nfserrno(error);
> > diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> > index 5c9b7e01e8ca..a33cacf62ea0 100644
> > --- a/fs/nfsd/nfs4acl.c
> > +++ b/fs/nfsd/nfs4acl.c
> > @@ -781,19 +781,18 @@ nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> > 	if (host_error < 0)
> > 		goto out_nfserr;
> >=20
> > -	fh_lock(fhp);
> > +	inode_lock(inode);
> >=20
> > 	host_error =3D set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS, pacl=
);
> > 	if (host_error < 0)
> > 		goto out_drop_lock;
> >=20
> > -	if (S_ISDIR(inode->i_mode)) {
> > +	if (S_ISDIR(inode->i_mode))
> > 		host_error =3D set_posix_acl(&init_user_ns, inode,
> > 					   ACL_TYPE_DEFAULT, dpacl);
> > -	}
> >=20
> > out_drop_lock:
> > -	fh_unlock(fhp);
> > +	inode_unlock(inode);
> >=20
> > 	posix_acl_release(pacl);
> > 	posix_acl_release(dpacl);
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 9d1a3e131c49..307317ba9aff 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -7322,21 +7322,21 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> > static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, =
struct file_lock *lock)
> > {
> > 	struct nfsd_file *nf;
> > +	struct inode *inode =3D fhp->fh_dentry->d_inode;
>=20
> I don't think this is correct.
>=20
> nfsd_file_acquire() calls fh_verify(), which can updated fhp->fh_dentry.
> Anyway, is it guaranteed that fh_dentry is not NULL here?

nfsd_test_lock() is only ever called from nfsd4_lockt(), and that always
calls fh_verify() before calling nfsd_test_lock().  So the code is safe.

>=20
> It would be more defensive to set @inode /after/ the call to
> nfsd_file_acquire().

Yes, that would make it even safer - thanks.

NeilBrown


>=20
>=20
> > 	__be32 err;
> >=20
> > 	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
> > 	if (err)
> > 		return err;
> > -	fh_lock(fhp); /* to block new leases till after test_lock: */
> > -	err =3D nfserrno(nfsd_open_break_lease(fhp->fh_dentry->d_inode,
> > -							NFSD_MAY_READ));
> > +	inode_lock(inode); /* to block new leases till after test_lock: */
> > +	err =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> > 	if (err)
> > 		goto out;
> > 	lock->fl_file =3D nf->nf_file;
> > 	err =3D nfserrno(vfs_test_lock(nf->nf_file, lock));
> > 	lock->fl_file =3D NULL;
> > out:
> > -	fh_unlock(fhp);
> > +	inode_unlock(inode);
> > 	nfsd_file_put(nf);
> > 	return err;
> > }
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 2ca748aa83bb..2526615285ca 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -444,7 +444,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp, struct iattr *iap,
> > 			return err;
> > 	}
> >=20
> > -	fh_lock(fhp);
> > +	inode_lock(inode);
> > 	if (size_change) {
> > 		/*
> > 		 * RFC5661, Section 18.30.4:
> > @@ -480,7 +480,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp, struct iattr *iap,
> > 	host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
> >=20
> > out_unlock:
> > -	fh_unlock(fhp);
> > +	inode_unlock(inode);
> > 	if (size_change)
> > 		put_write_access(inode);
> > out:
> > @@ -2196,12 +2196,8 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_=
fh *fhp, char **bufp,
> > }
> >=20
> > /*
> > - * Removexattr and setxattr need to call fh_lock to both lock the inode
> > - * and set the change attribute. Since the top-level vfs_removexattr
> > - * and vfs_setxattr calls already do their own inode_lock calls, call
> > - * the _locked variant. Pass in a NULL pointer for delegated_inode,
> > - * and let the client deal with NFS4ERR_DELAY (same as with e.g.
> > - * setattr and remove).
> > + * Pass in a NULL pointer for delegated_inode, and let the client deal
> > + * with NFS4ERR_DELAY (same as with e.g.  setattr and remove).
> >  */
> > __be32
> > nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
> > @@ -2217,12 +2213,14 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct s=
vc_fh *fhp, char *name)
> > 	if (ret)
> > 		return nfserrno(ret);
> >=20
> > -	fh_lock(fhp);
> > +	inode_lock(fhp->fh_dentry->d_inode);
> > +	fh_fill_pre_attrs(fhp);
> >=20
> > 	ret =3D __vfs_removexattr_locked(&init_user_ns, fhp->fh_dentry,
> > 				       name, NULL);
> >=20
> > -	fh_unlock(fhp);
> > +	fh_fill_post_attrs(fhp);
> > +	inode_unlock(fhp->fh_dentry->d_inode);
> > 	fh_drop_write(fhp);
> >=20
> > 	return nfsd_xattr_errno(ret);
> > @@ -2242,12 +2240,13 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_=
fh *fhp, char *name,
> > 	ret =3D fh_want_write(fhp);
> > 	if (ret)
> > 		return nfserrno(ret);
> > -	fh_lock(fhp);
> > +	inode_lock(fhp->fh_dentry->d_inode);
> > +	fh_fill_pre_attrs(fhp);
> >=20
> > 	ret =3D __vfs_setxattr_locked(&init_user_ns, fhp->fh_dentry, name, buf,
> > 				    len, flags, NULL);
> > -
> > -	fh_unlock(fhp);
> > +	fh_fill_post_attrs(fhp);
> > +	inode_unlock(fhp->fh_dentry->d_inode);
> > 	fh_drop_write(fhp);
> >=20
> > 	return nfsd_xattr_errno(ret);
> >=20
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20
>=20
