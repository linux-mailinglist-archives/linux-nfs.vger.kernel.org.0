Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A4776D69E
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 20:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjHBSQA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 14:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjHBSP7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 14:15:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDAB171B;
        Wed,  2 Aug 2023 11:15:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A82D61A82;
        Wed,  2 Aug 2023 18:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8689C433C7;
        Wed,  2 Aug 2023 18:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691000157;
        bh=PiT5woENc2vRLh/R3Ys/yPODxCD7EzJZkfQJ61xnDnY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g/62gwmBPYqUiLoB/txoVZwdfxQUBqv38oqm4E95qybEDLPdxd/ybIhLu3H+RfXxg
         ajxwQP57eUzuz8YTKozCB2ruMoeSHkI2nz04Kvdnplu9zDaOuW4MZnd1F7MOtiGtlj
         xp3dB5QBFKbniC2O1zKwIg+fR/zU25AggBOFHRNO3redrLUTVNIFGy5bCMrYyvZLq3
         d9Uu+SicvtFmIlihl0Nbo+v7stpXV9ktPdpH7nqi76YAts86ef/ggcEwO+akX4NIFJ
         xsuZUem63IpGpbRITj4gvezKOBliCdggjrFcJTtLgTIuzLlZtgdr8Ww8ystp+8q1Cj
         r5XtqhVaia+vQ==
Message-ID: <c9370f6fde62205356f4c864891a3c35ef811877.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Aug 2023 14:15:55 -0400
In-Reply-To: <8c3adfce-39f0-0e60-e35a-2f1be6fb67e6@oracle.com>
References: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
         <8c3adfce-39f0-0e60-e35a-2f1be6fb67e6@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-08-02 at 09:29 -0700, dai.ngo@oracle.com wrote:
> On 8/1/23 6:33 AM, Jeff Layton wrote:
> > I noticed that xfstests generic/001 was failing against linux-next nfsd=
.
> >=20
> > The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the serve=
r
> > would hand out a write delegation. The client would then try to use tha=
t
> > write delegation as the source stateid in a COPY
>=20
> not sure why the client opens the source file of a COPY operation with
> OPEN4_SHARE_ACCESS_WRITE?
>=20

It doesn't. The original open is to write the data for the file being
copied. It then opens the file again for READ, but since it has a write
delegation, it doesn't need to talk to the server at all -- it can just
use that stateid for later operations.

> >   or CLONE operation, and
> > the server would respond with NFS4ERR_STALE.
>=20
> If the server does not allow client to use write delegation for the
> READ, should the correct error return be NFS4ERR_OPENMODE?
>=20

The server must allow the client to use a write delegation for read
operations. It's required by the spec, AFAIU.

The error in this case was just bogus. The vfs copy routine would return
-EBADF since the file didn't have FMODE_READ, and the nfs server would
translate that into NFS4ERR_STALE.

Probably there is a better v4 error code that we could translate EBADF
to, but with this patch it shouldn't be a problem any longer.=20

> >=20
> > The problem is that the struct file associated with the delegation does
> > not necessarily have read permissions. It's handing out a write
> > delegation on what is effectively an O_WRONLY open. RFC 8881 states:
> >=20
> >   "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on it=
s
> >    own, all opens."
> >=20
> > Given that the client didn't request any read permissions, and that nfs=
d
> > didn't check for any, it seems wrong to give out a write delegation.
> >=20
> > Only hand out a write delegation if we have a O_RDWR descriptor
> > available. If it fails to find an appropriate write descriptor, go
> > ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
> > requested.
> >=20
> > This fixes xfstest generic/001.
> >=20
> > Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D412
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Changes in v2:
> > - Rework the logic when finding struct file for the delegation. The
> >    earlier patch might still have attached a O_WRONLY file to the deleg
> >    in some cases, and could still have handed out a write delegation on
> >    an O_WRONLY OPEN request in some cases.
> > ---
> >   fs/nfsd/nfs4state.c | 29 ++++++++++++++++++-----------
> >   1 file changed, 18 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index ef7118ebee00..e79d82fd05e7 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
> >   	struct nfs4_file *fp =3D stp->st_stid.sc_file;
> >   	struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
> >   	struct nfs4_delegation *dp;
> > -	struct nfsd_file *nf;
> > +	struct nfsd_file *nf =3D NULL;
> >   	struct file_lock *fl;
> >   	u32 dl_type;
> >  =20
> > @@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_open *open, st=
ruct nfs4_ol_stateid *stp,
> >   	if (fp->fi_had_conflict)
> >   		return ERR_PTR(-EAGAIN);
> >  =20
> > -	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> > -		nf =3D find_writeable_file(fp);
> > +	/*
> > +	 * Try for a write delegation first. We need an O_RDWR file
> > +	 * since a write delegation allows the client to perform any open
> > +	 * from its cache.
> > +	 */
> > +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D NFS4_SHAR=
E_ACCESS_BOTH) {
> > +		nf =3D nfsd_file_get(fp->fi_fds[O_RDWR]);
> >   		dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> > -	} else {
>=20
> Does this mean OPEN4_SHARE_ACCESS_WRITE do not get a write delegation?
> It does not seem right.
>=20
> -Dai
>=20

Why? Per RFC 8881:

"An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
own, all opens."

All opens. That includes read opens.

An OPEN4_SHARE_ACCESS_WRITE open will succeed on a file to which the
user has no read permissions. Therefore, we can't grant a write
delegation since can't guarantee that the user is allowed to do that.


> > +	}
> > +
> > +	/*
> > +	 * If the file is being opened O_RDONLY or we couldn't get a O_RDWR
> > +	 * file for some reason, then try for a read deleg instead.
> > +	 */
> > +	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
> >   		nf =3D find_readable_file(fp);
> >   		dl_type =3D NFS4_OPEN_DELEGATE_READ;
> >   	}
> > -	if (!nf) {
> > -		/*
> > -		 * We probably could attempt another open and get a read
> > -		 * delegation, but for now, don't bother until the
> > -		 * client actually sends us one.
> > -		 */
> > +
> > +	if (!nf)
> >   		return ERR_PTR(-EAGAIN);
> > -	}
> > +
> >   	spin_lock(&state_lock);
> >   	spin_lock(&fp->fi_lock);
> >   	if (nfs4_delegation_exists(clp, fp))
> >=20
> > ---
> > base-commit: a734662572708cf062e974f659ae50c24fc1ad17
> > change-id: 20230731-wdeleg-bbdb6b25a3c6
> >=20
> > Best regards,

--=20
Jeff Layton <jlayton@kernel.org>
