Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F0D76D8D0
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 22:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjHBUsW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 16:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjHBUsV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 16:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598EA2726;
        Wed,  2 Aug 2023 13:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBA6961B06;
        Wed,  2 Aug 2023 20:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FAFC433C7;
        Wed,  2 Aug 2023 20:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691009297;
        bh=MFl0CXdaBFCVCYT5KrGye4B/Is5l3xLAdbE4GdQMaQI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PLvWxSHyd4UDX5WAt9PA5J/ABmdkIARmYHh7a4+7tU9r+Cx/l1DaZQKthg6NM7kle
         D/1lW42JhQwI2OjQEZE4fsntilfsq0krikTarlVyOL7UyMtCQAJ6Pz3KIkYq4wfiAP
         AqIphyVvf0Ik8Mjo3Uii73aYJ7Ue3DUAGnUCEOs6VzsqEoZbRJ0mxaVMWpnJbehOUm
         cgKhpdu3dbPA/M2IhltOU0LvMU96jD7Rc+L+gVXLYFbzwq63dr+wCrotVUqiSRXdSV
         EJUmlZI0rqxdvuHFA2eLCGxNYoaTg6+HZLXSfhPOUDoIhTEMCjOo0LldwTHlNOpjmq
         b4P+lvKTRgijA==
Message-ID: <d70f4dd0fc77566f15f5178424bcf901ed21fbad.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Aug 2023 16:48:15 -0400
In-Reply-To: <0a256174-44ea-d653-7643-b39f5081d8a5@oracle.com>
References: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
         <8c3adfce-39f0-0e60-e35a-2f1be6fb67e6@oracle.com>
         <c9370f6fde62205356f4c864891a3c35ef811877.camel@kernel.org>
         <0a256174-44ea-d653-7643-b39f5081d8a5@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-08-02 at 13:15 -0700, dai.ngo@oracle.com wrote:
> On 8/2/23 11:15 AM, Jeff Layton wrote:
> > On Wed, 2023-08-02 at 09:29 -0700, dai.ngo@oracle.com wrote:
> > > On 8/1/23 6:33 AM, Jeff Layton wrote:
> > > > I noticed that xfstests generic/001 was failing against linux-next =
nfsd.
> > > >=20
> > > > The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the s=
erver
> > > > would hand out a write delegation. The client would then try to use=
 that
> > > > write delegation as the source stateid in a COPY
> > > not sure why the client opens the source file of a COPY operation wit=
h
> > > OPEN4_SHARE_ACCESS_WRITE?
> > >=20
> > It doesn't. The original open is to write the data for the file being
> > copied. It then opens the file again for READ, but since it has a write
> > delegation, it doesn't need to talk to the server at all -- it can just
> > use that stateid for later operations.
> >=20
> > > >    or CLONE operation, and
> > > > the server would respond with NFS4ERR_STALE.
> > > If the server does not allow client to use write delegation for the
> > > READ, should the correct error return be NFS4ERR_OPENMODE?
> > >=20
> > The server must allow the client to use a write delegation for read
> > operations. It's required by the spec, AFAIU.
> >=20
> > The error in this case was just bogus. The vfs copy routine would retur=
n
> > -EBADF since the file didn't have FMODE_READ, and the nfs server would
> > translate that into NFS4ERR_STALE.
> >=20
> > Probably there is a better v4 error code that we could translate EBADF
> > to, but with this patch it shouldn't be a problem any longer.
> >=20
> > > > The problem is that the struct file associated with the delegation =
does
> > > > not necessarily have read permissions. It's handing out a write
> > > > delegation on what is effectively an O_WRONLY open. RFC 8881 states=
:
> > > >=20
> > > >    "An OPEN_DELEGATE_WRITE delegation allows the client to handle, =
on its
> > > >     own, all opens."
> > > >=20
> > > > Given that the client didn't request any read permissions, and that=
 nfsd
