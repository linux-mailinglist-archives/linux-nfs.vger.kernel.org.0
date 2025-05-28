Return-Path: <linux-nfs+bounces-11959-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F8BAC7198
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 21:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CA51C01A75
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 19:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3D621FF41;
	Wed, 28 May 2025 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvxefWHt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21168111AD;
	Wed, 28 May 2025 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461451; cv=none; b=A3n5VqSKO7ujpVDwHoMBbJE0CrR5cPNrfAAhSfRfQvI9a94Rt1OaegBf1pbYfqwAvCP6yNjBN9EFsOUr8jj6g/kSMRkhnlWM4PiQwDSkM14M2cP4qqYHD6hZOce8HviyTWH9QSWxeL5ocj2ppMaCbWzVTEJ/N0RHud0oePd8sAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461451; c=relaxed/simple;
	bh=e6X0ntkrwEcI/Yjg6TxtkcqfPeo/43uI490dEilVNOY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fqAXvQU0eD85rskxJBif9e7QOrEBaERv1c7asK5fVVLR1TNjvqB66pVLdLNoy1/SooVCqnlgyPVX/Jck45Bnr6i79yafe4mW4eSnSf+o3bWTVq4ovaIgZtqWAaZM9MIT3OG9LHYiBTrBKlJVwbj4YmxLvc/s96eAJ44evHVdDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvxefWHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010DEC4CEE3;
	Wed, 28 May 2025 19:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748461451;
	bh=e6X0ntkrwEcI/Yjg6TxtkcqfPeo/43uI490dEilVNOY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mvxefWHtaNi2iX/nJyCFQ94+qDuj9B2y4MEEckitPas3NNQE0gBvZG7xyCmF4PMKc
	 zZempfPlAhnaFY+L27qZ1qiZL/bHiPtBqgBQNYefhH8AAVdP/q/Wgk+9bb9VNB2QsW
	 Z1/Bq4ogsz9AZzjwGXupSsg/hkit+4iSLnkKhRYWCpEWAwdJGtYBlHkXFviOi4uFJE
	 9C1qJKI0CbUpjuIu7zGiI+VgyOs/tsKKAklPdv4nC8FVD4gxay8TokV00xbDYLZX3k
	 7FV0oRS4+EGeMfu2z0ykLdQdaYqErXUx89nKkSW9NpErrrz1VYgniamk4UXbWCc4CQ
	 0VL9NXojGXFCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EBA3822D1A;
	Wed, 28 May 2025 19:44:46 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250527141706.388993-1-cel@kernel.org>
References: <20250527141706.388993-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250527141706.388993-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.16
X-PR-Tracked-Commit-Id: 425364dc49f050b6008b43408aa96d42105a9c1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c26b68cd5c51689b8cee9cb6a21abb5d2ab2d0f
Message-Id: <174846148482.2536722.14241215748390265331.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 19:44:44 +0000
To: cel@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 10:17:06 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c26b68cd5c51689b8cee9cb6a21abb5d2ab2d0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

