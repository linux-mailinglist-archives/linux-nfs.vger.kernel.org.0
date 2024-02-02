Return-Path: <linux-nfs+bounces-1712-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56871847243
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 15:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6782905E1
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8307C1DFEF;
	Fri,  2 Feb 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcGB8269"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F201547774
	for <linux-nfs@vger.kernel.org>; Fri,  2 Feb 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885676; cv=none; b=fpIO0vw4H9czL4iDUyuFbOmWWAZTauXU6tgdqfb4Ki2Yk37wp78IvyDTg4wWkmcdY1wg3UXmJY7Stp/bkhR2jx3KG1y4d9LehCE1GetKFHnLGsvfoOHpNxchw+aJg9QGy/E3atVf2GR1k+skGwA2HbO6/BKhyiC72hD9BEEbbE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885676; c=relaxed/simple;
	bh=uld7EvRo2cmxc+RNyI1V2YCujuAHkgzDK24g5xHJiuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FQaMUVrfECyWNL//HhRHgjlo0lpfwtmoeGce708P+kZGGn1lSqKHvLLu75f8pwLogr1Iqj44ponqKD37SiEhI3Tb8azJXM3BhOC44gZiq0EDSkE0Ar7upHUI5P0veM6xPfvfS1nABxkRUK2aK0+g5WHS5kMBm8e+SopqjGcUX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcGB8269; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-363790f53e7so600105ab.0
        for <linux-nfs@vger.kernel.org>; Fri, 02 Feb 2024 06:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706885674; x=1707490474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5H28bb7Giv8F5wK3BwM4o7IHx16B5aQPBfmyBrn/8Y=;
        b=hcGB8269vxj87WpzTkFIr/46uXamLatZ0DOq1vgt1qPtpVXcyyPmFpeLRQ9zibLoG0
         nhA6tB3n1rH1TD+YtdSTxptVb3hHgStVi/utkke07Sxkqd2PSCfx24AQNs0eD1gGNa4Y
         2u6i0dFOq8xsDJsyL/yuFeApc7q0gWyEoU5r146/qtrD3Xmq/4t8TLuEDPbOqQskYeUb
         9cv1TH34/VXoVpGS58iuPrpZKXTp2thd/KAVB2at/Bx4nGifysanO1NSb4glU4I59rxy
         8rCuoVNUf+ETFP0GcEROftyYsn1Gl5yaQUJWuEmKDPCTZ635QzcHs68roKVhHtwFgWtf
         1JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706885674; x=1707490474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5H28bb7Giv8F5wK3BwM4o7IHx16B5aQPBfmyBrn/8Y=;
        b=Z8zgDoAag9XEGtCoRnm5Ffz1k3fwZWmgA4xRPDYUA4XYyu0XiHEvcvEsBRHveFB8Vn
         UvPlN8ZQob2nx72IjLDYnQNq8g6CUiz1+Mks8mzdD2BvZDx8g2K8W5CNdazi0SxFMYcA
         ua9bHRjOkGHb3nOgS0wLiMl91KjdhKV5iMJY6zsncAOi0xnWiCNGjOfMK8zkt8Udyjec
         dZ3IW9apXe4DtHoDkquS9tQTuPupr37MogfmbfiBYNVwcXdxPw0+h6LIu7Ibd7AJjZ3C
         XLLZ5ThY31Pwv0j8tyQIvILzA58JDyL0ht3EiuN+kntm+2Fc1dWCrEQaLt4cgUGBbp0S
         9J8Q==
X-Gm-Message-State: AOJu0Yz24Ae7e2bhUmwpaei/fzlWtk10vj+kFFPF0JbPW19QjHjE8bn+
	3C3BOzVvYMiKd3DwRteSoxHDBwUbnTXQ3ZBRNpGcksgJwVpSW13klZXJqn7P
