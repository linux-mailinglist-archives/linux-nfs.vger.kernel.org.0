Return-Path: <linux-nfs+bounces-2918-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B5D8AD649
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 23:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4071C20F9A
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 21:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573581C69C;
	Mon, 22 Apr 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv9Or+yu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4DF1BC53;
	Mon, 22 Apr 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819968; cv=none; b=nFT+HNP8g54hE9QyxEGvV5mbvMR+nPQDc6DtIKUmymfcoKiIbNvI0xYXL0fst32nonfCQ2igzc5wDURBqj6hzGFaHmxOp3PR29BVd5ciqj0HcAxz443DbgQnMDaLflJOYF5j+efYEcE3aPLXxLxpmuuFb2t6Rse4VoWufOufQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819968; c=relaxed/simple;
	bh=MuCc+/c0lyK2rb34Ex+y6Ys7+/xQLpiIhkA1WL5xlCU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Uvx61n5t+8dAHE4w1ZywNy2dnddh6fTjvBs/CSR7zVXYw8q1jJ3GImj4lbgiSVeVpdb+7rxNVCNoiFJsG/dlCXcWrY3HIAP88hxoIsY1IR5fidP3DtoLRIDUTEOksOmAkoJ6H2soeiXnqpyL/5Ott+l+jaBY2Zx7zOAGYHEkXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv9Or+yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D8E8C113CC;
	Mon, 22 Apr 2024 21:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713819968;
	bh=MuCc+/c0lyK2rb34Ex+y6Ys7+/xQLpiIhkA1WL5xlCU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Rv9Or+yunwR/lMLzU/H8TPBlCJvHxK7/7ynTZMbJWdUAuucfncoHoCz3BCudM0JVF
	 yg34MWtjfrzIqlbLK6JTF+BN/cHdCbE0AbxOhrYOSlRhv/2ZATPCFJ2GrLS5VGWV81
	 jIV0aSqOqMvZ3LX+jmhLJAcmfGOIB51YHoNrgdggvrrOLgK5hzCjB8HYeYYD54VdDh
	 7hr4FBdT/eCmCRAUloqKOyiVunHZRVUG/a0rumK8vIuBhTPQ8aXOE2AtAAImvN3JsZ
	 gs4KH44XdZ9PhScS5gM0uz9e1QeZHgdCTL7Ooh03Pm9vD3x4lWn7Dg6AFqkZXIDeBM
	 SKDNe1WASBPlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0117C433A2;
	Mon, 22 Apr 2024 21:06:07 +0000 (UTC)
Subject: Re: [GIT PULL] 4th round of fixes for NFSD
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZiawMYH0M7pXJWau@tissot.1015granger.net>
References: <ZiawMYH0M7pXJWau@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZiawMYH0M7pXJWau@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-4
X-PR-Tracked-Commit-Id: 32cf5a4eda464d76d553ee3f1b06c4d33d796c52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c582ec1428a4016c60d3d43ddaab427cd09862d
Message-Id: <171381996797.20649.7838793970758635613.pr-tracker-bot@kernel.org>
Date: Mon, 22 Apr 2024 21:06:07 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Apr 2024 14:45:05 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c582ec1428a4016c60d3d43ddaab427cd09862d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

