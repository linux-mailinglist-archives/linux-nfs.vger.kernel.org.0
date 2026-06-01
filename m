Return-Path: <linux-nfs+bounces-22139-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g5OkNhLbHGrNTQkAu9opvQ
	(envelope-from <linux-nfs+bounces-22139-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 03:06:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4B1618958
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 03:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85D3230028A4
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 01:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E721A238F;
	Mon,  1 Jun 2026 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ovyCtiC3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVjfv2Rj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B61341C6A;
	Mon,  1 Jun 2026 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275981; cv=none; b=OguYU5jepTKhWU/I4f67p3a7G0nPTQcBB+xW8n9nal7YWGnvT9xWmihwU6g1kNt3IUFIUewgN0iFtuHUsq5DCH2ygY5Pcpmd+B/4PPHW3tx5eF4oH9JLgXc9z5Ai6L0G8iRJzDCAIFLMYDxMQQ5fPLIvcnlbOmoXEAoNNcu4T+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275981; c=relaxed/simple;
	bh=syxXGA7wA+xQiRnnCLY+UuoOzA0GW8hLXj0mN5iejMM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aE/VpZeDz5YSlfNOGHYj+G9o85lG7BXEJqIp7z22yATeI+JsujC6R0cDCLC7vKjvRe2IglUYUnKx6qGiT7uXuILSTXOiPryg86NcJGJhLqJ67o97PGmsPyjlWKfd08E5SjCMWcqZcHxWC7BJDWvb5U9hbf/tLxK0vNAIMzrfdPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ovyCtiC3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iVjfv2Rj; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 355DE7A0057;
	Sun, 31 May 2026 21:06:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 31 May 2026 21:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1780275978; x=1780362378; bh=p99SE1regdSaDqvVM0JQyYwcVxqsk3JHvxL
	DsfuTWhg=; b=ovyCtiC36F+lphU1gAHHEOCJfDzdBQMAP9WvYFMywAGezDSZa2b
	rc8X0/J1gDAaOT3pmYdELPk4CxKj/7PWmYApUnkUDcuGimuPmePzlGREq/QKsUDi
	PUOhisFfjqqg2MKdH3DrqcT9rhfRVytai6NJtjlxNKXOjfblamLuEhI0I9Vs1h4l
	61POu146R+QoPlwfR4eYx8+gTYgr+ev1m+/f0XZpP3ToMyVIdDKijpSTSlQK6IJx
	ydWscXBQJXt+/KzVjV4NvO64D/7HUwc2mFMuFvqvSDTW+6bYlcls7X8MfaGWikAe
	vdiGrWAJ4bVUr9H0NagP3gggfchUF6CxLRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780275978; x=
	1780362378; bh=p99SE1regdSaDqvVM0JQyYwcVxqsk3JHvxLDsfuTWhg=; b=i
	Vjfv2Rjyh2BngfTZ1qqfkJipT4xg18Qk2btHLMcung/tGbVBa/ByhqUSlD/edVE2
	ryq0jzmdpVC+RXcg/q4lmpeotYxThTLQ50AgHaKAzFE7i7auCtC1LN6t2C9hCNbZ
	N2+fLUcfgCBJW5dN5/JyXM77gR9WHdxN7VCNKU2kqoDrDwsCjJfhKbI77rU5k1a9
	qv6IeFlIH/Ti+JauOEws4+IGyX+stamPKiE4NkTiyHrlFeP9UU8YZKVMMtJ6GPtD
	6mKWyH1S15spaeUgv9pJe4DzJi5dMPHNsO1RfO0XMCIB8qRmsww4BUbE+YBEf0jl
	r91OSwXkYdWbtvz0+U+Mw==
X-ME-Sender: <xms:CdscanOEnvhXeKFs8210Gq1A-3S3zw2mY_39ZITWiinGfI7Y9IdFLA>
    <xme:Cdscam5sDighB0toUFyuSpoLMtgIWB-AiAYvos1H-ZqVLbdvi7Sytk2udyRtAB9lN
    Bz3aW0zJ6W3ldzOJ8Cvhg1RpEDLcOgPSPa1_NonB5nO2v3Gzg>
X-ME-Received: <xmr:Cdscaqgud97kHNduUaRicb-hPcnp6hYbmvzORKVbPLsTXWAhGDcDQk9JZoRf18r3XyVzRdUqn82Z5iZTZ35PykIbu5JPBIw>
X-ME-Proxy-Cause: dmFkZTFCQmMp7qONNyUVDkkJioKC1YoMRzq6iBaT+nFSpG7fLMN1AKC5P3/B8AtskoyBov
    CP6kbeQ/68c18Ni3TvmHbyCD4SPHKhcvrPfeTLMot99KBIFVXNhb08DC3hh5KGMNLzODdc
    0qs1TbFn6ogQGp6xyzsd5UQlZs+JOV6eBtoUQ9LNMg0TUvuJmyo4dSh97FnxI8TmhTYRWF
    3mzXku2nlURHCtkmXXu05faC8erLl+YI9D5YIPGc4wir2DOiMgDb3iXGK3NGzVffVKftU2
    OBjn+bgeOd+ryj+/rgZcxVgtXuC2ZfdPEmKR/Qxgthq5TlP9MshmD6dhFFXoaXJ5crjnRO
    9YM5Ij1PPzj0s2LeRHvpJgq/KGk3eMYNjSHpe2ifTekmO4ttsYKPX14hH+3ITsGLe7PEeJ
    LBcR0g8G8/iUusHwS5KBo5Dz7DWuIXW7j3Kkymj1mX86MP/0jf9e728dOB+eLD+vG0BuYh
    zEIi0mxDLIGQp5sVtGhoETXkyMbGHPkfCvmBd0N1jOs+eD25ylx9elRtbyjy7XqxQygB0o
    rtkd1L1FMEyBr6RF6fnedyLm/mMBzpuoRdsrQPjI4N+n0rIFpCoT+cNviNFc0MCfC4ggMp
    tnmpXRCoKHtA9pzdzmBVLNU4PS3PCwb+S3CICsUoVTj64O2269gXZEnevkOg
X-ME-Proxy: <xmx:CdscareDK5E7Y36KeaIghFTfRO30igYPAKOO0diGb8r0FfIFORMmfg>
    <xmx:Cdscaix7mM9zatSP7-WJDJT7lnRp1n0sQj4vgqHj2EakT0bZa_kPsg>
    <xmx:Cdscaq3g8Y4YZdeDtgNFvnR5XA2fdD1CaF2wjzDdN8KRy18PDCM6uA>
    <xmx:CdscaoxQ-sXWCk1JzorbGGMZQQmsfpLcVCS8xZTbIJ5dNc3a8TJmJQ>
    <xmx:CtscatuH79QN-8EqJiAbLDUIALMAqAtD2JgQ-bHccrcEXZDMRA9WXUnA>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 21:06:15 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Rick Macklem" <rmacklem@uoguelph.ca>,
 "Chris Mason" <clm@meta.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v2] nfsd: release OPEN-decoded posix ACLs via op_release
