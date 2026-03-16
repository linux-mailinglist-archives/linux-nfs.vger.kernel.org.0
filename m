Return-Path: <linux-nfs+bounces-20195-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGWCIjUguGlYZAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20195-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:22:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6C29C36B
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04922307F375
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4373A451C;
	Mon, 16 Mar 2026 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qez1pyuy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73453A168C;
	Mon, 16 Mar 2026 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674123; cv=none; b=DseZKMRnfj5EHovSon2eeOkLnYsNlFEgKd5Hb/5ENQWymTUmJvys6NWrEjHlX5x4UivZQo9M1GlVnvjNOIZGa7rRbPDP57coh5LZbiORG9rd8jjfufXwfvtb1w70I4qyFMkI6L7leRxtol5m0IwJGqHo3aaifdn27vC3dkNPCCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674123; c=relaxed/simple;
	bh=gAFoqWBNfhEgHq70T84C6SLnH52z9jYPIsTUasayNGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IibyuJyRN0GQNry64HZbCMwuZQKIjFGbtqebIfjfN6Rpz31U5hZ3H8xqOEZ8GY5lFxE58m4j7Tck0eF2Xd35qvhDgFP1xnJaaoSBcDHaSljiVms9c8uWFLCcsCaD8gkIqoFRZhiUZVPeyTGBGkTYnLZz66c6kOtpZ1yEL3ZTldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qez1pyuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD35C19425;
	Mon, 16 Mar 2026 15:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674123;
	bh=gAFoqWBNfhEgHq70T84C6SLnH52z9jYPIsTUasayNGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qez1pyuyrL5kbGBGBchavzDEooXfwbtaImELLHvS69B/hNq11XlI6NHMI287lzygw
	 ifOnLHRDQOzEQmfsciucEzk+2GY8NLy9iAbsbZmeCBZNiN+I3FrTCdM7yh9C+jyuie
	 iKd4F83GjClf7Llhc1txRHTPCjjOLjoaNajkEJnfj8J4MEu5EJqPr06RpNaXGBebiq
	 oZ+xfez+AuQS+qEWO9hvZPiMLPiCHsq/nn36ZbG6kTjDD0NDO87T6oz2eVVtHINe7f
	 LrSaGpx8aW/WURypakNBLM662PDubDLpqi9kgH2Ivrf0MJKFVVaJh+lbpTmmZy1gAn
	 sZrd4P2SwvX2Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:14:45 -0400
Subject: [PATCH 11/14] nfsd: add netlink upcall for the svc_export cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-11-6125dc62b955@kernel.org>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15411; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gAFoqWBNfhEgHq70T84C6SLnH52z9jYPIsTUasayNGY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB591LEvAezPcWErdjZ0f+jeo6QVwVBZ76pAK
 G5Dmd2ZE+yJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgefQAKCRAADmhBGVaC
 FaAVD/0cDm8dMktsjojlLMcCsC0EL1hBoOazooBd3EZCr0CoZpmu8xp7voSGtNKzAGLYUa/fa/H
 4TqlZ2IT6rGAUW8TxDBxsm90lC0PH+EDh63CFAMN1S8EJ1dnZ2drSrSOMWRtiLyuecBIkPcGv+N
 bDw6Ry5BceDj4KbBuBXeaFkWQPrHJV8zLy+OMHomoOubF6pxm8UnStH3NyKi4ohIZYNzHCcGCTk
 q9/RbVxLlm4vWzvi7GT8iNU26dok4KS9FWlF14Wgz9q7/fBpad+jc+BOTDIheeqjF5UilNCL5RZ
 QKir8StN0ioTtAbFMAIs7ecMLM5lvZ4pwQUGnLrCPZ/QPR66YHuyagVqqh+efqd/KD7IoapbHTj
 P1PssSTGPLLl/4DVak47e5/TyXaSb4D+8I1vlwsxh/F4h6AyKAVZXS8lDcpmk1+s8H3KJ3VrBny
 u+oje2A9pAxpwXsHLQ/V/WZ903MLXA19PX/QdV2WcmdJI8PBt/rCWyhq8//MDS3Pe78XFTN6++A
 JyqUeenrIa3ScbBsaXbiXpmiyHOW6b+e4SMEfNOeae8ZWNoz+Lql8srHARwNZ7SnzMZtEIzUOAm
 SZfFB3L66vBdvYusnPMQGMZYuMnz415PaX6ry+g0HUh3KE56sL+2CakY7F+tvq3ovVXb/8cMcuh
 MFf6zxgXvmzAaRw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20195-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,exp.cd:url]
X-Rspamd-Queue-Id: F2E6C29C36B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add netlink-based cache upcall support for the svc_export
(nfsd.export) cache.

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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/export.c | 440 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsctl.c |  28 ++++
 fs/nfsd/nfsd.h   |   2 +-
 3 files changed, 465 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index e83e88e69d90ab48c7aff58ac2b36cd1a6e1bb71..45a8e7b9866377131aac8639debdc4f877dc5788 100644
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
 
@@ -386,11 +389,443 @@ static void svc_export_put(struct kref *ref)
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
+ * Returns the size of the reply or a negative errno.
+ */
+int nfsd_nl_svc_export_get_reqs_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb)
+{
+	struct nfsd_net *nn;
+	struct cache_detail *cd;
+	struct cache_head **items;
+	u64 *seqnos;
+	int cnt, i;
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
+	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!items || !seqnos || !pathbuf) {
+		ret = -ENOMEM;
+		goto out_alloc;
+	}
+
+	cnt = sunrpc_cache_requests_snapshot(cd, items, seqnos, cnt);
+
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+			  cb->nlh->nlmsg_seq, &nfsd_nl_family,
+			  NLM_F_MULTI, NFSD_CMD_SVC_EXPORT_GET_REQS);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto out_put;
+	}
+
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
+		if (!nest) {
+			ret = -ENOBUFS;
+			goto out_cancel;
+		}
+
+		if (nla_put_u64_64bit(skb, NFSD_A_SVC_EXPORT_SEQNO,
+				      seqnos[i], 0) ||
+		    nla_put_string(skb, NFSD_A_SVC_EXPORT_CLIENT,
+				   exp->ex_client->name) ||
+		    nla_put_string(skb, NFSD_A_SVC_EXPORT_PATH, pth)) {
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
@@ -410,10 +845,6 @@ static void svc_export_request(struct cache_detail *cd,
 	(*bpp)[-1] = '\n';
 }
 
-static struct svc_export *svc_export_update(struct svc_export *new,
-					    struct svc_export *old);
-static struct svc_export *svc_export_lookup(struct svc_export *);
-
 static int check_export(const struct path *path, int *flags, unsigned char *uuid)
 {
 	struct inode *inode = d_inode(path->dentry);
@@ -907,6 +1338,7 @@ static const struct cache_detail svc_export_cache_template = {
 	.name		= "nfsd.export",
 	.cache_put	= svc_export_put,
 	.cache_upcall	= svc_export_upcall,
+	.cache_notify	= svc_export_notify,
 	.cache_request	= svc_export_request,
 	.cache_parse	= svc_export_parse,
 	.cache_show	= svc_export_show,
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index dc294c4f8c58a6692b9dfbeb98fedbd649ae1b95..7edcbe4504a91966db4805a099368edb92ca38ee 100644
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
+	msg = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
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

-- 
2.53.0


