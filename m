Return-Path: <linux-nfs+bounces-3359-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A518E8CDBA6
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 22:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B05B20902
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 20:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6607126F1A;
	Thu, 23 May 2024 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1QZkGtQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79086ADB;
	Thu, 23 May 2024 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716497750; cv=none; b=HqY5l7QUE7gDJJPdr+F9kK90l6OfazMt5wXUk5GN4fbpYlwRT3BBuqwIUItwTVCqDE7V0DHcCPdQgKjXN+7n/N4R5DDlmxke9g0Dn14jxZITBbi6vt65OJ1AgmULwD/XoGllwcebEQ/eje2GbB5kh33JZW4GalebP66lUI/ak7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716497750; c=relaxed/simple;
	bh=bYJND2brIohOquChRi4KB6JO8mDP1tYK5N0YTGj9HCQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gBNAvUFhXcemU69e+wJtVevm/tApKOAHk5XyQ6mZ1KOSpo/9YGQT3giVfHO7qBpY/73LLlw3oCPGVrmEWohrJVS2elgmeOxhjPlBeSmKSujkilWfq82h7aK4Dxf8fs/AtMyUa1yBDrx5Np9EMJyLJXKx8CID8nfe+pOjcBVhSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1QZkGtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41175C3277B;
	Thu, 23 May 2024 20:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716497750;
	bh=bYJND2brIohOquChRi4KB6JO8mDP1tYK5N0YTGj9HCQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=m1QZkGtQ7HDonUflCim3C0887Ejwpcp2zPTMmYPSmBRgYslg2y9h9+2q0R0Klwa3i
	 BJ1EpfjVTr1bnqQ8k6CE5b8yF8Cv9yc64+tLRpNFgHtVyZlia2MkpeKbJRQdB9W2yz
	 StBPDVJxaI+0U1OVC0TZ5cum9s+CzRNnZF+meswfC5g8hGAXLFi3iyyNYIEt5x4vLp
	 jJwpWI7fQgRxGl15txdtipMY5G2UtVyENbLaYI6X2DpbW6qgTwrRwF63EdJMuL28ie
	 X5N9Qpm0tkBMrZiZoCv2zlHQ1IWyLcm9h0hByJlR9WygDdKuZQsq6AbKaepQqVbZy9
	 Am3Nk6q4Acg9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36EA1C54BB2;
	Thu, 23 May 2024 20:55:50 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client updates for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <c1293d87d1e91d9986cb03c923f714560a0cc4d0.camel@hammerspace.com>
References: <c1293d87d1e91d9986cb03c923f714560a0cc4d0.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c1293d87d1e91d9986cb03c923f714560a0cc4d0.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.10-1
X-PR-Tracked-Commit-Id: 3c0a2e0b0ae661457c8505fecc7be5501aa7a715
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d69b6c12fce479fde7bc06f686212451688a102
Message-Id: <171649775021.3580.15544239282505269594.pr-tracker-bot@kernel.org>
Date: Thu, 23 May 2024 20:55:50 +0000
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 May 2024 20:30:36 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d69b6c12fce479fde7bc06f686212451688a102

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

