Return-Path: <linux-nfs+bounces-20208-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJqDOesguGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20208-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:25:31 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC7F29C431
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59CAD30B5B95
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716343A1E96;
	Mon, 16 Mar 2026 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmY7fWZB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00B39FCAA
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674223; cv=none; b=JDZ1YD5nhjXeSL75nhtCN73T27NmVdwKeO1H6WJmEcY795i66wD3UmQfIefBel+epXXMa+qqvRPFJyM/XX08gMyB+fz/sJFqr1gqgFUqEGNhYdsfKqLS7n82gfFlp+d0j7JJt4uVCXknU8YMHs6sdDyLxh3PbOFKQ57HBGymnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674223; c=relaxed/simple;
	bh=IF/3jCrcmMuq507/QZW0oUgVxE7lrLvleJ1dfpwUDvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QC7IrlOwaeJO0GMbAwy+8Htz92HnKbPupXAlNuFxYsshYr5gTQX68+oX2TzGmtYCeL8X3ZMFm09A95aa5hFO/Mz63Kzz0Q7IssFQAkUGy0T+lK5usSNhmhIqYydTPm6h1pq+h/wQ8mQmbjhvyWODuVmqkBMFZgyfjizIsU0eW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmY7fWZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE85C2BC87;
	Mon, 16 Mar 2026 15:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674223;
	bh=IF/3jCrcmMuq507/QZW0oUgVxE7lrLvleJ1dfpwUDvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EmY7fWZBVXEtksTkpVTzLKK3ChWadY2bxUo3eRWOejUnDoyS+axwKyhjHADmU0lB9
	 PFP4773sw0LrFw/B5GHIbWQ5igynKMOmbOfuVUYMaW5s8KJ1jsaYy7fKfAm7IlV9oq
	 SITS9kt6btbS/bjK0qzme0TbU3GM6Fvj8IDlTayavxITOC5sLENOmzG1VMjg8rp4jt
	 gTHqRposrOa6+lfnyDZ7F0FVMQ6FKNuYZPPm4XwZE4DQKr8roEFzc/BhxdAEaIVtit
	 Umvjuo9aK0MGKYR87VXvRXMBYdTkl3oYCg9QsKBCrXJaBhwsL/tjbQs4esvNyAimBe
	 /fOueuu3ijErA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:47 -0400
