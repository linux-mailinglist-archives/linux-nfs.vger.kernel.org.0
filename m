Return-Path: <linux-nfs+bounces-21614-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHLjHOr9BWrFdwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21614-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 18:52:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAA3544F45
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 18:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E64F3004CB6
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7910E33F58A;
	Thu, 14 May 2026 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGzg03eL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559423176E0
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777572; cv=none; b=ezhWSxpMU2B7Aqt5CQrukZl7BhXvntKvSHf7t05K/t8iReqiTXijnCZ8sgXwDgv4u/1CBkUizYLPQodHzRu+QEwpTJKxCHv8vSiXeBiBmdp5dVHabioGNW3wjRLrzYJxvwJEQiTbP8WMXp8GRuKfR8VBh0gPVKVJcvi1kTkTm2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777572; c=relaxed/simple;
	bh=OMcNqaUdrmGVakiu6L87tgWp5rdx1vWag9eFliaNj9M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQYi4a/q45Y9LmZpGQkOTzrnTjqfiOV/vRRKh12oIIAbmQFRzB6bAFIUTKIrI+fUk5kKWKqkQt33k2eHtK0vTKt9Z5JG6pRmlKRRTFX38j0f9pAFWZCUcYsVZKfcOeTHPNhvcTBz3vZUjDakXfAmAO/O/UNx/pHxq97ciRCTljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGzg03eL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6DAC2BCB3;
	Thu, 14 May 2026 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778777571;
	bh=OMcNqaUdrmGVakiu6L87tgWp5rdx1vWag9eFliaNj9M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tGzg03eLor8/+Ao3tjUGYZvoezVE9p645KJ6HVldfPqrozfqHJHZx0Y+7gXehwvcU
	 UGxNhh+hJb2dhj8jqiOOCyni7drL/65s7+/NDslov1K9/B163koMgt/Rcsplpc8GzX
	 ceVZojZ3T35BanL/hFCJ5khQycx5wqbrlMJ0PgnnaO8d4W8kw9AQFzwyOpjorFldCl
	 fW1esGxLITu117JngCo6jdIpPAeajRgKys4KvhFDu5Z8kefa9Ij++GzEH49Pa+8P8e
	 +c286edyBCGavd8vlowFor8U2/9R+5pCQ1rjNqEdsfcjeNyWMgFyqh5yG+8FCVP9Ty
	 WwvbGT/LSjFWg==
Message-ID: <5229a9746d723a3f830120c0b966510f75badfc2.camel@kernel.org>
Subject: Re: [PATCH 00/38] lockd: Convert NLMv3 server-side procedures to
 xdrgen
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 14 May 2026 12:52:48 -0400
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8CAA3544F45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21614-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Action: no action

