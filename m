Return-Path: <linux-nfs+bounces-20384-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHGoDkD2w2nPvAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20384-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:50:40 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E5E327215
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB39E30AE616
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 14:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB7D3F9F21;
	Wed, 25 Mar 2026 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKfLt3zn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA1A3E92B8;
	Wed, 25 Mar 2026 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449668; cv=none; b=FLHw2TDioqJHaw7hq34cn6LhRchTbhziU0Tk/ayk1/z6FH9IkJAI+zeWtVtL9SNTjrIuo2+oacOPKTuXWIeKWLdmLBHVndSJftKHuWNW2W/KW/T3juNoCAvbfvRExDxJ456mVm8LiWqnVUXv+mFlPTmX5SIAK5rpbddJdj5ifiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449668; c=relaxed/simple;
	bh=B5cTEaTEQdv9Xn8c4Db3TBkvHKsiNik7N964sW/pSBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P1AEtU5b0CdEmyKM5meRfHpUT9uPXkI2hOq9XXXsejmF9gv+XioR0SFfIgxPO4S+5Jnk+OnkMhWTz4i1r7a6QD/JWxYyOX3PqFl7FA66q+5gVPkEInQXZ4wLM0/Cl+Ahz6aFULgb5v7kp2AXWr559GqWWllBgfHi0x+dP58tJ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKfLt3zn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A37DC2BCB2;
	Wed, 25 Mar 2026 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449668;
	bh=B5cTEaTEQdv9Xn8c4Db3TBkvHKsiNik7N964sW/pSBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IKfLt3znCubLoBKGVsyJJ/VRvshQEUkFM3/reAdF4h/XLeiM+Z9ZLK4i5twq0h+H7
	 8B7diqjCrQM/cVT5t4JOYMLFZz0pTSQQHHTBiwYWh1XWJWAmrcpi3ZmoY5BriLHO9R
	 Op2n9cVWClvahFPB/A1tR4GRKh7sy81wBcR9evIWe/8oXBil5b1DEP4/jhLUK4iY1o
	 1bAO2pKaEfyq3mc31yhWEeiajfqKN5K6gp2/1POi3pnR//dq20pLhxQf13Xm81me2d
	 mKLnzZbmNM8KOA5ZYEaP+CthgSIEOVn5Oei2WnCpWPfKk9C5ZWW5XV/yBX/ScaOGc5
	 zkkpdIcu7kvug==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 25 Mar 2026 10:40:31 -0400
Subject: [PATCH v2 10/13] nfsd: add netlink upcall for the svc_export cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-exportd-netlink-v2-10-067df016ea95@kernel.org>
References: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
In-Reply-To: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=32341; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=B5cTEaTEQdv9Xn8c4Db3TBkvHKsiNik7N964sW/pSBU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpw/PvUSU32e3ZytmElrEvuvrOaPMP/9olcgvhf
 CWIQp1Ni52JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacPz7wAKCRAADmhBGVaC
 FeFAD/9EKCZk7Wuvno5gmLbSetNpNNQNjWWQB3yje8NBMQa3Q+3mM6izjoPl+qMegm7DvmUhbUI
 lMtRvZxOTKeWlKQglwwjwdYuIbqosZd2CmmGcdi0GDNSiUDa9cM2gdS4IKiOREG/uPMF5NgQ5bu
 OLWLfQxR1i71IUifCtrdODaYMnaJoSBtqmA9F6wlq+fxXCCBNtwc9DDkJv/9SaVKC71Z/xyUsP/
 kX3gGZxq14yY3gzugm8ybGg6aA6PNFLigAwZzFIpUI3jQhAj3qxQl18ZKvFvlZGdJrQSS+Kt9+f
 4Z47sbPV6PdAwgbYPTh3mIuxkwNwKZFJcDo5PKZj3N6iA2saHs/SiYY8wmQ+5o20DZJT/ehq/tq
 eLVWf/piFlvLjFd7n6YLjh+/2wJ6s4YjwDTUw5C3K7279HP7N5u1wA4XQpknBT7JsiqiDBmIQuR
 PDTk0WShC/sALGuDrtvX3P6Odj6agCdkulCu3darURAB1YPRNfHz6XpLoqOvv2amPxY+RwpvRgM
 iDTgphbr9nclr+rL9d9tXD7hNvoy1bo0cN2aN1cUjqc8ZvXD6VH3wVFuDlczbb+HE0mJLs36mJd
 +o20iB0rMPgGM0OGb0AKodz2P79EN5toYQbuQOE9MvLUum8TEzEZdqdI+DFrMC0rP3lm4DTHsRn
 c99lW5mhslwbamw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20384-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6E5E327215
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add netlink-based cache upcall support for the svc_export (nfsd.export)
cache to Documentation/netlink/specs/nfsd.yaml and regenerate the
resulting files.

Implement nfsd_cache_notify() which sends a NFSD_CMD_CACHE_NOTIFY
multicast event to the "exportd" group, carrying the cache type so
userspace knows which cache has pending requests.

Implement nfsd_nl_svc_export_get_reqs_dumpit() which snapshots
pending svc_export cache requests and sends each entry's seqno,
client name, and path over netlink.

Implement nfsd_nl_svc_export_set_reqs_doit() which parses svc_export
cache responses from userspace (client, path, expiry, flags, anon
uid/gid, fslocations, uuid, secinfo, xprtsec, fsid, or negative
flag) and updates the cache via svc_export_lookup() /
svc_export_update().

Wire up the svc_export_notify() callback in svc_export_cache_template
so cache misses trigger NFSD_CMD_CACHE_NOTIFY multicast events with
NFSD_CACHE_TYPE_SVC_EXPORT.

