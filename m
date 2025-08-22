Return-Path: <linux-nfs+bounces-13872-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19975B319DA
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 15:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4293EBA3FC8
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 13:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9BE30F531;
	Fri, 22 Aug 2025 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM64Blp+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B930748B;
	Fri, 22 Aug 2025 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869798; cv=none; b=OEOfbKklKCOZeL4RXDDoXJC1Uoyd2/AZJciesVEHoqxxSZIeiE4h6UQGhHOB29YcSlmYvke9aivKNHkqVp0QlqV/5dH3kDystRK6Swe3DEP75Iyedr5G3yalX+8liLVcok9+MfNhtLqqkbqqYbNp6ZzYczATHY7QnAvtwkBN/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869798; c=relaxed/simple;
	bh=6bIate8ROgVSH6yQ+ulBpiZ3QCvwL3AjkLqZW8jn7zE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tnRA6HqUBFc2wcUmh5ISU3teET+fa4/NZ9ZTjXSugOQLzpIfYmSbMMRKitizYngJaqjzz4qV3ZwusviGNlXSm50sp4hvDSoW4XGRfOgc56Xu3cuk3pseSB1o6noCi2t+faKiZry032DFNMvPrKBVQCe9JaRE1J3oiQDbDwkcHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM64Blp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82DFC4CEED;
	Fri, 22 Aug 2025 13:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755869798;
	bh=6bIate8ROgVSH6yQ+ulBpiZ3QCvwL3AjkLqZW8jn7zE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NM64Blp+VIYcgOeUZq/DyolM2SCdQrjJWP9PzkhJS3Qy01HcerK1ZeEnnDnKSz6uo
	 d+lC30JvXIbkROKx5OA71csWqz9iX5DX6PsebDy9Z0bRG8ggA3x0mVaniDs7ZgavQL
	 GoyX33hhorRp5bF5e4RIxJps0UbiW0Sy5Xi6ESygZ+lXO9t0IBk0s0swEKb1Dgvjxf
	 nl79m4CY++HCwMETe3BZoWhfVjxelWdBF+BqbTFL3uMGQnpo8zb8h4OyvxYqL8APSi
	 Jb8GULeuTyC7hLSCHmk0Ahb35S64/+PgBJapWNet+v8kOfOmuHWQYCfA+rz486ZOi3
	 bX036bS1ebHWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE28383BF6A;
	Fri, 22 Aug 2025 13:36:48 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull a NFS client bugfix for Linux 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <b72bf6be6869a8540051bdc6d93f59bbac50d3ea.camel@hammerspace.com>
References: <b72bf6be6869a8540051bdc6d93f59bbac50d3ea.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b72bf6be6869a8540051bdc6d93f59bbac50d3ea.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.17-2
X-PR-Tracked-Commit-Id: 76d2e3890fb169168c73f2e4f8375c7cc24a765e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e86ba12cf84ab9cf42fbc2382235fa7ba616e18b
Message-Id: <175586980763.1831455.6536713544286118089.pr-tracker-bot@kernel.org>
Date: Fri, 22 Aug 2025 13:36:47 +0000
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "aksteffen@meta.com" <aksteffen@meta.com>, "jdq@meta.com" <jdq@meta.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Aug 2025 00:57:38 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e86ba12cf84ab9cf42fbc2382235fa7ba616e18b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

