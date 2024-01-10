Return-Path: <linux-nfs+bounces-1022-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1486B82A27E
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 21:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A848EB25AAB
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 20:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BF15025A;
	Wed, 10 Jan 2024 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeES673r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3752F8A;
	Wed, 10 Jan 2024 20:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10F57C41679;
	Wed, 10 Jan 2024 20:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704919126;
	bh=5cQDO1LmTW0IZ/M1gQAukt0C6E5oydM9ivSKDR/2ick=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SeES673rdP6IuSEFvHmUFsX8C6DSxSGb6nu7OJ93O3LSrcwOK/dEpQpuLDC5UOShM
	 yNCYRtjFipkCtR/vywhkTw1tMsuCHgsU0PuGfzH7oHMxftLGhd+d/PNhrQrmVIlbMZ
	 EluWGB4FEHszFQUHFnqh76WIQ9Rj8i7LGI7rU89OEZ6AflJFp1wnK6P+7WMgTzXCpr
	 ntdeProRz+EhehZnphwfH26kQGIqshJvOz2WJpBSbpRiO1iH8CBixQn+UKnxTCUpMq
	 sNk99ANrdXwvwDXePV+UwI77CRDk/MO2auQ1pmmV62lxUgQmNYbKSLSSgI9WuzdOWq
	 kHGmKJqFAW5ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE926DFC686;
	Wed, 10 Jan 2024 20:38:45 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZ10c3vzhM/CVjQs@tissot.1015granger.net>
References: <ZZ10c3vzhM/CVjQs@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZ10c3vzhM/CVjQs@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.8
X-PR-Tracked-Commit-Id: 17419aefcbfd9891863e8b8132f0bca9a6b2984e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49f4810356f7d4294ad63dc70fe3c65ca3b8ada9
Message-Id: <170491912597.22036.5546653673843399911.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 20:38:45 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 9 Jan 2024 11:29:39 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49f4810356f7d4294ad63dc70fe3c65ca3b8ada9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

