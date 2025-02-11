Return-Path: <linux-nfs+bounces-10035-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4CEA301F4
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 04:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95B03A6CC5
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 03:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D0B1D54D6;
	Tue, 11 Feb 2025 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="felBCsX2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A5D1D54C2;
	Tue, 11 Feb 2025 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739242788; cv=none; b=V5kCrc7dqfxjLLaSzFHTauIYP2d1g04Lxf/kA7VXN1uZTHpWzyHbhh/30kf7dqZCGMXAySJOJlPR3vpSycIKKjmQWvb3++JBevLddRozFtpuHg7aZe3Vm3v1mFkIAkRFm9e83CNTMfTcL+GSbBdO/UZNRx389pw2dEn5Vque/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739242788; c=relaxed/simple;
	bh=Y+L7T+dFCAOOTacW/Q/+ULcCCojr0GjtwRfpqS1+yQQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oJdiaub8cRf/s6fgyiILiEu1BHhyZoqNLaREbq5ewr3jcw9qIDY9a2ptVQi14UF2xnOnT4On/YWau7nXyTt9rHp7bZa4jAAo37st3444GPCNxuHHY+znDf1DqD9Xj4R/gl784oZ6FVS3rwMh2Q8Pc914fCP6ZIRM26yQ8g9RWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=felBCsX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC9DC4CED1;
	Tue, 11 Feb 2025 02:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739242787;
	bh=Y+L7T+dFCAOOTacW/Q/+ULcCCojr0GjtwRfpqS1+yQQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=felBCsX2BsFdhI0JIUG+1nRTxUYaueiCqzFixUVbIsWdgmhqsB7Ws3Lyp3cgakBTB
	 6j2blVQKhD/NO/9i9UqyaYa9y4JBV9cTu/EJdVGkuWGNAk1KZk1lGmsxCdO81CCSod
	 p9XoUIG0ZwgTucJljg1Pyy198r3rl0+u41fIOqEbCOsfLgTE5++fZvK35yw2rZhGFh
	 jfRRFdkERmYxIY8Rb5zgE4vXFPhiYBvC/+eRjnV/KD1Sb/FHc4reccJ8YHJLhIW9GJ
	 ozGI4TJGoqJpJagnmJWHdd0zrRe0TGt5Jjd5Sz6d30E003Joa3R1v+9VbP1rs5XZds
	 iuuaFjJozpRww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0F842380AA7A;
	Tue, 11 Feb 2025 03:00:17 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD fixes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250210185905.116290-1-cel@kernel.org>
References: <20250210185905.116290-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250210185905.116290-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.14-1
X-PR-Tracked-Commit-Id: 4990d098433db18c854e75fb0f90d941eb7d479e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: febbc555cf0fff895546ddb8ba2c9a523692fb55
Message-Id: <173924281574.3934815.3832938738018337391.pr-tracker-bot@kernel.org>
Date: Tue, 11 Feb 2025 03:00:15 +0000
To: cel@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 10 Feb 2025 13:59:05 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/febbc555cf0fff895546ddb8ba2c9a523692fb55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

