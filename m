Return-Path: <linux-nfs+bounces-5279-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C29394DE2E
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 21:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8528C1C21625
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 19:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598BF13C670;
	Sat, 10 Aug 2024 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1aQd6wE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2AC3AC2B;
	Sat, 10 Aug 2024 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723316797; cv=none; b=c5w1DvSaME5v55wr2KbMLy+16zloBKm7eCH3Vg7m58lTkotRidP1wb63eaxtf7kmtvYruUez9iUniPr7HMHIpe+h71no2OhsOHZ8+mD8i7EAarXkPSGmxUKxZbdDn13/Ii7XLFBxu6gEe+/HAUrLPz2KGJDFkFs+l+YZPSx2qME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723316797; c=relaxed/simple;
	bh=lmd5aJ588sbrBdCpej78VqDLsJDEtsyPzMzIxAGed6c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XoFHg+PoxmK4EF0mDVm4IS0PL5o9SB/0GkSnMTXGcXSW2+WXHGTHILGlRFQKCH1kyjtocrF42dwENDljuZ4Fv57w05DemMGx6uVJyXrbO4YF/keAou5umLWYMKZTYdcySB9aLS7Ta/nxEr29gR6PZzAbCxjkgsCvNJVb62Hs8bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1aQd6wE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB35C32781;
	Sat, 10 Aug 2024 19:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723316797;
	bh=lmd5aJ588sbrBdCpej78VqDLsJDEtsyPzMzIxAGed6c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t1aQd6wEEW3ahLz7o4DCXErSt7P/HRY5daCqITO+PsdgY9mKEbiSKhtCo8C1CVCVC
	 H6sYpaUN3AtBCsv8ykZBGL4dlwI8hs50YExDieojfc8FugWGOxEVozE0qkDbnv+Ycy
	 UZSZ4pGc+0NSyQvefw6EGNDSp34wBgdqWHHqd9kUB/jibRG40dgejEE1oWC9HSo1Wy
	 4N1Bspiqrb4InVZ3dAlevvevnx3U+3TEyWujGhA35Fd7jSusv/LW4vMuvGMJhnpRXo
	 dT3EUgAFtdKpeAzR2GeF8DlCptPLa27yjo7qtHWXchg2k8KbpMCgXZd0ufXX6bM7j/
	 nLKgeLeG5uVSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37209382333F;
	Sat, 10 Aug 2024 19:06:37 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd fixes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZremFwYpY1m/5w88@tissot.1015granger.net>
References: <ZremFwYpY1m/5w88@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZremFwYpY1m/5w88@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.11-1
X-PR-Tracked-Commit-Id: 91da337e5d506f2c065d20529d105ca40090e320
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5189dafa4cf950e675f02ee04b577dfbbad0d9b1
Message-Id: <172331679550.56378.5106937401387094973.pr-tracker-bot@kernel.org>
Date: Sat, 10 Aug 2024 19:06:35 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 10 Aug 2024 13:40:39 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5189dafa4cf950e675f02ee04b577dfbbad0d9b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

