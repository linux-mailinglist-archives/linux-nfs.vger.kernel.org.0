Return-Path: <linux-nfs+bounces-7630-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3058E9BA38D
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Nov 2024 03:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813051F21B43
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Nov 2024 02:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A8667A0D;
	Sun,  3 Nov 2024 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxwskAA+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B2FBE6C;
	Sun,  3 Nov 2024 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730600780; cv=none; b=BAUKyxmKL68psWoFi8b8ysc8RFe3ARLULBKhb+ZcLoOu031cqkwulha8HSVa6+r6c7f5Nn7Jv3ujMS+R3D9Ml7Zaswmj0Cabi0aPhC2hODptRXxQp6PxEBa4BE1Ta9r06C1p31YRAyDVpkSqxEuj9Iio0mbdmxFaNhrmYb6MhT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730600780; c=relaxed/simple;
	bh=yMz0tRcowpkl5zxLc5dfvmBPHj/sJKtNeAY0DZ34/Fg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lj+coFCkcv1ymddcXt5ambdXk75S5ptWZDXqTuWxG1S4Xt7UAI/3XxAeDAxn+/7/rdp4KTToz+gMggElsElIy9WdMqfo9KJMIHm/1Y0hBX2Oj/uNntD3MPT/ZnRp5Scu7w/z3iu5Q4f5mpRmbeZ3/22iaBakRwejIC7unxEWs9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxwskAA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEF5C4CEC3;
	Sun,  3 Nov 2024 02:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730600780;
	bh=yMz0tRcowpkl5zxLc5dfvmBPHj/sJKtNeAY0DZ34/Fg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dxwskAA+gig1H5kwLbxk8jtuVZobt5qDFQawHE5Ogwknk/odqQgeg3r3RWgjnJIAU
	 5nEgR/Pj8NlGfoFz+IqO99pOEFJeAW2+FFxKt9UPRuA/FS9ddU4mh79HXYAPg1AguZ
	 J5ySPC3Vpjo2fF3YSb9zusCdMCeH0vXT+WFHf2rgnFlY80RqZ1Kb4fIk8D4UJWT48I
	 3fZkBxftX3Ao8C2hZiXUkg8PcU7cNKPJl/2eY6+hf/6KznAdodfMD53BoDPrHQqd29
	 2SPnxhwDgRgLAgUuJAtNN3HwkKO7dGTdNRQ/tbIT7sjik2wn4KqJ35qtsaj2AqeRIs
	 e2PMeVx1sv79A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACE038363C3;
	Sun,  3 Nov 2024 02:26:29 +0000 (UTC)
Subject: Re: [GIT PULL] more NFSD fixes for v6.12-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZyZwr9KvqOFkwE0N@tissot.1015granger.net>
References: <ZyZwr9KvqOFkwE0N@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZyZwr9KvqOFkwE0N@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12-3
X-PR-Tracked-Commit-Id: 63a81588cd2025e75fbaf30b65930b76825c456f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e5e6c9900c3d71895e8bdeacfb579462e98eba1
Message-Id: <173060078845.3103663.7535828207147998970.pr-tracker-bot@kernel.org>
Date: Sun, 03 Nov 2024 02:26:28 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 2 Nov 2024 14:34:23 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e5e6c9900c3d71895e8bdeacfb579462e98eba1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

