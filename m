Return-Path: <linux-nfs+bounces-15298-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F22BE42D0
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 17:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A541897812
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03431CDFD5;
	Thu, 16 Oct 2025 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8qZYiAk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9827D50276;
	Thu, 16 Oct 2025 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627966; cv=none; b=WBf8XoiE7ntCAoYAx4RCI9K0YApuzylwa/IGqKouKkO3O/0NFfDwhl4Ja8amrTRfQ1oqc6IDMDu89pjeAHrEI4BZ0H5IPfOsqHH5IxZwlscPlDt6S/l8nUjxo7mj3JTXgjtTOSXVOF9z5p9Yz5RxFKf5p63XdKifTLpVo8FQlLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627966; c=relaxed/simple;
	bh=VP3gpaNwuyarZ13HwFY1tS/jOZyxqpse4mkf0Tx9wvE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SJ04XgsWWJ4vGEZLrFk3UxzgB5rG76un//yQf9e6ImORodidYtxOzJlYh/O9aLCNFW45mqCWP6KY9DGD9AYXjPkx3s8UEHi9YuTHSui3u7e3PTVVcSN05+RBgkioH591WVVIrFLGxmonE51xyd99oFe1cbKMbtuS2tr7nXMcWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8qZYiAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A22CC4CEFB;
	Thu, 16 Oct 2025 15:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760627966;
	bh=VP3gpaNwuyarZ13HwFY1tS/jOZyxqpse4mkf0Tx9wvE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=X8qZYiAkaMMglo/mcmYKHi1dX8R0E6VXevv/XPLGwoum8SuO8jQhsTMAss6D8LEYv
	 nNvSC0B43y0eVQ2Pk8Q/Qv+77HdlLbj26G+HcqBY5dQwwsR8ZYusYi3gqcBaOh9Bur
	 815BtLbMX9KEe/MCpfQmrdbEuo14dhhboTKxKYJvNqMLMRv7Qo97IBn/6bKrvBZ7mN
	 P5EibhukS62arTMmiUOLdPC6i8CQixP9Fv4iwZeLurNC6RF+xw816TbghU8T2MhoiZ
	 Ro6NdDcUWkoKqfiKvhgoQpApTWfktjSnWbTtRTNleLMSQYX5s5gK7+qheZhXxudO0/
	 kzVmbImGHnz1Q==
Message-ID: <99d95e27637c6eeb82939d98d6aa3344b7518d89.camel@kernel.org>
Subject: Re: [GIT PULL] NFSD changes for v6.18
From: Trond Myklebust <trondmy@kernel.org>
To: Chuck Lever <cel@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
  Jeff Layton <jlayton@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Date: Thu, 16 Oct 2025 11:19:24 -0400
In-Reply-To: <b97cea29-4ab7-4fb6-85ba-83f9830e524f@kernel.org>
References: <20251006135010.2165-1-cel@kernel.org>
	 <CAMuHMdVYNUBH11trBr2Mo3i_fDh5sw5AzqYbPwO7_m4H6Y3sfA@mail.gmail.com>
	 <20251013192103.GA61714@google.com>
	 <f3a3f734-e75a-4d93-9a89-988417d5008c@kernel.org>
	 <96e2c0717722be57011f4670b1a6b19bb5f4ef48.camel@kernel.org>
	 <CAMuHMdX-LN-uhecx_ZJ9DokNJQ-0maGiLij_u9LVhNk9TODFVA@mail.gmail.com>
	 <b97cea29-4ab7-4fb6-85ba-83f9830e524f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 11:04 -0400, Chuck Lever wrote:
> On 10/16/25 10:36 AM, Geert Uytterhoeven wrote:
> > Hi Jeff,
> >=20
> > On Thu, 16 Oct 2025 at 16:31, Jeff Layton <jlayton@kernel.org>
> > wrote:
> > > On Mon, 2025-10-13 at 15:37 -0400, Chuck Lever wrote:
> > > > On 10/13/25 3:21 PM, Eric Biggers wrote:
> > > > > On Mon, Oct 13, 2025 at 12:15:52PM +0200, Geert Uytterhoeven
> > > > > wrote:
> > > > > > Hi Chuck, Eric,
> > > > > >=20
> > > > > > On Wed, 8 Oct 2025 at 00:05, Chuck Lever <cel@kernel.org>
> > > > > > wrote:
> > > > > > > Eric Biggers (4):
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SUNRPC: Make RPCSEC_GSS_KRB5 s=
elect CRYPTO instead
> > > > > > > of depending on it
> > > > > >=20
> > > > > > This is now commit d8e97cc476e33037 ("SUNRPC: Make
> > > > > > RPCSEC_GSS_KRB5
> > > > > > select CRYPTO instead of depending on it") in v6.18-rc1.
> > > > > > As RPCSEC_GSS_KRB5 defaults to "y", CRYPTO is now auto-
> > > > > > enabled in
> > > > > > defconfigs that didn't enable it before.
> > > > >=20
> > > > > Now the config is:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 config RPCSEC_GSS_KRB5
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Secure RPC: =
Kerberos V mechanism"
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on SUNRPC
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SUNRPC_GSS
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select CRYPTO
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select CRYPTO_SKCIPHER
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select CRYPTO_HASH
> > > > >=20
> > > > > Perhaps the 'default y' should be removed?
> > > > >=20
> > > > > Chuck, do you know why it's there?
> > > > The "default y" was added by 2010 commit df486a25900f ("NFS:
> > > > Fix the
> > > > selection of security flavours in Kconfig"), then modified
> > > > again by
> > > > commit e3b2854faabd ("SUNRPC: Fix the SUNRPC Kerberos V
> > > > RPCSEC_GSS
> > > > module dependencies") in 2011.
> > > >=20
> > > > Copying Trond, the author of both of those patches.
> > >=20
> > > Looking at this a bit closer, maybe a patch like this is what we
> > > want?
> > > This should make it so that we only enable RPCSEC_GSS_KRB5 if
> > > CRYPTO is
> > > already enabled:
> > >=20
> > > diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
> > > index 984e0cf9bf8a..d433626c7917 100644
> > > --- a/net/sunrpc/Kconfig
> > > +++ b/net/sunrpc/Kconfig
> > > @@ -19,9 +19,8 @@ config SUNRPC_SWAP
> > > =C2=A0config RPCSEC_GSS_KRB5
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Secure RPC: Kerb=
eros V mechanism"
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on SUNRPC
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y if CRYPTO
> >=20
> > This merely controls the default, the user can still override it.
> > Implementing your suggestion above would mean re-adding "depends on
> > CRYPTO", i.e. reverting commit d8e97cc476e33037.
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SUNRPC_GSS
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select CRYPTO
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select CRYPTO_SKCIPHER
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select CRYPTO_HASH
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> >=20
> > Gr{oetje,eeting}s,
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Geert
> >=20
>=20
> The graph of dependencies and selects between NFS, NFSD, and SUNRPC
> is
> brittle, unfortunately. I suggest reverting d8e97cc476e33037 for now
> while a proper solution is worked out and then tested.
>=20

Yes. The reason why I went for the weaker 'default y if ...' and
'depends on ...' is precisely because 'select' is so brittle, and at
the time others advised against using it for more complicated
situations such as this. The crypto code has a number of dependencies,
and those have been known to change both over time and across hardware
platforms.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