Note that the export-flags and xprtsec-mode enums are organized to match
their counterparts in include/uapi/linux/nfsd/export.h. The intent is
that future export options will only be added to the netlink headers,
which should eliminate the need to keep so much in sync.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml | 174 +++++++++++++
 fs/nfsd/export.c                      | 443 +++++++++++++++++++++++++++++++++-
 fs/nfsd/netlink.c                     |  61 +++++
 fs/nfsd/netlink.h                     |  13 +
 fs/nfsd/nfsctl.c                      |  28 +++
 fs/nfsd/nfsd.h                        |   2 +-
 include/uapi/linux/nfsd_netlink.h     | 110 +++++++++
 net/sunrpc/netlink.c                  |  17 +-
 net/sunrpc/netlink.h                  |   3 +-
 9 files changed, 835 insertions(+), 16 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 8ab43c8253b2e83bcc178c3f4fe8c41c2997d153..709751502f8b56bd4b68462fa15337df5e3e035e 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -6,7 +6,51 @@ uapi-header: linux/nfsd_netlink.h
 
 doc: NFSD configuration over generic netlink.
 
+definitions:
+  -
+    type: flags
+    name: cache-type
+    entries: [svc_export]
+  -
+    type: flags
+    name: export-flags
+    doc: These flags are ordered to match the NFSEXP_* flags in include/linux/nfsd/export.h
+    entries:
+      - readonly
+      - insecure-port
+      - rootsquash
+      - allsquash
+      - async
+      - gathered-writes
+      - noreaddirplus
+      - security-label
+      - sign-fh
+      - nohide
+      - nosubtreecheck
+      - noauthnlm
+      - msnfs
+      - fsid
+      - crossmount
+      - noacl
+      - v4root
+      - pnfs
+  -
+    type: flags
+    name: xprtsec-mode
+    doc: These flags are ordered to match the NFSEXP_XPRTSEC_* flags in include/linux/nfsd/export.h
+    entries:
+      - none
+      - tls
+      - mtls
+
 attribute-sets:
+  -
+    name: cache-notify
+    attributes:
+      -
+        name: cache-type
+        type: u32
+        enum: cache-type
   -
     name: rpc-status
     attributes:
@@ -132,6 +176,103 @@ attribute-sets:
       -
         name: npools
         type: u32
+  -
+    name: fslocation
+    attributes:
+      -
+        name: host
+        type: string
+      -
+        name: path
+        type: string
+  -
+    name: fslocations
+    attributes:
+      -
+        name: location
+        type: nest
+        nested-attributes: fslocation
+        multi-attr: true
+  -
+    name: auth-flavor
+    attributes:
+      -
+        name: pseudoflavor
+        type: u32
+      -
+        name: flags
+        type: u32
+        enum: export-flags
+        enum-as-flags: true
+  -
+    name: svc-export-req
+    attributes:
+      -
+        name: seqno
+        type: u64
+      -
+        name: client
+        type: string
+      -
+        name: path
+        type: string
+  -
+    name: svc-export
+    attributes:
+      -
+        name: seqno
+        type: u64
+      -
+        name: client
+        type: string
+      -
+        name: path
+        type: string
+      -
+        name: negative
+        type: flag
+      -
+        name: expiry
+        type: u64
+      -
+        name: anon-uid
+        type: u32
+      -
+        name: anon-gid
+        type: u32
+      -
+        name: fslocations
+        type: nest
+        nested-attributes: fslocations
+      -
+        name: uuid
+        type: binary
+      -
+        name: secinfo
+        type: nest
+        nested-attributes: auth-flavor
+        multi-attr: true
+      -
+        name: xprtsec
+        type: u32
+        enum: xprtsec-mode
+        multi-attr: true
+      -
+        name: flags
+        type: u32
+        enum: export-flags
+        enum-as-flags: true
+      -
+        name: fsid
+        type: s32
+  -
+    name: svc-export-reqs
+    attributes:
+      -
+        name: requests
+        type: nest
+        nested-attributes: svc-export
+        multi-attr: true
 
 operations:
   list:
@@ -233,3 +374,36 @@ operations:
           attributes:
             - mode
             - npools
+    -
+      name: cache-notify
+      doc: Notification that there are cache requests that need servicing
+      attribute-set: cache-notify
+      mcgrp: exportd
+      event:
+        attributes:
+          - cache-type
+    -
+      name: svc-export-get-reqs
+      doc: Dump all pending svc_export requests
+      attribute-set: svc-export-reqs
+      flags: [admin-perm]
+      dump:
+          request:
+            attributes:
+              - requests
+    -
+      name: svc-export-set-reqs
+      doc: Respond to one or more svc_export requests
+      attribute-set: svc-export-reqs
+      flags: [admin-perm]
+      do:
+          request:
+            attributes:
+              - requests
+
+mcast-groups:
+  list:
+    -
+      name: none
+    -
+      name: exportd
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index e83e88e69d90ab48c7aff58ac2b36cd1a6e1bb71..cfe542fd7b22e27a7971a1f792061767068ac439 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -17,6 +17,8 @@
 #include <linux/module.h>
 #include <linux/exportfs.h>
 #include <linux/sunrpc/svc_xprt.h>
+#include <net/genetlink.h>
+#include <uapi/linux/nfsd_netlink.h>
 
 #include "nfsd.h"
 #include "nfsfh.h"
@@ -24,6 +26,7 @@
 #include "pnfs.h"
 #include "filecache.h"
 #include "trace.h"
+#include "netlink.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_EXPORT
 
@@ -386,11 +389,446 @@ static void svc_export_put(struct kref *ref)
 	queue_rcu_work(nfsd_export_wq, &exp->ex_rwork);
 }
 
