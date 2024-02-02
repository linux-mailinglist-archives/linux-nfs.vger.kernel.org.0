Return-Path: <linux-nfs+bounces-1721-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD79847A6B
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 21:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2D229072C
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 20:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1786D2FE3F;
	Fri,  2 Feb 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nriCRCRR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844E981724
	for <linux-nfs@vger.kernel.org>; Fri,  2 Feb 2024 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706905278; cv=none; b=JuFIa55f3fzomyZSB4fsGwTfoit9AmOV8VRHqFCjoDB2tm5kO+YH3N4w9+ysrx0Qp03+XHSFsXzRYwFtTyEPCJERGzxry6TTc1qy5xzRs8GcAo8Cpjfe/5/k4BdcoIlGFHS3m+M6H3xX88DRYyG3abNUCrJNMv/GQdLsI1Kyp4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706905278; c=relaxed/simple;
	bh=7YDCXQuP0K9ud8u+xkYRoVuPD4M/Td1HXWRfk43QBh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JSzpiksF2i0PitInUHXkBkTpjLUq2VZurJ+PxMqGUjZFCYKuLOVu2YC6a0n/Nww0bhT+Xe4sWoXQU161ohMttMU69xwBax/VxcC3w3s0kq+XDhcF3fqfRtVv9T35rM8Q3zl/X3MNhxmsKrh5KuMWfWHP4P4tyYWch/yfFqFIWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nriCRCRR; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso33802139f.0
        for <linux-nfs@vger.kernel.org>; Fri, 02 Feb 2024 12:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706905275; x=1707510075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znLn9yA5qPtFNsntBbJ0XYwkKjjV+CNzihyetfsNicc=;
        b=nriCRCRRaAvl/6em8IcYrMfK1hRrblmfizMfaeXg9UJTNsI9hGKuC++5qmXYSEkv99
         6Gpw16DmaNEsPtwgFC8/RQwgjOOFmjnTiUD7YuScP7Gcv/WcDAfqiBmMBEID6OQDrFTM
         q5OXprCO6W9VicDCVmVOy5xJtfb3xzjRgoaUJU0eIslrId8FO+Qlf7/TnfHP4xHMStH3
         43ohfS/JiKJIWkPgqH3r6ekw3EdLyTPQePlNN2Y/1kdNo5NH1z52qsb1AjZBHl/8sDBv
         PaBUM2iKF94K0dSCX1atEAWy+frx2Qda1tyHc+Pg4qPui33Ea/rUvVuNmwL3C//g919O
         VKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706905275; x=1707510075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znLn9yA5qPtFNsntBbJ0XYwkKjjV+CNzihyetfsNicc=;
        b=E2gTDUuwrAaKK8KTqfShjEvOWVPmVxVGh++bYjCdctln3GdKB6y2WqxYDhv/tLkYgE
         uwiiTO3FuWks4zCi8QmCJ2isZKk5HFLtPZSmVr03Zx3BmcU+BCaXbkLP/a/vR8cHCBMT
         fQjHLXqRfb9YI93vfiuqcBaOlA5cgFzJmkmzp/KbeU2kJEpPzZFYLP7Qq63IpwL6kF0n
         6zQVpVex1c7BUv84n37bruDNd3QA69eaTD2/MEYdzAis7GxpeSdyp8Vr5LnwL1SZY1ub
         olM3zPf4DB1n+RZeOghdOzC9Z18PCJIojfaLQEzCEIpciItiBEVgm8f5u70AVlw6n6Ga
         TZfg==
X-Gm-Message-State: AOJu0YyhInuLBzYDEjydecoQYJXakalYB5gQMAa+Lck81Vqfbsj8nzly
	1F9ha0h8+cFxk8/bYc/K1f0HeP4CxnlSAoL/MCY7lenCHHx0rz3v6zDH3sUN
X-Google-Smtp-Source: AGHT+IGFZeY7oRCxMvBH4z1TjanvGGwqUtaF+wNLcxFejPgiAJ9S2Bi8LldIzQSmJLM5A4pOCLqhcg==
X-Received: by 2002:a6b:7b4a:0:b0:7c1:a68:f7c6 with SMTP id m10-20020a6b7b4a000000b007c10a68f7c6mr1757026iop.1.1706905275471;
        Fri, 02 Feb 2024 12:21:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWsec9uHUQbpkHt9gSbXWEF8HwQAoddJXeCyfBmdNylLXGfjypU180esaOBCSIM8WwhsZsQUCCyX7wj+SNzBzRaFyeMLNkt83kh
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:fd9e:da1:cbd9:bdbf])
        by smtp.gmail.com with ESMTPSA id o2-20020a056638124200b0046e760beffesm653203jas.19.2024.02.02.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 12:21:14 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3] NFSv4.1: add tracepoint to trunked nfs4_exchange_id calls
Date: Fri,  2 Feb 2024 15:21:13 -0500
Message-Id: <20240202202113.16945-1-olga.kornievskaia@gmail.com>
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
 fs/nfs/nfs4proc.c        |  8 +++++---
 fs/nfs/nfs4trace.h       | 30 ++++++++++++++++++++++++++++++
 include/trace/misc/nfs.h |  1 +
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 23819a756508..dae4c1b6cc1c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8970,10 +8970,12 @@ void nfs4_test_session_trunk(struct rpc_clnt *clnt, struct rpc_xprt *xprt,
 		return;
 
 	status = task->tk_status;
-	if (status == 0)
+	if (status == 0) {
 		status = nfs4_detect_session_trunking(adata->clp,
-				task->tk_msg.rpc_resp, xprt);
-
+				task->tk_msg.rpc_resp, xprt); 
+		trace_nfs4_trunked_exchange_id(adata->clp,
+			xprt->address_strings[RPC_DISPLAY_ADDR], status);
+	}
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


