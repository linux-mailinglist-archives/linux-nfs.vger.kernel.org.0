Return-Path: <linux-nfs+bounces-19433-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK9kI4P1oWkwxgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19433-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 20:50:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8B91BD172
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 20:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C82713019C91
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 19:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1830246AEDE;
	Fri, 27 Feb 2026 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpctUt5x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89404611CE
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221543; cv=none; b=goDUSUVqmm05JmVL/JgLUp6OQtnk8zvk/jk8MKyeAWXEXhMWLzxXK0bSWd6/OBi+MYkQliU1OevugcXVAxZ4gu6v/1WnnOCGvp+8tbxT4iUZKaaLcpqRCxrIEe5c8+aEhBBJpkrhMB1y0/Ux9zrWdXbP2SBWEODY+fCzTKyVVRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221543; c=relaxed/simple;
	bh=16ZI5eGEORJ5fn9I0Si9ijRN2DBmLAMbo+kRF2J4iNQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1PsRqX57l6HjnEU4XBZ5Bfne3TVd+N8gUlOkERXeDztl63UOJ59g/WOhNNcdKH/62dcECNyJKqVB/TjipQpI8oRfp324EhNvmWcwZuNELBqBm+KupPRSmB/8Xcy6sPtzkxtAvP0y1Q3c5s8utT/yaperbMY3AKDNX4mRlC7kwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpctUt5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA21AC116C6;
	Fri, 27 Feb 2026 19:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772221542;
	bh=16ZI5eGEORJ5fn9I0Si9ijRN2DBmLAMbo+kRF2J4iNQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QpctUt5xIOXMKt5cchuDsto7D+3ArjWoP81IsbnRhvejii4NmblJHItnQG1pNFixV
	 Iz5fUE2OrCJsgnn/SLvjv5Soc3g2i0k8v1QWxcPeLqvumWzzSXX5X3O+zv+9fg1nK4
	 D2gfmZySdCHMYrrhhj/8Dbr7YHMJqVHG5CGBxd0KKLELlQaQGvRQ1ATXwPBwd3AZH9
	 atUcAUrQ+SwosKJnOiLjTzgmvPBG5PPJsyjItoZUkTzKN8PbO+56q+Pi7HeHN+hNYd
	 QQgk4ceRZAZ5EQbnkX0B4NmDJADaGly7L+y82kT6mFMelgPGPCsJ2riTauWV/MGRhy
	 z+I1E5Ys2xDRQ==
Message-ID: <7ce6c46bef16d20f6e8ae8da1576b1a765cea1ca.camel@kernel.org>
Subject: Re: [PATCH v5 1/1] NFSD: move accumulated callback ops to per-net
 namespace
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, Dai Ngo <dai.ngo@oracle.com>, Chuck Lever	
 <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga Kornievskaia	
 <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>, Christoph Hellwig
 <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
Date: Fri, 27 Feb 2026 14:45:39 -0500
In-Reply-To: <77566649-f3ea-445e-a85a-afa1235ac9e1@kernel.org>
References: <20260226193611.1038076-1-dai.ngo@oracle.com>
	 <a4bf76dc-2805-415e-be50-5501ea1ebf9a@app.fastmail.com>
	 <e4b79d8b-ff77-4e1c-b2c6-8408b8310c5f@oracle.com>
	 <77566649-f3ea-445e-a85a-afa1235ac9e1@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19433-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: EE8B91BD172
X-Rspamd-Action: no action

On Fri, 2026-02-27 at 14:21 -0500, Chuck Lever wrote:
> On 2/27/26 1:20 PM, Dai Ngo wrote:
> >=20
> > On 2/27/26 7:56 AM, Chuck Lever wrote:
> > >=20
> > > On Thu, Feb 26, 2026, at 2:35 PM, Dai Ngo wrote:
> > > > Track accumulated callback operations on a per-network-namespace ba=
sis
> > > > instead of globally, ensuring proper isolation and behavior when ru=
nning
> > > > nfsd in containers.
> > > Where are the consumers of this information? "Subsequent patch"
> > > is an OK answer, but that should be indicated here in your patch
> > > description.
> >=20
> > Should I first expand the output of /proc/net/rpc/nfsd and then follow
> > up with a netlink-based implementation? Or are we trying to avoid addin=
g
> > anything new under /proc at this point?
>=20
> The current kernel-wide policy, as I understand it, is that subsystems
> are to avoid adding new items under /proc unless absolutely needed.
>=20

+1

Dealing with file-based interfaces for this sort of thing is a giant
PITA for userland. Netlink is a much cleaner interface to deal with. No
partial reads of the file, etc...

> I believe nfsdctl and the NFSD netlink protocol does not yet have an
> operation to retrieve statistics. Jeff can help you put that together.
>=20

