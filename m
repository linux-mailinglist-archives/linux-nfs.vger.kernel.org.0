Return-Path: <linux-nfs+bounces-4373-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7338891AE63
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 19:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D711F2983F
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB2B14C5AE;
	Thu, 27 Jun 2024 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y31x0NPx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D304C9A
	for <linux-nfs@vger.kernel.org>; Thu, 27 Jun 2024 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510329; cv=none; b=IEZBYBHNrMl3iQu8rBgLRLRjvAkDsFZc9Ap+S/QeSVFqxrbRsf6y08OANMi32Q6MpoDJK+lh7qgD4b8Pr7hsVdpCfviUQsdcWYnDqYjAR151bDpZpmXDkSU3IuQMXakAr0zb8qUADFcaUISadgqFjvzzLNUM/vriR+ZNyTVEVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510329; c=relaxed/simple;
	bh=vdHf0gEe1U6hYy5ghKJLlkrrD9TLkEUDVUZbK1aNzwA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uvm/vPSmqeHoauRGFGEz71zxjIqeJfYwst0FA8BZl33hzB4Dfy5b9Sivj4YAphRfiwTyCM94VfiIW/cC6qm2oBrF/VQ222LZkKBtwgjGKzxMwPuqscPaI+GycL+/01H/3O9FIWvbhkHePCpuuJsD9TEmfaBJs+psClL7thrQY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y31x0NPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF099C2BBFC;
	Thu, 27 Jun 2024 17:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719510328;
	bh=vdHf0gEe1U6hYy5ghKJLlkrrD9TLkEUDVUZbK1aNzwA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Y31x0NPx2Ct9PMFjvDdlTqYqsj821SbB1d0K3CyCZdXzZgVp1/9t35Uiz7Z3QNJnF
	 lMEvwSff/ie70RxdbBYSDMS1zBzXKKjb7HOMYku/3LOX+8SzG5jj4YAIz230HC1pG4
	 Uwi5X3T0r219g9igjV2Zr2APSL64CXNPK4rLd4TMTgstIOqVz6GMti3/9VX8mMR4sf
	 KEIP58gNYn5fWoDYGzN8fh3Oqf0VU9JD7gEJd6b4cFEdciiwx2gzFgddAXXdOnfhS/
	 Qps12Lor+GRO8DZGJZIdZDqM7Fdig9POIMh3r9Gv5FczrPmp+N7hPXsHeWyseQCHHm
	 IC018Yk/MUmXA==
Message-ID: <70a92bcf0e6ad3e7ef9fa96edf68d9cdb32e6a2e.camel@kernel.org>
Subject: Re: [PATCH v8 09/18] nfsd: use percpu_ref to interlock
 nfsd_destroy_serv and nfsd_open_local_fh
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, Trond
 Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 snitzer@hammerspace.com
Date: Thu, 27 Jun 2024 13:45:26 -0400
In-Reply-To: <Zn2d3L-JMZ1snvPH@kernel.org>
References: <20240626182438.69539-1-snitzer@kernel.org>
	 <20240626182438.69539-10-snitzer@kernel.org>
	 <bf414725b1ee06a03f766a2b1c976b71161570a2.camel@kernel.org>
	 <Zn2d3L-JMZ1snvPH@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-27 at 13:14 -0400, Mike Snitzer wrote:
