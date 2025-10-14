Return-Path: <linux-nfs+bounces-15248-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E123CBDA9E9
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 18:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BAEC58138D
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C1E302CA2;
	Tue, 14 Oct 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuDODLDQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A3030277E;
	Tue, 14 Oct 2025 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459498; cv=none; b=adghnmY3qY7ndDPIP9YJjCz0mNFnUaOG0HxesMYHOZGybDK6WDkzjdJyoSQHMtBB4wMvP4o9rQ55wH2ySByvh+GXLfKCp0fdAR9bnHZNHXmQxlVltzOaMcjD+6LFWI0FxTttHZja4r/u6Go1/j1ydh1So/Dx09LCVkdHc6hezcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459498; c=relaxed/simple;
	bh=n4oXF6XPkxdkZVvqZAtKMMcOctTEfQjVOptgzpkPE4c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u9xB+iRBu+qR/Ds2R4s7NtdFrZbyVXlpwo++pgFkoYG/8qZoZSJRZiAdUvn4Cwrvwb0/6Xrk9UlM7bJEzqv+LUe7jixHVtZ40I+u1GvN4WjlTA2U+RAqRBseHWwU4eDM6KrPcVWNyhhMu+9rR6DckHlYwpl0vwjfbhTTlN8q1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuDODLDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0763C4CEE7;
	Tue, 14 Oct 2025 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760459498;
	bh=n4oXF6XPkxdkZVvqZAtKMMcOctTEfQjVOptgzpkPE4c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tuDODLDQ7NMTp7zsw647v1EiPAty0Ebq1NTNuUDHx4foF8XsbJvo2Tec22Xkn0wG+
	 g4QsbHjeMCLZJza+Kh8if49Vuy1iSkGXbtcrTcgdLDVP7dfh68Xms1bR3tMC54/5oD
	 UCIoNNceSB864ooMfxmFwwfCBmb8kgbxJcqPb2eoPzv4cuBphui2A5zFgRa5jNeX5q
	 AjbQPm0/j8SAhuaoQll+b6AI1Uwz/aMqrdX3pg8tv6iDTGDpwe16fo8rpg8kjGsUvk
	 2mMqvXJh8oW7HHkEHyvBBPAwWj6a4IY9LFh0I+zxzXhBO9vUiIb8gAqHdGoXwSPNUH
	 XCXg9DYp0RMlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34025380AAEA;
	Tue, 14 Oct 2025 16:31:25 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD fixes for v6.18-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251014145810.4880-1-cel@kernel.org>
References: <20251014145810.4880-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251014145810.4880-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.18-1
X-PR-Tracked-Commit-Id: 4b47a8601b71ad98833b447d465592d847b4dc77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b332cece987ee1790b2ed4c989e28162fa47860
Message-Id: <176045948386.10193.5996695726053877508.pr-tracker-bot@kernel.org>
Date: Tue, 14 Oct 2025 16:31:23 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 Oct 2025 10:58:10 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b332cece987ee1790b2ed4c989e28162fa47860

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

