Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681504455CA
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Nov 2021 15:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhKDPAI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Nov 2021 11:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhKDPAH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Nov 2021 11:00:07 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F379C061714
        for <linux-nfs@vger.kernel.org>; Thu,  4 Nov 2021 07:57:29 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id i12so6415535ila.12
        for <linux-nfs@vger.kernel.org>; Thu, 04 Nov 2021 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aHj+KkDaysdYnyxwY/EhiY2zyJowRkz3pBrEozVC1QA=;
        b=R6ndz/xSBUUn/rrWHZCRenY7YjQ0JSEQVfkhdc2lW49DbLDLwK2szORoT1aYxAcDuA
         BAXwBKU1cAXAZnkKbXg2/fmlVeVi2rcVGprJj9EFa+Q22aHjhdajISG9qkN35LEDfoaw
         CjNgmIqlkvWpSVKfWixoEF9grWZP/qaHhNMBEA4E35qiUL/pPgefzvOnNGcPE0pKJd38
         Q+Dr0lXmwPqnSxtW34UZHZhDtICml7oaUBZ2x5i1Gi7FMqUA64a5dG1JZoAy9vK8TCwK
         l2SwsS1kQq9JeJRTWr75pC7/UJOResWY8zMkrui2xky4zGHaDZvYizqf19Vx1MxzRmwt
         EUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aHj+KkDaysdYnyxwY/EhiY2zyJowRkz3pBrEozVC1QA=;
        b=CR64IAPvpD0uPeMRTL0ohYWximx0ZUBnVPed8wSKhwvNOf/rm+7TnmB6irYl2+P3Do
         ymxjgvJs7PTkdQpA0upoYZ9RYVkrr3Wu85x8ueuI21c23lfLlKEf5mkHBIevmZvDmgO2
         DkTk1IDd6MmsRDksulA3h90K4y6O54QzKGxLf6tPWiuEPD+WQHhcDBSFq009406cquMK
         j+7rTf52LzaNNUOfAx8O1zhn/HxNsVmtb1C9ctvFlplphFgPHs+IFgCWq1CAxrA3zGyV
         5XlckXJS5U9mmyBqjZf4EZfdPSV8WL9vFaT8XA/RR3t3AjGhtFPZU1tsHWG7Bh3H/BCV
         Mu9A==
X-Gm-Message-State: AOAM533T5XeSDZaM2F3oHJjWrubZLxcHfHn7ILGpb9eTrnj3PfLL+p+C
        eFrBx/37YSL7KtKkEvggoRo=
X-Google-Smtp-Source: ABdhPJwLMmoXsR5ed2/S8vuNkO09MwuFeTC+ED/fIGzF00+QvkF72aQQcDHUXkicS48ubtOTihmSRw==
X-Received: by 2002:a92:c08d:: with SMTP id h13mr27664566ile.60.1636037848868;
        Thu, 04 Nov 2021 07:57:28 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:886c:a169:fafb:e7cf])
        by smtp.gmail.com with ESMTPSA id c12sm3007157ils.31.2021.11.04.07.57.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Nov 2021 07:57:27 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        chuck.level@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 6/7] NFSv4.2 add tracepoint to COPY_NOTIFY
Date:   Thu,  4 Nov 2021 10:57:13 -0400
Message-Id: <20211104145714.57942-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
References: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a tracepoint to COPY_NOTIFY operation.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c |  1 +
 fs/nfs/nfs4trace.h | 58 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index d3d9ea71702f..7c7399b10050 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -603,6 +603,7 @@ static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
 
 	status = nfs4_call_sync(src_server->client, src_server, &msg,
 				&args->cna_seq_args, &res->cnr_seq_res, 0);
+	trace_nfs4_copy_notify(file_inode(src), args, res, status);
 	if (status == -ENOTSUPP)
 		src_server->caps &= ~NFS_CAP_COPY_NOTIFY;
 
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index f971e38a6e3a..f337a25c67b3 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -243,7 +243,6 @@ TRACE_EVENT(nfs4_cb_offload,
 			show_nfs_stable_how(__entry->cb_how)
 		)
 );
-
 #endif /* CONFIG_NFS_V4_1 */
 
 TRACE_EVENT(nfs4_setup_sequence,
@@ -2407,6 +2406,63 @@ TRACE_EVENT(nfs4_clone,
 			__entry->len
 		)
 );
+
+TRACE_EVENT(nfs4_copy_notify,
+		TP_PROTO(
+			const struct inode *inode,
+			const struct nfs42_copy_notify_args *args,
+			const struct nfs42_copy_notify_res *res,
+			int error
+		),
+
+		TP_ARGS(inode, args, res, error),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(u32, fhandle)
+			__field(u32, fileid)
+			__field(dev_t, dev)
+			__field(int, stateid_seq)
+			__field(u32, stateid_hash)
+			__field(int, res_stateid_seq)
+			__field(u32, res_stateid_hash)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+
+			__entry->fileid = nfsi->fileid;
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fhandle = nfs_fhandle_hash(args->cna_src_fh);
+			__entry->stateid_seq =
+				be32_to_cpu(args->cna_src_stateid.seqid);
+			__entry->stateid_hash =
+				nfs_stateid_hash(&args->cna_src_stateid);
+			if (error) {
+				__entry->error = -error;
+				__entry->res_stateid_seq = 0;
+				__entry->res_stateid_hash = 0;
+			} else {
+				__entry->error = 0;
+				__entry->res_stateid_seq =
+					be32_to_cpu(res->cnr_stateid.seqid);
+				__entry->res_stateid_hash =
+					nfs_stateid_hash(&res->cnr_stateid);
+			}
+		),
+
+		TP_printk(
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"stateid=%d:0x%08x res_stateid=%d:0x%08x",
+			-__entry->error,
+			show_nfs4_status(__entry->error),
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			__entry->stateid_seq, __entry->stateid_hash,
+			__entry->res_stateid_seq, __entry->res_stateid_hash
+		)
+);
 #endif /* CONFIG_NFS_V4_2 */
 
 #endif /* CONFIG_NFS_V4_1 */
-- 
2.27.0

