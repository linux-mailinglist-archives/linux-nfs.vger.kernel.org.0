Return-Path: <linux-nfs+bounces-9499-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A239A19A59
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 22:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276053AC959
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 21:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2A51C5D74;
	Wed, 22 Jan 2025 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEKd1nt7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652401C5D4A
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737581093; cv=none; b=jsJfAOL71giuvx039w1mr4K68TJto4Ye/GjYZ7nXbE2xC4eCAUlibebPWTLIhDm2NX2bXJ+ncduWfe0vRjtQ+JZSDgt4dTIu5XFHMKEH4dH9PQNOJxg9bjpmqgSZ2ivkUyaaZVLCNQ41TVUGWAKcFCI1tUBWMeCyzNxnj51K1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737581093; c=relaxed/simple;
	bh=HYbsO2envuXyw+CuB7JAqeme1LdepIzj47DaxjvKOIg=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=XKOmTIHrqGQzmBj+uUPBFU6LZgMw3Zi7FrnAOt04M8RHRZTFiUQH4XdLkwN2sZceWRLIQW4feSJoasjMir04y361QhsSZ8VIME9qbiPXdvsMK7HRthQMWdks+1i4AToGtbQhgcSoAg/oXhwYS7sAN2rQwG38Rlm2GwNdDtHubm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEKd1nt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F913C4CED2;
	Wed, 22 Jan 2025 21:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737581093;
	bh=HYbsO2envuXyw+CuB7JAqeme1LdepIzj47DaxjvKOIg=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=DEKd1nt7VEgJaa9Dvsu/KA/RkspDiK9uSLJFb21Nf0YlNEIL6CcuzOb8AQ2IxWYp6
	 h9ipo3U+GYFKPxE6KGnalJp2fFfVjF1Wzr6C5okuS+JRSCIT7zLDqYVJKag0b30bLp
	 tHo5k8BXfr76k8mBtlIl2hP3ztRRVc/HsqOu0bnTjnfNdTwzrrftT8xC3E96fKzpE+
	 R5qYWCwYVYh0Op1FwlOtdtNmCUXgooDMPyWBwZw8SM3LfOHZoY6y4Ce75YMi1feyQT
	 d6I1ti1foeCOgKXXPl0hgJYrFzUV5w3ZV9nMhTs2VSGlHQYSJmcEnZJkmvtZym6OHE
	 BfHzuZQCK2mEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB166380AA62;
	Wed, 22 Jan 2025 21:25:18 +0000 (UTC)
From: JJ Jordan via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 21:25:29 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, tom@talpey.com, anna@kernel.org, 
 harald.dunkel@aixigo.com, herzog@phys.ethz.ch, jlayton@kernel.org, 
 carnil@debian.org, cel@kernel.org, linux-nfs@vger.kernel.org, 
 chuck.lever@oracle.com, benoit.gschwind@minesparis.psl.eu, 
 baptiste.pellegrin@ac-grenoble.fr
Message-ID: <20250122-b219710c15-630bda75684c@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

JJ Jordan added an attachment on Kernel.org Bugzilla:

Created attachment 307527
Logs and traces from Jan-18 pt1

Logs and traces from Jan-18 pt1

Here are the traces from two NFS crashes that occurred this past weekend.
Both occurred in the AM (US time) on Jan 18, a few hours apart from one
another.

I followed the instructions I found on the various threads.
There was no output to `rpcdebug -m rpc -c`, not sure what I did wrong
there. The syslog ought to contain the output of sysrq-trigger, however.

The output from trace-cmd captures several days' worth of logs in either
case, but not from system boot.

The syslogs I have cut from ~one hour before the incident until it finished
shutting down prior to reboot. I have removed the output of other services.

Both are VMs on GCE running the 6.1.119 kernel from Debian bookworm (6.1.0-28)
~60Gi memory, 16 CPUs.

File: nfs-traces-250118-pt1.tar.bz2 (application/octet-stream)
Size: 4.61 MiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307527
---
Logs and traces from Jan-18 pt1

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