+/**
+ * nfsd_nl_svc_export_get_reqs_dumpit - dump pending svc_export requests
+ * @skb: reply buffer
+ * @cb: netlink metadata and command arguments
+ *
+ * Walk the svc_export cache's pending request list and create a netlink
+ * message with a nested entry for each cache_request, containing the
+ * seqno, client string, and path.
+ *
+ * Uses cb->args[0] as a seqno cursor for dump continuation across
+ * multiple netlink messages.
+ *
+ * Returns the size of the reply or a negative errno.
+ */
+int nfsd_nl_svc_export_get_reqs_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb)
+{
+	struct nfsd_net *nn;
+	struct cache_detail *cd;
+	struct cache_head **items;
+	u64 *seqnos;
+	int cnt, i, emitted;
+	char *pathbuf;
+	void *hdr;
+	int ret;
+
+	nn = net_generic(sock_net(skb->sk), nfsd_net_id);
+
+	mutex_lock(&nfsd_mutex);
+
+	cd = nn->svc_export_cache;
+	if (!cd) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	cnt = sunrpc_cache_requests_count(cd);
+	if (!cnt) {
+		ret = 0;
+		goto out_unlock;
+	}
+
+	items = kcalloc(cnt, sizeof(*items), GFP_KERNEL);
+	seqnos = kcalloc(cnt, sizeof(*seqnos), GFP_KERNEL);
+	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!items || !seqnos || !pathbuf) {
+		ret = -ENOMEM;
+		goto out_alloc;
+	}
+
+	cnt = sunrpc_cache_requests_snapshot(cd, items, seqnos, cnt,
+					     cb->args[0]);
+	if (!cnt) {
+		ret = 0;
+		goto out_alloc;
+	}
+
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+			  cb->nlh->nlmsg_seq, &nfsd_nl_family,
+			  NLM_F_MULTI, NFSD_CMD_SVC_EXPORT_GET_REQS);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto out_put;
+	}
+
+	emitted = 0;
+	for (i = 0; i < cnt; i++) {
+		struct svc_export *exp;
+		struct nlattr *nest;
+		char *pth;
+
+		exp = container_of(items[i], struct svc_export, h);
+
+		pth = d_path(&exp->ex_path, pathbuf, PATH_MAX);
+		if (IS_ERR(pth))
+			continue;
+
+		nest = nla_nest_start(skb,
+				      NFSD_A_SVC_EXPORT_REQS_REQUESTS);
+		if (!nest)
+			break;
+
+		if (nla_put_u64_64bit(skb, NFSD_A_SVC_EXPORT_SEQNO,
+				      seqnos[i], 0) ||
+		    nla_put_string(skb, NFSD_A_SVC_EXPORT_CLIENT,
+				   exp->ex_client->name) ||
+		    nla_put_string(skb, NFSD_A_SVC_EXPORT_PATH, pth)) {
+			nla_nest_cancel(skb, nest);
+			break;
+		}
+
+		nla_nest_end(skb, nest);
+		cb->args[0] = seqnos[i];
+		emitted++;
+	}
+
+	if (!emitted) {
+		genlmsg_cancel(skb, hdr);
+		ret = -EMSGSIZE;
+		goto out_put;
+	}
+
+	genlmsg_end(skb, hdr);
+	ret = skb->len;
+out_put:
+	for (i = 0; i < cnt; i++)
+		cache_put(items[i], cd);
+out_alloc:
+	kfree(pathbuf);
+	kfree(seqnos);
+	kfree(items);
+out_unlock:
+	mutex_unlock(&nfsd_mutex);
+	return ret;
+}
+
+/**
+ * nfsd_nl_parse_fslocations - parse fslocations from netlink
+ * @attr: NFSD_A_SVC_EXPORT_FSLOCATIONS nested attribute
+ * @fsloc: fslocations struct to fill in
+ *
+ * Returns 0 on success or a negative errno.
+ */
+static int nfsd_nl_parse_fslocations(struct nlattr *attr,
+				     struct nfsd4_fs_locations *fsloc)
+{
+	struct nlattr *loc_attr;
+	int rem, count = 0;
+	int err;
+
+	if (fsloc->locations)
+		return -EINVAL;
+
+	/* Count locations first */
+	nla_for_each_nested_type(loc_attr, NFSD_A_FSLOCATIONS_LOCATION,
+				 attr, rem)
+		count++;
+
+	if (count > MAX_FS_LOCATIONS)
+		return -EINVAL;
+	if (!count)
+		return 0;
+
+	fsloc->locations = kcalloc(count, sizeof(struct nfsd4_fs_location),
+				   GFP_KERNEL);
+	if (!fsloc->locations)
+		return -ENOMEM;
+
+	nla_for_each_nested_type(loc_attr, NFSD_A_FSLOCATIONS_LOCATION,
+				 attr, rem) {
+		struct nlattr *tb[NFSD_A_FSLOCATION_PATH + 1];
+		struct nfsd4_fs_location *loc;
+
+		err = nla_parse_nested(tb, NFSD_A_FSLOCATION_PATH, loc_attr,
+				       nfsd_fslocation_nl_policy, NULL);
+		if (err)
+			goto out_free;
+
+		if (!tb[NFSD_A_FSLOCATION_HOST] ||
+		    !tb[NFSD_A_FSLOCATION_PATH]) {
+			err = -EINVAL;
+			goto out_free;
+		}
+
+		loc = &fsloc->locations[fsloc->locations_count++];
+		loc->hosts = kstrdup(nla_data(tb[NFSD_A_FSLOCATION_HOST]),
+				     GFP_KERNEL);
+		loc->path = kstrdup(nla_data(tb[NFSD_A_FSLOCATION_PATH]),
+				    GFP_KERNEL);
+		if (!loc->hosts || !loc->path) {
+			err = -ENOMEM;
+			goto out_free;
+		}
+	}
+
+	return 0;
+out_free:
+	nfsd4_fslocs_free(fsloc);
+	return err;
+}
+
+static struct svc_export *svc_export_update(struct svc_export *new,
+					    struct svc_export *old);
+static struct svc_export *svc_export_lookup(struct svc_export *);
+static int check_export(const struct path *path, int *flags,
+			unsigned char *uuid);
+
+/**
+ * @cd: cache_detail for the svc_export cache
+ * @attr: nested attribute containing svc-export fields
+ *
+ * Parses one svc-export entry from a netlink message and updates the
+ * cache. Mirrors the logic in svc_export_parse().
+ *
+ * Returns 0 on success or a negative errno.
+ */
+static int nfsd_nl_parse_one_export(struct cache_detail *cd,
+				    struct nlattr *attr)
+{
+	struct nlattr *tb[NFSD_A_SVC_EXPORT_FSID + 1];
+	struct auth_domain *dom = NULL;
+	struct svc_export exp = {}, *expp;
+	struct nlattr *secinfo_attr;
+	struct timespec64 boot;
+	int err, rem;
+
+	err = nla_parse_nested(tb, NFSD_A_SVC_EXPORT_FSID, attr,
+			       nfsd_svc_export_nl_policy, NULL);
+	if (err)
+		return err;
+
+	/* client (required) */
+	if (!tb[NFSD_A_SVC_EXPORT_CLIENT])
+		return -EINVAL;
+
+	dom = auth_domain_find(nla_data(tb[NFSD_A_SVC_EXPORT_CLIENT]));
+	if (!dom)
+		return -ENOENT;
+
+	/* path (required) */
+	if (!tb[NFSD_A_SVC_EXPORT_PATH]) {
+		err = -EINVAL;
+		goto out_dom;
+	}
+
+	err = kern_path(nla_data(tb[NFSD_A_SVC_EXPORT_PATH]), 0,
+			&exp.ex_path);
+	if (err)
+		goto out_dom;
+
+	exp.ex_client = dom;
+	exp.cd = cd;
+	exp.ex_devid_map = NULL;
+	exp.ex_xprtsec_modes = NFSEXP_XPRTSEC_ALL;
+
+	/* expiry (required, wallclock seconds) */
+	if (!tb[NFSD_A_SVC_EXPORT_EXPIRY]) {
+		err = -EINVAL;
+		goto out_path;
+	}
+	getboottime64(&boot);
+	exp.h.expiry_time = nla_get_u64(tb[NFSD_A_SVC_EXPORT_EXPIRY]) -
+			    boot.tv_sec;
+
+	if (tb[NFSD_A_SVC_EXPORT_NEGATIVE]) {
+		set_bit(CACHE_NEGATIVE, &exp.h.flags);
+	} else {
+		/* flags */
+		if (tb[NFSD_A_SVC_EXPORT_FLAGS])
+			exp.ex_flags = nla_get_u32(tb[NFSD_A_SVC_EXPORT_FLAGS]);
+
+		/* anon uid */
+		if (tb[NFSD_A_SVC_EXPORT_ANON_UID]) {
+			u32 uid = nla_get_u32(tb[NFSD_A_SVC_EXPORT_ANON_UID]);
+
+			exp.ex_anon_uid = make_kuid(current_user_ns(), uid);
+		}
+
+		/* anon gid */
+		if (tb[NFSD_A_SVC_EXPORT_ANON_GID]) {
+			u32 gid = nla_get_u32(tb[NFSD_A_SVC_EXPORT_ANON_GID]);
+
+			exp.ex_anon_gid = make_kgid(current_user_ns(), gid);
+		}
+
+		/* fsid */
+		if (tb[NFSD_A_SVC_EXPORT_FSID])
+			exp.ex_fsid = nla_get_s32(tb[NFSD_A_SVC_EXPORT_FSID]);
+
+		/* fslocations */
+		if (tb[NFSD_A_SVC_EXPORT_FSLOCATIONS]) {
+			struct nlattr *fsl = tb[NFSD_A_SVC_EXPORT_FSLOCATIONS];
+
+			err = nfsd_nl_parse_fslocations(fsl,
+							&exp.ex_fslocs);
+			if (err)
+				goto out_path;
+		}
+
+		/* uuid */
+		if (tb[NFSD_A_SVC_EXPORT_UUID]) {
+			if (nla_len(tb[NFSD_A_SVC_EXPORT_UUID]) !=
+			    EX_UUID_LEN) {
+				err = -EINVAL;
+				goto out_fslocs;
+			}
+			exp.ex_uuid = kmemdup(nla_data(tb[NFSD_A_SVC_EXPORT_UUID]),
+					      EX_UUID_LEN, GFP_KERNEL);
+			if (!exp.ex_uuid) {
+				err = -ENOMEM;
+				goto out_fslocs;
+			}
+		}
+
+		/* secinfo (multi-attr) */
+		nla_for_each_nested_type(secinfo_attr,
+					 NFSD_A_SVC_EXPORT_SECINFO,
+					 attr, rem) {
+			struct nlattr *ftb[NFSD_A_AUTH_FLAVOR_FLAGS + 1];
+			struct exp_flavor_info *f;
+
+			if (exp.ex_nflavors >= MAX_SECINFO_LIST) {
+				err = -EINVAL;
+				goto out_uuid;
+			}
+
+			err = nla_parse_nested(ftb,
+					       NFSD_A_AUTH_FLAVOR_FLAGS,
+					       secinfo_attr,
+					       nfsd_auth_flavor_nl_policy,
+					       NULL);
+			if (err)
+				goto out_uuid;
+
+			f = &exp.ex_flavors[exp.ex_nflavors++];
+
+			if (ftb[NFSD_A_AUTH_FLAVOR_PSEUDOFLAVOR])
+				f->pseudoflavor = nla_get_u32(ftb[NFSD_A_AUTH_FLAVOR_PSEUDOFLAVOR]);
+
+			if (ftb[NFSD_A_AUTH_FLAVOR_FLAGS])
+				f->flags = nla_get_u32(ftb[NFSD_A_AUTH_FLAVOR_FLAGS]);
+
+			/* Only some flags are allowed to differ between flavors: */
+			if (~NFSEXP_SECINFO_FLAGS & (f->flags ^ exp.ex_flags)) {
+				err = -EINVAL;
+				goto out_uuid;
+			}
+		}
+
+		/* xprtsec (multi-attr u32) */
+		if (tb[NFSD_A_SVC_EXPORT_XPRTSEC]) {
+			struct nlattr *xp_attr;
+
+			exp.ex_xprtsec_modes = 0;
+			nla_for_each_nested_type(xp_attr,
+						 NFSD_A_SVC_EXPORT_XPRTSEC,
+						 attr, rem) {
+				u32 mode = nla_get_u32(xp_attr);
+
+				if (mode > NFSEXP_XPRTSEC_MTLS) {
+					err = -EINVAL;
+					goto out_uuid;
+				}
+				exp.ex_xprtsec_modes |= mode;
+			}
+		}
+
+		err = check_export(&exp.ex_path, &exp.ex_flags,
+				   exp.ex_uuid);
+		if (err)
+			goto out_uuid;
+
+		if (exp.h.expiry_time < seconds_since_boot())
+			goto out_uuid;
+
+		err = -EINVAL;
+		if (!uid_valid(exp.ex_anon_uid))
+			goto out_uuid;
+		if (!gid_valid(exp.ex_anon_gid))
+			goto out_uuid;
+		err = 0;
+
+		nfsd4_setup_layout_type(&exp);
+	}
+
+	expp = svc_export_lookup(&exp);
+	if (!expp) {
+		err = -ENOMEM;
+		goto out_uuid;
+	}
+	expp = svc_export_update(&exp, expp);
+	if (expp) {
+		trace_nfsd_export_update(expp);
+		cache_flush();
+		exp_put(expp);
+	} else {
+		err = -ENOMEM;
+	}
+
+out_uuid:
+	kfree(exp.ex_uuid);
+out_fslocs:
+	nfsd4_fslocs_free(&exp.ex_fslocs);
+out_path:
+	path_put(&exp.ex_path);
+out_dom:
+	auth_domain_put(dom);
+	return err;
+}
+
+/**
+ * nfsd_nl_svc_export_set_reqs_doit - respond to svc_export requests
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Parse one or more svc_export cache responses from userspace and
+ * update the export cache accordingly.
+ *
+ * Returns 0 on success or a negative errno.
+ */
+int nfsd_nl_svc_export_set_reqs_doit(struct sk_buff *skb,
+				     struct genl_info *info)
+{
+	struct nfsd_net *nn;
+	struct cache_detail *cd;
+	const struct nlattr *attr;
+	int rem, ret = 0;
+
+	nn = net_generic(genl_info_net(info), nfsd_net_id);
+
+	mutex_lock(&nfsd_mutex);
+
+	cd = nn->svc_export_cache;
+	if (!cd) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	nlmsg_for_each_attr_type(attr, NFSD_A_SVC_EXPORT_REQS_REQUESTS,
+				 info->nlhdr, GENL_HDRLEN, rem) {
+		ret = nfsd_nl_parse_one_export(cd, (struct nlattr *)attr);
+		if (ret)
+			break;
+	}
+
+out_unlock:
+	mutex_unlock(&nfsd_mutex);
+	return ret;
+}
+
 static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
 {
 	return sunrpc_cache_upcall(cd, h);
 }
 
