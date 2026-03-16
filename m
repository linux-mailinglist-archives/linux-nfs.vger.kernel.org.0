Return-Path: <linux-nfs+bounces-20207-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BhOMucguGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20207-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:25:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC8229C42A
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 012043038D7A
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB203A1E73;
	Mon, 16 Mar 2026 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMK2Gv1c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ADF39FCAA
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674222; cv=none; b=Xu4indOwiptCRnmy5MHGi5KsiQj8pqZs2jyZQBEd0gLPhhTqzyK4RGLPBXNkbfkM9bgwhv3jNJAKsv82gQ18aPv82eHhsjXf7mxQVZEAWqsse8vnuQIYV3XaiJ60IZRUTPCgEreuKAWgJAfM4aIx6o5zv+PNGhkFWAZgqH1+GxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674222; c=relaxed/simple;
	bh=9vonjzowFIvdkIl8fup8ovoUgrT2NpeLCEw0w5/1Unc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKXyNOQrdq4J2jp31qAi8jU8xjhASyoS7KVNICREKMeKxd8qkR3OFqvWpVzFTW1cWfsP2Z3kAk50RaXPM9sEzCKDGubQUooTzeIEYztEuuyX5EjvH5RvM49noPbbMkLKK2Rz/6KpIxeIYtnJ0DXLKGFYKT8s0enDi6eapOwg64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMK2Gv1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20446C2BC9E;
	Mon, 16 Mar 2026 15:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674222;
	bh=9vonjzowFIvdkIl8fup8ovoUgrT2NpeLCEw0w5/1Unc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MMK2Gv1cmA9AISyU/WYoMFcZ5kuxuHERohpGyL76hSaDtL+Xpo27O5/yxzb7Cl7a9
	 IKRmMT8rNe2HlTqoS83JJpuhn11aDOTbtouJ6bI81C/WM7/YQsryJl/haZoEJZwKys
	 2CfXUsquKK1TBiMymqGIu87OXJSP88lPJXmsMsKB6l2JBEwGVnqeb6D960dwADpK5x
	 Fw/0F7LLJpQapLhL1Pn5SmhrP+v6vkazHsfqQ0U451MEw23RFCuT1pSq+zjtlLIokb
	 beBKpFw1RUmOb33SeQRrvcu+w9OaMFHdeMrLbVaZki5P72nv7qeiIl17NFQGC0FnRr
	 XqmrHOi6upybw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:46 -0400
Subject: [PATCH nfs-utils 08/17] exportd/mountd: add netlink support for
 the nfsd.fh cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-8-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10429; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9vonjzowFIvdkIl8fup8ovoUgrT2NpeLCEw0w5/1Unc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7hB9wmSKb8s8mkhxsplvEE99DrFJ/niwjW2
 o4A74cYXeKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge4QAKCRAADmhBGVaC
 FVdBD/9b6WHMlebbm4RZyLK8xjUJbwbBPJ+lBVLvXF+CrmqZOP95DH4yzcuLJSDytSzTGD9t86+
 IYGOM9XS7DW/4LtHLBiaaVnc4pntBovp87WLW0g+brrCMAMo7o6ct6GL+dQV5a2WpOUoA/YEPdG
 fSz7CKcqpOaUMfbCaXOnDd58P57s81/sdCkefPQt4/CBLgwtppMluTN9oFXXGnCD9bezp9Xy/SV
 nGDPGeTDBcPLazwuB76HaHNbwMWARrf7lrNCgYWZGGEDcXamBpLhSfRvV31zah4/PjVuwzyq2OT
 h7qKnLfbcRvS88VrqcDWUkAHDasJPfcq/ba13R7zekQ8+IPwVSM2m9De0eWLpQ8nWnbLzvaoy+A
 prP5A7B7GMH1L6K1HuCUvQ+z99frrr0V3UZfQhlqgTBjhQLz6+t3xKGul82tLtvHNlE+23yHJbK
 rtajE/8qXi1uyfKPFWxEfudOCCXgFaU2A1BDSV0dcbGb4JnisfmUUl0IYF9P02EE3ZO9O7lrosE
 a/uKnj22gecn1Xzx7HCOShFGyme25YXYIaeLCVUXya58FNh5z2qyZnwRUwCjKISYHxBn/X/ElFA
 j63dOat4ObCXo486GtTCQ7lbXERddStEfRq1Q0CjApZ4b4f3tkglkpdyO061iqR2edsOI+asX82
 WioZtruZL8pC7qA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20207-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FC8229C42A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor cache_nl_set_reqs() to take a socket parameter so it can be
reused for multiple genl families.

