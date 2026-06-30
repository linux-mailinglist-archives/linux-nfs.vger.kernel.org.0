Return-Path: <linux-nfs+bounces-22889-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L0pHNsbJQ2rZhwoAu9opvQ
	(envelope-from <linux-nfs+bounces-22889-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 15:51:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 336266E50D7
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 15:51:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=desy.de header.s=default header.b=vQZfOQCr;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22889-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22889-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=desy.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60B673112FC4
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 13:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECD2F549F;
	Tue, 30 Jun 2026 13:48:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6734D4D6
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 13:48:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827328; cv=none; b=K8kVRAwfnwfPG+b2QWkMvpd96nPmOYUMrfV41iCcoYN5TDxfVRb9UbOp3bftyNKll2dUFsh7sr1fbP/hHm4O3qdBOCyLJXzK3ISbk3OaxX71279R94a5VLyGKfPBQ2zNNdq+7FYgqVuBlxQUL2fEST6DIoI3GhsNFLsiFA2mXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827328; c=relaxed/simple;
	bh=FFXh0uZ8Q8YZy19967z67u9qiP1eeZDfyJje0k++zQQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=FeqBoibp348ynyIb2lPCZNbnUJlypRLjabZsGEMFRizoAGVwFw4kI9jMWAC96iPzBAYJiA4WSvzJ8F3fog0UWs71c9lpqEqOJT2MCtPibIfQ/xf+g0Pq57yzHYNh6BHm+cELJ3B0eKSclVfAyQnkLi0n9ewgWewuSKk6IBws1qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=vQZfOQCr; arc=none smtp.client-ip=131.169.56.154
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 80FD811F746
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 15:48:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 80FD811F746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1782827308; bh=1rgo0DvmOcmUFOWgQGNpR8CFpMUXwFSy1EfVNaPj0Lk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=vQZfOQCrfX7wwNlV7Ye0SLjh7Iv6WjL3AnTmfv8TM4mz2Jhl31LcpwBKVDhrAFjps
	 iOohrbmlI0w+REC+tA7z5OirNtQiQDJNVQLtHtNKherlGgDVhF1FcTETBBezo6Wckd
	 c1W+8wEruvgNWbLJ3MP6erVVfrwFUG6z54sJZtH8=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 736E1120043;
	Tue, 30 Jun 2026 15:48:28 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 6426140045;
	Tue, 30 Jun 2026 15:48:28 +0200 (CEST)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [131.169.56.69])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id DC46E100064;
	Tue, 30 Jun 2026 15:48:26 +0200 (CEST)
Received: from z-mbx-3.desy.de (z-mbx-3.desy.de [131.169.55.141])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id B03661A0041;
	Tue, 30 Jun 2026 15:48:26 +0200 (CEST)
Date: Tue, 30 Jun 2026 15:48:26 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: chuck lever <chuck.lever@oracle.com>, jlayton <jlayton@kernel.org>, 
	anna <anna@kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <255476971.4622529.1782827306515.JavaMail.zimbra@desy.de>