> > > > didn't check for any, it seems wrong to give out a write delegation=
.
> > > >=20
> > > > Only hand out a write delegation if we have a O_RDWR descriptor
> > > > available. If it fails to find an appropriate write descriptor, go
> > > > ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
> > > > requested.
> > > >=20
> > > > This fixes xfstest generic/001.
> > > >=20
> > > > Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D412
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > Changes in v2:
> > > > - Rework the logic when finding struct file for the delegation. The
> > > >     earlier patch might still have attached a O_WRONLY file to the =
deleg
> > > >     in some cases, and could still have handed out a write delegati=
on on
> > > >     an O_WRONLY OPEN request in some cases.
> > > > ---
> > > >    fs/nfsd/nfs4state.c | 29 ++++++++++++++++++-----------
> > > >    1 file changed, 18 insertions(+), 11 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index ef7118ebee00..e79d82fd05e7 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open *open, =
struct nfs4_ol_stateid *stp,
> > > >    	struct nfs4_file *fp =3D stp->st_stid.sc_file;
> > > >    	struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
> > > >    	struct nfs4_delegation *dp;
> > > > -	struct nfsd_file *nf;
> > > > +	struct nfsd_file *nf =3D NULL;
> > > >    	struct file_lock *fl;
> > > >    	u32 dl_type;
> > > >   =20
> > > > @@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_open *open=
, struct nfs4_ol_stateid *stp,
> > > >    	if (fp->fi_had_conflict)
> > > >    		return ERR_PTR(-EAGAIN);
> > > >   =20
> > > > -	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> > > > -		nf =3D find_writeable_file(fp);
> > > > +	/*
> > > > +	 * Try for a write delegation first. We need an O_RDWR file
> > > > +	 * since a write delegation allows the client to perform any open
> > > > +	 * from its cache.
> > > > +	 */
> > > > +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D NFS4_=
SHARE_ACCESS_BOTH) {
> > > > +		nf =3D nfsd_file_get(fp->fi_fds[O_RDWR]);
> > > >    		dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> > > > -	} else {
> > > Does this mean OPEN4_SHARE_ACCESS_WRITE do not get a write delegation=
?
> > > It does not seem right.
> > >=20
> > > -Dai
> > >=20
> > Why? Per RFC 8881:
> >=20
> > "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
> > own, all opens."
> >=20
> > All opens. That includes read opens.
> >=20
> > An OPEN4_SHARE_ACCESS_WRITE open will succeed on a file to which the
> > user has no read permissions. Therefore, we can't grant a write
> > delegation since can't guarantee that the user is allowed to do that.
>=20
> If the server grants the write delegation on an OPEN with
> OPEN4_SHARE_ACCESS_WRITE on the file with WR-only access mode then
> why can't the server checks and denies the subsequent READ?
>=20
> Per RFC 8881, section 9.1.2:
>=20
>      For delegation stateids, the access mode is based on the type of
>      delegation.
>=20
>      When a READ, WRITE, or SETATTR (that specifies the size attribute)
>      operation is done, the operation is subject to checking against the
>      access mode to verify that the operation is appropriate given the
>      stateid with which the operation is associated.
>=20
>      In the case of WRITE-type operations (i.e., WRITEs and SETATTRs that
>      set size), the server MUST verify that the access mode allows writin=
g
>      and MUST return an NFS4ERR_OPENMODE error if it does not. In the cas=
e
>      of READ, the server may perform the corresponding check on the acces=
s
>      mode, or it may choose to allow READ on OPENs for OPEN4_SHARE_ACCESS=
_WRITE,
>      to accommodate clients whose WRITE implementation may unavoidably do
>      reads (e.g., due to buffer cache constraints). However, even if READ=
s
>      are allowed in these circumstances, the server MUST still check for
>      locks that conflict with the READ (e.g., another OPEN specified
>      OPEN4_SHARE_DENY_READ or OPEN4_SHARE_DENY_BOTH). Note that a server
>      that does enforce the access mode check on READs need not explicitly
>      check for conflicting share reservations since the existence of OPEN
>      for OPEN4_SHARE_ACCESS_READ guarantees that no conflicting share
>      reservation can exist.
>=20
> FWIW, The Solaris server grants write delegation on OPEN with
> OPEN4_SHARE_ACCESS_WRITE on file with access mode either RW or
> WR-only. Maybe this is a bug? or the spec is not clear?
>=20

I don't think that's necessarily a bug.

It's not that the spec demands that we only hand out delegations on BOTH
opens.  This is more of a quirk of the Linux implementation. Linux'
write delegations require an open O_RDWR file descriptor because we may
be called upon to do a read on its behalf.

Technically, we could probably just have it check for
OPEN4_SHARE_ACCESS_WRITE, but in the case where READ isn't also set,
then you're unlikely to get a delegation. Either the O_RDWR descriptor
will be NULL, or there are other, conflicting opens already present.

Solaris may have a completely different design that doesn't require
this. I haven't looked at its code to know.

> It'd would be interesting to know how ONTAP server behaves in
> this scenario.
>=20

Indeed. Most likely it behaves more like Solaris does, but it'd nice to
know.

>
> >=20
> >=20
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * If the file is being opened O_RDONLY or we couldn't get a O_RD=
WR
> > > > +	 * file for some reason, then try for a read deleg instead.
> > > > +	 */
> > > > +	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
> > > >    		nf =3D find_readable_file(fp);
> > > >    		dl_type =3D NFS4_OPEN_DELEGATE_READ;
> > > >    	}
> > > > -	if (!nf) {
> > > > -		/*
> > > > -		 * We probably could attempt another open and get a read
> > > > -		 * delegation, but for now, don't bother until the
> > > > -		 * client actually sends us one.
> > > > -		 */
> > > > +
> > > > +	if (!nf)
> > > >    		return ERR_PTR(-EAGAIN);
> > > > -	}
> > > > +
> > > >    	spin_lock(&state_lock);
> > > >    	spin_lock(&fp->fi_lock);
> > > >    	if (nfs4_delegation_exists(clp, fp))
> > > >=20
> > > > ---
> > > > base-commit: a734662572708cf062e974f659ae50c24fc1ad17
> > > > change-id: 20230731-wdeleg-bbdb6b25a3c6
> > > >=20
> > > > Best regards,

--=20
Jeff Layton <jlayton@kernel.org>
