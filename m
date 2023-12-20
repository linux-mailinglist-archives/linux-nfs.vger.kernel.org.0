Return-Path: <linux-nfs+bounces-724-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728FD81A783
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Dec 2023 21:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115C31F22F01
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Dec 2023 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8DE482E3;
	Wed, 20 Dec 2023 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBAAhA7Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1BC41841;
	Wed, 20 Dec 2023 20:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15534C433C7;
	Wed, 20 Dec 2023 20:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703103192;
	bh=cUulZY7a6w+CtQVA4by2nPiQJljSCjxCA5eTFRsuNNM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uBAAhA7Z0MpS2m+TiH+tqxtEDtIIBgfOVUFqoKryNv70jC+Wf+tCr25wT0aHTLCsu
	 lw4TBT8bP2//KQzkpPaQkCCpSzfDDa8U5IBzR1BrpyI3hwWZRd3bHqBx5nYVZsHy7c
	 mVxWRt6gMWYzgn4IC7UvL+f+lJS1ENoV8Fk+PiO8bjhbQH94zsV7N208Vq/QI31qLh
	 giQO1N24RjQuOJf7mNzWlQGOMggeuMGKyzLShBrsL58QBmKk/a8H7ni+MFXaw6W3VP
	 zu6J/BIyG0JjzR2G0xCqWAUrYzN01Dzlpg4bDrrUNdzOhST87MTmVaRsJlPNy+ySyt
	 TTurxu8/1PJSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F423DD8C985;
	Wed, 20 Dec 2023 20:13:11 +0000 (UTC)
Subject: Re: [GIT PULL] more NFSD fixes for 6.7-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <957B327E-8807-4EEC-8BA3-6465A0810778@oracle.com>
References: <957B327E-8807-4EEC-8BA3-6465A0810778@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <957B327E-8807-4EEC-8BA3-6465A0810778@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.7-2
X-PR-Tracked-Commit-Id: bd018b98ba84ca0c80abac1ef23ce726a809e58c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac1c13e257c798510a60559c2cd50f1828f89c4e
Message-Id: <170310319199.16038.6468012873166012993.pr-tracker-bot@kernel.org>
Date: Wed, 20 Dec 2023 20:13:11 +0000
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Dec 2023 20:41:12 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac1c13e257c798510a60559c2cd50f1828f89c4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

