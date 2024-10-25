Return-Path: <linux-nfs+bounces-7472-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF59B0ED4
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 21:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F411C21CE4
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 19:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870E5214410;
	Fri, 25 Oct 2024 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3eqBBpW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041F20EA5B;
	Fri, 25 Oct 2024 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883909; cv=none; b=dLhoX9TSqf43Rs7a2z6ZDWbZ2Yc7RpxSjdbnFmRV85IpBfHpgWj4KiznakuJTmY+ZBmzwqC1cgFZfUibssNwCMnX01z3ArVRR4m0NtGzYqBDKMaKaoeAz0Krq56iKeG1knIPQ4aFUHRVdXduvDqbqud6PhvjVQ3NKVg9av3mqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883909; c=relaxed/simple;
	bh=1JCmDp2k85XOx9cTHjM55MD3saJLLLuwJVSLRKdRvIE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CAipnSPkwKN+VDVSf0M5XYSHP+vrHDtHnfS7spbzkpd0NDECylFuYwLgwy3ghykpExyF7wOVArkmZXemKCyepTnbWKaY13ph/PqzKe7CnrsRBEj8hNiBd76U5IYLIzwOyGw5qgYGrfhW9czcCUKltXLwMTfsi/T64QyMv4WF1Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3eqBBpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D6BC4CEC3;
	Fri, 25 Oct 2024 19:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729883908;
	bh=1JCmDp2k85XOx9cTHjM55MD3saJLLLuwJVSLRKdRvIE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g3eqBBpWYuJ8bgWR/SqBS3cK2l9GMMpckBy4NaJS2Gl1jLjzhlP1i3ME2eO9YapAa
	 HNQVC4kkmuG1yKycxCTwtx2zILLBPY8ipCcrsHsg3md3R4BnXVLC2IDylFNzWIXJr9
	 cRFtt0Nlngbe9YBqQQVMnmm5W0Jvvnw8cFJU1DFxOfnukPWRvoMX/9vmRD05RAFe58
	 9+O2pCMTZcBR6Qmwwfs7gSLb4JbdiOQIT5HlLEp8BjUekL8dxR76SZhMQveZfXmHSD
	 opNsOqT7HgcJClZujsMlvhPVTwhXr2UmU/5jkR/ha2QJkkhpi/t/4WlYT1O18WDnpr
	 FfMlpXAHcxY5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E2BF33809A8A;
	Fri, 25 Oct 2024 19:18:36 +0000 (UTC)
Subject: Re: [GIT PULL] additional NFSD fixes for v6.12-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZxupRdOKLeNUKTyJ@tissot.1015granger.net>
References: <ZxupRdOKLeNUKTyJ@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZxupRdOKLeNUKTyJ@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12-2
X-PR-Tracked-Commit-Id: d5ff2fb2e7167e9483846e34148e60c0c016a1f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f647053312ee1a01927a4ec2970c0fbbb31f983a
Message-Id: <172988391552.3013963.13435132907961784325.pr-tracker-bot@kernel.org>
Date: Fri, 25 Oct 2024 19:18:35 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Oct 2024 10:20:53 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f647053312ee1a01927a4ec2970c0fbbb31f983a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

