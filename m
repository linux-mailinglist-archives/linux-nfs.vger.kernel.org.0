Return-Path: <linux-nfs+bounces-15040-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6439BC2BDD
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 23:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F14C3AC230
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 21:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6D02441A6;
	Tue,  7 Oct 2025 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5xn7euk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A7242D99
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759872338; cv=none; b=sCv9Grw+oWwL45I0HW/CPvvjomNSUrI9BgH9qeXO6wO4fdpWfgz5Wm8C3sE2CoYSTCnC6biPPLyA10aD4xb/h8rBtF3/RL8VfMWQv/FO0NzhDnzaYgFIrYnuwWB0nxvOl2UXuUKUlVEVuTME3R4EDG/AqEAF6J6DAW+NdgfKZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759872338; c=relaxed/simple;
	bh=S1FEgML9qPG5AM0qstopvJ3G1GMqfZsPQL9p0u+C8Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9YUiBp1ebSfF9OgwsBUqtWA7QHsurwdyunZTGMqHsn5vBdTilfFwmCJYBoyaUVHV9t5gEvKkQDBPOJ3/Bhykx/h6ZF9ncEXN+Gvem9q0FfRVMYis9dxd97gUK7wF1HWwrYR3o4e9gG9rYv0RwvwZx0b8l/bE0VsxN8gQ4TqPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5xn7euk; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7a9a2b27c44so202088a34.0
        for <linux-nfs@vger.kernel.org>; Tue, 07 Oct 2025 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759872336; x=1760477136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kUquPAxZ7RNpS7S7i2SrAQtXSPkHjUEz/KSOyJfe4qQ=;
        b=C5xn7eukzcwq8GdNRDdcFZSJR8b56CV1c3zSdTiTkmHFCLKxi6hJmMHKG/1wV02sDS
         68j9bvXHrIvgzEsltBxTiBiaxk5Evkf6l6igFLOanMdM3KHqMwR0K6WMLs1EYx9t+B11
         d2kKBjUwxMP8FGDcPWHZvj8M/87GB9SP8EW1upGkuM2cwFKon1jLStFNBls6Fkt1BUhE
         +bcbP0VHxL/wFzRYCrKg0jL9JaI1b85Ph+MUtpb0XwY6+1qWNZW+mugTgxyQ3mpvHVpE
         vcdyrWb4z+uOZRv9IzZye6RvbFQsFxTfi1bumYkzGfOYJUuHV9hUJU7IQLXwxdsZd0WN
         d0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759872336; x=1760477136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUquPAxZ7RNpS7S7i2SrAQtXSPkHjUEz/KSOyJfe4qQ=;
        b=LZjD19DQ02DyCEth0NUApXhVJqnq6HzBrWNMlgVgBM/4Hc9+E+cEUFkhm0Cug9BiB7
         4ENqrS527qr0qzTqKl9F1Hn5isTgaqkHL6VnaL0yGEA/GTawzKgrtz7KxYRpFgEtkn0+
         Go6g4SUcMLrgx3Aw0qn3ONLmLotANciC0ZymBreHuQmSgDwYjt44M4bByxneMeNSReAl
         lwcjVF6Mij7KQCi7syYMlmx32ym8fBhDJgla4xJDz/MxDGCxz0mts8aRwK9ylkm4MU2t
         RVeBg3a3hbqQe/716nVkRP55nXHMo0jQsySb3xTO8/1nGKkW9Acfxd2Z9NL+ht77apWo
         A9ew==
X-Gm-Message-State: AOJu0YyaJkvcWHvWGmi1w4Td2/B34It+NTqgLx78QhR3x07ghWrLfsD6
	nyF4K1lit67V/GY03iSEaxK0aWJowvZePF0lxpv8L5ZaymGV0D6AHI4AjMjY0LJc
X-Gm-Gg: ASbGnct3HpJnK9qPiWqSBwZ9iCxua+oQHIwOpN3bIbgSLj4J0zaIIjMlJCLO0gczpCl
	kds8zAeIXj8f45i030P/KFGdaFimV6yYdTQRSoykE+gtCx0MoqBOauI0/HbzZA5XEuxDCIxUBgc
	sMukWmIotft/XmWaiRsSqv2Z1uMlErDhVE2D5PUCQsWd8zf3kY4454kvsAXO0smWuzIwT19JLUF
	BaRKKpxGmC6FyvpPeP1XqENIQcPqXgLlsHlIe1yGln/Wj9rmTz1Mqy2M1SAv4tHSqRW09eRDspd
	FofudY/RYSQy2yNEfzNR9dUdI11xpMGAahgIL73JBTnDvI86HyW/IPZQEQTnk8aQMhhbva2u4SG
	VnMewIWIdRDlzprjpFBcCbrYdme3FkXqFyQeHN43kAIzA
X-Google-Smtp-Source: AGHT+IGVpQmalLijAGU5vOAIIlvZRuDDP7hjcIQHqTx9MN+lNXCJVCuW2MsRZQXaL66/QVvXSBusuw==
X-Received: by 2002:a05:6830:7188:b0:797:97d1:de29 with SMTP id 46e09a7af769-7c0dfef9314mr520698a34.13.1759872335719;
        Tue, 07 Oct 2025 14:25:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::7bc8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf439d2aadsm5134465a34.36.2025.10.07.14.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 14:25:35 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joshua Watt <jpewhacker@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH] NFS4: Apply delay_retrans to async operations
