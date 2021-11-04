Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E142A4455CB
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Nov 2021 15:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhKDPAJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Nov 2021 11:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhKDPAI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Nov 2021 11:00:08 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E712C061714
        for <linux-nfs@vger.kernel.org>; Thu,  4 Nov 2021 07:57:30 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id j28so6455948ila.1
        for <linux-nfs@vger.kernel.org>; Thu, 04 Nov 2021 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjWWHMx05nyI41glpjb83c/ixWOqf5zmv65wzd4pvU0=;
        b=RhRBErrrhPrP6+4H6DalvxxBs9UtV5xLaSJzSQF9Wuk2ZBj/LizevI9qP/hvlFfXsi
         aQSNkxqSmlqQD7qQhEGOr1CA2mIMzDQnkFGJUYvDZRDzmT3n6ukW5adqYt+3empjteer
         /C+gKR4kmpWa/wiQKpcCoc3YVfSKkkYfnFl+Le5KS4Uq/msgRWaK37Xqa2sXep2rjkcl
         ZxqWwlawDQTG18UfWwsZr0hR4wtiQV5xf19Gkd8yOOnCSTtss2w0q26eZlhKP/8w0kuw
         +ue2+MAoDuMnRgw5QXx5MFf+v7XClyrSpb7N815VPlNewYpp/6M/sOYkueNUkRg/ISi9
         7auQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjWWHMx05nyI41glpjb83c/ixWOqf5zmv65wzd4pvU0=;
        b=cDPUclsA7g364PTSL2MleqQ9T+zo3nEeSqGxXdx0ZcrTclfgZQRwmTewfL/RRfCPcF
         +i41S6fmYnEeH/4aGE9ztrtHAYm/g2xfy5bweSCX4Wkc8VJ1oFgE5wB7adrkoZRdVwbK
         lt9wB1rsR+nDG0HolYaewpCRM8gS6sE2+pLfP+htGGEkMnkf7NExt5ROg9jXU8rAEhRy
         MVGJso8lfIZ/zJzxRxZK2QoHjcX0pkLCGQQdvwJ7PVpJsmQSGtdcXSbOUkbaHtwnHFxx
         kZWDraNT4rXovi/nOaStJ5cFiuK7P7zHO3SNx85ZoQ1A/0rQkn5PQsD/aMi8X84iGy3J
         4vOw==
X-Gm-Message-State: AOAM532LHJsFDboRGzDbhh7b9jDjxW8HncxJ3+1W5rdrQF5opCUoJrEg
        kMJn2bSEcm2t5GL7ADlZ23j3/F/qzBN2Sw==
X-Google-Smtp-Source: ABdhPJxN5cTcY2/pagu2dVUjbFZMVovJcFR3hXAkWBdn/0V3e9y1UzXsMGu1uy3NyavOx1+BFBkqVg==
X-Received: by 2002:a05:6e02:12e5:: with SMTP id l5mr12919449iln.36.1636037849992;
        Thu, 04 Nov 2021 07:57:29 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:886c:a169:fafb:e7cf])
        by smtp.gmail.com with ESMTPSA id c12sm3007157ils.31.2021.11.04.07.57.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Nov 2021 07:57:29 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        chuck.level@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 7/7] NFSv4.2 add tracepoint to OFFLOAD_CANCEL
Date:   Thu,  4 Nov 2021 10:57:14 -0400
Message-Id: <20211104145714.57942-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
References: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add tracepoint to OFFLOAD_CANCEL operation.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c |  1 +
 fs/nfs/nfs4trace.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 7c7399b10050..08355b66e7cb 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -509,6 +509,7 @@ static void nfs42_offload_cancel_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs42_offloadcancel_data *data = calldata;
 
+	trace_nfs4_offload_cancel(&data->args, task->tk_status);
 	nfs41_sequence_done(task, &data->res.osr_seq_res);
 	if (task->tk_status &&
 		nfs4_async_handle_error(task, data->seq_server, NULL,
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index f337a25c67b3..6ee6ad3674a2 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2463,6 +2463,39 @@ TRACE_EVENT(nfs4_copy_notify,
 			__entry->res_stateid_seq, __entry->res_stateid_hash
 		)
 );
+
+TRACE_EVENT(nfs4_offload_cancel,
+		TP_PROTO(
+			const struct nfs42_offload_status_args *args,
+			int error
+		),
+
+		TP_ARGS(args, error),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(u32, fhandle)
+			__field(int, stateid_seq)
+			__field(u32, stateid_hash)
+		),
+
+		TP_fast_assign(
+			__entry->fhandle = nfs_fhandle_hash(args->osa_src_fh);
+			__entry->error = error < 0 ? -error : 0;
+			__entry->stateid_seq =
+				be32_to_cpu(args->osa_stateid.seqid);
+			__entry->stateid_hash =
+				nfs_stateid_hash(&args->osa_stateid);
+		),
+
+		TP_printk(
+			"error=%ld (%s) fhandle=0x%08x stateid=%d:0x%08x",
+			-__entry->error,
+			show_nfs4_status(__entry->error),
+			__entry->fhandle,
+			__entry->stateid_seq, __entry->stateid_hash
+		)
+);
 #endif /* CONFIG_NFS_V4_2 */
 
 #endif /* CONFIG_NFS_V4_1 */
-- 
2.27.0

