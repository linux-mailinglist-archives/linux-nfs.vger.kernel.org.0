Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690C8584940
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 03:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiG2BJw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 21:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2BJw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 21:09:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1948F67161
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 18:09:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC604351D6;
        Fri, 29 Jul 2022 01:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659056988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=keTHzPHBPd4otzhrKNdIDV5819MvwuT0UcC8M8EOG3E=;
        b=N5Cux7hJQasV6KJpwGAkCu1Has3J/Hd9DAwE5Z5KU0PojfMrI5NsCdnnyK8+VGnkIHikaT
        ntWuHdsC7X54rsiF+i0INKtUQ3iIrFYR6Vm/TVrzDutJnOpCtxiaBuj1GXKCJoGVBwHZJf
        Pm3K1O/ru1I1nqTNu5wlCL8VEGK8t3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659056988;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=keTHzPHBPd4otzhrKNdIDV5819MvwuT0UcC8M8EOG3E=;
        b=g5XCdn4B7gC+KV64VZXHlxyv7N5ewB2P3FHo+aIDJJbCXY9OfM2WVLNamfTWmkfQ6B5amM
        6n6r9Iqu2KgEyXDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95B1E13A7E;
        Fri, 29 Jul 2022 01:09:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +yx7E1sz42JsOQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 29 Jul 2022 01:09:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 04/13] NFSD: set attributes when creating symlinks
In-reply-to: <F72352C4-4CFA-48CB-8901-EC6AFAC2E8BF@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>,
 <165881793056.21666.12904500892707412393.stgit@noble.brown>,
 <F72352C4-4CFA-48CB-8901-EC6AFAC2E8BF@oracle.com>
Date:   Fri, 29 Jul 2022 11:09:43 +1000
Message-id: <165905698386.4359.4415414780048520317@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 29 Jul 2022, Chuck Lever III wrote:
>=20
> > On Jul 26, 2022, at 2:45 AM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > The NFS protocol includes attributes when creating symlinks.
> > Linux does store attributes for symlinks and allows them to be set,
> > though they are not used for permission checking.
> >=20
> > NFSD currently doesn't set standard (struct iattr) attributes when
> > creating symlinks, but for NFSv4 it does set ACLs and security labels.
> > This is inconsistent.
> >=20
> > To improve consistency, pass the provided attributes into nfsd_symlink()
> > and call nfsd_create_setattr() to set them.
>=20
> This patch actually introduces a behavior change, if I'm reading
> it correctly. NFSD will now permit an NFSv4 client to specify
> attributes on creation, correct? I'm wondering if there will be
> fallout for our test cases.
>=20
> In any event, not an objection to this patch, but wanted the
> behavior modification to be noted at least in the review comments.
>=20

Yes, this patch changes behaviour for v2, v3, and v4.  Whatever
attributes are received from the client when creating a symlink are
passed on to the filesystem.
With the Linux client, the only attributes are
	attr.ia_mode =3D S_IFLNK | S_IRWXUGO;
	attr.ia_valid =3D ATTR_MODE;
so the final outcome will be unchanged.
Other clients might sent different attributes, and if they did they
probably expect them to be honoured.

As you say, making this explicit in the commit comment is appropriate.
Maybe:

  NOTE: this results in a behaviour change for all NFS versions when the
  client sends non-default attributes with a SYMLINK request.

Thanks,
NeilBrown


