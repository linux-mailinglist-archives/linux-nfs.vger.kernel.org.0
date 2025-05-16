Return-Path: <linux-nfs+bounces-11785-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6140ABA6AA
	for <lists+linux-nfs@lfdr.de>; Sat, 17 May 2025 01:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11711BC5FAC
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 23:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763B1280A33;
	Fri, 16 May 2025 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwxBzKxO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5E280326;
	Fri, 16 May 2025 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747438841; cv=none; b=IvIBeq+/GKOp+4zKzJtc4FcTs5k640bXRfBdbUdbDtp0YEb8negRSFWz3kAhKV/oyNqjKCXdoLA7tsjCgRqx9uzPe73o8Q0/tnDt4Vm+pqm7k7a5R/bG11kYAq1kGQreLoOgmWhF0T5pjTPScd0RSzGu2Zjm1mlzznr0M7A/R9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747438841; c=relaxed/simple;
	bh=SrPkNs1/hve/LFwNA7kWRPRFF6L+LcCn7z8eFNsV6b4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Mk3KziWyV7abiPlg1HGos6FppOdRfmYE8/wzNW9+OFeIY0OJeEtDXMh1HU4aowykmaCz72wcr1oJPwky0N3dbLTbqmAlV42nWMTD1HP582TQ79C2WaWqmHD+oD/Qkj4RJzY6/H3kFr9NX7+e+fBWmWUbgUlDdyFIX0dQ95TNMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwxBzKxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302BEC4CEE4;
	Fri, 16 May 2025 23:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747438841;
	bh=SrPkNs1/hve/LFwNA7kWRPRFF6L+LcCn7z8eFNsV6b4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IwxBzKxOXadniuOyNtXaPgwgmojYziRQ4LzJmswr9tgPzaQlWPvY2BFIxis3HjpFG
	 5cLMBcgYWGU9sndMHSJuXiPQFvQUsQSYZ/IqEOYv5U6c7ME2p8UvOvrxnnCdP+41oO
	 plri4tXPMfAR+TuQ+UtKjL+NoGs0xellXeF51rs1pCRRG3GHVGBXtNjGFOaeplQBw2
	 zSJAV9j9BtGNV3g6VHCO2pC84pfefJ+TPBWUTHjEX3IfQvkWoBYRv7rPYrhxBdIlS1
	 hUXQjRijHaZ5z5FeiJwtv2WXd6fxIbUV5B9/B1Q0z2jiuC5NDKroTNMJabbs1jhSQ0
	 5McGZalHCpzDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3431E3806659;
	Fri, 16 May 2025 23:41:19 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client bugfixes for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <983483fc86a4059a33e11968387f2faca29413ab.camel@hammerspace.com>
References: <983483fc86a4059a33e11968387f2faca29413ab.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <983483fc86a4059a33e11968387f2faca29413ab.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.15-2
X-PR-Tracked-Commit-Id: dcd21b609d4abc7303f8683bce4f35d78d7d6830
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 450d2f6e8829b8a153e58b37c697a4ab656e0801
Message-Id: <174743887791.4096732.9840507549178541004.pr-tracker-bot@kernel.org>
Date: Fri, 16 May 2025 23:41:17 +0000
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 May 2025 20:38:27 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.15-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/450d2f6e8829b8a153e58b37c697a4ab656e0801

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

