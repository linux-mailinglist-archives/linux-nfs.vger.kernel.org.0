Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F4C75C6C1
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 14:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjGUMSE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 08:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjGUMSC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 08:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1166172A;
        Fri, 21 Jul 2023 05:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D25B61A32;
        Fri, 21 Jul 2023 12:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4006C433C8;
        Fri, 21 Jul 2023 12:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689941879;
        bh=rJi2DTN83RfAThWFtDygFnpUN4JOZdYbsP09b1MLD6o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Bcy9AuDS9GdJtXMPCZTZcPJ0O+C6N6KFx0WHt2JTJnh1NtoToxaj2CSOsx+Mvfylj
         eJamf0ktvE6eTbBkrM3aLd+TTEjTE4sT+/TVrwVPAUoY7ky+i/Tm+p03cR7QXEBfc+
         MH1HiRIMVWCV8N9rOcY1diKYvc+tglaMAj9jK7LQqA6wofniN8UF1V2swN0yEM4ze9
         RwWwcBiwI8MgUxKdHQBJfN/RDZqgHg6oct/Ls2Xh7CTa3rofEEXgPX4lWfAq9k4XkO
         Vwcj9FSePL72HmS5aLTRd4aq/qPzedf3ZrDKwsr3ZpPvOuKR4PAHf0RPFwPgZAzlJ2
         FwiT91RGvmdBw==
Message-ID: <1de18a8bfa747d7949eb8afc93b66519538cc3f9.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] nfsd: handle failure to collect pre/post-op
 attrs more sanely
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Boyang Xue <bxue@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Jul 2023 08:17:57 -0400
In-Reply-To: <ZLm+w+aYVm59ctGq@manet.1015granger.net>
References: <20230720-bz2223560-v2-0-070aaf2660b7@kernel.org>
         <20230720-bz2223560-v2-1-070aaf2660b7@kernel.org>
         <168988958067.11078.10143293324143654882@noble.neil.brown.name>
         <ZLm+w+aYVm59ctGq@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-07-20 at 19:09 -0400, Chuck Lever wrote:
> On Fri, Jul 21, 2023 at 07:46:20AM +1000, NeilBrown wrote:
> > On Fri, 21 Jul 2023, Jeff Layton wrote:
> > > Collecting pre_op_attrs can fail, in which case it's probably best to
> > > fail the whole operation.
> > >=20
> > > Change fh_fill_{pre,post,both}_attrs to return __be32. For the pre an=
d
> > > both functions, have the callers check the return code and abort the
> > > operation if it failed.
> > >=20
> > > If fh_fill_post_attrs fails, then it's too late to do anything about =
it,
> > > so most of those callers ignore the return value. If this happens, th=
en
> > > fh_post_saved will be false, which should cue the later stages to dea=
l
> > > with it.
> > >=20
> > > Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/nfs3proc.c |  4 +++-
> > >  fs/nfsd/nfs4proc.c | 14 ++++++------
> > >  fs/nfsd/nfsfh.c    | 26 ++++++++++++++---------
> > >  fs/nfsd/nfsfh.h    |  6 +++---
> > >  fs/nfsd/vfs.c      | 62 ++++++++++++++++++++++++++++++++++----------=
----------
> > >  5 files changed, 69 insertions(+), 43 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> > > index fc8d5b7db9f8..268ef57751c4 100644
> > > --- a/fs/nfsd/nfs3proc.c
> > > +++ b/fs/nfsd/nfs3proc.c
> > > @@ -307,7 +307,9 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> > >  	if (!IS_POSIXACL(inode))
> > >  		iap->ia_mode &=3D ~current_umask();
> > > =20
> > > -	fh_fill_pre_attrs(fhp);
> > > +	status =3D fh_fill_pre_attrs(fhp);
> > > +	if (status !=3D nfs_ok)
> > > +		goto out;
> > >  	host_err =3D vfs_create(&nop_mnt_idmap, inode, child, iap->ia_mode,=
 true);
