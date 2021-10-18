Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F41143297F
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 00:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhJRWFn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Oct 2021 18:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhJRWFm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Oct 2021 18:05:42 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4540C061745
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:30 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id y11so16581226qtn.13
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bw7tmYKLruf/dsxGuWamVdY8tQo68VyJ6WeC6ofKfjU=;
        b=itiK3I+DNzeiPMizvBjMOO/PBDgMD0dxJIycyC7cGo1WYT3LrTBNfSbHLFqUe2m2jT
         yd/QzK5low5hcmzSt/oQnSQwfRpqSJ/bk5J/O7pWuveIvLgciGiob0Q+9eK6T6Gq9TKQ
         65GV2uIqGev360XaiN4f91SW+amab8NbvXjwzDMQDPEN3EG+9dj5v6ut7Fo1+1SdzcHO
         WLvSNmLTpG1Ht9JjQvQpd1ByvX5QHunwOao6Ao9CtvOvIO83v3GB7BrDuA6mASJB3yab
         BiG+0fWxWb7TYgOM0E1iK2T0QLUbfD5RZ1shx/VXBOu1a/cUZ4qX/I8U0Bi5fThaxEy9
         uthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bw7tmYKLruf/dsxGuWamVdY8tQo68VyJ6WeC6ofKfjU=;
        b=T8q06F7MeCuDOCK75VO6wR05TX0eGJv+w7vGKp29ZuEL5xCDeUteRLjtdx7jbycNpv
         re+nv/79bQie4ii4RzmNKtWvRVTQ4xXHK3ogsH/g3LSB27pTaBAHCcSc8LXZEzlYIPrT
         uHIwA6F0FlLalE3R+70rPBnvIJqGDOd/VwDwNlFg26u9rz7+0ZAiMGiuLa3PgWGYRz3j
         HLJ/1gjUhY/ecwhba9nNiyT1gskE5BVw1gFI2yR96Xek5IhlDjPJvlDfbjopkMwLbdLj
         zI7a70e5eZyyYQQWRkMXB2dTdrv2jR7x2K5aQw6JSO9fVmmzeaqtE+P0/mtQm7Tcbij7
         zLXw==
X-Gm-Message-State: AOAM5315wSGRBF6Bc4NgLkLw9h9Gea3QPerlBAwe4Q1xfgd5839JLSsT
        mra26bhzfU+BMScIbRWDDfk=
X-Google-Smtp-Source: ABdhPJym/y6SjH2OOSDLTQ8yQk8CGy+m3EER7a8n4PqW1M6M7YiagIq4SPi6tiZQjD6rOPCMfp5+VQ==
X-Received: by 2002:a05:622a:148d:: with SMTP id t13mr24761399qtx.393.1634594609884;
        Mon, 18 Oct 2021 15:03:29 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:e54f:15fc:f79a:2b96])
        by smtp.gmail.com with ESMTPSA id az14sm3352640qkb.125.2021.10.18.15.03.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 15:03:29 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 7/7] NFSv4.2 add tracepoint to OFFLOAD_CANCEL
Date:   Mon, 18 Oct 2021 18:03:14 -0400
Message-Id: <20211018220314.85115-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
References: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
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
index 2741e12746b2..476420a7985a 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2814,6 +2814,39 @@ TRACE_EVENT(nfs4_copy_notify,
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
+			show_nfsv4_errors(__entry->error),
+			__entry->fhandle,
+			__entry->stateid_seq, __entry->stateid_hash
+		)
+);
 #endif /* CONFIG_NFS_V4_1 */
 
 #endif /* _TRACE_NFS4_H */
-- 
2.27.0

