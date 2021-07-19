Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF85A3CD86C
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jul 2021 17:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242821AbhGSOWV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 10:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242840AbhGSOVJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Jul 2021 10:21:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9460861220;
        Mon, 19 Jul 2021 15:01:42 +0000 (UTC)
Subject: [PATCH 1/3] tracing: Add trace_event helper macros __string_len() and
 __assign_str_len()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     rostedt@goodmis.org
Date:   Mon, 19 Jul 2021 11:01:41 -0400
Message-ID: <162670690188.60572.7526075385565701719.stgit@klimt.1015granger.net>
In-Reply-To: <162670659736.60572.10597769067889138558.stgit@klimt.1015granger.net>
References: <162670659736.60572.10597769067889138558.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

There's a few cases that a string that is to be recorded in a trace event,
does not have a terminating 'nul' character, and instead, the tracepoint
passes in the length of the string to record.

Add two helper macros to the trace event code that lets this work easier,
than tricks with "%.*s" logic.

  __string_len() which is similar to __string() for declaration, but takes a
                 length argument.

  __assign_str_len() which is similar to __assign_str() for assiging the
                 string, but it too takes a length argument.

Note, the TRACE_EVENT() macro will allocate the location on the ring
buffer to 'len + 1', that will be used to store the string into. It is a
requirement that the 'len' used for this is a most the length of the
string being recorded.

This string can still use __get_str() just like strings created with
__string() can use to retrieve the string.

Link: https://lore.kernel.org/linux-nfs/20210513105018.7539996a@gandalf.local.home/

Tested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/trace_events.h               |   22 ++++++++++++++++++++++
 samples/trace_events/trace-events-sample.h |   27 +++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index acc17194c160..08810a463880 100644
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
 
@@ -459,6 +465,9 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
@@ -507,6 +516,9 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 #define __string(item, src) __dynamic_array(char, item,			\
 		    strlen((src) ? (const char *)(src) : "(null)") + 1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)
+
 /*
  * __bitmask_size_in_bytes_raw is the number of bytes needed to hold
  * num_possible_cpus().
@@ -670,10 +682,20 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __assign_str
 #define __assign_str(dst, src)						\
 	strcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)");
 
+#undef __assign_str_len
+#define __assign_str_len(dst, src, len)					\
+	do {								\
+		memcpy(__get_str(dst), (src), (len));			\
+		__get_str(dst)[len] = '\0';				\
+	} while(0)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 13a35f7cbe66..e61471ab7d14 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -141,6 +141,33 @@
  *         In most cases, the __assign_str() macro will take the same
  *         parameters as the __string() macro had to declare the string.
  *
+ *   __string_len: This is a helper to a __dynamic_array, but it understands
+ *	   that the array has characters in it, and with the combined
+ *         use of __assign_str_len(), it will allocate 'len' + 1 bytes
+ *         in the ring buffer and add a '\0' to the string. This is
+ *         useful if the string being saved has no terminating '\0' byte.
+ *         It requires that the length of the string is known as it acts
+ *         like a memcpy().
+ *
+ *         Declared with:
+ *
+ *         __string_len(foo, bar, len)
+ *
+ *         To assign this string, use the helper macro __assign_str_len().
+ *
+ *         __assign_str(foo, bar, len);
+ *
+ *         Then len + 1 is allocated to the ring buffer, and a nul terminating
+ *         byte is added. This is similar to:
+ *
+ *         memcpy(__get_str(foo), bar, len);
+ *         __get_str(foo)[len] = 0;
+ *
+ *        The advantage of using this over __dynamic_array, is that it
+ *        takes care of allocating the extra byte on the ring buffer
+ *        for the '\0' terminating byte, and __get_str(foo) can be used
+ *        in the TP_printk().
+ *
  *   __bitmask: This is another kind of __dynamic_array, but it expects
  *         an array of longs, and the number of bits to parse. It takes
  *         two parameters (name, nr_bits), where name is the name of the


