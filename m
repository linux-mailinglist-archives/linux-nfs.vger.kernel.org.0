Return-Path: <linux-nfs+bounces-10309-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684D9A41E5D
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 13:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277D63B1E14
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 12:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF4B2505C2;
	Mon, 24 Feb 2025 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqb3HxGi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E622192EB
	for <linux-nfs@vger.kernel.org>; Mon, 24 Feb 2025 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398076; cv=none; b=IDgRS4l/hcGVxdMVq++LuEw6j9RLpmXO7RKqWf0jFk8TAlFf5l2BRKQw74/GSXQUqUpj2WoInCcTx9J75NkNtFbiRzq/OvI8oZNyokSjqAdDPZETxNdCTWomAgC3w+ntSh5hurqrILss2pzoRx9BDK2LbQi4lFh5XThwj//1TA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398076; c=relaxed/simple;
	bh=J4Sv/KH/L20ZPnO+0fObyYjA5D+k5ITp7gBSOjVLaKQ=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=FcVUcnpD9jDNHu4W7DlquXf2cwbmU+PUfac/IWvBXHNy0IWBQxBLj9bLxmXHTmdaapW+YcWWPeINLtpcyJiv0DZFibEBerICjD/dqyCyM50AeLYGgRMBg/sG/mmSIopNiz/RRBu3je/q3/9igO1ko3Mxn+yc7jyCE06z9dZ6OHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqb3HxGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD478C4CED6;
	Mon, 24 Feb 2025 11:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398075;
	bh=J4Sv/KH/L20ZPnO+0fObyYjA5D+k5ITp7gBSOjVLaKQ=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=cqb3HxGirZBl19IqJXnVfyVUM/BMCXOPJQ5wY+3RVgLIw5hwLnrqJ0uPQS7u6zUlo
	 UO7mODmeOvf/XSGSKSuJbnJzYr1hSKH4cdL6I5mLMIaZf9CV4lddknVRG8AYdbaOtn
	 j0rj8NCWcf6VwberbfI26e+URwPBhu93LsMvBKUepn+1pwvtr6n7cO8/xg0ar4HCiJ
	 NRpteiFKWpE04o9Jf0xt+cu4cdRssiuqNC0vHYEIlSzUI4WSXVgA9ULmXeb6hpYQMB
	 F2jbtmJQ7sVEnr9b5vFxU0DcoXj64nhopLjNL51/T8Ur74ab4+17VmQ7ogOXe7mHmr
	 Lk65iOc0E6tSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4D04F380CEF3;
	Mon, 24 Feb 2025 11:55:08 +0000 (UTC)
From: "rik.theys via Bugspray Bot" <bugbot@kernel.org>
Date: Mon, 24 Feb 2025 11:55:16 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, aglo@umich.edu, jlayton@kernel.org, trondmy@kernel.org, 
 linux-nfs@vger.kernel.org, cel@kernel.org
Message-ID: <20250224-b219737c12-c39f21164cea@bugzilla.kernel.org>
In-Reply-To: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org>
References: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org>
Subject: Re: warning in nfsd4_cb_done
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

rik.theys writes via Kernel.org Bugzilla:

Hi,

We're currently running 6.12.13 with the following 4 patches on top:

1. 1b3e26a5ccbfc2f85bda1930cc278e313165e353: NFSD: fix decoding in nfs4_xdr_dec_cb_getattr

This patch went into 6.13-rc7, but I don't think it was CC'ed to stable?
I also don't see it in nfsd-6.12.y branch on https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log
Is it not needed on 6.12?

2. cedfbb92cf97a6bff3d25633001d9c44442ee854: NFSD: fix hang in nfsd4_shutdown_callback

This one is now in 6.12.16

3. 99e98a2312c8d08fba60d548009c03e7cfb1bf6b: NFSD: Skip sending CB_RECALL_ANY when the backchannel isn't up

This one seems to have a CC: stable but I assume it's not yet there as it isn't included in the mainline kernel yet? Is it expected to be merged into 6.14-rcX, or will it have to wait for 6.15?

4. 4990d098433db18c854e75fb0f90d941eb7d479e: NFSD: Fix CB_GETATTR status fix

This one seems to be in 6.14-rc, but also doesn't have a CC: stable? It fixes 1b3e26a5ccbfc2f85bda1930cc278e313165e353 above.


Are there any plans to include these patches in the 6.12.y kernel?

Some of the patches mentioned above are in the nfsd-{fixes,testing,next} branches on https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git, but I don't know what all of these branches are used for. Is the nfsd-next branch what's expected to land in the next upstream kernel (6.15-rc1), or also the current rc kernels (6.14-rcX)?

What is the difference between the nfsd-testing and nfsd-fixes branch?


This kernel seems to be running stable for now, but it's too soon to conclude it fixes the issue that sometimes comes up. It does show the following kernel message sometimes:

rpc-srv/tcp: nfsd: sent 106256 when sending 131204 bytes - shutting down socket

I don't recall seeing this message with previous (6.11 and earlier) kernels. Does this message mean a single connection to a client was shut down? Is this a message we can ignore?

Regards,
Rik

View: https://bugzilla.kernel.org/show_bug.cgi?id=219737#c12
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


