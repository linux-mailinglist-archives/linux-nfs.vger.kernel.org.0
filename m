Return-Path: <linux-nfs+bounces-10996-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E674EA79950
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Apr 2025 02:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DCF1881BE9
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Apr 2025 00:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD874059;
	Thu,  3 Apr 2025 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFzUjY4v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C354A08;
	Thu,  3 Apr 2025 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743639068; cv=none; b=r/vbGzJx94Hc7jVysLOBeA9fYmnd+RZv+0H/quCl0jT58s43aKRUumFDbQgsqrmdcskiV/T3LRVbnvl3Nskua8iOt7eW3ajog1LW3yG/RooMbLoAY8LC38yJdtN1aCe8cC0qFfDMQZS1fpIZ6UcvZAswToXuOHZ/HyWsouXp/jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743639068; c=relaxed/simple;
	bh=+HT9+KAd9piSzsUXX7QSYvzysR58Th76SYPc07WzxRM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LxXeZdoX73+NEj5SMFhTh03Oe0wwtkO+NtlvrKdvRDCz3PZPnO9StMnBiTV018JjccgQwwpCLei04pMdGp0TvsZg1eqO3aLJFcohAiWU+Y3fhciGXbJVChAUwVccgfUCFeWHRE6V20VzhVbZFuxxxGGnrHbw45JXezrU99ZeF5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFzUjY4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0E2C4CEEA;
	Thu,  3 Apr 2025 00:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743639068;
	bh=+HT9+KAd9piSzsUXX7QSYvzysR58Th76SYPc07WzxRM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UFzUjY4v0BJA8gMEnNeZankS4uUlSkgEakGVfAQ7HYHKGDll+H3Yh5lUqL5Ph9Jmb
	 2PI8aWrKhhdZEaRZcVDevAvs1hKws1S4cDGQE77nX8o23BJ3emYHyDQvVcN4xy5VTz
	 KKh1eVTHJjKXlnKJiSdgtft6kjyGRALcJqTKXrl/XWuDDFAEZXH+y30K5qx5HSh3er
	 qr1yp7U6CV0G1dRSvlxw+vSQ3BN4lk6UfOuYOrXIFUX5azE3n2xP9yifdhMxAG9uTX
	 031muY47ebR9L6Li56oyoHEwjwYhSuzQB3jvCLSIuC5wGi5hGHjz6Da04f02sVqYJa
	 6Bby9npomXYyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD45380CEE3;
	Thu,  3 Apr 2025 00:11:46 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client changes for Linux 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <b58d64f4a25d80b38743c29ad40d6af0ba7419f6.camel@hammerspace.com>
References: <b58d64f4a25d80b38743c29ad40d6af0ba7419f6.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b58d64f4a25d80b38743c29ad40d6af0ba7419f6.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.15-1
X-PR-Tracked-Commit-Id: 8e5419d6542fdf2dca9a0acdef2b8255f0e4ba69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94d471a4f42862bf53dc3776bde4b4c9175acbd4
Message-Id: <174363910526.1725867.16691744273458153054.pr-tracker-bot@kernel.org>
Date: Thu, 03 Apr 2025 00:11:45 +0000
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 2 Apr 2025 22:25:39 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94d471a4f42862bf53dc3776bde4b4c9175acbd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