>=20
> > We ignore any error from nfsd_create_setattr().  It isn't really clear
> > what should be done if a file is successfully created, but the
> > attributes cannot be set.  NFS doesn't allow partial success to be
> > reported.  Reporting failure is probably more misleading than reporting
> > success, so the status is ignored.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > fs/nfsd/nfs3proc.c |    3 ++-
> > fs/nfsd/nfs4proc.c |    2 +-
> > fs/nfsd/nfsproc.c  |    3 ++-
> > fs/nfsd/vfs.c      |   11 ++++++-----
> > fs/nfsd/vfs.h      |    5 +++--
> > 5 files changed, 14 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> > index 289eb844d086..5e369096e42f 100644
> > --- a/fs/nfsd/nfs3proc.c
> > +++ b/fs/nfsd/nfs3proc.c
> > @@ -391,6 +391,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
> > {
> > 	struct nfsd3_symlinkargs *argp =3D rqstp->rq_argp;
> > 	struct nfsd3_diropres *resp =3D rqstp->rq_resp;
> > +	struct nfsd_attrs attrs =3D { .iattr =3D &argp->attrs };
> >=20
> > 	if (argp->tlen =3D=3D 0) {
> > 		resp->status =3D nfserr_inval;
> > @@ -417,7 +418,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
> > 	fh_copy(&resp->dirfh, &argp->ffh);
> > 	fh_init(&resp->fh, NFS3_FHSIZE);
> > 	resp->status =3D nfsd_symlink(rqstp, &resp->dirfh, argp->fname,
> > -				    argp->flen, argp->tname, &resp->fh);
> > +				    argp->flen, argp->tname, &attrs, &resp->fh);
> > 	kfree(argp->tname);
> > out:
> > 	return rpc_success;
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index ba750d76f515..ee72c94732f0 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -809,7 +809,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> > 	case NF4LNK:
> > 		status =3D nfsd_symlink(rqstp, &cstate->current_fh,
> > 				      create->cr_name, create->cr_namelen,
> > -				      create->cr_data, &resfh);
> > +				      create->cr_data, &attrs, &resfh);
> > 		break;
> >=20
> > 	case NF4BLK:
> > diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> > index 594d6f85c89f..d09d516188d2 100644
> > --- a/fs/nfsd/nfsproc.c
> > +++ b/fs/nfsd/nfsproc.c
> > @@ -474,6 +474,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
> > {
> > 	struct nfsd_symlinkargs *argp =3D rqstp->rq_argp;
> > 	struct nfsd_stat *resp =3D rqstp->rq_resp;
> > +	struct nfsd_attrs attrs =3D { .iattr =3D &argp->attrs };
> > 	struct svc_fh	newfh;
> >=20
> > 	if (argp->tlen > NFS_MAXPATHLEN) {
> > @@ -495,7 +496,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
> >=20
> > 	fh_init(&newfh, NFS_FHSIZE);
> > 	resp->status =3D nfsd_symlink(rqstp, &argp->ffh, argp->fname, argp->flen,
> > -				    argp->tname, &newfh);
> > +				    argp->tname, &attrs, &newfh);
> >=20
> > 	kfree(argp->tname);
> > 	fh_put(&argp->ffh);
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index a85dc4dd4f3a..91c9ea09f921 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1451,9 +1451,9 @@ nfsd_readlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, char *buf, int *lenp)
> >  */
> > __be32
> > nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > -				char *fname, int flen,
> > -				char *path,
> > -				struct svc_fh *resfhp)
> > +	     char *fname, int flen,
> > +	     char *path, struct nfsd_attrs *attrs,
> > +	     struct svc_fh *resfhp)
>=20
> It would be nice if nfsd_symlink() had a kdoc comment like the one
> that nfsd_create_setattr() has.
>=20
>=20
> > {
> > 	struct dentry	*dentry, *dnew;
> > 	__be32		err, cerr;
> > @@ -1483,13 +1483,14 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
> >=20
> > 	host_err =3D vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
> > 	err =3D nfserrno(host_err);
> > +	cerr =3D fh_compose(resfhp, fhp->fh_export, dnew, fhp);
> > +	if (!err)
> > +		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
> > 	fh_unlock(fhp);
> > 	if (!err)
> > 		err =3D nfserrno(commit_metadata(fhp));
> > -
> > 	fh_drop_write(fhp);
> >=20
> > -	cerr =3D fh_compose(resfhp, fhp->fh_export, dnew, fhp);
> > 	dput(dnew);
> > 	if (err=3D=3D0) err =3D cerr;
> > out:
> > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > index 9bb0e3957982..f3f43ca3ac6b 100644
> > --- a/fs/nfsd/vfs.h
> > +++ b/fs/nfsd/vfs.h
> > @@ -114,8 +114,9 @@ __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> > __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
> > 				char *, int *);
> > __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
> > -				char *name, int len, char *path,
> > -				struct svc_fh *res);
> > +			     char *name, int len, char *path,
> > +			     struct nfsd_attrs *attrs,
> > +			     struct svc_fh *res);
> > __be32		nfsd_link(struct svc_rqst *, struct svc_fh *,
> > 				char *, int, struct svc_fh *);
> > ssize_t		nfsd_copy_file_range(struct file *, u64,
> >=20
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20
>=20
