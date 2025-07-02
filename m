Return-Path: <linux-nfs+bounces-12858-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D08AF5F71
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 19:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745891724E3
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B061B303DDB;
	Wed,  2 Jul 2025 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgQY9MZe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C690303DDA
	for <linux-nfs@vger.kernel.org>; Wed,  2 Jul 2025 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475993; cv=none; b=dY+n1q45jz6hT/9V5ZJYE+LLNC3EGoi5mLuXkeVWkkiMAKClHdPEP4LGFXClUoMiRic9rouKj9LNnf3RRmuwBDfPUNqnLNxxT4/rcn5CiAvIy1CJnJA+L32b6fCJ7OiPWtsTaIQ5prad85HqtXhS60lTFEjNfWHSjOaMZOVNdEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475993; c=relaxed/simple;
	bh=e+Qtv1pAkUqdGJXKQ9DKsFKI7AFVqusAuHF+n4hhhu4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lAaF/KLeqvhlXvavfp4OQM5wrBRJoeV5zjeJrQ9zmdhWKUBasTIXRuu0HBR8giq+r4bZSi7WdZr5JFMMr451iB3BnccOdFVvsOU3FLj60z/Px/YedQT7lFCP+4FsQnVRllMrPW6wWCBldPJcLt3bACC8KN0lIwR7PsvHQnQDasQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgQY9MZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C575C4CEE7;
	Wed,  2 Jul 2025 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751475993;
	bh=e+Qtv1pAkUqdGJXKQ9DKsFKI7AFVqusAuHF+n4hhhu4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tgQY9MZekpNpwwmL2+7nxdm3V6usdZ8iOcP0AHLin1Xw+GgrBMlwmCcs+9WJ9fx2r
	 fGAHp4bovUutYwHmsdNtUS8k7srkgOFb+IBYi6AAo9GTLiYYd71kAPBLsxZmDCjX2r
	 JStnPPieWbiGwsfzxkbxXVWP4/nCStBvmdeV4xoeNoCgJVUoeCBwJhqvRmtDKhOBnY
	 wntgWxmniBQtvv2x32U94j2v0IC6HXBVkC8JT44cgnJBEQoesx/OOXanB5PyZAEwDL
	 UldEad51C2VtDZmWGHnHwA9uyZhH0RBhyc1GDnMhCsg8AIDFOgQ3EREQpwpuV12UJm
	 NJM3rkPj83qRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C1C383B273;
	Wed,  2 Jul 2025 17:06:59 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull NFS Client Bugfixes for Linux 6.16-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250701203345.781391-1-anna@kernel.org>
References: <20250701203345.781391-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250701203345.781391-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.16-2
X-PR-Tracked-Commit-Id: 38074de35b015df5623f524d6f2b49a0cd395c40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce95858aeedfd7f942e91234b81841eec0260a82
Message-Id: <175147601790.796050.13303507789295685678.pr-tracker-bot@kernel.org>
Date: Wed, 02 Jul 2025 17:06:57 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  1 Jul 2025 16:33:45 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce95858aeedfd7f942e91234b81841eec0260a82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

