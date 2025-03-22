Return-Path: <linux-nfs+bounces-10763-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59543A6CB1E
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 16:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7052177613
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EA121A43C;
	Sat, 22 Mar 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAqZa5Lg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B4347C7
	for <linux-nfs@vger.kernel.org>; Sat, 22 Mar 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742656086; cv=none; b=EVfzii6NQBp7izXgp5dMLAb9wXOsvMccoO4/oqnxHyUThF6Bap3IxxUm2PKyg0x05WKrdZK36YQeM2QE7jh+vpPWO7GxtSgXsyBccXRpIWeKnZvwbGbCXTASGND8PnuuR7LerkbcCbSHKqp9CNY0H8M8nuD4Senx/I55P8LV5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742656086; c=relaxed/simple;
	bh=jTQFY4h5Kjzaso5m14LB60t7ZzftFoZ4RC9Nfd370fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sw3Zqr0igA2Ol8PTrfV/EzSUx3dRawUYti8nWNuDXtLhrHedQDn7nPiCf6vy3J9xHlargZZsUhBnQ+VIbo06C+YTooJTIsLii/YRjlLHLGZ8hpVYwYDBo/8203pPxR34E9d2gSY5L6+0ePWhKghLyxCwf3Vzfc9QH0RMvv1qHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAqZa5Lg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4D0C4CEDD;
	Sat, 22 Mar 2025 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742656086;
	bh=jTQFY4h5Kjzaso5m14LB60t7ZzftFoZ4RC9Nfd370fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAqZa5Lgbcvo3SiBkpPMRHDvsarOeOB3S9BBr7T66NBxfMEV+qwbi+A8MSfc/451P
	 e4rullq8OaPoilLVpooy4ljEQUeqUYnRtinenAiQGNwkhyVVWVXNfYS61HQMdiEOl5
	 da+jn5j7zCll4gKtbIiao6TBio+6xCO2u9RXEBM1EpxTcSCVssoU/DVVqMpp6hva7r
	 MlurdTDLU6Pwr+s6HkGH5FN/0c1769mkIiGn9wzvSYtfSIplJkxB6NdE0OIdXc+jTD
	 NKv1TUJu745mK/MTT5zu6EjRM/KE9LbekyCrCvMCL7yusolbbrYnjDsrqht5jfPIFI
	 XeFtDShmosXYw==
From: cel@kernel.org
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH 0/3] access checking fixes for NLM under security policies
Date: Sat, 22 Mar 2025 11:08:02 -0400
Message-ID: <174265606182.3181780.16683451436857502955.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250322001306.41666-1-okorniev@redhat.com>
References: <20250322001306.41666-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 21 Mar 2025 20:13:03 -0400, Olga Kornievskaia wrote:
> Since commit 4cc9b9f2bf4df ("nfsd: refine and rename NFSD_MAY_LOCK")
> for export policies with "sec=krb5:..." or "xprtsec=tls:.." NLM
> locking calls on v3 mounts fail. And for "sec=krb5" NLM calls it
> also leads to out-of-bounds reference while in check_nfsd_access().
> 
> This patch series address 3 problems.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/3] nfsd: fix access checking for NLM under XPRTSEC policies
      commit: 795be66362cc0bb9386fc40685de7c31d2ec27ea
[2/3] nfsd: adjust nfsd4_spo_must_allow checking order
      commit: 472d09faffb5a46373a74584cfc048df5e6a7bef
[3/3] nfsd: reset access mask for NLM calls in nfsd_permission
      commit: 502d6ba5c749411967b74e8f1aa3c47a8db7637d

--
Chuck Lever


