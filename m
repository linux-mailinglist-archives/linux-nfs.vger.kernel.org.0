Return-Path: <linux-nfs+bounces-20196-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMkfG0wguGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20196-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:22:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E7529C397
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F8643083CC6
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0382B3A453C;
	Mon, 16 Mar 2026 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou7/s+mo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40A53A4F21;
	Mon, 16 Mar 2026 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674124; cv=none; b=dighFmC/XEha01Q7iYG2gxfjyefnNKoUPOXLU3713dspLhu7g4+H6xs8ZrKNJlkcGHEY3EBQHQ+nI2YbyudR7FGigrqSTi2KsEyPYnM6CCh5CLsS/eYGqzZ/vi6CUplghxQKbaD9c8UyZ5zQb426esGmTDwP5QAujrcOj1UkD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674124; c=relaxed/simple;
	bh=M5sSlrxR4y1O2la/4E0fRjLF5UH9Ez1CUZv8gguKdTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ne7QQtSAljWeVvWZq6kjO/NkdkFxFghxPDTHtXhwU+eq+CDcExDCq6k2YGnEQAxlAXDM7tAfAvc1Yxn4+oguzbVPH3g8M4bOIoVLkdUhshIfg+bWFStqrCUMrIzCdl1okGkaYM39jKL3BTjF8PpqxNSjYy783iupTs6KfroJ/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou7/s+mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8593C19425;
	Mon, 16 Mar 2026 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674124;
	bh=M5sSlrxR4y1O2la/4E0fRjLF5UH9Ez1CUZv8gguKdTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ou7/s+mo0foqTfqDnYQZo23uVeFvUSB9TnSBCXQoZQOw+nIG1TEbNRkwQxC7FbGJZ
	 QRv1DUPS5yYcVlSE3NxkBhO8qJ9HoV90N2OxzbyER8d/YInPBbStyb2C9yCSKYJx6k
	 EeSy9Q7vKWtFYzH8bDEirLKJqCPcNPKLY2zn6Ao+yA3kDKZkBY+YAj3FDBuXPsBMln
	 zZUQ6gdhA8eBMXiJVlwO0tX2Eq1Y62h/GXYAPUW5h50choCqwoa8WV+MvgYXit+VLH
	 ekDD+TcynjsQAuIInlQSmVYypl61AxFkaN2OpXGmxG/XwWOBUyFcCw3S41sKMBRR5/
	 Dc5yIOh/qTvMQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:14:46 -0400
Subject: [PATCH 12/14] nfsd: add netlink upcall for the nfsd.fh cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-12-6125dc62b955@kernel.org>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15119; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=M5sSlrxR4y1O2la/4E0fRjLF5UH9Ez1CUZv8gguKdTo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB59eLBWkXfjsQZwwtN4tbGxmaxIdowh/1Hnb
 hiIZDIFKWOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgefQAKCRAADmhBGVaC
 FXKvEACSu6G3dRhL5sg82UwP9w/CW3/7dRpfzSVDiUlCIQ0fxnDK40tYm8MNqDb8W7h3ubSAGUf
 f3bv6Ng1T3cREKKK7obKxH0zAh4FYZkPesF+dDXde4iRfbOyNjH/f12eImpc2f1zJzYN1yY1Air
 k8AZd5Lw/d7ToXnXWSM4/QdQgvrgKnAFn4kG6SFDDtoC95NcPx54yDK9jPs71NQfEl83uqZmoLL
 1ba2Lz96DDzE2rOljwFtTgmQvASaRj3CzKVQK6OK1H2b4c8Ft/VNfm+ZHyQsphqW6AvnB889mNb
 MXEHVmOya+j6s4ZZMubCx5X1bXxlrjbnpNl/jMgGGacqnAWmSAcUR59rzWK4x50B5bQyJ9DurJ6
 gyw/h78fyXE3BbIK5/j09Ty4XzAHfuBmR/AGIZXqijLoOBL58TH/cTJ36SHHpT2+3Rsjo8tdQJ6
 v2kSqeMpNbRVaflMmkOsNlZEGcGqskLAX2hzeRzvKDvTH3OdCJASNEcCqMOHqYkX+/wH5XXvdAF
 esvyUOzjnw1R6gZEWNVv84E/PNpC7rQTrudmXh4Nj08YGVU9JDON9ztLsFAWxTzzjJF6336hvmu
 ADr3nRIzM3El0Yo8B1uYPcO2SJn1+nX+6IwYsBwfJSQLAWhhLTZXA8diQIctSKdp25E6I6IE9Za
 t08+Bk9oI1vdWpg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20196-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9E7529C397
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add netlink-based cache upcall support for the expkey (nfsd.fh) cache,
following the same pattern as the existing svc_export netlink support.

