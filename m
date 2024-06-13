Return-Path: <linux-nfs+bounces-3788-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2788907C9C
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 21:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC501F22435
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A909114D443;
	Thu, 13 Jun 2024 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mopnGdWw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A314C583;
	Thu, 13 Jun 2024 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307005; cv=none; b=WoWwA03jcDYqGBnuE2cwDEB6TC69Vv/JIVI9yyCfshTRVlAjHPnBZohDe0uDEpqkeGjgVlMjNcJTNHBogDO20R0CsITuq9/u1WtKIlDPiVdBIMCemdmzn7PHZ/IRQioMw9K0G3n1kgd69lHNbJyp1bT0CAVpJjzoMz0u/feibDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307005; c=relaxed/simple;
	bh=H4pUPg0+NJTwztZ/4pGH8ultMe4u2BJ54vMJwTkEszI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PEmC5MPY4rdUJIROfCEbW6aQlG98SkZN/Fp0/DwCSopnUAPd4YO+bGVhZezJJO09ZWE2jYXpXwDF+Sbu/u+oc+s3P69byYHs2Uz9hJl8CiuV2lLGCWkmE5L5dLV7x1DYbAOpW5fuTg//AlAsXbV9jrDEHqGuIUm/+30kB9mm2ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mopnGdWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6307FC3277B;
	Thu, 13 Jun 2024 19:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718307005;
	bh=H4pUPg0+NJTwztZ/4pGH8ultMe4u2BJ54vMJwTkEszI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mopnGdWwqFfGs15LjQZ1mCy9CKUsr9GO1C7GNQN2bS+A0jKkZ71n6+26d7x+xmHnq
	 2oLqADnrmc+CsKWuA2Dacouc8R53juBZqsi1b1N4RpTHtmsMU3E7frYmLqpOIhx2I3
	 Hy6rPj4MzFT1R96pLOl88CE47u7jgN62Buq1Fyx7lXBwfzyFzqYHxKKdon8aYQBxjs
	 AkGVsZyO2e/D3cu9Jf7EYIkFPyoDAD2ieJQYvqN9uoo9HCnJXdnoO0DLGcxTbIU7O7
	 r9zxWfbpHbekCd5kTpcbXaWKwPCWDe5tBpSMnMbztfGEUQptmzgKLPT9qV4hsVwuVY
	 54I8zdyRQw0EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5104EC43616;
	Thu, 13 Jun 2024 19:30:05 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client bugfixes for Linux 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <789b8f5da4f8a0406fd977f2e067237c51947b45.camel@hammerspace.com>
References: <789b8f5da4f8a0406fd977f2e067237c51947b45.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <789b8f5da4f8a0406fd977f2e067237c51947b45.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.10-2
X-PR-Tracked-Commit-Id: 99bc9f2eb3f79a2b4296d9bf43153e1d10ca50d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd88e181d80579afbc56b9d69ef884c81abc2df0
Message-Id: <171830700532.20849.14644549098140161931.pr-tracker-bot@kernel.org>
Date: Thu, 13 Jun 2024 19:30:05 +0000
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Jun 2024 15:31:08 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd88e181d80579afbc56b9d69ef884c81abc2df0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

