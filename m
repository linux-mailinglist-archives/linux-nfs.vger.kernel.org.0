Return-Path: <linux-nfs+bounces-3006-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52848B26AA
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 18:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3163284877
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD44414D6E5;
	Thu, 25 Apr 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShqDV8pL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF414D457;
	Thu, 25 Apr 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063168; cv=none; b=UA+c9CYVFtOAuzvlCqHnSp54JJ/rBdIK9IhsnvWHFOvZsDj8JYqzsGALCdbQFaQth099tz12FjWXLFGwxJBJHi9ZoQM62vGuBkI4h77Rj/n4uJq8XtX+IQs6Lud2vv59KIgd1Jmio7HLRn8dOXW2MwJCA9V1/3gy1kZ6v8QcF/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063168; c=relaxed/simple;
	bh=3xGzcdlOOjdjNul1Y7kXaLAiPLmVyjUyTRl4QVGvt94=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ULLLCHJXwxJBJF6WNknNM7ZUW6vuv7PoO1/FaZZdOdbwpDJzrjGL7ZhuBC088RASaPXgtbyTyDgUVAe4FYcb0W46RxMjsgNXeRtNNsMx/4Tt5INgzW0eUqDhjwieEmvqOYz8/zbfqBD65421/8P9RSQeoUtvFm4/0yWQ+HawiKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShqDV8pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D047C2BD11;
	Thu, 25 Apr 2024 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714063168;
	bh=3xGzcdlOOjdjNul1Y7kXaLAiPLmVyjUyTRl4QVGvt94=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ShqDV8pLQNpLbPbrF2xrUl+GNjtSdxJi1/NbKq8Ei6E4VayNxiwhNtKt7XH2cKITU
	 UDRRl99kqop9BtCUg4mYEiocrn3bB8zePYULA8CRI3ATaUORe342RyPiD3k/vqUTDL
	 CEx8qWeK6t/P4w1LQ6A9yoRrZZ3b6HJFlCw5SXsatuj+s6LJSktX+X4+NoIcDUwlE2
	 lOIjDTxaqs8Na8Smxhp3T0oZ2aev0PhlU7AnVhf/wxxQRkfCQTnBFHvANt+osbhUil
	 6lALrtFG4kX5yOeYfWXcekPoRUo8f51FqDgW6RLYenmf881uMzQjHeDq6pe611CoiM
	 ftm2fo5e1YnFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D58AC595C5;
	Thu, 25 Apr 2024 16:39:28 +0000 (UTC)
Subject: Re: [GIT PULL] 5th round of fixes for nfsd-6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zipmj7eGXGHMMDC5@tissot.1015granger.net>
References: <Zipmj7eGXGHMMDC5@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zipmj7eGXGHMMDC5@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-5
X-PR-Tracked-Commit-Id: 8ddb7142c8ab37371c6fd167a8aded97922c6268
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e33c4963bf536900f917fb65a687724d5539bc21
Message-Id: <171406316817.18419.15158705947533998443.pr-tracker-bot@kernel.org>
Date: Thu, 25 Apr 2024 16:39:28 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Apr 2024 10:19:59 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e33c4963bf536900f917fb65a687724d5539bc21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