Add expkey to the cache-type enum, a new expkey attribute-set with
client, fsidtype, fsid, negative, expiry, and path fields, and the
expkey-get-reqs / expkey-set-reqs operations to the nfsd YAML spec
and generated headers.

Implement nfsd_nl_expkey_get_reqs_dumpit() which snapshots pending
expkey cache requests and sends each entry's seqno, client name,
fsidtype, and fsid over netlink.

Implement nfsd_nl_expkey_set_reqs_doit() which parses expkey cache
responses from userspace (client, fsidtype, fsid, expiry, and path
or negative flag) and updates the cache via svc_expkey_lookup() /
svc_expkey_update().

Wire up the expkey_notify() callback in svc_expkey_cache_template
so cache misses trigger NFSD_CMD_CACHE_NOTIFY multicast events with
NFSD_CACHE_TYPE_EXPKEY.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  52 ++++++-
 fs/nfsd/export.c                      | 263 ++++++++++++++++++++++++++++++++++
 fs/nfsd/netlink.c                     |  34 +++++
 fs/nfsd/netlink.h                     |   4 +
 include/uapi/linux/nfsd_netlink.h     |  23 +++
 5 files changed, 375 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 08322bc3dee7458e6a202372dd332067d03e1be6..65fd9caf6bf66abca9302ffa3b947b589dbf0dd3 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -10,7 +10,7 @@ definitions:
   -
     type: flags
     name: cache-type
-    entries: [svc_export]
+    entries: [svc_export, expkey]
   -
     type: flags
     name: export-flags
@@ -271,6 +271,38 @@ attribute-sets:
         type: nest
         nested-attributes: svc-export
         multi-attr: true
+  -
+    name: expkey
+    attributes:
+      -
+        name: seqno
+        type: u64
+      -
+        name: client
+        type: string
+      -
+        name: fsidtype
+        type: u8
+      -
+        name: fsid
+        type: binary
+      -
+        name: negative
+        type: flag
+      -
+        name: expiry
+        type: u64
+      -
+        name: path
+        type: string
+  -
+    name: expkey-reqs
+    attributes:
+      -
+        name: requests
+        type: nest
+        nested-attributes: expkey
+        multi-attr: true
 
 operations:
   list:
@@ -398,6 +430,24 @@ operations:
           request:
             attributes:
               - requests
+    -
+      name: expkey-get-reqs
+      doc: Dump all pending expkey requests
+      attribute-set: expkey-reqs
+      flags: [admin-perm]
+      dump:
+          request:
+            attributes:
+              - requests
+    -
+      name: expkey-set-reqs
+      doc: Respond to one or more expkey requests
+      attribute-set: expkey-reqs
+      flags: [admin-perm]
+      do:
+          request:
+            attributes:
+              - requests
 
 mcast-groups:
   list:
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 45a8e7b9866377131aac8639debdc4f877dc5788..33988de28e95d30948b2f7e44453742c4cb62697 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -266,12 +266,18 @@ static void expkey_flush(void)
 	mutex_unlock(&nfsd_mutex);
 }
 
