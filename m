Return-Path: <linux-nfs+bounces-13513-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E69C2B1EA83
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 16:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4021AA72C4
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B77E27F198;
	Fri,  8 Aug 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf7DcgIM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684324B26;
	Fri,  8 Aug 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664057; cv=none; b=RhUgxwyg24YSW6sPjok36NvKJ8HjLF76l8g1ZWqFujiiFHb2RD9lESkB+FRGhfF4kLfXDsjocZ4C4mAFECN1ZXcUFMLbELX7EQOttYA13E+B4cpFtO0/z94iTN3NA2I1wNn4F94KBzF5VmjRwa4kgLjEq2Gw8K+fPyWD0GvcFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664057; c=relaxed/simple;
	bh=NajTTKEbnS/xxgPaRpXYD5b1BYz57O5jKJG27kJGGkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccv3Ux90jYmAulAsrwHwMjJrBYno+FqyYC3DTshYreMS8r86KmGE9vYEuxrsSHZPMUPTptJ5G2AGowTwoE7GYe5l1qWEvfVI9gfHu3uyjbOnFOjJX26JNcic6d6kIeV7JRi4txfBPuidC3ZPWscvsaXhZatFPxwzpO44SotY1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf7DcgIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083E2C4CEF4;
	Fri,  8 Aug 2025 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754664056;
	bh=NajTTKEbnS/xxgPaRpXYD5b1BYz57O5jKJG27kJGGkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mf7DcgIM4yNCi6D2qwyEcWgO6ek8SOmIH9BNw81t0HhiobE+IhUvmwqIVdm79m8R4
	 6RSap65Z6Vl6Pb92i8BgqwwQaKHC+/qLNih3AgBIX9NFMpQ0t4XYg1xmH4pT8wnJOy
	 MTyravxxk+hEdFaWWgMIHT+i6YS/MraNP09359zqTVvSlbtxPdhYaRfGdUmUrERZya
	 lHGuyTf5Q+W6aes9X6lGw3Tp+X4082JLazsh/YSXabNYNBIFq2AN0LzgConkWTruzO
	 2fyoS9HMoB72KqLSJEUmPHwGAeraqS5kzSVkYZfESUk+ZGY8/1LLKTV1xXM3Y9qETI
	 WYdz5NpzHYZag==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	stable@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] NFSD: Fix destination buffer size in nfsd4_ssc_setup_dul()
Date: Fri,  8 Aug 2025 10:40:50 -0400
Message-ID: <175466399815.118560.15374288860234204726.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250806011000.62482-2-thorsten.blum@linux.dev>
References: <20250806011000.62482-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 06 Aug 2025 03:10:01 +0200, Thorsten Blum wrote:
> Commit 5304877936c0 ("NFSD: Fix strncpy() fortify warning") replaced
> strncpy(,, sizeof(..)) with strlcpy(,, sizeof(..) - 1), but strlcpy()
> already guaranteed NUL-termination of the destination buffer and
> subtracting one byte potentially truncated the source string.
> 
> The incorrect size was then carried over in commit 72f78ae00a8e ("NFSD:
> move from strlcpy with unused retval to strscpy") when switching from
> strlcpy() to strscpy().
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: Fix destination buffer size in nfsd4_ssc_setup_dul()
      commit: 387d7905fb60d28ae3f2ff8956de626c797e4508

--
Chuck Lever


