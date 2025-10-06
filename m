Return-Path: <linux-nfs+bounces-15003-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B24BBF879
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 23:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BACA54F254D
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 21:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC0A258EC1;
	Mon,  6 Oct 2025 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2lb5/TM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C5422689C;
	Mon,  6 Oct 2025 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759784451; cv=none; b=QYt37fDnMYc5mlKiRm1kgOF/oK74ByQ8pNDIltmWBXNqnC46iDthWthzkp/RfZnkHhkuII6Pdk52MSiukioNDry57sOuRKiOH99iyr+wftAT9QtCNqzexoXH6RGFELZq7+wfnRJEMFNgNjmEeEbOTGLd3HgJMwXJKxwfY8YKvT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759784451; c=relaxed/simple;
	bh=K82V9VwxUb8xpskyAddYjyY6WLyCeBy1mGRcXZ5Lz/U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Vf4BVaHvkMLVDy/WaNIzdIu9ll5IOwOT+aJvpvWyqfpUgwT+OOOAXTF0A88tWsVM/Q9+TK/x6jGUC2pRhXpBEP+lvHIK8GVkqGfwSNeGrVhZM6N6YKASWUy0hwRvQZZqeHohFb5Hxi6L2BETWGeDO6b0s3+2mUS+9I8/sC55g18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2lb5/TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574AFC4CEF5;
	Mon,  6 Oct 2025 21:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759784451;
	bh=K82V9VwxUb8xpskyAddYjyY6WLyCeBy1mGRcXZ5Lz/U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s2lb5/TMxF3CxJu5hiLZjXdjXureRPmxN8WgjzkKo8sD9ZYSWvOHUxTlAmBm8ILWO
	 dVy+e+YcTxg1xdCSMio9Go5cBgGjEpyphPRpWYHYIZysGqvHFPRLZPfRG2IBg099Fq
	 LU0S1+5cClh+iA6wYTnXKYafjGUp3f1+f6+SQyI9ArMC+Pdu34Ha0IUcDC5Ets3jy6
	 qRj41JSb2GFcq5CiImFHrd+kORxMnc2JaGEULr+luMK3SzwMSNvSybbLTO2k12frEv
	 FOPFwWshpbHghLRcYf4vdneDe6So30He/G+MIS1nr74Wua5H6ktnVTw4x/1tBQbPCm
	 046qISdcCu1Jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34A8939D0C1B;
	Mon,  6 Oct 2025 21:00:42 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251006135010.2165-1-cel@kernel.org>
References: <20251006135010.2165-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251006135010.2165-1-cel@kernel.org>
X-PR-Tracked-Remote: https://lore.kernel.org/lkml/aN5dMYUPfFly6eUO@sirena.org.uk/ or
X-PR-Tracked-Commit-Id: 73cc6ec1a89a6c443a77b9b93ddcea63b7cea223
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81538c8e42806eed71ce125723877a7c2307370c
Message-Id: <175978444086.1594692.7026710454851240580.pr-tracker-bot@kernel.org>
Date: Mon, 06 Oct 2025 21:00:40 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  6 Oct 2025 09:50:10 -0400:

> https://lore.kernel.org/lkml/aN5dMYUPfFly6eUO@sirena.org.uk/ or

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81538c8e42806eed71ce125723877a7c2307370c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

