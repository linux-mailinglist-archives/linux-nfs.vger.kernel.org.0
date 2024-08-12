Return-Path: <linux-nfs+bounces-5324-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C56794F206
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 17:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB051C21194
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A791184538;
	Mon, 12 Aug 2024 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyaQ665T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477731474C3
	for <linux-nfs@vger.kernel.org>; Mon, 12 Aug 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477692; cv=none; b=bQ+rXx1kV9cHEkIloytV0eIcxtVDJMcWxyjeX02IY9hmOABL0t2K1nlcXjggG4op6SxYsH08USG0YrnHskAQ3kEvk5sI8rITZIav0KjqqYmFULj20A+pKKJV687PuVZAIC1pj0B0xSprg/2LBEeMUJrv1qSPvb8Uan+cskJoJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477692; c=relaxed/simple;
	bh=v2TCkm8mpwdhAyyFfDqJPr8AA4Zb/E5f18OoYCAd0QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdDjkErbdT+IQ2c3emoUXyoVL+skiKSdxuZRHsp/oFYyH7DsOhFlpYnAPkuktuDhVRM4lgVCmVSMbKJ7wcIyIr1D+kKgFo/2SfyMUS033gyxSnd1ZMkydLeDJ7EnKl03JezbKR+s3pzNlPmMFJghh78/evENTErOf9+mbn841OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyaQ665T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEDFC32782;
	Mon, 12 Aug 2024 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723477691;
	bh=v2TCkm8mpwdhAyyFfDqJPr8AA4Zb/E5f18OoYCAd0QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EyaQ665TWw0NUvmkaetB9l/VsxuAhpYRO9nBGP97tsv6zAX6BXldwh5fv4MPZnVmI
	 11wyk8CGEUPCB8Pz0qB6/chbz4+8ThKwvADJnp5j03uY64Z04mtT6aPtj4oUl1JgTh
	 89H7aoqYLFwcUcegDecV22OZOf4pKTMGLXPXo2VywBmXSJ2Tjqtt/N9/b4MKglXZd5
	 6nWeqRQAJpZns0xSpoHHptbHA2Paj12yqEX6eWpjbvyQi0z0sPjJc2MqO0dUMxPi2n
	 edaY/+v+LcDHfo8uOBrYTuWyQhZj8P4cZBHa+tUc3G7gwsDBJP1OXNsbjd+lNEWt9l
	 tc5wJO9980hIQ==
From: cel@kernel.org
To: Anna Schumaker <anna@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 3/3] rpcrdma: Trace connection registration and unregistration
Date: Mon, 12 Aug 2024 11:47:59 -0400
Message-ID: <20240812154759.29870-4-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240812154759.29870-1-cel@kernel.org>
References: <20240812154759.29870-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

These new trace points record xarray indices and the time of
endpoint registration and unregistration, to co-ordinate with
device removal events.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  | 36 +++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/ib_client.c |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 9141398591e0..e6a72646c507 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -2300,6 +2300,42 @@ DEFINE_CLIENT_DEVICE_EVENT(rpcrdma_client_remove_one);
 DEFINE_CLIENT_DEVICE_EVENT(rpcrdma_client_wait_on);
 DEFINE_CLIENT_DEVICE_EVENT(rpcrdma_client_remove_one_done);
 
+DECLARE_EVENT_CLASS(rpcrdma_client_register_class,
+	TP_PROTO(
+		const struct ib_device *device,
+		const struct rpcrdma_notification *rn
+	),
+
+	TP_ARGS(device, rn),
+
+	TP_STRUCT__entry(
+		__string(name, device->name)
+		__field(void *, callback)
+		__field(u32, index)
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->callback = rn->rn_done;
+		__entry->index = rn->rn_index;
+	),
+
+	TP_printk("device=%s index=%u done callback=%pS\n",
+		__get_str(name), __entry->index, __entry->callback
+	)
+);
+
+#define DEFINE_CLIENT_REGISTER_EVENT(name)				\
+	DEFINE_EVENT(rpcrdma_client_register_class, name,		\
+	TP_PROTO(							\
+		const struct ib_device *device,				\
+		const struct rpcrdma_notification *rn			\
+	),								\
+	TP_ARGS(device, rn))
+
+DEFINE_CLIENT_REGISTER_EVENT(rpcrdma_client_register);
+DEFINE_CLIENT_REGISTER_EVENT(rpcrdma_client_unregister);
+
 #endif /* _TRACE_RPCRDMA_H */
 
 #include <trace/define_trace.h>
diff --git a/net/sunrpc/xprtrdma/ib_client.c b/net/sunrpc/xprtrdma/ib_client.c
index 7913d7bad23d..8507cd4d8921 100644
--- a/net/sunrpc/xprtrdma/ib_client.c
+++ b/net/sunrpc/xprtrdma/ib_client.c
@@ -66,6 +66,7 @@ int rpcrdma_rn_register(struct ib_device *device,
 		return -ENOMEM;
 	kref_get(&rd->rd_kref);
 	rn->rn_done = done;
+	trace_rpcrdma_client_register(device, rn);
 	return 0;
 }
 
@@ -91,6 +92,7 @@ void rpcrdma_rn_unregister(struct ib_device *device,
 	if (!rd)
 		return;
 
+	trace_rpcrdma_client_unregister(device, rn);
 	xa_erase(&rd->rd_xa, rn->rn_index);
 	kref_put(&rd->rd_kref, rpcrdma_rn_release);
 }
-- 
2.45.1