+static int expkey_notify(struct cache_detail *cd, struct cache_head *h)
+{
+	return nfsd_cache_notify(cd, h, NFSD_CACHE_TYPE_EXPKEY);
+}
+
 static const struct cache_detail svc_expkey_cache_template = {
 	.owner		= THIS_MODULE,
 	.hash_size	= EXPKEY_HASHMAX,
 	.name		= "nfsd.fh",
 	.cache_put	= expkey_put,
 	.cache_upcall	= expkey_upcall,
+	.cache_notify	= expkey_notify,
 	.cache_request	= expkey_request,
 	.cache_parse	= expkey_parse,
 	.cache_show	= expkey_show,
@@ -322,6 +328,263 @@ svc_expkey_update(struct cache_detail *cd, struct svc_expkey *new,
 		return NULL;
 }
 
+/**
+ * nfsd_nl_expkey_get_reqs_dumpit - dump pending expkey requests
+ * @skb: reply buffer
+ * @cb: netlink metadata and command arguments
+ *
+ * Walk the expkey cache's pending request list and create a netlink
+ * message with a nested entry for each cache_request, containing the
+ * seqno, client string, fsidtype and fsid.
+ *
+ * Returns the size of the reply or a negative errno.
+ */
+int nfsd_nl_expkey_get_reqs_dumpit(struct sk_buff *skb,
+				   struct netlink_callback *cb)
+{
+	struct nfsd_net *nn;
+	struct cache_detail *cd;
+	struct cache_head **items;
+	u64 *seqnos;
+	int cnt, i;
+	void *hdr;
+	int ret;
+
+	nn = net_generic(sock_net(skb->sk), nfsd_net_id);
+
+	mutex_lock(&nfsd_mutex);
+
+	cd = nn->svc_expkey_cache;
+	if (!cd) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	/* Second call means we've already dumped everything */
+	if (cb->args[0]) {
+		ret = 0;
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
+	if (!items || !seqnos) {
+		ret = -ENOMEM;
+		goto out_alloc;
+	}
+
+	cnt = sunrpc_cache_requests_snapshot(cd, items, seqnos, cnt);
+
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+			  cb->nlh->nlmsg_seq, &nfsd_nl_family,
+			  NLM_F_MULTI, NFSD_CMD_EXPKEY_GET_REQS);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto out_put;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		struct svc_expkey *ek;
+		struct nlattr *nest;
+
+		ek = container_of(items[i], struct svc_expkey, h);
+
+		nest = nla_nest_start(skb, NFSD_A_EXPKEY_REQS_REQUESTS);
+		if (!nest) {
+			ret = -ENOBUFS;
+			goto out_cancel;
+		}
+
+		if (nla_put_u64_64bit(skb, NFSD_A_EXPKEY_SEQNO,
+				      seqnos[i], 0) ||
+		    nla_put_string(skb, NFSD_A_EXPKEY_CLIENT,
+				   ek->ek_client->name) ||
+		    nla_put_u8(skb, NFSD_A_EXPKEY_FSIDTYPE,
+			       ek->ek_fsidtype) ||
+		    nla_put(skb, NFSD_A_EXPKEY_FSID,
+			    key_len(ek->ek_fsidtype), ek->ek_fsid)) {
+			nla_nest_cancel(skb, nest);
+			ret = -ENOBUFS;
+			goto out_cancel;
+		}
+
+		nla_nest_end(skb, nest);
+	}
+
+	genlmsg_end(skb, hdr);
+	cb->args[0] = 1;
+	ret = skb->len;
+	goto out_put;
+
+out_cancel:
+	genlmsg_cancel(skb, hdr);
+out_put:
+	for (i = 0; i < cnt; i++)
+		cache_put(items[i], cd);
+out_alloc:
+	kfree(seqnos);
+	kfree(items);
+out_unlock:
+	mutex_unlock(&nfsd_mutex);
+	return ret;
+}
+
+/**
+ * nfsd_nl_parse_one_expkey - parse one expkey entry from netlink
+ * @cd: cache_detail for the expkey cache
+ * @attr: nested attribute containing expkey fields
+ *
+ * Parses one expkey entry from a netlink message and updates the
+ * cache. Mirrors the logic in expkey_parse().
+ *
+ * Returns 0 on success or a negative errno.
+ */
+static int nfsd_nl_parse_one_expkey(struct cache_detail *cd,
+				    struct nlattr *attr)
+{
+	struct nlattr *tb[NFSD_A_EXPKEY_PATH + 1];
+	struct auth_domain *dom = NULL;
+	struct svc_expkey key;
+	struct svc_expkey *ek = NULL;
+	struct timespec64 boot;
+	int err;
+	u8 fsidtype;
+	int fsid_len;
+
+	err = nla_parse_nested(tb, NFSD_A_EXPKEY_PATH, attr,
+			       nfsd_expkey_nl_policy, NULL);
+	if (err)
+		return err;
+
+	/* client (required) */
+	if (!tb[NFSD_A_EXPKEY_CLIENT])
+		return -EINVAL;
+
+	dom = auth_domain_find(nla_data(tb[NFSD_A_EXPKEY_CLIENT]));
+	if (!dom)
+		return -ENOENT;
+
+	/* fsidtype (required) */
+	if (!tb[NFSD_A_EXPKEY_FSIDTYPE]) {
+		err = -EINVAL;
+		goto out_dom;
+	}
+	fsidtype = nla_get_u8(tb[NFSD_A_EXPKEY_FSIDTYPE]);
+	if (key_len(fsidtype) == 0) {
+		err = -EINVAL;
+		goto out_dom;
+	}
+
+	/* fsid (required) */
+	if (!tb[NFSD_A_EXPKEY_FSID]) {
+		err = -EINVAL;
+		goto out_dom;
+	}
+	fsid_len = nla_len(tb[NFSD_A_EXPKEY_FSID]);
+	if (fsid_len != key_len(fsidtype)) {
+		err = -EINVAL;
+		goto out_dom;
+	}
+
+	/* expiry (required, wallclock seconds) */
+	if (!tb[NFSD_A_EXPKEY_EXPIRY]) {
+		err = -EINVAL;
+		goto out_dom;
+	}
+
+	key.h.flags = 0;
+	getboottime64(&boot);
+	key.h.expiry_time = nla_get_u64(tb[NFSD_A_EXPKEY_EXPIRY]) -
+			    boot.tv_sec;
+	key.ek_client = dom;
+	key.ek_fsidtype = fsidtype;
+	memcpy(key.ek_fsid, nla_data(tb[NFSD_A_EXPKEY_FSID]), fsid_len);
+
+	ek = svc_expkey_lookup(cd, &key);
+	if (!ek) {
+		err = -ENOMEM;
+		goto out_dom;
+	}
+
+	if (tb[NFSD_A_EXPKEY_NEGATIVE]) {
+		set_bit(CACHE_NEGATIVE, &key.h.flags);
+		ek = svc_expkey_update(cd, &key, ek);
+		if (ek)
+			trace_nfsd_expkey_update(ek, NULL);
+		else
+			err = -ENOMEM;
+	} else if (tb[NFSD_A_EXPKEY_PATH]) {
+		err = kern_path(nla_data(tb[NFSD_A_EXPKEY_PATH]), 0,
+				&key.ek_path);
+		if (err)
+			goto out_ek;
+		ek = svc_expkey_update(cd, &key, ek);
+		if (ek)
+			trace_nfsd_expkey_update(ek,
+					nla_data(tb[NFSD_A_EXPKEY_PATH]));
+		else
+			err = -ENOMEM;
+		path_put(&key.ek_path);
+	} else {
+		err = -EINVAL;
+		goto out_ek;
+	}
+
+	cache_flush();
+
+out_ek:
+	if (ek)
+		cache_put(&ek->h, cd);
+out_dom:
+	auth_domain_put(dom);
+	return err;
+}
+
+/**
+ * nfsd_nl_expkey_set_reqs_doit - respond to expkey requests
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Parse one or more expkey cache responses from userspace and
+ * update the expkey cache accordingly.
+ *
+ * Returns 0 on success or a negative errno.
+ */
+int nfsd_nl_expkey_set_reqs_doit(struct sk_buff *skb,
+				 struct genl_info *info)
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
+	cd = nn->svc_expkey_cache;
+	if (!cd) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	nlmsg_for_each_attr_type(attr, NFSD_A_EXPKEY_REQS_REQUESTS,
+				 info->nlhdr, GENL_HDRLEN, rem) {
+		ret = nfsd_nl_parse_one_expkey(cd, (struct nlattr *)attr);
+		if (ret)
+			break;
+	}
+
+out_unlock:
+	mutex_unlock(&nfsd_mutex);
+	return ret;
+}
 
 #define	EXPORT_HASHBITS		8
 #define	EXPORT_HASHMAX		(1<< EXPORT_HASHBITS)
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index fb401d7302afb9e41cb074581f7b94e8ece6cf0c..394230e250a5b07fa0bb6a5b76f7282758e94565 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -17,6 +17,16 @@ const struct nla_policy nfsd_auth_flavor_nl_policy[NFSD_A_AUTH_FLAVOR_FLAGS + 1]
 	[NFSD_A_AUTH_FLAVOR_FLAGS] = NLA_POLICY_MASK(NLA_U32, 0x3ffff),
 };
 
