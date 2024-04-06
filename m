Return-Path: <linux-nfs+bounces-2693-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C26B89AC15
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 18:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0DB1C20AA2
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10153D962;
	Sat,  6 Apr 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg4LPtaS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D152137E;
	Sat,  6 Apr 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712421722; cv=none; b=XaJNxwYTrUO6cjcYedrVs6Oqxv/92iKnn2l5UpsbraGwFQEC3vbD3L/tC6jsuIYJ8ss92YdTBucWJlPfevtZSiUFFHHGt6MfA5K5lurNzLgBx36bAGy1jrulVCIIUtf0hgtzjVgz/bsan+WhIbBpnVN9e30Loq9YqMtw4rS/yuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712421722; c=relaxed/simple;
	bh=ttTKEBDEIKNl6Rji9qt5QDBkBZVSyncuFn9A8jAEd/s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Cw4IAgy3eOzg5AMlsjYKvpBunbF8CFsnhZxo8ErGC9A8sysBXPDHmX2BGvz/DY6rMifQ9pNo7QHAw+qCBr5rqGtRem9+0aU/iuGNu7cPN7lFRhw0y0/KjjaI3YpUFrrxTvyMXJEblg1h6qtRZHpOVN41ZgLmxr6uelIgvz8jUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg4LPtaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 855ABC433C7;
	Sat,  6 Apr 2024 16:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712421722;
	bh=ttTKEBDEIKNl6Rji9qt5QDBkBZVSyncuFn9A8jAEd/s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jg4LPtaSXIVG3RMECevcxDOWcWh98mdDI7a3k50FGxWbvE29dKdjv/lw/SyWTGx5J
	 +Ebw8KOvHfQTuLR8M7H84W9YSi4zfce7l3sMngIrOoo/008AabR3ZGqO5T14GtQif2
	 WssuX984Y48WJJIj9eu2qGoGdqMX84sg0nMPkCq07fhnvrMkuIMNAOxvoXYxjs5zHc
	 y+IydKaCtmpUi1E+UbEtY2UTV8eXFt9OTgShv+Z1Fcpnn9B133NU++55ZH0nkUqpEH
	 LIrhcZm73yEWzveYNUFOmwlMlE/RUjc39Fb20hExGIrbBuHFdFJgwuF/YcE+XXpnzd
	 VH9JJiDOO9rxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71422D8A103;
	Sat,  6 Apr 2024 16:42:02 +0000 (UTC)
Subject: Re: [GIT PULL] 2nd round of NFSD fixes for v6.9-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhF6O/tcbLJYjddw@tissot.1015granger.net>
References: <ZhF6O/tcbLJYjddw@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZhF6O/tcbLJYjddw@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-2
X-PR-Tracked-Commit-Id: 10396f4df8b75ff6ab0aa2cd74296565466f2c8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2f80ac809875855ac843f9e5e7480604b5cbff5
Message-Id: <171242172245.14146.1185090208878693476.pr-tracker-bot@kernel.org>
Date: Sat, 06 Apr 2024 16:42:02 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 6 Apr 2024 12:37:15 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2f80ac809875855ac843f9e5e7480604b5cbff5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

