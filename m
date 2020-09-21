Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C2627319E
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgIUSLk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgIUSLj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:11:39 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A874BC061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:39 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t12so14698602ilh.3
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=S4BslARkhd63EIdOskdkDQs+da07SzJ0KrmE6mO5O30=;
        b=icv+mKCewdBK7AFU95UL7Flq8c3PtK/zSvP/kWI7Nw9H0jhitRa9BAYw/cfrwdydma
         vz2tQxLAYLnAz+XAnZjsNv+ilB7WEWtBNQT7Qf4o3E8TsNNcLrn9RI7/+O91G7I2p1AD
         LbrajMQDxTS65qZHIQv77om4DdBm+1KrgUGrDWy+b+g9O9IXyzsiZMQAAKANFlLi9YXn
         MnEkdEsfnNN7EdjizYZrtB73uli85mGGgU3/qa0UvahaExwJ6ew4yuDTZfmaoup4bURa
         sIrXbmXqkby9eGtNEaEFN8EJH7vqEwY6KFjUmkO8pjpnoY/3B4lIF+9imB8ruaAxyoM2
         iJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=S4BslARkhd63EIdOskdkDQs+da07SzJ0KrmE6mO5O30=;
        b=amZMaX6vysw+vbi9chuNPjzSyLvPdQGDbx70r+b1Uo16x28QrdHNYQy2npBd5Pecn6
         hHqyhzb2wSrqav4jcjlmOYx1Bh1QR8jy7/zuv3YPl4HP71jWG555pU/YHrpztr+0x1mz
         M81G0sIk2u4pcSwyAvCM6h4xJDT10Xh1QFQtQQtPVEOqV7VzeG85tlv3spt6wc/7x6g5
         lWTKiIyrUbH03c7rm+9ztnR1X1T5UMLzdVMhaqV+tuXisV1j/E+8zxXtQaxGSvkoa65d
         GUXwFZ1eT0rULlA1MAAz8lAhOUqTaQ6/JTKHvabaxuI8cDfewJUXEx1mKPzbwWMHitii
         HpBg==
X-Gm-Message-State: AOAM531BJODS44MWJvuYHNNcFQ526jcrQIzPwoE9ZmBjemHt3g/0li8X
        z+J/UTqmBvKt8Uaf1eUUNSA=
X-Google-Smtp-Source: ABdhPJzmNnow4EIW9g4XSVEqg/UTCu+hTCRF2aCP0fj6d1qjfZh5Y8Fj5qnZebpyUMHNQlXil4kpHA==
X-Received: by 2002:a92:905:: with SMTP id y5mr1060940ilg.210.1600711898989;
        Mon, 21 Sep 2020 11:11:38 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g6sm6190080iop.24.2020.09.21.11.11.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:11:38 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LIBb2w003869;
        Mon, 21 Sep 2020 18:11:37 GMT
Subject: [PATCH v2 09/27] NFSD: Clean up the show_nf_may macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:11:37 -0400
Message-ID: <160071189735.1468.14866148934956788835.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Display all currently possible NFSD_MAY permission flags.

Move and rename show_nf_may with a more generic name because the
NFSD_MAY permission flags are used in other places besides the file
cache.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |   40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 1909fc57435f..8d72829f15ac 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -13,6 +13,22 @@
 #include "export.h"
 #include "nfsfh.h"
 
+#define show_nfsd_may_flags(x)						\
+	__print_flags(x, "|",						\
+		{ NFSD_MAY_EXEC,		"EXEC" },		\
+		{ NFSD_MAY_WRITE,		"WRITE" },		\
+		{ NFSD_MAY_READ,		"READ" },		\
+		{ NFSD_MAY_SATTR,		"SATTR" },		\
+		{ NFSD_MAY_TRUNC,		"TRUNC" },		\
+		{ NFSD_MAY_LOCK,		"LOCK" },		\
+		{ NFSD_MAY_OWNER_OVERRIDE,	"OWNER_OVERRIDE" },	\
+		{ NFSD_MAY_LOCAL_ACCESS,	"LOCAL_ACCESS" },	\
+		{ NFSD_MAY_BYPASS_GSS_ON_ROOT,	"BYPASS_GSS_ON_ROOT" },	\
+		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAD_LEASE" },	\
+		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
+		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
+		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
+
 TRACE_EVENT(nfsd_compound,
 	TP_PROTO(const struct svc_rqst *rqst,
 		 u32 args_opcnt),
@@ -422,6 +438,9 @@ TRACE_EVENT(nfsd_clid_inuse_err,
 		__entry->cl_boot, __entry->cl_id)
 )
 
+/*
+ * from fs/nfsd/filecache.h
+ */
 TRACE_DEFINE_ENUM(NFSD_FILE_HASHED);
 TRACE_DEFINE_ENUM(NFSD_FILE_PENDING);
 TRACE_DEFINE_ENUM(NFSD_FILE_BREAK_READ);
@@ -436,13 +455,6 @@ TRACE_DEFINE_ENUM(NFSD_FILE_REFERENCED);
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
@@ -467,7 +479,7 @@ DECLARE_EVENT_CLASS(nfsd_file_class,
 		__entry->nf_inode,
 		__entry->nf_ref,
 		show_nf_flags(__entry->nf_flags),
-		show_nf_may(__entry->nf_may),
+		show_nfsd_may_flags(__entry->nf_may),
 		__entry->nf_file)
 )
 
@@ -493,10 +505,10 @@ TRACE_EVENT(nfsd_file_acquire,
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
@@ -515,10 +527,10 @@ TRACE_EVENT(nfsd_file_acquire,
 
 	TP_printk("xid=0x%x hash=0x%x inode=0x%p may_flags=%s ref=%d nf_flags=%s nf_may=%s nf_file=0x%p status=%u",
 			__entry->xid, __entry->hash, __entry->inode,
-			show_nf_may(__entry->may_flags), __entry->nf_ref,
-			show_nf_flags(__entry->nf_flags),
-			show_nf_may(__entry->nf_may), __entry->nf_file,
-			__entry->status)
+			show_nfsd_may_flags(__entry->may_flags),
+			__entry->nf_ref, show_nf_flags(__entry->nf_flags),
+			show_nfsd_may_flags(__entry->nf_may),
+			__entry->nf_file, __entry->status)
 );
 
 DECLARE_EVENT_CLASS(nfsd_file_search_class,


