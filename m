Return-Path: <linux-nfs+bounces-14823-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C4EBAE514
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 20:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8131942F45
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7831553A3;
	Tue, 30 Sep 2025 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdLYh05A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B314D283;
	Tue, 30 Sep 2025 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759257103; cv=none; b=Dt2s5mjrR0Jl4PmW6fuKk9af4fcdJH7i7dkzZcEINVA/Mh07BbYtPG5ScsOGGf0V0s+k5rI1u+WqpV9ytQC94220g4AhdKIWE0svhQnYSjVyFT9EgXdssn4nk63DwuKvE2q15rI2m8LOl1Px61+EjvWOytWT/GjnQHpgmYDAZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759257103; c=relaxed/simple;
	bh=vW3Ny/jW9WMLeERr9aXr0XFEOC31RqRWTEmIhraYLbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q9z/YQXgtv/poGRwAOl3yixnHcKZP2JJ2SlKasKLK/DGbE/fdmR17rdl9O90FSuVSSJq6OPpopEZPgVcjWZe6SSiAnb/2kKCe7ebCCXtnCmIVOUOXyRQPPGW8w1nqbJUGCzhIoHTRs128vCBGCTL5gQ9RZEcde/A4J5tog2uCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdLYh05A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB08C4CEF0;
	Tue, 30 Sep 2025 18:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759257102;
	bh=vW3Ny/jW9WMLeERr9aXr0XFEOC31RqRWTEmIhraYLbw=;
	h=From:Date:Subject:To:Cc:From;
	b=GdLYh05AxWbANd20DIsfqneBp/o2cU9k1uAiFTuig/xIIlVepTEnvZYBgjcplKupq
	 3v+hmytTVWfSljlbUNjHkjya8VZqh04VZK6ewNU9bSndFZtv7Ew6PGHqfzWhIOeneB
	 /WuE8md6j4DnZbqnsq3/TN29cXAmbvMfoD3EbWfBpr3PJeqOWllHMb0Tx+SbpQk7Kg
	 Zpqrr6IxmFOLoAxODd46V5wzMwJMh7qF+Mg2tjnLcOtzVKxAntr0WA9nrvsd4rXZ51
	 4meHZCMSL9FJIcJQU6Au0O+njBr3yb6rMm3V+7AWkqqRVHfprFfgLhxP07i2ouknH9
	 qJ7bsp7J0/k1g==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 30 Sep 2025 11:31:34 -0700
Subject: [PATCH v3] nfsd: Avoid strlen conflict in
 nfsd4_encode_components_esc()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-nfsd-fix-trace-printk-strlen-error-v3-1-536cc9822ee6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAUi3GgC/5XNTQqDMBAF4KtI1p2SP4PtqvcoXWicaFASmYi0i
 HdvdNXuWmb1Bt73VpaQPCZ2LVZGuPjkY8hBnQpm+zp0CL7NmUkuS36RJQSXWnD+CTPVFmEiH+Y
 B0kwjBkCiSCBrqbVQ2IjKsAxNhLlwjNwfOfc+zZFex+Yi9u9f/CIgnzK8VBy1Nc1tQAo4niN1b
 PcX+WlWP5lyN3nVojPOaWG/zG3b3u62UFcpAQAA
X-Change-ID: 20250925-nfsd-fix-trace-printk-strlen-error-2a24413eb186
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4106; i=nathan@kernel.org;
 h=from:subject:message-id; bh=vW3Ny/jW9WMLeERr9aXr0XFEOC31RqRWTEmIhraYLbw=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBl3lHgO77GxP9c7V1v7/PQJeesOWtlufrTb5s+GNkFVd
 f3c5+7hHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAirqWMDHe8Fwmu5P6+s/VN
 en7eQQ32C5uL/7Fo5y1cEsJg97agKIiR4UsSc7oP0x43DU/3H2HP7+e+smO/yJl6MvRK0f8en9K
 ZnAA=
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
altogether to get rid of the immediate strlen() conflict.

At the same time, eliminate the local strlen variable to avoid potential
conflicts with strlen() in the future.

Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v3:
- Eliminate local strlen variable altogether (NeilBrown)
- Link to v2: https://patch.msgid.link/20250928-nfsd-fix-trace-printk-strlen-error-v2-1-108def6ff41c@kernel.org

Changes in v2:
- Remove dprintk() to remove usage of strlen()
- Rename local strlen variable to avoid potential conflict in the future
- Link to v1: https://patch.msgid.link/20250925-nfsd-fix-trace-printk-strlen-error-v1-1-1360530e4c6b@kernel.org
---
 fs/nfsd/nfs4xdr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ea91bad4eee2..07350931488d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2640,11 +2640,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
 	__be32 *p;
 	__be32 pathlen;
 	int pathlen_offset;
-	int strlen, count=0;
+	int count=0;
 	char *str, *end, *next;
 
-	dprintk("nfsd4_encode_components(%s)\n", components);
-
 	pathlen_offset = xdr->buf->len;
 	p = xdr_reserve_space(xdr, 4);
 	if (!p)
@@ -2670,9 +2668,8 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
 			for (; *end && (*end != sep); end++)
 				/* find sep or end of string */;
 
-		strlen = end - str;
-		if (strlen) {
-			if (xdr_stream_encode_opaque(xdr, str, strlen) < 0)
+		if (end > str) {
+			if (xdr_stream_encode_opaque(xdr, str, end - str) < 0)
 				return nfserr_resource;
 			count++;
 		} else

---
base-commit: 3fadfaec904dffab02ebf63dd9c2ae8fa15c6d32
change-id: 20250925-nfsd-fix-trace-printk-strlen-error-2a24413eb186

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