Date: Tue,  7 Oct 2025 15:22:58 -0600
Message-ID: <20251007212452.599683-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Watt <jpewhacker@gmail.com>

The setting of delay_retrans is applied to synchronous RPC operations
because the retransmit count is stored in same struct nfs4_exception
that is passed each time an error is checked. However, for asynchronous
operations (READ, WRITE, LOCKU, CLOSE, DELEGRETURN), a new struct
nfs4_exception is made on the stack each time the task callback is
invoked. This means that the retransmit count is always zero and thus
delay_retrans never takes effect.

Apply delay_retrans to these operations by tracking and updating their
retransmit count.

Change-Id: Ieb33e046c2b277cb979caa3faca7f52faf0568c9
Signed-off-by: Joshua Watt <jpewhacker@gmail.com>
---
 fs/nfs/nfs4proc.c       | 13 +++++++++++++
 include/linux/nfs_xdr.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index f58098417142..411776718494 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3636,6 +3636,7 @@ struct nfs4_closedata {
 	} lr;
 	struct nfs_fattr fattr;
 	unsigned long timestamp;
+	unsigned short retrans;
 };
 
 static void nfs4_free_closedata(void *data)
@@ -3664,6 +3665,7 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
 		.state = state,
 		.inode = calldata->inode,
 		.stateid = &calldata->arg.stateid,
+		.retrans = calldata->retrans,
 	};
 
 	if (!nfs4_sequence_done(task, &calldata->res.seq_res))
@@ -3711,6 +3713,7 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
 		default:
 			task->tk_status = nfs4_async_handle_exception(task,
 					server, task->tk_status, &exception);
+			calldata->retrans = exception.retrans;
 			if (exception.retry)
 				goto out_restart;
 	}
@@ -5593,9 +5596,11 @@ static int nfs4_read_done_cb(struct rpc_task *task, struct nfs_pgio_header *hdr)
 			.inode = hdr->inode,
 			.state = hdr->args.context->state,
 			.stateid = &hdr->args.stateid,
+			.retrans = hdr->retrans,
 		};
 		task->tk_status = nfs4_async_handle_exception(task,
 				server, task->tk_status, &exception);
+		hdr->retrans = exception.retrans;
 		if (exception.retry) {
 			rpc_restart_call_prepare(task);
 			return -EAGAIN;
@@ -5709,10 +5714,12 @@ static int nfs4_write_done_cb(struct rpc_task *task,
 			.inode = hdr->inode,
 			.state = hdr->args.context->state,
 			.stateid = &hdr->args.stateid,
+			.retrans = hdr->retrans,
 		};
 		task->tk_status = nfs4_async_handle_exception(task,
 				NFS_SERVER(inode), task->tk_status,
 				&exception);
+		hdr->retrans = exception.retrans;
 		if (exception.retry) {
 			rpc_restart_call_prepare(task);
 			return -EAGAIN;
@@ -6726,6 +6733,7 @@ struct nfs4_delegreturndata {
 	struct nfs_fh fh;
 	nfs4_stateid stateid;
 	unsigned long timestamp;
+	unsigned short retrans;
 	struct {
 		struct nfs4_layoutreturn_args arg;
 		struct nfs4_layoutreturn_res res;
@@ -6746,6 +6754,7 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 		.inode = data->inode,
 		.stateid = &data->stateid,
 		.task_is_privileged = data->args.seq_args.sa_privileged,
+		.retrans = data->retrans,
 	};
 
 	if (!nfs4_sequence_done(task, &data->res.seq_res))
@@ -6817,6 +6826,7 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 		task->tk_status = nfs4_async_handle_exception(task,
 				data->res.server, task->tk_status,
 				&exception);
+		data->retrans = exception.retrans;
 		if (exception.retry)
 			goto out_restart;
 	}
@@ -7093,6 +7103,7 @@ struct nfs4_unlockdata {
 	struct file_lock fl;
 	struct nfs_server *server;
 	unsigned long timestamp;
+	unsigned short retrans;
 };
 
 static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
@@ -7147,6 +7158,7 @@ static void nfs4_locku_done(struct rpc_task *task, void *data)
 	struct nfs4_exception exception = {
 		.inode = calldata->lsp->ls_state->inode,
 		.stateid = &calldata->arg.stateid,
+		.retrans = calldata->retrans,
 	};
 
 	if (!nfs4_sequence_done(task, &calldata->res.seq_res))
@@ -7180,6 +7192,7 @@ static void nfs4_locku_done(struct rpc_task *task, void *data)
 			task->tk_status = nfs4_async_handle_exception(task,
 					calldata->server, task->tk_status,
 					&exception);
+			calldata->retrans = exception.retrans;
 			if (exception.retry)
 				rpc_restart_call_prepare(task);
 	}
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index d56583572c98..31463286402f 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1659,6 +1659,7 @@ struct nfs_pgio_header {
 	void			*netfs;
 #endif
 
+	unsigned short		retrans;
 	int			pnfs_error;
 	int			error;		/* merge with pnfs_error */
 	unsigned int		good_bytes;	/* boundary of good data */
-- 
2.51.0


