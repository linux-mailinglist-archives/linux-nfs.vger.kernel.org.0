Return-Path: <linux-nfs+bounces-1425-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9A583CD00
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 21:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D1AB233C1
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC3D136640;
	Thu, 25 Jan 2024 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTfDeHgP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B9273175;
	Thu, 25 Jan 2024 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212804; cv=none; b=DSnX23qF50z94uyIaeQXQlKHtpzIo+faMhhwhv9CziDlBoc8FuJjewCahSjazaTaWwprGkSDvCL+clyWfd65Wsaygsx+j81eo5iSzt+bdsaiB9Oeyf6j2MszoeYEc1FiYs9WfvFLfO5wlfbqtkHINkhDEcB064YoVdfYErzuLLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212804; c=relaxed/simple;
	bh=ZFnMI0/SXfSTdJN4Hi4k39XnZenpetS+ne6kdmaF6jo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j7JeLJ8eU/1SDX08FqHXhabrKHuNQwSWaWxfAXg+E0e32O+CGKgY8YxUXlD9CDnGmotVDVmUcavhKeuPLKtIbwslBJ6dDcXKQI1iDC92HJigxqtWGUQ5DGAHUR2R4ibvnxOxTy09aHXGLCFBL/NNhFGxJFuye/puRMhJIb1ztE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTfDeHgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06B51C43390;
	Thu, 25 Jan 2024 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706212804;
	bh=ZFnMI0/SXfSTdJN4Hi4k39XnZenpetS+ne6kdmaF6jo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CTfDeHgPUIfBUu+fshKLFjf8cGiKOKyHv+zQ39xUjptsJiFFlmcYfdEHQdCvNDyGn
	 yqMtKtdPEyHtSQBRGi76s0/G9qp39F9hyT3uNJtKmpZewsvkLiH78aJo/LGCZMCxjk
	 t8AdnhxvK/FoSXmGfZy8X9Tu/037ZEihCRxOe9rLjtTjZl+gUK6fq2bQQ3PXNhB5j6
	 ZkN4q2t85wfOdMLEzxeKpk5Q2TrUQ9tKLN//PeGJkWUVZ0ViJK+cg46IAjD72ufkQ1
	 Rzg+GRJpxfcIkmlCi7yGicebSgJ2AAUQNz94RpDzmv2Yd3EIZUy4svr3nvvUWxN14q
	 fPLwb02waBhPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4114DC99E0;
	Thu, 25 Jan 2024 20:00:03 +0000 (UTC)
Subject: Re: [GIT PULL] first round of 6.8 fixes for NFSD
From: pr-tracker-bot@kernel.org
In-Reply-To: <A3915BC8-E134-4094-A88F-3C75CA908B10@oracle.com>
References: <A3915BC8-E134-4094-A88F-3C75CA908B10@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <A3915BC8-E134-4094-A88F-3C75CA908B10@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.8-1
X-PR-Tracked-Commit-Id: edcf9725150e42beeca42d085149f4c88fa97afd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9fa4cbd8415c57d514a45c5eb6272d40961d6c7
Message-Id: <170621280383.19358.1142771434552068942.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jan 2024 20:00:03 +0000
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jan 2024 01:43:49 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9fa4cbd8415c57d514a45c5eb6272d40961d6c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

