Return-Path: <linux-nfs+bounces-4412-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EBB91CF0F
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 22:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5391F21A3B
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 20:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E95913664C;
	Sat, 29 Jun 2024 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldQjrjtc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209832032B;
	Sat, 29 Jun 2024 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719694255; cv=none; b=DmWufpGFCN4xomZrnNvdDlJNbzfvvT4G7QqBKuC1HhswPvoFHzThNbGXPAKdFiOsaWkngt/4uNDQCO4rQQvqzXx14hLD0Za6IOqaC6bRsnl+mX2hUZGzwW8z86+nMDHG46nYT/CcLJ4kV2GjFWKTdl+7WyKuO0tZvlS29GXAKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719694255; c=relaxed/simple;
	bh=htBZTH+Edjre4pkYs24rFwxkI0nMVpuFJxTMnbP39cs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mqkHedE/TvQiVreMKgFWv843vYkJcoVMvaPwMCPWt5DNKhIEr13CH0VfoWfWU/JhGIxlmnYConu6o7WBS15pRrOl/+Gm3f1UlNM6LLo5/ntAPkrXw7hMwDxVnvtC2kmKdQJPkMSi5/cAqPEocczm2sYcRS1KulsR/snXmIDMzmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldQjrjtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A912FC2BBFC;
	Sat, 29 Jun 2024 20:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719694254;
	bh=htBZTH+Edjre4pkYs24rFwxkI0nMVpuFJxTMnbP39cs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ldQjrjtc2OXnnv7Wt437y4vgF1uTXf/EI6xsYur+Ymse1I1H89bQOL1VAj7ObO9/A
	 LjJNFC2HTAGMwZbBxeOmsjMBFflXoPGKnbngtsmcEFG1YTGgfF/shpwwjwXpy7FW7a
	 GY+BEHLGBIQAT6Vn0Z+qjyUNEfJz7Juf7auGHGhER47EYGSTgzywppihT3DKmqh7m9
	 FiuxtoRdNpZgt744/nI6wJphHFyOTvbOM1O3FddS76ZeP23zTZpVtLGIIgcIZUYX6z
	 slNPTqic5SEkLrFl83OOEaYi5aj7pIPRPBrN0tiYl24toi4vM8eCyFrCqLzCStcqt8
	 UYxhlSLxqATaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DF45C433E9;
	Sat, 29 Jun 2024 20:50:54 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client bugfix for Linux-6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <dc1c267b7628de99b6f134f411a9c3ca86bc56c4.camel@hammerspace.com>
References: <dc1c267b7628de99b6f134f411a9c3ca86bc56c4.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <dc1c267b7628de99b6f134f411a9c3ca86bc56c4.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.10-3
X-PR-Tracked-Commit-Id: 6ddc9deacc1312762c2edd9de00ce76b00f69f7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8282d5af7be82100c5460d093e9774140a26b96a
Message-Id: <171969425463.4408.8279816423986894290.pr-tracker-bot@kernel.org>
Date: Sat, 29 Jun 2024 20:50:54 +0000
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 29 Jun 2024 18:34:18 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.10-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8282d5af7be82100c5460d093e9774140a26b96a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

