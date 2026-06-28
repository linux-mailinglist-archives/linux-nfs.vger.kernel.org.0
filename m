Return-Path: <linux-nfs+bounces-22870-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CC8jEguPQWqYsAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22870-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jun 2026 23:15:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AE86D4F58
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jun 2026 23:15:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M7tgPV1w;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22870-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22870-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 287BD300C008
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jun 2026 21:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D381D9663;
	Sun, 28 Jun 2026 21:15:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD5C2765D7
	for <linux-nfs@vger.kernel.org>; Sun, 28 Jun 2026 21:15:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782681352; cv=none; b=YxKU+VctFEpYZ+GD1JtlBL7yXz13gfllwoBv6eOUBbmwrmS+jv4s/P5OBiOrAuFSotczXHqWoKNVfpg4rz+caCp9isFJQcrJYEE2rsGS6rwO8yoOIT5eLYCOk7f42J7U7M1lBABoBELj1g+DYigoXkuCYBTwtCVOoIZ3m4Zw7qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782681352; c=relaxed/simple;
	bh=bbbnl1Sz5UQM0naLMufHkE7oMuJxy/AQI0I0uOo9lS0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WY+hjOY0oTWVZGsFIT0tjdh824J428ZeOjoK1dSBgbe7yDpO3naUlK8NCvLnvWcNVn1toAaibwS0xW42jFjcVYbaY4DfMc8EwJk5VnWHtdEoVDL0sFui3k0h4G4AIHXU5yXHKh8/uw7ZW+XSM1rofH0MYVEqEiOVg/7oqSmA4eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7tgPV1w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A4E1F000E9;
	Sun, 28 Jun 2026 21:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782681351;
	bh=0Pg4dQLWEEQfrjoWunyFdRMfGWUIsC0VT+M4MKBkTus=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M7tgPV1wTfcEAorwoNX/z7g6HejacCtZCFU1Uah6yYQ6ujOKwgmeBuUeNDKovA9ll
	 sbD32QA8wjRWve4yGfmAKTNX0CFqMdE4aXhwUhJLNxBDfdxpCzJsI6CsTrD4aKnRb+
	 iPy08Bg/fJ4G5X7KetPkpjnKJhm5JKK3o7HwfqmsTSAe/O22YfCkPWyZgnO2WzVU6w
	 IK+50Rt+b8G/KIBp927qCe8F7PkES+I8Mk9wqXAKKdHj/VPkrAR28q956Eguy8Vrku
	 odNSRDwtkIdrBXifkzGf7guWHwDI5EK0b9N0teETW1SEeiSD337ebFNuEUkJl5wH/G
	 KxyEw6e1XUk7A==
Message-ID: <fb81ad5a850160daab7092a8289bc626862f6072.camel@kernel.org>
Subject: Re: [PATCH] [RFC] nfs4: inject process namespace into COMPOUND tag
From: Trond Myklebust <trondmy@kernel.org>
To: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>, chuck.lever@oracle.com, 
	jlayton@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Sun, 28 Jun 2026 17:15:42 -0400
In-Reply-To: <20260626151029.1516839-1-tigran.mkrtchyan@desy.de>
References: <20260626151029.1516839-1-tigran.mkrtchyan@desy.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tigran.mkrtchyan@desy.de,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22870-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85AE86D4F58

