Return-Path: <linux-nfs+bounces-965-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604D825E44
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jan 2024 06:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992FC1F2413D
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jan 2024 05:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433E03C3B;
	Sat,  6 Jan 2024 05:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jd+T9r7r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FBE3C0E;
	Sat,  6 Jan 2024 05:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB56AC433C7;
	Sat,  6 Jan 2024 05:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704517468;
	bh=LkTgjlO7FgY/E4bOtrsx77xfOLsvx35I66fzwA+SWIw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jd+T9r7rvvPvKmncNPz66ONlQi1E8cMSxSaAWVGveUOvgQ6HqdWLWmdcz42RHzwcb
	 rrgiIT4suNeg0dQSjjzHEDyS5GI1czq4ERl4eEo0pA+LPKS9ivSBpAxdxPYhSBhy6U
	 Vj1raRHCKd0lc2O3xNXgUxeQUM5sX03FNzyK747su1glzuuzjKkHY9RwJKw8MQpZeI
	 vkBcShAs4VyQGCdYFM5h/AY1mxSp8O99Z87GVMYrdjOOAOW9V0+momZG1xsVEYijO3
	 a/+JZ6bhIt5j6X8wPiM9SWmUXvEuwnYU/gl+3OVZ4V12v/647jxb6IgX0MZY3W6XnM
	 bklpdwfyYJZNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFF54C4166F;
	Sat,  6 Jan 2024 05:04:27 +0000 (UTC)
Subject: Re: [GIT PULL] one final NFSD fix for 6.7-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <E16FA05B-5516-4138-915F-C6338F2939BB@oracle.com>
References: <E16FA05B-5516-4138-915F-C6338F2939BB@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <E16FA05B-5516-4138-915F-C6338F2939BB@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.7-3
X-PR-Tracked-Commit-Id: 64e6304169f1e1f078e7f0798033f80a7fb0ea46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d3ac66ed81cb7c0aa78fceec9fb0dbe384992ed
Message-Id: <170451746784.9519.1306778512949214303.pr-tracker-bot@kernel.org>
Date: Sat, 06 Jan 2024 05:04:27 +0000
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Jan 2024 19:40:12 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.7-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d3ac66ed81cb7c0aa78fceec9fb0dbe384992ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

