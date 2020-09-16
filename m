Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B7226CE8F
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIPWSW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgIPWR5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:17:57 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66677C061A2A
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:36 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g7so9964844iov.13
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GX8blvT22n2flPRieLsZA2945QuhO1WonegzvfRPWcE=;
        b=uFC45ftiAg3Vf7nmSSJK0F6l/d6wIkwmudumh/AYw1RaKQ7ev/HhuqaGiLnVJcU9wK
         lelXphsfHpWO5q191QMxviv9grovykVWBBUIAwc6vPVIO5d00Ry7rp9dWRPXy9vIWJbF
         M1pznFiTb5QGlHhBLAq08o8sbhN1aXHry49hh8FCgQChyAlPNdrHCuscbHyHiMxciMSn
         RD+LyhrE6fa3XoNYjJcVG90RoxI5Yo/OZvcx5Syj8DBM47YLv0AqhevCH81Nf7STD5s6
         34i8M+SzudUDcTqe9lIp2Y/Q9w+DzuVYsCxmbKMj+Vu8S7JRdXE0nGKdnxDBku3it0lP
         3MSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=GX8blvT22n2flPRieLsZA2945QuhO1WonegzvfRPWcE=;
        b=ea0pJJYQ3ZXMzmUUMx4dQrntJrQJTeNpQNxKX1vAX6sWydQP9kfJUbWRb3VufBqLLC
         jjNGBl/IEfXCjVCt+l59F2W7094FBAR/FwVuuZC4JWcbNFiqzpqfMGN2zDvD5wCOhM7W
         L8XbiJitRD7kIfUDatHUetiKYXqVozZSDB2e6GOdW6lMhY3y/HZpJV8mSqfpn/qUHfkc
         XVtT8CTZaFPQ/21MZZgGQRRwNgf8SenCbi28yKVkohfVkBrTSs2UAtTFj9evuA8L1DC9
         2zRdyzYxEl4ikEd3uvU0yabM8ZwwTStYHbynodFMvv2bvMTb26wYygn4PmmjqXDZxqxl
         iicA==
X-Gm-Message-State: AOAM533AWSeVRNG60/30cWCcKZp9AAQ572KcewF2uwfS2775lxlV8aF3
        Rf0Jg9kqf8i86tALtG/LYCM=
X-Google-Smtp-Source: ABdhPJxZ61TJmVe6Ch7nGdOrCX83txGzTr0GKrGp4DN+LlWctsYW+w2bTEi7jpmtAMvbUPRmLxWRig==
X-Received: by 2002:a05:6602:22cf:: with SMTP id e15mr20713403ioe.114.1600292555769;
        Wed, 16 Sep 2020 14:42:35 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i144sm9629121ioa.55.2020.09.16.14.42.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:42:35 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLgYOT022990;
        Wed, 16 Sep 2020 21:42:34 GMT
Subject: [PATCH RFC 04/21] NFSD: Clean up the show_nf_may macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:42:34 -0400
Message-ID: <160029255410.29208.10420863210576888477.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Display all possible NFSD_MAY permission flags.

Rename show_nf_may with a more generic name because the NFSD_MAY
permission flags are used in other places besides the file cache.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |   52 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 1861db1bdc67..a8013338f4d5 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -12,6 +12,38 @@
 #include "export.h"
 #include "nfsfh.h"
 