Subject: [PATCH nfs-utils 09/17] exportd/mountd: add netlink support for
 the auth.unix.ip cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-9-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12483; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IF/3jCrcmMuq507/QZW0oUgVxE7lrLvleJ1dfpwUDvQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7hzK7h9ezdyKIjEQiiK0rWFQ7JgnGsW+bEa
 aJKF1QHF4aJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge4QAKCRAADmhBGVaC
 FZVGD/9UPHIKGwhZMDW9JyDY7C9zQ8XqHf9rEMSWU0Vq/aGwGQ/VM9x6vQWyEpDq/XExD0TMB/Z
 dAs40V+Z7WoMivMNCiook5e0nMildg5uM8nwACmzvNrWjzBQ9laPEAWtprE2jQZOX7aHhJl2iux
 xpsKr0mgz8a8lQpmvGBg2bjRevGYILRlLJ3dRH3eyO+WZSmTMZCWpzB3ZrSeZ76MVJh1xMo8r+B
 FpR78mk4U32x2E3wDvSxcNJdQ6erjkxMkEFiOCbgTg2861M8/I1g+y9QHuc3fLGjahVuy4Ua1wm
 8Xp8VPXD5hODaB8XpjGjxWn5xHCstv5Ckwq5bMhqCyL2DzM0foX8vLlTX3VQSwZk0XmBcoeEG0z
 5upxkXravdzWvD2YKNLtRh+K4n8nV23vQN0gu47Tf5iLHRAwRXusod6pYjwPYhPUXxVoIGb9GUT
 FSn5TwqIYUahy8bj82oWC5uoa+aVhvzIQkBkhmEomj2440JBN4VOtreXABLTWfXh1B0Sz/frAGH
 niWHF5eLO5wOqxPQGKmXRwlblQ4I/IqGQb5mGwKjuqSEpXn05tzso2TfwM/Z5b2L3F5iC05Pwch
 gGmf1tBGp3kaXr1XaJKuwt2Q6rNNEiGOvlOHyt6y9XNjerEwgmLdKuoXMvIytIryrJHoBp7aYJC
 D0v7z2qSXPMTL7w==
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
	TAGGED_FROM(0.00)[bounces-20208-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: EFC7F29C431
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor cache_nfsd_nl_open() into a generic cache_genl_open() helper
that takes the family name, multicast group name, and output pointers
for the command socket, notification socket, and resolved family ID.
Convert cache_nfsd_nl_open() to use it.

Add the sunrpc genl family socket setup for handling auth.unix.ip and
auth.unix.gid cache upcalls. The sunrpc family is resolved at startup
and silently falls back if the kernel doesn't support it.

Add the ip_map (auth.unix.ip) netlink cache handler. For each pending
request, the handler resolves the IP address using client_resolve()
and responds via SUNRPC_CMD_IP_MAP_SET_REQS with the domain name or a
negative entry.

Wire the sunrpc notification socket into cache_open(), cache_set_fds(),
and cache_process_req().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/export/cache.c | 366 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 342 insertions(+), 24 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index c350662fd97c33c40c1d59297b9638141a67befb..50c2de08c504da1a05631938ee51251d82c52377 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -48,6 +48,12 @@
 #include "nfsd_netlink.h"
 #endif
 
+#ifdef USE_SYSTEM_SUNRPC_NETLINK_H
+#include <linux/sunrpc_netlink.h>
+#else
+#include "sunrpc_netlink.h"
+#endif
+
 #ifdef USE_BLKID
 #include "blkid/blkid.h"
 #endif
@@ -1108,58 +1114,71 @@ static struct nl_sock *nl_sock_setup(void)
 	return sock;
 }
 
