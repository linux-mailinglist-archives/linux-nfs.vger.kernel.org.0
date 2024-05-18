Return-Path: <linux-nfs+bounces-3280-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AB58C926D
	for <lists+linux-nfs@lfdr.de>; Sat, 18 May 2024 23:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A6528199D
	for <lists+linux-nfs@lfdr.de>; Sat, 18 May 2024 21:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135776BB20;
	Sat, 18 May 2024 21:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcntaA1c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F96A33E;
	Sat, 18 May 2024 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716067323; cv=none; b=koJfnelHdy/f5wZbfOwUNOyxxuwhHzCRYHVUy+JMvnJy2wembgOu08P9cBGG55FSJrW/UxivsMVLJhTmLUDkoy/cQmPwbDVWb4SoIuxwEflenQuJxxrjS2LzVcu+klsw1VsZMmayzosXKtzlm2b5QHDGWQjZN3QEaL64nbWXxKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716067323; c=relaxed/simple;
	bh=jyzp0m5li3sNKVds2H7VhC0gP9nlEB2sE68kKdo7UZY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rq/ZKbayu0jW6ef7447yN7X16DETCiiNWxjc5AebtdK3yox+a0m6pq2VtD79jdcQtuqKgm5wqlHXhI7WnMi6FbHEDKRopdOzYmnoLa1fisQL/mdJM9OAPsZXNvbPuXVKWeUwoeoKw/tAmPhmrTCKc26hKfQLuM6AXg7EDOi4NGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcntaA1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BABC3C113CC;
	Sat, 18 May 2024 21:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716067322;
	bh=jyzp0m5li3sNKVds2H7VhC0gP9nlEB2sE68kKdo7UZY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HcntaA1cM3+26g1V4O6c+WCLlaUIbmbbb9R/nUGcjKR8OErMFWNuyn2MFeia0eB1Y
	 0d/qMw7cX5LILMZ2i4xWbvDj+BjHmwwx7nRaP/QwBCG7Wj1lBEExJmpSrcWCC8HRZW
	 NhhD0mQLD7WrFRTlO1OFC7Ixtl4JpkndO/1C6yv1wWKI9kw+ceWF7czQHbx6yMWy2t
	 mdvarERaIK9vez/vVjjCXZm9jFPNCaUlCMKCT3U96S0xyUlt+9im1JHesvCMCig3LV
	 pIb+5KzfuDO3XO/W024HDlUWSyw4XKGKz7fJ859q4hiQaFp+zzt3JaEJCTWvX8jjvS
	 vu3PoSkySrUcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A681AC43336;
	Sat, 18 May 2024 21:22:02 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zkd13J6KgE/kdKSJ@tissot.1015granger.net>
References: <Zkd13J6KgE/kdKSJ@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zkd13J6KgE/kdKSJ@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.10
X-PR-Tracked-Commit-Id: 8d915bbf39266bb66082c1e4980e123883f19830
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61ea647ed190af8ed5c5adece2fb5ee33eb3cd22
Message-Id: <171606732267.14195.18399250065227381901.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 21:22:02 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 May 2024 11:21:00 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61ea647ed190af8ed5c5adece2fb5ee33eb3cd22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

