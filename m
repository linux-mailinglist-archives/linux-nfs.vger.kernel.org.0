Return-Path: <linux-nfs+bounces-1505-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B3683E222
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 20:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D637A1F243E0
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 19:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C5921A1C;
	Fri, 26 Jan 2024 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT/Uqhsq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DAD1DDEA
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295817; cv=none; b=H+TRiXCKHR092o6uLjKrcK4XfdjRq7DHj4jso7kHrVngqCJnEljR29/cym92cO3D+Vu0FzJJhIJSu8wjXK5BDDzzOZBhsrk12UNGgv74k3vE0WLNEig5z+TMpU9ZAjZxuJDWfRWZvmU0Xef7WZewFc10CWkDPJB4wHxHEfzIpv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295817; c=relaxed/simple;
	bh=l58gbDK5mmEqJyBAty9dlL6gLpu+Ashpyz94K+1B7t4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WHbS6zhFO18OTxojhxJs1Y1lU7kGTPCEdUwwhy96Z8XnuWS95unK5sKN6UI28QZfce3b1lGF2t99nf1OPuMPYtE5c9hwvzY/l1I5GNT7PBMD9sVli+/3XchSUBNygCmhDtIkuOGdp88fxFFcjZp8xWN5Kj9HTWUztzeqHP7wyFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT/Uqhsq; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bed82030faso11633839f.1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 11:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706295815; x=1706900615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LECgUHJau29iKjsS8glEoYyEhmQcFOB7ALm2WkPDom4=;
        b=ZT/UqhsqLIlzwLpBJg3eic9y15nioqMqnT3F2jQ+skiLdttBwqF+SzqlMRd2fexYed
         +esHirY9OxTdAQzbmKlqLxu/DdPW5kl/1JWysA+HgadIBg5vz49i7p7Un4gAlHkosRuJ
         63bpAeAOdVOTB8qlcVkMx3iiukkyTqf9+31P07DyPD22UGAiXlIzJJ6hBkt+mLaDYORT
         1ndS7zrznYKs09HeNOTKFB7P61SGsH+GAGE9zMZOPD0fXQROfkbYF/014AKaa5w6+tRV
         suYo2pogSfdrKwJ+GhTV09daIcUgWNE8BOdF34SNpXai81EgjhqsnsUfZy8IXIUmpckD
         N4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706295815; x=1706900615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LECgUHJau29iKjsS8glEoYyEhmQcFOB7ALm2WkPDom4=;
        b=JIW5eole65e+g5IlMHB21ZXs70F8al+sVWk1qfR03RBc2FWJwnG6bgsKWJ9MovZLZi
         6NZMIwGdtZfZY3IuA45/ksqm0MZh21kYBiE6oVSY04wwNfsLI+h2It3kyAlfvFSGo5ao
         Ub7gYIbScVz+jhuKlkCcfqtRHcVtTj0RDzToWoMkp18uq0XELFqwmacsUfbqbPNm/zDP
         YtDutN867Q6wiZbnsSlYUanTs6hxlPaXt7sVWilSTj46pxq+3VikbW4dAS/WTWIQ//Jo
         Jt8KcRn38v8DMt5n0W9ZNViYR/yt/XPVEK8G9O47bc7mI0DMxDmGW5tHtUeegBFcdK8t
         mX8w==
X-Gm-Message-State: AOJu0Yy/GRK8XCwS8KUZhoy13ZjawyiMrBOw0E5aGQ5vdn0WSqIt+1l1
	d2Dbnjm9KqyXDAU1YAN5QYkdmaE0Hh7fUY3yIRFVQHQGVcPnpjzx/HIlKE44
X-Google-Smtp-Source: AGHT+IH9aUe/5FN0bFeKc+aWnknYKsIfVV04myrNeNTb9ee0/lC40iMRtNgdJOkafb0M+G/ZCWfdBQ==
X-Received: by 2002:a6b:a02:0:b0:7bf:b9e0:c7c3 with SMTP id z2-20020a6b0a02000000b007bfb9e0c7c3mr528486ioi.2.1706295815234;
        Fri, 26 Jan 2024 11:03:35 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:f83b:1fa0:f269:c742])
        by smtp.gmail.com with ESMTPSA id f6-20020a02b786000000b0046f793d36basm259518jam.34.2024.01.26.11.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 11:03:34 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: add tracepoint to trunked nfs4_exchange_id calls
Date: Fri, 26 Jan 2024 14:03:33 -0500
Message-Id: <20240126190333.13528-1-olga.kornievskaia@gmail.com>
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

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c  |  3 +++
 fs/nfs/nfs4trace.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

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
-- 
2.39.1