On Tue, 2026-05-12 at 14:13 -0400, Chuck Lever wrote:
> This series finishes the xdrgen migration of lockd's server-side
> stack. The companion NLMv4 work landed earlier; here the
> remaining hand-written XDR in fs/lockd/xdr.c is retired in
> favour of code generated from a new
> Documentation/sunrpc/xdr/nlm3.x.
>=20
> XDR helpers now do wire-format conversion only. NLMv3's
> 32-bit range limit on TEST conflict-holder byte ranges is
> clamped at the proc function rather than inside loff_t_to_s32()
> in the encoder. The HP-UX zero-length cookie rewrite that
> svcxdr_decode_cookie() has carried since the original kernel
> import is dropped on the server side; the generated decoder
> reproduces the cookie verbatim, and neither NLM_TEST reply
> matching nor CANCEL_MSG depends on the substitution.
>=20
> A wrapper struct bridges each generated argument type with
> lockd's legacy lockd_lock/lockd_cookie/lockd_res internals.
> Each handler reaches xdrgen-decoded fields through argp->xdrgen
> and the legacy layout through a wrapper member that the handler
> populates explicitly, typically in nlm3svc_lookup_file(). The
> core lockd helpers and the async callback path operate on the
> legacy types unchanged, which is what keeps the conversion
> incremental.
>=20
> .pc_argzero is cleared for every converted procedure: the
> generated decoders fill the substructure they own, so the
> dispatch layer's zero-memset is no longer needed. The
> trade-off is that any wrapper field a handler reads must be
> initialized explicitly. lock members are populated by
> nlm3svc_lookup_file(), or on the GRANTED path by the new
> nlm_lock_to_lockd_lock() helper.
>=20
> Five NLMv4 fixes at the head of the series and three cleanup
> patches at the tail bracket the conversion. The six lockd_
> struct renames between them are split out so that each
> conversion patch reads as a single concern.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> ---
> Chuck Lever (38):
>       lockd: Stop warning on nlm__int__drop_reply in !V4 cast_status
>       lockd: Correct kernel-doc status descriptions for NLMv4 GRANTED
>       lockd: Drop locks_init_lock() from nlm4_lock_to_lockd_lock()
>       lockd: Translate nlm__int__deadlock in __nlm4svc_proc_lock_msg()
>       lockd: Do not monitor when looking up the LOCK_MSG callback host
>       Documentation: Add the RPC language description of NLM version 3
>       lockd: Rename struct nlm_cookie to lockd_cookie
>       lockd: Rename struct nlm_lock to lockd_lock
>       lockd: Rename struct nlm_args to lockd_args
>       lockd: Rename struct nlm_res to lockd_res
>       lockd: Rename struct nlm_reboot to lockd_reboot
>       lockd: Rename struct nlm_share to lockd_share
>       lockd: Use xdrgen XDR functions for the NLMv3 NULL procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 TEST procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 LOCK procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 CANCEL procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 UNLOCK procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 GRANTED procedure
>       lockd: Refactor nlmsvc_callback()
>       lockd: Use xdrgen XDR functions for the NLMv3 TEST_MSG procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 LOCK_MSG procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 CANCEL_MSG procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 UNLOCK_MSG procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 GRANTED_MSG procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 TEST_RES procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 LOCK_RES procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 CANCEL_RES procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 UNLOCK_RES procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 GRANTED_RES procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 SM_NOTIFY procedure
>       lockd: Convert NLMv3 server-side undefined procedures to xdrgen
>       lockd: Use xdrgen XDR functions for the NLMv3 SHARE procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 UNSHARE procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 NM_LOCK procedure
>       lockd: Use xdrgen XDR functions for the NLMv3 FREE_ALL procedure
>       lockd: Remove C macros that are no longer used
>       lockd: Remove dead code from fs/lockd/xdr.c
>       lockd: Unify cast_status
>=20
>  Documentation/sunrpc/xdr/nlm3.x    |  168 ++++
>  fs/lockd/Makefile                  |   19 +-
>  fs/lockd/clnt4xdr.c                |   42 +-
>  fs/lockd/clntlock.c                |    2 +-
>  fs/lockd/clntproc.c                |   14 +-
>  fs/lockd/clntxdr.c                 |   44 +-
>  fs/lockd/host.c                    |    4 +-
>  fs/lockd/lockd.h                   |   57 +-
>  fs/lockd/mon.c                     |    2 +-
>  fs/lockd/nlm3xdr_gen.c             |  714 ++++++++++++++
>  fs/lockd/nlm3xdr_gen.h             |   32 +
>  fs/lockd/share.h                   |    4 +-
>  fs/lockd/svc4proc.c                |   69 +-
>  fs/lockd/svclock.c                 |   38 +-
>  fs/lockd/svcproc.c                 | 1844 ++++++++++++++++++++++++------=
------
>  fs/lockd/svcshare.c                |    8 +-
>  fs/lockd/svcsubs.c                 |    2 +-
>  fs/lockd/svcxdr.h                  |  142 ---
>  fs/lockd/trace.h                   |   16 +-
>  fs/lockd/xdr.c                     |  354 -------
>  fs/lockd/xdr.h                     |   39 +-
>  include/linux/sunrpc/xdrgen/nlm3.h |  210 ++++
>  22 files changed, 2538 insertions(+), 1286 deletions(-)
> ---
> base-commit: b26490baad0b7318d763b5ad6e5ca2addb20b314
> change-id: 20260427-nlm4-xdrgen-35bf1c6869b8
>=20
> Best regards,
> -- =20
> Chuck Lever <chuck.lever@oracle.com>


I got a sketchy review from Gemini that I had Claude validate that
looks valid. You may want to add the memset() it recommends:

--------------8<---------------

  Analysis complete. The previous review (against b201ce7af2a2
FREE_ALL) identified the right underlying bug but attributed it to the
wrong commit. Here's the corrected analysis:

  Correct commit: 3de744ee4e45 =E2=80=94 "lockd: Use xdrgen XDR functions f=
or
the NLMv4 TEST procedure"

  The regression: nlm4svc_lookup_file() (introduced in this commit)
copies only fh.len bytes of the file handle without zeroing the
remainder. Combined with .pc_argzero =3D 0 removing the
  defensive memset of the argument buffer, bytes beyond fh.len in lock-
>fh.data contain stale data from previous RPC calls. file_hash() in
fs/lockd/svcsubs.c reads a fixed 32 bytes (NFS2_FHSIZE)
   regardless of actual handle length, so for handles shorter than 32
bytes the hash is non-deterministic =E2=80=94 the same file handle can hash=
 to
different buckets on different calls, causing lock
  state lookup failures.

  Old code had two protections:
  1. pc_argzero =3D sizeof(struct nlm_args) =E2=86=92 zeroed the entire arg=
p
before decode
  2. svcxdr_decode_fhandle() =E2=86=92 memset(fh->data + len, 0, sizeof(fh-
>data) - len)

  Both are gone in the new code.

  Fix: Add memset(lock->fh.data + xdr_lock->fh.len, 0, sizeof(lock-
>fh.data) - xdr_lock->fh.len) after the memcpy in
nlm4svc_lookup_file().

  FINAL REGRESSIONS FOUND: 1
  FINAL UNADDRESSED COMMENTS: 0 (no lore threads found)
  BUG FIX DETERMINATION: not a bug fix
  Fixes tag check for NFSD: NO (not a bug fix)
  Assisted-by: Claude Code:claude-opus-4-6

