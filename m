Return-Path: <linux-nfs+bounces-10633-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ABCA65FF4
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 22:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5256A1894BB6
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 21:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B22D1F5851;
	Mon, 17 Mar 2025 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvWrOsCB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046118A6B5;
	Mon, 17 Mar 2025 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245208; cv=none; b=G2FKvgCtXeQ6+KjTXPbFG0OgAAJiQQyPVHHh2LG6oUoQPkn+GpHbKPWwumHVMhzl2xBklFqm4eALA6u8qpYZiN4Pr/mTHbfWijZyGUZrEVLrdvQSHoSOVCgkZSbBXv/yi3l3ggCJTuXy1BUjtETlu9uOlXhNO5FUk97KHAOOCjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245208; c=relaxed/simple;
	bh=LZezTtfBxnU1U9NfWyM3dhrEClwTdALOaDfardOQj5A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o2r7RVwvp1XjbQ17G5vTUBlzYzFDG3TyyiQ/j/scDJ6ZI8Ob6sve7dH6ljR9N9B2GGqoTNeLOLbZ7xNThprTStAUxj9oyC2rhRP57zoylGMPCGlksBKQP0tN/fx0yaKtnERt6EdHXfJG1Wy/rJIylQIoYPA9vFd2wXlbjgDGGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvWrOsCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FE1C4CEE3;
	Mon, 17 Mar 2025 21:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742245207;
	bh=LZezTtfBxnU1U9NfWyM3dhrEClwTdALOaDfardOQj5A=;
	h=From:Subject:Date:To:Cc:From;
	b=FvWrOsCBkG2b5WR2fYek1NqWkkVZeh+rYJX6AeSmHWk2tmn7v/K7ndRKUKBUgiKhv
	 YC1SGFLoSjILCx7RTfq9ETrW7gy/rbq+SI9pTZXJgq1FOyTYPobw2DpYKGb6bCl0MQ
	 wQnINJIS8OQKFNfA+MXBvQkVt4Mk4VLuG+EJPW2dM5JOkUQX3jhal8cIj5xt9eFzYa
	 nuQzBjcU0Ddp4j+oQuMPgVaapUUdh/yU8dJH4Sx3c71HsNF9rnViEczZ4ux/Er50ju
	 73YOoGDvmZ05WwNlNjUfznC039L+7Ns5sDBHGCk/E/53t/5wl0YnD7RYQl4abzP4vR
	 NVIziORlPmI0g==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH RFC 0/9] nfs/sunrpc: stop holding netns references in
 client-side NFS and RPC objects
Date: Mon, 17 Mar 2025 16:59:52 -0400
Message-Id: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEiN2GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0Nz3aKCZN3ijNKSlPzyPF1DU0PLxMTkFMOUJGMloJaCotS0zAqwcdF
 KQW7OSrG1tQDviDdvYwAAAA==
X-Change-ID: 20250317-rpc-shutdown-1519aacd1db3
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, 
 Benjamin Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3362; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LZezTtfBxnU1U9NfWyM3dhrEClwTdALOaDfardOQj5A=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn2I1UV12EFnRz5ZoqCJ5wmQaOhCJwRqarq0CBX
 wL5904V+raJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ9iNVAAKCRAADmhBGVaC
 Fb24D/4/Rd/JgmewcD9iQ9XGk04mlfYwMRmp6jXhl5sIQxFvOAnNpvPXNFv5GLtLFYMJZ4ffxo5
 FxJHCtrRLFOlETo4BW2uJsyLwvC696QF7txzvjnpaRg8MGKQ3oV6MLVVOtTa53cnMT1LuuI65vK
 b3hqHJulaiskG+QxDY/F+2y+mQ2mXdTW7ttUxXiDGsGOhmXhKPbqbMjHrDux+DHIvcTuMCjHhpk
 CJJmcJkxDmeI+Ot2H0VE6YPQyTgcM2sKtuDJgJOSccJg9RGXD72NI0kLGu3H1yT+tzopB+JfMnZ
 rq4ihVXj7XZlNf8FC1uH4O2++af45lsfrhCdpfH6hO7U4QPvt51ztomBfrn9VR2NssNoFnMCoZl
 fbvKtyQz11DK8CBMMVmZyFQkY2FWvWZ2DYS4E+vbsOXDZb4bq1Blnkhft3mkd7Ez14EJgLXRtkU
 mn+tf4jv+PgNOvpoypggM6o/Oc4/c1g0pacoXfd4B01syRklZg39omJ3lJJD1wIHujGUOTkQCA6
 FU/n4b4GBh28pIsbKXhMNnwrShtheHYo0EMf2e4qflBrxU7t+xIHcsQ5HL4pscVbh+GMCVSeaEQ
 2ZEazcsram4DKqhv+ZDSDt/ZVocLnf4ZOZF/hsQhWzCzFZNnxfjFjsDFY3RzknnTi/Sb0Qia4KL
 fcBuMNJbZh9h+bA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We have a long-standing problem with containers that have NFS mounts in