Rename cache_nl_process() to cache_nl_process_export() and factor out
the notification drain and auth_reload() into a new
cache_nfsd_nl_process() wrapper.

Add the expkey (nfsd.fh) netlink cache handler, which uses the same
nfsd genl family as svc_export. The handler resolves fsid-based
lookups including CROSSMOUNT submount iteration and responds via
NFSD_CMD_EXPKEY_SET_REQS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/export/cache.c | 323 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 314 insertions(+), 9 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 090ea0a6cc6da7e9c2ce255601103d2442526067..c350662fd97c33c40c1d59297b9638141a67befb 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -1477,7 +1477,7 @@ static struct nl_msg *cache_nl_new_msg(int family, int cmd, int flags)
 	return msg;
 }
 
-static int cache_nl_set_reqs(struct nl_msg *msg)
+static int cache_nl_set_reqs(struct nl_sock *sock, struct nl_msg *msg)
 {
 	struct nl_cb *cb;
 	int done = 0;
@@ -1490,14 +1490,14 @@ static int cache_nl_set_reqs(struct nl_msg *msg)
 	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, nl_finish_cb, &done);
 	nl_cb_err(cb, NL_CB_CUSTOM, nl_error_cb, &done);
 
-	ret = nl_send_auto(nfsd_nl_cmd_sock, msg);
+	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
 		nl_cb_put(cb);
 		return ret;
 	}
 
 	while (!done) {
-		ret = nl_recvmsgs(nfsd_nl_cmd_sock, cb);
+		ret = nl_recvmsgs(sock, cb);
 		if (ret < 0)
 			break;
 	}
@@ -1515,9 +1515,6 @@ static void cache_nl_process_export(void)
 	struct nl_msg *msg;
 	int i;
 
-	/* Drain pending notifications */
-	cache_nfsd_nl_drain();
-
 	/* Fetch all pending requests from the kernel */
 	if (cache_nl_get_export_reqs(&reqs, &nreqs)) {
 		xlog(L_WARNING, "cache_nl_process_export: failed to get export requests");
@@ -1571,7 +1568,7 @@ static void cache_nl_process_export(void)
 		}
 
 		if (nfsd_nl_add_export(msg, dom, path, epp, ttl) < 0) {
-			cache_nl_set_reqs(msg);
+			cache_nl_set_reqs(nfsd_nl_cmd_sock, msg);
 			nlmsg_free(msg);
 			msg = cache_nl_new_msg(nfsd_nl_family,
 					       NFSD_CMD_SVC_EXPORT_SET_REQS, 0);
@@ -1588,7 +1585,7 @@ static void cache_nl_process_export(void)
 		nfs_freeaddrinfo(ai);
 	}
 
-	cache_nl_set_reqs(msg);
+	cache_nl_set_reqs(nfsd_nl_cmd_sock, msg);
 	nlmsg_free(msg);
 
 out_free:
@@ -1599,6 +1596,314 @@ out_free:
 	free(reqs);
 }
 
