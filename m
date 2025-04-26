Return-Path: <linux-nfs+bounces-11296-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D58A9DCB0
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 19:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B1A1B67104
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 17:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B7F25DB1D;
	Sat, 26 Apr 2025 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUFVHLMs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3041A08DB;
	Sat, 26 Apr 2025 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745690022; cv=none; b=osdJQUwIYV6152YUKceJdR0mdyaaVfjoyObaeo49ae3UATwTGgCrWAhsN6Gw8ozbqMp+plVeeFZx10YLEUs0bkEqwWuVcpWYUzeFeNbO5YpPTkMI0eozWOJJu4B227nvuLknrRA9oGAxXgAH6WL1zD+URvwWoMRw8btCz+GVrJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745690022; c=relaxed/simple;
	bh=NDeC8ZcZ1RRIJPeHaGlEK5rMTcxDItZqFEb0E5ghCps=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MUBwmFeaJ+s0hsLS+9dVsK3zgMR165PwRDtPauJakHPxWD4qPCBl9uIin6DgmjT1ou2ja9l+FRZ1Eju3n0//HzfkR04bKGKX64Bc2ghXq35Dn4QTWrES1kKaRiAcqbIT+gaR7BQSq4YRf8J6QVjgqQl1D9l9ehitnYzMidVMzbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUFVHLMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B48C4CEE2;
	Sat, 26 Apr 2025 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745690021;
	bh=NDeC8ZcZ1RRIJPeHaGlEK5rMTcxDItZqFEb0E5ghCps=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fUFVHLMsh0byRby2mZZbs90jMBwCZFD3jXPC8cxxzCxd9lhrvzAGOL9oscVI3x1wn
	 7BM0qaFMm/fXWbdtQmAhL1EnIBb7SM7jWyXFsr7nAKwxweH2pHza3FRL8E3yQMgRpN
	 LYLjpD67xhzKBgFho+tejATqpW6Mv9hQhHecGIlFydJ4zn+iQXQdxdVGY8f0u3kjUn
	 o6brEj/LyAol2VkX42wl5ZsQQKFsgoj+wXCXx2cambwoVlmq9/RTpIUYnFvecSnKnF
	 XL8H5c86uikqLwYpp2lqIp8vWHJnLXqBNkKcrDohX0eUcrqtYCzs+DVLH9t8jkIYv6
	 n9bhlVIXwuUtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 345D938111CC;
	Sat, 26 Apr 2025 17:54:21 +0000 (UTC)
Subject: Re: [GIT PULL] 2nd round of NFSD fixes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250426160531.5466-1-cel@kernel.org>
References: <20250426160531.5466-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250426160531.5466-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.15-2
X-PR-Tracked-Commit-Id: 831e3f545b0771f91fa94cdb8aa569a73b9ec580
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d22aad29de2a7b13f43ccb9b55cfd5daf793ead4
Message-Id: <174569005973.4037932.7521780680972977613.pr-tracker-bot@kernel.org>
Date: Sat, 26 Apr 2025 17:54:19 +0000
To: cel@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Apr 2025 12:05:31 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.15-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d22aad29de2a7b13f43ccb9b55cfd5daf793ead4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

