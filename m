Return-Path: <linux-nfs+bounces-17503-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C26CFA1DC
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 19:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B524D32D9247
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70712C17A0;
	Tue,  6 Jan 2026 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW827pcf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF8F2BE7B2;
	Tue,  6 Jan 2026 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720730; cv=none; b=M7haignhbdYKdRuONb14CtSDzdmCmZm+3/Ng0+scgaL++O1rh+aHL4fRwvS6xPvyVwwOjwj9hpyD+dzxREqimfZwFLvZPHg86ogvRMZKSCOT909SV/KU3FgPRIJGieWYiwsH60He5ErxHK+fxzOkXhZhdDu7cnoJPhBX0HV8Rho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720730; c=relaxed/simple;
	bh=PvUHq2pAb/D314qa6prDWqka0s7D1u1oDz6sdtRSFlc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qnL07+qXEMtE36yO3rSHc7ogAoKuY4soe1FnctfIIE/YYp0D+HP1jdPwi/BoGqObfqe0dEf2wdt9LRCav3rdF0jjL3xLOEgbbETC/hv2mauSP+va0oHRPt6t8MRwG3DI/SOS5GtD3y20k+GWbVZeoFAsvXGxJUQMJ36Ge2K9HlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mW827pcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BE7C116C6;
	Tue,  6 Jan 2026 17:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767720730;
	bh=PvUHq2pAb/D314qa6prDWqka0s7D1u1oDz6sdtRSFlc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mW827pcfb63wOZ7C1Ewvj3fFFEXoJ4xNy8Cpl8/sA+D3Rxk9Rq/bVgMnQ9Mfo/BwJ
	 2vI+lNh1ibyqgx85M7TC3GoaiHaOq94B66bWESN5gGfQ2RckeEAJwHyqBP+/HFBo/U
	 vNS+gqN3W4a6uPEH1alxJ2RabK9xYTq1yC7TcGMe3kHexGN3xVJ4pj49LGJsOLUVbg
	 4sWN6ltR8vDPPG7LfDUwI84Jxdyk6cNLNrXQL6nVzbvEvDDiBMyWXOzlmERmQJ5uif
	 pSa3FifG1ZRTqhHCzb/bjRjdlls/yi3ROrJ1V2hTi42dxVRAZIPeVZkRBn5VDYYtb/
	 wJTqQb0p/3mbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2C02380CEDF;
	Tue,  6 Jan 2026 17:28:48 +0000 (UTC)
Subject: Re: [GIT PULL] Third round of fixes for NFSD (6.19)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260106155902.3706718-1-cel@kernel.org>
References: <20260106155902.3706718-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260106155902.3706718-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.19-3
X-PR-Tracked-Commit-Id: 0b88bfa42e5468baff71909c2f324a495318532b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0b9d8eb98dfee8d00419aa07543bdc2c1a44fb1
Message-Id: <176772052758.2044058.8851796089400749053.pr-tracker-bot@kernel.org>
Date: Tue, 06 Jan 2026 17:28:47 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  6 Jan 2026 10:59:02 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.19-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0b9d8eb98dfee8d00419aa07543bdc2c1a44fb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

