Return-Path: <linux-nfs+bounces-22311-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4LUdGqILI2o7hAEAu9opvQ
	(envelope-from <linux-nfs+bounces-22311-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:47:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 640CA64A4C6
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:47:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZMtQOBMX;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22311-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22311-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D54CE304B72C
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F04399369;
	Fri,  5 Jun 2026 17:34:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3976390209;
	Fri,  5 Jun 2026 17:34:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680897; cv=none; b=uvwx43O4z2BHeZS0OVrS3Bfqkvns9BFdEvo2YeL8jlcb0jLME04shoOmeWUS8Yc4ffvo0sJKIBrxs2XfOvsErTXOLMwZAufohq80mE7mGlyYmnyR2Mu7LpFe4ZJpEC3AW4kyl7Oe+fXnXvtvJqNCkETlSJ0piV7MT/g2WrP7ZUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680897; c=relaxed/simple;
	bh=iJFrdho+iDvBpB3XtXrB4/OfRInJ9ykZZ4+3Ipmrebg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1busaw4489UfCS1aKPG2pfp9J2auEUF73C7/PN8TfgrXX3zwDsOTleoYc0n1yGFLvgD37G5/ZWUCbrRmdGxYRCiBvIjI7e8ZkFxx+TwWhkbZvoAf2D96bRTchGbCRW4bAjEUvCb58RYVmR93OaW731bHVcQaaKVklrsdutp4jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMtQOBMX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5FB1F0089A;
	Fri,  5 Jun 2026 17:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680892;
	bh=nvzhyXwGUFrdqi65Noh+UK8zz7St44WUKJkM8kmVVkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZMtQOBMXbAh5CF2eTzXC8XXmy26eXEyhQXXDKqynoHO2vmrF9/x9U8LL54ceV8BpM
	 r87VJpc8Wfj37DML8mwOmreW3+ZE8sc5sq0QdfzrCo6RrC1ofOjD+7SduJ5ME1kWur
	 TlZp1CgqGptXGI2gC4ekGw14vaztpobAKlsREr2dmo7n2+a2b4tnGtOM4eDO6g3C7i
	 mMvXI/hM/uhk6Kw2MwiVfP9BzSW3DVfuI00XnWbME81Bp+YX+vDrky9v4BMP6kgP7K
	 q2zVruH0Fm1ou8oespIVsr4d4pRcVvQ7pYm7A05lwErl/eb9SuSkJfUrFo9bP4168B
	 7BPk3O7guhsnA==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 05 Jun 2026 13:34:37 -0400
Subject: [PATCH 3/9] lib: Add a "tagset" data structure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-tls-session-tags-v1-3-47bd1d94d552@oracle.com>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
In-Reply-To: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sabrina Dubroca <sd@queasysnail.net>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=20554;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=vRucQo5Cu6HRxT3Xwlsvz7Fo2hFkJRjveVoe+ISVr+U=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIwi41lGLi+XLq6OAkH9enu/nOU+qRi7aDKT8m
 I573/nbqbuJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiMIuAAKCRAzarMzb2Z/
 l8teD/43HmSE4+naDZN9yq3c7woc7O+7ENxzqHLWOuTEDKs8jm3zy3gn/wcpBjmdiW9FrZa2AVq
 OgIjQw+R/H+HvA5iBq+6COgQcBXzZmifrMPyenS4AyJmi/KwsxK0DcGNNZpLN3/pLaHQGjWzy8x
 PdPwIu2LzkyfeRJHgnzg2KBNAkAH8n9xOVUSd0WxHhGueuDd53N/N83f342ggBB/xDPbdZIOlxI
 r8b66KxhhIk+IcpQb+DczzS50jPYPnVoJw2oElDqTxRCh6SPq9BXK0y1dRIKQ8FoOtu1IOSvV9q
 6wvVgiXqjU0rYUlgu0TWXuVtOiG0HBDizXjGok/TP6pk5IpbONa7Qqrml5jTpjvIohkpIPT/JSh
 y0Hz+dtCby0uVqfoKYQCPBc5o8GPO1vPVRF6N9STM55upNGh7QAEZTWhf4fITcrE0kYyEnxxh1Z
 f2hIMLBJ4+qdSbu0zpNK5H2OhliucZvpYbtncfQsf0yDmsq/zmzN3bKdxTrpiyyYo5oXH1J51We
 jwbJ//k8Pre452MzcmelQU9gCZk3vPbULYSAPudOUWAUoNbdYSbrFGxDCUVwlfl5IVQwi4sLOyy
 CNSu53fRcV8UeqR1oafTRzHv/8r3rBWBheLkFffB5x9jbqutBawh35dlE6TgCe+FAz3vAhBPKJG
 eOWx1BviVfvqh8g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:akpm@linux-foundation.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22311-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 640CA64A4C6

From: Chuck Lever <chuck.lever@oracle.com>

Access control mechanisms sometimes need to match metadata tags
between a session and a resource. A tagset provides efficient
membership testing and set intersection operations for this purpose.

The implementation uses a sorted array of string pointers. Unlike
hash tables, sorted arrays support efficient intersection without
needing to iterate one set and probe the other. Unlike rbtrees,
they require no per-element node allocation, minimizing memory
overhead for small sets typical of resource tagging.

Operation complexities:

  - tagset_add():          O(1)
  - tagset_finalize():     O(N log N) for sorting and deduplication
  - tagset_is_member():    O(log N) via binary search
  - tagset_intersection(): O(N + M) via merge comparison

The API follows a build-then-query pattern: callers initialize,
allocate capacity, add tags, then finalize before querying. Once
finalized, the tagset is suitable for concurrent read access.

Consumers of the new APIs will be introduced in subsequent patches.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/core-api/index.rst  |   1 +
 Documentation/core-api/tagset.rst | 225 ++++++++++++++++++++++++++++++++++++++
 include/linux/tagset.h            | 187 +++++++++++++++++++++++++++++++
 lib/Makefile                      |   1 +
 lib/tagset.c                      | 174 +++++++++++++++++++++++++++++
 5 files changed, 588 insertions(+)

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 13769d5c40bf..d48c074e6b12 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -45,6 +45,7 @@ Library functionality that is used throughout the kernel.
    idr
    circular-buffers
    rbtree
+   tagset
    generic-radix-tree
    packing
    this_cpu_ops
diff --git a/Documentation/core-api/tagset.rst b/Documentation/core-api/tagset.rst
new file mode 100644
index 000000000000..2945cfa95ab4
--- /dev/null
+++ b/Documentation/core-api/tagset.rst
@@ -0,0 +1,225 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+======
+Tagset
+======
+
+Overview
+========
+
+A tagset is a set of strings, intended for resource tagging where
+metadata about a resource is represented simply by a name. The public
+API can be found in ``<linux/tagset.h>``.
+
+
+Initialization and Destruction
+==============================
+
+A tagset must be initialized before use::
+
+    struct tagset tags;
+    tagset_init(&tags);
+
+Before adding tags, allocate capacity::
+
+    if (!tagset_alloc(&tags, num_tags, GFP_KERNEL))
+        return -ENOMEM;
+
+When finished, release all resources::
+
+    tagset_destroy(&tags);
+
+This frees all tag strings and the array. The tagset is reinitialized
+and may be reused by calling ``tagset_alloc()`` again.
+
+
+Adding Tags
+===========
+
+Two functions are provided for adding tags. Both require that
+sufficient capacity has been allocated via ``tagset_alloc()``.
+All functions that allocate memory return false on failure; callers
+should check return values.
+
+``tagset_add()``
+    Adds a tag string that is already in kmalloc'd memory. On success,
+    the tagset takes ownership of the string and will free it when
+    the tagset is destroyed::
+
+        char *tag = kstrdup("mytag", GFP_KERNEL);
+        if (!tag || !tagset_add(&tags, tag))
+            kfree(tag);  /* failed, caller must free */
+
+``tagset_add_dup()``
+    Duplicates the tag string internally. The caller retains ownership
+    of the original string::
+
+        if (!tagset_add_dup(&tags, "mytag", GFP_KERNEL))
+            return -ENOMEM;
+
+Both functions return true on success, false on failure. Tags must
+not be added after ``tagset_finalize()`` has been called. Use
+``GFP_ATOMIC`` when adding tags in atomic context.
+
+
+Finalizing
+==========
+
+After adding all tags, the tagset must be finalized before querying::
+
+    tagset_finalize(&tags);
+
+This sorts the array to enable efficient binary search and removes
+any duplicate tags. Calling ``tagset_is_member()`` or
+``tagset_intersection()`` on a non-finalized tagset produces
+undefined results.
+
+
+Querying Tags
+=============
+
+``tagset_is_empty()``
+    Returns true if the tagset contains no tags.
+
+``tagset_count()``
+    Returns the number of tags in the tagset. Before finalization,
+    this is the number of tags added; after finalization, this is
+    the number of unique tags.
+
+``tagset_is_member()``
+    Returns true if a tag is present in the tagset. Uses binary
+    search for O(log N) complexity::
+
+        if (tagset_is_member(&tags, "mytag"))
+            pr_info("tag found\n");
+
+``tagset_intersection()``
+    Returns true if two tagsets share at least one common tag.
+    Uses merge-style comparison for O(N+M) complexity::
+
+        if (tagset_intersection(&tags1, &tags2))
+            pr_info("sets overlap\n");
+
+
+Iteration
+=========
+
+Use ``tagset_for_each()`` to iterate over all tags::
+
+    unsigned int index;
+    char *tag;
+
+    tagset_for_each(&tags, index, tag)
+        pr_info("tag: %s\n", tag);
+
+Callers should not depend on the order in which tags are returned.
+Modifying the tagset during iteration produces undefined behavior.
+
+
+Copying
+=======
+
+``tagset_copy()`` duplicates all tags from one tagset to another::
+
+    struct tagset copy;
+    if (!tagset_copy(&copy, &original, GFP_KERNEL))
+        pr_err("copy failed\n");
+
+The source tagset should be finalized before copying. The destination
+tagset is initialized and ready for queries after this function
+returns (no separate ``tagset_finalize()`` call is needed). Each tag
+string is duplicated, so the two tagsets are fully independent after
+copying.
+
+
+Typical Usage Pattern
+=====================
+
+A typical usage pattern for building a tagset::
+
+    struct tagset tags;
+
+    tagset_init(&tags);
+    if (!tagset_alloc(&tags, count, GFP_KERNEL))
+        return -ENOMEM;
+
+    for (i = 0; i < count; i++) {
+        if (!tagset_add_dup(&tags, strings[i], GFP_KERNEL)) {
+            tagset_destroy(&tags);
+            return -ENOMEM;
+        }
+    }
+    tagset_finalize(&tags);
+
+    /* Now safe to query */
+    if (tagset_is_member(&tags, "target"))
+        do_something();
+
+    tagset_destroy(&tags);
+
+
+Thread Safety
+=============
+
+Tagsets have no internal locking. Callers provide synchronization
+between writers and readers.
+
+The build-and-finalize phase mutates the tagset; the post-finalize
+query phase reads from it. The two phases must be separated by a
+publication boundary, because ``tagset_finalize()`` itself carries
+no memory barrier. A reader that observes the finalized tagset
+before the writer's stores have propagated may see a stale
+``ts_count`` or a partially populated ``ts_tags[]`` array.
+
+Three publication patterns are sufficient:
+
+* Lock release after ``tagset_finalize()``, lock acquire before
+  each query. The matching unlock/lock pair supplies release and
+  acquire ordering.
+
+* ``rcu_assign_pointer()`` of the tagset pointer after
+  ``tagset_finalize()``, paired with ``rcu_dereference()`` inside
+  an RCU read-side critical section on the reader.
+
+* ``smp_store_release()`` of the tagset pointer after
+  ``tagset_finalize()``, paired with ``smp_load_acquire()`` on the
+  reader.
+
+Once published, the tagset must remain immutable until no further
+readers can observe it. ``tagset_destroy()`` is not safe against
+concurrent readers, and ``tagset_finalize()`` must not be called
+more than once. With RCU publication, callers typically defer
+destruction to a grace period (``synchronize_rcu()`` before
+``tagset_destroy()``, or ``tagset_destroy()`` from a
+``call_rcu()`` callback) so that in-flight readers drain before
+the storage is freed.
+
+
+Implementation
+==============
+
+Each tagset is rooted on the following structure::
+
+    struct tagset {
+            char         **ts_tags;
+            unsigned int   ts_count;
+            unsigned int   ts_capacity;
+            bool           ts_finalized;
+    };
+
+The implementation uses a sorted array of string pointers, providing
+O(log N) membership testing and O(N+M) intersection operations.
+
++------------------------+-------------+
+| Operation              | Complexity  |
++========================+=============+
+| tagset_add             | O(1)        |
++------------------------+-------------+
+| tagset_finalize        | O(N log N)  |
++------------------------+-------------+
+| tagset_is_member       | O(log N)    |
++------------------------+-------------+
+| tagset_intersection    | O(N + M)    |
++------------------------+-------------+
+| tagset_copy            | O(N)        |
++------------------------+-------------+
diff --git a/include/linux/tagset.h b/include/linux/tagset.h
new file mode 100644
index 000000000000..8b0a58add8fc
--- /dev/null
+++ b/include/linux/tagset.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Tagsets
+ *
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * A tagset is a set of strings. See
+ * Documentation/core-api/tagset.rst for how to use tagsets.
+ *
+ * Tagsets have no internal locking. Callers provide synchronization
+ * between writers and readers, including a release/acquire (RCU, or
+ * matching unlock/lock) publication boundary between tagset_finalize()
+ * and the first concurrent query, and a grace period (or equivalent
+ * reader drain) before tagset_destroy(). See the Thread Safety section
+ * of Documentation/core-api/tagset.rst.
+ */
+
+#ifndef _LINUX_TAGSET_H
+#define _LINUX_TAGSET_H
+
+#include <linux/bug.h>
+#include <linux/slab.h>
+
+struct tagset {
+	char		**ts_tags;
+	unsigned int	ts_count;
+	unsigned int	ts_capacity;
+	bool		ts_finalized;
+};
+
+#define TAGSET_INIT \
+	{ .ts_tags = NULL, .ts_count = 0, .ts_capacity = 0, .ts_finalized = false }
+#define DEFINE_TAGSET(name) \
+	struct tagset name = TAGSET_INIT
+
+/**
+ * tagset_for_each - Iterate over items in a tagset
+ * @set: An initialized tagset containing zero or more items
+ * @index: Index counter for the iteration
+ * @tag: Tag retrieved from the tagset
+ */
+#define tagset_for_each(set, index, tag) \
+	for ((index) = 0; (index) < (set)->ts_count && \
+	     ((tag) = (set)->ts_tags[index], true); (index)++)
+
+/**
+ * tagset_init - Initialize an empty tagset
+ * @set: tagset to be initialized
+ */
+static inline void tagset_init(struct tagset *set)
+{
+	set->ts_tags = NULL;
+	set->ts_count = 0;
+	set->ts_capacity = 0;
+	set->ts_finalized = false;
+}
+
+/**
+ * tagset_alloc - Pre-allocate space for tags
+ * @set: An initialized tagset
+ * @capacity: Number of tags to allocate space for
+ * @gfp: Memory allocation flags
+ *
+ * This function may only be called once per tagset. Calling it on a
+ * tagset that has already been allocated returns failure.
+ *
+ * @capacity may be zero. The tagset then represents an empty set:
+ * tagset_add() rejects further additions, and tagset_finalize(),
+ * tagset_is_member(), tagset_intersection(), and tagset_destroy()
+ * all handle it correctly. The same state is produced by
+ * DEFINE_TAGSET() and tagset_init() alone, so callers that know the
+ * set is empty may skip tagset_alloc() entirely.
+ *
+ * Return:
+ *   %true: allocation succeeded (or @capacity was zero)
+ *   %false: allocation failed or tagset already allocated
+ */
+static inline __must_check bool
+tagset_alloc(struct tagset *set, unsigned int capacity, gfp_t gfp)
+{
+	if (set->ts_tags)
+		return false;
+	if (capacity == 0)
+		return true;
+
+	set->ts_tags = kcalloc(capacity, sizeof(char *), gfp);
+	if (!set->ts_tags)
+		return false;
+	set->ts_capacity = capacity;
+	return true;
+}
+
+/**
+ * tagset_is_empty - Determine if a tagset contains any tags
+ * @set: An initialized tagset to be checked
+ *
+ * Return:
+ *    %true: if @set is empty
+ *    %false: if @set contains one or more tags
+ */
+static inline bool tagset_is_empty(const struct tagset *set)
+{
+	return set->ts_count == 0;
+}
+
+/**
+ * tagset_count - Return the number of tags in a tagset
+ * @set: An initialized tagset to be checked
+ *
+ * If called before tagset_finalize(), returns the number of tags
+ * added. If called after, returns the number of unique tags.
+ *
+ * Return:
+ *    The number of tags in @set
+ */
+static inline unsigned int tagset_count(const struct tagset *set)
+{
+	return set->ts_count;
+}
+
+/**
+ * tagset_add - Add a tag to a tagset
+ * @set: An initialized tagset with available capacity
+ * @tag: non-NULL tag string to be added to @set, in kmalloc'd memory
+ *
+ * On success, @tag is now owned by @set and will be freed either
+ * by tagset_finalize() (if a content duplicate) or tagset_destroy().
+ * The tagset must have been allocated with sufficient capacity via
+ * tagset_alloc(). Tags must not be added after tagset_finalize() has
+ * been called. Callers must not hand the same pointer to tagset_add()
+ * more than once: ownership has already transferred, and a second add
+ * produces a double-free at tagset_destroy().
+ *
+ * Return:
+ *   %true: @tag is now a member of @set
+ *   %false: @tag could not be added (NULL or no capacity)
+ */
+static inline __must_check bool
+tagset_add(struct tagset *set, char *tag)
+{
+	if (WARN_ON_ONCE(set->ts_finalized))
+		return false;
+	if (!tag || set->ts_count >= set->ts_capacity)
+		return false;
+	set->ts_tags[set->ts_count++] = tag;
+	return true;
+}
+
+/**
+ * tagset_add_dup - Add a copy of a tag to a tagset
+ * @set: An initialized tagset with available capacity
+ * @tag: non-NULL tag string to be copied and added to @set
+ * @gfp: Memory allocation flags
+ *
+ * On success, @tag will have been copied into a kmalloc'd
+ * buffer. The caller can release @tag immediately. Tags must not
+ * be added after tagset_finalize() has been called.
+ *
+ * Return:
+ *   %true: @tag is now a member of @set
+ *   %false: @tag could not be added (NULL, no capacity, or ENOMEM)
+ */
+static inline __must_check bool
+tagset_add_dup(struct tagset *set, const char *tag, gfp_t gfp)
+{
+	char *entry;
+
+	if (WARN_ON_ONCE(set->ts_finalized))
+		return false;
+	if (!tag || set->ts_count >= set->ts_capacity)
+		return false;
+	entry = kstrdup(tag, gfp);
+	if (!entry)
+		return false;
+	set->ts_tags[set->ts_count++] = entry;
+	return true;
+}
+
+/* Implemented in lib/tagset.c */
+void tagset_finalize(struct tagset *set);
+void tagset_destroy(struct tagset *set);
+bool tagset_is_member(const struct tagset *set, const char *tag);
+bool tagset_copy(struct tagset *dest, const struct tagset *src, gfp_t gfp);
+bool tagset_intersection(const struct tagset *set1, const struct tagset *set2);
+
+#endif /* _LINUX_TAGSET_H */
diff --git a/lib/Makefile b/lib/Makefile
index f33a24bf1c19..4f3be192be5b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -61,6 +61,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 generic-radix-tree.o bitmap-str.o
 obj-y += string_helpers.o
 obj-y += hexdump.o
+obj-y += tagset.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
diff --git a/lib/tagset.c b/lib/tagset.c
new file mode 100644
index 000000000000..a7e09895e370
--- /dev/null
+++ b/lib/tagset.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tagsets - a sorted set of strings
+ *
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ */
+
+#include <linux/bug.h>
+#include <linux/export.h>
+#include <linux/sort.h>
+#include <linux/tagset.h>
+
+static int tagset_cmp(const void *a, const void *b)
+{
+	const char * const *sa = a;
+	const char * const *sb = b;
+
+	return strcmp(*sa, *sb);
+}
+
+/**
+ * tagset_finalize - Sort the tagset and remove duplicates
+ * @set: An initialized tagset that has been populated
+ *
+ * This must be called after all tags have been added and before
+ * calling tagset_is_member() or tagset_intersection(). Duplicate
+ * tags are removed and their memory is freed.
+ */
+void tagset_finalize(struct tagset *set)
+{
+	unsigned int i, j;
+
+	if (WARN_ON_ONCE(set->ts_finalized))
+		return;
+	if (set->ts_count > 1) {
+		sort(set->ts_tags, set->ts_count, sizeof(char *),
+		     tagset_cmp, NULL);
+
+		/* Remove duplicates in place */
+		for (i = 0, j = 1; j < set->ts_count; j++) {
+			if (strcmp(set->ts_tags[i], set->ts_tags[j]) == 0)
+				kfree(set->ts_tags[j]);
+			else
+				set->ts_tags[++i] = set->ts_tags[j];
+		}
+		set->ts_count = i + 1;
+	}
+	set->ts_finalized = true;
+}
+EXPORT_SYMBOL_GPL(tagset_finalize);
+
+/**
+ * tagset_destroy - Release tagset resources
+ * @set: tagset to be destroyed
+ */
+void tagset_destroy(struct tagset *set)
+{
+	unsigned int i;
+
+	for (i = 0; i < set->ts_count; i++)
+		kfree(set->ts_tags[i]);
+	kfree(set->ts_tags);
+	tagset_init(set);
+}
+EXPORT_SYMBOL_GPL(tagset_destroy);
+
+/**
+ * tagset_is_member - Check if a tag is already a member of a tagset
+ * @set: An initialized and finalized tagset to be checked
+ * @tag: tag string to search for
+ *
+ * Uses binary search. The tagset must have been finalized first.
+ *
+ * Return:
+ *   %true: if @tag is a member of @set
+ *   %false: if @tag is not a member of @set
+ */
+bool tagset_is_member(const struct tagset *set, const char *tag)
+{
+	unsigned int low = 0, high = set->ts_count;
+
+	WARN_ON_ONCE(!set->ts_finalized);
+	while (low < high) {
+		unsigned int mid = low + (high - low) / 2;
+		int cmp = strcmp(tag, set->ts_tags[mid]);
+
+		if (cmp == 0)
+			return true;
+		if (cmp < 0)
+			high = mid;
+		else
+			low = mid + 1;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(tagset_is_member);
+
+/**
+ * tagset_copy - Duplicate tags to another tagset
+ * @dest: An empty, initialized tagset to be filled
+ * @src: An initialized tagset to be copied from
+ * @gfp: Memory allocation flags
+ *
+ * @dest must be initialized -- via TAGSET_INIT, DEFINE_TAGSET,
+ * tagset_init(), or a prior tagset_destroy() -- and must hold no
+ * tags. Passing a populated tagset leaks its contents.
+ *
+ * On success @dest is populated and ready for use; no call to
+ * tagset_finalize() is required. On failure @dest is left as an
+ * empty, finalized tagset, so callers can safely run queries
+ * against it without first checking the return value.
+ *
+ * Return:
+ *   %true: All tags in @src were copied to @dest
+ *   %false: A failure occurred; @dest is empty and finalized
+ */
+bool tagset_copy(struct tagset *dest, const struct tagset *src, gfp_t gfp)
+{
+	unsigned int i;
+
+	/* src is already sorted, so dest is too */
+	dest->ts_finalized = src->ts_finalized;
+	if (src->ts_count == 0)
+		return true;
+	if (!tagset_alloc(dest, src->ts_count, gfp))
+		goto out_fail;
+	for (i = 0; i < src->ts_count; i++) {
+		char *entry = kstrdup(src->ts_tags[i], gfp);
+
+		if (!entry)
+			goto out_fail;
+		dest->ts_tags[dest->ts_count++] = entry;
+	}
+	return true;
+
+out_fail:
+	tagset_destroy(dest);
+	dest->ts_finalized = true;
+	return false;
+}
+EXPORT_SYMBOL_GPL(tagset_copy);
+
+/**
+ * tagset_intersection - Report if there are common tags
+ * @set1: An initialized and finalized tagset
+ * @set2: Another initialized and finalized tagset
+ *
+ * Uses merge-style comparison of two sorted arrays for O(N+M)
+ * complexity.
+ *
+ * Return:
+ *   %true: @set1 and @set2 have at least one common tag
+ *   %false: @set1 and @set2 have no tags in common
+ */
+bool tagset_intersection(const struct tagset *set1, const struct tagset *set2)
+{
+	unsigned int i = 0, j = 0;
+
+	WARN_ON_ONCE(!set1->ts_finalized);
+	WARN_ON_ONCE(!set2->ts_finalized);
+	while (i < set1->ts_count && j < set2->ts_count) {
+		int cmp = strcmp(set1->ts_tags[i], set2->ts_tags[j]);
+
+		if (cmp == 0)
+			return true;
+		if (cmp < 0)
+			i++;
+		else
+			j++;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(tagset_intersection);

-- 
2.54.0


