Return-Path: <linux-nfs+bounces-17507-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C8CFAB6C
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 20:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3610D329BCB5
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 19:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9132308F1D;
	Tue,  6 Jan 2026 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3aoWdUN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F90F307494;
	Tue,  6 Jan 2026 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726006; cv=none; b=WDmZFHq5k2awgnIPr3+K7bAUUQ9P9j/Z+Wb1EKY3vkWB2TsfWB64sahKm4hW4uIImn5GI8pv64THciD18SotnorfSt6ouV7q7a9v60A6FEaDI1iYrjzIiccDirCPJCJ01PT0oreIBHaVZn9NT1nhH/n5m/rLLgQnKC1UpYv7tA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726006; c=relaxed/simple;
	bh=YYSOhkEyEYNamkhnpuW1P5bAfn5jV8rLxqgNSeB4haY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PKej3OBPAMLpQ1/RS5O9PZp6uDsHKeDmx/e0LRFMUO9JTGBTU6l77/inU9J9Tf2VZjX+F2bIo/Hs8azQps25pEDIn9qpdHq77IuIBpMxW45G5/SXfXqjCvUCw8w/vGkI8yiwGsv/y0jEvY4q5K/4m4LVSLW0m6fNI/v4LNpD6f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3aoWdUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F99C116C6;
	Tue,  6 Jan 2026 19:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767726006;
	bh=YYSOhkEyEYNamkhnpuW1P5bAfn5jV8rLxqgNSeB4haY=;
	h=From:Subject:Date:To:Cc:From;
	b=q3aoWdUNmHLL+ozyBuhXRVgB0tesfBh5RfDDtFvGcNujYFF6SJw4kVASAmPvFeJs3
	 nu9UytKQv57vFPMvZ7C6yLxQlhnJRJNTyKZrZ7L3xrkNMlm7AUD7BLz+RmQ5ZrGrbg
	 jRjgI0Xrru8I+x222kc7+nKqL0xLcernRtXTmjfesPOWmhVa8bmb730TfJNk03Lqkq
	 gsue/mL/FsEGx2DnZo09ABD2rsWKhjLrM5VnIIJRwK+Al+Zo3Ktd1Ch58MBEL9/Q/C
	 G/lpTKrnEE2rY+0T7ZDxkv1CSXPSgGGUWrINBjPso4Q6WxKrB44498fYAyVmBOvYbD
	 7J3gvQyNFs3gw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/8] nfsd, sunrpc: allow for a dynamically-sized
 threadpool
Date: Tue, 06 Jan 2026 13:59:42 -0500
Message-Id: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNwQrDIBAFfyXsuRY1FUlP/Y+Qg9U1Sospa5CG4
 L/XBnrqcQbevB0yUsQM124HwhJzXFIDeerABpNmZNE1BsmlElJIlnx2zG3JrIHQODZ4bXohtOR
 cQVu9CH18H8VxahxiXhfajoMivvbX6v9aRTDOHGqlUA32bi+3B1LC53mhGaZa6weiHmI+rwAAA
 A==
