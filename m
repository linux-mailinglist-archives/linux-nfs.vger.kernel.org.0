Return-Path: <linux-nfs+bounces-22892-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6a7sNWHpQ2rWlQoAu9opvQ
	(envelope-from <linux-nfs+bounces-22892-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 18:05:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 547EE6E63F7
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 18:05:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QGaxsn2Y;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22892-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22892-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 821233038D2E
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA6E376BD3;
	Tue, 30 Jun 2026 15:59:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F127334BA5B
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 15:59:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835172; cv=none; b=FmvipVq0qjmyuLDMQ/eCuavgPWxI+Vzohym7iel0Prb9o2nQVLQsplsHenfKrdUnFElKMDuswpA8funsyjwGlzJ0cuaeMLUQXFd3QMhFyyZ2KgMbmhstbTyfK4H38mugvsYsABTfxWjmSgVi1MAUfVcLcznXjq3HSYiDWqvrbjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835172; c=relaxed/simple;
	bh=PD4UQnmz8dojeCykeZJm7pq991BT9UR3aw0rU5VVc00=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TP/0ONOFtFHbr0pq744ZPyHv/OEw6kJlslkj5y6AgigsFkju1REJKWS+WGGGWg4FEt036zta6+9iHQHMuWSL2whBpIFoA0m/5R+nRlMkPodTl7O/ZHERyzjoUWnBcMxVX91Pha9bDghUnoCizbvnpWOnsQWkXKm71E8+O2JYcCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGaxsn2Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994ED1F000E9;
	Tue, 30 Jun 2026 15:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782835169;
	bh=MptqtTOsjQ+H6tv9Zut7XVxTwRscm7BB+HWlU0dYcdg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QGaxsn2YCQEB+mSjNCiZ2sSuOIRD266bPDvhvQPh3kiDTVKNFWjnWHoWV7+mYcuog
	 ACJ+SCG8+4QgrUEOCsawsxWh7qExPHEMXVCY7uzf0z+1F5ErwQnqTYPiyuB0j+bEdT
	 vJPiOoRt+9qovbi9M7ILeRXVK1/1b6GOKTsgFXrvO/9l3l8fs6UoEDB2kVKsHWeAf8
	 zKSoZmvWoGqyuvgYtvK0xvbQXEMdKyYm/j5bwJkHO9yq+1t2sFph9DhB3DX0UI3iTS
	 HBpr6VbAdYIPRquuJXBaOoFvOP5jY2rW3L7fIBh8C1xmQ0arHxpnVF2IAuSF56SfxH
	 ADmN1jaoqdcBQ==
Message-ID: <2703b7c43779c8fbe6a8440bc7554aa348648079.camel@kernel.org>
Subject: Re: [PATCH] lockd: Regenerate NLMv4 XDR code
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Date: Tue, 30 Jun 2026 11:59:26 -0400
In-Reply-To: <20260630155638.874492-1-cel@kernel.org>
References: <20260630155638.874492-1-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22892-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 547EE6E63F7

On Tue, 2026-06-30 at 11:56 -0400, Chuck Lever wrote:
> The checked-in NLMv4 xdrgen output predates the addition of enum
> value validation to generated decoders. As a result the decoders for
> fsh4_mode, fsh4_access, and nlm4_stats still accept any 32-bit value,
> while the current generator rejects values outside the enumeration.
> Resync the generated files with the in-tree xdrgen by regenerating
> from the unchanged nlm4.x specification.
>=20
> This is a plain regeneration with no specification change; it also
> refreshes the recorded specification modification time to show that
> all existing enum decoders have picked up the xdrgen tool fix.
>=20
> Signed-off-by: Chuck Lever <cel@kernel.org>
> ---
>  fs/lockd/nlm3xdr_gen.c               |  2 +-
>  fs/lockd/nlm3xdr_gen.h               |  2 +-
>  fs/lockd/nlm4xdr_gen.c               | 47 ++++++++++++++++++++++++++--
>  fs/lockd/nlm4xdr_gen.h               |  2 +-
>  fs/nfsd/nfs4xdr_gen.c                |  2 +-
>  fs/nfsd/nfs4xdr_gen.h                |  2 +-
>  include/linux/sunrpc/xdrgen/nfs4_1.h |  2 +-
>  include/linux/sunrpc/xdrgen/nlm3.h   |  2 +-
>  include/linux/sunrpc/xdrgen/nlm4.h   |  2 +-
>  9 files changed, 53 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/lockd/nlm3xdr_gen.c b/fs/lockd/nlm3xdr_gen.c
> index 9ed5a41b5daf..352a694ca0f5 100644
> --- a/fs/lockd/nlm3xdr_gen.c
> +++ b/fs/lockd/nlm3xdr_gen.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Generated by xdrgen. Manual edits will be lost.
>  // XDR specification file: ../../Documentation/sunrpc/xdr/nlm3.x
> -// XDR specification modification time: Thu Apr 23 10:56:34 2026
> +// XDR specification modification time: Mon Jun 29 20:39:34 2026
> =20
>  #include <linux/sunrpc/svc.h>
> =20
> diff --git a/fs/lockd/nlm3xdr_gen.h b/fs/lockd/nlm3xdr_gen.h
> index c99038e99805..d24cbb887b7f 100644
> --- a/fs/lockd/nlm3xdr_gen.h
> +++ b/fs/lockd/nlm3xdr_gen.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Generated by xdrgen. Manual edits will be lost. */
>  /* XDR specification file: ../../Documentation/sunrpc/xdr/nlm3.x */
> -/* XDR specification modification time: Thu Apr 23 10:56:34 2026 */
> +/* XDR specification modification time: Mon Jun 29 20:39:34 2026 */
> =20
>  #ifndef _LINUX_XDRGEN_NLM3_DECL_H
>  #define _LINUX_XDRGEN_NLM3_DECL_H
> diff --git a/fs/lockd/nlm4xdr_gen.c b/fs/lockd/nlm4xdr_gen.c
> index 1c8c221db456..004ea01c689e 100644
> --- a/fs/lockd/nlm4xdr_gen.c
> +++ b/fs/lockd/nlm4xdr_gen.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Generated by xdrgen. Manual edits will be lost.
>  // XDR specification file: ../../Documentation/sunrpc/xdr/nlm4.x
> -// XDR specification modification time: Thu Dec 25 13:10:19 2025
> +// XDR specification modification time: Mon Jun 29 20:39:36 2026
> =20
>  #include <linux/sunrpc/svc.h>
> =20
> @@ -20,6 +20,16 @@ xdrgen_decode_fsh4_mode(struct xdr_stream *xdr, fsh4_m=
ode *ptr)
> =20
>  	if (xdr_stream_decode_u32(xdr, &val) < 0)
>  		return false;
> +	/* Compiler may optimize to a range check for dense enums */
> +	switch (val) {
> +	case fsm_DN:
> +	case fsm_DR:
> +	case fsm_DW:
> +	case fsm_DRW:
> +		break;
> +	default:
> +		return false;
> +	}
>  	*ptr =3D val;
>  	return true;
>  }
> @@ -31,6 +41,16 @@ xdrgen_decode_fsh4_access(struct xdr_stream *xdr, fsh4=
_access *ptr)
> =20
>  	if (xdr_stream_decode_u32(xdr, &val) < 0)
>  		return false;
> +	/* Compiler may optimize to a range check for dense enums */
> +	switch (val) {
> +	case fsa_NONE:
> +	case fsa_R:
> +	case fsa_W:
> +	case fsa_RW:
> +		break;
> +	default:
> +		return false;
> +	}
>  	*ptr =3D val;
>  	return true;
>  }
> @@ -62,7 +82,30 @@ xdrgen_decode_int32(struct xdr_stream *xdr, int32 *ptr=
)
>  static bool __maybe_unused
>  xdrgen_decode_nlm4_stats(struct xdr_stream *xdr, nlm4_stats *ptr)
>  {
> -	return xdr_stream_decode_be32(xdr, ptr) =3D=3D 0;
> +	__be32 raw;
> +	u32 val;
> +
> +	if (xdr_stream_decode_be32(xdr, &raw) < 0)
> +		return false;
> +	val =3D be32_to_cpu(raw);
> +	/* Compiler may optimize to a range check for dense enums */
> +	switch (val) {
> +	case NLM4_GRANTED:
> +	case NLM4_DENIED:
> +	case NLM4_DENIED_NOLOCKS:
> +	case NLM4_BLOCKED:
> +	case NLM4_DENIED_GRACE_PERIOD:
> +	case NLM4_DEADLCK:
> +	case NLM4_ROFS:
> +	case NLM4_STALE_FH:
> +	case NLM4_FBIG:
> +	case NLM4_FAILED:
> +		break;
> +	default:
> +		return false;
> +	}
> +	*ptr =3D raw;
> +	return true;
>  }
> =20
>  static bool __maybe_unused
> diff --git a/fs/lockd/nlm4xdr_gen.h b/fs/lockd/nlm4xdr_gen.h
> index b6008b296a3e..b5898f0e0689 100644
> --- a/fs/lockd/nlm4xdr_gen.h
> +++ b/fs/lockd/nlm4xdr_gen.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Generated by xdrgen. Manual edits will be lost. */
>  /* XDR specification file: ../../Documentation/sunrpc/xdr/nlm4.x */
> -/* XDR specification modification time: Thu Dec 25 13:10:19 2025 */
> +/* XDR specification modification time: Mon Jun 29 20:39:36 2026 */
> =20
>  #ifndef _LINUX_XDRGEN_NLM4_DECL_H
>  #define _LINUX_XDRGEN_NLM4_DECL_H
> diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
> index a6725c773768..e5a6ea4a9349 100644
> --- a/fs/nfsd/nfs4xdr_gen.c
> +++ b/fs/nfsd/nfs4xdr_gen.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Generated by xdrgen. Manual edits will be lost.
>  // XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x
> -// XDR specification modification time: Wed Mar 25 11:40:02 2026
> +// XDR specification modification time: Tue Jun 30 11:56:05 2026
> =20
>  #include <linux/sunrpc/svc.h>
> =20
> diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
> index f6a458a07406..4092379a9efa 100644
> --- a/fs/nfsd/nfs4xdr_gen.h
> +++ b/fs/nfsd/nfs4xdr_gen.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Generated by xdrgen. Manual edits will be lost. */
>  /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
> -/* XDR specification modification time: Wed Mar 25 11:40:02 2026 */
> +/* XDR specification modification time: Tue Jun 30 11:56:05 2026 */
> =20
>  #ifndef _LINUX_XDRGEN_NFS4_1_DECL_H
>  #define _LINUX_XDRGEN_NFS4_1_DECL_H
> diff --git a/include/linux/sunrpc/xdrgen/nfs4_1.h b/include/linux/sunrpc/=
xdrgen/nfs4_1.h
> index 356c3da9f4e0..6ff4d727b0d2 100644
> --- a/include/linux/sunrpc/xdrgen/nfs4_1.h
> +++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Generated by xdrgen. Manual edits will be lost. */
>  /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
> -/* XDR specification modification time: Wed Mar 25 11:40:02 2026 */
> +/* XDR specification modification time: Tue Jun 30 11:56:05 2026 */
> =20
>  #ifndef _LINUX_XDRGEN_NFS4_1_DEF_H
>  #define _LINUX_XDRGEN_NFS4_1_DEF_H
> diff --git a/include/linux/sunrpc/xdrgen/nlm3.h b/include/linux/sunrpc/xd=
rgen/nlm3.h
> index 897e7d91807c..3cc69a09c1c7 100644
> --- a/include/linux/sunrpc/xdrgen/nlm3.h
> +++ b/include/linux/sunrpc/xdrgen/nlm3.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Generated by xdrgen. Manual edits will be lost. */
>  /* XDR specification file: ../../Documentation/sunrpc/xdr/nlm3.x */
> -/* XDR specification modification time: Thu Apr 23 10:56:34 2026 */
> +/* XDR specification modification time: Mon Jun 29 20:39:34 2026 */
> =20
>  #ifndef _LINUX_XDRGEN_NLM3_DEF_H
>  #define _LINUX_XDRGEN_NLM3_DEF_H
> diff --git a/include/linux/sunrpc/xdrgen/nlm4.h b/include/linux/sunrpc/xd=
rgen/nlm4.h
> index e95e8f105624..7b6f10ea2838 100644
> --- a/include/linux/sunrpc/xdrgen/nlm4.h
> +++ b/include/linux/sunrpc/xdrgen/nlm4.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Generated by xdrgen. Manual edits will be lost. */
>  /* XDR specification file: ../../Documentation/sunrpc/xdr/nlm4.x */
> -/* XDR specification modification time: Thu Dec 25 13:10:19 2025 */
> +/* XDR specification modification time: Mon Jun 29 20:39:36 2026 */
> =20
>  #ifndef _LINUX_XDRGEN_NLM4_DEF_H
>  #define _LINUX_XDRGEN_NLM4_DEF_H


Reviewed-by: Jeff Layton <jlayton@kernel.org>