+const struct nla_policy nfsd_expkey_nl_policy[NFSD_A_EXPKEY_PATH + 1] = {
+	[NFSD_A_EXPKEY_SEQNO] = { .type = NLA_U64, },
+	[NFSD_A_EXPKEY_CLIENT] = { .type = NLA_NUL_STRING, },
+	[NFSD_A_EXPKEY_FSIDTYPE] = { .type = NLA_U8, },
+	[NFSD_A_EXPKEY_FSID] = { .type = NLA_BINARY, },
+	[NFSD_A_EXPKEY_NEGATIVE] = { .type = NLA_FLAG, },
+	[NFSD_A_EXPKEY_EXPIRY] = { .type = NLA_U64, },
+	[NFSD_A_EXPKEY_PATH] = { .type = NLA_NUL_STRING, },
+};
+
 const struct nla_policy nfsd_fslocation_nl_policy[NFSD_A_FSLOCATION_PATH + 1] = {
 	[NFSD_A_FSLOCATION_HOST] = { .type = NLA_NUL_STRING, },
 	[NFSD_A_FSLOCATION_PATH] = { .type = NLA_NUL_STRING, },
@@ -88,6 +98,16 @@ static const struct nla_policy nfsd_svc_export_set_reqs_nl_policy[NFSD_A_SVC_EXP
 	[NFSD_A_SVC_EXPORT_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_svc_export_nl_policy),
 };
 
+/* NFSD_CMD_EXPKEY_GET_REQS - dump */
+static const struct nla_policy nfsd_expkey_get_reqs_nl_policy[NFSD_A_EXPKEY_REQS_REQUESTS + 1] = {
+	[NFSD_A_EXPKEY_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_expkey_nl_policy),
+};
+
+/* NFSD_CMD_EXPKEY_SET_REQS - do */
+static const struct nla_policy nfsd_expkey_set_reqs_nl_policy[NFSD_A_EXPKEY_REQS_REQUESTS + 1] = {
+	[NFSD_A_EXPKEY_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_expkey_nl_policy),
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -157,6 +177,20 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.maxattr	= NFSD_A_SVC_EXPORT_REQS_REQUESTS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_EXPKEY_GET_REQS,
+		.dumpit		= nfsd_nl_expkey_get_reqs_dumpit,
+		.policy		= nfsd_expkey_get_reqs_nl_policy,
+		.maxattr	= NFSD_A_EXPKEY_REQS_REQUESTS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= NFSD_CMD_EXPKEY_SET_REQS,
+		.doit		= nfsd_nl_expkey_set_reqs_doit,
+		.policy		= nfsd_expkey_set_reqs_nl_policy,
+		.maxattr	= NFSD_A_EXPKEY_REQS_REQUESTS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group nfsd_nl_mcgrps[] = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index d6ed8d9b0bb149faa4d6493ba94972addf9c26ed..f5b3387772850692b220bbbf8a66bc416b67801e 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -14,6 +14,7 @@
 
 /* Common nested types */
 extern const struct nla_policy nfsd_auth_flavor_nl_policy[NFSD_A_AUTH_FLAVOR_FLAGS + 1];
+extern const struct nla_policy nfsd_expkey_nl_policy[NFSD_A_EXPKEY_PATH + 1];
 extern const struct nla_policy nfsd_fslocation_nl_policy[NFSD_A_FSLOCATION_PATH + 1];
 extern const struct nla_policy nfsd_fslocations_nl_policy[NFSD_A_FSLOCATIONS_LOCATION + 1];
 extern const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_NAME + 1];
@@ -34,6 +35,9 @@ int nfsd_nl_svc_export_get_reqs_dumpit(struct sk_buff *skb,
 				       struct netlink_callback *cb);
 int nfsd_nl_svc_export_set_reqs_doit(struct sk_buff *skb,
 				     struct genl_info *info);
+int nfsd_nl_expkey_get_reqs_dumpit(struct sk_buff *skb,
+				   struct netlink_callback *cb);
+int nfsd_nl_expkey_set_reqs_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NFSD_NLGRP_NONE,
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 1ba1c2c167fd06cd0c845d947f5a03702356d991..e96cc1d23366bce13624084fd476dda65aef140a 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -12,6 +12,7 @@
 
 enum nfsd_cache_type {
 	NFSD_CACHE_TYPE_SVC_EXPORT = 1,
+	NFSD_CACHE_TYPE_EXPKEY = 2,
 };
 
 enum nfsd_export_flags {
@@ -177,6 +178,26 @@ enum {
 	NFSD_A_SVC_EXPORT_REQS_MAX = (__NFSD_A_SVC_EXPORT_REQS_MAX - 1)
 };
 
+enum {
+	NFSD_A_EXPKEY_SEQNO = 1,
+	NFSD_A_EXPKEY_CLIENT,
+	NFSD_A_EXPKEY_FSIDTYPE,
+	NFSD_A_EXPKEY_FSID,
+	NFSD_A_EXPKEY_NEGATIVE,
+	NFSD_A_EXPKEY_EXPIRY,
+	NFSD_A_EXPKEY_PATH,
+
+	__NFSD_A_EXPKEY_MAX,
+	NFSD_A_EXPKEY_MAX = (__NFSD_A_EXPKEY_MAX - 1)
+};
+
+enum {
+	NFSD_A_EXPKEY_REQS_REQUESTS = 1,
+
+	__NFSD_A_EXPKEY_REQS_MAX,
+	NFSD_A_EXPKEY_REQS_MAX = (__NFSD_A_EXPKEY_REQS_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -190,6 +211,8 @@ enum {
 	NFSD_CMD_CACHE_NOTIFY,
 	NFSD_CMD_SVC_EXPORT_GET_REQS,
 	NFSD_CMD_SVC_EXPORT_SET_REQS,
+	NFSD_CMD_EXPKEY_GET_REQS,
+	NFSD_CMD_EXPKEY_SET_REQS,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)

-- 
2.53.0