In-reply-to: <20260531-nfsd-testing-v2-1-e13e6355fc07@kernel.org>
References: <20260531-nfsd-testing-v2-1-e13e6355fc07@kernel.org>
Date: Mon, 01 Jun 2026 11:06:10 +1000
Message-id: <178027597098.2923901.17316619429004997151@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22139-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ownmail.net:dkim,messagingengine.com:dkim,noble.neil.brown.name:mid]
X-Rspamd-Queue-Id: 0B4B1618958
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 01 Jun 2026, Jeff Layton wrote:
> nfsd4_decode_createhow4() calls nfsd4_decode_fattr4(), which allocates
> refcounted struct posix_acl objects via posix_acl_alloc() and stores
> them in open->op_pacl and open->op_dpacl. These pointers must be
> released once the OPEN compound finishes.
>=20
> When nfsd4_decode_open_claim4() returns a non-seqid-mutating error,
> the dispatcher short-circuits before op_func runs:
>=20
>     nfsd4_proc_compound()
>       opdesc->op_func =3D=3D nfsd4_open_omfg
>         if (!seqid_mutating_err(ntohl(op->status)))
>             return op->status;   /* nfsd4_open() never runs */
>       opdesc->op_release(&op->u)  /* must still release op_pacl/op_dpacl */
>=20
> Before this change OP_OPEN had no .op_release in nfsd4_ops[], and the
> release pair lived inside nfsd4_open() at its out_err: label. On the
> short-circuit path nfsd4_open() is never invoked, so both posix_acl
> refs leak on every malformed OPEN compound that carries valid POSIX
> ACL createhow4 attributes.
>=20
> Add nfsd4_open_release() and wire it as .op_release for OP_OPEN.
> posix_acl_release() is NULL-safe, so the single release site covers
> both the normal path and the nfsd4_open_omfg short-circuit. Remove
> the matching posix_acl_release() pair from nfsd4_open()'s out_err:
> label to avoid double-releasing.
>=20
> The compound loop has two encoding branches: nfsd4_encode_operation()
> for normal ops, and nfsd4_encode_replay() for v4.0 replayed ops.
> op_release was only called from nfsd4_encode_operation(), so resources
> attached to op->u leak on the replay path. Add an op_release call to
> the replay branch as well to ensure cleanup on every path.
>=20
> Fixes: 5fc51dfc2eb1 ("NFSD: Add support for XDR decoding POSIX draft ACLs")
> Signed-off-by: Chris Mason <clm@meta.com>
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v2:
> - Ensure that op_release is called in the v4.0 replay case as well
> - Link to v1: https://lore.kernel.org/r/20260531-nfsd-testing-v1-0-7bfa481b=
0540@kernel.org
> ---
>  fs/nfsd/nfs4proc.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 017474cd63b5..51998d7885ae 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -681,8 +681,6 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compoun=
d_state *cstate,
>  	nfsd4_cleanup_open_state(cstate, open);
>  	nfsd4_bump_seqid(cstate, status);
>  out_err:
> -	posix_acl_release(open->op_dpacl);
> -	posix_acl_release(open->op_pacl);
>  	return status;
>  }
> =20
> @@ -704,6 +702,13 @@ static __be32 nfsd4_open_omfg(struct svc_rqst *rqstp, =
struct nfsd4_compound_stat
>  	return nfsd4_open(rqstp, cstate, &op->u);
>  }
> =20
> +static void
> +nfsd4_open_release(union nfsd4_op_u *u)
> +{
> +	posix_acl_release(u->open.op_dpacl);
> +	posix_acl_release(u->open.op_pacl);
> +}
> +
>  /*
>   * filehandle-manipulating ops.
>   */
> @@ -3214,6 +3219,8 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  			op->replay =3D &cstate->replay_owner->so_replay;
>  			nfsd4_encode_replay(resp->xdr, op);
>  			status =3D op->status =3D op->replay->rp_status;
> +			if (op->opdesc->op_release)
> +				op->opdesc->op_release(&op->u);
>  		} else {
>  			nfsd4_encode_operation(resp, op);
>  			status =3D op->status;

I think this patch is good, but I think it would be even better if the
->op_release() call were moved out of nfsd4_encode_operation() and
places after this if-else.  Then there would be only one call-site in a
fairly obviously-correct place.
But:
  Reviewed-by: NeilBrown <neil@brown.name>
for if you just want to stick with this version.

Thanks,
NeilBrown


> @@ -3718,6 +3725,7 @@ static const struct nfsd4_operation nfsd4_ops[] =3D {
>  	},
>  	[OP_OPEN] =3D {
>  		.op_func =3D nfsd4_open,
> +		.op_release =3D nfsd4_open_release,
>  		.op_flags =3D OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
>  		.op_name =3D "OP_OPEN",
>  		.op_rsize_bop =3D nfsd4_open_rsize,
>=20
> ---
> base-commit: 6c0004650ba248a12937ada16f9ba961b35ce2b5
> change-id: 20260531-nfsd-testing-9122bf51ce95
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20


