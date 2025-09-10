Return-Path: <linux-nfs+bounces-14251-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811BCB5214A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 21:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB7E7AE716
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 19:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2B2D9EC8;
	Wed, 10 Sep 2025 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8wpkL3y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8182D979D;
	Wed, 10 Sep 2025 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533356; cv=none; b=iIOvjGRxqy1vgGl5UjYwXW9avnydhzfpoNoi8qnyCILdhqsOvwIPse6MXEHb949d84NlZ4xV42nonhjo8vGI9u/fZ1yPtG4FuV9Wzqn2TQBYwmiDja4BQBA6vPD76MK+ib14hIkltu4pfut1keik+Zwv/3IAAUSrFozvPlpKFjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533356; c=relaxed/simple;
	bh=QdMP7bEv90DQoZ+hHUZEhbxHn7B4NjBaKlJgJ5QiUUw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kVpBSbrEo9Z83vkEP1fO0krJ4TeyvB+w2FQcVafxM+ckErfstf+h+DJrp1zSHR0sVYtEfO4kZt02VSHhtq8KJF80mXligpffm2aPjFopZrF8UKDVoRws9UGnaavu1HllmV/ki4ML9iP4pEC1EwxW7XYeOor/Zr/8HgDsidQOzCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8wpkL3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B30C4CEF0;
	Wed, 10 Sep 2025 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757533356;
	bh=QdMP7bEv90DQoZ+hHUZEhbxHn7B4NjBaKlJgJ5QiUUw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=D8wpkL3y5idQx9YWTWz/BOgw2MpvfBa6XIW1tZTkC2QdSHbpmWJMyaAnOuGCl51Dw
	 E4b5rUQqePR0YihblZRgN+f3bhgKgxyhM5WMjDemLgrgc1WEwXKaSOr+lj7XbmUfPy
	 74DHXGA0JzkxkztR0aOkhmqBVrQ72ufaow4ChPRm3+k+lo5IiCmCV3Qh2naG+a4zAA
	 ZSbmRg3VWx95Je2jvDyTieUZ7BysWHHo4Xili8uMSD7aXLkclbbrwTAUeRLbQ4Lo6H
	 cOhKp/o1GZzjkgE2Dysu1fUfKTwuuZEah9XhnyqFjgmNFztGjy64SSo2JRHmDTQnBS
	 KPPWfxQEngvGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2C383BF69;
	Wed, 10 Sep 2025 19:42:40 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client bugfixes for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <150cb132accb448dd29e30af08394548b26524d5.camel@kernel.org>
References: <150cb132accb448dd29e30af08394548b26524d5.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <150cb132accb448dd29e30af08394548b26524d5.camel@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.17-3
X-PR-Tracked-Commit-Id: dd2fa82473453661d12723c46c9f43d9876a7efd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7aac71907bdea16e2754a782b9d9155449a9d49d
Message-Id: <175753335865.1546567.12052545947146428602.pr-tracker-bot@kernel.org>
Date: Wed, 10 Sep 2025 19:42:38 +0000
To: Trond Myklebust <trondmy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Sep 2025 14:34:55 -0400:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7aac71907bdea16e2754a782b9d9155449a9d49d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

