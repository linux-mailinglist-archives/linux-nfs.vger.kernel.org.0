Return-Path: <linux-nfs+bounces-15306-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B26BE5104
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 20:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3953ACD85
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 18:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E55222424E;
	Thu, 16 Oct 2025 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5x9m+hN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CCF22129B;
	Thu, 16 Oct 2025 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639510; cv=none; b=FpfNBEoJ52M1x+QfxmNH3jam/2iVYyxfmIO1yOdpDAuKBGDdeCqmB2I+GrRlRklK0OwlIAx3pxUZ6OBZHkdQlYCb0bCTpslhYRD+Ih3cICcA74p4eq2j6VVKrqj6g0mnrXrpIqf2DRiE5yAeNlOYImpKejAjYAMkld6Y8SWaFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639510; c=relaxed/simple;
	bh=Yx1TGj8eN5YIFM/43RluEKE7h+6J4CE6yZh818kFlhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5nZUS9gKkaBC4vBZTwIVqe0Ee+kvK2siyR91Djs7YcKw+UdyA0YQe7O9XjoMsW6IPsER9JFOiRhs7tzF+Q1CwxJ5b3xHTjUxkkamBNLugL2HjrY85TavS44ZMAD2gb5dPFEzqylC13wPogdoLCHnAyDex2eq9C3HrWRJbSnxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5x9m+hN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFF9C4CEF1;
	Thu, 16 Oct 2025 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760639509;
	bh=Yx1TGj8eN5YIFM/43RluEKE7h+6J4CE6yZh818kFlhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5x9m+hNkS6G/56U/qgUB6bWlGwdhkTf71PrQZpHCboibJCebIM73KFu+iI7T5TRa
	 WtuXKTvBPS322owm9TFTqTlTz4FiOIGswxfesLqc8eEP955g8kNaodqz+hnfMWxKsH
	 Z/675ZCdobNLQTNH0rgvh4K/Q/4S0MD0ULOlrS0kOTrjDZd8ASzV3D3kJd6MUXnpry
	 0st/Zg8BxnXzW9JvVCl/IeIE5IECAwh72YavvlkQN3EbERt2QmzE2pMDEz91rbovCe
	 muo6BjQ01/CUSKQ5sO82YQp3IAJL3RD9ZoGhC5U5VGK0rTTNzECLwjb9x4frLaUCZs
	 jJlnFUylEFXAw==
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: Use MD5 library instead of crypto_shash
Date: Thu, 16 Oct 2025 14:31:46 -0400
Message-ID: <176063936413.28537.4413010868699924082.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016181534.17252-1-ebiggers@kernel.org>
References: <20251016181534.17252-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 16 Oct 2025 11:15:34 -0700, Eric Biggers wrote:
> Update NFSD's support for "legacy client tracking" (which uses MD5) to
> use the MD5 library instead of crypto_shash.  This has several benefits:
> 
> - Simpler code.  Notably, much of the error-handling code is no longer
>   needed, since the library functions can't fail.
> 
> - Improved performance due to reduced overhead.  A microbenchmark of
>   nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.
> 
> [...]

Applied to nfsd-testing, thanks!

Note that the posted version of this patch does not apply cleanly to
the nfsd-testing branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-testing

Be sure to rebase on that branch when posting subsequence patches
that target NFSD.

[1/1] nfsd: Use MD5 library instead of crypto_shash
      commit: 4a8d4b1d4b8abcc0d73b924d4d15828dd2ead301

--
Chuck Lever


