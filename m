Return-Path: <linux-nfs+bounces-13291-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 616A9B144C9
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 01:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E1B7AE6E1
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 23:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0802253F2C;
	Mon, 28 Jul 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5So/KO+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A30254849;
	Mon, 28 Jul 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746000; cv=none; b=MesvFGZOqIF/dvb8G7WfDO94kDBcRgpNdOoq12jExldBgwBBttB1yZ3VrFCo9ARt29C58oD97hP+rCGKFdTRY8gD6Jbi57R5q6XYhWqR0cvIT6HnUjJ2OCx/OFWeKr6sq11SV4lcTKZRehNZZn86oPBeuJwg/oCcvSLqwXiozb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746000; c=relaxed/simple;
	bh=sQv+XFikgwvRSYtIkF3q+nZkowTjL8lo3VqQgo/JZ2Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bw4rN74Hm1z8wh/OwEsnzdDG9RRX5Ip9kk9Rr7Em9oZLETVWUAu0o959JwapRrnIZatkZR8w0+LKAnLQTnYrTKPOqv8ImpNwzTigiXWL+HNdRccO2PFyRiYtvhXfad9g2Q96IxUGfZ1BwePp5mtua8NW42SzWCXlrrIF0rTJ+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5So/KO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841B2C4CEF9;
	Mon, 28 Jul 2025 23:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746000;
	bh=sQv+XFikgwvRSYtIkF3q+nZkowTjL8lo3VqQgo/JZ2Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I5So/KO+BjHIYya5EzNNkb8OismKlXf+Mt11wcahAS1dlYwgbNdDea6pGElmRcqCB
	 WCvQ5SBPTbSyy62xVPtSXvwNGYBGaJc3fbq6U/jk9P0ZclOn9QYRftWReqrlg/YNhI
	 oNYimNqE1UJhGFRLAUGD8kn+lp9Jh6xLZrCpJ4ixyjcIINkvI9pkpKCtmzz3JcTxwU
	 xG1q9yN499qi/TquCt1bXvlrAs2giJGw3coraEb9hy5J7FCgihGnNENMkhALnYXCDX
	 nQ6qO6dnkQd4XA3jJ2nvKaDAn0bAi/osFprjWttqFRlRMtXzo44CuXN73lyV5UvDX3
	 KFosrmPCjTXkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D52383BF62;
	Mon, 28 Jul 2025 23:40:18 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250728143033.70585-1-cel@kernel.org>
References: <20250728143033.70585-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250728143033.70585-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.17
X-PR-Tracked-Commit-Id: e339967eecf1305557f7c697e1bc10b5cc495454
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce3f5bb7504ca802efa710280a4601a06545bd2e
Message-Id: <175374601703.885311.15818635347973177201.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:17 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 10:30:33 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce3f5bb7504ca802efa710280a4601a06545bd2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

