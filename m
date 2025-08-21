Return-Path: <linux-nfs+bounces-13842-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEB8B300D9
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 19:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF255C8EA5
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 17:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27DC3218AE;
	Thu, 21 Aug 2025 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxJwVPBw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503D31DDB7;
	Thu, 21 Aug 2025 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796632; cv=none; b=JtSzkb35HbXhi0/CSmhX9qAvAtcNCU8BCSb1Ma2KFGrA3+9aesqZ2Kwjn2XscccCqHRyCmqwaTg2RI0cJnKDP13A+SSjW+So1YsEH7NhHO0nXnn8cqah/cgVObikHKc4glVE3Xx1etrANQvHSViFP52MDUfKP5de8y76MqOzNig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796632; c=relaxed/simple;
	bh=IWBUsPMaovbvPzkcKpzQPxw7viJiDsYkOjxuQ6QdK3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qsaQ/ycAzy3ZKhZI9IJiqGH5MMoz7LG/9UXMKheDmzdDybBw21AcnhqE2A8i4czbXLaALB+BZeUaArGaQoRfqOwSPDqyB4W64aV3dNz9D+6C2YsbTocbHqrtOV15wXtY1c4Xkp3+Pljid72qCnrQEdeyJMWOQUmIhStMb4NVWv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxJwVPBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6504DC116D0;
	Thu, 21 Aug 2025 17:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796632;
	bh=IWBUsPMaovbvPzkcKpzQPxw7viJiDsYkOjxuQ6QdK3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qxJwVPBwJwOp6paCOmqcfGXUBFUa+O1w4dDwzZhyX6a/Ewa1icxGMypTGA4Wjn2pM
	 Qq+8t6d3QXmO2xj/ZWsHVFUSanIVBTM/XMnr24tSJNJ0mBFT5r/e2YiDwQi1w/E+dS
	 +uGuVsXnfSvov+QVdZemIlW1fFziBjCf/uSZwbmsTOF8O/T0gSy0Wrjv0e+asApxqq
	 BuxzHH3Div0IH5ayM+KvoKoylitPpOtblvKl00tCo817eWf54VDwRdNOaALwhOXSRS
	 1DrAZezvbovb201KBDRw5nm4nB2emBI6Cb3heHMa0ygs+fWe3FkyYTPiziNF1n18lD
	 FwR4tTjLIiezA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 21 Aug 2025 13:16:54 -0400
Subject: [PATCH 2/2] sunrpc: add a Kconfig option to redirect dfprintk()
 output to trace buffer
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-nfs-testing-v1-2-f06099963eda@kernel.org>
References: <20250821-nfs-testing-v1-0-f06099963eda@kernel.org>
In-Reply-To: <20250821-nfs-testing-v1-0-f06099963eda@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2810; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IWBUsPMaovbvPzkcKpzQPxw7viJiDsYkOjxuQ6QdK3E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBop1SUmZk9LS+M8TwLsVUJeOHMCSNpNyhRLj9G2
 ug+q8odwyiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaKdUlAAKCRAADmhBGVaC
 FZyPEACK3z617R0z5DE/cZI1qGrxkauIY0eeQfj3MsvV25UN5XF6Sr6ilK0Yc+1kyScluYz9c1k
 9QvUal/H0Tj7IZ4yl+gEut5EEQNemyWxnQqjuxzIL7Q3AzJ+YRFekXZQcEt26T0uD2pALOlxxVI
 SRPhv8x7E5K9ZKbu8bL0klUK2f+WTaZW7Oglp9bcfFbVaoG5PK6cEbtlXKV2mOABG5QuHTVSa4z
 wCfJEC9ZNnk6KI1LBFqJFO0a0z2R6fmUUz6TS22ZCbL9aAJypw4g3s3CNie6AN7ec1sCObxsBKb
 Q805K+x7QBFs2zzg0j/+EQ4e3uzWg0NCbFDQVB1xDh6pKecSy5KbhgjD8pZp77COZaECy5n07/b
 U6u0IGOEQwfbqKNSYeYJ1OnX7kJjsP1pK6YhqBdmJcz92aVcJ+U4/NAdxP7ptj96drf5IaelM7f
 TAn0KCFPQUy7EopIcbZP3YqFyy8yeZYttEFZHiD8/1BD2M6fCGr9XpQvsrK2BYBNPaa/5UP0MGy
 hww90I43IY5TDuAtpbPLjkEiZ519dIJTP2L5Guy43vrycQNG2LFftLMtES708S6mLrlf/iU0chP
 S5uuHuh7W98DTv4n6/1CbdsoRznRFaZZmPy0LF6EvDmEgmr1CpxlWCOMrQl7vNw9JikW0rxGnpn
 eWH78akbKznwTIA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We have a lot of old dprintk() call sites that aren't going anywhere
anytime soon. At the same time, turning them up is a serious burden on
the host due to the console locking overhead.

Add a new Kconfig option that redirects dfprintk() output to the trace
buffer. This is more efficient than logging to the console and allows
for proper interleaving of dprintk and static tracepoint events.

Since using trace_printk() causes scary warnings to pop at boot time,
this new option defaults to "n".

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/debug.h | 10 ++++++++--
 net/sunrpc/Kconfig           | 14 ++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index 99a6fa4a1d6af0b275546a53957f07c9a509f2ac..fd9f79fa534ef001b3ec5e6d7e4b1099843b64a4 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -30,17 +30,23 @@ extern unsigned int		nlm_debug;
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define ifdebug(fac)		if (unlikely(rpc_debug & RPCDBG_##fac))
 
+# if IS_ENABLED(CONFIG_SUNRPC_DEBUG_TRACE)
+#  define __sunrpc_printk(fmt, ...)	trace_printk(fmt, ##__VA_ARGS__)
+# else
+#  define __sunrpc_printk(fmt, ...)	pr_default(fmt, ##__VA_ARGS__)
+# endif
+
 # define dfprintk(fac, fmt, ...)					\
 do {									\
 	ifdebug(fac)							\
-		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);				\
+		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
 } while (0)
 
 # define dfprintk_rcu(fac, fmt, ...)					\
 do {									\
 	ifdebug(fac) {							\
 		rcu_read_lock();					\
-		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);				\
+		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
 		rcu_read_unlock();					\
 	}								\
 } while (0)
diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index 2d8b67dac7b5b58a8a86c3022dd573746fb22547..a570e7adf270fb8976f751266bbffe39ef696c6a 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -101,6 +101,20 @@ config SUNRPC_DEBUG
 
 	  If unsure, say Y.
 
+config SUNRPC_DEBUG_TRACE
+	bool "RPC: Send dfprintk() output to the trace buffer"
+	depends on SUNRPC_DEBUG && TRACING
+	default n
+	help
+          dprintk() output can be voluminous, which can overwhelm the
+          kernel's logging facility as it must be sent to the console.
+          This option causes dprintk() output to go to the trace buffer
+          instead of the kernel log.
+
+          This will cause warnings about trace_printk() being used to be
+          logged at boot time, so say N unless you are debugging a problem
+          with sunrpc-based clients or services.
+
 config SUNRPC_XPRT_RDMA
 	tristate "RPC-over-RDMA transport"
 	depends on SUNRPC && INFINIBAND && INFINIBAND_ADDR_TRANS

-- 
2.50.1


