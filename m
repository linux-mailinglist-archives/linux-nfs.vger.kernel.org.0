Return-Path: <linux-nfs+bounces-4382-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F9E91C44B
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 19:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3111F2436F
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 17:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E8C1CCCCA;
	Fri, 28 Jun 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7W7Pyc+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB61CCCC4;
	Fri, 28 Jun 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594068; cv=none; b=MCqxcCJsTamFS0tl1ZSPtnSSwGhJwv0D12zGObzueC5BfjgLBwDqmB5HTq0UHroBHhV21z3rcYqSFlDjuFHjdrq/Scp9uj7/BZiDtZRHGHOHDLRYPPMzIVF7YjNXrw/QkIh+JZhr1mFMh9d6a5LHk+vkmZKViNXl+tTs7LCrgi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594068; c=relaxed/simple;
	bh=27t2NpUtT177OCmqX/RiVtZBck3ggj+tk5lX6t0hULU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KtnCtBjpoy6v6GBZhe6bJhNeGvd77jSpdK7kjiIrrwPjVXrAGnTzosYhWxVTryCuUfq4xoXEBxz+OxuauYYhDLKDdmV2l/i8v8hrbqbS+SoRT7L2NQ+QJiETVl6qOmczvLI53ffqbrb3YNHhGW/WAuzjtNlStRsg2njr8k5w9cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7W7Pyc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBA1CC2BD10;
	Fri, 28 Jun 2024 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594068;
	bh=27t2NpUtT177OCmqX/RiVtZBck3ggj+tk5lX6t0hULU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q7W7Pyc+jkEqaCVvonj2MxyPeBC01tc7ZNvkVasheXgQDS/jjeEWondmYO7niM5bm
	 2ojEkHlb2HnQyOazrayYQvwBbTel3hBN2BbKds1/flSodO7fj+zC6uc2Z0JkvbOBd4
	 QO4W06CbxTDR2hfR+7+MYARzKD6hYhk6c4PgUu4bg4uCngrG81yEJTfpMGiihmzcy5
	 ImexkaNHer0XodpecxyycL9NP4TKTcgtZF6CZokkhLIo+Q7G62MjymF0XP8w168wFt
	 icFdRM11VsWnBuVexqXVFH6bTZJ1JobJnBivVb41DRgQHPbUje4y97zEk7kTqHgySu
	 43un7RMXb0OlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1036C433A2;
	Fri, 28 Jun 2024 17:01:07 +0000 (UTC)
Subject: Re: [GIT PULL] Additional fixes for NFSD in v6.10-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zn7PNqLWc1Q4MqZ6@tissot.1015granger.net>
References: <Zn7PNqLWc1Q4MqZ6@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zn7PNqLWc1Q4MqZ6@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.10-3
X-PR-Tracked-Commit-Id: ac03629b1612ad008ea6603a3d142e291e3de9bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c0483dbfe7223f2b8390e3d5fe942629d3317b7
Message-Id: <171959406791.14402.4815054769860774296.pr-tracker-bot@kernel.org>
Date: Fri, 28 Jun 2024 17:01:07 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Jun 2024 10:56:54 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.10-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c0483dbfe7223f2b8390e3d5fe942629d3317b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

