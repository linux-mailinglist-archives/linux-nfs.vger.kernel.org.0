Return-Path: <linux-nfs+bounces-22764-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z/5nD51EOWqKpgcAu9opvQ
	(envelope-from <linux-nfs+bounces-22764-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 16:20:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7506B042E
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 16:20:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iH0Lr36K;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22764-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22764-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B48393006509
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF92B3B0AE5;
	Mon, 22 Jun 2026 14:20:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482639FCB5;
	Mon, 22 Jun 2026 14:20:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138008; cv=none; b=pXJ32KyvC0IJfWyhvseQ/3pCFfm/y5UX2VbdqJoMRNb6mlbkhTeHEJzBSTSXb1HAmtreUmZR8Xv5fE+xBB6xcFfXWW+WEPVU0jq7YcT52NBSivtILBNz9dMPfK2xjfi77GMrl0JMkNXnFt+4TI6B9+uvFd7Jn+TIar8Ib+8t+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138008; c=relaxed/simple;
	bh=il2B49fk72mkhl0VYDZ91Qxi/NEVnu364/S6kE6ewf8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dFuB/CVdQxMLn7tm6dvV3qrAfTiVC/kLhqgaVdtHi9Pome95+nfIeLsbCe7O5LcGZDzVxOQW0FGSuxNLTXxuUfn9+iRsNbJ3IopQNrT5fF+TaLPSiI1O8e8MAGa/fFQWNJB3cY4tYDEk8Wt21ifqT7VVBOW/+6m6mfdoc45ukfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iH0Lr36K; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D841F000E9;
	Mon, 22 Jun 2026 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138007;
	bh=CfTGHpvtOmLN9H8rkvxUcnN4BnMDfYENNkkSeWKQB2c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iH0Lr36Ko7rJ3JD4cnXTi0ZE8u6tQjaUsHiT2Cd+7aCQpug90I1AgC7rR9v3lStEz
	 z3Lj4ipMgvj2aMOncMYymJH85XdoGAP2UqP9u9GJPkbmGEPD2gDcu50gi7ADIn45vf
	 alRhMkZfxVw20xhS4K6mMtKTto4ZR6eRWluj84jVQRnlCIaQ5X99R8wROzpxfHmHxf
	 scvPamGUxozLmAvdQTYuF8EHMW+xi7VNS2N+QlEnSF66nz64MvF5RjCwGORUYw3Yl4
	 31II8LAUMTiFoqSbD6DQsKM4fI18iEcMNHsgaPdM5pS8jorU2eXmbHz9+llGIXFF7f
	 yiCofIL3pYsag==
Message-ID: <d53d167ad535d865ffbafb0806398ffbd3559674.camel@kernel.org>
Subject: Re: [PATCH] NFSv4.1/pnfs: bound layout-type count in
 decode_pnfs_layout_types
From: Trond Myklebust <trondmy@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>, Anna Schumaker
	 <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 22 Jun 2026 10:20:05 -0400
In-Reply-To: <20260622124836.1696330-1-michael.bommarito@gmail.com>
References: <20260622124836.1696330-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:anna@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22764-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB7506B042E

On Mon, 2026-06-22 at 08:48 -0400, Michael Bommarito wrote:
> decode_pnfs_layout_types() reads a server-controlled u32 count and
> then
> reserves 4 * count bytes:
>=20
> 	fsinfo->nlayouttypes =3D be32_to_cpup(p);
> 	...
> 	p =3D xdr_inline_decode(xdr, fsinfo->nlayouttypes * 4);
>=20
> The multiplication is u32, so any count >=3D 0x40000000 wraps to a
> small
> value and xdr_inline_decode() reserves too few bytes. The
> NFS_MAX_LAYOUT
> cap is applied only afterwards, so the subsequent reads run past the
> short reservation. array_size() is not a safe guard here either:
> xdr_inline_decode() runs its nbytes argument through
> XDR_QUADLEN(((l) + 3) >> 2), which wraps SIZE_MAX to a zero-word
> reservation instead of failing.
>=20
> Reject counts that cannot fit in the u32 multiplication before the
> reservation, and use sizeof(__be32) so the size arithmetic is
> explicit.
>=20
> A malicious NFSv4.1+ server returning a crafted
> FATTR4_FS_LAYOUT_TYPES
> attribute triggers this on the client during FSINFO decode.
>=20
> This is the decode_pnfs_layout_types companion to the same XDR-wrap
> class
> fixed in decode_getdeviceinfo (NFSv4.1/pnfs: bound notification
> bitmap
> length in decode_getdeviceinfo).
>=20
> Fixes: ca440c383a58 ("pnfs: add a new mechanism to select a layout
> driver according to an ordered list")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Reproduced on a UML KASAN build with a KUnit case that feeds
> decode_pnfs_layout_types() an xdr buffer whose nlayouttypes is
> 0x40000001:
> nlayouttypes * 4 wraps, xdr_inline_decode() reserves a short buffer,
> and
> the decode reads past xdr->end (KASAN slab-out-of-bounds read). With
> this
> patch the count is rejected (-EIO) before the reservation. Benign
> control:
> a small nlayouttypes decodes correctly on both stock and patched. The
> KUnit test can ride as a separate patch (matching the
> decode_getdeviceinfo
> series). Before/after logs available on request.
>=20
> =C2=A0fs/nfs/nfs4xdr.c | 10 +++++++++-
> =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index c23c2eee1b5c4..8b7994f61d303 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -4903,8 +4903,16 @@ static int decode_pnfs_layout_types(struct
> xdr_stream *xdr,
> =C2=A0	if (fsinfo->nlayouttypes =3D=3D 0)
> =C2=A0		return 0;
> =C2=A0
> +	/* Reject counts that would overflow the u32 multiplication
> below.
> +	 * array_size() is not sufficient here: xdr_inline_decode()
> passes
> +	 * nbytes through XDR_QUADLEN(((l)+3)>>2), which wraps
> SIZE_MAX to
> +	 * a zero-word reservation rather than failing.
> +	 */
> +	if (fsinfo->nlayouttypes > U32_MAX / sizeof(__be32))
> +		return -EIO;
> +
> =C2=A0	/* Decode and set first layout type, move xdr->p past unused
> types */
> -	p =3D xdr_inline_decode(xdr, fsinfo->nlayouttypes * 4);
> +	p =3D xdr_inline_decode(xdr, fsinfo->nlayouttypes *
> sizeof(__be32));
> =C2=A0	if (unlikely(!p))
> =C2=A0		return -EIO;
> =C2=A0
>=20
> base-commit: ef0c9f75a19532d7675384708fc8621e10850104

This is just open coding xdr_stream_decode_uint32_array(), and doing so
incorrectly.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

