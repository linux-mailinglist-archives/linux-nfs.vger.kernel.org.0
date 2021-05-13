Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3D537FA08
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhEMOxc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 10:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234685AbhEMOvb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 13 May 2021 10:51:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4850061370;
        Thu, 13 May 2021 14:50:20 +0000 (UTC)
Date:   Thu, 13 May 2021 10:50:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Message-ID: <20210513105018.7539996a@gandalf.local.home>
In-Reply-To: <238C0E2D-C2A4-4578-ADD2-C565B3B99842@oracle.com>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
        <162083370248.3108.7424008399973918267.stgit@klimt.1015granger.net>
        <20210512122623.79ee0dda@gandalf.local.home>
        <238C0E2D-C2A4-4578-ADD2-C565B3B99842@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 12 May 2021 16:52:05 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> The underlying need is to support non-NUL-terminated C strings.
> 
> I assumed that since the commentary around 9a6944fee68e claims
> the proper way to trace C strings is to use __string and friends,
> and those do not support non-NUL-terminated strings, that such
> strings are really not first-class citizens. Thus I concluded
> that my use of '%.*s' was incorrect.
> 
> Having some __string-style helpers that can deal with such
> strings would be valuable.

I guess the best I can do is a strncpy version, that will add the '\0' in
the ring buffer. That way we don't need to save the length as well (length
would need to be at least 4 bytes, where as '\0' is one).

Something like this?

I added "__string_len()" and "__assign_str_len()". You use them just like
__string() and __assign_str() but add a max length that you want to use
(although, it will always allocate "len" regardless if the string is
smaller). Then use __get_str() just like you use __string().

Would something like that work?

-- Steve

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 8268bf747d6f..7ab23535a0c8 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -102,6 +102,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
 
@@ -197,6 +200,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
@@ -444,6 +450,9 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
@@ -492,6 +501,9 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 #define __string(item, src) __dynamic_array(char, item,			\
 		    strlen((src) ? (const char *)(src) : "(null)") + 1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)
+
 /*
  * __bitmask_size_in_bytes_raw is the number of bytes needed to hold
  * num_possible_cpus().
@@ -655,10 +667,18 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __assign_str
 #define __assign_str(dst, src)						\
 	strcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)");
 
+#undef __assign_str_len
+#define __assign_str_len(dst, src, len)						\
+	strncpy(__get_str(dst), (src) ? (const char *)(src) : "(null)", len);	\
+	__get_str(dst)[len] = '\0';
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 


