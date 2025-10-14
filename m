Return-Path: <linux-nfs+bounces-15217-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDC3BD8086
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 09:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF597188F8D4
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 07:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C3530EF87;
	Tue, 14 Oct 2025 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdcBl1C2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3480A30EF72
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428595; cv=none; b=d3bmN4otaVITvX5JVXkJTwHKEak8M4tQTSpIavPBnYUFVnwXEmbFHU3apBOEUsYVj7Vam1QktPwYaKQOTwpYmybqEFiiRF0lYVFg3tVnYuZkfQNex6g3pT+4U04BWCE1PSiAvsIsWk9T35UVRh8lDegVGdxDm+9fVCiLMp2hw7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428595; c=relaxed/simple;
	bh=7e3X6CSYpEFt02rvSj4dC5FfpVv4bV7rKkRLNoqqmXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjTtKBm8BO5VusjXF1ofeVN8oeCskzQ7k2I5HVldT0+Cm732hgYksc6UyAHDvz72C+ATKQ6AZ+ASsx1c0qXb9FodOXYawK4vkfj18cflvzqAKhYeCQ9WTpyD7mY8I9QF95/WnC7uc5VCh/JRuZWVdjIU0xeQ0UimvX+OnKRbdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdcBl1C2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCF1C4AF0B
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 07:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760428594;
	bh=7e3X6CSYpEFt02rvSj4dC5FfpVv4bV7rKkRLNoqqmXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mdcBl1C2rUUwz9kvTij7etsj8dSRaRgzximJbzCgKEH5yKZWOgC9Cas+2U2ssqqj/
	 y7UXyUJw364qycNq5QfvJaYSOBzRwBwAUWUUPjW/9yFIRsoMh2IFS9zH2AvpxnpLnB
	 /kUmLwyeMPghzmSrApEUvNUJQmEqHCyhTeS6TaWasSmEyCsMhinI/p6y1znpojX7B1
	 g4DFL/AeZmPjRMHSY6Nu678PR5UWfCx9Rg9mswC50tJqDXSoasWTdhh62KmPlW8GMq
	 RRKjI3S5HVjJ3jyTCEWrdQdLH87sTYteflgntax4UrbDjn2iANp6R4iQBby9JxdazU
	 XjiJF/empbieQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6497c23a47aso1535558eaf.1
        for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 00:56:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YxsxK2miA5ZkLLgojH7w6Dd5XObXTM961bLg0zeoybwCl/i+CVZ
	Jv64WiYMPK6EHejP2ntqLVDdRigP0lmuR/KCpYQhDGMRret8T3AP9UIny8v2ubAvKSs7xp2V7+J
	pyD9Gzyw5TZs8vZKF5CPFOYZ91mAYAx8=
X-Google-Smtp-Source: AGHT+IEuTFJEMJdXOfRA2pxTU+ljO7ipLp1dGZShzsMSsnhgvkCjvnaLb9GS6qpqKZ5cZYEIur5xTDXUDfUsmvPCn9E=
X-Received: by 2002:a05:6870:3923:b0:395:9e1b:b0da with SMTP id
 586e51a60fabf-3c0f81fba9bmr11950766fac.49.1760428594243; Tue, 14 Oct 2025
 00:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011185225.155625-1-ebiggers@kernel.org>
In-Reply-To: <20251011185225.155625-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 14 Oct 2025 09:56:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGyML+pG0+DZKV-mXV9Six1RA1AdwCEno7owS6OtKEbEg@mail.gmail.com>
X-Gm-Features: AS18NWArqMNmf7hjAL0i0ZKbeQcoI-zfF7-otCtjcyqINVQX-7-7M2NuhSYPICU
Message-ID: <CAMj1kXGyML+pG0+DZKV-mXV9Six1RA1AdwCEno7owS6OtKEbEg@mail.gmail.com>
Subject: Re: [PATCH] nfsd: Use MD5 library instead of crypto_shash
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Oct 2025 at 20:54, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Update NFSD's support for "legacy client tracking" (which uses MD5) to
> use the MD5 library instead of crypto_shash.  This has several benefits:
>
> - Simpler code.  Notably, much of the error-handling code is no longer
>   needed, since the library functions can't fail.
>
> - Improved performance due to reduced overhead.  A microbenchmark of
>   nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.
>
> - The MD5 code can now safely be built as a loadable module when nfsd is
>   built as a loadable module.  (Previously, nfsd forced the MD5 code to
>   built-in, presumably to work around the unreliablity of the name-based
>   loading.)  Thus, select MD5 from the tristate option NFSD if
>   NFSD_LEGACY_CLIENT_TRACKING, instead of from the bool option NFSD_V4.
>
> To preserve the existing behavior of legacy client tracking support
> being disabled when the kernel is booted with "fips=1", make
> nfsd4_legacy_tracking_init() return an error if fips_enabled.  I don't
> know if this is truly needed, but it preserves the existing behavior.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/nfsd/Kconfig       |  3 +-
>  fs/nfsd/nfs4recover.c | 82 ++++++++-----------------------------------
>  2 files changed, 16 insertions(+), 69 deletions(-)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

