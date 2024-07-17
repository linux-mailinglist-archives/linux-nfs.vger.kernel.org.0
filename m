Return-Path: <linux-nfs+bounces-4975-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578A6934324
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 22:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69933283A80
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 20:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D3A18785E;
	Wed, 17 Jul 2024 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHNQJl92"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD70185E62;
	Wed, 17 Jul 2024 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247508; cv=none; b=aOuWDFb4DGSRIU/K13QZbN/wNkLEYwy0BAnyQaU5QUe+wt+o5lZ9Zb87vwKKTFgCowBW86w8MfgRU4ehZqmwDPtqVmjYFsY6yPfKeVs4WDSwg06TXNgiGO1ISoDQD1APp6tK1RhPbtU4QdqyBkLtpszDuSVD4z5cGtPGpoNcOaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247508; c=relaxed/simple;
	bh=egA5IkXJugbvtCo4bqBKyGfwRGIj/9H1IEUM2HjYat4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sCOlX8KwPuyHKb9K/E6sH7DdiOngk3WlOObDIXx3md60IQHCXe0Ay2lezBlungxCzp+bCpcO2ekjhOu2b368Lfpct9l75L3R+X3yrSQ4N0SfesBxBenLmX7ApdX+GprtzkK4T0AwDWet2qFKSCu+6lvIyKsCenPE+xiT9c9XigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHNQJl92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EF99C4AF18;
	Wed, 17 Jul 2024 20:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721247508;
	bh=egA5IkXJugbvtCo4bqBKyGfwRGIj/9H1IEUM2HjYat4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UHNQJl926Eb7KQlxs/lZsON5vegXQIYEkoatp8/3G6EWC2ZhLEtf/nqQjV0AaER3a
	 o6bcIzjZ2P/N8ySGx9fJvB1kZ3DoNQdgeluEho0QZbmTgr3QtJFj9yxdSiF2JlYq1T
	 VU4wv7651TYqRR/Q423m4S1xVZeAIseEdkM2PwUWX8vBnTMARkC8xFvq8g2fudzJ8z
	 /enZTMI/NI1RSDU34ACmsbPBbUD9ze6M+kg1qDUTvudZM0fno2n+ep6nMmTYs2+2sL
	 ZPcKg758+KDAMyBQ8XfYXgZoJgk74NXjw75oDWCKs3IibcyClbWgAKNeB04UjrvwkH
	 mEpn2XPBQrZVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6289CC433E9;
	Wed, 17 Jul 2024 20:18:28 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpU0EWtsVcy+J3DO@tissot.1015granger.net>
References: <ZpU0EWtsVcy+J3DO@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZpU0EWtsVcy+J3DO@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.11
X-PR-Tracked-Commit-Id: 769d20028f45a4f442cfe558a32faba357a7f5e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 586a7a854234b0a48b0e188ad11896fd2764174f
Message-Id: <172124750839.12217.4903886514450253101.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 20:18:28 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 10:37:05 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/586a7a854234b0a48b0e188ad11896fd2764174f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

