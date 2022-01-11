Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132AA48B648
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jan 2022 19:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350304AbiAKS7a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jan 2022 13:59:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56374 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242717AbiAKS7a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jan 2022 13:59:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BED1A616DB;
        Tue, 11 Jan 2022 18:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D5DC36AE9;
        Tue, 11 Jan 2022 18:59:28 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-trace-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH RFC 1/2] trace: Introduce helpers to safely handle dynamic-sized sockaddrs
Date:   Tue, 11 Jan 2022 13:59:27 -0500
Message-Id:  <164192756765.1149.13872546013201834510.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164192738510.1149.7614903005271825552.stgit@klimt.1015granger.net>
References:  <164192738510.1149.7614903005271825552.stgit@klimt.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4111; h=from:subject:message-id; bh=6osr5wh6WcD4WAY+kseGgBHzYS0YheQhzabd71O4rvk=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh3dOPX2MFGDcp5Qj0p1voUzY6PbACVSD+4urXCTTY s1j4c82JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYd3TjwAKCRAzarMzb2Z/l9J2D/ 98KPJItI7tfMD0iyxr4jJpAvEnwOzeyu1xLXs1tHdmSJ7HxtmvG4ek1Br7XlIfhekD8k+DVrQX0GN+ hGWpjw2zL06FQEuZBNqR6bR8nL0qJIGdQxugsI37ySs97fO/pDy96OS/TXUjrSWhVqSjTQtReBwCXa AW2Hy+qqztA9cE4vJo2RisHnXtDYWiLAgiHFUldRVhAzNOadMDLk8SG0Ot/lqjG2l1LZJXNjiWqxun 7okaB+q6zFezyGjXIlSMqwyJsta4jTHC8Jw1k92UZ6djI+u2ZFP+BLDWiga8ueNfpnbqeoNC+uhxj4 9w13jPZ3KqoY2Y/z4NyIU0kHkQC3t3OSu/f9rXpL2ZwhHPWlIDrEmMhVaRfkwr3PJqX0epn1+kWRSR 5EzsDPrZvYs4HiYKleJk8E8oG+zEpfylVsdRGowz1l8FNpBvxXdjF/lP2qP4eE1DvYO0Uy4+fsiikH oeaeZLhXC6PeFEctioKts7ugLY4VQ87zLWW5pwHw2KCP2mKtXy+QfBTON9vUXWIPk1/E6l9fcidV/d 01wU3bMGY5zl2NdGI1b5cKr7PVHmbciPKW3CyhCsgR/Xv9UMsPvkchR8FEy74L3JBp8AhnjUNSrSKz uOvZxYvQbbw4WzICemDSI5H/rM2FAVzLrM7XEPz4Mr8E9XKhZfQFJzRRYHlw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Enable a struct sockaddr to be stored in a trace record as a
dynamically-sized field. The common cases are AF_INET and AF_INET6
which are different sizes, and are vastly smaller than a struct
sockaddr_storage.

These are safer because, when used properly, the size of the
sockaddr destination field in each trace record is now guaranteed
to be the same as the source address that is being copied into it.

Link: https://lore.kernel.org/all/164182978641.8391.8277203495236105391.stgit@bazille.1015granger.net/
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/bpf_probe.h    |    3 +++
 include/trace/perf.h         |    3 +++
 include/trace/trace_events.h |   18 ++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index a8e97f84b652..74068d7b3103 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -21,6 +21,9 @@
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
+#undef __get_sockaddr
+#define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
+
 #undef __perf_count
 #define __perf_count(c)	(c)
 
diff --git a/include/trace/perf.h b/include/trace/perf.h
index dbc6c74defc3..953ff4a25691 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -21,6 +21,9 @@
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
+#undef __get_sockaddr
+#define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
+
 #undef __perf_count
 #define __perf_count(c)	(__count = (c))
 
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 08810a463880..003104159087 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -108,6 +108,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
 
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
 #undef TP_STRUCT__entry
 #define TP_STRUCT__entry(args...) args
 
@@ -206,6 +209,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 	struct trace_event_data_offsets_##call {			\
@@ -302,6 +308,9 @@ TRACE_MAKE_SYSTEM_STR();
 		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
 	})
 
+#undef __get_sockaddr
+#define __get_sockaddr(field)	((struct sockaddr *)__get_dynamic_array(field))
+
 #undef __print_flags
 #define __print_flags(flag, delim, flag_array...)			\
 	({								\
@@ -471,6 +480,9 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, func, print)	\
 static struct trace_event_fields trace_event_fields_##call[] = {	\
@@ -542,6 +554,9 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item,	\
 					 __bitmask_size_in_longs(nr_bits))
 
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 static inline notrace int trace_event_get_offsets_##call(		\
@@ -706,6 +721,9 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #define __assign_bitmask(dst, src, nr_bits)					\
 	memcpy(__get_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
 
+#define __assign_sockaddr(dest, src, len)					\
+	memcpy(__get_dynamic_array(dest), src, len)
+
 #undef TP_fast_assign
 #define TP_fast_assign(args...) args
 

