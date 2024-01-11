Return-Path: <linux-nfs+bounces-1026-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D177A82A5FA
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 03:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B961C20C11
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 02:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADB9E554;
	Thu, 11 Jan 2024 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB0pPAC2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1250E544
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 02:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A9C8C433C7;
	Thu, 11 Jan 2024 02:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704939854;
	bh=Ikv8/dCeLySK0bNOtHZezGi3QNk3x6yZwqOXmUYht/4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XB0pPAC2eyUy9Raup21WIipsceMvuE8V+9rZmgw9saT+d/TyZYZV/ipfY/kBDGjmt
	 Yj0lplsrbiF8IoaEqwuN+bXnsDgNrMJmOyF/h1vjI/NI8iScOs1wRWzGRb5joaf1Jz
	 tXZkUXCNXfzKkJBWNyXp3qlPjO+F44cgjM3mBXodVsxnjRXD9/M67A92wZuTT+F53l
	 xeth3qLR3ChD1OkYPwlewwDqp0Q7/2FoUDxJ2DxGj6kufkY9I5NN6rWCLflGyi0hFG
	 SS+6cyRIs6hh2R4+pzdxQwQ5w/mkF3nu2sWTZYXMnPxWmGI7sGPORhIDZJszNqrHVD
	 aRIvx4is6Kw2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A66CD8C96F;
	Thu, 11 Jan 2024 02:24:14 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull NFS Client Updates for Linux 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240110214314.36822-1-anna@kernel.org>
References: <20240110214314.36822-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240110214314.36822-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.8-1
X-PR-Tracked-Commit-Id: 57331a59ac0d680f606403eb24edd3c35aecba31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 587217f9706a4ff033196d819db52e32afa29654
Message-Id: <170493985448.10151.8419493033953667841.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 02:24:14 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 16:43:14 -0500:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/587217f9706a4ff033196d819db52e32afa29654

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

