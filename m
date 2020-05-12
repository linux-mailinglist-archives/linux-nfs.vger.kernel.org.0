Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86F21D007B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbgELVOI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELVOI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:14:08 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE1BC061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:14:07 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t8so6724406qvw.5
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Nzft6Vqmh5HX0svIDJb8KZdwtw+h1SAtda0ir1T51Uk=;
        b=TvVRT++NjlW//NfcecCMsK3b6UrbyoDjbnsmjTLyLsC1QkBCWSl2qJYxUAcIvEwr/i
         5ACmkhGKNsEhU7xULYp/d2UlPgIa7xvO1Vhym1RgJx3eIT07An6XxDYDdsiAc5epmd/q
         Vzmx/+Ih/gsHOpsGv9e2JBoi7nTxo2aCXk1jxMhcFSnRKi33G+WhdVUKIABZhvvtDrzN
         XfGBSHVPxgStoN8OQtJnNVcd9veLJuzOQWINdFBmDz7m2RyHH+CUFBd1mFbgOpLsIJbH
         gsjQKo9PaouPLZgtwa9Cpsv7ydWL5E59B7kgVNuhFlXbUI69pyMVIPhzZ2x3I/4onE6S
         aRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Nzft6Vqmh5HX0svIDJb8KZdwtw+h1SAtda0ir1T51Uk=;
        b=X01mz5C433XGqTlIaC7FunTdZ0CS2C8CuxaNY6mzWcR1BTnaEhBgWZnN3NFm3aZbvT
         1VpRllQBdLL3lRvSfOZ8rUZxKlMZ0NXaVVm3zBexkp5YOdaaq6utLHs/r28n5WkijA5K
         6iY66FACw+Qq5SIxXMbsWL6oCyqzVXXaTSOlQ+NJuWALc8dJH2HaWge+a3mBxDYdJwvR
         myAlsn0nh4WZnuhn5TeNix9W8ZAR2idlmL6n/zd5KOjxs0yiZLDpRZpmufmyL/ZFYLtt
         VLxTwtNSkiz/QzAid7ACVlzdIbI/6AWN23E+3sn2Q5ps405EC3JEu70VOg9DfVQ4MPNJ
         cg2Q==
X-Gm-Message-State: AGi0PuaOoOr77Tkn/s8LOr8R0oIBPQrK3VP0wA5Em1ydRtz22gALQ5EA
        l2tGgLtRq0spUGx0TWLNJPw=
X-Google-Smtp-Source: APiQypJi5yuHYflhuUdlVo1LlOdRunywy8ZK6SONP8IbsmdtNJoxZaVYLruVjSjDY3CLnt+yBmLa5g==
X-Received: by 2002:ad4:46e7:: with SMTP id h7mr12977503qvw.221.1589318047200;
        Tue, 12 May 2020 14:14:07 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e28sm11139678qka.125.2020.05.12.14.14.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:14:06 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLE5Du009833;
        Tue, 12 May 2020 21:14:05 GMT
Subject: [PATCH v1 14/15] NFS: Trace short NFS READs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:14:05 -0400
Message-ID: <20200512211405.3288.44179.stgit@manet.1015granger.net>
In-Reply-To: <20200512210724.3288.15187.stgit@manet.1015granger.net>
References: <20200512210724.3288.15187.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A short read can generate an -EIO error without there being an error
on the wire. This tracepoint acts as an eyecatcher when there is no
obvious I/O error.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfstrace.h |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/read.c     |    2 ++
 2 files changed, 49 insertions(+)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index e90651431804..b35998c5c9ca 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -961,6 +961,53 @@
 		)
 );
 
+TRACE_EVENT(nfs_readpage_short,
+		TP_PROTO(
+			const struct rpc_task *task,
+			const struct nfs_pgio_header *hdr
+		),
+
+		TP_ARGS(task, hdr),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(loff_t, offset)
+			__field(u32, arg_count)
+			__field(u32, res_count)
+			__field(bool, eof)
+			__field(int, status)
+		),
+
+		TP_fast_assign(
+			const struct inode *inode = hdr->inode;
+			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = hdr->args.fh ?
+						  hdr->args.fh : &nfsi->fh;
+
+			__entry->status = task->tk_status;
+			__entry->offset = hdr->args.offset;
+			__entry->arg_count = hdr->args.count;
+			__entry->res_count = hdr->res.count;
+			__entry->eof = hdr->res.eof;
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(fh);
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"offset=%lld count=%u res=%u status=%d%s",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			(long long)__entry->offset, __entry->arg_count,
+			__entry->res_count, __entry->status,
+			__entry->eof ? " eof" : ""
+		)
+);
+
 TRACE_DEFINE_ENUM(NFS_UNSTABLE);
 TRACE_DEFINE_ENUM(NFS_DATA_SYNC);
 TRACE_DEFINE_ENUM(NFS_FILE_SYNC);
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 13b22e898116..eb854f1f86e2 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -264,6 +264,8 @@ static void nfs_readpage_retry(struct rpc_task *task,
 
 	/* This is a short read! */
 	nfs_inc_stats(hdr->inode, NFSIOS_SHORTREAD);
+	trace_nfs_readpage_short(task, hdr);
+
 	/* Has the server at least made some progress? */
 	if (resp->count == 0) {
 		nfs_set_pgio_error(hdr, -EIO, argp->offset);