X-Change-ID: 20251212-nfsd-dynathread-9f7a31172005
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3220; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YYSOhkEyEYNamkhnpuW1P5bAfn5jV8rLxqgNSeB4haY=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGldW7KhFmio9G7ArgCyERHCdl+gSk+/5CtIdJhQ8vA7jFO9K
 IkCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJpXVuyAAoJEAAOaEEZVoIVNtoP/iO2
 fuHfdwFUXT8a2FdOKaDRkEDRkjeT+TllPLYwAcYz3HuuzLKfQrhcRcGPVGmPZi+lG7EH8uQ/Vou
 i3zaSwxtpNosszQu6a/g5kr8vode21EFGnMjpYroAFRBcmw/J6ZBIWZxfq8bKNn8HuyxwscIg0X
 skhRljAW6CuDJ9oLM2TmZTlxJ71QSMAJqCuynA+66w8i6Hxh1IZ0v8iUVMn94KSx6gNm4RwpJ9t
 ZXkp7hAj1VwDsWVs60XaMKG5qzQ7xwIWmF0oGnE6W4yCvHjwDjBkk8EbvJYFQjoq+OdOYmq7ARP
 o2FQeLtuzO7hAx2r++jsPOCFdVO1ESxxQEarhGevtjU9i6DMEBDd9sMJPkOSyvqxK490uTr3ijL
 5tK/RvkhZgEUY8MOQBtsdvr2abn6wmvWRt+xLeRbd7AbDs7ZClAbN4ZZ3D2jGHOfN4HRPZFBSnI
 +nxx2EK2F+2dfjr5gecLqR13fNPDSsr+MzzKdTnpALOAnTtKtx44oma6X9gvouHv4Z9Q6uFeymy
 pJ3Ot/OYpn+206tI3EsLpQk95Bef9Zl1zAc8K4NPrlFMPXtUUp3NjDDswHPj6iOEdrPsjUfQwu3
 y5siQyr29XN1CnFSJZqhMU7r7IxW9i7MOFP7QZdZxSIfAq9k8Qjjio3aJlMq4LXmrePiIzUDi+a
 YvvPJ
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This version of the patchset fixes a number of warts in the first, and
hopefully gets this closer to something mergeable.

This patchset allows nfsd to dynamically size its threadpool as needed.
The main user-visible change is the addition of new controls that allow
the admin to set a minimum number of threads.

When the minimum is set to a non-zero value, the traditional "threads"
setting is interpreted as a maximum number of threads instead of a
static count. The server will start the minimum number of threads, and
then ramp up the thread count as needed. When the server is idle, it
will gradually ramp down the thread count.

This control scheme should allow us to sanely switch between kernels
that do and do not support dynamic threading. In the case where dynamic
threading is not supported, the user will just get the static maximum
number of threads, just like they do today.

So far this is only lightly tested, but it seems to work well. I
still need to do some benchmarking to see whether this affects
performance, so I'm posting this as an RFC for now.

Does this approach look sane to everyone?

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- svc_recv() now takes a timeout parameter. This should mean that
  non-dynamic RPC services are unaffected by these changes.
- if min_threads is larger than the max, then clamp it to the max
- simplify SP_TASK_STARTING usage. Have same task set and clear it.
- rework thread starting logic (EBUSY handling)
- reorder arguments to svc_set_num_threads() and svc_set_pool_threads()
- break up larger patches
- Link to v1: https://lore.kernel.org/r/20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org

---
Jeff Layton (8):
      sunrpc: split svc_set_num_threads() into two functions
      sunrpc: remove special handling of NULL pool from svc_start/stop_kthreads()
      sunrpc: track the max number of requested threads in a pool
      sunrpc: introduce the concept of a minimum number of threads per pool
      sunrpc: split new thread creation into a separate function
      sunrpc: allow svc_recv() to return -ETIMEDOUT and -EBUSY
      nfsd: adjust number of running nfsd threads based on activity
      nfsd: add controls to set the minimum number of threads per pool

 Documentation/netlink/specs/nfsd.yaml |   5 +
 fs/lockd/svc.c                        |   6 +-
 fs/nfs/callback.c                     |  10 +-
 fs/nfsd/netlink.c                     |   5 +-
 fs/nfsd/netns.h                       |   6 +
 fs/nfsd/nfsctl.c                      |  50 ++++++++
 fs/nfsd/nfssvc.c                      |  63 +++++++---
 fs/nfsd/trace.h                       |  54 +++++++++
 include/linux/sunrpc/svc.h            |  13 ++-
 include/linux/sunrpc/svcsock.h        |   2 +-
 include/uapi/linux/nfsd_netlink.h     |   1 +
 net/sunrpc/svc.c                      | 210 ++++++++++++++++++++--------------
 net/sunrpc/svc_xprt.c                 |  44 +++++--
 13 files changed, 349 insertions(+), 120 deletions(-)
---
base-commit: 83f633515af9382e7201e205112e18b995a80f70
change-id: 20251212-nfsd-dynathread-9f7a31172005

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


