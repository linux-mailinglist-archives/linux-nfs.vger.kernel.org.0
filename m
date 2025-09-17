Return-Path: <linux-nfs+bounces-14506-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DBCB7F376
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 15:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C8B17FDA7
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 13:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BBF333A93;
	Wed, 17 Sep 2025 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CkfZMU8b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-24425.protonmail.ch (mail-24425.protonmail.ch [109.224.244.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E15C330D28
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114354; cv=none; b=TJcdkrzXXGZuPJ4qPWQSE6UNlbPKG+WCxU3A0vL/9G/amS5J21cZ+MLqb/vZ/s7ROZr5rNhKtbqxagkIoVVOL4Za75kvDNv47dAFGa52rSyigp2Vcp3ed0te8syWFcSlZV9KsT2hC75AaGSya3EgDyida+Ur+5EQPvjE/17s9/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114354; c=relaxed/simple;
	bh=pE20QNusmh3KnKDfz0j/sI1pSJWMQ7cjA/mNmZQ1rs0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBajFa9+A0kqVp52OddLs2lc4yLcvy2LE2KZc7fQ0hTFmf12/wK2cvvU2+f+H32bWu6m8vLzZg1BsmDQe5T7yAZzr0axeRzvR0t7z6mRrYte7uKOWluZ8b2FycoLlPKly7Fh/oxtI68aOSHdO8q/trN8mnoUqWUij94B4ZVrT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CkfZMU8b; arc=none smtp.client-ip=109.224.244.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1758114343; x=1758373543;
	bh=/lLmp9PxM747wVdbOurJh8wFaXphjSWJ1PSapEeKH9c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CkfZMU8byVjTk7vsJos0dEi/4RWN4HCtq3n7vnsvUlc55r8ILH6Ay/HowWdDN7quC
	 FLq82Cv4tN87zPCLzf0ndp7NlErPUfbfTtixrTbAxRdhjOPOW6NBpu5okb6RI9YjAE
	 PUX0daF2kCoMNCiUfKVAZ3kWapX/zjFOn3BpNIY9yt3NbVpDorGBr0uJCoLiB4Uqc5
	 jdqzfRY2pWRdJMgqRxbjtjUozeEy9MvASUMNgZG2JqsQJi7krASjqHMTpeF+7p9CKy
	 tC4YbNfG1R01+5erGtsEfZRFIdrB8mU49U3fQJhHNslwYIo/qOW6I+shG7+TGoczqO
	 Nn7ghiQCtoPBg==
Date: Wed, 17 Sep 2025 13:05:38 +0000
To: John <therealgraysky@proton.me>
From: John <therealgraysky@proton.me>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "steved@redhat.com" <steved@redhat.com>
Subject: Re: [PATCH] fix cleanup_lockfiles function linkage in exportd
Message-ID: <uxZp7h_Dq5tO5u9-g7sFF_CjsukrA29o5nO-R-M47IC8r8Knhx5BBl-qfz5QlXLw4ay-MVxfRRxVomyVn3y60zTXv0gizit4FEjxUJtWSSY=@proton.me>
In-Reply-To: <nflkbymsZf-JPtqHSc_evn9hseuYTvvgOCi606D0q7qJmzqBgiTg17wPCbWZLOnSEPoc7gftHIdaFz-bJm-5nI1-QFGSHYBe1trF6yMyAsI=@proton.me>
References: <nflkbymsZf-JPtqHSc_evn9hseuYTvvgOCi606D0q7qJmzqBgiTg17wPCbWZLOnSEPoc7gftHIdaFz-bJm-5nI1-QFGSHYBe1trF6yMyAsI=@proton.me>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: e47e836bbbcd9ffb78f46d6fe2d977a53e653783
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I am unsubscribing. Please cc me on any replies to this patch.=20

On Sunday, August 24th, 2025 at 12:19 PM, John <therealgraysky@proton.me> w=
rote:

> From d18643a9fe0e612e823d07cb75d36b4641033f09 Mon Sep 17 00:00:00 2001
> From: John Audia therealgraysky@proton.me
>=20
> Date: Sun, 24 Aug 2025 11:00:44 -0400
> Subject: [PATCH] fix cleanup_lockfiles function linkage in exportd
>=20
> The cleanup_lockfiles function in utils/exportd/exportd.c was declared
> as 'inline void' without a proper function prototype, causing linker
> errors during the build process:
>=20
> exportd.c:(.text+0x5a): undefined reference to `cleanup_lockfiles' export=
d.c:(.text.startup+0x317): undefined reference to` cleanup_lockfiles'
>=20
> This occurred because:
> 1. The inline keyword prevented the compiler from generating a callable
> function symbol in some build configurations
> 2. The function lacked a proper prototype declaration, triggering
> -Werror=3Dmissing-prototypes
>=20
> The fix changes the function to:
> - Remove the 'inline' keyword to ensure symbol generation
> - Add a proper static function prototype
> - Make the function 'static' since it's only used within exportd.c
>=20
> This resolves both the linking error and the missing prototype warning,
> allowing exportd to build successfully in OpenWrt's cross-compilation
> environment.
> ---
> utils/exportd/exportd.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
> index a2e370ac506f..956e4d732f00 100644
> --- a/utils/exportd/exportd.c
> +++ b/utils/exportd/exportd.c
> @@ -51,9 +51,10 @@ static char shortopts[] =3D "d:fghs:t:liT:";
> /*
> * Signal handlers.
> */
> +static void cleanup_lockfiles(void);
> inline static void set_signals(void);
>=20
> -inline void
> +static void
> cleanup_lockfiles (void)
> {
> unlink(etab.lockfn);
> --
> 2.50.1
> 

