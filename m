Return-Path: <linux-nfs+bounces-8226-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDF9D9EA6
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 22:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506A8168A3D
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 21:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27FF1DFD9F;
	Tue, 26 Nov 2024 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN1yAbfU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBF61DF99D;
	Tue, 26 Nov 2024 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732655102; cv=none; b=KCpfV6ITS8xw1UJx0QgCcFWGP0PcsG5hSf8HHA9r+jFPgLVvTsuZR8OAdI0I/6pOw+Q61WfEW4kLdJ5BEe/8QgMJaKMLBZT1Ymqxpo0hxIj4Mp6nYukvMqz4pEYJzB4nbLz13qmVgXAX2RcySNEG1r35mLZhE75P81TnxhroTbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732655102; c=relaxed/simple;
	bh=i0LxOvfK28Z52U25B2ST3QcbhpVu57HLMVODFi7SE0c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Rgd5gdYD7eVsCaIl2FaByhNMrJqWoXBFsxXJTLSN/LECB6UENQ2gvrwWj/rvzgu5rb2oAHYcmmwkk+juTGlZrlhFgYjp1Wh+/dM+IrceBH6qTOXXzfD1j9PEHjLQ13miuIrH/1/NXOwlEzEk2I5TX0OHBEz81E1UirLfm7V29kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN1yAbfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D229C4CED0;
	Tue, 26 Nov 2024 21:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732655102;
	bh=i0LxOvfK28Z52U25B2ST3QcbhpVu57HLMVODFi7SE0c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IN1yAbfUrrFe741mGXvG0efCCqtCCuyxeDVBRMbLvdHQEQMKh6NOADyLvDbdbptW0
	 vbmSZ0OdzWOVXDeCn4oJifJv7UKEW48t/08KUCX57wgxCnBcY3eFOxUEowSv+2szsL
	 v9gKikfngQv48IolTb1ImeX9nsTG0cNTHsG3yjS1Pah7RCKbzOn6sBBdO8AI7PGOYV
	 Uv9BXT9AtBGngwAD5+ORYPeBRzoAZcvC4Oz7S7jVq/5bBdFhurVk0FOetxuS1j8buq
	 aEX6KQH4q14NKOeJLvCytxCzZfLLCHEsulMZhWkYRfkUY1KYuoMErGCPPtaL/sO6lA
	 nMDMCQtg8xwOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1203809A00;
	Tue, 26 Nov 2024 21:05:16 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0Xg7A1J/CkYiENR@tissot.1015granger.net>
References: <Z0Xg7A1J/CkYiENR@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z0Xg7A1J/CkYiENR@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.13
X-PR-Tracked-Commit-Id: 583772eec7b0096516a8ee8b1cc31401894f1e3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 445d9f05fa149556422f7fdd52dacf487cc8e7be
Message-Id: <173265511521.539328.8368166461221509113.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 21:05:15 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 26 Nov 2024 09:53:32 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/445d9f05fa149556422f7fdd52dacf487cc8e7be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

