Return-Path: <linux-nfs+bounces-20525-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLn+C1GAymnX9QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20525-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:53:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D6135C5F9
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A42930A3B45
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E953D566D;
	Mon, 30 Mar 2026 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c78bC/ML"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6BB3D47BC
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877934; cv=none; b=uTWztf+ew348aFy6tWbBebGW5teMblGgCRMOHPArITHCDO5d7xE+OZ1UV4fVQoOh3o7MR8edAlwyTF+ORfLuWmr0Jr6fFbIWiwtmGJClv3o6Wfe351qxuQPtrHQRf4oB26R1xu40gcjrBP1L/oYA4DJ7xknmpidsDET1ccuCMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877934; c=relaxed/simple;
	bh=5bDr0ReU7Rn1PUfi5dy9fHYNdHXWt95DbMAzvjeOY4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B+zbaa6c72lgTdBDNJ2xyyPwkxCtlWNsmCp9bLea4yGO230NwNS01qZkUbSyknBew+q4AARjffx4uC1qq1hM11qz3HRY90Bhi69wqOlJwl9ZfCvD4EP1H+X/GEfTeakR8MoIf7mJ6CYOaaEKAwy/BARO50KRvtpJTZ8lo7uIopw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c78bC/ML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBC4C2BCB0;
	Mon, 30 Mar 2026 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877934;
	bh=5bDr0ReU7Rn1PUfi5dy9fHYNdHXWt95DbMAzvjeOY4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c78bC/ML91Ei8Y3Av9KGm1zcyTWj6Y02LVXDZh0o/yzFdPZQ6NNSl+0i0TkiJpxcA
	 Oqod/LFNtgQYLF93wOn24m7p97srBAvHtFR4Xq83uwIjOuMycdg4Vt1yoUtBAoE9Oh
	 nlt7w6UkmQGi2+NEwpc0LfHKLkFgp167gEGYFFW6e4WqADwaXwxS+ZnxRPgvGkT0gy
	 mBiuFqfrnzdPHvAhOPweud7/2w1jGKalLPeOBJk0XaqRDNDD5Uoh0IxcliYQYCmgY0
	 JOI15LfdNuncc1/UBR75mbZJk97c4509YTwUWx84SWVYt+wI+poaAzPLm5ZfeD5g/Y
	 xcZvxqypnrrYA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 30 Mar 2026 09:38:30 -0400
Subject: [PATCH nfs-utils v2 10/16] exportd/mountd: add netlink support for
 the auth.unix.gid cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-exportd-netlink-v2-10-cc9bd5db2408@kernel.org>
References: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
In-Reply-To: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6760; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5bDr0ReU7Rn1PUfi5dy9fHYNdHXWt95DbMAzvjeOY4Y=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpynzg/c7L3w3e5WrvFDb/KhiKDgeLDd9ZkXSaD
 7rYowyOEwCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacp84AAKCRAADmhBGVaC
 FdiTEAC02YRrX1AdjEkizoHHBeekwZiuLEKmtT7CnE5Q8NoM5PA7XPEjKpGLHJb7ga2h5O69err
 nCS4867AmLtJ7BZxRfMk3gaqC7jwwPJ6E/JRZwyBoKaaF84XDxTPzjGZY39LeMxpXBlYWA1T/Hb
 0swRBiKEsZrtmR+bcqW45462e6p4m6UTwQpI602ObvEBQ+GYhuwSweGQrCZzmkkuHoNjSxx2zmo
 2KfGbnIracycUmBssPcpdnNtacMz9MJw1Ftjnfb05eP26BvBGQiwpxTkYs0M8gWBunTyXPpMId0
 5WkkYjOlhSTlCF//NdpEGMsW1a65IywIDdn1o39hx9/sHllniWeaoIcyy4Me1ZbuVvpi6kR8poy
 6aa87f54VjYKoXSoOg1aRM9PxCi2nV9FNg/uclqoUtWP5BIutq0tAasS8ly6OCdA/3XCsq6j/x7
 ds+tQwGaR2NQA1cJ7BRB3CmtKHXy+FhjUr9qfa7WR/hKjDqVzvG1Du603D2xLnx1hoFAoIgkC6o
 JhpA5T/KA6YqNvGQ+QSLzG0atI4cUqD07pAij7nvuZBWODIRETuONsWbU92GK0MrBlW4Bgx+Cxw
 EHjdbKW/pDH6R4mPWaxKKQGHRGYrfzb+7B5Vl6KQ02arWfGGrfCM/2ofgrNY37l58J40c68S71x
 e8L5S1cFyrDbm/A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20525-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30D6135C5F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the unix_gid (auth.unix.gid) netlink cache handler. For each