+static int svc_export_notify(struct cache_detail *cd, struct cache_head *h)
+{
+	return nfsd_cache_notify(cd, h, NFSD_CACHE_TYPE_SVC_EXPORT);
+}
+
 static void svc_export_request(struct cache_detail *cd,
 			       struct cache_head *h,
 			       char **bpp, int *blen)
@@ -410,10 +848,6 @@ static void svc_export_request(struct cache_detail *cd,
 	(*bpp)[-1] = '\n';
 }
 
-static struct svc_export *svc_export_update(struct svc_export *new,
-					    struct svc_export *old);
-static struct svc_export *svc_export_lookup(struct svc_export *);
-
 static int check_export(const struct path *path, int *flags, unsigned char *uuid)
 {
 	struct inode *inode = d_inode(path->dentry);
@@ -907,6 +1341,7 @@ static const struct cache_detail svc_export_cache_template = {
 	.name		= "nfsd.export",
 	.cache_put	= svc_export_put,
 	.cache_upcall	= svc_export_upcall,
+	.cache_notify	= svc_export_notify,
 	.cache_request	= svc_export_request,
 	.cache_parse	= svc_export_parse,
 	.cache_show	= svc_export_show,
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 81c943345d13db849483bf0d6773458115ff0134..fb401d7302afb9e41cb074581f7b94e8ece6cf0c 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -12,11 +12,41 @@
 #include <uapi/linux/nfsd_netlink.h>
 
 /* Common nested types */
+const struct nla_policy nfsd_auth_flavor_nl_policy[NFSD_A_AUTH_FLAVOR_FLAGS + 1] = {
+	[NFSD_A_AUTH_FLAVOR_PSEUDOFLAVOR] = { .type = NLA_U32, },
+	[NFSD_A_AUTH_FLAVOR_FLAGS] = NLA_POLICY_MASK(NLA_U32, 0x3ffff),
+};
+
+const struct nla_policy nfsd_fslocation_nl_policy[NFSD_A_FSLOCATION_PATH + 1] = {
+	[NFSD_A_FSLOCATION_HOST] = { .type = NLA_NUL_STRING, },
+	[NFSD_A_FSLOCATION_PATH] = { .type = NLA_NUL_STRING, },
+};
+
+const struct nla_policy nfsd_fslocations_nl_policy[NFSD_A_FSLOCATIONS_LOCATION + 1] = {
+	[NFSD_A_FSLOCATIONS_LOCATION] = NLA_POLICY_NESTED(nfsd_fslocation_nl_policy),
+};
+
 const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_NAME + 1] = {
 	[NFSD_A_SOCK_ADDR] = { .type = NLA_BINARY, },
 	[NFSD_A_SOCK_TRANSPORT_NAME] = { .type = NLA_NUL_STRING, },
 };
 
+const struct nla_policy nfsd_svc_export_nl_policy[NFSD_A_SVC_EXPORT_FSID + 1] = {
+	[NFSD_A_SVC_EXPORT_SEQNO] = { .type = NLA_U64, },
+	[NFSD_A_SVC_EXPORT_CLIENT] = { .type = NLA_NUL_STRING, },
+	[NFSD_A_SVC_EXPORT_PATH] = { .type = NLA_NUL_STRING, },
+	[NFSD_A_SVC_EXPORT_NEGATIVE] = { .type = NLA_FLAG, },
+	[NFSD_A_SVC_EXPORT_EXPIRY] = { .type = NLA_U64, },
+	[NFSD_A_SVC_EXPORT_ANON_UID] = { .type = NLA_U32, },
+	[NFSD_A_SVC_EXPORT_ANON_GID] = { .type = NLA_U32, },
+	[NFSD_A_SVC_EXPORT_FSLOCATIONS] = NLA_POLICY_NESTED(nfsd_fslocations_nl_policy),
+	[NFSD_A_SVC_EXPORT_UUID] = { .type = NLA_BINARY, },
+	[NFSD_A_SVC_EXPORT_SECINFO] = NLA_POLICY_NESTED(nfsd_auth_flavor_nl_policy),
+	[NFSD_A_SVC_EXPORT_XPRTSEC] = NLA_POLICY_MASK(NLA_U32, 0x7),
+	[NFSD_A_SVC_EXPORT_FLAGS] = NLA_POLICY_MASK(NLA_U32, 0x3ffff),
+	[NFSD_A_SVC_EXPORT_FSID] = { .type = NLA_S32, },
+};
+
 const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
 	[NFSD_A_VERSION_MAJOR] = { .type = NLA_U32, },
 	[NFSD_A_VERSION_MINOR] = { .type = NLA_U32, },
@@ -48,6 +78,16 @@ static const struct nla_policy nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MOD
 	[NFSD_A_POOL_MODE_MODE] = { .type = NLA_NUL_STRING, },
 };
 
