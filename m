Return-Path: <linux-nfs+bounces-2829-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6F08A5DA0
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 00:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709C7283583
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37DB157491;
	Mon, 15 Apr 2024 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOJTNbDw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7781A25601;
	Mon, 15 Apr 2024 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713219232; cv=none; b=avFesKSM+HiQZqEZgSPjAKy0XG4CaxeCIdlAi8Oog3CWaOGNyRMeDlMxu4ISMVDbmI37WCA4fQ7laihH23fFYk3mQWPBPs+KfLSyCST22wa7CLWRCs/d6GW+HTfpiD4Tbsa2h264kMCGEvG2GbN7jvet8z0T20IyFFouOcIAl38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713219232; c=relaxed/simple;
	bh=M90vJ3MsH0dryaDQi6o46A1Gs2LvpeUpZqmtQOfzufg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YW5iwobQ2/YxqP2cYAd6KEBgzczQ2i1MbfTpQrlCUFRs9nxLACJZBS16EMsWnYEjyy3sYQUr5UdXF6OzVRdF6eSfLT9oXun5oV9aknnt/eHWrQBGWbV7mkkOqIKQju/XVSLqTG8UYHUCW+II+sxCYLiyUgpYrE9hVBygCc9qggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOJTNbDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE72CC113CC;
	Mon, 15 Apr 2024 22:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713219232;
	bh=M90vJ3MsH0dryaDQi6o46A1Gs2LvpeUpZqmtQOfzufg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UOJTNbDwAxlzkEsA7mRjxGVUNeUPynvyrOWD1UxmZKUKyg1/IsmunY2GJuRo7NtGS
	 /PKlCfKoLq0qLdonR3YAoh3MCUfkObyGgAyi5uuV+9QTVCVx5zvsvplQOfmZwwu03Q
	 q5+eoeCC/mkV7HjcexEO1b3PAqCO0AKWSQM0fgtQzYOua1hNvyuXlTUHIGqXlyubyW
	 gsUVbBI7xOeCUiYfVRZGqvWbUwR1eLRZ5JKllkFmto73FrvBQWB7RFalx0outzULLT
	 vsl81jZniKR5s/ej+PeSBX1q2Onbp3MJxfo5dsBTJn/BMJyy9OuCVEavjwFma8PKco
	 H/Hxq3cyoEyWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCC7CC395FE;
	Mon, 15 Apr 2024 22:13:51 +0000 (UTC)
Subject: Re: [GIT PULL] 3rd round of NFSD fixes for v6.9-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zh2WGRLG3mA92OxN@tissot.1015granger.net>
References: <Zh2WGRLG3mA92OxN@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zh2WGRLG3mA92OxN@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-3
X-PR-Tracked-Commit-Id: f488138b526715c6d2568d7329c4477911be4210
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96fca68c4fbf77a8185eb10f7557e23352732ea2
Message-Id: <171321923188.15775.12825885354121277640.pr-tracker-bot@kernel.org>
Date: Mon, 15 Apr 2024 22:13:51 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Apr 2024 17:03:21 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96fca68c4fbf77a8185eb10f7557e23352732ea2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

