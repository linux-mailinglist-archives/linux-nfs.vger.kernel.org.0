Return-Path: <linux-nfs+bounces-20209-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF1NJO0guGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20209-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:25:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAAC29C438
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CF4E3039990
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F393A1A44;
	Mon, 16 Mar 2026 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdp9jE3e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133E39FCAA
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674224; cv=none; b=GfZQK3gPGw/AHPef6jRg4swCDUH5NchS59n+n8l9I9S7zJpd9SYpVyUGY5O3PlyGEGpO1Ylv7TolVKiQjPFmypvzkV+zKHi5S7y1Qici53RAQwHwdEzFvdXaZgRJiDDew0zCdkpK7Q7IfsQQAtc7xx/E/Tcaybd0s7RqnfOjSzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674224; c=relaxed/simple;
	bh=5bDr0ReU7Rn1PUfi5dy9fHYNdHXWt95DbMAzvjeOY4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gh6TeDLWPDptfDZf2oe4tGHJonA+QUd6QH95YD+8pBbFNw+ds6JMJ4cUAvLY6PbwROr1Txq4mycqa/zouV8Xt0Qv3iQ3Uhz2IOQ8hECr9AEcJM0nWgZpNFExFi38pvSKchC5UUQXcI3DjeB511yElauxbhO23y66jeR/okiqnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdp9jE3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5415EC2BC9E;
	Mon, 16 Mar 2026 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674224;
	bh=5bDr0ReU7Rn1PUfi5dy9fHYNdHXWt95DbMAzvjeOY4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gdp9jE3e23XKwWb9KSL7NeNg9wQ5ujy794jV61EMBC2qsYFU7Fqda48aSVntr0C70
	 JMbs1s2WjPAOMcVu6QqAaxe7gGURg9l1qIj6ATSMt4YYHd9WPS8JOrCuFOKq7A5VCY
	 Rrx78n0ByHzos2IwUq+q+sNspLcbfyRe121E3U0kcLGWq8PBQUJWyjZuQNClUBlUlD
	 mH5YO5SRMWbQrE4OEy9R8qI6BZCIbAxkjvrcNtjCnLDbdrj36wdHTgk3tBl0Piarje
	 Kl34hsN7bdPjVTjyic3J36R0+qB2dMgNzoj9+G/ibJ8jWXnkJSk4QRv8StPt25vCE7
	 2fWMg260+qvMA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:48 -0400
Subject: [PATCH nfs-utils 10/17] exportd/mountd: add netlink support for
 the auth.unix.gid cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-10-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6760; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5bDr0ReU7Rn1PUfi5dy9fHYNdHXWt95DbMAzvjeOY4Y=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7iE+nfh16lx1pMRlrM/jhGueDbrBHVh6j8o
 nSsONc6k46JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge4gAKCRAADmhBGVaC
 FUqNEACkJqGW5ARs6bxYS3VvKePBn2Uin6cJ2ZwcjTMBscFNw+oZYI8Krzd/uC4MPxMDzydR7r+
 MAWA4dGTWQEwTnOTuu3OJvbWFsO3PC5GcirEfUt0szJTFyc53/3LN4pKSxV4Sk68Jmov3iBk5ch
 kNmhD+O7rrtnrRBWREJIVBEonGE8TwGt3o8o/h7+Zzb7P3BTDrw4OLM40CpL8m6Ac8FqWrC+KHw
 NkfG9QbUys8c6F8q+qBoJ5I931tAv9tou4Lgi2eP/8EW2VzHEEDlT10uiX3/iIJbh4xpE8XAa/X
 A3o+5MPh+wS6VoqXFWGApxJWlxhiUnjDKuCD2MCfjktIu2Pp/XyHFiqVpyBJJ6f+Tdpq/rrpVyp
 5ZeF8OhY4f8vsZKC654Vz5Kkhc2gjo3bl/P0wrq0zxkfyxAnx54jpmYPOjF8d0CIWWc5eA8hUt4
 cB8O44J2xqq+xIuwpkeey8Yjo3xTxOtONj0Pnf0kPW0yVzzR1BRSptAhaJmmzM7EzveZgnk3qRV
 HQ0btpW1d+WIKgP9AqMHCmSYMdY2myU2H8LTMLe5ffAk0NMb5ke30E1hvvt59Jqf0iLWNbyjeE5
 fXBe0rfNsIdeTO/QYdRdC8W6xTvKyr76YRW9hiWkipIRJTC2v5hl8+lz/UnGMVH24fBiOu8bZNv
 OYdm10Qrr89U41Q==
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
	TAGGED_FROM(0.00)[bounces-20209-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: DCAAC29C438
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


