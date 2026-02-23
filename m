Return-Path: <linux-nfs+bounces-19134-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKJxCaJjnGkoFgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19134-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 15:26:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 968AB177FA5
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 15:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A79F3053B99
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31BB17BA6;
	Mon, 23 Feb 2026 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYfYpKeT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2B175A5
	for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856610; cv=none; b=F7lpKyE7gReAFf2bL8FLdnomflazfls8GAe+yTif4+Vv2c/nwXcqJse4jf9NHBDimNvvIVW4lG67BfkEdidQ9+xX2/bZC3stASRYWrqaM1RlEnN1fKIM3dVBIZaKsIPc7lW4NRrBDNtEB74PLEukwuJv0fOrzeakJqrEejp6DQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856610; c=relaxed/simple;
	bh=kXFgEMK0421eKAGKufdusXkq2dLuB92KcX3zIrNVRSs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JaOKdTkK+oRUHmc0nLroxjk2niEGYAu3yK7cs0uWN319Y4JPxdS4xBWbA0ln8LdbkCgdH9ZDT0aeH0ldmR8lo3cdZdyYsR7uDMReor9OowCCSCBFgUNNGEeWuNBBcUGOgPkOso0lVSptlcOXEWpPUclCw7kQ5HZVQ/37CLnQyo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYfYpKeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B6CC116C6;
	Mon, 23 Feb 2026 14:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771856610;
	bh=kXFgEMK0421eKAGKufdusXkq2dLuB92KcX3zIrNVRSs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XYfYpKeTlgw8kWkw4XNxYcC2uDEVGx7f4kXW/TQS67KT3m5QoxcThkGf32gFHsTEe
	 +OJpncY1v3WCWnipmlgCma0M1Iv23yQwKnTEdx3FJ0gOny0BI0DzqbWee46RLe2W53
	 veJpNWOLZHhwCEx4/70dJvQ2LjrDQ39rz6IJo3XJTgnsVCxOWDVDmm7Bls4m73/MBt
	 Rwn5V62LqAZHy1wANOlhfvzNA+z3SoeHYbuflvJhGL3g0kezoavRdnh/M5d4Tg9fFn
	 9cSs2qvfZbsTpAZIpZb0lL62mIUFtLlg3Fpl6dou8GQ6XW0ORWokIVuu10iLazsgmj
	 1nbDyxAhSflhQ==
Message-ID: <84bbbe173485c6cbd0af9169e55717be0aa0e367.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: Expose callback statistics in
 /proc/net/rpc/nfsd
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <cel@kernel.org>, Chuck Lever	
 <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga Kornievskaia	
 <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>, Christoph Hellwig
 <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
Date: Mon, 23 Feb 2026 09:23:28 -0500
In-Reply-To: <831ee3d3-4d5d-4b63-80e6-51d1e5907666@oracle.com>
References: <20260221215733.3643669-1-dai.ngo@oracle.com>
	 <8d11898b-9889-43b5-bb96-445870367949@app.fastmail.com>
	 <831ee3d3-4d5d-4b63-80e6-51d1e5907666@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19134-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 968AB177FA5
X-Rspamd-Action: no action

On Sun, 2026-02-22 at 13:18 -0800, Dai Ngo wrote:
> On 2/21/26 2:57 PM, Chuck Lever wrote:
> > Hello Dai!
> >=20
> > On Sat, Feb 21, 2026, at 4:57 PM, Dai Ngo wrote:
> > > Extend /proc/net/rpc/nfsd output to report NFSv4 callback activity:
> > >=20
> > > . Add system-wide counters for each callback operation.
> > > . Add per-client callback operation statistics, similar to mountstats=
(8)
> > >    raw format.
> > The commit message needs to justify why you are modifying a legacy
> > /proc interface.
>=20
> Oh I did not know /proc is a legacy interface. What is the proper
> way to display nfsd statistics?
>=20

We have a new netlink commands for nfsd that give us request status. It
would be good to either extend that or add a new command that allows
statistics.=C2=A0 Netlink is much better suited for this since it's a lot
easier to extend than dealing with procfiles.


> >   I assume it is because you want these metrics to
> > appear in an existing NFS administrative tool like nfsstat ?
>=20
> I should have made this clearer in the commit message.
>=20
> nfsd already maintains backchannel statistics, but there's currently
> no convenient way to view them during normal operation - developers
> typically have to inspect a vmcore.
>=20
> This patch addresses that gap by adding the backchannel statistics to
> the existing output of /proc/net/rpc/nfsd.
>=20
> At this time, I don't plan to extend nfsstat(8) to report these statistic=
s,
> as this patch is intended for developer use only.
>=20

