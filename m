Return-Path: <linux-nfs+bounces-8530-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B42A9EEF3F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Dec 2024 17:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B4B294730
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Dec 2024 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296CD226894;
	Thu, 12 Dec 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dm2c+QWr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0514E2210FE
	for <linux-nfs@vger.kernel.org>; Thu, 12 Dec 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019192; cv=none; b=ca8pnllAlQ2H5qcwnvVB1x/M3BVD6XH689il0aV0x/lxnQd+T94fqxq67j/5DkpX/8ZAS6T43qbTCe0/PItDXDKloAONL4TcAOeofInJXun6SetP8U3Z2Ube57Un60+bC/OlYwIWyomhl2zKIa47aDmTEte8VBXrlOTwFl7Y6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019192; c=relaxed/simple;
	bh=A3qyFi8admPxPQQgLQPj9ksB0XjYV8aCCLnvGS3BdPE=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=fSFm3Q79ZvqD/1N+aIbZz/rXgUWG8pnoGQUGUg54N2yQqYMZuBW8EVIRcLMQKiptxQHyJAtpTKDRNU1YcZVkfPZrgrpkOK0VmYFfqdQNT8A3z5hJWTt7Bxl5rR+J82lRpWLwfqhp8sE7mnghHn+1AFI6sT0NZYuktrTdp26cxEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dm2c+QWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBBBC4CED4;
	Thu, 12 Dec 2024 15:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734019191;
	bh=A3qyFi8admPxPQQgLQPj9ksB0XjYV8aCCLnvGS3BdPE=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=dm2c+QWryBoxvMXBfagTlJ2/4at2WtQnxNV0NKRm4VsV9COI8XJzeN2KOJLLTokKk
	 HPv05boZ8ftU+kn7uB/VJQvWCV/r55eqYoK9e6b6uc0p472ozJsw74Xl4q4t7l8TjF
	 aWfyJqTmaCVQqZeRvRLhT6K+za116mipzY219OsWgRtMej8H5XcYda/eHrG2VD/Plr
	 0+a5kuN1vWleShaRSVyLHoQXgxZniWdOfTkWGCARh8cqFAKVAHwUWipgJ5qHViic/a
	 YtfZEzIScBFeqmC/+/JsA9Wvu4is9bOYnaTWMVELf4v5+yB6HnTSS1LVw43Fy7Bwc3
	 lhfVONRKWaaQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5BF7380A959;
	Thu, 12 Dec 2024 16:00:08 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 12 Dec 2024 16:00:17 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jlayton@kernel.org, linux-nfs@vger.kernel.org, trondmy@kernel.org, 
 cel@kernel.org, anna@kernel.org
Message-ID: <20241212-b219535c13-13490047f72c@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

From attachment 307290:

[29924.805968] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0-1,global_oom,task_memcg=/user.slice/user-0.slice/user@0.service/init.scope,task=(sd-pam),pid=4503,uid=0
[29924.805991] Out of memory: Killed process 4503 ((sd-pam)) total-vm:173972kB, anon-rss:0kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:96kB oom_score_adj:100
[29925.425864] nfsd invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
[29925.425872] CPU: 0 PID: 1874 Comm: nfsd Kdump: loaded Tainted: G            E      6.1.119-1.el9.elrepo.x86_64 #1
[29925.425875] Hardware name: Dell Inc. PowerEdge R740/0923K0, BIOS 2.22.2 09/12/2024
[29925.425877] Call Trace:
[29925.425880]  <TASK>
[29925.425885]  dump_stack_lvl+0x45/0x5e
[29925.425893]  dump_header+0x4a/0x213
[29925.425897]  oom_kill_process.cold+0xb/0x10
[29925.425901]  out_of_memory+0xed/0x2e0
[29925.425906]  __alloc_pages_slowpath.constprop.0+0x707/0x9d0
[29925.425916]  __alloc_pages+0x35d/0x370
[29925.425921]  __alloc_pages_bulk+0x3e5/0x680
[29925.425927]  svc_alloc_arg+0x81/0x1f0 [sunrpc]
[29925.425991]  svc_recv+0x1f/0x190 [sunrpc]
[29925.426043]  ? nfsd_inet6addr_event+0x110/0x110 [nfsd]
[29925.426080]  nfsd+0x87/0xc0 [nfsd]
[29925.426113]  kthread+0xe5/0x110
[29925.426118]  ? kthread_complete_and_exit+0x20/0x20
[29925.426122]  ret_from_fork+0x1f/0x30
[29925.426129]  </TASK>

NFSD is targeted by OOM killer because it frequently allocates up to 256 pages at a time to fill the send and receive buffers. It is not necessarily the source of a leak.

The bulk page allocator is on the slow path here, suggesting there weren't any free pages available on the lists it normally checks first. So it is doing one-at-a-time order-0 allocations, a sign that memory is short.

We see that Node 1 appears to be short on free memory, but the system has not pushed into swap at all. Kernel memory isn't swappable, so whatever is leaking is in the kernel proper.

The slab caches all look reasonably sized, so not likely a slab leak.

At this point we would want someone with some MM expertise to come in and help us nail down the leak.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219535#c13
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