+/*
+ * from fs/nfsd/vfs.h
+ */
+#define NFSD_PERMISSION_LIST						\
+	nfsd_perm_flag(EXEC)						\
+	nfsd_perm_flag(WRITE)						\
+	nfsd_perm_flag(READ)						\
+	nfsd_perm_flag(SATTR)						\
+	nfsd_perm_flag(TRUNC)						\
+	nfsd_perm_flag(LOCK)						\
+	nfsd_perm_flag(OWNER_OVERRIDE)					\
+	nfsd_perm_flag(LOCAL_ACCESS)					\
+	nfsd_perm_flag(BYPASS_GSS_ON_ROOT)				\
+	nfsd_perm_flag(NOT_BREAK_LEASE)					\
+	nfsd_perm_flag(BYPASS_GSS)					\
+	nfsd_perm_flag(READ_IF_EXEC)					\
+	nfsd_perm_flag_end(64BIT_COOKIE)
+
+#undef nfsd_perm_flag
+#undef nfsd_perm_flag_end
+#define nfsd_perm_flag(x)	TRACE_DEFINE_ENUM(NFSD_MAY_##x);
+#define nfsd_perm_flag_end(x)	TRACE_DEFINE_ENUM(NFSD_MAY_##x);
+
+NFSD_PERMISSION_LIST
+
+#undef nfsd_perm_flag
+#undef nfsd_perm_flag_end
+#define nfsd_perm_flag(x)	{ NFSD_MAY_##x, #x },
+#define nfsd_perm_flag_end(x)	{ NFSD_MAY_##x, #x }
+
+#define show_perm_flags(val)	__print_flags(val, "|", NFSD_PERMISSION_LIST)
+
 TRACE_EVENT(nfsd_compound,
 	TP_PROTO(const struct svc_rqst *rqst,
 		 u32 args_opcnt),
@@ -421,6 +453,9 @@ TRACE_EVENT(nfsd_clid_inuse_err,
 		__entry->cl_boot, __entry->cl_id)
 )
 
+/*
+ * from fs/nfsd/filecache.h
+ */
 TRACE_DEFINE_ENUM(NFSD_FILE_HASHED);
 TRACE_DEFINE_ENUM(NFSD_FILE_PENDING);
 TRACE_DEFINE_ENUM(NFSD_FILE_BREAK_READ);
@@ -435,13 +470,6 @@ TRACE_DEFINE_ENUM(NFSD_FILE_REFERENCED);
 		{ 1 << NFSD_FILE_BREAK_WRITE,	"BREAK_WRITE" },	\
 		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"})
 
-/* FIXME: This should probably be fleshed out in the future. */
-#define show_nf_may(val)						\
-	__print_flags(val, "|",						\
-		{ NFSD_MAY_READ,		"READ" },		\
-		{ NFSD_MAY_WRITE,		"WRITE" },		\
-		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" })
-
 DECLARE_EVENT_CLASS(nfsd_file_class,
 	TP_PROTO(struct nfsd_file *nf),
 	TP_ARGS(nf),
@@ -466,7 +494,7 @@ DECLARE_EVENT_CLASS(nfsd_file_class,
 		__entry->nf_inode,
 		__entry->nf_ref,
 		show_nf_flags(__entry->nf_flags),
-		show_nf_may(__entry->nf_may),
+		show_perm_flags(__entry->nf_may),
 		__entry->nf_file)
 )
 
@@ -492,10 +520,10 @@ TRACE_EVENT(nfsd_file_acquire,
 		__field(u32, xid)
 		__field(unsigned int, hash)
 		__field(void *, inode)
-		__field(unsigned int, may_flags)
+		__field(unsigned long, may_flags)
 		__field(int, nf_ref)
 		__field(unsigned long, nf_flags)
-		__field(unsigned char, nf_may)
+		__field(unsigned long, nf_may)
 		__field(struct file *, nf_file)
 		__field(u32, status)
 	),
@@ -514,9 +542,9 @@ TRACE_EVENT(nfsd_file_acquire,
 
 	TP_printk("xid=0x%x hash=0x%x inode=0x%p may_flags=%s ref=%d nf_flags=%s nf_may=%s nf_file=0x%p status=%u",
 			__entry->xid, __entry->hash, __entry->inode,
-			show_nf_may(__entry->may_flags), __entry->nf_ref,
+			show_perm_flags(__entry->may_flags), __entry->nf_ref,
 			show_nf_flags(__entry->nf_flags),
-			show_nf_may(__entry->nf_may), __entry->nf_file,
+			show_perm_flags(__entry->nf_may), __entry->nf_file,
 			__entry->status)
 );
 