+/* NFSD_CMD_SVC_EXPORT_GET_REQS - dump */
+static const struct nla_policy nfsd_svc_export_get_reqs_nl_policy[NFSD_A_SVC_EXPORT_REQS_REQUESTS + 1] = {
+	[NFSD_A_SVC_EXPORT_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_svc_export_nl_policy),
+};
+
+/* NFSD_CMD_SVC_EXPORT_SET_REQS - do */
+static const struct nla_policy nfsd_svc_export_set_reqs_nl_policy[NFSD_A_SVC_EXPORT_REQS_REQUESTS + 1] = {
+	[NFSD_A_SVC_EXPORT_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_svc_export_nl_policy),
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -103,6 +143,25 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.doit	= nfsd_nl_pool_mode_get_doit,
 		.flags	= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_SVC_EXPORT_GET_REQS,
+		.dumpit		= nfsd_nl_svc_export_get_reqs_dumpit,
+		.policy		= nfsd_svc_export_get_reqs_nl_policy,
+		.maxattr	= NFSD_A_SVC_EXPORT_REQS_REQUESTS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= NFSD_CMD_SVC_EXPORT_SET_REQS,
+		.doit		= nfsd_nl_svc_export_set_reqs_doit,
+		.policy		= nfsd_svc_export_set_reqs_nl_policy,
+		.maxattr	= NFSD_A_SVC_EXPORT_REQS_REQUESTS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+};
+
+static const struct genl_multicast_group nfsd_nl_mcgrps[] = {
+	[NFSD_NLGRP_NONE] = { "none", },
+	[NFSD_NLGRP_EXPORTD] = { "exportd", },
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
@@ -113,4 +172,6 @@ struct genl_family nfsd_nl_family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.split_ops	= nfsd_nl_ops,
 	.n_split_ops	= ARRAY_SIZE(nfsd_nl_ops),
+	.mcgrps		= nfsd_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(nfsd_nl_mcgrps),
 };
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 478117ff6b8c0d6e83d6ece09a938935e031c62b..d6ed8d9b0bb149faa4d6493ba94972addf9c26ed 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -13,7 +13,11 @@
 #include <uapi/linux/nfsd_netlink.h>
 
 /* Common nested types */