There is a rpc-status-get command, but that's a bit different from what
this is adding. You'll probably want to add a new netlink command to
get these stats and a new set of attributes for them.

Have a look at Documentation/netlink/specs/nfsd.yaml. You'll want to
extend that and regenerate the headers and code, and then implement the
new commands.

For this, it might be best to first replicate the stats that
/proc/net/rpc/nfsd already provides to be accessible via netlink. Then
you could add support for the new stats you want to add. Then in
userland, you could extend nfsstat to attempt to use netlink first and
only fall back to /proc scraping if the command doesn't exist.

>=20
> > Also, is there currently any user-space utility that can extract nfsd
> > statistics via the netlink interface?
> >=20
> > -Dai
> >=20
> > >=20
> > >=20
> > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > ---
> > > > =C2=A0 fs/nfsd/netns.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 5 +++
> > > > =C2=A0 fs/nfsd/nfs4callback.c | 75 ++++++++++++++++++++++----------=
----------
> > > > =C2=A0 fs/nfsd/nfsctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 5 +++
> > > > =C2=A0 fs/nfsd/state.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 ++
> > > > =C2=A0 4 files changed, 52 insertions(+), 35 deletions(-)
> > > >=20
> > > > v2:
> > > > =C2=A0=C2=A0 . free memory allocated for nn->nfsd_cb_version4.count=
s in
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 nfsd_net_cb_stats_init() on error in nfsd_=
net_init().
> > > > v3:
> > > > =C2=A0=C2=A0 . reword commit message.
> > > > =C2=A0=C2=A0 . fix initialization of nn->nfsd_cb_program.nrvers.
> > > > v4:
> > > > =C2=A0=C2=A0 . fix merge conflict in nfsd_net_exit in nfsd-testing =
branch.
> > > > v5:
> > > > =C2=A0=C2=A0 . restore commit message to the original in v1
> > > >=20
> > > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > > index 6ad3fe5d7e12..c101bf2c24c2 100644
> > > > --- a/fs/nfsd/netns.h
> > > > +++ b/fs/nfsd/netns.h
> > > > @@ -228,6 +228,11 @@ struct nfsd_net {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head=C2=A0=C2=A0=C2=A0 l=
ocal_clients;
> > > > =C2=A0 #endif
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 siphash_key_t=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 *fh_key;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 struct rpc_version=C2=A0=C2=A0=C2=A0 nfsd_cb_ve=
rsion4;
> > > > +=C2=A0=C2=A0=C2=A0 const struct rpc_version *nfsd_cb_versions[2];
> > > I know this is copy-paste of existing code, but can you find a
> > > proper symbolic constant to use here instead of "2" ?
> > >=20
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0 struct rpc_program=C2=A0=C2=A0=C2=A0 nfsd_cb_pr=
ogram;
> > > > +=C2=A0=C2=A0=C2=A0 struct rpc_stat=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 nfsd_cb_stat;
> > > > =C2=A0 };
> > > >=20
> > > > =C2=A0 /* Simple check to find out if a given net was properly init=
ialized */
> > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > > index aea8bdd2fdc4..759f24657c34 100644
> > > > --- a/fs/nfsd/nfs4callback.c
> > > > +++ b/fs/nfsd/nfs4callback.c
> > > > @@ -1016,7 +1016,7 @@ static int nfs4_xdr_dec_cb_offload(struct
> > > > rpc_rqst *rqstp,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .p_decode=C2=A0 =3D nfs4_xdr_dec_##r=
estype,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .p_arglen=C2=A0 =3D NFS4_enc_##argty=
pe##_sz,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .p_replen=C2=A0 =3D NFS4_dec_##resty=
pe##_sz,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > > -=C2=A0=C2=A0=C2=A0 .p_statidx =3D NFSPROC4_CB_##call,=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
> > > > +=C2=A0=C2=A0=C2=A0 .p_statidx =3D NFSPROC4_CLNT_##proc,=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .p_name=C2=A0=C2=A0=C2=A0 =3D #proc,=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > > =C2=A0 }
> > > Previously all compound-based callbacks mapped to statidx 1
> > > (NFSPROC4_CB_COMPOUND); now each operation gets its own counter
> > > slot (values 0=E2=80=937). This changes what stats are reported, IIUC=
.
> > > So bundling it here means a bisect on a stats regression cannot
> > > isolate when accounting changed, and reverting either change
> > > forces reverting both.
> > >=20
> > > IMO this should be a pre-requisite commit with its own
> > > rationale.
> > >=20
> > >=20
> > > > @@ -1032,40 +1032,7 @@ static const struct rpc_procinfo
> > > > nfs4_cb_procedures[] =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PROC(CB_GETATTR,=C2=A0=C2=A0=C2=A0 C=
OMPOUND,=C2=A0=C2=A0=C2=A0 cb_getattr,=C2=A0=C2=A0=C2=A0 cb_getattr),
> > > > =C2=A0 };
> > > >=20
> > > > -static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)]=
;
> > > > -static const struct rpc_version nfs_cb_version4 =3D {
> > > > -/*
> > > > - * Note on the callback rpc program version number: despite langua=
ge
> > > > in rfc
> > > > - * 5661 section 18.36.3 requiring servers to use 4 in this field, =
the
> > > > - * official xdr descriptions for both 4.0 and 4.1 specify version =
1,
> > > > and
> > > > - * in practice that appears to be what implementations use.=C2=A0 =
The
> > > > section
> > > > - * 18.36.3 language is expected to be fixed in an erratum.
> > > > - */
> > > > -=C2=A0=C2=A0=C2=A0 .number=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 1,
> > > > -=C2=A0=C2=A0=C2=A0 .nrprocs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D ARRAY_SIZE(nfs4_cb_procedures),
> > > > -=C2=A0=C2=A0=C2=A0 .procs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D nfs4_cb_procedures,
> > > > -=C2=A0=C2=A0=C2=A0 .counts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D nfs4_cb_counts,
> > > > -};
> > > > -
> > > > -static const struct rpc_version *nfs_cb_version[2] =3D {
> > > > -=C2=A0=C2=A0=C2=A0 [1] =3D &nfs_cb_version4,
> > > > -};
> > > > -
> > > > -static const struct rpc_program cb_program;
> > > > -
> > > > -static struct rpc_stat cb_stats =3D {
> > > > -=C2=A0=C2=A0=C2=A0 .program=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D &cb_program
> > > > -};
> > > > -
> > > > =C2=A0 #define NFS4_CALLBACK 0x40000000
> > > > -static const struct rpc_program cb_program =3D {
> > > > -=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D "nfs4_cb",
> > > > -=C2=A0=C2=A0=C2=A0 .number=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D NFS4_CALLBACK,
> > > > -=C2=A0=C2=A0=C2=A0 .nrvers=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D ARRAY_SIZE(nfs_cb_version),
> > > > -=C2=A0=C2=A0=C2=A0 .version=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D nfs_cb_version,
> > > > -=C2=A0=C2=A0=C2=A0 .stats=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &cb_stats,
> > > > -=C2=A0=C2=A0=C2=A0 .pipe_dir_name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D "nfsd4_cb",
> > > > -};
> > > >=20
> > > > =C2=A0 static int max_cb_time(struct net *net)
> > > > =C2=A0 {
> > > > @@ -1152,14 +1119,15 @@ static int setup_callback_client(struct
> > > > nfs4_client *clp, struct nfs4_cb_conn *c
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .addrsize=C2=
=A0=C2=A0=C2=A0 =3D conn->cb_addrlen,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .saddress=C2=
=A0=C2=A0=C2=A0 =3D (struct sockaddr *) &conn->cb_saddr,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .timeout=C2=
=A0=C2=A0=C2=A0 =3D &timeparms,
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .program=C2=A0=C2=A0=C2=
=A0 =3D &cb_program,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .version=C2=
=A0=C2=A0=C2=A0 =3D 1,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .flags=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D (RPC_CLNT_CREATE_NOPING |
> > > > RPC_CLNT_CREATE_QUIET),
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cred=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D current_cred(),
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rpc_clnt *client;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cred *cred;
> > > > +=C2=A0=C2=A0=C2=A0 struct nfsd_net *nn =3D net_generic(clp->net, n=
fsd_net_id);
> > > Nit: Reverse Christmas tree ordering -- this new declaration
> > > belongs close to the top.
> > >=20
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0 args.program =3D &nn->nfsd_cb_program;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (clp->cl_minorversion =3D=3D 0) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!clp->cl=
_cred.cr_principal &&
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (clp->cl_cred.cr_flavor >=3D RPC_AUTH_GSS_KRB5)) {
> > > > @@ -1786,3 +1754,40 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd41_cb_in=
flight_end(clp);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return queued;
> > > > =C2=A0 }
> > > > +
> > > > +void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0 kfree(nn->nfsd_cb_version4.counts);
> > > > +}
> > > > +
> > > > +int nfsd_net_cb_stats_init(struct nfsd_net *nn)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0 nn->nfsd_cb_version4.counts =3D kzalloc_objs(un=
signed int,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ARRAY_SIZE(nfs4_cb_procedures), GFP_KERNEL);
> > > > +=C2=A0=C2=A0=C2=A0 if (!nn->nfsd_cb_version4.counts)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> > > > +=C2=A0=C2=A0=C2=A0 /*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Note on the callback rpc program versio=
n number: despite
> > > > language
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * in rfc 5661 section 18.36.3 requiring s=
ervers to use 4 in this
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * field, the official xdr descriptions fo=
r both 4.0 and 4.1
> > > > specify
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * version 1, and in practice that appears=
 to be what
> > > > implementations
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * use. The section 18.36.3 language is ex=
pected to be fixed in an
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * erratum.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0 nn->nfsd_cb_version4.number =3D 1;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 nn->nfsd_cb_version4.nrprocs =3D ARRAY_SIZE(nfs=
4_cb_procedures);
> > > > +=C2=A0=C2=A0=C2=A0 nn->nfsd_cb_version4.procs =3D nfs4_cb_procedur=
es;
> > > > +=C2=A0=C2=A0=C2=A0 nn->nfsd_cb_versions[1] =3D &nn->nfsd_cb_versio=
n4;
> > > Could you add a comment explaining that slot 0 is intentionally
> > > NULL and slot 1 corresponds to the CB protocol version number?
> > > The original designated-initializer syntax made this self-
> > > evident; the replacement imperative assignment here does not.
> > >=20
> > >=20
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 memset(&nn->nfsd_cb_stat, 0, sizeof(nn->nfsd_cb=
_stat));
> > > > +=C2=A0=C2=A0=C2=A0 nn->nfsd_cb_program.name =3D "nfs4_cb";
> > > > +=C2=A0=C2=A0=C2=A0 nn->nfsd_cb_program.number =3D NFS4_CALLBACK;
> > > > +=C2=A0=C2=A0=C2=A0 nn->nfsd_cb_program.nrvers =3D ARRAY_SIZE(nn->n=
fsd_cb_versions);
> > > > +=C2=A0=C2=A0=C2=A0 nn->nfsd_cb_program.version =3D &nn->nfsd_cb_ve=
rsions[0];
> > > > +=C2=A0=C2=A0=C2=A0 nn->nfsd_cb_program.pipe_dir_name =3D "nfsd4_cb=
";
> > > > +=C2=A0=C2=A0=C2=A0 nn->nfsd_cb_program.stats =3D &nn->nfsd_cb_stat=
;
> > > > +=C2=A0=C2=A0=C2=A0 nn->nfsd_cb_stat.program =3D &nn->nfsd_cb_progr=
am;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 return 0;
> > > > +}
> > > New non-static functions should get kernel-doc comments.
> > >=20
> > >=20
> > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > index 032ab44feb70..5daa647ef0fa 100644
> > > > --- a/fs/nfsd/nfsctl.c
> > > > +++ b/fs/nfsd/nfsctl.c
> > > > @@ -2216,6 +2216,9 @@ static __net_init int nfsd_net_init(struct ne=
t
> > > > *net)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int retval;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0 retval =3D nfsd_net_cb_stats_init(nn);
> > > > +=C2=A0=C2=A0=C2=A0 if (retval)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return retval;
> > > Does this build if CONFIG_NFSD_V4 is not enabled?
> > >=20
> > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retval =3D nfsd_export_init(net);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (retval)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_exp=
ort_error;
> > > > @@ -2256,6 +2259,7 @@ static __net_init int nfsd_net_init(struct ne=
t
> > > > *net)
> > > > =C2=A0 out_idmap_error:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_export_shutdown(net);
> > > > =C2=A0 out_export_error:
> > > > +=C2=A0=C2=A0=C2=A0 nfsd_net_cb_stats_shutdown(nn);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return retval;
> > > > =C2=A0 }
> > > >=20
> > > > @@ -2286,6 +2290,7 @@ static __net_exit void nfsd_net_exit(struct n=
et
> > > > *net)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_net *nn =3D net_generic(=
net, nfsd_net_id);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree_sensitive(nn->fh_key);
> > > > +=C2=A0=C2=A0=C2=A0 nfsd_net_cb_stats_shutdown(nn);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_proc_stat_shutdown(net);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 percpu_counter_destroy_many(nn->coun=
ter, NFSD_STATS_COUNTERS_NUM);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_idmap_shutdown(net);
> > > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > > index 9b05462da4cc..490193c1877d 100644
> > > > --- a/fs/nfsd/state.h
> > > > +++ b/fs/nfsd/state.h
> > > > @@ -895,4 +895,6 @@ struct nfsd4_get_dir_delegation;
> > > > =C2=A0 struct nfs4_delegation *nfsd_get_dir_deleg(struct
> > > > nfsd4_compound_state *cstate,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct nfsd4_get_dir_delegation *gdd,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct nfsd_file *nf);
> > > > +int nfsd_net_cb_stats_init(struct nfsd_net *nn);
> > > > +void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn);
> > > > =C2=A0 #endif=C2=A0=C2=A0 /* NFSD4_STATE_H */
> > > > --=C2=A0
> > > > 2.47.3
>=20

--=20
Jeff Layton <jlayton@kernel.org>

