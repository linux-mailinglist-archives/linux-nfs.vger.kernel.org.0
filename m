Return-Path: <linux-nfs+bounces-9397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BF0A16F62
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 16:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16533A8384
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 15:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF83A1E9B02;
	Mon, 20 Jan 2025 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6vvO+NT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADA11E98E3
	for <linux-nfs@vger.kernel.org>; Mon, 20 Jan 2025 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387584; cv=none; b=bGLBdymmhEaYJMIYGb68xpwggo99g4vj0jn52XcO+ZldACGWvseSM6xLvJw5yo3VS2zXxFcuWaTJ66qaNVnijZLc1FKESldk/SRcENFEvLF8S0Cpsz8fnJEYd6M0HCeOC4quNbOYxyTfOvXY5/ZjA5EjWmF7VwY5FPUWbBZDRTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387584; c=relaxed/simple;
	bh=AHJDPgdPm4ez1h4hLxY2xHIwOAZu2UtDoq6eAGqtrvE=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=R0+L9pxx0V8DE1qrejuCc3YgG7CIxsecKl/ueGvSUI9mDwAzE4KrkFcuKKyH5vyA0llxBSVEpR5Pbj5IReTAtFuFBxIILBYqCq4fSsKezcItlVJs3AuLv6tY9JyehJKP5UtXfpsO+/EbWLy5ganKwHq8SIQMgaXYbF9hzsMrerI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6vvO+NT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64320C4CEDD;
	Mon, 20 Jan 2025 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737387584;
	bh=AHJDPgdPm4ez1h4hLxY2xHIwOAZu2UtDoq6eAGqtrvE=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=Z6vvO+NTt5WxV+vbkWEHel1jWMUOXU2eEnbK68tF3LEEOs0rSpyjGRaYlWXVG9WY7
	 FgdW+uNNpeV1Wjd0bSqZ/Ld9dYVOHYKQWP1RDuScnxI6CjxSgeGxLkgwme54TSHhRS
	 TJfOlvtrXUwt7oJE5B80rPdiQ/bcBIIRr6hAw0U9+kanIur+LtFU8s8Mo1LflxAu+A
	 U/eGhqcMuOX9mfdza+x5isje3k7r6uZSBzwhMcluloDGdqRvNUYgN64VY6iig5VE18
	 qXgjmd0nEeNLkcLz5KZIt88ekUsLTwjrT3xeKlfu2ZfNvPUocz9bDe22kowfQkgrEv
	 rjR1WBMN3xf0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 76396380AA62;
	Mon, 20 Jan 2025 15:40:09 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 20 Jan 2025 15:40:07 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: chuck.lever@oracle.com, harald.dunkel@aixigo.com, anna@kernel.org, 
 carnil@debian.org, herzog@phys.ethz.ch, jlayton@kernel.org, 
 linux-nfs@vger.kernel.org, trondmy@kernel.org, 
 baptiste.pellegrin@ac-grenoble.fr, cel@kernel.org, 
 benoit.gschwind@minesparis.psl.eu
Message-ID: <20250120-b219710c3-639e348b9df3@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

v6.1 symptomology:

The following stack trace shows that the active callback workqueue item is stuck in rpc_shutdown_client() waiting for RPC operations to complete. Because the callback workqueue is single-threaded (max_active = 1) and this work item never completes, it prevents subsequent flush_workqueue() calls on the callback work queue from completing.

> [7257352.347503] task:kworker/u32:6   state:D stack:0     pid:173983 ppid:2  
>    flags:0x00004000
> [7257352.347511] Workqueue: nfsd4_callbacks nfsd4_run_cb_work [nfsd]
> [7257352.347568] Call Trace:
> [7257352.347571]  <TASK>
> [7257352.347577]  __schedule+0x34d/0x9e0
> [7257352.347589]  schedule+0x5a/0xd0
> [7257352.347597]  schedule_timeout+0x94/0x150
> [7257352.347606]  ? __bpf_trace_tick_stop+0x10/0x10
> [7257352.347616]  rpc_shutdown_client+0xf2/0x150 [sunrpc]
> [7257352.347683]  ? cpuusage_read+0x10/0x10
> [7257352.347694]  nfsd4_process_cb_update+0x4c/0x270 [nfsd]
> [7257352.347763]  nfsd4_run_cb_work+0x9f/0x150 [nfsd]
> [7257352.347812]  process_one_work+0x1c7/0x380
> [7257352.347824]  worker_thread+0x4d/0x380
> [7257352.347835]  ? rescuer_thread+0x3a0/0x3a0
> [7257352.347843]  kthread+0xda/0x100
> [7257352.347849]  ? kthread_complete_and_exit+0x20/0x20
> [7257352.347859]  ret_from_fork+0x22/0x30
> [7257352.347875]  </TASK>

Based on the full stack trace output, there do not appear to be any outstanding RPC operations.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c3
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


