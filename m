Return-Path: <linux-nfs+bounces-10636-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BABEA65FFA
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 22:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77315421870
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 21:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB142046BD;
	Mon, 17 Mar 2025 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mim8WU4s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F61FECD1;
	Mon, 17 Mar 2025 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245213; cv=none; b=btq5qsQ/cqObDhtVtwZmYoB3Y4LHfq6VBXXefWULvD6/b3w6NrEk4tVQonBKEfxtMz7KSaWx9W/r/ooFCS1w79IZp3LfqVSeJCtzqFoESiRJDOfJozo+H+Mwsmx3Z3T47VrT2BpWqAHkTZ6NNV5c8tUvb69WlAqUc+u35saZE/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245213; c=relaxed/simple;
	bh=Z8+zmkrN7LhrP0MkJFChPV8uMJu827UOhw4WsUjVhZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hd4qwEcLHeF6hfPM+qsI3gEKgaiKZl80W5Msvw5JxAgMt3S534H9VvIh7QVyQqKZDbnFnMLM1oDjim39wAA7kbpHAVzfSz0h+ZDfngajU5nr47LmZlB6xUyrT8/9nnfUKvsoJMQDRq0uPUzaB7yxaXjL9+nwsmXkIsBBPHvus7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mim8WU4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B13FC4CEF2;
	Mon, 17 Mar 2025 21:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742245212;
	bh=Z8+zmkrN7LhrP0MkJFChPV8uMJu827UOhw4WsUjVhZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mim8WU4sOomZEmeQ3aNunFWsglhUZRDesS0dW220nrhgZK0yPI8fHio1cTaktKgrV
	 vWV7FtEbScUlyG4ZPM9QNL0/yK1IrH2DBKmFuTTKZAnJS9hxmQZo4jRIHIGPnfPlJR
	 Lj6UdMKb2Mcrod/EqjN53KTdRdogEScKU9o3oj2gJ+ubq0viX8ELLxebRgtDLoDQof
	 gfqQ3V/aGVTQ75/Ol9NM+jOc0ioRvHxwM3OUGFNlQlNL+giHXv7G8kxX56uuXbaNLW
	 t0LDzms/v92PDjk4fDC4JrSur3nc5Jg8kTUW9Cpw8bTUqDB6YwnXmOPwA3ZDeWinYT
	 S8UUo8texQiGQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 17 Mar 2025 16:59:55 -0400
Subject: [PATCH RFC 3/9] lockd: don't #include debug.h from lockd.h
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rpc-shutdown-v1-3-85ba8e20b75d@kernel.org>
References: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
In-Reply-To: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5550; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Z8+zmkrN7LhrP0MkJFChPV8uMJu827UOhw4WsUjVhZA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn2I1UWq9Ti1qnKUyZMea0lRaTutpfQI3YSGdCL
 MviXaptbFOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ9iNVAAKCRAADmhBGVaC
 FdXDD/4h6mSKDBstWZdZKEK7FN2NyVFD4JT+U+AIKzn0Yw61Xvg0koTqx/YFfUlxmwABs3fBSnv
 /h0XSi8fHOeHZdtkYQZn7fv4GghjnctbP767omEwM9lz3V0TS6skvmV6pOXnoUfy1wHr4bM8BHk
 fDMIScAxgI38JTMZ7wq/MbgH3jTtCEHtHB9/6LaDFi6dZKrXtvd20V5ZxVg9pVYxBRJCcKq745W
 kNdwz2X4ZdLRpgz5W9KXG/jMvrzJbvkHhjeO3X+KX9/1iPYsHBfwq5GoardxxHLLk+UxdkHh0vm
 ZX5VZn0YZo/HEBI5B4fcVThsFf/3lfZxbS9p8VdMoGe5UTi1qdnWPOV26set2l2Qp4xs/KYRNC0
 J0wTi6g3sYQgnBZ2tF2l9RrMubqGg1dR3h9mETSDy1QXmU6U7ZGShRFQ6TPEVCwnfv4tgNx0WI0
 HTcX1MHGXDCL7WNF5Se1LsGuUg+Xfk+GxnCft6KF6kTZACIrdGVxjNYCxDL8Mo/8q6FoVMaKoAE
 D7or1FINRWPHlP6dSL9o9WxSggyg9lyEGDotKoSDG3tXy+ObfxWBZb4V3vKTI3m9ASRgqkF0FKE
 sez8T1hDK21NNWcgABgu+HlVVIF1EB91qFRRvnxb62GYRv7gSjWNEDYr2DGiIU7hylXbviZbwB3
 /pNHNNHxRkCl5iQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We need to #include lockd.h in some files in fs/nfs, but the dprintk
