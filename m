Return-Path: <linux-nfs+bounces-1822-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37EC84D0ED
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 19:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D251C24F05
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 18:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C552F12BF16;
	Wed,  7 Feb 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5GcXBiJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE812BF09;
	Wed,  7 Feb 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329335; cv=none; b=XHoxsbOfXMwuEQ1xs8Q3WuCFminIIWWsZVvU9X4hvA780g3mhDQNn8ytR9tM5f8eM33SYXY50CVWNpZ/fBguAXaiSY1je8yLC7xFO+w47XQ86NWXp6CXCs2NyufJ/m+EQ6LDY7K3lOrfYK4qxVNA+mDWY4pxtB2HP/sKsCruznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329335; c=relaxed/simple;
	bh=SRSTjQU25Si5Mc82OIFI1VgoL9ylA6hpOqje8jabBRA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ONsEtNwPJmLFu/UstqEuldg/fV3FioWSD8fssXWrLTId9qnU52hyWZ3/0URCcnVlLxXNOOsKygozIahN4Ph12VnhCSgwZprYwp0XhsoRGz1CIdm5QiAL1loiJZG/jqmZJ5tex9yTskJdgqW0iBcSy3DAavmB9C8JnKvUFrTpVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5GcXBiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AF84C43390;
	Wed,  7 Feb 2024 18:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707329335;
	bh=SRSTjQU25Si5Mc82OIFI1VgoL9ylA6hpOqje8jabBRA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y5GcXBiJ0YFK3yBfjRwcTTn/4ZkpV4iK3gh9KNNkw84g2ibTY8hgW22diNpGrKVm3
	 WKv2HWnFJZu/l2ejFjWPBLZ8NIgY1spSTlboCcRqW1WPV5NaaRhGvwkCLe6BoCjCH7
	 NxBB2WnB4rv9Zk9RPz+awJURK8RzPNFEH3cnnz1EuIxtFOQ06XsmtpRd/qz+d4/286
	 q7xNpn0EM9p1zD8Kb1usPxtaOlZV65O1GUcu9kkF+F5Fp6kKsyzlsUisDAhYtocqWw
	 kEegJ7t+kTiRuFR+TU9Xq8aU6DWZciC7GpQuDP9bwyYoJheBOgTjOnSZBmGm1nRk0p
	 DH6Q4+DAj7sRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FD64E2F2F1;
	Wed,  7 Feb 2024 18:08:55 +0000 (UTC)
Subject: Re: [GIT PULL] another NFSD fix for 6.8-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <EE8DFAAF-C9CF-4D82-B946-739F2D1AA390@oracle.com>
References: <EE8DFAAF-C9CF-4D82-B946-739F2D1AA390@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <EE8DFAAF-C9CF-4D82-B946-739F2D1AA390@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.8-3
X-PR-Tracked-Commit-Id: 5ea9a7c5fe4149f165f0e3b624fe08df02b6c301
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8d80f83de47fd183a0eef2d6b1085d4fdecea37
Message-Id: <170732933525.14404.8579635684203844209.pr-tracker-bot@kernel.org>
Date: Wed, 07 Feb 2024 18:08:55 +0000
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 7 Feb 2024 14:21:04 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.8-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8d80f83de47fd183a0eef2d6b1085d4fdecea37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