X-Google-Smtp-Source: AGHT+IE8n/xKA70DG1tPNNWin/scw0IVq7584A4LCfYwkDKeydxnhq/qDIa3GraeeJRkFA/FZACjlA==
X-Received: by 2002:a05:6e02:1d0a:b0:360:968d:bf98 with SMTP id i10-20020a056e021d0a00b00360968dbf98mr6494203ila.1.1706885673993;
        Fri, 02 Feb 2024 06:54:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWzOhr618IaYRz/Mg9JE1GAPPLom2shheU5oH4YXsS5E3ROEiEhdjWD9rTGBRbv6qK0VbGjuEO0gSNuKoj2/zfbP6eoigwTsSqe
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:fd9e:da1:cbd9:bdbf])
        by smtp.gmail.com with ESMTPSA id br9-20020a056e0223c900b003637871ec98sm64720ilb.27.2024.02.02.06.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 06:54:33 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSv4.1: add tracepoint to trunked nfs4_exchange_id calls
Date: Fri,  2 Feb 2024 09:54:32 -0500
Message-Id: <20240202145432.95487-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

Add a tracepoint to track when the client sends EXCHANGE_ID to test
a new transport for session trunking.

nfs4_detect_session_trunking() tests for trunking and returns
EINVAL if trunking can't be done, add EINVAL mapping to
show_nfs4_status() in tracepoints.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c        |  3 +++
 fs/nfs/nfs4trace.h       | 30 ++++++++++++++++++++++++++++++
 include/trace/misc/nfs.h |  1 +
 3 files changed, 34 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 23819a756508..cdda7971c945 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8974,6 +8974,9 @@ void nfs4_test_session_trunk(struct rpc_clnt *clnt, struct rpc_xprt *xprt,
 		status = nfs4_detect_session_trunking(adata->clp,
 				task->tk_msg.rpc_resp, xprt);
 
+	trace_nfs4_trunked_exchange_id(adata->clp,
+			xprt->address_strings[RPC_DISPLAY_ADDR], status);
+
 	if (status == 0)
 		rpc_clnt_xprt_switch_add_xprt(clnt, xprt);
 	else if (status != -NFS4ERR_DELAY && rpc_clnt_xprt_switch_has_addr(clnt,
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 713d080fd268..7d9cb980865d 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -77,6 +77,36 @@ DEFINE_NFS4_CLIENTID_EVENT(nfs4_bind_conn_to_session);
 DEFINE_NFS4_CLIENTID_EVENT(nfs4_sequence);
 DEFINE_NFS4_CLIENTID_EVENT(nfs4_reclaim_complete);
 
+TRACE_EVENT(nfs4_trunked_exchange_id,
+		TP_PROTO(
+			const struct nfs_client *clp,
+			const char *addr,
+			int error
+		),
+
+		TP_ARGS(clp, addr, error),
+
+		TP_STRUCT__entry(
+			__string(main_addr, clp->cl_hostname)
+			__string(trunk_addr, addr)
+			__field(unsigned long, error)
+		),
+
+		TP_fast_assign(
+			__entry->error = error < 0 ? -error : 0;
+			__assign_str(main_addr, clp->cl_hostname);
+			__assign_str(trunk_addr, addr);
+		),
+
+		TP_printk(
+			"error=%ld (%s) main_addr=%s trunk_addr=%s",
+			-__entry->error,
+			show_nfs4_status(__entry->error),
+			__get_str(main_addr),
+			__get_str(trunk_addr)
+		)
+);
+
 TRACE_EVENT(nfs4_sequence_done,
 		TP_PROTO(
 			const struct nfs4_session *session,
diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
index 0d9d48dca38a..5387eb0a6a08 100644
--- a/include/trace/misc/nfs.h
+++ b/include/trace/misc/nfs.h
@@ -239,6 +239,7 @@ TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
 		{ EHOSTDOWN,			"EHOSTDOWN" }, \
 		{ EPIPE,			"EPIPE" }, \
 		{ EPFNOSUPPORT,			"EPFNOSUPPORT" }, \
+		{ EINVAL,			"EINVAL" }, \
 		{ EPROTONOSUPPORT,		"EPROTONOSUPPORT" }, \
 		{ NFS4ERR_ACCESS,		"ACCESS" }, \
 		{ NFS4ERR_ATTRNOTSUPP,		"ATTRNOTSUPP" }, \
-- 
2.39.1


