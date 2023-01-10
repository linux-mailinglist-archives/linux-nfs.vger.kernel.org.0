Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CBB664BAB
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 19:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbjAJSxB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 13:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbjAJSwL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 13:52:11 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B685565B
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 10:46:48 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id r9so96107oie.13
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 10:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwlCVwVR0CwHdU5OHrWAtUU+rFIl2PxoPz5eAnDmMww=;
        b=RAe94LwjN8wvsTqTdH+EFu/jt+VejGal2hqatZN83cAHcao0zxrYn1NBoJplzuaNcp
         GdIOXwRdoeGuu2zOan/3aKRcmQWOlUCVxP3ZecHN3/zRZpU8O4dFP9w+TR3ZYXONLb3k
         xHfW0AQ/t/Xi+fOx0m91cWIoT7leAuQlbYubBEJrLPzL04QybzkRPdMO2k+AFHMsEkjB
         AcjhA2RMTRWA6YLFe2w/vasoAz3Kla6NICpe68D2tD4ZsfI6+FYX+QkZ0UIt0PC+C4IK
         RM6+4WoCtpSvZ4XUMybD7Va4w+YtOeICRle4WHl4cZ/RmihF4qLQoCtpIQPDj9G/Stx2
         DMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwlCVwVR0CwHdU5OHrWAtUU+rFIl2PxoPz5eAnDmMww=;
        b=RZ8i8Io5JkbIcnoV95psajBHDzKzfTQGtVmwwXLiMXvksQujBx8oviQIWXkQTJM7UK
         Vw2+cVs57uxKpZE4wkyKLJCEqwibC2H56as6VMupDqL2HuRA/OlAb2Uuryp6+SJyeLVT
         aAoT6LQzxUNfjjrn4k5WKFRC28qsmGWMHEOgKnnsI/KTlqD3vyDMjhE8ifrBRSgCulOH
         /aAIBUZgVzUGY5kiM5F7di21kHcz6nVHucd2Hga9XKYCEs17DwyavGccL0w0YhxhOBWC
         d+O/nL9Rs2hadmNgJwE20Tou7rS9XObWAfavtqmY3hPiop0M5SwYKQ9EagANxEm3bYxc
         4oXQ==
X-Gm-Message-State: AFqh2kqlrOC2xR/Hd3gGdIA7+5YdYGDW5PixEb8c0wL5haflJWnATEaB
        o1DPn9qzM2DPxHN8xILT1Yg/VeVUw9M=
X-Google-Smtp-Source: AMrXdXsankG5uoNUWT1YwfqBpRkqoJWUm143C49qgS/jed5Hmi0o3TSKC4rooTvQb8qVjt7DLkuN7g==
X-Received: by 2002:a05:6808:13d6:b0:35e:acd7:99d6 with SMTP id d22-20020a05680813d600b0035eacd799d6mr36956379oiw.9.1673376407393;
        Tue, 10 Jan 2023 10:46:47 -0800 (PST)
Received: from localhost.localdomain (cpe-24-28-172-218.elp.res.rr.com. [24.28.172.218])
        by smtp.gmail.com with ESMTPSA id t11-20020a9d590b000000b00677714a440fsm6438775oth.81.2023.01.10.10.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:46:46 -0800 (PST)
From:   Jorge Mora <jmora1300@gmail.com>
X-Google-Original-From: Jorge Mora <mora@netapp.com>
To:     linux-nfs@vger.kernel.org
Cc:     trond.myklebust@hammerspace.com, Anna.Schumaker@netapp.com
Subject: [PATCH v1 2/2] NFSv4.2 add tracepoint to IO_ADVISE
Date:   Tue, 10 Jan 2023 11:46:41 -0700
Message-Id: <20230110184641.13334-3-mora@netapp.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230110184641.13334-1-mora@netapp.com>
References: <20230110184641.13334-1-mora@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a tracepoint to the IO_ADVISE operation.

Signed-off-by: Jorge Mora <mora@netapp.com>
---
 fs/nfs/nfs42proc.c |  1 +
 fs/nfs/nfs4trace.h | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index af40f705386a..8f6ad08c7f99 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -205,6 +205,7 @@ static loff_t _nfs42_proc_io_advise(struct file *filep,
 
 	status = nfs4_call_sync(server->client, server, &msg,
 				&args.seq_args, &res.seq_res, 0);
+	trace_nfs4_io_advise(inode, &args, &res, status);
 	if (status == -ENOTSUPP)
 		server->caps &= ~NFS_CAP_IO_ADVISE;
 	return status;
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index e3fbdc8a98eb..e936b0bbebc6 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2170,6 +2170,81 @@ TRACE_EVENT(nfs4_llseek,
 		)
 );
 
+#define show_nfs4_io_advise_hints(hints) \
+	__print_flags(hints, "|", \
+		{ NFS_IO_ADVISE4_NORMAL,			"NORMAL" }, \
+		{ NFS_IO_ADVISE4_SEQUENTIAL,			"SEQUENTIAL" }, \
+		{ NFS_IO_ADVISE4_SEQUENTIAL_BACKWARDS,		"SEQUENTIAL_BACKWARDS" }, \
+		{ NFS_IO_ADVISE4_RANDOM,			"RANDOM" }, \
+		{ NFS_IO_ADVISE4_WILLNEED,			"WILLNEED" }, \
+		{ NFS_IO_ADVISE4_WILLNEED_OPPORTUNISTIC,	"WILLNEED_OPPORTUNISTIC" }, \
+		{ NFS_IO_ADVISE4_DONTNEED,			"DONTNEED" }, \
+		{ NFS_IO_ADVISE4_NOREUSE,			"NOREUSE" }, \
+		{ NFS_IO_ADVISE4_READ,				"READ" }, \
+		{ NFS_IO_ADVISE4_WRITE,				"WRITE" }, \
+		{ NFS_IO_ADVISE4_INIT_PROXIMITY,		"INIT_PROXIMITY" })
+
+TRACE_EVENT(nfs4_io_advise,
+		TP_PROTO(
+			const struct inode *inode,
+			const struct nfs42_io_advise_args *args,
+			const struct nfs42_io_advise_res *res,
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
+			__field(loff_t, offset)
+			__field(u64, count)
+			__field(u32, arg_hints)
+			__field(u32, res_hints)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = args->fh;
+
+			__entry->fileid = nfsi->fileid;
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fhandle = nfs_fhandle_hash(fh);
+			__entry->stateid_seq = be32_to_cpu(args->stateid.seqid);
+			__entry->stateid_hash = nfs_stateid_hash(&args->stateid);
+			__entry->offset = args->offset;
+			__entry->count = args->count;
+			__entry->arg_hints = args->hints;
+			if (error) {
+				__entry->error = -error;
+				__entry->res_hints = 0;
+			} else {
+				__entry->error = 0;
+				__entry->res_hints = res->hints;
+			}
+		),
+
+		TP_printk(
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"stateid=%d:0x%08x offset=%llu count=%llu "
+			"arg_hints=%s res_hints=%s",
+			-__entry->error,
+			show_nfs4_status(__entry->error),
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			__entry->stateid_seq, __entry->stateid_hash,
+			__entry->offset,
+			__entry->count,
+			show_nfs4_io_advise_hints(__entry->arg_hints),
+			show_nfs4_io_advise_hints(__entry->res_hints)
+		)
+);
+
 DECLARE_EVENT_CLASS(nfs4_sparse_event,
 		TP_PROTO(
 			const struct inode *inode,
-- 
2.31.1

