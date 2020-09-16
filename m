Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363A426CE8A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIPWR5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgIPWR4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:17:56 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA84C061A2E
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:52 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d190so10031025iof.3
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=25pBL4LKQ8q1DweXXb8lo+1GSGfI3ts0e7EUEMUNcJE=;
        b=EAu3LBNpaS74BLEykCl6jHWHZkdCH5Akb+UTFFu4w0ZqoO3ibH8thBagLpl/OB0fGv
         EtS1FXM41eg9XMs/FuVdNMBxiVMB0nd5mdYo4llsENijfQdJOO2ia6QiwVO4Mut0EFiU
         Yg7OU/a4xprqeB4ey3Q1OudIMQEQVEMYRXPQVfXDwZKlGxSbgiEXW+5uq3BkjRkqY9yD
         3csVS60t0cqOY9uUjZvtR9FAhbSPjo2WEwd/+ntu4eiZazfIKxT9w8r6MvWJ1E2FzmxF
         rdvvaGOOMPFst/z8LSggi4wMtwZoIIWZ2EOo6cUdghXngD+hvpgPChrgS5dm2jF0Ioy4
         +SCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=25pBL4LKQ8q1DweXXb8lo+1GSGfI3ts0e7EUEMUNcJE=;
        b=tnPuq17Rk9fVcwQzkpmAe/UPvoP2I679XnxbcyR/eV2IHyE7OjHnlkCbWt4kb6bCJW
         zbR0akXZb7lX8tGMCXrUHQ57mHbdLGzvPKLl111mO+qxMlVRrmK9Q1yK4Th+bioigiIz
         57PzcV4/EOEtrv+fhMWEUPv9MhplN0dpi+uEDPX3zoiQP6L8i3Dm26yzuVYKWpAaM1o9
         ZLha4ZaJzRjDAigE4Hc/MsVhgVNieeWlowfzXBpuQwIIH3d+6OXhY3a6Q/9HMc5jBr+O
         Vt7mkyufXuP5Yf5f+uuXZNy7KsSJROVKA0mDoexAeJwDFsa9Dw4g7DunY4BN57Z0l3Cr
         xrCA==
X-Gm-Message-State: AOAM532HfKhNsTRknu376KRcILANU9+VZHTHBbFFDrhmdsIMhZty5uv6
        5i3sNMD0oxouVvnhgMUkxHU=
X-Google-Smtp-Source: ABdhPJyazCIzIN8SkO0z0as1L3IRkRGCxBpyHhENnDyzD8YoOEMx2GmydXXkexIUIKJrKmrCYkXwZg==
X-Received: by 2002:a02:1142:: with SMTP id 63mr24210637jaf.73.1600292571355;
        Wed, 16 Sep 2020 14:42:51 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j77sm3921934ili.31.2020.09.16.14.42.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:42:50 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLgnLm022999;
        Wed, 16 Sep 2020 21:42:49 GMT
Subject: [PATCH RFC 07/21] NFSD: Add tracepoint in nfsd_setattr()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:42:49 -0400
Message-ID: <160029256978.29208.2271307698611376056.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Capture especially the XID, file handle, and attr mask for
troubleshooting. So for example:

nfsd-1025  [002]   256.807363: nfsd_setattr:         xid=0x12147d7a fh_hash=0x6085d6fb valid=MODE|ATIME|MTIME

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c   |    2 +
 2 files changed, 83 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 2ed632d36640..77b7e8a45776 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -12,6 +12,64 @@
 #include "export.h"
 #include "nfsfh.h"
 
+/*
+ * from include/linux/fs.h
+ */
+#define ATTR_VALID_LIST							\
+	attr_valid_list(MODE)						\
+	attr_valid_list(UID)						\
+	attr_valid_list(GID)						\
+	attr_valid_list(SIZE)						\
+	attr_valid_list(ATIME)						\
+	attr_valid_list(MTIME)						\
+	attr_valid_list(CTIME)						\
+	attr_valid_list(ATIME_SET)					\
+	attr_valid_list(MTIME_SET)					\
+	attr_valid_list(FORCE)						\
+	attr_valid_list(KILL_SUID)					\
+	attr_valid_list(KILL_SGID)					\
+	attr_valid_list(FILE)						\
+	attr_valid_list(KILL_PRIV)					\
+	attr_valid_list(OPEN)						\
+	attr_valid_list(TIMES_SET)					\
+	attr_valid_list_end(TOUCH)
+
+#undef attr_valid_list
+#undef attr_valid_list_end
+#define attr_valid_list(x)		TRACE_DEFINE_ENUM(ATTR_##x);
+#define attr_valid_list_end(x)		TRACE_DEFINE_ENUM(ATTR_##x);
+
+ATTR_VALID_LIST
+
+#undef attr_valid_list
+#undef attr_valid_list_end
+#define attr_valid_list(x)		{ ATTR_##x, #x },
+#define attr_valid_list_end(x)		{ ATTR_##x, #x }
+
+#define show_attr_valid_flags(x)	__print_flags(x, "|", ATTR_VALID_LIST)
+
+/*
+ * from include/uapi/linux/stat.h
+ */
+TRACE_DEFINE_ENUM(S_IFSOCK);
+TRACE_DEFINE_ENUM(S_IFLNK);
+TRACE_DEFINE_ENUM(S_IFREG);
+TRACE_DEFINE_ENUM(S_IFBLK);
+TRACE_DEFINE_ENUM(S_IFDIR);
+TRACE_DEFINE_ENUM(S_IFCHR);
+TRACE_DEFINE_ENUM(S_IFIFO);
+
+#define show_inode_type(x)						\
+	__print_symbolic(x,						\
+			{ S_IFSOCK, "SOCK" },				\
+			{ S_IFLNK, "LNK" },				\
+			{ S_IFREG, "REG" },				\
+			{ S_IFBLK, "BLK" },				\
+			{ S_IFDIR, "DIR" },				\
+			{ S_IFCHR, "CHR" },				\
+			{ S_IFIFO, "FIFO" },				\
+			{ 0, "NONE" })
+
 /*
  * from fs/nfsd/vfs.h
  */
@@ -805,6 +863,29 @@ TRACE_EVENT(nfsd_cb_done,
 		__entry->status)
 );
 
+TRACE_EVENT(nfsd_setattr_args,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp,
+		unsigned int valid
+	),
+	TP_ARGS(rqstp, fhp, valid),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, fh_hash)
+		__field(unsigned long, valid)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->valid = valid;
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x valid=%s",
+		__entry->xid, __entry->fh_hash,
+		show_attr_valid_flags(__entry->valid)
+	)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 1ecaceebee13..a311593ac976 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -375,6 +375,8 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 	bool		get_write_count;
 	bool		size_change = (iap->ia_valid & ATTR_SIZE);
 
+	trace_nfsd_setattr_args(rqstp, fhp, iap->ia_valid);
+
 	if (iap->ia_valid & ATTR_SIZE) {
 		accmode |= NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
 		ftype = S_IFREG;


