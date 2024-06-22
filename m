Return-Path: <linux-nfs+bounces-4233-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD3913618
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 23:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BBFB22915
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 21:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E6B61FC4;
	Sat, 22 Jun 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbFqCAj9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E4153E31;
	Sat, 22 Jun 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719090305; cv=none; b=sRVdCjn8ySgyCfiIsvXDci1wUh2Cgv/PNWEDP40RjB9ldv4yxrGC18jBNVkszSFVS6boXhNjwlVAMQU2wNo6FuMSJeFF2xjP2Mhmy7xmOogxqKvvZP3tgEWPfHWOs0+StsACafjVSi3es7N04RSYuQ9ycYhmlN5NvLwb7W5R4qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719090305; c=relaxed/simple;
	bh=waJiqTDH2GTFmh8ACvxm1o+nIZUh1nu4O/KRBPAP29E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DFQSQ6O4riRA9vnSURbxmLA1GkMdkHbwtg36c4kqNW1vvXjd4WImndtY8vIXVwg3bOGvIq4vJd8/pXBzv+vEZ7J9LfnFtp/Z0HQC9WITTHOROmgLEvHXsrpvB02p2fSQ4p5ZUH5Oll4rJDKEL1az5RAr2E+XAcZ10MkgD5BikQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbFqCAj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4194AC32781;
	Sat, 22 Jun 2024 21:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719090305;
	bh=waJiqTDH2GTFmh8ACvxm1o+nIZUh1nu4O/KRBPAP29E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KbFqCAj99B1qe3U7o6d0farFm+ICd2Otj4hMlLOtb+111jgAtOO6UXr/HDp9CS39V
	 8j0R5RWEKFqjcrJfTctmelFu9KRXK4KUVoYpcv+VWvCk1ZInHUe23Qbn+5ThKiXyhJ
	 H0du7oLMcDyu0PN3hWWRRn7TGkJymi7hw2SBnoXNL9lY1HFYkOTLLOfZtw8uuFsEU+
	 mKBZvdUp3GVb0Vn11VqGatShmtDHLy7WVUUz60MkvW3nY+cA/DcLOgVI5TS8jFDA8D
	 ivK5h6vdsZH7o+rBsO4FlbGvbnnb++WPTn8EDIqpma45fXCs3PRwSfU9jGiOs6XSo3
	 UG6UHqxV98TKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BD5DCF3B82;
	Sat, 22 Jun 2024 21:05:05 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD fixes for v6.10-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <Znb+ELqzU3lqTUK+@tissot.1015granger.net>
References: <Znb+ELqzU3lqTUK+@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <Znb+ELqzU3lqTUK+@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.10-2
X-PR-Tracked-Commit-Id: da2c8fef130ec7197e2f91c7ed70a8c5bede4bea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2fc946223f565d99322e942cdc46396d3c7d60b
Message-Id: <171909030516.414.15249663544529779426.pr-tracker-bot@kernel.org>
Date: Sat, 22 Jun 2024 21:05:05 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Jun 2024 12:38:40 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2fc946223f565d99322e942cdc46396d3c7d60b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

