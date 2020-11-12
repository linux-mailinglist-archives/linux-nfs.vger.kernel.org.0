Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4032B0805
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 16:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgKLPBQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 10:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgKLPBL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 10:01:11 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216ABC0613D1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 07:01:10 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id t191so5486593qka.4
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 07:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=g1Tt3FCskayNJzdE3wguk1JhfCZ5PNbQuRtfux2nKF0=;
        b=RE9+pdMDPH2ZytNyYlhP51AQYMNYmrHAJjc/WmUZKBUCpfy+QNyN5gm4nHM8IFpVRw
         4lPpBxykHfcIu4lXOMejnsmlv17UieD6jNAYmDNUmIpa08IiL+dD0ZmU98+SiY7+t2Dr
         N0+LP0+yH8wPe9HgY5Dbp7StCx1iIlMTqB96conGc8R/P3AYokwexKt83/mwsLpug0Fa
         Ew/2MhfoXUJqALScup2pO0uAq3652BS7EXnMSFE0CXp3a269jCw4Lz7CgcCrqNERlU++
         DzcaoHtRZqhgPifUfdtCi64iwaO6k5CArt5QGDcAWtDSX0K4ULG49nU3a1A+h37RD0dR
         AL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=g1Tt3FCskayNJzdE3wguk1JhfCZ5PNbQuRtfux2nKF0=;
        b=hFhradD4bTDcskC6lhz8NoVxQqtOFRra8t9jRTH7cv++FgsaLTVZRwrnFTdKIVnHqJ
         +8BSzHQYTBIiHODP9UpifK8FhNWGadD2wwk7anE+WuczZgrJFbkbsdvdpDIRzJ3mEi3F
         9gUjBTtp8RX6kdlUnVSIcTj6eGrTqYRrcPIFmkNF3IeZaq0STmypPc075QUXJm9WcKej
         1urW5Z1EksX/fH+p21bLp7NxQgNuOD/to76re/CzDLBOASJma7JLH3Pq/tpabQyHKSYC
         c3q645YPAqOXGCYj3XaLEC81JSBvzOEft3TpNqOVTNDqkJdCNGeT9IvXCVwGxjHgz07F
         hg0A==
X-Gm-Message-State: AOAM532XLPG3a3CCYpLCEGLJBJ4uYpgfjdCFvXMwzzA3OmJKAAcoazm1
        BlUjcZ6Ju9w9jIiiyFIOAukx21KQr4U=
X-Google-Smtp-Source: ABdhPJxKHORNUFjTrnWddkTXay9ZAw9XUvQyCsTRGAy9TSaWSJI85vgVtoJXHBgdZRwCZKdAg+1dHw==
X-Received: by 2002:a37:6143:: with SMTP id v64mr128700qkb.490.1605193268361;
        Thu, 12 Nov 2020 07:01:08 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k70sm5195395qke.46.2020.11.12.07.01.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 07:01:07 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ACF16Lj029802
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 15:01:06 GMT
Subject: [PATCH v1 2/4] NFSD: Clean up the show_nf_may macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 12 Nov 2020 10:01:06 -0500
Message-ID: <160519326660.1658.18351054451047271453.stgit@klimt.1015granger.net>
In-Reply-To: <160519319763.1658.12613346131541001302.stgit@klimt.1015granger.net>
References: <160519319763.1658.12613346131541001302.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
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
index 99bf07800cd0..532b66a4b7f1 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -12,6 +12,22 @@
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
@@ -421,6 +437,9 @@ TRACE_EVENT(nfsd_clid_inuse_err,
 		__entry->cl_boot, __entry->cl_id)
 )
 
+/*
+ * from fs/nfsd/filecache.h
+ */
 TRACE_DEFINE_ENUM(NFSD_FILE_HASHED);
 TRACE_DEFINE_ENUM(NFSD_FILE_PENDING);
 TRACE_DEFINE_ENUM(NFSD_FILE_BREAK_READ);
@@ -435,13 +454,6 @@ TRACE_DEFINE_ENUM(NFSD_FILE_REFERENCED);
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
@@ -466,7 +478,7 @@ DECLARE_EVENT_CLASS(nfsd_file_class,
 		__entry->nf_inode,
 		__entry->nf_ref,
 		show_nf_flags(__entry->nf_flags),
-		show_nf_may(__entry->nf_may),
+		show_nfsd_may_flags(__entry->nf_may),
 		__entry->nf_file)
 )
 
@@ -492,10 +504,10 @@ TRACE_EVENT(nfsd_file_acquire,
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
@@ -514,10 +526,10 @@ TRACE_EVENT(nfsd_file_acquire,
 
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