them. Best practice is to unmount gracefully, of course, but sometimes
containers just spontaneously die (e.g. SIGSEGV in the init task in the
container). When that happens the orchestrator will see that all of the
tasks are dead, and will detach the mount namespace and kill off the
network connection.

If there are RPCs in flight at the time, the rpc_clnt will try to
retransmit them indefinitely, but there is no hope of them ever
contacting the server since nothing in userland can reach the netns
at that point to fix anything.

This patchset takes the approach of changing various nfs client and
sunrpc objects to not hold a netns reference. Instead, when a nfs_net or
sunrpc_net is exiting, all nfs_server, nfs_client and rpc_clnt objects
associated with it are shut down, and the pre_exit functions block
until they are gone.

With this approach, when the last userland task in the container exits,
the NFS and RPC clients get cleaned up automatically. As a bonus, this
fixes another bug with the gssproxy RPC client that causes net namespace
leaks in any container where it runs (details in the patch
descriptions).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (9):
      sunrpc: transplant shutdown_client() to sunrpc module
      lockd: add a helper to shut down rpc_clnt in nlm_host
      lockd: don't #include debug.h from lockd.h
      nfs: transplant nfs_server shutdown into a helper function
      nfs: don't hold a reference to struct net in struct nfs_client
      auth_gss: shut down gssproxy rpc_clnt in net pre_exit
      auth_gss: don't hold a net reference in gss_auth
      sunrpc: don't hold a struct net reference in rpc_xprt
      sunrpc: don't upgrade passive net reference in xs_create_sock

 fs/lockd/clnt4xdr.c                |  1 +
 fs/lockd/clntlock.c                |  1 +
 fs/lockd/clntproc.c                |  1 +
 fs/lockd/clntxdr.c                 |  1 +
 fs/lockd/host.c                    |  8 ++++++++
 fs/lockd/mon.c                     |  1 +
 fs/lockd/svc.c                     |  1 +
 fs/lockd/svc4proc.c                |  1 +
 fs/lockd/svclock.c                 |  1 +
 fs/lockd/svcproc.c                 |  1 +
 fs/lockd/svcsubs.c                 |  1 +
 fs/nfs/client.c                    |  6 ++++--
 fs/nfs/inode.c                     | 28 ++++++++++++++++++++++++++++
 fs/nfs/internal.h                  |  1 +
 fs/nfs/super.c                     | 18 ++++++++++++++++++
 fs/nfs/sysfs.c                     | 27 ++-------------------------
 include/linux/lockd/lockd.h        |  2 +-
 include/linux/sunrpc/sched.h       |  1 +
 include/linux/sunrpc/svcauth_gss.h |  1 +
 include/linux/sunrpc/xprt.h        |  1 -
 net/sunrpc/auth_gss/auth_gss.c     | 15 ++++++++-------
 net/sunrpc/auth_gss/svcauth_gss.c  |  7 ++++++-
 net/sunrpc/clnt.c                  | 14 ++++++++++++++
 net/sunrpc/sunrpc_syms.c           | 29 +++++++++++++++++++++++++++++
 net/sunrpc/xprt.c                  |  3 +--
 net/sunrpc/xprtsock.c              |  3 ---
 26 files changed, 132 insertions(+), 42 deletions(-)
---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250317-rpc-shutdown-1519aacd1db3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


