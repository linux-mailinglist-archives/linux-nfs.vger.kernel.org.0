Return-Path: <linux-nfs+bounces-2551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3A7890F14
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 01:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29ABB28B50E
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 00:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48F7A47;
	Fri, 29 Mar 2024 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddpCJbRj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED54A3D;
	Fri, 29 Mar 2024 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671588; cv=none; b=IjiJwhrJd6mswq+PUl2cGi4o3E9Q11IJeNTrZeA73halGYe2PHV+7w79UfhyY8o7AHH3xcTeHXH70n4oTRhDHq3tEYJ/eJWPSFfbEy43hpXqTNcCeWkD2EqHgjT7LAWkxPVD0TJagIOYy7qt3Yg1BKH1XsJB3xp9WYiHTSfb0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671588; c=relaxed/simple;
	bh=5tPFBXMUT0VSabup6O2XPk35Wbl/US/LvFR0UWRjnYA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l4Cf7FsUX4ZsnvQDR8SCYwYXemxPeJDjVq0QdCaIze9Ism9ccVK3vK4FHatRW4NBm0kE1LvdAdSxEbzHvNY2jJCyVt93gk7ytpCbHLtqrUbWYjZNouOYevIUW2SjiAor+Q7TU+L5W74Anyk7PWBYr3rFdpyoBhmKrW0KC4JLpVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddpCJbRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70BEDC433F1;
	Fri, 29 Mar 2024 00:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711671588;
	bh=5tPFBXMUT0VSabup6O2XPk35Wbl/US/LvFR0UWRjnYA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ddpCJbRjkkMUtikpMMbK0McN/Zz+ZCwfPPM4YYsLGhRjoT//Rs52JZFY0HooBB52M
	 oGq9gElOutdrdnvl4x3t07m8t9BBwkAlVfeZ/lgBcGpuhKFDDiNh9htNyhhkpbKdOS
	 OxM6Wdgs1b/IXaKBPy89cw0kgMSO11i6Z0rj+q8NGN0tb+aKPaX1KRulrepFWfiZvN
	 DJ36Jtnnbs5BfGSUEuqS6E8Kd5+yyw201IgTRlknpQ8shzw0rgSKwrwdLuxiZ81G+x
	 PAn/LM7kqlCRoGfet0j0Kk+ANWxHtNxvadJ0UCrlbxBXfXMbrlKgKMpqDWwvWFvTld
	 wPye4ltqsyUSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6372ED2D0EB;
	Fri, 29 Mar 2024 00:19:48 +0000 (UTC)
Subject: Re: [GIT PULL] first round of NFSD fixes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZgW2GVcXbJaPlT8z@tissot.1015granger.net>
References: <ZgW2GVcXbJaPlT8z@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZgW2GVcXbJaPlT8z@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-1
X-PR-Tracked-Commit-Id: 99dc2ef0397d082b63404c01cf841cf80f1418dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8e8fbec00eb59be0a438d52ba81315af0b8960b
Message-Id: <171167158840.21457.1265346948147575374.pr-tracker-bot@kernel.org>
Date: Fri, 29 Mar 2024 00:19:48 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Mar 2024 14:25:29 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8e8fbec00eb59be0a438d52ba81315af0b8960b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

