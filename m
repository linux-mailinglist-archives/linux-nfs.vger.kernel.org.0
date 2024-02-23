Return-Path: <linux-nfs+bounces-2068-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEDB861D77
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Feb 2024 21:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF8DB26A01
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Feb 2024 20:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FF71448E5;
	Fri, 23 Feb 2024 20:20:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD4F149388;
	Fri, 23 Feb 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719615; cv=none; b=tkZHEv/Ye0qeQhlSSltcQIn6dv+/z3BqdAVbhvSlgC5CtQYE06+3AMDtPef4lrQaASW3KNcc4nLnV/MSkRb7XGeTwf4TpGwg9QJZt4iY3FxF/CK+GQ2o45mk4BHkxoNR3fZZNvKmH9LfYw4HOfJ+PQOpqkTAIjMAOuN/IkolzZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719615; c=relaxed/simple;
	bh=CQv9OjZaC8cVr5dQoVkV3H1UwbxVlvPPTLLBhbu5mHI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MNXhqcU5JbAwDymAm9qUSOZ7/OC3PywhC56aG0dTmkPrQuyIPfHklHPP4Kc8smbszkCwEFkjkBzab3/33vYsjdVO6km7e4Akfb/sGWp8mEoRsGVFC3MZcc+IYtta1YW50Ci1kmHcbxnUa8Ax8P5d+/Pi0LXvugnjrGJxDj3QuXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DCDC433F1;
	Fri, 23 Feb 2024 20:20:13 +0000 (UTC)
Date: Fri, 23 Feb 2024 15:22:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, Jeff
 Layton <jlayton@kernel.org>
Subject: [PATCH v2] tracing: Remove __assign_str_len()
Message-ID: <20240223152206.0b650659@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Now that __assign_str() gets the length from the __string() (and
__string_len()) macros, there's no reason to have a separate
__assign_str_len() macro as __assign_str() can get the length of the
string needed.

Also remove __assign_rel_str() although it had no users anyway.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/linux-trace-kernel/20240223144840.563660e1@gandalf.local.home/

- I just realized that __assign_str_len() makes sure that the string ends
  with a '\0'. To use __assign_str(), it too must write a '\0' at the end
  of the string.

 fs/nfsd/trace.h                              |  8 +++---
 include/trace/stages/stage6_event_callback.h | 28 ++++++++------------
 samples/trace_events/trace-events-sample.h   |  9 ++++---
 3 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 2cd57033791f..98b14f30d772 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -102,7 +102,7 @@ TRACE_EVENT(nfsd_compound,
 	TP_fast_assign(
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->opcnt = opcnt;
-		__assign_str_len(tag, tag, taglen);
+		__assign_str(tag, tag);
 	),
 	TP_printk("xid=0x%08x opcnt=%u tag=%s",
 		__entry->xid, __entry->opcnt, __get_str(tag)
@@ -483,7 +483,7 @@ TRACE_EVENT(nfsd_dirent,
 	TP_fast_assign(
 		__entry->fh_hash = fhp ? knfsd_fh_hash(&fhp->fh_handle) : 0;
 		__entry->ino = ino;
-		__assign_str_len(name, name, namlen)
+		__assign_str(name, name);
 	),
 	TP_printk("fh_hash=0x%08x ino=%llu name=%s",
 		__entry->fh_hash, __entry->ino, __get_str(name)
@@ -853,7 +853,7 @@ DECLARE_EVENT_CLASS(nfsd_clid_class,
 		__entry->flavor = clp->cl_cred.cr_flavor;
 		memcpy(__entry->verifier, (void *)&clp->cl_verifier,
 		       NFS4_VERIFIER_SIZE);
-		__assign_str_len(name, clp->cl_name.data, clp->cl_name.len);
+		__assign_str(name, clp->cl_name.data);
 	),
 	TP_printk("addr=%pISpc name='%s' verifier=0x%s flavor=%s client=%08x:%08x",
 		__entry->addr, __get_str(name),
@@ -1800,7 +1800,7 @@ TRACE_EVENT(nfsd_ctl_time,
 	TP_fast_assign(
 		__entry->netns_ino = net->ns.inum;
 		__entry->time = time;
-		__assign_str_len(name, name, namelen);
+		__assign_str(name, name);
 	),
 	TP_printk("file=%s time=%d\n",
 		__get_str(name), __entry->time
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 2bfd49713b42..0c0f50bcdc56 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -32,16 +32,13 @@
 
 #undef __assign_str
 #define __assign_str(dst, src)						\
-	memcpy(__get_str(dst), __data_offsets.dst##_ptr_ ? : EVENT_NULL_STR, \
-	       __get_dynamic_array_len(dst))
-
-#undef __assign_str_len
-#define __assign_str_len(dst, src, len)					\
 	do {								\
-		memcpy(__get_str(dst),					\
-		       __data_offsets.dst##_ptr_ ? : EVENT_NULL_STR, len); \
-		__get_str(dst)[len] = '\0';				\
-	} while(0)
+		char *__str__ = __get_str(dst);				\
+		int __len__ = __get_dynamic_array_len(dst) - 1;		\
+		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
+		       EVENT_NULL_STR, __len__);			\
+		__str__[__len__] = '\0';				\
+	} while (0)
 
 #undef __assign_vstr
 #define __assign_vstr(dst, fmt, va)					\
@@ -94,15 +91,12 @@
 
 #undef __assign_rel_str
 #define __assign_rel_str(dst, src)					\
-	memcpy(__get_rel_str(dst), __data_offsets.dst##_ptr_ ? : EVENT_NULL_STR, \
-	       __get_rel_dynamic_array_len(dst))
-
-#undef __assign_rel_str_len
-#define __assign_rel_str_len(dst, src, len)				\
 	do {								\
-		memcpy(__get_rel_str(dst),				\
-		       __data_offsets.dst##_ptr_ ? : EVENT_NULL_STR, len); \
-		__get_rel_str(dst)[len] = '\0';				\
+		char *__str__ = __get_rel_str(dst);			\
+		int __len__ = __get_rel_dynamic_array_len(dst) - 1;	\
+		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
+		       EVENT_NULL_STR, __len__);			\
+		__str__[__len__] = '\0';				\
 	} while (0)
 
 #undef __rel_bitmask
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 23f923ccd529..f2d2d56ce8e2 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -163,8 +163,7 @@
  *         __string().
  *
  *   __string_len: This is a helper to a __dynamic_array, but it understands
- *	   that the array has characters in it, and with the combined
- *         use of __assign_str_len(), it will allocate 'len' + 1 bytes
+ *	   that the array has characters in it, it will allocate 'len' + 1 bytes
  *         in the ring buffer and add a '\0' to the string. This is
  *         useful if the string being saved has no terminating '\0' byte.
  *         It requires that the length of the string is known as it acts
@@ -174,9 +173,11 @@
  *
  *         __string_len(foo, bar, len)
  *
- *         To assign this string, use the helper macro __assign_str_len().
+ *         To assign this string, use the helper macro __assign_str().
+ *         The length is saved via the __string_len() and is retrieved in
+ *         __assign_str().
  *
- *         __assign_str_len(foo, bar, len);
+ *         __assign_str(foo, bar);
  *
  *         Then len + 1 is allocated to the ring buffer, and a nul terminating
  *         byte is added. This is similar to:
-- 
2.43.0


