Return-Path: <linux-nfs+bounces-13571-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1585DB21BEE
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 06:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29306463374
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 04:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11952DE71B;
	Tue, 12 Aug 2025 04:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnBbs4j0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5D2DBF5E;
	Tue, 12 Aug 2025 04:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754971206; cv=none; b=SGUmjn6Mr6EHVp8uB7BzaDAP6/1hY45nFL9aq0vqPs2vzFDq7Q+rqSnS3J2VhJuqaYi84ptL1n1geX2+N+5avL/n6G6U1K+3FEPklk+sJSLHd9ifDLv/SrlVxJgqcmFTnEAnm+GGGW+JpxoP9Fkq4DMMG3+RRWgb5427sRGP8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754971206; c=relaxed/simple;
	bh=tVMpQA3Pb01QeGzUsPCVZM8O7RZG8jTWxBlUK09feW4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gsNlUxNiCV7bgnKuE1y1fdYDvPooSSD4dD9EK4BobBq1N8fd9wbs0v5O3eL6WVpF5UwEEi1U/8IAeMww7ffPVnLdDuKe+kt/st2YW3fm07LkKLUPyMCq9MvCNJfz34pMuybORSyOasupHE7BiCeVNnxqTMQcW3PizhRQq05UYw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnBbs4j0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918AAC4CEF0;
	Tue, 12 Aug 2025 04:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754971206;
	bh=tVMpQA3Pb01QeGzUsPCVZM8O7RZG8jTWxBlUK09feW4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gnBbs4j0Jr1Yklvgg1hv//y+BGwkrp+sWiNLs3/I7IKmOMvpUbENBvX3Id78DLlSG
	 YTQVaX5guv3fGkP7Vx9Yh9TK2cAKc2Ar9Rem1h8epq+31Yr+1MHt969dMzugEMttfO
	 qphliIYvosfqi0b9k5gdoYy1PnG5wzVs+mcdncxLtLO0P8XNwY3r7yE9KZ/aVwZYqy
	 7iDVigBzrkrnXAmVygKlDvuUModTM20kiXh33q4n8r+3yXJQIQpvb22fVKxjRbd76a
	 Co9OB6MajAiZzhdO+BnqXvUSR2JEb4fwGkFdAWI9CmHrHJxeuOTOxOonV2Yv0XRNUX
	 JIBDNX5XkLNsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF36383BF51;
	Tue, 12 Aug 2025 04:00:19 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD fixes for v6.17-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250811141324.6094-1-cel@kernel.org>
References: <20250811141324.6094-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250811141324.6094-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.17-1
X-PR-Tracked-Commit-Id: bee47cb026e762841f3faece47b51f985e215edb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53e760d8949895390e256e723e7ee46618310361
Message-Id: <175497121848.2002100.9807818115226083490.pr-tracker-bot@kernel.org>
Date: Tue, 12 Aug 2025 04:00:18 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Aug 2025 10:13:24 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53e760d8949895390e256e723e7ee46618310361

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

