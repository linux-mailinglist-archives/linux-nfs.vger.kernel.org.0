Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200A64455C9
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Nov 2021 15:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhKDPAF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Nov 2021 11:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhKDPAE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Nov 2021 11:00:04 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE945C061714
        for <linux-nfs@vger.kernel.org>; Thu,  4 Nov 2021 07:57:26 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id k1so6435967ilo.7
        for <linux-nfs@vger.kernel.org>; Thu, 04 Nov 2021 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RwnNqgv9ccoYl352WSb+exKQaGiQEt1N3MQu3C5Jlck=;
        b=LI7AiAHOb3Q0DDMlSV3EV0wTB7WmzCMk450QGfA93vLGdi1kZ2XsokTg4Tnc08aE2o
         /nb7N6J1mJtdot6FXf8azjxAAjkqeXPX8tjQhkkARnxQ6DeGKsL1Tkb/39Zye2I9NcmA
         khzlX7w7mHIYiEpjj8EACFa3nAqHYVpUOIBWZMAJxGp6frrnuGu6rlfW4iOy6TrzvcGj
         deyNbAUIXVlGHL6aTS8MGo3MhwY/bsrvoqDFXORgoB5slFg8wJWoTv5gylK2Eld0gfh2
         +G4LSbj5m0/Wj14AvePZjzBjMg7y5mmsnrYL5nCH9lKzmX/IFDEhdbgXWNrw9SpUuu10
         hMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RwnNqgv9ccoYl352WSb+exKQaGiQEt1N3MQu3C5Jlck=;
        b=rRZawLnxA6LrSCRqCScSfuk994jdU+rYHy+rZLZX3MCpf5xqS/WalRiaN4lSBDp/yZ
         Kh2wQVbLVfJhbFOKKDRoDa1AtUi/+AWWAzgUt+1oeWJKrxGhGtwnMfzIemTGHqvZQX5L
         xQF2CM0queH4mNIaj0/E8Tw+wpln9EqN9nQ6qY0nHJ/v1bera7jubs5v/hPLTy2btBf8
         EGEaeLXfu/CSp8wbUE/LQLTXEWDv0gJYVSwFfSpOuguF6Eo8SyPsE8FRclMzEWyWg0uB
         GfaVisR245GO/dv2LAUTYpSkRypejjcAJAWGQsfaIlC6mLK6T7AVIHK+GyCZ68lb7/Cl
         Xdcw==
X-Gm-Message-State: AOAM530QBshDjpFcrc3Wv1xFJJJcmabdvHrbpIsb1+VMzo2LBRCSzqq0
        DAMT4xlC8uRLOAxdiNRdJWo=
X-Google-Smtp-Source: ABdhPJwVe6Xnu9OYu5YnMFNrKfjf3D/tXK8IR9rI88XKwPQFLQNDS+sNZPZFsesL9FB2QCdpMOJ1Rw==
X-Received: by 2002:a92:6f0c:: with SMTP id k12mr28772988ilc.240.1636037846255;
        Thu, 04 Nov 2021 07:57:26 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:886c:a169:fafb:e7cf])
        by smtp.gmail.com with ESMTPSA id c12sm3007157ils.31.2021.11.04.07.57.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Nov 2021 07:57:25 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        chuck.level@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 5/7] NFSv4.2 add tracepoint to CB_OFFLOAD
Date:   Thu,  4 Nov 2021 10:57:12 -0400
Message-Id: <20211104145714.57942-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
References: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a tracepoint to the CB_OFFLOAD operation.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/callback_proc.c |  3 +++
 fs/nfs/nfs4trace.h     | 44 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index ed9d580826f5..09c5b1cb3e07 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -739,6 +739,9 @@ __be32 nfs4_callback_offload(void *data, void *dummy,
 		kfree(copy);
 	spin_unlock(&cps->clp->cl_lock);
 
+	trace_nfs4_cb_offload(&args->coa_fh, &args->coa_stateid,
+			args->wr_count, args->error,
+			args->wr_writeverf.committed);
 	return 0;
 }
 #endif /* CONFIG_NFS_V4_2 */
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index af7e59aa9265..f971e38a6e3a 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -200,6 +200,50 @@ TRACE_EVENT(nfs4_cb_seqid_err,
 		)
 );
 
+TRACE_EVENT(nfs4_cb_offload,
+		TP_PROTO(
+			const struct nfs_fh *cb_fh,
+			const nfs4_stateid *cb_stateid,
+			uint64_t cb_count,
+			int cb_error,
+			int cb_how_stable
+		),
+
+		TP_ARGS(cb_fh, cb_stateid, cb_count, cb_error,
+			cb_how_stable),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(u32, fhandle)
+			__field(loff_t, cb_count)
+			__field(int, cb_how)
+			__field(int, cb_stateid_seq)
+			__field(u32, cb_stateid_hash)
+		),
+
+		TP_fast_assign(
+			__entry->error = cb_error < 0 ? -cb_error : 0;
+			__entry->fhandle = nfs_fhandle_hash(cb_fh);
+			__entry->cb_stateid_seq =
+				be32_to_cpu(cb_stateid->seqid);
+			__entry->cb_stateid_hash =
+				nfs_stateid_hash(cb_stateid);
+			__entry->cb_count = cb_count;
+			__entry->cb_how = cb_how_stable;
+		),
+
+		TP_printk(
+			"error=%ld (%s) fhandle=0x%08x cb_stateid=%d:0x%08x "
+			"cb_count=%llu cb_how=%s",
+			-__entry->error,
+			show_nfs4_status(__entry->error),
+			__entry->fhandle,
+			__entry->cb_stateid_seq, __entry->cb_stateid_hash,
+			__entry->cb_count,
+			show_nfs_stable_how(__entry->cb_how)
+		)
+);
+
 #endif /* CONFIG_NFS_V4_1 */
 
 TRACE_EVENT(nfs4_setup_sequence,
-- 
2.27.0

