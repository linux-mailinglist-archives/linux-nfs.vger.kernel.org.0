Return-Path: <linux-nfs+bounces-12610-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E52AAE2A53
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 18:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885673BB12B
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 16:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3130370805;
	Sat, 21 Jun 2025 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnIKFOrX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0898119BBC;
	Sat, 21 Jun 2025 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750523735; cv=none; b=qoMvm3C8OKr4LtdjQ6paas3AF/pxlTOWW4iypbR4Zqvx9o32OApeHryp1Zk84PigwZgKIzvihSEZNM/Lk6LbBoKWROfSVydu+nKEwh5mw1KSrPVh9OTjuRvRwZGB6L+DBl6yiyfSwAp0GrA2dATp+xLHnoEEmnMqIvr8AY6Ji4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750523735; c=relaxed/simple;
	bh=v1iJS3nFhlqWgscy1WV6Km58td50gg3nUaY/2HFtyCY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M52jPijZZzUqGX3X6lcCYgSa1RUxNKoIvCbVi5o2zy9UaeodyjGCQW6PMVcHIIdCy8ssR3T+PAVmhmIWYiSVU+BzV5gJEXBGomgJFEP0UoKDY8wrJVQ27a8vJhImvMoi2NdD3NHUAKC0CYvY12qkYem/0N6SNsaohZzKlg5k3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnIKFOrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD760C4CEE7;
	Sat, 21 Jun 2025 16:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750523734;
	bh=v1iJS3nFhlqWgscy1WV6Km58td50gg3nUaY/2HFtyCY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mnIKFOrXRAlhrXWpsMiyVbH0xL6QL6wwO2byI3ESWgFzNOWLpIQlJUIefuZ1iUQTS
	 s7fm9dWavtXYLsf3EcZwrUU5k0uiey3enjA6ojshg73o2Lym7Ldo37VVKOi7Ih/1nd
	 qk0gu/PSuzt57cGzwNWjS8YMG05xc8R3BnkfqhP7Hj2pmyuaRjFfzmklFD/i+1cFAn
	 Y/pdRTdS9P7p9AJRbwfb4HqITTaKo9etWN+/PkHO4CkevEj4mNMfFazUZMxV4CnP2I
	 Szax5Zh6OtoViA0l/zMTSSlU25aTURMk7GHfKd2GXpVxa2GE7X9cyhR8wlpZiZghKW
	 e15RGD1/Gx5Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF0A38111DD;
	Sat, 21 Jun 2025 16:36:03 +0000 (UTC)
Subject: Re: [GIT PULL] First round of NFSD fixes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250621151340.499111-1-cel@kernel.org>
References: <20250621151340.499111-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250621151340.499111-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.16-1
X-PR-Tracked-Commit-Id: 94d10a4dba0bc482f2b01e39f06d5513d0f75742
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 739a6c93cc755c0daf3a7e57e018a8c61047cd90
Message-Id: <175052376235.1897727.2873684211528327419.pr-tracker-bot@kernel.org>
Date: Sat, 21 Jun 2025 16:36:02 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	jeft@codeaurora.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 21 Jun 2025 11:13:40 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.16-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/739a6c93cc755c0daf3a7e57e018a8c61047cd90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

