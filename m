Return-Path: <linux-nfs+bounces-11190-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE6FA944E1
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629781782A7
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 17:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9EB1DC992;
	Sat, 19 Apr 2025 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSHPLrvB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86662A8C1;
	Sat, 19 Apr 2025 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745084607; cv=none; b=TMMNurNjWuBeCUtMbfa+Spe2vvG2IcFKEFpaQ9tvCAmB4ILBWoPOzeHNKSGjOc+nu55sNMnL3pGTBzKFHejnNQwIh0crb5LX2jYDXFGg1H1v+YGwwqxyKL04gF30wgd7HxKrgAPojNDiPpIHUDmY4MSpLbZFLKnIizM8tFNwVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745084607; c=relaxed/simple;
	bh=tLjYD4RId1d3uqY04lgzWM3raLo1li4/3JN5c1WDXrM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YFKjBk9aeIJcN682oAlPlYyI6QaRNR9tJUghiknZbxAHDijjpA9at1DeQplrNNbkWXsld7riGidrJ5jBCKdv3Sxab7UWUUojWnWI08ZydAlChiHNqB01wHqp30qeboBXN3RpsxGkSqds/e9RTpq5CoKvQyymBrzzVH5+d9P5c8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSHPLrvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B76BC4CEE7;
	Sat, 19 Apr 2025 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745084607;
	bh=tLjYD4RId1d3uqY04lgzWM3raLo1li4/3JN5c1WDXrM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DSHPLrvBLD6tyZejtdNlZwk6iaY94b4dizCyPjtqLun0yBWpUjd11hgAxfGBu1O+0
	 S6IOvlfZZXcib1oiEl4Fyy+2oHE0piPsh0mLFjwaXMg/ssKZsZ/aqs2z9Qsq6WkZ+h
	 e0TwpHmzT7eUFPTIHhrFrlxchqKd7qF9PYhttQzRboZ0NVd1RIp0u1F6igem8Q3Vtt
	 MoNv6DZ7r/Ey1kK9gCLUiTeUURYmvj1YhirUA59Kqw3P3pbpHRoXNCj2IuyXc130TP
	 /pv1Zvoem9KHkBIPEA/niY8cnfR4XfdPswHqJZ2JDu/C8nX1oaXikWVt3QNP6bAu/t
	 b1SmGtrAPvqcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE9AE3806642;
	Sat, 19 Apr 2025 17:44:06 +0000 (UTC)
Subject: Re: [GIT PULL] First set of NFSD fixes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250419173216.7115-1-cel@kernel.org>
References: <20250419173216.7115-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250419173216.7115-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.15-1
X-PR-Tracked-Commit-Id: a1d14d931bf700c1025db8c46d6731aa5cf440f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ca0f935a126950c2f0b305a50f31f3b00542b0d
Message-Id: <174508464527.511251.18251351333918819365.pr-tracker-bot@kernel.org>
Date: Sat, 19 Apr 2025 17:44:05 +0000
To: cel@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 19 Apr 2025 13:32:16 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ca0f935a126950c2f0b305a50f31f3b00542b0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

