Return-Path: <linux-nfs+bounces-8442-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E9C9E88C7
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 01:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E36918836CB
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 00:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704D319BBC;
	Mon,  9 Dec 2024 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZNaiQaA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E48AD2C
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733705617; cv=none; b=tgDZkvDSRBgMGHIiUUip/spF2FgWxfX1Nm60Y+n1VPjjHFgk2giGge6jdFw2zxv+yihGZ/HS2FLwEOGP33OI7Z75NpGWKDQv1/JqoxEoIoz9rWjNaPVF40mBJIQ645YSziAqESFp0hQ/Q8eKiqKkZuo8CXwHvD5us5dMGFuvxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733705617; c=relaxed/simple;
	bh=euJLNu/ozKuUfN4rLHyjVTOg6Zbbm3BGVF3YJyO9E/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8+oZSkWBxxeUAiWxD+0iEGe8NuJn0R06Ekun/DHGpCpnSohrRVgikOEJ3hNvWNp/VJAH4hrePr/hPO2eSE15YUPWwnSRh2pab3qfstZXcBRjZDO5DaO92Hx3ynEN1HXljs7OrmKA3aSdO0/jrmuLmDbOEiTvaV4x6RUuv7Oa18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZNaiQaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78847C4CED2;
	Mon,  9 Dec 2024 00:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733705617;
	bh=euJLNu/ozKuUfN4rLHyjVTOg6Zbbm3BGVF3YJyO9E/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZNaiQaAx/EZ8PfYaNcsPv8j69mHztMD0t2z28/Y83Os3tgwNKAUHGktiuluS9FSm
	 mAM9RqFO0Ly0g3l1oFPFaX52Ivb91W8y9OOBrGG7H7U+YZyrBf/nXkF/kdG41Lztb8
	 9rVL+rBeNlruf0EBrYMWXKVQ67Itp5Abo9BUiglBnd3Lg8lUeOD2l84CQbd4Mb4kJ9
	 jvY7PemkN4hg1cmXuv8vA0zKk+rDfjRfj6a7NNvqrYV1PhTDpe5zEOkEF8rY4Vp70G
	 8uLqcVF95yXKLLC/nhCGYEVXRQWhpCLRBRXsUfkSoFLjygQBdVFluKp+GSegOikWG2
	 2HK6HZ0FovUDA==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 1/6] nfsd: use an xarray to store v4.1 session slots
Date: Sun,  8 Dec 2024 19:53:30 -0500
Message-ID: <173370556434.1781407.6644392216606855682.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241208224629.697448-2-neilb@suse.de>
References: <20241208224629.697448-1-neilb@suse.de> <20241208224629.697448-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 09 Dec 2024 09:43:12 +1100, NeilBrown wrote:
> Using an xarray to store session slots will make it easier to change the
> number of active slots based on demand, and removes an unnecessary
> limit.
> 
> To achieve good throughput with a high-latency server it can be helpful
> to have hundreds of concurrent writes, which means hundreds of slots.
> So increase the limit to 2048 (twice what the Linux client will
> currently use).  This limit is only a sanity check, not a hard limit.
> 
> [...]

Applied to nfsd-testing for v6.14, thanks!

[1/6] nfsd: use an xarray to store v4.1 session slots
      commit: 2d8efbc3b656b43a5d1b813e3a778c9b9c8810a4
[2/6] nfsd: remove artificial limits on the session-based DRC
      commit: 8233f78fbd970cbfcb9f78c719ac5a3aac4ea053
[3/6] nfsd: add session slot count to /proc/fs/nfsd/clients/*/info
      commit: c1c0d459067dc044dba36779da8a9da69c2053cb
[4/6] nfsd: allocate new session-based DRC slots on demand.
      commit: c2340cd75a0c99bb68cefde70db5893577f100f4
[5/6] nfsd: add support for freeing unused session-DRC slots
      commit: 22b1fbeea695de4efedf4de4db66be21004f134a
[6/6] nfsd: add shrinker to reduce number of slots allocated per session
      commit: 8af8f01a1bb7d84ad2d176ae00112c96647e151f

--
Chuck Lever


