Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB69437FDF5
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 21:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhEMTSf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 13 May 2021 15:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230394AbhEMTSe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 13 May 2021 15:18:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C180613C4;
        Thu, 13 May 2021 19:17:23 +0000 (UTC)
Date:   Thu, 13 May 2021 15:17:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Message-ID: <20210513151721.02a7fdd1@gandalf.local.home>
In-Reply-To: <C618B795-ED20-4BA8-9C18-333EB42AD9CD@oracle.com>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
        <162083370248.3108.7424008399973918267.stgit@klimt.1015granger.net>
        <20210512122623.79ee0dda@gandalf.local.home>
        <238C0E2D-C2A4-4578-ADD2-C565B3B99842@oracle.com>
        <20210513105018.7539996a@gandalf.local.home>
        <C3D7DA41-C5B1-4388-B55C-E8A1280E9C9E@oracle.com>
        <107A51EE-E0A8-46FE-9E62-9FC586B91F19@oracle.com>
        <20210513150047.6b8ed9fb@gandalf.local.home>
        <C618B795-ED20-4BA8-9C18-333EB42AD9CD@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 13 May 2021 19:08:13 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> The tracepoints that currently use '%.*s' no longer work when
> using "trace-cmd start/stop/show". They were working before
> 9a6944fee68e, so I consider this a regression. I plan to
> submit patches to address this for 5.13-rc. I guess they will
> have to go without the use of the new _len macros for now,
> and you can push the macros in v5.14.

That's a separate bug. I'm currently running this patch through my tests,
and will push to Linus when it completes. Feel free to test this one too.

-- Steve

From eb01f5353bdaa59600b29d864819056a0e3de24d Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Thu, 13 May 2021 12:23:24 -0400
Subject: [PATCH] tracing: Handle %.*s in trace_check_vprintf()

If a trace event uses the %*.s notation, the trace_check_vprintf() will
fail and will warn about a bad processing of strings, because it does not
take into account the length field when processing the star (*) part.
Have it handle this case as well.

Link: https://lore.kernel.org/linux-nfs/238C0E2D-C2A4-4578-ADD2-C565B3B99842@oracle.com/

Reported-by: Chuck Lever III <chuck.lever@oracle.com>
Fixes: 9a6944fee68e2 ("tracing: Add a verifier to check string pointers for trace events")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 560e4c8d3825..a21ef9cd2aae 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3704,6 +3704,9 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		goto print;
 
 	while (*p) {
+		bool star = false;
+		int len = 0;
+
 		j = 0;
 
 		/* We only care about %s and variants */
@@ -3725,13 +3728,17 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 				/* Need to test cases like %08.*s */
 				for (j = 1; p[i+j]; j++) {
 					if (isdigit(p[i+j]) ||
-					    p[i+j] == '*' ||
 					    p[i+j] == '.')
 						continue;
+					if (p[i+j] == '*') {
+						star = true;
+						continue;
+					}
 					break;
 				}
 				if (p[i+j] == 's')
 					break;
+				star = false;
 			}
 			j = 0;
 		}
@@ -3744,6 +3751,9 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		iter->fmt[i] = '\0';
 		trace_seq_vprintf(&iter->seq, iter->fmt, ap);
 
+		if (star)
+			len = va_arg(ap, int);
+
 		/* The ap now points to the string data of the %s */
 		str = va_arg(ap, const char *);
 
@@ -3762,8 +3772,18 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 			int ret;
 
 			/* Try to safely read the string */
-			ret = strncpy_from_kernel_nofault(iter->fmt, str,
-							  iter->fmt_size);
+			if (star) {
+				if (len + 1 > iter->fmt_size)
+					len = iter->fmt_size - 1;
+				if (len < 0)
+					len = 0;
+				ret = copy_from_kernel_nofault(iter->fmt, str, len);
+				iter->fmt[len] = 0;
+				star = false;
+			} else {
+				ret = strncpy_from_kernel_nofault(iter->fmt, str,
+								  iter->fmt_size);
+			}
 			if (ret < 0)
 				trace_seq_printf(&iter->seq, "(0x%px)", str);
 			else
@@ -3775,7 +3795,10 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 			strncpy(iter->fmt, p + i, j + 1);
 			iter->fmt[j+1] = '\0';
 		}
-		trace_seq_printf(&iter->seq, iter->fmt, str);
+		if (star)
+			trace_seq_printf(&iter->seq, iter->fmt, len, str);
+		else
+			trace_seq_printf(&iter->seq, iter->fmt, str);
 
 		p += i + j + 1;
 	}
-- 
2.29.2