On Fri, 2026-06-26 at 17:10 +0200, Tigran Mkrtchyan wrote:
> On large shared machines often multiple jobs of a same user run in
> parallel. For debugging, it's usually impossible to identify requests
> coming from different processes.
>=20
> The batch systems like HTCondor or SLURM start every job in it's own
> namespace, thus passing namespace info to the server will help by
> debugging.
>=20
> 192.168.122.150 =E2=86=92 192.168.178.69 NFS 260 V4 Call GETATTR FH:
> 0xd5ffb2cb
> 192.168.178.69 =E2=86=92 192.168.122.150 NFS 324 V4 Reply (Call In 89)
> GETATTR
> 192.168.122.150 =E2=86=92 192.168.178.69 NFS 260 V4 Call GETATTR FH:
> 0xd0b0a44e
> 192.168.178.69 =E2=86=92 192.168.122.150 NFS 324 V4 Reply (Call In 95)
> GETATTR
> 192.168.122.150 =E2=86=92 192.168.178.69 NFS 268 V4 Call ACCESS FH:
> 0xd0b0a44e, [Check: RD LU MD XT DL XAR XAW XAL]
> 192.168.178.69 =E2=86=92 192.168.122.150 NFS 240 V4 Reply (Call In 101)
> ACCESS, [Allowed: RD LU MD XT DL XAR XAW XAL]
> 192.168.122.150 =E2=86=92 192.168.178.69 NFS 284 V4 Call READDIR FH:
> 0xd0b0a44e
> 192.168.178.69 =E2=86=92 192.168.122.150 NFS 664 V4 Reply (Call In 105)
> READDIR
> 192.168.122.150 =E2=86=92 192.168.178.69 NFS 284 V4 Call ns:4026532507
> GETATTR FH: 0xd67b66a5
> 192.168.178.69 =E2=86=92 192.168.122.150 NFS 340 V4 Reply (Call In 111)
> ns:4026532507 GETATTR
> 192.168.122.150 =E2=86=92 192.168.178.69 NFS 292 V4 Call ns:4026532507 AC=
CESS
> FH: 0xd67b66a5, [Check: RD LU MD XT DL XAR XAW XAL]
> 192.168.178.69 =E2=86=92 192.168.122.150 NFS 256 V4 Reply (Call In 117)
> ns:4026532507 ACCESS, [Access Denied: MD XT DL XAW], [Allowed: RD LU
> XAR XAL]
> 192.168.122.150 =E2=86=92 192.168.178.69 NFS 308 V4 Call ns:4026532507
> READDIR FH: 0xd67b66a5
> 192.168.178.69 =E2=86=92 192.168.122.150 NFS 200 V4 Reply (Call In 121)
> ns:4026532507 READDIR
>=20
> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
> ---
> =C2=A0fs/nfs/nfs4xdr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 24 +++++++++++++++++++-----
> =C2=A0include/linux/sunrpc/sched.h |=C2=A0 2 ++
> =C2=A0net/sunrpc/sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 6 ++++++
> =C2=A03 files changed, 27 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index c23c2eee1b5c..9c035c74a3b5 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -46,6 +46,7 @@
> =C2=A0#include <linux/kdev_t.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/utsname.h>
> +#include <linux/pid_namespace.h>
> =C2=A0#include <linux/sunrpc/clnt.h>
> =C2=A0#include <linux/sunrpc/msg_prot.h>
> =C2=A0#include <linux/sunrpc/gss_api.h>
> @@ -71,12 +72,8 @@ static void encode_layoutget(struct xdr_stream
> *xdr,
> =C2=A0static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst
> *req,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs4_layoutget_res *res);
> =C2=A0
> -/* NFSv4 COMPOUND tags are only wanted for debugging purposes */
> -#ifdef DEBUG
> +/* Enable compound tags to include namespace information */
> =C2=A0#define NFS4_MAXTAGLEN		20
> -#else
> -#define NFS4_MAXTAGLEN		0
> -#endif
> =C2=A0
> =C2=A0/* lock,open owner id:
> =C2=A0 * we currently use size 2 (u64) out of (NFS4_OPAQUE_LIMIT=C2=A0 >>=
 2)
> @@ -1034,6 +1031,23 @@ static void encode_compound_hdr(struct
> xdr_stream *xdr,
> =C2=A0{
> =C2=A0	__be32 *p;
> =C2=A0
> +	/* Inject namespace info into compound tag if not already
> set */
> +	if (hdr->taglen =3D=3D 0 && req->rq_task !=3D NULL) {
> +		/* Use namespace info captured at task creation time
> */
> +		struct rpc_task *task =3D req->rq_task;
> +
> +		if (taks->tk_ns_inum !=3D 0) {

Hmm.... This has not been compile tested.

> +			char ns_tag[NFS4_MAXTAGLEN + 1];
> +
> +			hdr->taglen =3D snprintf(ns_tag,
> sizeof(ns_tag), "ns:%u", taks->tk_ns_inum);
> +			if (hdr->taglen > NFS4_MAXTAGLEN) {
> +				hdr->taglen =3D NFS4_MAXTAGLEN;
> +				ns_tag[NFS4_MAXTAGLEN] =3D '\0';
> +			}
> +			hdr->tag =3D ns_tag;

ns_tag is only scoped to this block. I suggest that instead of
assigning to hdr->taglen and hdr->tag, you just do the assignment to
hdr->replen + call to encode_string() here, so you don't have to assign
a scope limited buffer to an externally visible struct.

Note also that there is no need to NUL terminate ns_tag[] when hdr-
>taglen > NFS4_MAXTAGLEN, since encode_string() does not require a nul
terminated string. In addition, snprintf() always guarantees that the
string is nul terminated, even when truncated by the buffer size :-).

> +		}
> +	}
> +
> =C2=A0	/* initialize running count of expected bytes in reply.
> =C2=A0	 * NOTE: the replied tag SHOULD be the same is the one sent,
> =C2=A0	 * but this is not required as a MUST for the server to do
> so. */
> diff --git a/include/linux/sunrpc/sched.h
> b/include/linux/sunrpc/sched.h
> index 0dbdf3722537..d376b52a72a1 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -92,6 +92,8 @@ struct rpc_task {
> =C2=A0
> =C2=A0	pid_t			tk_owner;	/* Process id for
> batching tasks */
> =C2=A0
> +	unsigned int		tk_ns_inum;	/* PID namespace
> inum for namespace tracking */
> +
> =C2=A0	int			tk_rpc_status;	/* Result of last
> RPC operation */
> =C2=A0	unsigned short		tk_flags;	/* misc flags */
> =C2=A0	unsigned short		tk_timeouts;	/* maj timeouts */
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index 016f16ca5779..4e8e7fa849d5 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/mutex.h>
> =C2=A0#include <linux/freezer.h>
> =C2=A0#include <linux/sched/mm.h>
> +#include <linux/pid_namespace.h>
> =C2=A0
> =C2=A0#include <linux/sunrpc/clnt.h>
> =C2=A0#include <linux/sunrpc/metrics.h>
> @@ -1110,6 +1111,11 @@ static void rpc_init_task(struct rpc_task
> *task, const struct rpc_task_setup *ta
> =C2=A0	task->tk_priority =3D task_setup_data->priority -
> RPC_PRIORITY_LOW;
> =C2=A0	task->tk_owner =3D current->tgid;
> =C2=A0
> +	struct pid_namespace *pid_ns =3D task_active_pid_ns(current);
> +	/* Keep track on namespace id */
> +	if (pid_ns !=3D &init_pid_ns)
> +		task->tk_ns_inum =3D pid_ns->ns.inum;

For buffered writes, this will tell you the pid namespace of the
process that is flushing the data, not that of the process that wrote
the data into the page cache. Is that what you expected?

> +
> =C2=A0	/* Initialize workqueue for async tasks */
> =C2=A0	task->tk_workqueue =3D task_setup_data->workqueue;
> =C2=A0

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

