Return-Path: <linux-nfs+bounces-20523-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMDRDSN9ymlo9QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20523-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB0335C23F
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61567301A027
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A663D5256;
	Mon, 30 Mar 2026 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLXgyKmK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA0C3D565B
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877932; cv=none; b=WZhD9dIIiYG0RiKjJNfP6ip3x2m9/PLQydT56LMPBBXdADtVBJ3gFLQ8PsloMVOD1c+VWbemU3Ky+GqwBvxij9Ly2qR/8aTVsByoLLabdScPVA0C1gme6EZuOTuko0HOPyFjmPAZ9FRp1ofCNiFcSNKHvfFOZsO0RLuXcSxjpuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877932; c=relaxed/simple;
	bh=9vonjzowFIvdkIl8fup8ovoUgrT2NpeLCEw0w5/1Unc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D6leYmJIGCySv9uQzyGcRwGddXpac521ZSZEV9E0RHH76wY9v8YoSHYYZDijUWzPbN5RheBRb2PADOunyHm/gjcjECEGrmKW7g6RUXwi5x+i16etTV4PRlMVi7UU8Qhr+/g1IKmC0TcSRaNMP0s8yVyjBM1Qxxb2YNOLe+LMz9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLXgyKmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D6FC2BCB1;
	Mon, 30 Mar 2026 13:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877931;
	bh=9vonjzowFIvdkIl8fup8ovoUgrT2NpeLCEw0w5/1Unc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HLXgyKmKvTTTN82jybDMpGx26iUOKjUKG7FL/y14ahiqs0pMMZqqf6yU8pMn6Of+H
	 XWEZAt5y8bB33KqiLxGAxtoPb1k9EbMl0/60T91H3xWLWeKbqA33rDYnZXtOpJt8EK
	 H52kXKkNK12+dAV4S96M0/e6D5RbCBj9yTMiFwW4sUQHsNXnngJb8cVe0N8gPgUn0l
	 BmIUgmRm7fihNpjnl4V7u/gSerSHewEt1RnunO13DELWs2m395byDMu7vhVIsWO//3
	 h9R7rHjXzQ4S2zuEjexCyozUeXXje1M0rAnvHILAzR1jndeTc+VxY4EoCYDXO6/NfP
	 gOa1OOkFXw2Zg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 30 Mar 2026 09:38:28 -0400
Subject: [PATCH nfs-utils v2 08/16] exportd/mountd: add netlink support for
 the nfsd.fh cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-exportd-netlink-v2-8-cc9bd5db2408@kernel.org>
References: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
In-Reply-To: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10429; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9vonjzowFIvdkIl8fup8ovoUgrT2NpeLCEw0w5/1Unc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpynzfSXFSCF8W7IiaxlLRiqoPJliabmWT7epKU
 BKDYivVx+aJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacp83wAKCRAADmhBGVaC
 FczZD/0Z2/tQ7mw1C33IwZeF9WYL2rju2jiGuk3oO5Q4kChuPZnbBcTujcAYk329dF8nh2YYaoI
 YUNY8v3BxydnxtLhhJHYt8ddsXMEa4LeCNa57AUoln9IUrohNPEeDlszJLNlnn71/VgUiT63hNM
 rZ6eOg4gWPIA+Pn8aQAnQVW2gN2/sVDacVHo0gQjCuXoILn/8pUizKbDvcC3wqStjpX6m15CqJq
 RM2vyWTG2daOJqMGDGWF9zIasUl12+oHJ0NWijzGhjS4YAg1WdqSjOftczGkFLwMh478G2ijzML
 24x8EA9OVULGdSqbrG5iiTCE2GwHHK1CgAK1QQcoQbbKCz+3fv85ZUeuuPKtaptRVtVw3QKxvJs
 DEoeP43mVfmadXWMO6T/v1/Ph0qm+tAxwzi7nvst5EvggtJYt4EabfUElc9qbXEqxNgTRqeoMjN
 nTcg5TSjQyfBl5X7hxovHZKKKzTVT41TF/0veMyjzZoxFTqBYjwWlqkdhMyRorEemCQWRCZLo3g
 QysLPcN7k10VaBwfK3sZLehdDSWgmWgFfpx5YV9ejrKDMAdrpBFG4HNeOCUuhab8a1eX+z3EBiG
 q+oU75y/Us1KIFHPhjGqUxp44GNVsFyt7gmH86drbF8SfXiuoVeqNwf5s/pl1/eZSVS1fafD2dg
 TwuRvaiphhqcfFA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20523-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CB0335C23F
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


