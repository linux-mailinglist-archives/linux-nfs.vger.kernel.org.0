Return-Path: <linux-nfs+bounces-3674-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE442904971
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 05:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F501F24780
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 03:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A79257D;
	Wed, 12 Jun 2024 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V0HR9TJS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K68Vr3VW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V0HR9TJS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K68Vr3VW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8241FA1
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162235; cv=none; b=NGUUg3X8xYR/9nSy4vtHXVKZ8nw+SG78oCTs458Iq1S0ZenKBQpz8VCCdifihtA0HVNreRS5ugfd9BvsytCHBz7Lu4w2s87QgE4PoR/GayR7HLqDW73a5J8nScknwLPsTAPA4itd/WjIFYKtSaNEe6PQNXAuafjntmYRw38kwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162235; c=relaxed/simple;
	bh=26h32mF365po8TkxchgFSEOyXqNwCQ6KyCG0U5udTkw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=s+jF3lysCfK6rWVZHqI5Hxi9KG7Zn0E8m2fWrlg52SVdF884is6LoPQmNuTek1C+VDgkwRvXpTbpArYAby11HtU7rgx9GY6ntm0GT4hnz3kKWDer5SkLQVlu9cKPxAnnrzfsm132eeK2xBkNkHyA3824FaZzivu0nNDLPXOLhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V0HR9TJS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K68Vr3VW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V0HR9TJS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K68Vr3VW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0A4720E85;
	Wed, 12 Jun 2024 03:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718162231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3QZsimHj960s5+ij0vgOONGXiA73gmE24xf2stvIP8=;
	b=V0HR9TJS00HBY5YrttRmzk8MgBzlkeLj7prZJ6lbbLHaOwMr+F7ma32CfR6S2p7WP7K9ew
	m6gVp+E1s3cAl9qYitXVF5+lKZiE+H75NqghZoOZ6vyPDR3deEu/wLM0iiOAW4+ob3wE12
	azuixV38kv3e4VRC40BeBJAHfxLeOWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718162231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3QZsimHj960s5+ij0vgOONGXiA73gmE24xf2stvIP8=;
	b=K68Vr3VWuo/GHVf/Auj40fPiKdIevrOZq3Sl0GKTjr4MneifQrQ0tMIjlZ808jE/3/FhnL
	cmqanjq8XgzzocAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718162231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3QZsimHj960s5+ij0vgOONGXiA73gmE24xf2stvIP8=;
	b=V0HR9TJS00HBY5YrttRmzk8MgBzlkeLj7prZJ6lbbLHaOwMr+F7ma32CfR6S2p7WP7K9ew
	m6gVp+E1s3cAl9qYitXVF5+lKZiE+H75NqghZoOZ6vyPDR3deEu/wLM0iiOAW4+ob3wE12
	azuixV38kv3e4VRC40BeBJAHfxLeOWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718162231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3QZsimHj960s5+ij0vgOONGXiA73gmE24xf2stvIP8=;
	b=K68Vr3VWuo/GHVf/Auj40fPiKdIevrOZq3Sl0GKTjr4MneifQrQ0tMIjlZ808jE/3/FhnL
	cmqanjq8XgzzocAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04693137DF;
	Wed, 12 Jun 2024 03:17:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1rdxJjQTaWYVDwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 03:17:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [for-6.11 PATCH 10/29] nfs/nfsd: add "local io" support
In-reply-to: <ZmkHNr5jtGHDpko_@kernel.org>
References: <>, <ZmkHNr5jtGHDpko_@kernel.org>
Date: Wed, 12 Jun 2024 13:17:05 +1000
Message-id: <171816222529.14261.9832643931623454806@noble.neil.brown.name>
X-Spam-Score: -4.28
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.18)[-0.884];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,hammerspace.com:email,primarydata.com:email]

On Wed, 12 Jun 2024, Mike Snitzer wrote:
> On Mon, Jun 10, 2024 at 12:42:54PM -0400, Mike Snitzer wrote:
> > On Mon, Jun 10, 2024 at 08:43:34AM -0400, Jeff Layton wrote:
> > > On Fri, 2024-06-07 at 10:26 -0400, Mike Snitzer wrote:
> > > > From: Weston Andros Adamson <dros@primarydata.com>
> > > >=20
> > > > Add client support for bypassing NFS for localhost reads, writes, and=
 commits.
> > > >=20
> > > > This is only useful when the client and the server are running on the=
 same
