Return-Path: <linux-nfs+bounces-3618-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC704900DF9
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Jun 2024 00:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B4328253F
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 22:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E473114F10E;
	Fri,  7 Jun 2024 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGFKmy+H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD383502BE;
	Fri,  7 Jun 2024 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717798673; cv=none; b=l0Cz69+qtaSW+aLfwDmIoSR8xzZWungRLDPWZBp3rZV94/4fkkv4XSN6Gme7c4GzxG0pzOY6JJQXk4A0GUSX2YTJBCbw2C9kdI9jJLblxE/avEuULdgXzw9ycl8QLBr8Lr9iq0FU96HhoiNsPL2oIz2yZPTx2Z83AMUtOdghtjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717798673; c=relaxed/simple;
	bh=wlxFo891DPkzzPYAt7urOMnHbdybnK9zowy34KTI/tY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q872BoPKByAWr30v0phKw4bQNBDaQj/P4Q6fJ99IVpXKqyubQOYQdnzOwA89sCt712zP3o72Ti5QolilytapktIbD19awp9RFKRZMgt8d8Lum6+KfEfDyi0YLed9+BWJ6TUYEMy0kv3zNtsxcbZAZwwxz60ZqoYGTcBt0sIWiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGFKmy+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9151EC32781;
	Fri,  7 Jun 2024 22:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717798673;
	bh=wlxFo891DPkzzPYAt7urOMnHbdybnK9zowy34KTI/tY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oGFKmy+HBfovOofZIdl8/eMBpgNFSlEntWi5ty1mJ/ZixJZ1eCY/PlJZdlztWaK8J
	 3kvHVEdxMJMpDHLj1z7HC34OvuSOWSLv6HbdSYP9TbWYSZilYhedPOSNPMIT3v2bXp
	 8Vu6CF5VL/hwaXdwMTATaC8FrKfqCv4LpK0WeU0EVNfHxRArXQ/aDlKAebwouHVyQm
	 Cl2mwC/FZqc41+wwaLXmJTixJGgNp34F+ZXLk0+JIErwzPUZPu6BqRO0NjxLt0w2ms
	 K1QbPQ9otssZDX91RUiCEZKvxVhL+LgEthVdViGgwTP2aKE9EgynEi5w7FEMk6UrlK
	 E4AvK0MlRUZug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F790CF3BA3;
	Fri,  7 Jun 2024 22:17:53 +0000 (UTC)
Subject: Re: [GIT PULL] first NFSD fix for v6.10-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZmMIxOjoqzW8auo6@tissot.1015granger.net>
References: <ZmMIxOjoqzW8auo6@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZmMIxOjoqzW8auo6@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.10-1
X-PR-Tracked-Commit-Id: 4a77c3dead97339478c7422eb07bf4bf63577008
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eecba7c070283f053434808fa69abda36cf154b4
Message-Id: <171779867351.7177.13875177410808866880.pr-tracker-bot@kernel.org>
Date: Fri, 07 Jun 2024 22:17:53 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Jun 2024 09:19:00 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eecba7c070283f053434808fa69abda36cf154b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

