Return-Path: <linux-nfs+bounces-14752-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B27BA76CC
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Sep 2025 21:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FB83A670D
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Sep 2025 19:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463F825A33F;
	Sun, 28 Sep 2025 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByrA+qQs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C4227BB5;
	Sun, 28 Sep 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086904; cv=none; b=ZP4IIYmRzV9NQk8SJF7PjQ2cA9f1Y9PH3qMnRUxBP+li1pyLHI8Z6afeIckg2Cw4/+1kOCo/xGtxuE6H6aZCMkNXmzm29Yaj5y+f1GwtLCcNNQXFOz2fza0Ar8LKLG9Mb/ZnD/MMouc9IRMBtgh9+XGCOO/VJS9yVUx70RgKf+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086904; c=relaxed/simple;
	bh=pN+mMsh78YePxJNWcmLEMcX+GpwX6mBG0Q8/+8T0gGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B9OrDGfnB39qtJJcBNoIBK+iHGeA2TiFkuXVdzaX4wqtjhMU6aw3uDKWGTCz+bNFyDr3ptaPE02ky1pbgNss8r8kqF5LJm6Pujt6/csgD7XAUETHAPX6iI/zXZhrtQA9nVSfXz6PUsmPCbfTu7alAUQn4UGUUIB2VwLl1hStVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByrA+qQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92301C4CEF0;
	Sun, 28 Sep 2025 19:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759086902;
	bh=pN+mMsh78YePxJNWcmLEMcX+GpwX6mBG0Q8/+8T0gGc=;
	h=From:Date:Subject:To:Cc:From;
	b=ByrA+qQszPLiLs0jKtNdKXRmWSKs0W/fIcnL2KCduq51KMrAGKn6tkyTye7u3TCAA
	 NQEwlM9s1DnoQ7kp4yd24EWK9V+9HdfqWUrXk6tvltBPkS5Yig1VGbBIUUtiFDdLAN
	 riVXJQ21FMt7MtNZfbdRP4LQZLp/4VfECleKgzu4S5wcoIytnraQqmTYhI4L/Z2GmC
	 zN/qCNk65gyreBuNTcgC0iyMrnTysoijG+lJHeB0+OO1k++nOA1jNjPQkjdbQxYIp1
	 klGnu7uxNmyag0W8r34gMQC4Ztffwmm43RMGtP6jk0JqcZKUU8R83qOqFKHJOvkWbl
	 AMtO7QaFWq79A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sun, 28 Sep 2025 15:14:50 -0400
Subject: [PATCH v2] nfsd: Avoid strlen conflict in
 nfsd4_encode_components_esc()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250928-nfsd-fix-trace-printk-strlen-error-v2-1-108def6ff41c@kernel.org>
X-B4-Tracking: v=1; b=H4sIACmJ2WgC/5WNTQqDMBCFryKz7pQkRmm76j2KC39GHZREJkFaJ
 Hdv6g3KW30P3vcOCCRMAR7FAUI7B/Yug7kU0M+tmwh5yAxGmUrdTYVuDAOO/MYobU+4Cbu4YIi
 ykkMS8YKmNdbqkjp9qyGLNqE8OE9eTeaZQ/TyOT93/Wv/0u8ac8paVaUi29fdcyFxtF69TNCkl
 L67DsK01QAAAA==
X-Change-ID: 20250925-nfsd-fix-trace-printk-strlen-error-2a24413eb186
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3890; i=nathan@kernel.org;
 h=from:subject:message-id; bh=pN+mMsh78YePxJNWcmLEMcX+GpwX6mBG0Q8/+8T0gGc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBk3O02q4/6prUgT1Ztx8qeY6OZjtzqjovlDzhyIj1h8+
 piEpMrsjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRbSsZ/qnYSH/jPhNoW5sj
 9zGO/7fL8ctTt257F7GFyylmWVKIpCIjw8nZopN6O0TfnVl769R/51mftnUXtqnIKD1S4ngg+Nv
 mBycA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

There is an error building nfs4xdr.c with CONFIG_SUNRPC_DEBUG_TRACE=y
and CONFIG_FORTIFY_SOURCE=n due to the local variable strlen conflicting
with the function strlen():

  In file included from include/linux/cpumask.h:11,
                   from arch/x86/include/asm/paravirt.h:21,
                   from arch/x86/include/asm/irqflags.h:102,
                   from include/linux/irqflags.h:18,
                   from include/linux/spinlock.h:59,
                   from include/linux/mmzone.h:8,
                   from include/linux/gfp.h:7,
                   from include/linux/slab.h:16,
                   from fs/nfsd/nfs4xdr.c:37:
  fs/nfsd/nfs4xdr.c: In function 'nfsd4_encode_components_esc':
  include/linux/kernel.h:321:46: error: called object 'strlen' is not a function or function pointer
    321 |                 __trace_puts(_THIS_IP_, str, strlen(str));              \
        |                                              ^~~~~~
  include/linux/kernel.h:265:17: note: in expansion of macro 'trace_puts'
    265 |                 trace_puts(fmt);                        \
        |                 ^~~~~~~~~~
  include/linux/sunrpc/debug.h:34:41: note: in expansion of macro 'trace_printk'
     34 | #  define __sunrpc_printk(fmt, ...)     trace_printk(fmt, ##__VA_ARGS__)
        |                                         ^~~~~~~~~~~~
  include/linux/sunrpc/debug.h:42:17: note: in expansion of macro '__sunrpc_printk'
     42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
        |                 ^~~~~~~~~~~~~~~
  include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
     25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
        |         ^~~~~~~~
  fs/nfsd/nfs4xdr.c:2646:9: note: in expansion of macro 'dprintk'
   2646 |         dprintk("nfsd4_encode_components(%s)\n", components);
        |         ^~~~~~~
  fs/nfsd/nfs4xdr.c:2643:13: note: declared here
   2643 |         int strlen, count=0;
        |             ^~~~~~

This dprintk() instance is not particularly useful, so just remove it
altogether.

At the same time, rename the strlen local variable to avoid any
potential conflicts with strlen().

Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Remove dprintk() to remove usage of strlen()
- Rename local strlen variable to avoid potential conflict in the future
- Link to v1: https://patch.msgid.link/20250925-nfsd-fix-trace-printk-strlen-error-v1-1-1360530e4c6b@kernel.org
---
 fs/nfsd/nfs4xdr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ea91bad4eee2..9fe8a413f688 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2640,11 +2640,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
 	__be32 *p;
 	__be32 pathlen;
 	int pathlen_offset;
-	int strlen, count=0;
+	int str_len, count=0;
 	char *str, *end, *next;
 
-	dprintk("nfsd4_encode_components(%s)\n", components);
-
 	pathlen_offset = xdr->buf->len;
 	p = xdr_reserve_space(xdr, 4);
 	if (!p)
@@ -2670,9 +2668,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
 			for (; *end && (*end != sep); end++)
 				/* find sep or end of string */;
 
-		strlen = end - str;
-		if (strlen) {
-			if (xdr_stream_encode_opaque(xdr, str, strlen) < 0)
+		str_len = end - str;
+		if (str_len) {
+			if (xdr_stream_encode_opaque(xdr, str, str_len) < 0)
 				return nfserr_resource;
 			count++;
 		} else

---
base-commit: 3fadfaec904dffab02ebf63dd9c2ae8fa15c6d32
change-id: 20250925-nfsd-fix-trace-printk-strlen-error-2a24413eb186

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


