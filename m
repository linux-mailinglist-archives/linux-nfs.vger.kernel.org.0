Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ECC76C158
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 02:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjHBAID (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Aug 2023 20:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHBAIC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Aug 2023 20:08:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B471BFD;
        Tue,  1 Aug 2023 17:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 419556176B;
        Wed,  2 Aug 2023 00:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06804C433C8;
        Wed,  2 Aug 2023 00:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690934880;
        bh=BMzrpwv50MEUrljcMRk308rZZ/nGCYCQ57sEQTo0m0Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UKFam1cbsjxf5e3PLeCLASsOLLHZtew2aGILu9pq2mqm7tpNMiri+g4nef71wso0Y
         VSRpXGleYsdrcoyNmwJDzRAcZRORNE/IuK7AE3oNQdwbpxG2NESoMoB//arwWaEwXn
         UrKjN0SEF6lG1LRQE1pFUkpiS/LIgcySdHdPHdHFS1f9xGDkMVFO1k2BItyxyO4tA2
         T2LCjiFGPxzhoop8HmS2YWrWwBTXkwYadyprAFJzffO4uS/+IFQqTjCntmRDj2LmrB
         Z65RQFqwA3wXW0gFV4kLI8zvWolbwlDPMmezarKjN7YfsYb9Iu65sg3EFQ7AXWOJy5
         35hTxr1AYKQuA==
Message-ID: <144121b83bca817eb17c8d0b40b4a419543b8275.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Cc:     Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 01 Aug 2023 20:07:58 -0400
In-Reply-To: <ZMmMfPSFIkV2dbhg@tissot.1015granger.net>
References: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
         <169092877531.32308.10105992729094485900@noble.neil.brown.name>
         <ZMmMfPSFIkV2dbhg@tissot.1015granger.net>
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

On Tue, 2023-08-01 at 18:51 -0400, Chuck Lever wrote:
> On Wed, Aug 02, 2023 at 08:26:15AM +1000, NeilBrown wrote:
> > On Tue, 01 Aug 2023, Jeff Layton wrote:
> > > I noticed that xfstests generic/001 was failing against linux-next nf=
sd.
> > >=20
> > > The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the ser=
ver
> > > would hand out a write delegation. The client would then try to use t=
hat
> > > write delegation as the source stateid in a COPY or CLONE operation, =
and
> > > the server would respond with NFS4ERR_STALE.
> > >=20
> > > The problem is that the struct file associated with the delegation do=
es
> > > not necessarily have read permissions. It's handing out a write
> > > delegation on what is effectively an O_WRONLY open. RFC 8881 states:
> > >=20
> > >  "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on i=
ts
> > >   own, all opens."
> > >=20
> > > Given that the client didn't request any read permissions, and that n=
fsd
> > > didn't check for any, it seems wrong to give out a write delegation.
> > >=20
> > > Only hand out a write delegation if we have a O_RDWR descriptor
> > > available. If it fails to find an appropriate write descriptor, go
> > > ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
> > > requested.
> > >=20
> > > This fixes xfstest generic/001.
> > >=20
> > > Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D412
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > Changes in v2:
> > > - Rework the logic when finding struct file for the delegation. The
> > >   earlier patch might still have attached a O_WRONLY file to the dele=
g
> > >   in some cases, and could still have handed out a write delegation o=
n
> > >   an O_WRONLY OPEN request in some cases.
> > > ---
> > >  fs/nfsd/nfs4state.c | 29 ++++++++++++++++++-----------
> > >  1 file changed, 18 insertions(+), 11 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index ef7118ebee00..e79d82fd05e7 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open *open, st=
ruct nfs4_ol_stateid *stp,
> > >  	struct nfs4_file *fp =3D stp->st_stid.sc_file;
> > >  	struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
> > >  	struct nfs4_delegation *dp;
> > > -	struct nfsd_file *nf;
> > > +	struct nfsd_file *nf =3D NULL;
> > >  	struct file_lock *fl;
> > >  	u32 dl_type;
> > > =20
> > > @@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_open *open, =
struct nfs4_ol_stateid *stp,
> > >  	if (fp->fi_had_conflict)
> > >  		return ERR_PTR(-EAGAIN);
> > > =20
> > > -	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> > > -		nf =3D find_writeable_file(fp);
> > > +	/*
> > > +	 * Try for a write delegation first. We need an O_RDWR file
> > > +	 * since a write delegation allows the client to perform any open
> > > +	 * from its cache.
> > > +	 */
> > > +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D NFS4_SH=
ARE_ACCESS_BOTH) {
> > > +		nf =3D nfsd_file_get(fp->fi_fds[O_RDWR]);
> >=20
> > This doesn't take fp->fi_lock before accessing ->fi_fds[], while the
> > find_readable_file() call below does.
>=20
> Note that the code it replaces (find_writeable_file) takes the fi_lock,
> so that seems like an important omission.
>=20

Yes, you and Neil are correct. We need the lock there. I'll respin the
patch, re-test and resend soon (once I sort out an issue with my test
setup).

> I noticed this earlier, but I was anxious to test whether this fix is
> on the right path. So far, NFSv4.2 behavior seems much improved. And,
> I like the new comments.
>=20
>=20
> > This inconsistency suggests a bug?
> >=20
> > Maybe the provided API is awkward.  Should we have=20
> > find_suitable_file() and find_suitable_file_locked()
> > that gets passed an nfs4_file and an O_MODE?
> > It tries the given mode, then O_RDWR
> >=20
> > NeilBrown
> >=20
> >=20
> > >  		dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> > > -	} else {
> > > +	}
> > > +
> > > +	/*
> > > +	 * If the file is being opened O_RDONLY or we couldn't get a O_RDWR
> > > +	 * file for some reason, then try for a read deleg instead.
> > > +	 */
> > > +	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
> > >  		nf =3D find_readable_file(fp);
> > >  		dl_type =3D NFS4_OPEN_DELEGATE_READ;
> > >  	}
> > > -	if (!nf) {
> > > -		/*
> > > -		 * We probably could attempt another open and get a read
> > > -		 * delegation, but for now, don't bother until the
> > > -		 * client actually sends us one.
> > > -		 */
> > > +
> > > +	if (!nf)
> > >  		return ERR_PTR(-EAGAIN);
> > > -	}
> > > +
> > >  	spin_lock(&state_lock);
> > >  	spin_lock(&fp->fi_lock);
> > >  	if (nfs4_delegation_exists(clp, fp))
> > >=20
> > > ---
> > > base-commit: a734662572708cf062e974f659ae50c24fc1ad17
> > > change-id: 20230731-wdeleg-bbdb6b25a3c6
> > >=20
> > > Best regards,
> > > --=20
> > > Jeff Layton <jlayton@kernel.org>
> > >=20
> > >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
