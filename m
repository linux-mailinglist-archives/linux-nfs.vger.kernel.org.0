Return-Path: <linux-nfs+bounces-5874-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8753F9630BE
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 21:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069A9B243F3
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 19:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6241AB51B;
	Wed, 28 Aug 2024 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwZTldYt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F281AAE19;
	Wed, 28 Aug 2024 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872286; cv=none; b=dwEAJmCxhLkgegIkRXF+rXbWaBx8Z6FY63F2NCF4SrA5JOvqMS0M9r4QMG9HjRhFRddlzvsMazKWsIIhyNxNr/W5cpTSMZZcI3QlPJmyjOffNSB7CgSmpc+GRR4W/PMGN05DLZPWmee7E+E2S9zYkRuyEWavbOyVAgiohGOiND4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872286; c=relaxed/simple;
	bh=rw8h9wd9dYF2Z6CXC3OwMClSuF2ZYsg0KK9XmAEBxcI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=f9B3AnitzupokwPJog/MOvyr/hrGE/26QOdg5IOXMngJEJvL1Oi492l4GbArfTI/qp7BkmxFjSyDDri3uTxDgcTVDSHwoftkJOF004KpImxQrpC+ZizHkw+h3w82iqh4vwam5tm9kCT4Pg5PZfl34GlYZ/guoL813JuApA45xks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwZTldYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F406C4CEC0;
	Wed, 28 Aug 2024 19:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724872285;
	bh=rw8h9wd9dYF2Z6CXC3OwMClSuF2ZYsg0KK9XmAEBxcI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YwZTldYt5moMY3uMsUQBShbSVcojRR9l2fqfzlgGbhi62QVgNicDZtjFTusl8FO3i
	 1Ld4vDOJHYCUObJ6uPJrFtx7qywddpqabdhH/yt8CgubTrZCtA04Sh3xGA1eX1F5Z/
	 O0HSB2ZM1AC8YxwHeFuLMtf7qDuLuxxG++4jCOWWAu0IOycXKkIeS5NX9oLk/uUNio
	 To/oiaOC3YpsQb8kfCl6hciYJfT9Ie+PANb/zY0H+8IdlpUQJYkAJRFgejmbKPAVnJ
	 NJntd7OiPbAUMsCdaSURwkhRD3Gqi9ypSR+bLN2jm6ci6tG0WeVXLCMug1a808dS1w
	 Dlpnl3UUbE4pA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6C93809A80;
	Wed, 28 Aug 2024 19:11:26 +0000 (UTC)
Subject: Re: [GIT PULL] More NFSD fixes for v6.11-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zs8ta1ytpxZFAu6m@tissot.1015granger.net>
References: <Zs8ta1ytpxZFAu6m@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zs8ta1ytpxZFAu6m@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.11-2
X-PR-Tracked-Commit-Id: 7e8ae8486e4471513e2111aba6ac29f2357bed2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a18093afa393d03599cbe42da2eb00d84a1c9a34
Message-Id: <172487228555.1399279.9074243688277258923.pr-tracker-bot@kernel.org>
Date: Wed, 28 Aug 2024 19:11:25 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 28 Aug 2024 10:00:11 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a18093afa393d03599cbe42da2eb00d84a1c9a34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

