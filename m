Return-Path: <linux-nfs+bounces-16886-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A922CA16A2
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 20:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45D9E304764C
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 19:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656BB33290E;
	Wed,  3 Dec 2025 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sbj2Z5qn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD2919C553
	for <linux-nfs@vger.kernel.org>; Wed,  3 Dec 2025 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790178; cv=none; b=bpkgw9rCCHFh+0+F42kfIxehc2PTOc+P9gXKaPc5TKavSYEiMa4AesNVKAJWxdvmBSvzUgWLr89XZrDbY688cNBdVDoB5ZjYG0vfQVgWm3QFiuJJVU1DhK0twRTObS15Rtm0jNX17qdrx6i2WyffRMmVrKO8OJ+QswU/ongpZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790178; c=relaxed/simple;
	bh=HhUHorRdoNyZTbYGPF2HpRGz40aYMjAU7O6QhaqfZJo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AoqWdJlw82k3gbQqO792Y4ADwlSiU6emYuF8tsMK+eEPLusSRNs1n2m/sXRYQgYfgoG8iSIWHD0Eb2h4waY7tiogIH7MVAv9+L67Si109EvMtbDIRgGZUudtVxtzkpJx7+on+JlCwvUVjDiBFyd/fsJ9AfCvLvBga96gCb1CHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sbj2Z5qn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3FFC4CEF5;
	Wed,  3 Dec 2025 19:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764790177;
	bh=HhUHorRdoNyZTbYGPF2HpRGz40aYMjAU7O6QhaqfZJo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Sbj2Z5qncK4vesx3x1PsoIDDZNwfvKRmJo5PXZHP/gAe6JtGmoTShtwr6BG7iNdHJ
	 A3MVW74dLXuBUkXWDhqr5WzBQx07RDxS+zPo9QF9iZYoaGPCJKK+uA5kixdBkZtYD/
	 R81CZAtRwlB6o7/KJBlC4F+juZKGSBt1NUw54IYOY69DRJFlb3bq+Ng6w5izfFl8Ns
	 DERNvs8qlvDzYQ+fglqnWfeTfWlAreijoEcbz3x6MFzNQ/jFanUudHHYt/1eIobLVw
	 Zp13Ae9eFY8leD/cQE6pUYLi5yJ8i+c5cjLqbBRZZFEdGe//G7DI/0FDHhyiOZ5j4y
	 DkxizCj1cPS6Q==
Message-ID: <305f38b14cec83b79921d5e1552ace515db59f24.camel@kernel.org>
Subject: Re: [PATCH v2] SUNRPC: Check if we need to recalculate slack
 estimates
From: Trond Myklebust <trondmy@kernel.org>
To: Scott Mayhew <smayhew@redhat.com>, anna@kernel.org
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Date: Wed, 03 Dec 2025 14:29:35 -0500
In-Reply-To: <20251120121252.3724988-1-smayhew@redhat.com>
References: <20251120121252.3724988-1-smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Scott,

On Thu, 2025-11-20 at 07:12 -0500, Scott Mayhew wrote:
> If the incoming GSS verifier is larger than what we previously
> recorded
> on the gss_auth, that would indicate the GSS cred/context used for
> that
> RPC is using a different enctype than the one used by the machine
> cred/context, and we should recalculate the slack variables
> accordingly.
>=20
> Link: https://bugs.debian.org/1120598
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
> =C2=A0net/sunrpc/auth_gss/auth_gss.c | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/net/sunrpc/auth_gss/auth_gss.c
> b/net/sunrpc/auth_gss/auth_gss.c
> index 5c095cb8cb20..bff5f10581a2 100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -1721,6 +1721,18 @@ gss_validate(struct rpc_task *task, struct
> xdr_stream *xdr)
> =C2=A0	if (maj_stat)
> =C2=A0		goto bad_mic;
> =C2=A0
> +	/*
> +	 * Normally we only recalculate the slack variables once
> after
> +	 * creating a new gss_auth, but we should also do it if the
> incoming
> +	 * verifier has a larger size than what was previously
> recorded.
> +	 * When the incoming verifier is larger than expected, the
> +	 * GSS context is using a different enctype than the one
> used
> +	 * initially by the machine credential. Force a slack size
> update
> +	 * to maintain good payload alignment.
> +	 */
> +	if (cred->cr_auth->au_verfsize < (XDR_QUADLEN(len) + 2))
> +		__set_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth-
> >au_flags);
> +
> =C2=A0	/* We leave it to unwrap to calculate au_rslack. For now we
> just
> =C2=A0	 * calculate the length of the verifier: */
> =C2=A0	if (test_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth-
> >au_flags))

What's the status here? Are you planning to put out a new version with
the non-atomic __set_bit() -> atomic set_bit() change?

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

