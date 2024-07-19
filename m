Return-Path: <linux-nfs+bounces-4986-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877159371CA
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 03:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F2B1C20F64
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 01:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5917F79C0;
	Fri, 19 Jul 2024 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKvLfRvD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335AC6FD3
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jul 2024 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721351088; cv=none; b=V3s4b4dD9AO3H6ckXLFDtYs81cZbINUb5onEDFrwKEv37JpejC3FBBjI9cWfFpZecxTTOlpOqZ25EA/1ssa1dNo7Kyya7X0nlGPzvSk7Z0f4F153/+mmOGwmt8IEtvfOYWL140GPOdiib6NVCvFNm5t8rAziNE/2DcmQlP1wpYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721351088; c=relaxed/simple;
	bh=72wg6WgXc4hShuprBn3B1perAS1jz3gXMtTPxJYWnA8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uOdyOPTSrQlpnJNfdzSnPNqxsTk+3nfpXrit/aWSYDF8jdErnqtyW8Xeb6ehD+fg6LFVYEWx5FG0fjuQ/d0Y6J1XMwdgUG8+8tFUNyH4Yub9qBfFnp8FgpVxoXXL/xwaZEBYikGQfssED9ZKaRJv1sjzraoGRFmfX8R9UbouDrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKvLfRvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 170D5C4AF09;
	Fri, 19 Jul 2024 01:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721351088;
	bh=72wg6WgXc4hShuprBn3B1perAS1jz3gXMtTPxJYWnA8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gKvLfRvDkORw3tYQ072Ne00kdJCjXccyIq8uK+p+M0ZO2fnTBCZnr60WAi466KDvf
	 5jhmlHbxm01wK7ccL6NCrNHyx8ucptOPzzodLUb7479dl8JCPUptZ42T/pOVrOSYew
	 JW9XrlhKD8tWMLzYTWurpjSy7Q2FJAohFwmLNRvhs5EIKMElCG5RhlYWYInEIBOvWH
	 s0ImCWCiY8xpUXOdct8rsBD2336xhvyxBKgnKgSxBt9xqlYSI27gcH7WJbRXVIy8zi
	 OpLBH462KbFhC/ZSoXljH+ToRNkZiezLnwN0lqSuh5kGkkyma91HHij4Ur4Vi5Ffyo
	 HB/KRP5PW/fcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06D4DC43443;
	Fri, 19 Jul 2024 01:04:48 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull NFS Client Updates for Linux 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240718210932.703615-1-anna@kernel.org>
References: <20240718210932.703615-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240718210932.703615-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.11-1
X-PR-Tracked-Commit-Id: b9fae9f06d84ffab0f3f9118f3a96bbcdc528bf6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f40c636b291deeae7d1f4c9fb5db5f0aac54267
Message-Id: <172135108802.16878.12930683311011722993.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 01:04:48 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jul 2024 17:09:32 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f40c636b291deeae7d1f4c9fb5db5f0aac54267

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

