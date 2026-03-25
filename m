Return-Path: <linux-nfs+bounces-20385-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFckOUL+w2lXvQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20385-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 16:24:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFE4327DFE
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 16:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A68F3210E39
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD7F3FADE2;
	Wed, 25 Mar 2026 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfYh0gHQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5889A3FA5E2;
	Wed, 25 Mar 2026 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449670; cv=none; b=mXfupiUidGUBXWxl8TOkcpo0aI8q5CmxIemHypcuj6m/+wCZCToAaukJ3fP/IPVt7U+QTMDIUxDUHjJ44zBTARne8hAs11bvMjk0XZybbLpFv0bwg+Sj09MOuBiU2gZ5jieaToW3zMYiUy/pCc8C/HHQucUKqKthAgkZE/SY4Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449670; c=relaxed/simple;
	bh=a93t/sVtm9B/uugWNXM7m8wlzfW14hQRfjR7xraeum4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SS4v2af3l5qdDSqANFfiBJPAHPUCBx5eYl1GL9eXSL5Lm87RcJx+dp3PEz15WhkfMbq3h95M0hpiK8TPDetdH1HlH56tUL+KyP4ZikRnArD9SW8mhg1kz/FaxGEc9zGfc5yyPI2/5AgX35P+2S/vkz9WRlTYElq8m3knYEkXArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfYh0gHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B76C19423;
	Wed, 25 Mar 2026 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449669;
	bh=a93t/sVtm9B/uugWNXM7m8wlzfW14hQRfjR7xraeum4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dfYh0gHQ5ySUMZSAyEnU3XRjrcoB2vkB3bVkwUjGNx+KZPDIBJTPUdHkJtgxsRk+6
	 URNGNTWgIHQyfprpOQD9hn7s5om+rN44qFyWaTrJaMoy1lZo4sOT3bixwxWRypQbVk
	 gmV5C6g2PUOn8Gk0gGsDkvUmj1+vSs2JinnJ6JRS37wMUO/p0iSjOPTOeZ6QATb9h3
	 KgWLxV2vKgk2GR1iBt8yu4pzokUdl8t2Yu+fSREJXFbKaJIzrwNhtpxPyUgOUdjgB7
	 qI0nd2teWphlCbGjllIHthJD1VWePocguvED8cHP8xW7d0nPU95RPFYk6HzAPALtbE
	 QbpUQOAmskUfQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 25 Mar 2026 10:40:32 -0400
Subject: [PATCH v2 11/13] nfsd: add netlink upcall for the nfsd.fh cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-exportd-netlink-v2-11-067df016ea95@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15170; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=a93t/sVtm9B/uugWNXM7m8wlzfW14hQRfjR7xraeum4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpw/Pvn5knBKL3TYylOJ2sRTKmHkF5FM1+6s2YQ
 l0P2jB778GJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacPz7wAKCRAADmhBGVaC
 FSrED/9oYb1iqdPNkM5oWNawopN/Exu9mJWaqty87uGa2DKNe+wvCzJJiT1EnNm2rc4kCBxrofL
 7D/muvBexRJshtms163zWN0KFeW/eZcUcHY7qvTDwDBMuu8J7KgSnMgnD9MpluNsB+43m3w4MS2
 HPgxUkwYKhWuya2sd0OaiSrxwyt5lr48fNUr8p9jfIhhKrNQliJwKh1BY98YkYtjMLSyt7daE0r
 lKkyQ28CPsQ3Vu/RuhDrhmJVW9RY4CH5N+LXNafCgdHg+03yvn8Ha3yI59YlwChV0JZoXYLea4o
 49MGINWMLUmLr3udYl+TOJqox03jf7zN0Zr9p8XQSwMdYBNp0VDvnORahlMtT/uGyyeLEki2cK3
 5avybqNBCHbrUEjiqrhKMnGmSekfkei24pCY/g7AilTH6v3huYPqwtuiUemwdQ6S6Bhnb07/iF7
 SS7nHRJltBnrKdwPYEkH0K1mJzm6Efb3bM+lZ2xZjiD4TY93/DAt8vo7NEr7wiH23bynHz7gsX7
 Rz/dVFWLXen2sgeDRL8XUS/e32Xi2TTcklBWUSyJ/q1fTAsE6sb6HUWZYbnba0OHJI7ZgWR65YT
 1fi9LiAgLVUH5NQBL3zVDLXw9gvBFmBFDV3VbYzy7F5sTkgY8NO8QxA9IdNbsWAPAfigyRyCryQ
 7aiYKGNcG3qqpPA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20385-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BFE4327DFE
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
 fs/nfsd/export.c                      | 266 ++++++++++++++++++++++++++++++++++
 fs/nfsd/netlink.c                     |  34 +++++
 fs/nfsd/netlink.h                     |   4 +
 include/uapi/linux/nfsd_netlink.h     |  23 +++
 5 files changed, 378 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 709751502f8b56bd4b68462fa15337df5e3e035e..ae9563ca58ee0bf7373fd96d7d2253df411316fd 100644
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
@@ -273,6 +273,38 @@ attribute-sets:
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
@@ -400,6 +432,24 @@ operations:
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
index cfe542fd7b22e27a7971a1f792061767068ac439..07d40e786aa77488b27fa0e47082ae5000f6f286 100644
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
@@ -322,6 +328,266 @@ svc_expkey_update(struct cache_detail *cd, struct svc_expkey *new,
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
+ * Uses cb->args[0] as a seqno cursor for dump continuation across
+ * multiple netlink messages.
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
+	int cnt, i, emitted;
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
+	cnt = sunrpc_cache_requests_snapshot(cd, items, seqnos, cnt,
+					     cb->args[0]);
+	if (!cnt) {
+		ret = 0;
+		goto out_alloc;
+	}
+
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+			  cb->nlh->nlmsg_seq, &nfsd_nl_family,
+			  NLM_F_MULTI, NFSD_CMD_EXPKEY_GET_REQS);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto out_put;
+	}
+
+	emitted = 0;
+	for (i = 0; i < cnt; i++) {
+		struct svc_expkey *ek;
+		struct nlattr *nest;
+
+		ek = container_of(items[i], struct svc_expkey, h);
+
+		nest = nla_nest_start(skb, NFSD_A_EXPKEY_REQS_REQUESTS);
+		if (!nest)
+			break;
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
index eae426e9c8e737a95181e7d7b0904b86fc35cff6..2cbd2a36f00ca38e313e95a4ccfaa46a5c1c0df3 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -12,6 +12,7 @@
 
 enum nfsd_cache_type {
 	NFSD_CACHE_TYPE_SVC_EXPORT = 1,
+	NFSD_CACHE_TYPE_EXPKEY = 2,
 };
 
 /*
@@ -185,6 +186,26 @@ enum {
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
@@ -198,6 +219,8 @@ enum {
 	NFSD_CMD_CACHE_NOTIFY,
 	NFSD_CMD_SVC_EXPORT_GET_REQS,
 	NFSD_CMD_SVC_EXPORT_SET_REQS,
+	NFSD_CMD_EXPKEY_GET_REQS,
+	NFSD_CMD_EXPKEY_SET_REQS,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)

-- 
2.53.0


