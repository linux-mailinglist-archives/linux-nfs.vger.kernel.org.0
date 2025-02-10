Return-Path: <linux-nfs+bounces-10005-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAE0A2EC23
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 13:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0611668F5
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 12:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742C91F8922;
	Mon, 10 Feb 2025 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBkB7wCf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A214B08C
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739189079; cv=none; b=ktZ5e6hO24SdjAHwmr0nOqlw6teyYAJvLaruyOwI7xCHKuP3miOQ1sUnPOQJ879ueY6LuxqlkkCQXKwVQSA3At3laKo/bnlBIjMAkyNnbgALmABxq6uyj6ZUbsajj7TJx98I9o3w8KpcQIWKG4+af6hkiUx4MoYoLgWI84+8xwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739189079; c=relaxed/simple;
	bh=GzOg3GfWe628Sdnsew53wv9Z3W4BWrHGEnp6X/XwnWU=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=qPTare1+PQ99DoMZKK0tpHUoKc1B2fQvU9fQdHHYiZl/caZGrfVgysfUkmiO5s5Yr7lDC7nk/fyK0FkuMFUiJ2NsOMstrN0nR8BGJh1wqs7r1nIJ9qjBhbCnQL8bxNcPZlcHOnWtk28OmqzwMsQPcoLedYNOBlwDMqsjEKAuH7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBkB7wCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B70C4CED1;
	Mon, 10 Feb 2025 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739189078;
	bh=GzOg3GfWe628Sdnsew53wv9Z3W4BWrHGEnp6X/XwnWU=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=nBkB7wCf6QH/DvnydvAPFGux5QjEkjO44U5Ne+QU1OoG1b1Rn9Qst9ahRDtEqLex2
	 QyqTGnTLQH/wn2OB2p8YBEkOyaspXnsCwtp/NV8d+0GoATayi/+I1oAKz4yfXhrpBj
	 JxFooFlzJm1n6df0QmWdiEUK1Ee6/jxoFOiwaotlEKip06ixV99K15X5/qj5+p8AqA
	 AuNz7woNjcm1jEO09YeO7I6MfMzExs8W95vA/2HeHNYDEpO8ovz9Yftql9uU0IOGR+
	 6wr42iCF/arRh/LIj0RcuWxD/JMM7kwZmwjGklpCFGntDV97dZZuk5quCNQKFOf3eP
	 DiXSk/OwcDq2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BF5A380AA66;
	Mon, 10 Feb 2025 12:05:08 +0000 (UTC)
From: Baptiste PELLEGRIN via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 10 Feb 2025 12:05:32 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, jlayton@kernel.org, cel@kernel.org, 
 herzog@phys.ethz.ch, tom@talpey.com, trondmy@kernel.org, 
 benoit.gschwind@minesparis.psl.eu, carnil@debian.org, 
 baptiste.pellegrin@ac-grenoble.fr, linux-nfs@vger.kernel.org, 
 harald.dunkel@aixigo.com, chuck.lever@oracle.com
Message-ID: <20250210-b219710c28-43a3ff2e1add@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Baptiste PELLEGRIN writes via Kernel.org Bugzilla:

Hello.

Good news for 6.1 kernels.

With these patches applied :

8626664c87ee NFSD: Replace dprintks in nfsd4_cb_sequence_done()
961b4b5e86bf NFSD: Reset cb_seq_status after NFS4ERR_DELAY

No hangs anymore for me since more than two weeks of server uptime. And previously the hangs occurred every weeks.

I just see some suspicious server load maybe caused by the send of RPC_RECALL_ANY to shutdown/suspended/courtesy clients.

I see a lot of work on the list that try to address these problems :

nfsd: eliminate special handling of NFS4ERR_SEQ_MISORDERED
nfsd: handle NFS4ERR_BADSLOT on CB_SEQUENCE better
nfsd: when CB_SEQUENCE gets ESERVERFAULT don't increment seq_nr
nfsd: only check RPC_SIGNALLED() when restarting rpc_task
nfsd: always release slot when requeueing callback
nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
nfsd: prepare nfsd4_cb_sequence_done() for error handling rework

NFSD: Skip sending CB_RECALL_ANY when the backchannel isn't up

NFSD: fix hang in nfsd4_shutdown_callback


Thanks a lot !

Baptiste.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c28
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


