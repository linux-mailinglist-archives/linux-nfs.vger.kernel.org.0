Return-Path: <linux-nfs+bounces-12825-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F845AEE6DB
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jun 2025 20:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89EC13B77C4
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jun 2025 18:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464282E7639;
	Mon, 30 Jun 2025 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz6svb68"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B63C2E718B;
	Mon, 30 Jun 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308576; cv=none; b=mYzofunr0nT6obz8T7bhZlnuCSCDFHqP3Ki13VLCaOW2xk44voVJz4gG6p+INMGdlgrUna9sESoofhK/4T0xBVtzRp3lzxoMuJJYUmPH9DTo8twVAya+HGpJd7AkJy8krq/tAVpv9FvuNycTjESvQ6y3f5gK+1gyVYMDt8GgFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308576; c=relaxed/simple;
	bh=dtVyVF5MNOMBsCDa1CoBOom+uvndZq8R2JSHuPZeVIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIyIArYMJg8fa6w+h3fVtEZDomFRCrCppqzZGTSIah2HIo3aJc8vPzmGtm1zrTvY+tsGzL03Ar+OCzdTphjYDuvqgvuNwJ/T4lDkTr1G+IwfY4tXOCbkx9MTvCHAmN3VuaZLR1Me7LMBh4y7Pn9FvwN4OOpss5JbM2CW0Yj0OMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gz6svb68; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5561d41fc96so612644e87.1;
        Mon, 30 Jun 2025 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751308572; x=1751913372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEaFTdp9vPJydEyqwmi3nr/Hucoz77t8PqXx+J2O80U=;
        b=Gz6svb68q0MWpaKBDenuPhE9t5wy86SEeRt5cridRmWhL5bFypg4DwS8gBQa5EedRe
         KSm26dt5wbWFnYqYwxsPdY1FRsL1tcfuTOq9HsgcLrhvmDjm8lpuS6Idlj6OAR5VdKMa
         BAs5rFm5LP4fhd4gHZWvta+Rb8wHByI4bFs36rhQNkNvIMSap+3uOwHYWj4mx3GybGUM
         UaoDV97pJraJhhVvttS3KdOC/gPQ2pJHGtAl3RsPMaDRAq2JMeMrfgyUKh2WSDB4HJn6
         vKMg+eVKKn2rX7dWO9vAFLyy1A+KOhywNT1VNEXDsvyYb8LXssWkei0yng9i30WjnqOG
         hAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751308572; x=1751913372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEaFTdp9vPJydEyqwmi3nr/Hucoz77t8PqXx+J2O80U=;
        b=iXVskG8TMfhRETZ9FUdc9zh+XKHM1Z29e5ultuYIjJ07qD0g0fZwp9q6bnR34OQiz6
         2A9/X0SYslHm98jCUSDhilEe07v/NulLfj/Z65RaDvvyhNf9UioWlHi00B+eE8u9bxH9
         VdUWH1y5ibKd06H9pRY43chZ/0V0rfl+VutiZ9Ypu6Q6V8uBvb7cBv6kHYmHKjVwNDE9
         AIAF693Gqp7P2cWAy0WDs9scnOmSRnUI5VeHzOxSoG6Lb/jWFwDKEOKQTYb0KHR0yxlX
         uaW1+9UomctE+rq1uufHicQU60OQDHfnncA/ednqOjwhbXI9GhQect9NSNUAEB1CKCRS
         X4JA==
X-Forwarded-Encrypted: i=1; AJvYcCUh5zloDPvTR2ZofEB3HMKkOaxhhL47lx/KtW2Pwa708/KCvx8ki6QXjmsruc3qcCelxrkf3B6TKbii35s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgb8oDQXNeCoM84XKTtbyruDCyVdpGYLEadyHb+27GYXwigcSP
	SOIGUfhDhvVX6dJ4pUxbD/OSo6Z360TrWRe3NJtxouhaYoc49R3GTD4s