Even more reason to use netlink then.

>=20
> >=20
> >=20
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >   fs/nfsd/nfs4callback.c | 33 ++++++++++++++++++++++++++++++++-
> > >   fs/nfsd/nfsd.h         |  1 +
> > >   fs/nfsd/stats.c        |  2 ++
> > >   3 files changed, 35 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > index e00b2aea8da2..5d6c91b2da24 100644
> > > --- a/fs/nfsd/nfs4callback.c
> > > +++ b/fs/nfsd/nfs4callback.c
> > > @@ -36,6 +36,7 @@
> > >   #include <linux/sunrpc/xprt.h>
> > >   #include <linux/sunrpc/svc_xprt.h>
> > >   #include <linux/slab.h>
> > > +#include <linux/sunrpc/metrics.h>
> > >   #include "nfsd.h"
> > >   #include "state.h"
> > >   #include "netns.h"
> > > @@ -1016,7 +1017,7 @@ static int nfs4_xdr_dec_cb_offload(struct rpc_r=
qst *rqstp,
> > >   	.p_decode  =3D nfs4_xdr_dec_##restype,				\
> > >   	.p_arglen  =3D NFS4_enc_##argtype##_sz,				\
> > >   	.p_replen  =3D NFS4_dec_##restype##_sz,				\
> > > -	.p_statidx =3D NFSPROC4_CB_##call,				\
> > > +	.p_statidx =3D NFSPROC4_CLNT_##proc,				\
> > >   	.p_name    =3D #proc,						\
> > >   }
> > >=20
> > > @@ -1786,3 +1787,33 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
> > >   		nfsd41_cb_inflight_end(clp);
> > >   	return queued;
> > >   }
> > > +
> > > +void nfsd4_show_cb_stats(struct nfsd_net *nn, struct seq_file *seq)
> > > +{
> > > +	const struct rpc_procinfo *pinfo;
> > > +	const struct rpc_version *ver;
> > > +	struct nfs4_client *clp;
> > > +	int ix;
> > > +
> > > +	/* display system-wide status, count per op */
> > > +	ver =3D cb_program.version[1];
> > > +	for (ix =3D 0; ix < ver->nrprocs; ix++) {
> > > +		pinfo =3D &ver->procs[ix];
> > > +		if (pinfo->p_name)
> > > +			seq_printf(seq, "%s: %d\n",
> > > +				pinfo->p_name, ver->counts[pinfo->p_statidx]);
> > > +	}
> > > +
> > > +	/* display per-client status, similar to mountstats(8) in raw forma=
t */
> > > +	spin_lock(&nn->client_lock);
> > > +	for (ix =3D 0; ix < CLIENT_HASH_SIZE; ix++) {
> > > +		list_for_each_entry(clp, &nn->conf_id_hashtbl[ix], cl_idhash) {
> > > +			if (!clp->cl_cb_client)
> > > +				continue;
> > > +			seq_printf(seq, "\nClient[%pISpc]:\n",
> > > +					(struct sockaddr *)&clp->cl_addr);
> > > +			rpc_clnt_show_stats(seq, clp->cl_cb_client);
> > > +		}
> > > +	}
> > > +	spin_unlock(&nn->client_lock);
> > > +}
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index 7c009f07c90b..cec0c6167ddb 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -591,6 +591,7 @@ extern void nfsd4_ssc_init_umount_work(struct nfs=
d_net *nn);
> > >   #endif
> > >=20
> > >   extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> > > +void nfsd4_show_cb_stats(struct nfsd_net *nn, struct seq_file *seq);
> > >=20
> > >   #else /* CONFIG_NFSD_V4 */
> > >   static inline int nfsd4_is_junction(struct dentry *dentry)
> > > diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
> > > index f7eaf95e20fc..cc601719ef26 100644
> > > --- a/fs/nfsd/stats.c
> > > +++ b/fs/nfsd/stats.c
> > > @@ -66,6 +66,8 @@ static int nfsd_show(struct seq_file *seq, void *v)
> > >   		percpu_counter_sum_positive(&nn->counter[NFSD_STATS_WDELEG_GETATT=
R]));
> > >=20
> > >   	seq_putc(seq, '\n');
> > > +
> > > +	nfsd4_show_cb_stats(nn, seq);
> > >   #endif
> > >=20
> > >   	return 0;
> > > --=20
> > > 2.47.3

--=20
Jeff Layton <jlayton@kernel.org>