> > >  	if (host_err < 0) {
> > >  		status =3D nfserrno(host_err);
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index d8e7a533f9d2..9285e1eab4d5 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -297,12 +297,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
> > >  	}
> > > =20
> > >  	if (d_really_is_positive(child)) {
> > > -		status =3D nfs_ok;
> > > -
> > >  		/* NFSv4 protocol requires change attributes even though
> > >  		 * no change happened.
> > >  		 */
> > > -		fh_fill_both_attrs(fhp);
> > > +		status =3D fh_fill_both_attrs(fhp);
> > > +		if (status !=3D nfs_ok)
> > > +			goto out;
> > > =20
> > >  		switch (open->op_createmode) {
> > >  		case NFS4_CREATE_UNCHECKED:
> > > @@ -345,7 +345,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> > >  	if (!IS_POSIXACL(inode))
> > >  		iap->ia_mode &=3D ~current_umask();
> > > =20
> > > -	fh_fill_pre_attrs(fhp);
> > > +	status =3D fh_fill_pre_attrs(fhp);
> > > +	if (status !=3D nfs_ok)
> > > +		goto out;
> > >  	status =3D nfsd4_vfs_create(fhp, child, open);
> > >  	if (status !=3D nfs_ok)
> > >  		goto out;
> > > @@ -424,11 +426,11 @@ do_open_lookup(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate, stru
> > >  	} else {
> > >  		status =3D nfsd_lookup(rqstp, current_fh,
> > >  				     open->op_fname, open->op_fnamelen, *resfh);
> > > -		if (!status)
> > > +		if (status =3D=3D nfs_ok)
> > >  			/* NFSv4 protocol requires change attributes even though
> > >  			 * no change happened.
> > >  			 */
> > > -			fh_fill_both_attrs(current_fh);
> > > +			status =3D fh_fill_both_attrs(current_fh);
> > >  	}
> > >  	if (status)
> > >  		goto out;
> > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > index c291389a1d71..f7e68a91e826 100644
> > > --- a/fs/nfsd/nfsfh.c
> > > +++ b/fs/nfsd/nfsfh.c
> > > @@ -614,7 +614,7 @@ fh_update(struct svc_fh *fhp)
> > >   * @fhp: file handle to be updated
> > >   *
> > >   */
> > > -void fh_fill_pre_attrs(struct svc_fh *fhp)
> > > +__be32 fh_fill_pre_attrs(struct svc_fh *fhp)
> > >  {
> > >  	bool v4 =3D (fhp->fh_maxsize =3D=3D NFS4_FHSIZE);
> > >  	struct inode *inode;
> > > @@ -622,12 +622,12 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> > >  	__be32 err;
> > > =20
> > >  	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
> > > -		return;
> > > +		return nfs_ok;
> > > =20
> > >  	inode =3D d_inode(fhp->fh_dentry);
> > >  	err =3D fh_getattr(fhp, &stat);
> > >  	if (err)
> > > -		return;
> > > +		return err;
> > > =20
> > >  	if (v4)
> > >  		fhp->fh_pre_change =3D nfsd4_change_attribute(&stat, inode);
> > > @@ -636,6 +636,7 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> > >  	fhp->fh_pre_ctime =3D stat.ctime;
> > >  	fhp->fh_pre_size  =3D stat.size;
> > >  	fhp->fh_pre_saved =3D true;
> > > +	return nfs_ok;
> > >  }
> > > =20
> > >  /**
> > > @@ -643,26 +644,27 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> > >   * @fhp: file handle to be updated
> > >   *
> > >   */
> > > -void fh_fill_post_attrs(struct svc_fh *fhp)
> > > +__be32 fh_fill_post_attrs(struct svc_fh *fhp)
> > >  {
> > >  	bool v4 =3D (fhp->fh_maxsize =3D=3D NFS4_FHSIZE);
> > >  	struct inode *inode =3D d_inode(fhp->fh_dentry);
> > >  	__be32 err;
> > > =20
> > >  	if (fhp->fh_no_wcc)
> > > -		return;
> > > +		return nfs_ok;
> > > =20
> > >  	if (fhp->fh_post_saved)
> > >  		printk("nfsd: inode locked twice during operation.\n");
> > > =20
> > >  	err =3D fh_getattr(fhp, &fhp->fh_post_attr);
> > >  	if (err)
> > > -		return;
> > > +		return err;
> > > =20
> > >  	fhp->fh_post_saved =3D true;
> > >  	if (v4)
> > >  		fhp->fh_post_change =3D
> > >  			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
> > > +	return nfs_ok;
> > >  }
> > > =20
> > >  /**
> > > @@ -672,16 +674,20 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
> > >   * This is used when the directory wasn't changed, but wcc attribute=
s
> > >   * are needed anyway.
> > >   */
> > > -void fh_fill_both_attrs(struct svc_fh *fhp)
> > > +__be32 fh_fill_both_attrs(struct svc_fh *fhp)
> > >  {
> > > -	fh_fill_post_attrs(fhp);
> > > -	if (!fhp->fh_post_saved)
> > > -		return;
> > > +	__be32 err;
> > > +
> > > +	err =3D fh_fill_post_attrs(fhp);
> > > +	if (err)
> > > +		return err;
> > > +
> > >  	fhp->fh_pre_change =3D fhp->fh_post_change;
> > >  	fhp->fh_pre_mtime =3D fhp->fh_post_attr.mtime;
> > >  	fhp->fh_pre_ctime =3D fhp->fh_post_attr.ctime;
> > >  	fhp->fh_pre_size =3D fhp->fh_post_attr.size;
> > >  	fhp->fh_pre_saved =3D true;
> > > +	return nfs_ok;
> > >  }
> > > =20
> > >  /*
> > > diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> > > index 4e0ecf0ae2cf..486803694acc 100644
> > > --- a/fs/nfsd/nfsfh.h
> > > +++ b/fs/nfsd/nfsfh.h
> > > @@ -294,7 +294,7 @@ static inline void fh_clear_pre_post_attrs(struct=
 svc_fh *fhp)
> > >  }
> > > =20
> > >  u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode);
> > > -extern void fh_fill_pre_attrs(struct svc_fh *fhp);
> > > -extern void fh_fill_post_attrs(struct svc_fh *fhp);
> > > -extern void fh_fill_both_attrs(struct svc_fh *fhp);
> > > +__be32 fh_fill_pre_attrs(struct svc_fh *fhp);
> > > +__be32 fh_fill_post_attrs(struct svc_fh *fhp);
> > > +__be32 fh_fill_both_attrs(struct svc_fh *fhp);
> > >  #endif /* _LINUX_NFSD_NFSFH_H */
> > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > index 8a2321d19194..f200afd33630 100644
> > > --- a/fs/nfsd/vfs.c
> > > +++ b/fs/nfsd/vfs.c
> > > @@ -1537,9 +1537,11 @@ nfsd_create(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
> > >  	dput(dchild);
> > >  	if (err)
> > >  		goto out_unlock;
> > > -	fh_fill_pre_attrs(fhp);
> > > -	err =3D nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
> > > -	fh_fill_post_attrs(fhp);
> > > +	err =3D fh_fill_pre_attrs(fhp);
> > > +	if (err =3D=3D nfs_ok) {
> > > +		err =3D nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
> > > +		fh_fill_post_attrs(fhp);
> >=20
> > Most error handling in nfsd is
> > =20
> >    if (err)
> >        goto ....
> >=20
> > Here (and one other place I think) you have
> >    if (not err)
> >        do stuff;
> >=20
> > Do we want to be more consistent?
>=20
> Yes, unless being consistent makes this code unreadable. There
> doesn't seem to be a reason to drop that convention here.
>=20

My usual test for this is to use gotos if unwinding errors is complex
enough to warrant it, and to just use the second form if the code is
fairly simple.

But...if you want gotos everywhere, then so be it. I'll respin this.

>=20
> > I'm in two minds about this and I
> > don't dislike your patch.  But I noticed the inconsistency and thought =
I
> > should mention it.
> >=20
> > Also, should we put a __must_check annotation on fh_fill_pre_attrs() an=
d
> > ..post..?  Then I wouldn't have to manually check that you found and
> > fixed all callers (which I haven't).

Maybe for the "pre" and "both" ones. We would _not_ want to add
__must_check for the post one, since most of the callers (correctly)
ignore that return value.

I'll=A0plan to roll that in.
--=20
Jeff Layton <jlayton@kernel.org>