In-Reply-To: <fb81ad5a850160daab7092a8289bc626862f6072.camel@kernel.org>
References: <20260626151029.1516839-1-tigran.mkrtchyan@desy.de> <fb81ad5a850160daab7092a8289bc626862f6072.camel@kernel.org>
Subject: Re: [PATCH] [RFC] nfs4: inject process namespace into COMPOUND tag
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_4622530_9064409.1782827306628"
X-Mailer: Zimbra 10.1.18_GA_4890 (ZimbraWebClient - FF152 (Linux)/10.1.17_GA_4873)
Thread-Topic: nfs4: inject process namespace into COMPOUND tag
Thread-Index: 7a8XJWMPfDbNU14LxRS4CzIFprmnQA==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[desy.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[desy.de:s=default];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22889-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email,hammerspace.com:email];
	FORGED_SENDER(0.00)[tigran.mkrtchyan@desy.de,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[desy.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tigran.mkrtchyan@desy.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 336266E50D7

------=_Part_4622530_9064409.1782827306628
Date: Tue, 30 Jun 2026 15:48:26 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: chuck lever <chuck.lever@oracle.com>, jlayton <jlayton@kernel.org>, 
	anna <anna@kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <255476971.4622529.1782827306515.JavaMail.zimbra@desy.de>
In-Reply-To: <fb81ad5a850160daab7092a8289bc626862f6072.camel@kernel.org>
References: <20260626151029.1516839-1-tigran.mkrtchyan@desy.de> <fb81ad5a850160daab7092a8289bc626862f6072.camel@kernel.org>
Subject: Re: [PATCH] [RFC] nfs4: inject process namespace into COMPOUND tag
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 10.1.18_GA_4890 (ZimbraWebClient - FF152 (Linux)/10.1.17_GA_4873)
Thread-Topic: nfs4: inject process namespace into COMPOUND tag
Thread-Index: 7a8XJWMPfDbNU14LxRS4CzIFprmnQA==



----- Original Message -----
> From: "Trond Myklebust" <trondmy@kernel.org>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "chuck lever" <chuck.l=
ever@oracle.com>, "jlayton"
> <jlayton@kernel.org>, "anna" <anna@kernel.org>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Sunday, 28 June, 2026 23:15:42
> Subject: Re: [PATCH] [RFC] nfs4: inject process namespace into COMPOUND t=
ag

> On Fri, 2026-06-26 at 17:10 +0200, Tigran Mkrtchyan wrote:
>> On large shared machines often multiple jobs of a same user run in
>> parallel. For debugging, it's usually impossible to identify requests
>> coming from different processes.
>>=20
>> The batch systems like HTCondor or SLURM start every job in it's own
>> namespace, thus passing namespace info to the server will help by
>> debugging.
>>=20
>> 192.168.122.150 =E2=86=92 192.168.178.69 NFS 260 V4 Call GETATTR FH:
>> 0xd5ffb2cb
>> 192.168.178.69 =E2=86=92 192.168.122.150 NFS 324 V4 Reply (Call In 89)
>> GETATTR
>> 192.168.122.150 =E2=86=92 192.168.178.69 NFS 260 V4 Call GETATTR FH:
>> 0xd0b0a44e
>> 192.168.178.69 =E2=86=92 192.168.122.150 NFS 324 V4 Reply (Call In 95)
>> GETATTR
>> 192.168.122.150 =E2=86=92 192.168.178.69 NFS 268 V4 Call ACCESS FH:
>> 0xd0b0a44e, [Check: RD LU MD XT DL XAR XAW XAL]
>> 192.168.178.69 =E2=86=92 192.168.122.150 NFS 240 V4 Reply (Call In 101)
>> ACCESS, [Allowed: RD LU MD XT DL XAR XAW XAL]
>> 192.168.122.150 =E2=86=92 192.168.178.69 NFS 284 V4 Call READDIR FH:
>> 0xd0b0a44e
>> 192.168.178.69 =E2=86=92 192.168.122.150 NFS 664 V4 Reply (Call In 105)
>> READDIR
>> 192.168.122.150 =E2=86=92 192.168.178.69 NFS 284 V4 Call ns:4026532507
>> GETATTR FH: 0xd67b66a5
>> 192.168.178.69 =E2=86=92 192.168.122.150 NFS 340 V4 Reply (Call In 111)
>> ns:4026532507 GETATTR
>> 192.168.122.150 =E2=86=92 192.168.178.69 NFS 292 V4 Call ns:4026532507 A=
CCESS
>> FH: 0xd67b66a5, [Check: RD LU MD XT DL XAR XAW XAL]
>> 192.168.178.69 =E2=86=92 192.168.122.150 NFS 256 V4 Reply (Call In 117)
>> ns:4026532507 ACCESS, [Access Denied: MD XT DL XAW], [Allowed: RD LU
>> XAR XAL]
>> 192.168.122.150 =E2=86=92 192.168.178.69 NFS 308 V4 Call ns:4026532507
>> READDIR FH: 0xd67b66a5
>> 192.168.178.69 =E2=86=92 192.168.122.150 NFS 200 V4 Reply (Call In 121)
>> ns:4026532507 READDIR
>>=20
>> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
>> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
>> ---
>> =C2=A0fs/nfs/nfs4xdr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 24 +++++++++++++++++++-----
>> =C2=A0include/linux/sunrpc/sched.h |=C2=A0 2 ++
>> =C2=A0net/sunrpc/sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 6 ++++++
>> =C2=A03 files changed, 27 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
>> index c23c2eee1b5c..9c035c74a3b5 100644
>> --- a/fs/nfs/nfs4xdr.c
>> +++ b/fs/nfs/nfs4xdr.c
>> @@ -46,6 +46,7 @@
>> =C2=A0#include <linux/kdev_t.h>
>> =C2=A0#include <linux/module.h>
>> =C2=A0#include <linux/utsname.h>
>> +#include <linux/pid_namespace.h>
>> =C2=A0#include <linux/sunrpc/clnt.h>
>> =C2=A0#include <linux/sunrpc/msg_prot.h>
>> =C2=A0#include <linux/sunrpc/gss_api.h>
>> @@ -71,12 +72,8 @@ static void encode_layoutget(struct xdr_stream
>> *xdr,
>> =C2=A0static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqs=
t
>> *req,
>> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs4_layoutget_res *res);
>> =C2=A0
>> -/* NFSv4 COMPOUND tags are only wanted for debugging purposes */
>> -#ifdef DEBUG
>> +/* Enable compound tags to include namespace information */
>> =C2=A0#define NFS4_MAXTAGLEN=09=0920
>> -#else
>> -#define NFS4_MAXTAGLEN=09=090
>> -#endif
>> =C2=A0
>> =C2=A0/* lock,open owner id:
>> =C2=A0 * we currently use size 2 (u64) out of (NFS4_OPAQUE_LIMIT=C2=A0 >=
> 2)
>> @@ -1034,6 +1031,23 @@ static void encode_compound_hdr(struct
>> xdr_stream *xdr,
>> =C2=A0{
>> =C2=A0=09__be32 *p;
>> =C2=A0
>> +=09/* Inject namespace info into compound tag if not already
>> set */
>> +=09if (hdr->taglen =3D=3D 0 && req->rq_task !=3D NULL) {
>> +=09=09/* Use namespace info captured at task creation time
>> */
>> +=09=09struct rpc_task *task =3D req->rq_task;
>> +
>> +=09=09if (taks->tk_ns_inum !=3D 0) {
>=20
> Hmm.... This has not been compile tested.

I am pretty sure this is the code that I run on VM right now :)

>=20
>> +=09=09=09char ns_tag[NFS4_MAXTAGLEN + 1];
>> +
>> +=09=09=09hdr->taglen =3D snprintf(ns_tag,
>> sizeof(ns_tag), "ns:%u", taks->tk_ns_inum);
>> +=09=09=09if (hdr->taglen > NFS4_MAXTAGLEN) {
>> +=09=09=09=09hdr->taglen =3D NFS4_MAXTAGLEN;
>> +=09=09=09=09ns_tag[NFS4_MAXTAGLEN] =3D '\0';
>> +=09=09=09}
>> +=09=09=09hdr->tag =3D ns_tag;
>=20
> ns_tag is only scoped to this block. I suggest that instead of
> assigning to hdr->taglen and hdr->tag, you just do the assignment to
> hdr->replen + call to encode_string() here, so you don't have to assign
> a scope limited buffer to an externally visible struct.
>=20
> Note also that there is no need to NUL terminate ns_tag[] when hdr-
>>taglen > NFS4_MAXTAGLEN, since encode_string() does not require a nul
> terminated string. In addition, snprintf() always guarantees that the
> string is nul terminated, even when truncated by the buffer size :-).
>=20
>> +=09=09}
>> +=09}
>> +
>> =C2=A0=09/* initialize running count of expected bytes in reply.
>> =C2=A0=09 * NOTE: the replied tag SHOULD be the same is the one sent,
>> =C2=A0=09 * but this is not required as a MUST for the server to do
>> so. */
>> diff --git a/include/linux/sunrpc/sched.h
>> b/include/linux/sunrpc/sched.h
>> index 0dbdf3722537..d376b52a72a1 100644
>> --- a/include/linux/sunrpc/sched.h
>> +++ b/include/linux/sunrpc/sched.h
>> @@ -92,6 +92,8 @@ struct rpc_task {
>> =C2=A0
>> =C2=A0=09pid_t=09=09=09tk_owner;=09/* Process id for
>> batching tasks */
>> =C2=A0
>> +=09unsigned int=09=09tk_ns_inum;=09/* PID namespace
>> inum for namespace tracking */
>> +
>> =C2=A0=09int=09=09=09tk_rpc_status;=09/* Result of last
>> RPC operation */
>> =C2=A0=09unsigned short=09=09tk_flags;=09/* misc flags */
>> =C2=A0=09unsigned short=09=09tk_timeouts;=09/* maj timeouts */
>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>> index 016f16ca5779..4e8e7fa849d5 100644
>> --- a/net/sunrpc/sched.c
>> +++ b/net/sunrpc/sched.c
>> @@ -21,6 +21,7 @@
>> =C2=A0#include <linux/mutex.h>
>> =C2=A0#include <linux/freezer.h>
>> =C2=A0#include <linux/sched/mm.h>
>> +#include <linux/pid_namespace.h>
>> =C2=A0
>> =C2=A0#include <linux/sunrpc/clnt.h>
>> =C2=A0#include <linux/sunrpc/metrics.h>
>> @@ -1110,6 +1111,11 @@ static void rpc_init_task(struct rpc_task
>> *task, const struct rpc_task_setup *ta
>> =C2=A0=09task->tk_priority =3D task_setup_data->priority -
>> RPC_PRIORITY_LOW;
>> =C2=A0=09task->tk_owner =3D current->tgid;
>> =C2=A0
>> +=09struct pid_namespace *pid_ns =3D task_active_pid_ns(current);
>> +=09/* Keep track on namespace id */
>> +=09if (pid_ns !=3D &init_pid_ns)
>> +=09=09task->tk_ns_inum =3D pid_ns->ns.inum;
>=20
> For buffered writes, this will tell you the pid namespace of the
> process that is flushing the data, not that of the process that wrote
> the data into the page cache. Is that what you expected?


In general, with read-ahead, delegations, and other caching mechanisms,
is it possible to match NFS I/O to an application?

Best regards,
   Tigran.


>=20
>> +
>> =C2=A0=09/* Initialize workqueue for async tasks */
>> =C2=A0=09task->tk_workqueue =3D task_setup_data->workqueue;
>> =C2=A0
>=20
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com

------=_Part_4622530_9064409.1782827306628
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIIF
2zCCBEOgAwIBAgIQBBL/+bEcDC3Q01JGn3M5ITANBgkqhkiG9w0BAQsFADBUMQswCQYDVQQGEwJO
TDEZMBcGA1UECgwQR0VBTlQgVmVyZW5pZ2luZzEqMCgGA1UEAwwhR0VBTlQgVENTIEF1dGhlbnRp
Y2F0aW9uIFJTQSBDQSA1MB4XDTI1MTIxMjE0MDk0MloXDTI3MDExMTE0MDk0MVowgakxEzARBgoJ
kiaJk/IsZAEZFgNvcmcxFjAUBgoJkiaJk/IsZAEZFgZ0ZXJlbmExEzARBgoJkiaJk/IsZAEZFgN0
Y3MxCzAJBgNVBAYTAkRFMS4wLAYDVQQKDCVEZXV0c2NoZXMgRWxla3Ryb25lbi1TeW5jaHJvdHJv
biBERVNZMSgwJgYDVQQDDB9UaWdyYW4gTWtydGNoeWFuIHRpZ3JhbkBkZXN5LmRlMIIBojANBgkq
hkiG9w0BAQEFAAOCAY8AMIIBigKCAYEArfnI6mD8MyGhRXT544OuIOATR0q0ViKjZWMjNO0PYJ7b
WrA2ahLCMyOw18kaAhArvmyhASlCZGHAeHjMPQAcRWoBQyLXkbusXBqxPQbApGXcXERNGXja00Xk
MrZCGe198EcRgn52hDbmcOhQPlyY/fKp3ukpPDLyQEeZFDDz4KeKFrZ6Qc3ps/yZqjQ2bXY8l93W
G+0DVbP6e2AM0DW4fWDYoafLvnMyl2J5yhYjYXtFkcV7iiDUuQH/lZvYvRQTzlir0jczribIPpss
zxcctqleZRX646qBT+lI0nP+EgdGPCXNteJGbwGHw7DQqXDk+0AIYShiiTMayRODX65uCwRG9iO5
mtibWMeFTzGOy8HG09PFlc8VG8+2pZtIYLPIof65dykviDm0vI0A36iaw7gI5RRy1K6dGpJscKU2
V5d+LlhVu5qjBayUfJQhy4jykZplaeXvQThZ9rg9ngz+FwlEz7tlM5U1hepzD7s1snyVaOGtRiQt
yWSUKcMB0DPJAgMBAAGjggFRMIIBTTAfBgNVHSMEGDAWgBSDrT4rvBOJjYgJHL8g3F+4MVXq8TBX
BggrBgEFBQcBAQRLMEkwRwYIKwYBBQUHMAKGO2h0dHA6Ly9jcnQuZ2VhbnQtcHJ2LmhhcmljYS5n
ci9HRUFOVC1UQ1MtQ2xpZW50LUF1dGgtUjUuY2VyMDUGA1UdIAQuMCwwDAYKKoZIhvdMBQICBTAN
BgsqhkiG90wFAgMDAzANBgsqhkiG90wFAgMBAjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUH
AwQwTAYDVR0fBEUwQzBBoD+gPYY7aHR0cDovL2NybC5nZWFudC1wcnYuaGFyaWNhLmdyL0dFQU5U
LVRDUy1DbGllbnQtQXV0aC1SNS5jcmwwHQYDVR0OBBYEFDxIMH6YFtPoOHuwqAzVWAjUq9klMA4G
A1UdDwEB/wQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAYEAM3+V2E77QHQaDQSi0RRpdct0OrebGrBQ
1UZHmxhwyy1LaTERW/8J70lDP9FxYJlk77whB853mwW/LukNXzRNW/mgpuIlVQH+uooys5NbIgl2
zVuIhQ/7CWO3xYbKyxk8pUwvk43qR/hVprL0djOGm9Wr31AmryK9KMXpod95pv3hydpAPZi+4Kux
GtsmX69ggbcB518och4jij+KCtGCaFHjLbek40VYwAjIRSfwpVTKgFefkTEo+/G9KiJiT3p8Z/RL
6VDc+pB+GFNAW/+Z6nAkRWJKZFrVAEFqX2by2v+CTu9oLPUKiRTCEuSXCqwsMO40qzYT8Tjp9+sq
KfeGDPzRxd/J4G6JSsLpRrCesQnKRTwqEF6yUfvNyrqKe9fImt/UriOFjXcdPqAkhFWIr0d/fZQp
1upqYQ1PnuyfdOU4Ct6NN9PGopyB4i+iKWaECe4W4iPZsF+qWUmynQpbAwDu/UvBN3U4wdrDdeO6
XZ3HQ0q/aG67FOeLCkhOgnvqAAAxggLkMIIC4AIBATBoMFQxCzAJBgNVBAYTAk5MMRkwFwYDVQQK
DBBHRUFOVCBWZXJlbmlnaW5nMSowKAYDVQQDDCFHRUFOVCBUQ1MgQXV0aGVudGljYXRpb24gUlNB
IENBIDUCEAQS//mxHAwt0NNSRp9zOSEwDQYJYIZIAWUDBAIBBQCggc4wGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNjMwMTM0ODI2WjAtBgkqhkiG9w0BCTQxIDAe
MA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCDYTgbCmz1/jDYJ
RlK/aNEUBMfcGqYsAYTF4NoJW9dBmDA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqG
SIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0BAQsFAASCAYCC2AG+HP7XEoYpdF2eoiqs4nfM
+agVpQoMl+8oMzz5hsTd42gKGzkPC08nzQc+Y/3jBmKwKvVyeXDLqcMERPb4+lEN8z0ksxBNXc5u
GGWtygEYWUwGYJj6FBAEyTl9rv1t2/AONU+0JLpzFb0swvCUXdkf5QI5BiSFTGshUdoLLtvBM7dj
SFGCnhb31lYsGxsaWqfrZ4aP8zt6H+ymoUxU5FtE0oRSTprX+GhLkeanR40FPizkvlZy7f9wxP+R
k1wNjtSFqg2ebCt9fjCoGrh+NLFCD1jXd5iNvKtw33/qXZyE9LyiXOz05H6EPob/fmFGyCQP5sg6
stuXBumnhutKSsea8hGyzvoPXfLAwXyl+2XOfH9JggmSGhs8ZS2gIE3nlkUtfXMNLMNcIpdLxHQn
Avq/LdsGsh32I7XO9f34XwAa3ob0TPSYJ/dNyAdLojeX03minV18xNWH+PSXArA+Ru63wdsTtBA5
9OAKTTf0UBAs+jL61G48uOco+cySBEUAAAAAAAA=
------=_Part_4622530_9064409.1782827306628--

