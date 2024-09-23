Return-Path: <linux-nfs+bounces-6615-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619BB97F115
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 21:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29C1B22101
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 19:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6254D1A0B1F;
	Mon, 23 Sep 2024 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjV6tmo9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DED71A0B1A;
	Mon, 23 Sep 2024 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118393; cv=none; b=mJI5QDlJpG8KnTQLecSxr640RjHKXswerpy5Yh3UDcTVS7PepN2S5TtONY+fhE6Ccym48w0RytSsualyihMp06M2AwBp4qwKQVgtPsOksvFcI+l9yMaOmBBrtWC1RmLYfE/eui24/pF+yT5zo/iXvfrl818/v1rcbeUtDQngE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118393; c=relaxed/simple;
	bh=5+xgeHGkG+V/Zq6B+gT0xI0PpSSU1b2wKGzM/pXPV6U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F7A5/ZOGMT4xN0O8UP8PVWOvKJk9jl4E3/7wderkCQ4vOkzzXt9ebWygux48/EX3wYDiT1rK8B91w3eb1UtstTgw+cYXTxmFF5V0OJOoV4+kswulzgQ/lHbNnbYrd1ThQ+VsiBKBRZ79BVx3znpQEa7EXhJVYux5j1uAXcZooRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjV6tmo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20070C4CECE;
	Mon, 23 Sep 2024 19:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727118393;
	bh=5+xgeHGkG+V/Zq6B+gT0xI0PpSSU1b2wKGzM/pXPV6U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VjV6tmo9QGwMWRehAuxBx+xosRVTgQJxMmQdVnJVo9hNZtEFkx9qsAmVNGY/uf0ii
	 JBk8bnfKrNQhAX74nsN8/9Qaps9GGkOO6mQIs6sDpipth/Vy1MrUPMxSGN4h5HDAvx
	 IvDlKkXyw+kAmiXkEPxFdz7iDT7UAWi42Br7XIVracjiGBZzQclMnsRryCHImrK+7V
	 7VYry+i21EM+svA9UPP3gLO2RTDsvJFvl7Jd1h0vy64Yo9U90WhesTI0UoluviHUn5
	 Ad82729FHClgVMZp6en2gQ35v87NB2iZkCoVUJwMsoULlql+Y4tVOO/c96LoCKNyoP
	 0n+g8l/0cAziQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0A73809A8F;
	Mon, 23 Sep 2024 19:06:36 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for the v6.12 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZvGGu59VMM18+31a@tissot.1015granger.net>
References: <ZvGGu59VMM18+31a@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZvGGu59VMM18+31a@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12
X-PR-Tracked-Commit-Id: 509abfc7a0ba66afa648e8216306acdc55ec54ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18ba6034468e7949a9e2c2cf28e2e123b4fe7a50
Message-Id: <172711839517.3454481.11639166163935440903.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 19:06:35 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Sep 2024 11:18:19 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18ba6034468e7949a9e2c2cf28e2e123b4fe7a50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