> > > > host and in the same container.
> > > >=20
> > > > This has dynamic binding with the nfsd module. Local i/o will only wo=
rk if
> > > > nfsd is already loaded.
> > > >=20
> > > > [snitm: rebase accounted for commit d8b26071e65e8 ("NFSD: simplify st=
ruct nfsfh")
> > > > =C2=A0and commit 7c98f7cb8fda ("remove call_{read,write}_iter() funct=
ions")]
> > > >=20
> > > > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > > > Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
> > > > Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> > > > Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> > > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ...
> > > > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > > > new file mode 100644
> > > > index 000000000000..ff68454a4017
> > > > --- /dev/null
> > > > +++ b/fs/nfsd/localio.c
> > > > @@ -0,0 +1,179 @@
> > > > +/*
> > > > + * NFS server support for local clients to bypass network stack
> > > > + *
> > > > + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> > > > + */
> > > > +
> > > > +#include <linux/exportfs.h>
> > > > +#include <linux/sunrpc/svcauth_gss.h>
> > > > +#include <linux/sunrpc/clnt.h>
> > > > +#include <linux/nfs.h>
> > > > +#include <linux/string.h>
> > > > +
> > > > +#include "nfsd.h"
> > > > +#include "vfs.h"
> > > > +#include "netns.h"
> > > > +#include "filecache.h"
> > > > +
> > > > +#define NFSDDBG_FACILITY		NFSDDBG_FH
> > > > +
> > > > +static void
> > > > +nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
> > > > +{
> > > > +	if (rqstp->rq_client)
> > > > +		auth_domain_put(rqstp->rq_client);
> > > > +	if (rqstp->rq_cred.cr_group_info)
> > > > +		put_group_info(rqstp->rq_cred.cr_group_info);
> > > > +	kfree(rqstp->rq_cred.cr_principal);
> > > > +	kfree(rqstp->rq_xprt);
> > > > +	kfree(rqstp);
> > > > +}
> > > > +
> > > > +static struct svc_rqst *
> > > > +nfsd_local_fakerqst_create(struct rpc_clnt *rpc_clnt, const struct c=
red *cred)
> > > > +{
> > > > +	struct svc_rqst *rqstp;
> > > > +	struct net *net =3D rpc_net_ns(rpc_clnt);
> > > > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > > > +	int status;
> > > > +
> > > > +	if (!nn->nfsd_serv) {
> > > > +		dprintk("%s: localio denied. Server not running\n", __func__);
> > > > +		return ERR_PTR(-ENXIO);
> > > > +	}
> > > > +
> > >=20
> > > Note that the above check is racy. The nfsd_serv can go away at any
> > > time since you're not holding the (global) nfsd_mutex (I assume?).
> >=20
> > Yes, worst case we should fallback to going over the network.
>=20
> Actual worst case is we could crash... ;)
>=20
> > > > +	rqstp =3D kzalloc(sizeof(*rqstp), GFP_KERNEL);
> > > > +	if (!rqstp)
> > > > +		return ERR_PTR(-ENOMEM);
> > > > +
> > > > +	rqstp->rq_xprt =3D kzalloc(sizeof(*rqstp->rq_xprt), GFP_KERNEL);
> > > > +	if (!rqstp->rq_xprt) {
> > > > +		status =3D -ENOMEM;
> > > > +		goto out_err;
> > > > +	}
> > > > +
> > > > +	rqstp->rq_xprt->xpt_net =3D net;
> > > > +	__set_bit(RQ_SECURE, &rqstp->rq_flags);
> > > > +	rqstp->rq_proc =3D 1;
> > > > +	rqstp->rq_vers =3D 3;
> > > > +	rqstp->rq_prot =3D IPPROTO_TCP;
> > > > +	rqstp->rq_server =3D nn->nfsd_serv;
> > > > +
> > >=20
> > > I suspect you need to carry a reference of some sort so that the
> > > nfsd_serv doesn't go away out from under you while this is running,
> > > since this is not operating in nfsd thread context.
> > >=20
> > > Typically, every nfsd thread holds a reference to the serv (in serv-
> > > >sv_nrthreads), so that when you shut down all of the threads, it goes
> > > away. The catch is that that refcount is currently under the protection
> > > of the global nfsd_mutex and I doubt you want to take that in this
> > > codepath.
> >=20
> > OK, I can look closer at the implications.
>=20
> SO I looked, and I'm saddened to see Neil's 6.8 commit 1e3577a4521e
> ("SUNRPC: discard sv_refcnt, and svc_get/svc_put").
>=20
> [the lack of useful refcounting with the current code kind of blew me
> away.. but nice to see it existed not too long ago.]
>=20
> Rather than immediately invest the effort to revert commit
> 1e3577a4521e for my apparent needs... I'll send out v2 to allow for
> further review and discussion.
>=20
> But it really does feel like I _need_ svc_{get,put} and nfsd_{get,put}

You are taking a reference, and at the right time.  But it is to the
wrong thing.
You call symbol_request(nfsd_open_local_fh) and so get a reference to
the nfsd module.  But you really want a reference to the nfsd service.

I would suggest that you use symbol_request() to get a function which
you then call and immediately symbol_put().... unless you need to use it
to discard the reference to the service later.
The function would take nfsd_mutex, check there is an nfsd_serv, sets a
flag or whatever to indicate the serv is being used for local_io, and
maybe returns the nfsd_serv.  As long as that flag is set the serv
cannot be destroy.

Do you need there to be available threads for LOCAL_IO to work?  If so
the flag would cause setting the num threads to zero to fail.
If not ....  that is weird.  It would mean that setting the number of
threads to zero would not destroy the service and I don't think we want
to do that.

So I think that when LOCAL_IO is in use, setting number of threads to
zero must return EBUSY or similar, even if you don't need the threads.

NeilBrown

