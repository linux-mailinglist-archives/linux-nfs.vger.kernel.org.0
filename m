Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC97F5F34BB
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 19:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJCRoq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 13:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJCRom (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 13:44:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC1E316
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 10:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 014A761189
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 17:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17251C433D7;
        Mon,  3 Oct 2022 17:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664819075;
        bh=pwUwM5u8duBV7zxnFPO2/x3SgczSF72eJmMc09T5tQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bs0xThLEwEQQ+G/GZwsN43OQd8KjkWtJ/ZRQBGSEXqpb6rVtT8l0dCd4AqjwLTTrX
         1pCqwR1Nlk/98ohq/+Nty24FUrvRbI5YzknQwknywT3oHctmnzfCa8wEeIzuWDb4RX
         R1VM/ycAQjZVJcutgzqkwJgmMReBKM6xV7XRek3MLODg95TwvW5rkMeaS2isiBGXLn
         mYWkTT64P1AvWpu7tTULaE4Hosr0MsskMdtdIkw7ITyg7/+WQgZOMppvOwsNbty47j
         QxG36chzD+qgCGtnWTy48abLoH4EAl7udBGW1M3CkyxqZggxHYQjlJdM1fzUu64RrK
         /xsYsD6qa9YAQ==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH 2/3] NFSv4.2: Add tracepoints for getxattr, setxattr, and removexattr
Date:   Mon,  3 Oct 2022 13:44:32 -0400
Message-Id: <20221003174433.476685-2-anna@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221003174433.476685-1-anna@kernel.org>
References: <20221003174433.476685-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These functions take similar arguments, and can share a tracepoint class
for common formatting.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42proc.c |  3 +++
 fs/nfs/nfs4trace.h | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 6dab9e408372..c4791ca00df1 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1175,6 +1175,7 @@ static int _nfs42_proc_removexattr(struct inode *inode, const char *name)
 
 	ret = nfs4_call_sync(server->client, server, &msg, &args.seq_args,
 	    &res.seq_res, 1);
+	trace_nfs4_removexattr(inode, name, ret);
 	if (!ret)
 		nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
 
@@ -1214,6 +1215,7 @@ static int _nfs42_proc_setxattr(struct inode *inode, const char *name,
 
 	ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
 	    &res.seq_res, 1);
+	trace_nfs4_setxattr(inode, name, ret);
 
 	for (; np > 0; np--)
 		put_page(pages[np - 1]);
@@ -1246,6 +1248,7 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
 
 	ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
 	    &res.seq_res, 0);
+	trace_nfs4_getxattr(inode, name, ret);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 37c4c105ed29..650c9353826f 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2496,6 +2496,52 @@ TRACE_EVENT(nfs4_offload_cancel,
 			__entry->stateid_seq, __entry->stateid_hash
 		)
 );
+
+DECLARE_EVENT_CLASS(nfs4_xattr_event,
+		TP_PROTO(
+			const struct inode *inode,
+			const char *name,
+			int error
+		),
+
+		TP_ARGS(inode, name, error),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__string(name, name)
+		),
+
+		TP_fast_assign(
+			__entry->error = error < 0 ? -error : 0;
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = NFS_FILEID(inode);
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
+			__assign_str(name, name);
+		),
+
+		TP_printk(
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"name=%s",
+			-__entry->error, show_nfs4_status(__entry->error),
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __get_str(name)
+		)
+);
+#define DEFINE_NFS4_XATTR_EVENT(name) \
+	DEFINE_EVENT(nfs4_xattr_event, name,  \
+			TP_PROTO( \
+				const struct inode *inode, \
+				const char *name, \
+				int error \
+			), \
+			TP_ARGS(inode, name, error))
+DEFINE_NFS4_XATTR_EVENT(nfs4_getxattr);
+DEFINE_NFS4_XATTR_EVENT(nfs4_setxattr);
+DEFINE_NFS4_XATTR_EVENT(nfs4_removexattr);
 #endif /* CONFIG_NFS_V4_2 */
 
 #endif /* CONFIG_NFS_V4_1 */
-- 
2.37.3

