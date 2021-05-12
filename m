Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA9837D0D4
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 19:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbhELRm6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 13:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240032AbhELQyv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 May 2021 12:54:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 919B261183;
        Wed, 12 May 2021 16:53:41 +0000 (UTC)
Date:   Wed, 12 May 2021 12:53:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, dwysocha@redhat.com,
        bfields@fieldses.org
Subject: Re: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Message-ID: <20210512125339.358972a6@gandalf.local.home>
In-Reply-To: <20210512122623.79ee0dda@gandalf.local.home>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
        <162083370248.3108.7424008399973918267.stgit@klimt.1015granger.net>
        <20210512122623.79ee0dda@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 12 May 2021 12:26:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 12 May 2021 11:35:02 -0400
> Chuck Lever <chuck.lever@oracle.com> wrote:
> 
> > Since commit 9a6944fee68e ("tracing: Add a verifier to check string
> > pointers for trace events"), which was merged in v5.13-rc1,
> > TP_printk() no longer tacitly supports the "%.*s" format specifier.  
> 
> Hmm, this looks like a bug. I should allow the %.*s notation.
> 
> I probably should fix that.

Only compiled tested, but the %.*s notation should work with this.

-- Steve

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e28d08905124..0181122f1e80 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3700,6 +3700,9 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		goto print;
 
 	while (*p) {
+		bool star = false;
+		int len = 0;
+
 		j = 0;
 
 		/* We only care about %s and variants */
@@ -3721,13 +3724,17 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
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
@@ -3740,6 +3747,9 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		iter->fmt[i] = '\0';
 		trace_seq_vprintf(&iter->seq, iter->fmt, ap);
 
+		if (star)
+			len = va_arg(ap, int);
+
 		/* The ap now points to the string data of the %s */
 		str = va_arg(ap, const char *);
 
@@ -3758,8 +3768,18 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
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
@@ -3771,7 +3791,10 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
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
