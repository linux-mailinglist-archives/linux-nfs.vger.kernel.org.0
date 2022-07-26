Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCC4581BEA
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 00:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiGZWBj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 18:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239623AbiGZWBj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 18:01:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2D932ED8
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 15:01:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A23F9200E1;
        Tue, 26 Jul 2022 22:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658872896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvQQ0NkdaLGv+eQyaevcbkXlILDXuLzUluURu926/Gc=;
        b=AMDcMBchZu46y2P9WvkcgruRMIkZcyxsLiU+wyZzD5sC5dcdkU/3Ih9PD2JX6PwTR75tkm
        IS6SOgN+bj6J/HbAZxzViyqzKlEl2hTjZDtwPUcOVesZ7Fuq6sJt5iCPRA1C0qvYDX7fHA
        ouGLlIi00k8KIBr06I0DYKRV1Vdsl18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658872896;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvQQ0NkdaLGv+eQyaevcbkXlILDXuLzUluURu926/Gc=;
        b=VazuxrpSnfXM9ePfhIr9g5JVD1CCGeGxEMW/4D8HIJYAnRlAiWPsZ8p1LIqUD32SX6PzC9
        ZyZgW5Yh8Se0nDDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8165113322;
        Tue, 26 Jul 2022 22:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZqcZDz9k4GIIYAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Jul 2022 22:01:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 04/13] NFSD: set attributes when creating symlinks
In-reply-to: <A4671B71-ECAD-42BF-8B67-5C098FF36172@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>,
 <165881793056.21666.12904500892707412393.stgit@noble.brown>,
 <A4671B71-ECAD-42BF-8B67-5C098FF36172@oracle.com>
Date:   Wed, 27 Jul 2022 08:01:31 +1000
Message-id: <165887289170.4359.18057479700877988511@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 26 Jul 2022, Chuck Lever III wrote:
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
> >=20
> > We ignore any error from nfsd_create_setattr().  It isn't really clear
> > what should be done if a file is successfully created, but the
> > attributes cannot be set.  NFS doesn't allow partial success to be
> > reported.  Reporting failure is probably more misleading than reporting
> > success, so the status is ignored.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
>=20
> While I was trying to get more information about how
> security labels are supposed to be applied to symlinks,
> Jeff, Bruce, and I had a brief private discussion about
> it. Jeff has the impression that NFSD should not apply
> ACLs/security labels to symlinks, and we believe that
> would be somewhat of a change in behavior.
>=20
> Now is a good time to hoist that private discussion to
> the list, so I'm mentioning it here. I'm thinking it
> would be appropriate to introduce that change in this
> series, and probably right here in this patch, if we
> agree that is the right thing to do going forward.

One option would be to avoid changing behaviour at this point.
That could be achieved by a one-line change in nfsd_symlink() in this
patch to clear the ia_valid field.  That way iattr attrs would still not
be set on symlinks, but ACLs/security labels would.
As and when we change our mind on what we *should* be doing, any such
change can then happen right there in nfsd_symlink() by making
modifications to the nfsd_attrs content, so it would be explicit in the
code.=20

My feeling on policy is that it is our job to implement the NFSv4
protocol.  If the protocol sends attributes, and if the filesystem
allows them to be set, when who are we to stand in the way?
I appreciate that might be an overly-narrow perspective.

>=20
> Otherwise, after a brief glance at the series, it looks
> better to me than the previous approach. I will try to
> dig in later this week so we can get this work merged at
> the end of the upcoming merge window.

Thanks,
NeilBrown

>=20
>=20
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
