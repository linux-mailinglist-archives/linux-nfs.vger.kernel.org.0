Return-Path: <linux-nfs+bounces-8274-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C109DF299
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2024 19:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FB8162FD9
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2024 18:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D043154456;
	Sat, 30 Nov 2024 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQilyAuj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3C8468;
	Sat, 30 Nov 2024 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732991913; cv=none; b=B4VGhGKibBrAOUpJjJ2/EkXc4oEoPsfBA/OC8yvboUh2kLBmwoqAVFC3gU0z8tqavcUKfO7d/3DrwH8l7QCL79HM0rV4/HBYoxVCz+UEa0cSjHAiNXY1V5XtXxqUvQ/9hW+w4nKDzFWfhZaUwZJhq7HIv/yny72bKm+pLhZa+9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732991913; c=relaxed/simple;
	bh=BYVMPsFHCnXrh2JHBfoj6gZYuAHf10di/10DVZ++2Qg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fOf/NVupigZRFBH5FmMEWwvFNgvXlobBTYPWGpbXmjroqxPniQ+68s7+JHWFAoBF6ah5X35n8r8hXLnRPDLPuMA7ZYVGdpBI498CFD4YH02ULyrP/pgSv3Oq8yRaKjUjRmkrPaasR2RkVlShXhy7oslSx5DsVEJCNMddg8E0904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQilyAuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF472C4CECC;
	Sat, 30 Nov 2024 18:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732991913;
	bh=BYVMPsFHCnXrh2JHBfoj6gZYuAHf10di/10DVZ++2Qg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MQilyAuj0qDKh/eH9nHK4eQF5hA+s2dF/skL3lb/chorOMtLIYBBalYvlNEa9pLfN
	 E1Ic9VYbP3LiaZv+xWQ13bB5A06tcI73m1Lx7IJ6KfMgrQ2gbljI2fPfxpaZkrLjBo
	 gT0jngzGkgp6W3wAPOvsKjYPIW0C5vQiDLqk7o8J+iaKpfPVtj6sS0/hfKx50+b+2Q
	 cv9ueFrsAulmEz4Dr6vUcGrgks4zK2ONaccZK2nSJGrXHm9IiXGIsOQ1oVf0N3cWCP
	 P1NpWKg8JviOeC6rM/kRILHKAo4H/HuNjp1tN9kHsozlI67h35OtrTGodYnLOftufK
	 GzYUZSJYUrYZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFA8380A944;
	Sat, 30 Nov 2024 18:38:48 +0000 (UTC)
Subject: Re: [GIT PULL v2] Please pull NFS client changes for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <173b7b2ce8ca6ab9cf692ea5e2ae7efea6ee9b31.camel@hammerspace.com>
References: <173b7b2ce8ca6ab9cf692ea5e2ae7efea6ee9b31.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <173b7b2ce8ca6ab9cf692ea5e2ae7efea6ee9b31.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.13-1
X-PR-Tracked-Commit-Id: 38a125b31504f91bf6fdd3cfc3a3e9a721e6c97a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: baf67f6aa9d29512809f1b1fbab624fce57fd16d
Message-Id: <173299192730.2451487.15522514823003491071.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2024 18:38:47 +0000
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Nov 2024 19:27:56 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/baf67f6aa9d29512809f1b1fbab624fce57fd16d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

