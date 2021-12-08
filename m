Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE56B46D8FB
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Dec 2021 17:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbhLHQ6C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Dec 2021 11:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbhLHQ6A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Dec 2021 11:58:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CB8C0617A1
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 08:54:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E300ECE2262
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A76C00446
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:54:23 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] NFSD: Combine XDR error tracepoints
Date:   Wed,  8 Dec 2021 11:54:23 -0500
Message-Id:  <163898246262.1640.15450534978421376705.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <163898243636.1640.16855750027301323187.stgit@bazille.1015granger.net>
References:  <163898243636.1640.16855750027301323187.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578; h=from:subject:message-id; bh=ytFvDT7ZO5bBOYHYyKgj4cCDb0K0sKlBcWUe4h8HzL8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhsOM+SGifwJKS7alVB21YCvI9iBEOcnOtPAkXN0pi YHIiKBaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYbDjPgAKCRAzarMzb2Z/lwpNEA CNzH3f7oCAliKE6KpktWciSUHCQaIQTIbpOrG1JGp2syNrCumAiu5VFtfqxUsHbY3jJxq5yhgiV9Ja 3OTwEtJNtkywnq7SzNFBUGUEvuvmiZXjl5IY5pwbPKM6a6y91H52uSeGkmu6WABAG1xhWPCcB886o3 uAxAo1uUk2s+zoHUzAMJTmt21GigGzXJ6oN5PBhWzavGRVoR1OTcFoJ7Th/XMEFtmMfE8Odr/eY/3A kZQvaRIPsOTdkgyw7suphUaOownL/cMAf1JvSNJuJsXA67C365/wFPPh68tTrkqvz1HgBsBwbhDe6c B/bMhhb7UMHE/T9nkFJf5A3XaApmAS4e22PrVVvYSetEIuLsxrYOzJzsUpWbvCKyvj2lKyIZiKInIQ ZhsDetHOdCHEHrgE1FKnr4P5b7SUq2sZFjMqAYkt+QZOMzn9d1HAhLA4Ws1unaPsPMHycGyY2BhE/V oPETRxDWd3rFEdHC6X9UCYGK8kuSlpSFBkxeUFv1ErXRTCuDqpltk7pxPXAoKPna9GbIQRZaMP8Czj PXTblvQOAEf9Ag40OdenpR2xZqJt/4pnayyvYFEVWaQF6EjvtlEzHvjFz+o2qVyPOxLQOkZEmJMV6W 4wMWThjafQcICnkX+ENar0QfksI6Qz1gerFaqAYKaZK5DeStDMLHh4HOZWtw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: The garbage_args and cant_encode tracepoints report the
same information as each other, so combine them into a single
tracepoint class to reduce code duplication and slightly reduce the
size of trace.o.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |   28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index f1e0d3c51bc2..6afb32093104 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -47,7 +47,7 @@
 			       rqstp->rq_xprt->xpt_remotelen); \
 		} while (0);
 
-TRACE_EVENT(nfsd_garbage_args_err,
+DECLARE_EVENT_CLASS(nfsd_xdr_err_class,
 	TP_PROTO(
 		const struct svc_rqst *rqstp
 	),
@@ -69,27 +69,13 @@ TRACE_EVENT(nfsd_garbage_args_err,
 	)
 );
 
-TRACE_EVENT(nfsd_cant_encode_err,
-	TP_PROTO(
-		const struct svc_rqst *rqstp
-	),
-	TP_ARGS(rqstp),
-	TP_STRUCT__entry(
-		NFSD_TRACE_PROC_ARG_FIELDS
+#define DEFINE_NFSD_XDR_ERR_EVENT(name) \
+DEFINE_EVENT(nfsd_xdr_err_class, nfsd_##name##_err, \
+	TP_PROTO(const struct svc_rqst *rqstp), \
+	TP_ARGS(rqstp))
 
-		__field(u32, vers)
-		__field(u32, proc)
-	),
-	TP_fast_assign(
-		NFSD_TRACE_PROC_ARG_ASSIGNMENTS
-
-		__entry->vers = rqstp->rq_vers;
-		__entry->proc = rqstp->rq_proc;
-	),
-	TP_printk("xid=0x%08x vers=%u proc=%u",
-		__entry->xid, __entry->vers, __entry->proc
-	)
-);
+DEFINE_NFSD_XDR_ERR_EVENT(garbage_args);
+DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
 
 #define show_nfsd_may_flags(x)						\
 	__print_flags(x, "|",						\