X-Gm-Gg: ASbGncv1DMEt7YnY5kZcQ2URwvNNrqh1lnaGQIEcTuypZnnJzRL3aXCTk7q6wQ9+wFU
	CF/cdxx6JWVuetxjaHz+FUfcOtCU5qCpMQBM6udpS9WF1BUmDzeZuBPPMVKUK5EJxiMAFs3TG4s
	XXgyoFK8HjFpxZWG/xy1Fu4G/85ZUKt0r0Cp7eDRZ1JnZ3tIk8DkLRXA4myC1uA1xyWe7QRvgK8
	nx//BVxE57tz6h30efATqr7//2XxbFEJQ7hcQKOw5cmsgMPdK3Hvtsg7/0XJnn20CGMvY0FExl3
	BVR7M9YYJXfohZ/Jz2zXfDxqxrQ4lFaL9jMqqqj13rz2FKJZG0RiN1qA5nFxdUy0Q+dCKwOiVKR
	wnkW/D6mbxc1w3w==
X-Google-Smtp-Source: AGHT+IHzuNMWICB1FM4QDZ/ppAnASXDHHwOSIgNZHwXP+gll20SBH910lX8ibFhrkIwk1DipdDkhmQ==
X-Received: by 2002:a05:6512:1396:b0:553:37e7:867c with SMTP id 2adb3069b0e04-5550b8d15b8mr5022270e87.50.1751308572272;
        Mon, 30 Jun 2025 11:36:12 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.230.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b255a51sm1530793e87.88.2025.06.30.11.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:36:12 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH 3/4] pNFS: Add prepare commit trace to block/scsi layout
Date: Mon, 30 Jun 2025 21:35:28 +0300
Message-ID: <20250630183537.196479-4-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630183537.196479-1-sergeybashirov@gmail.com>
References: <20250630183537.196479-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dprintk with trace event in ext_tree_prepare_commit() function.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfs/blocklayout/extent_tree.c |  6 +++---
 fs/nfs/nfs4trace.c               |  1 +
 fs/nfs/nfs4trace.h               | 34 ++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent_tree.c
index faccd5caa149..315949a7e92d 100644
--- a/fs/nfs/blocklayout/extent_tree.c
+++ b/fs/nfs/blocklayout/extent_tree.c
@@ -6,6 +6,7 @@
 #include <linux/vmalloc.h>
 
 #include "blocklayout.h"
+#include "../nfs4trace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PNFS_LD
 
@@ -637,8 +638,6 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 	__be32 *start_p;
 	int ret;
 
-	dprintk("%s enter\n", __func__);
-
 	arg->layoutupdate_page = alloc_page(GFP_NOFS);
 	if (!arg->layoutupdate_page)
 		return -ENOMEM;
@@ -685,7 +684,8 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 		}
 	}
 
-	dprintk("%s found %zu ranges\n", __func__, count);
+	trace_bl_ext_tree_prepare_commit(ret, count,
+			arg->lastbytewritten, !!ret);
 	return ret;
 }
 
diff --git a/fs/nfs/nfs4trace.c b/fs/nfs/nfs4trace.c
index 389941ccc9c9..3caa0720ef68 100644
--- a/fs/nfs/nfs4trace.c
+++ b/fs/nfs/nfs4trace.c
@@ -31,6 +31,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_read_error);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_write_error);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_commit_error);
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(bl_ext_tree_prepare_commit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_reg);
 EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_reg_err);
 EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_unreg);
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index deab4c0e21a0..9b1c5e7f3e9c 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2163,6 +2163,40 @@ TRACE_EVENT(ff_layout_commit_error,
 		)
 );
 
+TRACE_EVENT(bl_ext_tree_prepare_commit,
+		TP_PROTO(
+			int ret,
+			size_t count,
+			u64 lwb,
+			bool not_all_ranges
+		),
+
+		TP_ARGS(ret, count, lwb, not_all_ranges),
+
+		TP_STRUCT__entry(
+			__field(int, ret)
+			__field(size_t, count)
+			__field(u64, lwb)
+			__field(bool, not_all_ranges)
+		),
+
+		TP_fast_assign(
+			__entry->ret = ret;
+			__entry->count = count;
+			__entry->lwb = lwb;
+			__entry->not_all_ranges = not_all_ranges;
+		),
+
+		TP_printk(
+			"ret=%d, found %zu ranges, lwb=%llu%s",
+			__entry->ret,
+			__entry->count,
+			__entry->lwb,
+			__entry->not_all_ranges ? ", not all ranges encoded" :
+						  ""
+		)
+);
+
 DECLARE_EVENT_CLASS(pnfs_bl_pr_key_class,
 	TP_PROTO(
 		const struct block_device *bdev,
-- 
2.43.0


