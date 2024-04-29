Return-Path: <linux-nfs+bounces-3070-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F2F8B64BB
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 23:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1BDB20ACA
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 21:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6FA1836D3;
	Mon, 29 Apr 2024 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4TXY6Ln"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1A946C;
	Mon, 29 Apr 2024 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426843; cv=none; b=skNWUigvaLbCJ+dOxaUOJpirPtlH3k88umXfeZdBfkpHK6vDRrT1DCdAgA2n3aFRdcNCj+n1arOxchUkAtoi1jD8YeO/HhPS2KPXojRBK28UAhRe+zMKikiyoHe4VMuwb1tFCdzBiW22oVfy1M+kR4b5+2rYKwuD1nVG1mP65NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426843; c=relaxed/simple;
	bh=bq9KL6EZw7mRtwEahFykXn5GG7qI/qUD1qgJuWY8VzI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E4zDrzqHCpZ3a9+RoSkJMEchXj136IYotc5bzNn9Ux244Zzlmp5KsyS052oV6RWsO9NgKAEUskViGdFlJ6d9XDUnNHy6pSwxnnHt8dGeRgDeMP02R/1rzgqgyWKgJv27yt9mlzbUmqAA33TqsbwYRXcHhDfPPcdeadTeU/62OWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4TXY6Ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA8B4C113CD;
	Mon, 29 Apr 2024 21:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714426842;
	bh=bq9KL6EZw7mRtwEahFykXn5GG7qI/qUD1qgJuWY8VzI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K4TXY6Lnn8aKB/+3FLYwqXG0OkJ+i4kOtQbLyLJyb3ZQcbsXUQ11FtSkuTQk7JNZv
	 bLTMkupDKYPdt+SO9V+AiN6L9tcfWa93n5qDbGOlWcPwvKTCq1KP4FA0ReewUU5kME
	 R93PGeFCGfgODiRd2ChSx6zVDMx6i49SfXf3LDWChzsbwEXAL84PN6yLJomNb8xz7i
	 pUETsJ8CBMz/Acla9RgIpO1Jv9n2VryW/e2G2PJEFulkzWABkc3LZZhrrU+cWwTLVx
	 jv/qH8ng5zDncTWdTCKmcGWtTDNHgaxAZkK+/208SXSoS6LeRyyabzyy4McDXGftNM
	 5u5a2kLWsqWQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99E86C54BA4;
	Mon, 29 Apr 2024 21:40:42 +0000 (UTC)
Subject: Re: [GIT PULL] 6th set of NFSD fixes for v6.9-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zi/+mXlrQ41AdK6G@tissot.1015granger.net>
References: <Zi/+mXlrQ41AdK6G@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zi/+mXlrQ41AdK6G@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-6
X-PR-Tracked-Commit-Id: 18180a4550d08be4eb0387fe83f02f703f92d4e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a91bae8794fa77a5f208fe76d3503c1099e93575
Message-Id: <171442684261.12451.5496762590273458424.pr-tracker-bot@kernel.org>
Date: Mon, 29 Apr 2024 21:40:42 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Apr 2024 16:10:01 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a91bae8794fa77a5f208fe76d3503c1099e93575

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