+extern const struct nla_policy nfsd_auth_flavor_nl_policy[NFSD_A_AUTH_FLAVOR_FLAGS + 1];
+extern const struct nla_policy nfsd_fslocation_nl_policy[NFSD_A_FSLOCATION_PATH + 1];
+extern const struct nla_policy nfsd_fslocations_nl_policy[NFSD_A_FSLOCATIONS_LOCATION + 1];
 extern const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_NAME + 1];
+extern const struct nla_policy nfsd_svc_export_nl_policy[NFSD_A_SVC_EXPORT_FSID + 1];
 extern const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1];
 
 int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
@@ -26,6 +30,15 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_svc_export_get_reqs_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb);
+int nfsd_nl_svc_export_set_reqs_doit(struct sk_buff *skb,
+				     struct genl_info *info);
+
+enum {
+	NFSD_NLGRP_NONE,
+	NFSD_NLGRP_EXPORTD,
+};
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index dc294c4f8c58a6692b9dfbeb98fedbd649ae1b95..0f236046adfd239d0f88f4ed82a14e1a41cb6abe 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2215,6 +2215,34 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+int nfsd_cache_notify(struct cache_detail *cd, struct cache_head *h, u32 cache_type)
+{
+	struct genlmsghdr *hdr;
+	struct sk_buff *msg;
+
+	if (!genl_has_listeners(&nfsd_nl_family, cd->net, NFSD_NLGRP_EXPORTD))
+		return -ENOLINK;
+
+	msg = genlmsg_new(nla_total_size(sizeof(u32)), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &nfsd_nl_family, 0, NFSD_CMD_CACHE_NOTIFY);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return -ENOMEM;
+	}
+
+	if (nla_put_u32(msg, NFSD_A_CACHE_NOTIFY_CACHE_TYPE, cache_type)) {
+		nlmsg_free(msg);
+		return -ENOMEM;
+	}
+
+	genlmsg_end(msg, hdr);
+	return genlmsg_multicast_netns(&nfsd_nl_family, cd->net, msg, 0,
+				       NFSD_NLGRP_EXPORTD, GFP_KERNEL);
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 260bf8badb032de18f973556fa5deabe7e67870d..709da3c7a5fa7cdb4f5e91b488b02295c5f54392 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -108,7 +108,7 @@ struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
 				 const struct tree_descr *,
 				 struct dentry **fdentries);
 void nfsd_client_rmdir(struct dentry *dentry);
