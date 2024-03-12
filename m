Return-Path: <linux-nfs+bounces-2278-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9216E879E74
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 23:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5DD2845CD
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 22:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0395114403C;
	Tue, 12 Mar 2024 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWKydBdN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4345144035;
	Tue, 12 Mar 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282244; cv=none; b=fsC+Hzh2azIV0WYF8TL9E0kMeTp+WInYdybjq4PA6LuoMTLIF63Od3uPzWK9Btgccs2DZLgu6cD35Z3ty4ePDuZnQzefyjPYkEB6PWICm1+9hAv6q9WkJN7F2zi1mjfetDfOgKqgaDXFSOdgeRzIMHW1HDHTqY/nHEP5FrtRppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282244; c=relaxed/simple;
	bh=ofqfLzVJ0ZtU3uN+KHSVIAdR9gUkSwiuAjGmqMKWSH8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NB5yTgQ50YjCfIKzdJLUo0eaLBDJ9wXTOuMJMNa2eKY8ZY+eWKa1AwIyzJfoelJ9rqaBqM2zLLRNq3xqHijJxBCtsdCpdikikmw0oZB+Ldzkgw91knQ68L3cglnfO7C3UOrb8Wxk3EVwhHZ5vqhf1nLrBnlMPMifRFSzqytVDZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWKydBdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A801DC433C7;
	Tue, 12 Mar 2024 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282244;
	bh=ofqfLzVJ0ZtU3uN+KHSVIAdR9gUkSwiuAjGmqMKWSH8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FWKydBdN+VLYE1c90pSHMdBBuNHDWCKKvc39TB0+f91BuJx5y5nhFFkKJD/zbIB7X
	 VsDGP2vhxDuYPr0hXUxjjCNPAXQJJgQpMIFLfmeRcpogJSNpxrK6yKPo3u+oqhcV27
	 3UAw2TVaJyOAbqrX93rYaDSrsSLC7h6uIZ3X0G0fvGEDV4NF1xNOM4GqeZsR6xcOai
	 MtNL00bkQjBIlWXnvmbJFplogB63p9fRHRO2Pxje78fnt92ZeO31v0OZXKi+GFRY2i
	 9jsAj5NA9GSeNTd6muXbWF55nxzXAqoyiJgC6EL3//a637Yr3mwDKDMSfmRHC7mON2
	 778/2csxGlqhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92603D95053;
	Tue, 12 Mar 2024 22:24:04 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfBZekuzxPL1zBVz@manet.1015granger.net>
References: <ZfBZekuzxPL1zBVz@manet.1015granger.net>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfBZekuzxPL1zBVz@manet.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9
X-PR-Tracked-Commit-Id: 9b350d3e349f2c4ba4e046001446d533471844a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a01c9fe32378636ae65bec8047b5de3fdb2ba5c8
Message-Id: <171028224459.16151.4186471773665004988.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:04 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 09:32:42 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a01c9fe32378636ae65bec8047b5de3fdb2ba5c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

