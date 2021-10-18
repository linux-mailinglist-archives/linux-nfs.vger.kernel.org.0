Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E8643297D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 00:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhJRWFm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Oct 2021 18:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRWFk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Oct 2021 18:05:40 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902C5C06161C
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:28 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id z24so16597958qtv.9
        for <linux-nfs@vger.kernel.org>; Mon, 18 Oct 2021 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGVbY1wW4HGMpJzVMxKz7eRW71dvKunfgthGA8/4uGg=;
        b=WwxVg2CecHNKrEFG8FQUyJG58/rtiRr4ntmViQpj4G+9pDET25X04r8MudAli8cemJ
         i/BiKfGr8KC9XGUgymHDjXmqkffbZNEZb5nyCefnVZ2UQK4HZmqZwOq9+NJvqPP2ghik
         yDOTR8bSG08icg8r0P2rnehsCiO8Fm36nyc1OE/RgxZIamgts9n3jl0ENOSm9uZV2GIU
         kz4b6691GKgMl3xrTRrT2ya2JY7kprpSDHLDLAs+JD3iyGXL3eXUFS6W16MtaXSk/Fii
         jFjt1exB0B2Y1iTjfMK6YM7vLNfZ7s32J6SQVmF6Eg7GT4SerNdkgbsVloHai52uxzNA
         LDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGVbY1wW4HGMpJzVMxKz7eRW71dvKunfgthGA8/4uGg=;
        b=tvWUeeTDg21y0PYUwzyvg/Wjq5iJMrRGVLSy4EotxPaXToEy8IhLQUqeCAN0aAc08v
         81gV3o4h0v1QWqDnOjWhzFFtGurXubVnleMOqLZFRDjbWjCtSyXHmQ/sABbteaetXHkR
         aydMe9MtKTmRD409Fvay6YdcIHU7acWoUBu+xcFr0tVVAUUdNrv8Mgo1Ai1a8BLoBJdC
         QcdA/mFI4qHPjoLGswxaEeCY9jLXHi4dQj1/QNVePfONZZmt8fu3JsaWlzBXXLnAefOV
         iLgSJ8rQR557HOH4rwfkc41o/xg+RlqNEk7pk0V/fucl8avTJgvawMOLcEdhsabKsypj
         +kCQ==
X-Gm-Message-State: AOAM532gnqSnJpt8ZcjTeh0LRDcuae8i1qRm9ioWhnNLI67Du/wgao0V
        TWEhgoHfVVVE4vF5mUyREzM=
X-Google-Smtp-Source: ABdhPJxJmvWj9x07gPGJ+YwFye6Z0wtS/o/buS6tWtaR6axrnAMlWmHvAmMGs4xKQZLpyeN9FRRLEw==
X-Received: by 2002:ac8:7f03:: with SMTP id f3mr32814340qtk.320.1634594607743;
        Mon, 18 Oct 2021 15:03:27 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:e54f:15fc:f79a:2b96])
        by smtp.gmail.com with ESMTPSA id az14sm3352640qkb.125.2021.10.18.15.03.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 15:03:27 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/7] NFSv4.2 add tracepoint to CB_OFFLOAD
Date:   Mon, 18 Oct 2021 18:03:12 -0400
Message-Id: <20211018220314.85115-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
References: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
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
 fs/nfs/nfs4trace.h     | 50 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

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
index cc6537a20ebe..33f52d486528 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2714,6 +2714,56 @@ TRACE_EVENT(nfs4_clone,
 		)
 );
 
+#define show_write_mode(how)			\
+        __print_symbolic(how,			\
+                { NFS_UNSTABLE, "UNSTABLE" },	\
+                { NFS_DATA_SYNC, "DATA_SYNC" },	\
+		{ NFS_FILE_SYNC, "FILE_SYNC"})
+
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
+			show_nfsv4_errors(__entry->error),
+			__entry->fhandle,
+			__entry->cb_stateid_seq, __entry->cb_stateid_hash,
+			__entry->cb_count,
+			show_write_mode(__entry->cb_how)
+		)
+);
+
 #endif /* CONFIG_NFS_V4_1 */
 
 #endif /* _TRACE_NFS4_H */
-- 
2.27.0