definitions collide with the ones in NFS. Include it directly in the
files in fs/lockd/ that need it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/clnt4xdr.c         | 1 +
 fs/lockd/clntlock.c         | 1 +
 fs/lockd/clntproc.c         | 1 +
 fs/lockd/clntxdr.c          | 1 +
 fs/lockd/host.c             | 1 +
 fs/lockd/mon.c              | 1 +
 fs/lockd/svc.c              | 1 +
 fs/lockd/svc4proc.c         | 1 +
 fs/lockd/svclock.c          | 1 +
 fs/lockd/svcproc.c          | 1 +
 fs/lockd/svcsubs.c          | 1 +
 include/linux/lockd/lockd.h | 1 -
 12 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index 527458db4525af3e76d9119feb6e5e5b62890741..d824c8f89aeedf5903052bf4ed045b079adadaa1 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -14,6 +14,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/stats.h>
 #include <linux/lockd/lockd.h>
+#include <linux/lockd/debug.h>
 
 #include <uapi/linux/nfs3.h>
 
diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index a7e0519ec024a9f73ca05d0d4a0ca29f22d0eb23..5f593d367c1f1781cf68842bb00610234c436524 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -16,6 +16,7 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/lockd/lockd.h>
+#include <linux/lockd/debug.h>
 #include <linux/kthread.h>
 
 #include "trace.h"
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index cebcc283b7ce2e813944d9037de2a7462585a2c9..2cc331c8b2a294f4feae38d1ca0da240b14008bc 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -19,6 +19,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/lockd/lockd.h>
+#include <linux/lockd/debug.h>
 
 #include "trace.h"
 
diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
index 6ea3448d2d31ea54451d6ec0fd01c5f31c35e123..effcef151b60a929a8e96d5560aa5efa84e00b74 100644
--- a/fs/lockd/clntxdr.c
+++ b/fs/lockd/clntxdr.c
@@ -16,6 +16,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/stats.h>
 #include <linux/lockd/lockd.h>
+#include <linux/lockd/debug.h>
 
 #include <uapi/linux/nfs2.h>
 
diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index ed88c102eca0f999a9c5351467d823b806c30962..931a24abd78462ae12b18b7799e1c060748ff276 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -17,6 +17,7 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/lockd/lockd.h>
+#include <linux/lockd/debug.h>
 #include <linux/mutex.h>
 
 #include <linux/sunrpc/svc_xprt.h>
diff --git a/fs/lockd/mon.c b/fs/lockd/mon.c
index b8fc732e1c677063a0d0a1385a64ce22fe216ae4..79364ffa7b2f2aa43c1a504b59d2de77691ae378 100644
--- a/fs/lockd/mon.c
+++ b/fs/lockd/mon.c
@@ -17,6 +17,7 @@
 #include <linux/sunrpc/xprtsock.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/lockd/lockd.h>
+#include <linux/lockd/debug.h>
 
 #include <linux/unaligned.h>
 
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 2c8eedc6c2cc9ebcfe521d90364de84e00eae40f..1cd1bdb06566c70c77728e9a3bab19364c155cdc 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -37,6 +37,7 @@
 #include <net/addrconf.h>
 #include <net/ipv6.h>
 #include <linux/lockd/lockd.h>
+#include <linux/lockd/debug.h>
 #include <linux/nfs.h>
 
 #include "netns.h"
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 109e5caae8c7045487d32bf35b5b80456a421f57..6fdaac8e6877f148927bdc9c0ba613de2dbf2be0 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/lockd/lockd.h>
+#include <linux/lockd/debug.h>
 #include <linux/lockd/share.h>
 #include <linux/sunrpc/svc_xprt.h>
 
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index c1315df4b350bbd753305b5c08550d50f67b92aa..d73ba3959aac3160904b55e77cc10d59604b725c 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -30,6 +30,7 @@
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/lockd/nlm.h>
 #include <linux/lockd/lockd.h>
+#include <linux/lockd/debug.h>
 
 #define NLMDBG_FACILITY		NLMDBG_SVCLOCK
 
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index f53d5177f26732092242fcabe32f0f8931fc1fb6..68c08bf21d300a1c5739c659ceffe375b465c16b 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/lockd/lockd.h>
+#include <linux/lockd/debug.h>
 #include <linux/lockd/share.h>
 #include <linux/sunrpc/svc_xprt.h>
 
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 9103896164f6886eec5adf65a55f4c29433dcb29..e3b63708f7872d5a97df0d1379db40b2fbd3ac5d 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -16,6 +16,7 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/lockd/lockd.h>
+#include <linux/lockd/debug.h>
 #include <linux/lockd/share.h>
 #include <linux/module.h>
 #include <linux/mount.h>
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 6b8c912f443c3b4130f49b8170070d0b794abb94..21cd2cd85e537708ac83d658e40265cec327197b 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -24,7 +24,6 @@
 #ifdef CONFIG_LOCKD_V4
 #include <linux/lockd/xdr4.h>
 #endif
-#include <linux/lockd/debug.h>
 #include <linux/sunrpc/svc.h>
 
 /*

-- 
2.48.1