> On Thu, Jun 27, 2024 at 07:24:54AM -0400, Jeff Layton wrote:
> > On Wed, 2024-06-26 at 14:24 -0400, Mike Snitzer wrote:
> > > Introduce nfsd_serv_get and nfsd_serv_put and update the nfsd
> > > code to
> > > prevent nfsd_destroy_serv from destroying nn->nfsd_serv until any
> > > client initiated localio calls to nfsd (that are _not_ in the
> > > context
> > > of nfsd) are complete.
> > >=20
> > > nfsd_open_local_fh is updated to nfsd_serv_get before opening its
> > > file
> > > handle and then drop the reference using nfsd_serv_put at the end
> > > of
> > > nfsd_open_local_fh.
> > >=20
> > > This "interlock" working relies heavily on nfsd_open_local_fh()'s
> > > maybe_get_net() safely dealing with the possibility that the
> > > struct
> > > net (and nfsd_net by association) may have been destroyed by
> > > nfsd_destroy_serv() via nfsd_shutdown_net().
> > >=20
> > > Verified to fix an easy to hit crash that would occur if an nfsd
> > > instance running in a container, with a localio client mounted,
> > > is
> > > shutdown. Upon restart of the container and associated nfsd the
> > > client
> > > would go on to crash due to NULL pointer dereference that
> > > occuured due
> > > to the nfs client's localio attempting to nfsd_open_local_fh(),
> > > using
> > > nn->nfsd_serv, without having a proper reference on nn-
> > > >nfsd_serv.
> > >=20
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > > =C2=A0fs/nfsd/localio.c |=C2=A0 2 ++
> > > =C2=A0fs/nfsd/netns.h=C2=A0=C2=A0 |=C2=A0 8 +++++++-
> > > =C2=A0fs/nfsd/nfssvc.c=C2=A0 | 39 +++++++++++++++++++++++++++++++++++=
++++
> > > =C2=A03 files changed, 48 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > > index 48118db801b5..819589ae2008 100644
> > > --- a/fs/nfsd/localio.c
> > > +++ b/fs/nfsd/localio.c
> > > @@ -204,6 +204,7 @@ int nfsd_open_local_fh(struct net *net,
> > > =C2=A0	}
> > > =C2=A0	nn =3D net_generic(net, nfsd_net_id);
> > > =C2=A0
> > > +	nfsd_serv_get(nn);
> > > =C2=A0	serv =3D READ_ONCE(nn->nfsd_serv);
> > > =C2=A0	if (unlikely(!serv)) {
> > > =C2=A0		dprintk("%s: localio denied. Server not
> > > running\n", __func__);
> > > @@ -244,6 +245,7 @@ int nfsd_open_local_fh(struct net *net,
> > > =C2=A0out_revertcred:
> > > =C2=A0	revert_creds(save_cred);
> > > =C2=A0out_net:
> > > +	nfsd_serv_put(nn);
> > > =C2=A0	put_net(net);
> > > =C2=A0	return status;
> > > =C2=A0}
> > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > index 0c5a1d97e4ac..17a73c780ca1 100644
> > > --- a/fs/nfsd/netns.h
> > > +++ b/fs/nfsd/netns.h
> > > @@ -13,6 +13,7 @@
> > > =C2=A0#include <linux/filelock.h>
> > > =C2=A0#include <linux/nfs4.h>
> > > =C2=A0#include <linux/percpu_counter.h>
> > > +#include <linux/percpu-refcount.h>
> > > =C2=A0#include <linux/siphash.h>
> > > =C2=A0#include <linux/sunrpc/stats.h>
> > > =C2=A0#include <linux/nfslocalio.h>
> > > @@ -140,7 +141,9 @@ struct nfsd_net {
> > > =C2=A0
> > > =C2=A0	struct svc_info nfsd_info;
> > > =C2=A0#define nfsd_serv nfsd_info.serv
> > > -
> > > +	struct percpu_ref nfsd_serv_ref;
> > > +	struct completion nfsd_serv_confirm_done;
> > > +	struct completion nfsd_serv_free_done;
> > > =C2=A0
> > > =C2=A0	/*
> > > =C2=A0	 * clientid and stateid data for construction of net
> > > unique COPY
> > > @@ -225,6 +228,9 @@ struct nfsd_net {
> > > =C2=A0extern bool nfsd_support_version(int vers);
> > > =C2=A0extern void nfsd_netns_free_versions(struct nfsd_net *nn);
> > > =C2=A0
> > > +void nfsd_serv_get(struct nfsd_net *nn);
> > > +void nfsd_serv_put(struct nfsd_net *nn);
> > > +
> > > =C2=A0extern unsigned int nfsd_net_id;
> > > =C2=A0
> > > =C2=A0void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net
> > > *nn);
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index a477d2c5088a..be5acb7a4057 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -258,6 +258,30 @@ int nfsd_minorversion(struct nfsd_net *nn,
> > > u32 minorversion, enum vers_op change
> > > =C2=A0	return 0;
> > > =C2=A0}
> > > =C2=A0
> > > +void nfsd_serv_get(struct nfsd_net *nn)
> > > +{
> > > +	percpu_ref_get(&nn->nfsd_serv_ref);
> > > +}
> > > +
> > > +void nfsd_serv_put(struct nfsd_net *nn)
> > > +{
> > > +	percpu_ref_put(&nn->nfsd_serv_ref);
> > > +}
> > > +
> > > +static void nfsd_serv_done(struct percpu_ref *ref)
> > > +{
> > > +	struct nfsd_net *nn =3D container_of(ref, struct nfsd_net,
> > > nfsd_serv_ref);
> > > +
> > > +	complete(&nn->nfsd_serv_confirm_done);
> > > +}
> > > +
> > > +static void nfsd_serv_free(struct percpu_ref *ref)
> > > +{
> > > +	struct nfsd_net *nn =3D container_of(ref, struct nfsd_net,
> > > nfsd_serv_ref);
> > > +
> > > +	complete(&nn->nfsd_serv_free_done);
> > > +}
> > > +
> > > =C2=A0/*
> > > =C2=A0 * Maximum number of nfsd processes
> > > =C2=A0 */
> > > @@ -462,6 +486,7 @@ static void nfsd_shutdown_net(struct net
> > > *net)
> > > =C2=A0		lockd_down(net);
> > > =C2=A0		nn->lockd_up =3D false;
> > > =C2=A0	}
> > > +	percpu_ref_exit(&nn->nfsd_serv_ref);
> > > =C2=A0#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> > > =C2=A0	list_del_rcu(&nn->nfsd_uuid.list);
> > > =C2=A0#endif
> > > @@ -544,6 +569,13 @@ void nfsd_destroy_serv(struct net *net)
> > > =C2=A0	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > > =C2=A0	struct svc_serv *serv =3D nn->nfsd_serv;
> > > =C2=A0
> > > +	lockdep_assert_held(&nfsd_mutex);
> > > +
> > > +	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref,
> > > nfsd_serv_done);
> > > +	wait_for_completion(&nn->nfsd_serv_confirm_done);
> > > +	wait_for_completion(&nn->nfsd_serv_free_done);
> > > +	/* percpu_ref_exit is called in nfsd_shutdown_net */
> > > +
> >=20
> > At this point where you're waiting on these completion vars, what
> > stops
> > the client from issuing new localio requests?
>=20
> The server going down.=C2=A0 The interlock is with nfsd_open_local_fh, so
> once any active file opens complete the server will get these
> completions and the server will go down.=C2=A0 The client will reconnect
> if/when the server comes back up.
>=20
> Maybe I'm not imaginative enough, but is there risk of never-ending
> overlapping file opens that prevent nfsd_destroy_serv() from
> progressing?
>=20

Yeah, I think it's a possibility, especially if the underlying
filesystem is particularly slow. You can probably solve that by just
not handing out new references somehow once you're going to call
percpu_ref_kill_and_confirm.

--=20
Jeff Layton <jlayton@kernel.org>

