Return-Path: <linux-nfs+bounces-8754-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3E9FB51C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 21:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FCC188313C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 20:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EE01B4F02;
	Mon, 23 Dec 2024 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BooMkVwA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B2E1ADFFB
	for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2024 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734985121; cv=none; b=q3K3zo8bsaIduXNHyxg9ukK9nPYrdB/QjLCQw10ENZGtYlgmZ0YKQ8FiwbrHCdfWi3+nRWQxkDH2Kt8damIoByGnUswtdYHjMl1YQf23rh3Ei5agq9LYgqm7aymZ4o3uUe77+vcs6qp9CSv6oJC2gslCU59o/cLDOOPCe+XgPGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734985121; c=relaxed/simple;
	bh=VI2Ciq0sjulThsFL2WyMI/id591EItkdFYkTM3aeIPw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qoSZI3czhLbJHYbq9rbxmo1JVqz1y39YY10UwhLWsZjpfWAOjGrIcQhWHb6cZQjV6JEStplBc3kzntrSNAxAZYHzhT4kxniF5qWqJwq+8MP3T5jdLmgaOD2vHVuLEKLeEHK4DOluQqta2sGoSLkccetoNIj0BQwJkoLADuaQhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BooMkVwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E1BC4CED3;
	Mon, 23 Dec 2024 20:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734985121;
	bh=VI2Ciq0sjulThsFL2WyMI/id591EItkdFYkTM3aeIPw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BooMkVwAhcBO1X5xcaDRFr5W20DzknTPDFulEpZd+wyIVe0gR4eogOHomkOBahO7n
	 PjsTpOyl/dwV/YW0iUAeM1I0PwNL2uLXjYY3KJ94AbMTfze29c8ucdNZe25GOtWdQ6
	 ql6ljhy0tD3XEP5bFXH7dNtvAtJgU7rCDVPRlhAxOT9Y1+yfmq5tzZmEl5N410zrip
	 YQojAbP/i70uk5LrDSAqsf6BXD1kBwi35C/D20MO1lr0v+l7cPWvxQtXj2W+SxUS94
	 pu5Nmapm6rzIPYN63KemU++o7YItwnWWGXvZ/iI5H2tEWXmSfM0KdHjxo4NXMHayMM
	 Uqem0jaxt63xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5843805DBC;
	Mon, 23 Dec 2024 20:19:00 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD fixes for v6.13-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <aa86e853-efca-4035-bb2a-d52a029bdbd3@oracle.com>
References: <aa86e853-efca-4035-bb2a-d52a029bdbd3@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <aa86e853-efca-4035-bb2a-d52a029bdbd3@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.13-1
X-PR-Tracked-Commit-Id: 7917f01a286ce01e9c085e24468421f596ee1a0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f07044dd0df0c9d0ad177c3098b62ccddb735a2d
Message-Id: <173498513923.3946453.8131955365559446545.pr-tracker-bot@kernel.org>
Date: Mon, 23 Dec 2024 20:18:59 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Dec 2024 13:54:32 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f07044dd0df0c9d0ad177c3098b62ccddb735a2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

