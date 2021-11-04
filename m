Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDF24455C5
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Nov 2021 15:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKDO76 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Nov 2021 10:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhKDO76 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Nov 2021 10:59:58 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C87C061714
        for <linux-nfs@vger.kernel.org>; Thu,  4 Nov 2021 07:57:20 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h23so6446467ila.4
        for <linux-nfs@vger.kernel.org>; Thu, 04 Nov 2021 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4tAxnw/v2l2V3KwJcHJCQQ+ZoVxVjSCmPO+OTALYGGM=;
        b=nEZZgoQfb6phY5wGzZqFG17Uw3mv3l/3MD9w+cQSbTlPIBXJnpS2J9Vwx/iKUQH8Eg
         TpRpBVr4pHlcUBgkhWr0fjaPPU/xIjMzAVHqBwTknxTWC2+eiv/I2JuRmRyFmTESMIvL
         C0P8n4WFdULreycdDnxAVfSfcWkAht03/RxNGDpTYDqSUzw6XALfVi39vJejT/48VhJs
         MCzEh4tGnQVwwXf1yD3YoRNuf6Weeri4RDI6qxAgYGsZ/G2EjewBrkzgLCftmxQfUYSJ
         fTahPEEe3SGW0Csq2EK3GypH+7Boz4ZW3p9gKm6T/DgaBFJu9Pyg42UslsIISk7qy5AF
         TyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4tAxnw/v2l2V3KwJcHJCQQ+ZoVxVjSCmPO+OTALYGGM=;
        b=DRD5ctGNZH9AACVQqWh5uOrhMe6kttXlwd4NIpJFSpFBiB4tAK1NsdmmN3wOaSfOI9
         pgrAEv7FXTqtw/JINYnM5xP4xafMlJUvMqEfzf+bVVKLXDPEUf2CAJa1et2i9Icfdwr5
         FOSCSCe/U73eCTmxSyvBPzIn+xwGrtIt95jkf6xB+TSyfynEoh21+hBfAPqBIcnMyWpk
         VHL62Ym2NjMFbvE5g4HsHKhHQesAT01Vcaj+SKbiiRzVraDvucEGSRnbL1wLg3Ulo4Q+
         CN+SKraMMtDAwsuAsuHceOIoSXwtzH41XvVbelR50ehQuGAC5710QVxGRCdGVJpXGHlY
         RguQ==
X-Gm-Message-State: AOAM530++RSrEeoTm1WulqwEVGQgtXJt08YBJ+ZPZaVHvBWxE5agfX/l
        Oow9Wm7j0+XPi1XgKE4HZMbT+PN3BJH3IQ==
X-Google-Smtp-Source: ABdhPJxM+7JsoKn8T+ElU969BTY0D/qJ9yqhutAtg1R34RBphw+GMPUePno7C7IUlK/JH0nCTAgzEA==
X-Received: by 2002:a92:d411:: with SMTP id q17mr20896086ilm.116.1636037839500;
        Thu, 04 Nov 2021 07:57:19 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:886c:a169:fafb:e7cf])
        by smtp.gmail.com with ESMTPSA id c12sm3007157ils.31.2021.11.04.07.57.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Nov 2021 07:57:18 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        chuck.level@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/7] NFSv4.2 add tracepoints to FALLOCATE and DEALLOCATE
Date:   Thu,  4 Nov 2021 10:57:09 -0400
Message-Id: <20211104145714.57942-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
References: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a tracepoint to the FALLOCATE/DEALLOCATE operations.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c |  4 ++++
 fs/nfs/nfs4trace.h | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 87c0dcb8823b..c36824888601 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -83,6 +83,10 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 		status = nfs_post_op_update_inode_force_wcc(inode,
 							    res.falloc_fattr);
 
+	if (msg->rpc_proc == &nfs4_procedures[NFSPROC4_CLNT_ALLOCATE])
+		trace_nfs4_fallocate(inode, &args, status);
+	else
+		trace_nfs4_deallocate(inode, &args, status);
 	kfree(res.falloc_fattr);
 	return status;
 }
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 823ac436a1da..a88464238b88 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2127,6 +2127,62 @@ TRACE_EVENT(nfs4_llseek,
 		)
 );
 
+DECLARE_EVENT_CLASS(nfs4_sparse_event,
+		TP_PROTO(
+			const struct inode *inode,
+			const struct nfs42_falloc_args *args,
+			int error
+		),
+
+		TP_ARGS(inode, args, error),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(loff_t, offset)
+			__field(loff_t, len)
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(int, stateid_seq)
+			__field(u32, stateid_hash)
+		),
+
+		TP_fast_assign(
+			__entry->error = error < 0 ? -error : 0;
+			__entry->offset = args->falloc_offset;
+			__entry->len = args->falloc_length;
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = NFS_FILEID(inode);
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
+			__entry->stateid_seq =
+				be32_to_cpu(args->falloc_stateid.seqid);
+			__entry->stateid_hash =
+				nfs_stateid_hash(&args->falloc_stateid);
+		),
+
+		TP_printk(
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"stateid=%d:0x%08x offset=%llu len=%llu",
+			-__entry->error,
+			show_nfs4_status(__entry->error),
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			__entry->stateid_seq, __entry->stateid_hash,
+			(long long)__entry->offset,
+			(long long)__entry->len
+		)
+);
+#define DEFINE_NFS4_SPARSE_EVENT(name) \
+	DEFINE_EVENT(nfs4_sparse_event, name, \
+			TP_PROTO( \
+				const struct inode *inode, \
+				const struct nfs42_falloc_args *args, \
+				int error \
+			), \
+			TP_ARGS(inode, args, error))
+DEFINE_NFS4_SPARSE_EVENT(nfs4_fallocate);
+DEFINE_NFS4_SPARSE_EVENT(nfs4_deallocate);
 #endif /* CONFIG_NFS_V4_2 */
 
 #endif /* CONFIG_NFS_V4_1 */
-- 
2.27.0