-
+int nfsd_cache_notify(struct cache_detail *cd, struct cache_head *h, u32 cache_type);
 
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 #ifdef CONFIG_NFSD_V2_ACL
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 97c7447f4d14df97c1cba8cdf1f24fba0a7918b3..eae426e9c8e737a95181e7d7b0904b86fc35cff6 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -10,6 +10,52 @@
 #define NFSD_FAMILY_NAME	"nfsd"
 #define NFSD_FAMILY_VERSION	1
 
+enum nfsd_cache_type {
+	NFSD_CACHE_TYPE_SVC_EXPORT = 1,
+};
+
+/*
+ * These flags are ordered to match the NFSEXP_* flags in
+ * include/linux/nfsd/export.h
+ */
+enum nfsd_export_flags {
+	NFSD_EXPORT_FLAGS_READONLY = 1,
+	NFSD_EXPORT_FLAGS_INSECURE_PORT = 2,
+	NFSD_EXPORT_FLAGS_ROOTSQUASH = 4,
+	NFSD_EXPORT_FLAGS_ALLSQUASH = 8,
+	NFSD_EXPORT_FLAGS_ASYNC = 16,
+	NFSD_EXPORT_FLAGS_GATHERED_WRITES = 32,
+	NFSD_EXPORT_FLAGS_NOREADDIRPLUS = 64,
+	NFSD_EXPORT_FLAGS_SECURITY_LABEL = 128,
+	NFSD_EXPORT_FLAGS_SIGN_FH = 256,
+	NFSD_EXPORT_FLAGS_NOHIDE = 512,
+	NFSD_EXPORT_FLAGS_NOSUBTREECHECK = 1024,
+	NFSD_EXPORT_FLAGS_NOAUTHNLM = 2048,
+	NFSD_EXPORT_FLAGS_MSNFS = 4096,
+	NFSD_EXPORT_FLAGS_FSID = 8192,
+	NFSD_EXPORT_FLAGS_CROSSMOUNT = 16384,
+	NFSD_EXPORT_FLAGS_NOACL = 32768,
+	NFSD_EXPORT_FLAGS_V4ROOT = 65536,
+	NFSD_EXPORT_FLAGS_PNFS = 131072,
+};
+
+/*
+ * These flags are ordered to match the NFSEXP_XPRTSEC_* flags in
+ * include/linux/nfsd/export.h
+ */
+enum nfsd_xprtsec_mode {
+	NFSD_XPRTSEC_MODE_NONE = 1,
+	NFSD_XPRTSEC_MODE_TLS = 2,
+	NFSD_XPRTSEC_MODE_MTLS = 4,
+};
+
+enum {
+	NFSD_A_CACHE_NOTIFY_CACHE_TYPE = 1,
+
+	__NFSD_A_CACHE_NOTIFY_MAX,
+	NFSD_A_CACHE_NOTIFY_MAX = (__NFSD_A_CACHE_NOTIFY_MAX - 1)
+};
+
 enum {
 	NFSD_A_RPC_STATUS_XID = 1,
 	NFSD_A_RPC_STATUS_FLAGS,
@@ -81,6 +127,64 @@ enum {
 	NFSD_A_POOL_MODE_MAX = (__NFSD_A_POOL_MODE_MAX - 1)
 };
 
+enum {
+	NFSD_A_FSLOCATION_HOST = 1,
+	NFSD_A_FSLOCATION_PATH,
+
+	__NFSD_A_FSLOCATION_MAX,
+	NFSD_A_FSLOCATION_MAX = (__NFSD_A_FSLOCATION_MAX - 1)
+};
+
+enum {
+	NFSD_A_FSLOCATIONS_LOCATION = 1,
+
+	__NFSD_A_FSLOCATIONS_MAX,
+	NFSD_A_FSLOCATIONS_MAX = (__NFSD_A_FSLOCATIONS_MAX - 1)
+};
+
+enum {
+	NFSD_A_AUTH_FLAVOR_PSEUDOFLAVOR = 1,
+	NFSD_A_AUTH_FLAVOR_FLAGS,
+
+	__NFSD_A_AUTH_FLAVOR_MAX,
+	NFSD_A_AUTH_FLAVOR_MAX = (__NFSD_A_AUTH_FLAVOR_MAX - 1)
+};
+
+enum {
+	NFSD_A_SVC_EXPORT_REQ_SEQNO = 1,
+	NFSD_A_SVC_EXPORT_REQ_CLIENT,
+	NFSD_A_SVC_EXPORT_REQ_PATH,
+
+	__NFSD_A_SVC_EXPORT_REQ_MAX,
+	NFSD_A_SVC_EXPORT_REQ_MAX = (__NFSD_A_SVC_EXPORT_REQ_MAX - 1)
+};
+
+enum {
+	NFSD_A_SVC_EXPORT_SEQNO = 1,
+	NFSD_A_SVC_EXPORT_CLIENT,
+	NFSD_A_SVC_EXPORT_PATH,
+	NFSD_A_SVC_EXPORT_NEGATIVE,
+	NFSD_A_SVC_EXPORT_EXPIRY,
+	NFSD_A_SVC_EXPORT_ANON_UID,
+	NFSD_A_SVC_EXPORT_ANON_GID,
+	NFSD_A_SVC_EXPORT_FSLOCATIONS,
+	NFSD_A_SVC_EXPORT_UUID,
+	NFSD_A_SVC_EXPORT_SECINFO,
+	NFSD_A_SVC_EXPORT_XPRTSEC,
+	NFSD_A_SVC_EXPORT_FLAGS,
+	NFSD_A_SVC_EXPORT_FSID,
+
+	__NFSD_A_SVC_EXPORT_MAX,
+	NFSD_A_SVC_EXPORT_MAX = (__NFSD_A_SVC_EXPORT_MAX - 1)
+};
+
+enum {
+	NFSD_A_SVC_EXPORT_REQS_REQUESTS = 1,
+
+	__NFSD_A_SVC_EXPORT_REQS_MAX,
+	NFSD_A_SVC_EXPORT_REQS_MAX = (__NFSD_A_SVC_EXPORT_REQS_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -91,9 +195,15 @@ enum {
 	NFSD_CMD_LISTENER_GET,
 	NFSD_CMD_POOL_MODE_SET,
 	NFSD_CMD_POOL_MODE_GET,
+	NFSD_CMD_CACHE_NOTIFY,
+	NFSD_CMD_SVC_EXPORT_GET_REQS,
+	NFSD_CMD_SVC_EXPORT_SET_REQS,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
 };
 
+#define NFSD_MCGRP_NONE		"none"
+#define NFSD_MCGRP_EXPORTD	"exportd"
+
 #endif /* _UAPI_LINUX_NFSD_NETLINK_H */
diff --git a/net/sunrpc/netlink.c b/net/sunrpc/netlink.c
index 41843f007c37a3ccb6480d11ec31de201c5aa5e7..3ac6b0cac5fece964f6e6591f90d074f40e96af1 100644
--- a/net/sunrpc/netlink.c
+++ b/net/sunrpc/netlink.c
@@ -6,7 +6,6 @@
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
-#include <linux/sunrpc/cache.h>
 
 #include "netlink.h"
 
@@ -22,6 +21,14 @@ const struct nla_policy sunrpc_ip_map_nl_policy[SUNRPC_A_IP_MAP_EXPIRY + 1] = {
 	[SUNRPC_A_IP_MAP_EXPIRY] = { .type = NLA_U64, },
 };
 
+const struct nla_policy sunrpc_unix_gid_nl_policy[SUNRPC_A_UNIX_GID_EXPIRY + 1] = {
+	[SUNRPC_A_UNIX_GID_SEQNO] = { .type = NLA_U64, },
+	[SUNRPC_A_UNIX_GID_UID] = { .type = NLA_U32, },
+	[SUNRPC_A_UNIX_GID_GIDS] = { .type = NLA_U32, },
+	[SUNRPC_A_UNIX_GID_NEGATIVE] = { .type = NLA_FLAG, },
+	[SUNRPC_A_UNIX_GID_EXPIRY] = { .type = NLA_U64, },
+};
+
 /* SUNRPC_CMD_IP_MAP_GET_REQS - dump */
 static const struct nla_policy sunrpc_ip_map_get_reqs_nl_policy[SUNRPC_A_IP_MAP_REQS_REQUESTS + 1] = {
 	[SUNRPC_A_IP_MAP_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_ip_map_nl_policy),
@@ -32,14 +39,6 @@ static const struct nla_policy sunrpc_ip_map_set_reqs_nl_policy[SUNRPC_A_IP_MAP_
 	[SUNRPC_A_IP_MAP_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_ip_map_nl_policy),
 };
 
-const struct nla_policy sunrpc_unix_gid_nl_policy[SUNRPC_A_UNIX_GID_EXPIRY + 1] = {
-	[SUNRPC_A_UNIX_GID_SEQNO] = { .type = NLA_U64, },
-	[SUNRPC_A_UNIX_GID_UID] = { .type = NLA_U32, },
-	[SUNRPC_A_UNIX_GID_GIDS] = { .type = NLA_U32, },
-	[SUNRPC_A_UNIX_GID_NEGATIVE] = { .type = NLA_FLAG, },
-	[SUNRPC_A_UNIX_GID_EXPIRY] = { .type = NLA_U64, },
-};
-
 /* SUNRPC_CMD_UNIX_GID_GET_REQS - dump */
 static const struct nla_policy sunrpc_unix_gid_get_reqs_nl_policy[SUNRPC_A_UNIX_GID_REQS_REQUESTS + 1] = {
 	[SUNRPC_A_UNIX_GID_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_unix_gid_nl_policy),
diff --git a/net/sunrpc/netlink.h b/net/sunrpc/netlink.h
index 16b87519a4096a72798e686dc20d2702ef329e52..2aec57d27a586e4c6b2fc65c7b4505b0996d9577 100644
--- a/net/sunrpc/netlink.h
+++ b/net/sunrpc/netlink.h
@@ -18,8 +18,7 @@ extern const struct nla_policy sunrpc_unix_gid_nl_policy[SUNRPC_A_UNIX_GID_EXPIR
 
 int sunrpc_nl_ip_map_get_reqs_dumpit(struct sk_buff *skb,
 				     struct netlink_callback *cb);
-int sunrpc_nl_ip_map_set_reqs_doit(struct sk_buff *skb,
-				   struct genl_info *info);
+int sunrpc_nl_ip_map_set_reqs_doit(struct sk_buff *skb, struct genl_info *info);
 int sunrpc_nl_unix_gid_get_reqs_dumpit(struct sk_buff *skb,
 				       struct netlink_callback *cb);
 int sunrpc_nl_unix_gid_set_reqs_doit(struct sk_buff *skb,

-- 
2.53.0