+/*
+ * Netlink-based expkey (nfsd.fh) cache support.
+ *
+ * Uses the same nfsd genl family as svc_export. The kernel sends
+ * NFSD_CMD_CACHE_NOTIFY with NFSD_CACHE_TYPE_EXPKEY to signal
+ * pending expkey cache requests.
+ */
+struct expkey_req {
+	char	*client;
+	int	fsidtype;
+	char	*fsid;
+	int	fsidlen;
+};
+
+struct get_expkey_reqs_data {
+	struct expkey_req	*reqs;
+	int			nreqs;
+	int			maxreqs;
+	int			err;
+};
+
+static int get_expkey_reqs_cb(struct nl_msg *msg, void *arg)
+{
+	struct get_expkey_reqs_data *data = arg;
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attr;
+	int rem;
+
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem) {
+		struct nlattr *tb[NFSD_A_EXPKEY_PATH + 1];
+		struct expkey_req *req;
+
+		if (nla_type(attr) != NFSD_A_EXPKEY_REQS_REQUESTS)
+			continue;
+
+		if (nla_parse_nested(tb, NFSD_A_EXPKEY_PATH, attr, NULL))
+			continue;
+
+		if (!tb[NFSD_A_EXPKEY_CLIENT] ||
+		    !tb[NFSD_A_EXPKEY_FSIDTYPE] ||
+		    !tb[NFSD_A_EXPKEY_FSID])
+			continue;
+
+		if (data->nreqs >= data->maxreqs) {
+			int newmax = data->maxreqs ? data->maxreqs * 2 : 16;
+			struct expkey_req *tmp;
+
+			tmp = realloc(data->reqs, newmax * sizeof(*tmp));
+			if (!tmp) {
+				data->err = -ENOMEM;
+				return NL_STOP;
+			}
+			data->reqs = tmp;
+			data->maxreqs = newmax;
+		}
+
+		req = &data->reqs[data->nreqs++];
+		req->client = strdup(nla_get_string(tb[NFSD_A_EXPKEY_CLIENT]));
+		req->fsidtype = nla_get_u8(tb[NFSD_A_EXPKEY_FSIDTYPE]);
+		req->fsidlen = nla_len(tb[NFSD_A_EXPKEY_FSID]);
+		req->fsid = malloc(req->fsidlen);
+
+		if (!req->client || !req->fsid) {
+			data->err = -ENOMEM;
+			return NL_STOP;
+		}
+		memcpy(req->fsid, nla_data(tb[NFSD_A_EXPKEY_FSID]),
+		       req->fsidlen);
+	}
+
+	return NL_OK;
+}
+
+static int cache_nl_get_expkey_reqs(struct expkey_req **reqs_out,
+				    int *nreqs_out)
+{
+	struct get_expkey_reqs_data data = { };
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int done = 0;
+	int ret;
+
+	msg = cache_nl_new_msg(nfsd_nl_family,
+			       NFSD_CMD_EXPKEY_GET_REQS, NLM_F_DUMP);
+	if (!msg)
+		return -ENOMEM;
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb) {
+		nlmsg_free(msg);
+		return -ENOMEM;
+	}
+
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, get_expkey_reqs_cb, &data);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, nl_finish_cb, &done);
+	nl_cb_err(cb, NL_CB_CUSTOM, nl_error_cb, &done);
+
+	ret = nl_send_auto(nfsd_nl_cmd_sock, msg);
+	nlmsg_free(msg);
+	if (ret < 0) {
+		nl_cb_put(cb);
+		return ret;
+	}
+
+	while (!done) {
+		ret = nl_recvmsgs(nfsd_nl_cmd_sock, cb);
+		if (ret < 0)
+			break;
+	}
+
+	nl_cb_put(cb);
+
+	if (data.err) {
+		int i;
+		for (i = 0; i < data.nreqs; i++) {
+			free(data.reqs[i].client);
+			free(data.reqs[i].fsid);
+		}
+		free(data.reqs);
+		return data.err;
+	}
+
+	*reqs_out = data.reqs;
+	*nreqs_out = data.nreqs;
+	return 0;
+}
+
+static int nfsd_nl_add_expkey(struct nl_msg *msg, char *dom, int fsidtype,
+			 char *fsid, int fsidlen, char *found_path)
+{
+	struct nlattr *nest;
+
+	nest = nla_nest_start(msg, NFSD_A_EXPKEY_REQS_REQUESTS);
+	if (!nest)
+		return -1;
+
+	if (nla_put_string(msg, NFSD_A_EXPKEY_CLIENT, dom) < 0 ||
+	    nla_put_u8(msg, NFSD_A_EXPKEY_FSIDTYPE, fsidtype) < 0 ||
+	    nla_put(msg, NFSD_A_EXPKEY_FSID, fsidlen, fsid) < 0 ||
+	    nla_put_u64(msg, NFSD_A_EXPKEY_EXPIRY, 0x7fffffff) < 0)
+		goto nla_failure;
+
+	if (found_path) {
+		if (nla_put_string(msg, NFSD_A_EXPKEY_PATH,
+				   found_path) < 0)
+			goto nla_failure;
+	} else {
+		if (nla_put_flag(msg, NFSD_A_EXPKEY_NEGATIVE) < 0)
+			goto nla_failure;
+	}
+
+	nla_nest_end(msg, nest);
+	return 0;
+
+nla_failure:
+	nla_nest_cancel(msg, nest);
+	return -1;
+}
+
+static void cache_nl_process_expkey(void)
+{
+	struct expkey_req *reqs = NULL;
+	int nreqs = 0;
+	struct nl_msg *msg;
+	int i;
+
+	if (cache_nl_get_expkey_reqs(&reqs, &nreqs)) {
+		xlog(L_WARNING, "cache_nl_process_expkey: failed to get expkey requests");
+		return;
+	}
+
+	if (!nreqs)
+		return;
+
+	xlog(D_CALL, "cache_nl_process_expkey: %d pending expkey requests", nreqs);
+
+	msg = cache_nl_new_msg(nfsd_nl_family, NFSD_CMD_EXPKEY_SET_REQS, 0);
+	if (!msg)
+		goto out_free;
+
+	for (i = 0; i < nreqs; i++) {
+		char *dom = reqs[i].client;
+		int fsidtype = reqs[i].fsidtype;
+		char *fsid = reqs[i].fsid;
+		int fsidlen = reqs[i].fsidlen;
+		struct parsed_fsid parsed;
+		struct addrinfo *ai = NULL;
+		struct exportent *found = NULL;
+		char *found_path = NULL;
+		nfs_export *exp;
+		int j;
+
+		if (parse_fsid(fsidtype, fsidlen, fsid, &parsed))
+			goto do_add_expkey;
+
+		if (is_ipaddr_client(dom)) {
+			ai = lookup_client_addr(dom);
+			if (!ai)
+				goto do_add_expkey;
+		}
+
+		for (j = 0; j < MCL_MAXTYPES; j++) {
+			nfs_export *prev = NULL;
+			nfs_export *next_exp;
+			void *mnt = NULL;
+
+			for (exp = exportlist[j].p_head; exp;
+			     exp = next_exp) {
+				char *path;
+
+				if (exp->m_export.e_flags &
+				    NFSEXP_CROSSMOUNT) {
+					if (prev == exp) {
+						path = next_mnt(&mnt,
+							exp->m_export.e_path);
+						if (!path) {
+							next_exp = exp->m_next;
+							prev = NULL;
+							continue;
+						}
+						next_exp = exp;
+					} else {
+						prev = exp;
+						mnt = NULL;
+						path = exp->m_export.e_path;
+						next_exp = exp;
+					}
+				} else {
+					path = exp->m_export.e_path;
+					next_exp = exp->m_next;
+				}
+
+				if (!is_ipaddr_client(dom) &&
+				    !namelist_client_matches(exp, dom))
+					continue;
+
+				switch (match_fsid(&parsed, exp, path)) {
+				case 0:
+					continue;
+				case -1:
+					continue;
+				}
+
+				if (is_ipaddr_client(dom) &&
+				    !ipaddr_client_matches(exp, ai))
+					continue;
+
+				if (!found ||
+				    subexport(&exp->m_export, found)) {
+					found = &exp->m_export;
+					free(found_path);
+					found_path = strdup(path);
+					if (!found_path)
+						goto do_add_expkey;
+				}
+			}
+		}
+
+do_add_expkey:
+		if (nfsd_nl_add_expkey(msg, dom, fsidtype, fsid,
+				       fsidlen, found_path) < 0) {
+			cache_nl_set_reqs(nfsd_nl_cmd_sock, msg);
+			nlmsg_free(msg);
+			msg = cache_nl_new_msg(nfsd_nl_family,
+					       NFSD_CMD_EXPKEY_SET_REQS, 0);
+			if (!msg) {
+				free(found_path);
+				nfs_freeaddrinfo(ai);
+				goto out_free;
+			}
+			if (nfsd_nl_add_expkey(msg, dom, fsidtype, fsid,
+					       fsidlen, found_path) < 0)
+				xlog(L_WARNING, "%s: skipping oversized "
+				     "entry", __func__);
+		}
+		if (!found)
+			xlog(D_AUTH, "denied access to %s",
+			     *dom == '$' ? dom + 1 : dom);
+		free(found_path);
+		nfs_freeaddrinfo(ai);
+	}
+
+	cache_nl_set_reqs(nfsd_nl_cmd_sock, msg);
+	nlmsg_free(msg);
+
+out_free:
+	for (i = 0; i < nreqs; i++) {
+		free(reqs[i].client);
+		free(reqs[i].fsid);
+	}
+	free(reqs);
+}
+
+static void cache_nfsd_nl_process(void)
+{
+	/* Drain pending nfsd notifications */
+	cache_nfsd_nl_drain();
+
+	auth_reload();
+
+	/* Handle any pending svc_export requests */
+	cache_nl_process_export();
+
+	/* Handle any pending expkey requests */
+	cache_nl_process_expkey();
+}
+
 static int can_reexport_via_fsidnum(struct exportent *exp, struct statfs *st)
 {
 	if (st->f_type != 0x6969 /* NFS_SUPER_MAGIC */)
@@ -2207,7 +2512,7 @@ int cache_process_req(fd_set *readfds)
 	if (nfsd_nl_notify_sock &&
 	    FD_ISSET(nl_socket_get_fd(nfsd_nl_notify_sock), readfds)) {
 		cnt++;
-		cache_nl_process_export();
+		cache_nfsd_nl_process();
 		FD_CLR(nl_socket_get_fd(nfsd_nl_notify_sock), readfds);
 	}
 	return cnt;

-- 
2.53.0


