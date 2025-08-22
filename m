Return-Path: <linux-nfs+bounces-13871-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D59AB31966
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 15:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839A8AC21B5
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D2B303C90;
	Fri, 22 Aug 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlbNRWv2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5771303C87;
	Fri, 22 Aug 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868789; cv=none; b=u+x+TEUWvbMI2H5fwv2bIu3HPRM8nGiD2xQJtICROZCKG5Z4MXjSa3taCoM2R1XPvXw5luv2lMkOvNlv6HSfvzZQfhVH5lK3EhK/40YgPg9WciCHKd3SEozIOEaaPgv8OiIbsgzzdN6AI8GbRAN6UVvsKVmXIYYYU50GiQPhUpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868789; c=relaxed/simple;
	bh=AmfhC4f3gfkz5oMJ/fDs0QSwi0saBraVHHxr250eZic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+R9B+U9AOx67YERvB5j6UCsSVNcEDeG1F/ZFFOXyMjkXB7GrJxhIxofoxD7bOy5MU7e2Z4qi1RdtTuSKr0H63FSYwsatitf9ojCOqmunWUtTtbqlOtfQCMmGYEzsiIVZmw8+iZvIjzPM19TEO4UM9K4kAKNs1ZdgLNXh6zbrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlbNRWv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29E4C116B1;
	Fri, 22 Aug 2025 13:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755868789;
	bh=AmfhC4f3gfkz5oMJ/fDs0QSwi0saBraVHHxr250eZic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TlbNRWv2xjT93EUpqH9o/BObRhdYVDvHGKKbCk8PckrA6mtkxy+IN1EOyzyt+YQlK
	 s+BYggS9VQonnhZkU5nbvzL9+bpwPmpJjWNwQIBFRdQDAruroYiDuuLehZAX8p7WaK
	 EVCQ2t0RD7CLifcqPfYj/17WVl9uDgLY/JbGoiJBxfgjMY7vH8DeQ+6cRxK/8VKIEO
	 4d1RI13wxPrWz8BI8TH4nkCe/JLcyG/GsSJRNBPO8QcqHd5XlahVinqK7p2dOHJdPX
	 myYv2u0r6SYhEuCzdqx9qp4eXkhjmnDKJu3sREMBU8Cd8B7UlJWmLZpmH4LKI1ShGD
	 ejgRyJmYC1wtQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 Aug 2025 09:19:23 -0400
Subject: [PATCH v2 2/2] sunrpc: add a Kconfig option to redirect dfprintk()
 output to trace buffer
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-nfs-testing-v2-2-5f6034b16e46@kernel.org>
References: <20250822-nfs-testing-v2-0-5f6034b16e46@kernel.org>
In-Reply-To: <20250822-nfs-testing-v2-0-5f6034b16e46@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2819; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AmfhC4f3gfkz5oMJ/fDs0QSwi0saBraVHHxr250eZic=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoqG5wYtaTHzijD5oaj7MtUxrsCJnQcKKBm5X6o
 s14Caekx+CJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaKhucAAKCRAADmhBGVaC
 FRrZD/9f8TkP/JWpNJp4PYSfHUqeybIbKvgvrkxSJqfvQJm1AUdH0CHqUGvwnBSFHho2sc/SViE
 7Bqowurj3YMnWX1Kls+9UQ5HTJwHh37QdO/RcE1OmUwJzncomZ5HIp9Ia6iWs5qpdxFZacAgfNp
 b/sLKznRWOtFUcOy0dCic9O34GwTPSoCS/ZoQVZyYRH1P9ynhK31bwl7m453Yfwz/6X90BHUIA5
 4ywCXCBjBTrVH5IzWb4tqTvBwI52IdrGCA2gdYkekSx2Akg2AvK3+xGgE9I+gAFQZ6RJqQ0gGYF
 B9p5HprYvPIOzo8ah8UyW/AhZG/Afna6HQZoVYso7+RBd4k4IzXmf+wmfQUbIkeWSI2Q2el3p44
 8o2yRKjp04IbSSirWbQXFfwKRLF2DGiK4Zd/ZnUc/DBa+f5StvBrboo/DkHLqTO2W+K4ApirNjn
 6ifudEMj1NjcqsJWQSnYGx/JvpWMKx5Hkvqyp0VVtCaCMhNCbwDVyHHJ08nRrLGVQn0pJVVGU0Q
 tp18vbiNbaTMCnLwqMW6AiM/qYKNdEGcgR1y5fDq8YkRHpGTwZjYRhPlOiA991ZAReiouVnNw5u
 S2NK2nQOJNyu2lSXUXIOYFHwXTwhflFvZ1qg6XGWo9MdrupmFJH8AAR466IDvAO3LoVyyBRFUfd
 qKq9TtDIgrud8Sg==
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
index 99a6fa4a1d6af0b275546a53957f07c9a509f2ac..891f6173c951a6644018237017c845d81b42aa76 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -30,17 +30,23 @@ extern unsigned int		nlm_debug;
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define ifdebug(fac)		if (unlikely(rpc_debug & RPCDBG_##fac))
 
+# if IS_ENABLED(CONFIG_SUNRPC_DEBUG_TRACE)
+#  define __sunrpc_printk(fmt, ...)	trace_printk(fmt, ##__VA_ARGS__)
+# else
+#  define __sunrpc_printk(fmt, ...)	printk(KERN_DEFAULT fmt, ##__VA_ARGS__)
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