-static int cache_nfsd_nl_open(void)
+static int cache_genl_open(const char *family_name, const char *mcgrp_name,
+			   struct nl_sock **cmd_sock,
+			   struct nl_sock **notify_sock, int *family_out)
 {
 	int grp;
 
-	nfsd_nl_family = 0;
+	*family_out = 0;
 
-	nfsd_nl_cmd_sock = nl_sock_setup();
-	if (!nfsd_nl_cmd_sock) {
-		xlog(D_NETLINK, "cache_nfsd_nl_open: failed to allocate command socket");
+	*cmd_sock = nl_sock_setup();
+	if (!*cmd_sock) {
+		xlog(D_NETLINK, "%s: failed to allocate command socket",
+		     family_name);
 		return -ENOMEM;
 	}
 
-	nfsd_nl_family = genl_ctrl_resolve(nfsd_nl_cmd_sock, NFSD_FAMILY_NAME);
-	if (nfsd_nl_family < 0) {
-		xlog(D_NETLINK, "cache_nfsd_nl_open: nfsd netlink family not found");
+	*family_out = genl_ctrl_resolve(*cmd_sock, family_name);
+	if (*family_out < 0) {
+		xlog(D_NETLINK, "%s: netlink family not found", family_name);
 		goto out_free_cmd;
 	}
 
-	grp = genl_ctrl_resolve_grp(nfsd_nl_cmd_sock, NFSD_FAMILY_NAME,
-				    NFSD_MCGRP_EXPORTD);
+	grp = genl_ctrl_resolve_grp(*cmd_sock, family_name, mcgrp_name);
 	if (grp < 0) {
-		xlog(D_NETLINK, "cache_nfsd_nl_open: exportd multicast group not found");
+		xlog(D_NETLINK, "%s: %s multicast group not found",
+		     family_name, mcgrp_name);
 		goto out_free_cmd;
 	}
 
-	nfsd_nl_notify_sock = nl_sock_setup();
-	if (!nfsd_nl_notify_sock) {
-		xlog(D_NETLINK, "cache_nfsd_nl_open: failed to allocate notify socket");
+	*notify_sock = nl_sock_setup();
+	if (!*notify_sock) {
+		xlog(D_NETLINK, "%s: failed to allocate notify socket",
+		     family_name);
 		goto out_free_cmd;
 	}
 
-	nl_socket_disable_seq_check(nfsd_nl_notify_sock);
+	nl_socket_disable_seq_check(*notify_sock);
 
-	if (nl_socket_add_membership(nfsd_nl_notify_sock, grp)) {
-		xlog(L_WARNING, "cache_nfsd_nl_open: failed to join exportd multicast group");
+	if (nl_socket_add_membership(*notify_sock, grp)) {
+		xlog(L_WARNING, "%s: failed to join %s multicast group",
+		     family_name, mcgrp_name);
 		goto out_free_notify;
 	}
 
-	nl_socket_set_nonblocking(nfsd_nl_notify_sock);
-	xlog(D_NETLINK, "cache_nfsd_nl_open: listening for export notifications");
+	nl_socket_set_nonblocking(*notify_sock);
+	xlog(D_NETLINK, "%s: listening for %s notifications",
+	     family_name, mcgrp_name);
 	return 0;
 
 out_free_notify:
-	nl_socket_free(nfsd_nl_notify_sock);
-	nfsd_nl_notify_sock = NULL;
+	nl_socket_free(*notify_sock);
+	*notify_sock = NULL;
 out_free_cmd:
-	nl_socket_free(nfsd_nl_cmd_sock);
-	nfsd_nl_cmd_sock = NULL;
-	nfsd_nl_family = 0;
+	nl_socket_free(*cmd_sock);
+	*cmd_sock = NULL;
+	*family_out = 0;
 	return -ENOENT;
 }
 
+static int cache_nfsd_nl_open(void)
+{
+	return cache_genl_open(NFSD_FAMILY_NAME, NFSD_MCGRP_EXPORTD,
+			       &nfsd_nl_cmd_sock, &nfsd_nl_notify_sock,
+			       &nfsd_nl_family);
+}
+
 static int nfsd_nl_notify_handler(struct nl_msg *UNUSED(msg), void *UNUSED(arg))
 {
 	return NL_OK;
@@ -1904,6 +1923,296 @@ static void cache_nfsd_nl_process(void)
 	cache_nl_process_expkey();
 }
 
+/*
+ * Netlink-based sunrpc cache support.
+ *
+ * The sunrpc genl family handles auth.unix.ip and auth.unix.gid caches.
+ * A SUNRPC_CMD_CACHE_NOTIFY on the "exportd" multicast group signals
+ * pending cache requests.
+ */
+static struct nl_sock *sunrpc_nl_notify_sock;
+static struct nl_sock *sunrpc_nl_cmd_sock;
+static int sunrpc_nl_family;
+
+static int cache_sunrpc_nl_open(void)
+{
+	return cache_genl_open(SUNRPC_FAMILY_NAME, SUNRPC_MCGRP_EXPORTD,
+			       &sunrpc_nl_cmd_sock, &sunrpc_nl_notify_sock,
+			       &sunrpc_nl_family);
+}
+
+static void cache_sunrpc_nl_drain(void)
+{
+	struct nl_cb *cb;
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb)
+		return;
+
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, nfsd_nl_notify_handler, NULL);
+	nl_recvmsgs(sunrpc_nl_notify_sock, cb);
+	nl_cb_put(cb);
+}
+
+/*
+ * ip_map (auth.unix.ip) netlink handler
+ */
+struct ip_map_req {
+	char	*class;
+	char	*addr;
+};
+
+struct get_ip_map_reqs_data {
+	struct ip_map_req	*reqs;
+	int			nreqs;
+	int			maxreqs;
+	int			err;
+};
+
+static int get_ip_map_reqs_cb(struct nl_msg *msg, void *arg)
+{
+	struct get_ip_map_reqs_data *data = arg;
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attr;
+	int rem;
+
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem) {
+		struct nlattr *tb[SUNRPC_A_IP_MAP_EXPIRY + 1];
+		struct ip_map_req *req;
+
+		if (nla_type(attr) != SUNRPC_A_IP_MAP_REQS_REQUESTS)
+			continue;
+
+		if (nla_parse_nested(tb, SUNRPC_A_IP_MAP_EXPIRY, attr,
+				     NULL))
+			continue;
+
+		if (!tb[SUNRPC_A_IP_MAP_CLASS] ||
+		    !tb[SUNRPC_A_IP_MAP_ADDR])
+			continue;
+
+		if (data->nreqs >= data->maxreqs) {
+			int newmax = data->maxreqs ? data->maxreqs * 2 : 16;
+			struct ip_map_req *tmp;
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
+		req->class = strdup(nla_get_string(tb[SUNRPC_A_IP_MAP_CLASS]));
+		req->addr = strdup(nla_get_string(tb[SUNRPC_A_IP_MAP_ADDR]));
+
+		if (!req->class || !req->addr) {
+			data->err = -ENOMEM;
+			return NL_STOP;
+		}
+	}
+
+	return NL_OK;
+}
+
+static int cache_nl_get_ip_map_reqs(struct ip_map_req **reqs_out,
+				    int *nreqs_out)
+{
+	struct get_ip_map_reqs_data data = { };
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int done = 0;
+	int ret;
+
+	msg = cache_nl_new_msg(sunrpc_nl_family,
+			       SUNRPC_CMD_IP_MAP_GET_REQS, NLM_F_DUMP);
+	if (!msg)
+		return -ENOMEM;
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb) {
+		nlmsg_free(msg);
+		return -ENOMEM;
+	}
+
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, get_ip_map_reqs_cb, &data);
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
+		int i;
+		for (i = 0; i < data.nreqs; i++) {
+			free(data.reqs[i].class);
+			free(data.reqs[i].addr);
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
+static int nl_add_ip_map(struct nl_msg *msg, char *class, char *addr,
+			 char *domain)
+{
+	struct nlattr *nest;
+	time_t now = time(0);
+
+	nest = nla_nest_start(msg, SUNRPC_A_IP_MAP_REQS_REQUESTS);
+	if (!nest)
+		return -1;
+
+	if (nla_put_string(msg, SUNRPC_A_IP_MAP_CLASS, class) < 0 ||
+	    nla_put_string(msg, SUNRPC_A_IP_MAP_ADDR, addr) < 0 ||
+	    nla_put_u64(msg, SUNRPC_A_IP_MAP_EXPIRY,
+			now + default_ttl) < 0)
+		goto nla_failure;
+
+	if (domain) {
+		if (nla_put_string(msg, SUNRPC_A_IP_MAP_DOMAIN,
+				   domain) < 0)
+			goto nla_failure;
+	} else {
+		if (nla_put_flag(msg, SUNRPC_A_IP_MAP_NEGATIVE) < 0)
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
+static void cache_nl_process_ip_map(void)
+{
+	struct ip_map_req *reqs = NULL;
+	int nreqs = 0;
+	struct nl_msg *msg;
+	int i;
+
+	if (cache_nl_get_ip_map_reqs(&reqs, &nreqs)) {
+		xlog(L_WARNING, "cache_nl_process_ip_map: failed to get ip_map requests");
+		return;
+	}
+
+	if (!nreqs)
+		return;
+
+	xlog(D_CALL, "cache_nl_process_ip_map: %d pending ip_map requests",
+	     nreqs);
+
+	msg = cache_nl_new_msg(sunrpc_nl_family,
+			       SUNRPC_CMD_IP_MAP_SET_REQS, 0);
+	if (!msg)
+		goto out_free;
+
+	for (i = 0; i < nreqs; i++) {
+		char *class = reqs[i].class;
+		char *ipaddr = reqs[i].addr;
+		char *client = NULL;
+		char *domain = NULL;
+		char *dom_alloc = NULL;
+		struct addrinfo *tmp = NULL;
+
+		if (strcmp(class, "nfsd") == 0) {
+			tmp = host_pton(ipaddr);
+			if (tmp) {
+				struct addrinfo *ai;
+
+				ai = client_resolve(tmp->ai_addr);
+				if (ai) {
+					client = client_compose(ai);
+					nfs_freeaddrinfo(ai);
+				}
+			}
+
+			if (use_ipaddr && client) {
+				dom_alloc = malloc(strlen(ipaddr) + 2);
+				if (dom_alloc) {
+					dom_alloc[0] = '$';
+					strcpy(dom_alloc + 1, ipaddr);
+					domain = dom_alloc;
+				}
+			} else if (client) {
+				domain = *client ? client : "DEFAULT";
+			}
+		}
+
+		if (nl_add_ip_map(msg, class, ipaddr, domain) < 0) {
+			cache_nl_set_reqs(sunrpc_nl_cmd_sock, msg);
+			nlmsg_free(msg);
+			msg = cache_nl_new_msg(sunrpc_nl_family,
+					       SUNRPC_CMD_IP_MAP_SET_REQS, 0);
+			if (!msg) {
+				free(dom_alloc);
+				free(client);
+				nfs_freeaddrinfo(tmp);
+				goto out_free;
+			}
+			if (nl_add_ip_map(msg, class, ipaddr, domain) < 0)
+				xlog(L_WARNING, "%s: skipping oversized "
+				     "entry for %s", __func__, ipaddr);
+		}
+
+		if (tmp && !client)
+			xlog(D_AUTH, "failed authentication for IP %s",
+			     ipaddr);
+		else if (client && !use_ipaddr)
+			xlog(D_AUTH, "successful authentication for IP %s as %s",
+			     ipaddr, *client ? client : "DEFAULT");
+		else if (client)
+			xlog(D_AUTH, "successful authentication for IP %s",
+			     ipaddr);
+
+		free(dom_alloc);
+		free(client);
+		nfs_freeaddrinfo(tmp);
+	}
+
+	cache_nl_set_reqs(sunrpc_nl_cmd_sock, msg);
+	nlmsg_free(msg);
+
+out_free:
+	for (i = 0; i < nreqs; i++) {
+		free(reqs[i].class);
+		free(reqs[i].addr);
+	}
+	free(reqs);
+}
+
+static void cache_sunrpc_nl_process(void)
+{
+	/* Drain pending sunrpc notifications */
+	cache_sunrpc_nl_drain();
+
+	auth_reload();
+
+	/* Handle any pending ip_map requests */
+	cache_nl_process_ip_map();
+}
+
 static int can_reexport_via_fsidnum(struct exportent *exp, struct statfs *st)
 {
 	if (st->f_type != 0x6969 /* NFS_SUPER_MAGIC */)
@@ -2476,6 +2785,7 @@ void cache_open(void)
 		cachelist[i].f = open(path, O_RDWR);
 	}
 	cache_nfsd_nl_open();
+	cache_sunrpc_nl_open();
 }
 
 /**
@@ -2491,6 +2801,8 @@ void cache_set_fds(fd_set *fdset)
 	}
 	if (nfsd_nl_notify_sock)
 		FD_SET(nl_socket_get_fd(nfsd_nl_notify_sock), fdset);
+	if (sunrpc_nl_notify_sock)
+		FD_SET(nl_socket_get_fd(sunrpc_nl_notify_sock), fdset);
 }
 
 /**
@@ -2515,6 +2827,12 @@ int cache_process_req(fd_set *readfds)
 		cache_nfsd_nl_process();
 		FD_CLR(nl_socket_get_fd(nfsd_nl_notify_sock), readfds);
 	}
+	if (sunrpc_nl_notify_sock &&
+	    FD_ISSET(nl_socket_get_fd(sunrpc_nl_notify_sock), readfds)) {
+		cnt++;
+		cache_sunrpc_nl_process();
+		FD_CLR(nl_socket_get_fd(sunrpc_nl_notify_sock), readfds);
+	}
 	return cnt;
 }
 

-- 
2.53.0