pending request, the handler resolves the UID to a group list using
getpwuid() and getgrouplist(), and responds via
SUNRPC_CMD_UNIX_GID_SET_REQS.

The handler is only active when manage_gids is set, matching the
behavior of the existing procfs handler.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/export/cache.c | 236 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 236 insertions(+)

diff --git a/support/export/cache.c b/support/export/cache.c
index 50c2de08c504da1a05631938ee51251d82c52377..43cb16079da867e6633b9cc6436689ab0e156e44 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -110,6 +110,7 @@ static bool path_lookup_error(int err)
 #define INITIAL_MANAGED_GROUPS 100
 
 extern int use_ipaddr;
+extern int manage_gids;
 
 static void auth_unix_ip(int f)
 {
@@ -2202,6 +2203,237 @@ out_free:
 	free(reqs);
 }
 
+/*
+ * unix_gid (auth.unix.gid) netlink handler
+ */
+struct unix_gid_req {
+	uid_t	uid;
+};
+
+struct get_unix_gid_reqs_data {
+	struct unix_gid_req	*reqs;
+	int			nreqs;
+	int			maxreqs;
+	int			err;
+};
+
+static int get_unix_gid_reqs_cb(struct nl_msg *msg, void *arg)
+{
+	struct get_unix_gid_reqs_data *data = arg;
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attr;
+	int rem;
+
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem) {
+		struct nlattr *tb[SUNRPC_A_UNIX_GID_EXPIRY + 1];
+		struct unix_gid_req *req;
+
+		if (nla_type(attr) != SUNRPC_A_UNIX_GID_REQS_REQUESTS)
+			continue;
+
+		if (nla_parse_nested(tb, SUNRPC_A_UNIX_GID_EXPIRY, attr,
+				     NULL))
+			continue;
+
+		if (!tb[SUNRPC_A_UNIX_GID_UID])
+			continue;
+
+		if (data->nreqs >= data->maxreqs) {
+			int newmax = data->maxreqs ? data->maxreqs * 2 : 16;
+			struct unix_gid_req *tmp;
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
+		req->uid = nla_get_u32(tb[SUNRPC_A_UNIX_GID_UID]);
+	}
+
+	return NL_OK;
+}
+
+static int cache_nl_get_unix_gid_reqs(struct unix_gid_req **reqs_out,
+				      int *nreqs_out)
+{
+	struct get_unix_gid_reqs_data data = { };
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int done = 0;
+	int ret;
+
+	msg = cache_nl_new_msg(sunrpc_nl_family,
+			       SUNRPC_CMD_UNIX_GID_GET_REQS, NLM_F_DUMP);
+	if (!msg)
+		return -ENOMEM;
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb) {
+		nlmsg_free(msg);
+		return -ENOMEM;
+	}
+
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, get_unix_gid_reqs_cb,
+		  &data);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, nl_finish_cb, &done);
+	nl_cb_err(cb, NL_CB_CUSTOM, nl_error_cb, &done);
+
+	ret = nl_send_auto(sunrpc_nl_cmd_sock, msg);
+	nlmsg_free(msg);
+	if (ret < 0) {
+		nl_cb_put(cb);
+		return ret;
+	}
+
+	while (!done) {
+		ret = nl_recvmsgs(sunrpc_nl_cmd_sock, cb);
+		if (ret < 0)
+			break;
+	}
+
+	nl_cb_put(cb);
+
+	if (data.err) {
+		free(data.reqs);
+		return data.err;
+	}
+
+	*reqs_out = data.reqs;
+	*nreqs_out = data.nreqs;
+	return 0;
+}
+
+static int nl_add_unix_gid(struct nl_msg *msg, uid_t uid, gid_t *groups,
+			   int ngroups)
+{
+	struct nlattr *nest;
+	time_t now = time(0);
+	int i;
+
+	nest = nla_nest_start(msg, SUNRPC_A_UNIX_GID_REQS_REQUESTS);
+	if (!nest)
+		return -1;
+
+	if (nla_put_u32(msg, SUNRPC_A_UNIX_GID_UID, uid) < 0 ||
+	    nla_put_u64(msg, SUNRPC_A_UNIX_GID_EXPIRY, now + default_ttl) < 0)
+		goto nla_failure;
+
+	if (ngroups >= 0) {
+		for (i = 0; i < ngroups; i++)
+			if (nla_put_u32(msg, SUNRPC_A_UNIX_GID_GIDS, groups[i]) < 0)
+				goto nla_failure;
+	} else {
+		if (nla_put_flag(msg, SUNRPC_A_UNIX_GID_NEGATIVE) < 0)
+			goto nla_failure;
+	}
+
+	nla_nest_end(msg, nest);
+	return 0;
+nla_failure:
+	nla_nest_cancel(msg, nest);
+	return -1;
+}
+
+static void cache_nl_process_unix_gid(void)
+{
+	struct unix_gid_req *reqs = NULL;
+	int nreqs = 0;
+	struct nl_msg *msg;
+	static gid_t *groups = NULL;
+	static int groups_len = 0;
+	int i;
+
+	if (cache_nl_get_unix_gid_reqs(&reqs, &nreqs)) {
+		xlog(L_WARNING, "cache_nl_process_unix_gid: failed to get unix_gid requests");
+		return;
+	}
+
+	if (!nreqs)
+		return;
+
+	xlog(D_CALL, "cache_nl_process_unix_gid: %d pending unix_gid requests",
+	     nreqs);
+
+	if (groups_len == 0) {
+		groups = malloc(sizeof(gid_t) * INITIAL_MANAGED_GROUPS);
+		if (!groups)
+			goto out_free;
+		groups_len = INITIAL_MANAGED_GROUPS;
+	}
+
+	msg = cache_nl_new_msg(sunrpc_nl_family,
+			       SUNRPC_CMD_UNIX_GID_SET_REQS, 0);
+	if (!msg)
+		goto out_free;
+
+	for (i = 0; i < nreqs; i++) {
+		uid_t uid = reqs[i].uid;
+		struct passwd *pw;
+		int ngroups;
+		int rv;
+		int ret;
+
+		ngroups = groups_len;
+		pw = getpwuid(uid);
+		if (!pw) {
+			rv = -1;
+		} else {
+			rv = getgrouplist(pw->pw_name, pw->pw_gid,
+					  groups, &ngroups);
+			if (rv == -1 && ngroups >= groups_len) {
+				gid_t *more_groups;
+
+				more_groups = realloc(groups,
+						      sizeof(gid_t) * ngroups);
+				if (!more_groups) {
+					rv = -1;
+				} else {
+					groups = more_groups;
+					groups_len = ngroups;
+					rv = getgrouplist(pw->pw_name,
+							  pw->pw_gid,
+							  groups, &ngroups);
+				}
+			}
+		}
+
+		if (rv >= 0)
+			ret = nl_add_unix_gid(msg, uid, groups, ngroups);
+		else
+			ret = nl_add_unix_gid(msg, uid, NULL, -1);
+
+		if (ret < 0) {
+			/* Flush current message and retry with a fresh one */
+			cache_nl_set_reqs(sunrpc_nl_cmd_sock, msg);
+			nlmsg_free(msg);
+			msg = cache_nl_new_msg(sunrpc_nl_family,
+					       SUNRPC_CMD_UNIX_GID_SET_REQS, 0);
+			if (!msg)
+				goto out_free;
+
+			if (rv >= 0)
+				ret = nl_add_unix_gid(msg, uid, groups, ngroups);
+			else
+				ret = nl_add_unix_gid(msg, uid, NULL, -1);
+			if (ret < 0)
+				xlog(L_WARNING, "%s: skipping oversized entry for uid %u",
+				     __func__, uid);
+		}
+	}
+
+	cache_nl_set_reqs(sunrpc_nl_cmd_sock, msg);
+	nlmsg_free(msg);
+
+out_free:
+	free(reqs);
+}
+
 static void cache_sunrpc_nl_process(void)
 {
 	/* Drain pending sunrpc notifications */
@@ -2211,6 +2443,10 @@ static void cache_sunrpc_nl_process(void)
 
 	/* Handle any pending ip_map requests */
 	cache_nl_process_ip_map();
+
+	/* Handle any pending unix_gid requests */
+	if (manage_gids)
+		cache_nl_process_unix_gid();
 }
 
 static int can_reexport_via_fsidnum(struct exportent *exp, struct statfs *st)

-- 
2.53.0


