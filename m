Return-Path: <linux-nfs+bounces-9712-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C93A2031A
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 02:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D3A1887FBD
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 01:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2023151C4A;
	Tue, 28 Jan 2025 01:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMWfKwAB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB81D1F5FA;
	Tue, 28 Jan 2025 01:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738029379; cv=none; b=hTL/BzkQgyFOF8FMQTwZ9azmrRBqh6rfQXfoyiTIkCvS/3qQ0LF8B3mCnWi50P1bZrUZrsGK/HAlVyfCzIH1hnqbLKuLVLl8nKldZ2FRdTZDS000ZvYc7enPEHCmZDt86yNXOZlD/W1kq57RHEqaa+6O/EabC1x0XU02syzkzr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738029379; c=relaxed/simple;
	bh=KobeCKGsuS3nf1OXeHYhkl4A9QGhsAcX5Vy+rYb6pIU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GypuH/eI2ZnhOF1fMtaPCR6N/OUOJqHTWRG3sZZLvu8rfsxASh855VodyOiEl7SRGDbYZuKKpfm0yldIxte5srEsQi4mMK/mj0p786bt23LGUoyEIGg+JDSBhLIP8LAT6Ho4Sy+r7w8JGiLTIzencOAWI+wdp2tpDZp9nDEsQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMWfKwAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA954C4CED2;
	Tue, 28 Jan 2025 01:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738029378;
	bh=KobeCKGsuS3nf1OXeHYhkl4A9QGhsAcX5Vy+rYb6pIU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MMWfKwABKSxplyH2gSuCk35JNh6rNhfoman60vnv6n3bnqLOnw+eZ+8yOVcabWMON
	 3qe5v1Cct749iWUlmWzVQvDShZhwtf24XMDwVvUZtMn64zYuOajHkzu9f2hKnQDW7I
	 TzbXSfBVZbRJSwmuVEixXg5KkNmVivlQzdSvWT9HhKna9mJgT6KwsSbJNEvAIRwsMp
	 GRls3FjsER6T4h7Pjvix9BvYaHYRb0e62ikn4eSZFAfU4CgRpLfehTq0W8WLQHiRL3
	 xTYtUbxqqKjmPZlb9y3p15ny/V6qKTJBy8+uXBPDYqvncNx+SxshTkE3BQ6oyIF8EY
	 bB39O6azPS0pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF02380AA63;
	Tue, 28 Jan 2025 01:56:45 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250127143907.5349-1-cel@kernel.org>
References: <20250127143907.5349-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250127143907.5349-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.14
X-PR-Tracked-Commit-Id: c92066e78600b058638785288274a1f1426fe268
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f34b580514c9816a317764e6b138ec66a4adab25
Message-Id: <173802940435.3293641.6471359663140543795.pr-tracker-bot@kernel.org>
Date: Tue, 28 Jan 2025 01:56:44 +0000
To: cel@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 27 Jan 2025 09:39:07 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f34b580514c9816a317764e6b138ec66a4adab25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

