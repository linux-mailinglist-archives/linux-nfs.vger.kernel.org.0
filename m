Return-Path: <linux-nfs+bounces-20522-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOkDMSB9ymlo9QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20522-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA0135C237
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A7E83012E7C
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E33B3D525A;
	Mon, 30 Mar 2026 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT482aoX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED0D3D522F
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877930; cv=none; b=gvQdL/vfHpLmMvhjwcaGz5+uds2+7WrhxQZrAejiw1lG/zlH14vdBSv4FFDPh+dqcasLhRh2dTJgjoq4iafi0arRkaTudribCMWPQ8Joj39zS5YkRXxXReGIhqvCvSqGgDpYDJ7s6G2LFlKcgMf3ON2va+82qu79ru4Hf6Ajwk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877930; c=relaxed/simple;
	bh=3WcNOA0X2LfZ6bxs6Ad2eEyxDHrhQBB1QaByR5yZd70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NCTFmxVcKGyyYkD6AEZjHh5Kw9GU90JrG7NjkhbIRkOpK2RCYOZEwGMOiMOdQgoDVoxRSczdLj1mXZAX9Gf7E3kOQSjhjOTh4jDHhgwoOVVlz90a8JcJgGMWtFWPX94NzKT83UXpvCXs8Z4kXqbCLyKAV8BXBEJi4i+iLBSbjoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT482aoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D585AC2BCB2;
	Mon, 30 Mar 2026 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877930;
	bh=3WcNOA0X2LfZ6bxs6Ad2eEyxDHrhQBB1QaByR5yZd70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cT482aoXOguG+ye64RU3GW1BXtPIrxXDy2pvOpAGZiFbu0+lyMXaG/ygGmXLn8UC/
	 hMW3U/pr8/WPJ4huZ1lGjWsIwpULPhml3F4OPrUGOUAg86JT5FqdGLNtVsdkbuHcA8
	 JRA4RRFYgnYnNKCZP3I4bGBPoYRCCBBJVhpoB4zxbFz5wp/5eTrwNCDqlZbgf9oKSY
	 OnBGDqdFDhaRlWYMsM6XPRIImJZ2czXcs67SiO0az/ZDy0fE6ars/+OdqcDcB+ithh
	 uPI9nKb+47HyY7sbEkxvt3Vgy4v8zaS/tKr0Y/JWqjFL0wAVP16qElVrPhdgMI13NL
	 yIppSa+ngtcjA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 30 Mar 2026 09:38:27 -0400
Subject: [PATCH nfs-utils v2 07/16] exportd/mountd: add netlink support for
 svc_export cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-exportd-netlink-v2-7-cc9bd5db2408@kernel.org>
References: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
In-Reply-To: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16138; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3WcNOA0X2LfZ6bxs6Ad2eEyxDHrhQBB1QaByR5yZd70=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpynzfDqGpzK0YyCYQ9R2QQUEIWUsHAqaAk/zXJ
 lsETf3POKSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacp83wAKCRAADmhBGVaC
 FX6pD/wNuXQe/Opjb5pOZAbFJMs6ZmGDMhtrU6DTf/pVF9D8ILlg46noELwJMmgP3L1USE1xI8D
 q5m+404by8BNeI+hJ7lwLOcIkYuCbhDV8OPuZAauqYeGKQGN1+kFraznNrtvKDxVkf2cWSUPV1O
 wPyb2/w0j86e24gCBW4E6N4pi0axycOS1SeB1ik9KXIh1RoXeeKYuI/J4ZnZAS7E1AFz9IvNKYQ
 Vt6gGHFUjolg9HasLX7UuWf2M1XgHU3g8nBKmhSFnAzTALlIGuk4G9jaj7R7968mRoQgujf9fvX
 ZTltjFXujq0TNkXp7y9mGWrpawWopkhs+wcqptYfjQ31bihh2Jd+JejP/C9Ne1r0mkf5gZtciyp
 zLf/HvotbFb3Ac6bvGw34rdFXIil9jlXWaA7eE+vkf2kPrCJcZzIA8EF3RLQirGMDVb+/+QiXeJ
 DXpzzkZXeBxhbyXxMcrZrMjH4Kd9DJR2gEA8dRi4kfOFTyr0LqRsfDkvtI7FjH0YxDEkdTXkp3W
 vepaAnlVG1B+PL3TLIkmUrrygH9AjEWuQA7WrxVqZEQ/axeTBZKuuyHiQSCXrSGT4SJJmyeKKU9
 HtKVUr2M6j/2fiZ0yg173XzztwILMNyWpd8i/korqtBRnolhclsgwZNUj5+aHwakmoBVsXTTThx
 UuHF8ySZy2Rf0IA==
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
	TAGGED_FROM(0.00)[bounces-20522-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: ADA0135C237
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add netlink-based svc_export cache handling alongside the existing
procfs channel mechanism. When the kernel sends an
NFSD_CMD_SVC_EXPORT_NOTIFY multicast notification on the "exportd"
genetlink group, userspace responds by issuing
NFSD_CMD_SVC_EXPORT_GET_REQS to retrieve all pending export requests,
resolving each one via lookup_export(), and sending back the results
with NFSD_CMD_SVC_EXPORT_SET_REQS.

Two netlink sockets are used: a non-blocking notification socket that
joins the multicast group and is integrated into the existing select()
loop, and a blocking command socket for the GET_REQS dump and SET_REQS
response. The notification socket is added to the fd_set in
cache_set_fds() and checked in cache_process_req().

If the kernel does not support the nfsd genetlink family or the
"exportd" multicast group (older kernels), the netlink setup silently
fails and the daemon falls back to procfs-only operation. Both
mechanisms can coexist safely since the kernel's CACHE_PENDING check
prevents duplicate processing.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/export/cache.c | 560 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 558 insertions(+), 2 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index c052455889481f04631e4ef0e16cd48bc6c11964..090ea0a6cc6da7e9c2ce255601103d2442526067 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -36,6 +36,18 @@
 #include "reexport.h"
 #include "fsloc.h"
 
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+#include <linux/netlink.h>
+
+#ifdef USE_SYSTEM_NFSD_NETLINK_H
+#include <linux/nfsd_netlink.h>
+#else
+#include "nfsd_netlink.h"
+#endif
+
 #ifdef USE_BLKID
 #include "blkid/blkid.h"
 #endif
@@ -1052,6 +1064,541 @@ static void write_xprtsec(char **bp, int *blen, struct exportent *ep)
 		qword_addint(bp, blen, p->info->number);
 }
 
+/*
+ * Netlink-based svc_export cache support.
+ *
+ * The kernel can notify userspace of pending export cache requests via
+ * the "exportd" genetlink multicast group. We listen for
+ * NFSD_CMD_SVC_EXPORT_NOTIFY, then issue NFSD_CMD_SVC_EXPORT_GET_REQS
+ * to retrieve pending requests, resolve them, and respond with
+ * NFSD_CMD_SVC_EXPORT_SET_REQS.
+ */
+static nfs_export *lookup_export(char *dom, char *path, struct addrinfo *ai);
+static struct nl_msg *cache_nl_new_msg(int family, int cmd, int flags);
+
+static struct nl_sock *nfsd_nl_notify_sock;	/* multicast notifications */
+static struct nl_sock *nfsd_nl_cmd_sock;	/* GET_REQS / SET_REQS commands */
+static int nfsd_nl_family;
+
+#define NL_BUFFER_SIZE	65536
+
+struct export_req {
+	char	*client;
+	char	*path;
+};
+
+static struct nl_sock *nl_sock_setup(void)
+{
+	struct nl_sock *sock;
+	int val = 1;
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		return NULL;
+
+	if (genl_connect(sock)) {
+		nl_socket_free(sock);
+		return NULL;
+	}
+
+	nl_socket_set_buffer_size(sock, NL_BUFFER_SIZE, NL_BUFFER_SIZE);
+	setsockopt(nl_socket_get_fd(sock), SOL_NETLINK, NETLINK_EXT_ACK,
+		   &val, sizeof(val));
+
+	return sock;
+}
+
+static int cache_nfsd_nl_open(void)
+{
+	int grp;
+
+	nfsd_nl_family = 0;
+
+	nfsd_nl_cmd_sock = nl_sock_setup();
+	if (!nfsd_nl_cmd_sock) {
+		xlog(D_NETLINK, "cache_nfsd_nl_open: failed to allocate command socket");
+		return -ENOMEM;
+	}
+
+	nfsd_nl_family = genl_ctrl_resolve(nfsd_nl_cmd_sock, NFSD_FAMILY_NAME);
+	if (nfsd_nl_family < 0) {
+		xlog(D_NETLINK, "cache_nfsd_nl_open: nfsd netlink family not found");
+		goto out_free_cmd;
+	}
+
+	grp = genl_ctrl_resolve_grp(nfsd_nl_cmd_sock, NFSD_FAMILY_NAME,
+				    NFSD_MCGRP_EXPORTD);
+	if (grp < 0) {
+		xlog(D_NETLINK, "cache_nfsd_nl_open: exportd multicast group not found");
+		goto out_free_cmd;
+	}
+
+	nfsd_nl_notify_sock = nl_sock_setup();
+	if (!nfsd_nl_notify_sock) {
+		xlog(D_NETLINK, "cache_nfsd_nl_open: failed to allocate notify socket");
+		goto out_free_cmd;
+	}
+
+	nl_socket_disable_seq_check(nfsd_nl_notify_sock);
+
+	if (nl_socket_add_membership(nfsd_nl_notify_sock, grp)) {
+		xlog(L_WARNING, "cache_nfsd_nl_open: failed to join exportd multicast group");
+		goto out_free_notify;
+	}
+
+	nl_socket_set_nonblocking(nfsd_nl_notify_sock);
+	xlog(D_NETLINK, "cache_nfsd_nl_open: listening for export notifications");
+	return 0;
+
+out_free_notify:
+	nl_socket_free(nfsd_nl_notify_sock);
+	nfsd_nl_notify_sock = NULL;
+out_free_cmd:
+	nl_socket_free(nfsd_nl_cmd_sock);
+	nfsd_nl_cmd_sock = NULL;
+	nfsd_nl_family = 0;
+	return -ENOENT;
+}
+
+static int nfsd_nl_notify_handler(struct nl_msg *UNUSED(msg), void *UNUSED(arg))
+{
+	return NL_OK;
+}
+
+static void cache_nfsd_nl_drain(void)
+{
+	struct nl_cb *cb;
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb)
+		return;
+
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, nfsd_nl_notify_handler, NULL);
+	nl_recvmsgs(nfsd_nl_notify_sock, cb);
+	nl_cb_put(cb);
+}
+
+struct get_export_reqs_data {
+	struct export_req	*reqs;
+	int			nreqs;
+	int			maxreqs;
+	int			err;
+};
+
+static int get_export_reqs_cb(struct nl_msg *msg, void *arg)
+{
+	struct get_export_reqs_data *data = arg;
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attr;
+	int rem;
+
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem) {
+		struct nlattr *tb[NFSD_A_SVC_EXPORT_PATH + 1];
+		struct export_req *req;
+
+		if (nla_type(attr) != NFSD_A_SVC_EXPORT_REQS_REQUESTS)
+			continue;
+
+		if (nla_parse_nested(tb, NFSD_A_SVC_EXPORT_PATH, attr,
+				     NULL))
+			continue;
+
+		if (!tb[NFSD_A_SVC_EXPORT_CLIENT] ||
+		    !tb[NFSD_A_SVC_EXPORT_PATH])
+			continue;
+
+		if (data->nreqs >= data->maxreqs) {
+			int newmax = data->maxreqs ? data->maxreqs * 2 : 16;
+			struct export_req *tmp;
+
+			tmp = realloc(data->reqs,
+				      newmax * sizeof(*tmp));
+			if (!tmp) {
+				data->err = -ENOMEM;
+				return NL_STOP;
+			}
+			data->reqs = tmp;
+			data->maxreqs = newmax;
+		}
+
+		req = &data->reqs[data->nreqs++];
+		req->client = strdup(nla_get_string(tb[NFSD_A_SVC_EXPORT_CLIENT]));
+		req->path = strdup(nla_get_string(tb[NFSD_A_SVC_EXPORT_PATH]));
+
+		if (!req->client || !req->path) {
+			data->err = -ENOMEM;
+			return NL_STOP;
+		}
+	}
+
+	return NL_OK;
+}
+
+static int nl_finish_cb(struct nl_msg *UNUSED(msg), void *arg)
+{
+	int *done = arg;
+
+	*done = 1;
+	return NL_STOP;
+}
+
+static int nl_error_cb(struct sockaddr_nl *UNUSED(nla),
+		       struct nlmsgerr *UNUSED(nlerr), void *arg)
+{
+	int *done = arg;
+
+	*done = 1;
+	return NL_STOP;
+}
+
+static int cache_nl_get_export_reqs(struct export_req **reqs_out, int *nreqs_out)
+{
+	struct get_export_reqs_data data = { };
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int done = 0;
+	int ret;
+
+	msg = cache_nl_new_msg(nfsd_nl_family,
+			       NFSD_CMD_SVC_EXPORT_GET_REQS, NLM_F_DUMP);
+	if (!msg)
+		return -ENOMEM;
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb) {
+		nlmsg_free(msg);
+		return -ENOMEM;
+	}
+
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, get_export_reqs_cb, &data);
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
+			free(data.reqs[i].path);
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
+static int nfsd_nl_add_fsloc(struct nl_msg *msg, struct exportent *ep)
+{
+	struct servers *servers;
+	struct nlattr *fslocs;
+	int i;
+
+	if (ep->e_fslocmethod == FSLOC_NONE)
+		return 0;
+
+	servers = replicas_lookup(ep->e_fslocmethod, ep->e_fslocdata);
+	if (!servers)
+		return 0;
+
+	if (servers->h_num < 0) {
+		release_replicas(servers);
+		return 0;
+	}
+
+	fslocs = nla_nest_start(msg, NFSD_A_SVC_EXPORT_FSLOCATIONS);
+	if (!fslocs) {
+		release_replicas(servers);
+		return -1;
+	}
+
+	for (i = 0; i < servers->h_num; i++) {
+		struct nlattr *loc;
+
+		loc = nla_nest_start(msg, NFSD_A_FSLOCATIONS_LOCATION);
+		if (!loc) {
+			release_replicas(servers);
+			return -1;
+		}
+
+		if (nla_put_string(msg, NFSD_A_FSLOCATION_HOST,
+				   servers->h_mp[i]->h_host) < 0 ||
+		    nla_put_string(msg, NFSD_A_FSLOCATION_PATH,
+				   servers->h_mp[i]->h_path) < 0) {
+			nla_nest_cancel(msg, fslocs);
+			release_replicas(servers);
+			return -1;
+		}
+		nla_nest_end(msg, loc);
+	}
+
+	nla_nest_end(msg, fslocs);
+	release_replicas(servers);
+	return 0;
+}
+
+static int nfsd_nl_add_secinfo(struct nl_msg *msg, struct exportent *ep)
+{
+	struct sec_entry *p;
+
+	for (p = ep->e_secinfo; p->flav; p++)
+		; /* count */
+	if (p == ep->e_secinfo)
+		return 0;
+
+	fix_pseudoflavor_flags(ep);
+	for (p = ep->e_secinfo; p->flav; p++) {
+		struct nlattr *sec;
+
+		sec = nla_nest_start(msg, NFSD_A_SVC_EXPORT_SECINFO);
+		if (!sec)
+			return -1;
+
+		if (nla_put_u32(msg, NFSD_A_AUTH_FLAVOR_PSEUDOFLAVOR,
+				p->flav->fnum) < 0 ||
+		    nla_put_u32(msg, NFSD_A_AUTH_FLAVOR_FLAGS,
+				p->flags) < 0)
+			return -1;
+		nla_nest_end(msg, sec);
+	}
+
+	return 0;
+}
+
+static int nfsd_nl_add_xprtsec(struct nl_msg *msg, struct exportent *ep)
+{
+	struct xprtsec_entry *p;
+
+	for (p = ep->e_xprtsec; p->info; p++)
+		;
+	if (p == ep->e_xprtsec)
+		return 0;
+
+	for (p = ep->e_xprtsec; p->info; p++)
+		if (nla_put_u32(msg, NFSD_A_SVC_EXPORT_XPRTSEC,
+				p->info->number) < 0)
+			return -1;
+
+	return 0;
+}
+
+static int nfsd_nl_add_export(struct nl_msg *msg, char *domain, char *path,
+			 struct exportent *exp, int ttl)
+{
+	struct nlattr *nest;
+	time_t now = time(0);
+	char u[16];
+
+	if (ttl <= 1)
+		ttl = default_ttl;
+
+	nest = nla_nest_start(msg, NFSD_A_SVC_EXPORT_REQS_REQUESTS);
+	if (!nest)
+		return -1;
+
+	if (nla_put_string(msg, NFSD_A_SVC_EXPORT_CLIENT, domain) < 0 ||
+	    nla_put_string(msg, NFSD_A_SVC_EXPORT_PATH, path) < 0 ||
+	    nla_put_u64(msg, NFSD_A_SVC_EXPORT_EXPIRY, now + ttl) < 0)
+		goto nla_failure;
+
+	if (!exp) {
+		if (nla_put_flag(msg, NFSD_A_SVC_EXPORT_NEGATIVE) < 0)
+			goto nla_failure;
+	} else {
+		if (nla_put_u32(msg, NFSD_A_SVC_EXPORT_ANON_UID,
+				exp->e_anonuid) < 0 ||
+		    nla_put_u32(msg, NFSD_A_SVC_EXPORT_ANON_GID,
+				exp->e_anongid) < 0 ||
+		    nla_put_u32(msg, NFSD_A_SVC_EXPORT_FLAGS,
+				exp->e_flags) < 0 ||
+		    nla_put_s32(msg, NFSD_A_SVC_EXPORT_FSID,
+				exp->e_fsid) < 0)
+			goto nla_failure;
+
+		if (nfsd_nl_add_fsloc(msg, exp))
+			goto nla_failure;
+
+		if (exp->e_uuid) {
+			get_uuid(exp->e_uuid, 16, u);
+			if (nla_put(msg, NFSD_A_SVC_EXPORT_UUID,
+				    16, u) < 0)
+				goto nla_failure;
+		} else if (uuid_by_path(path, 0, 16, u)) {
+			if (nla_put(msg, NFSD_A_SVC_EXPORT_UUID,
+				    16, u) < 0)
+				goto nla_failure;
+		}
+
+		if (nfsd_nl_add_secinfo(msg, exp))
+			goto nla_failure;
+
+		if (nfsd_nl_add_xprtsec(msg, exp))
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
+static struct nl_msg *cache_nl_new_msg(int family, int cmd, int flags)
+{
+	struct nl_msg *msg;
+
+	msg = nlmsg_alloc();
+	if (!msg)
+		return NULL;
+
+	if (!genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family,
+			 0, flags, cmd, 0)) {
+		nlmsg_free(msg);
+		return NULL;
+	}
+	return msg;
+}
+
+static int cache_nl_set_reqs(struct nl_msg *msg)
+{
+	struct nl_cb *cb;
+	int done = 0;
+	int ret;
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb)
+		return -ENOMEM;
+
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, nl_finish_cb, &done);
+	nl_cb_err(cb, NL_CB_CUSTOM, nl_error_cb, &done);
+
+	ret = nl_send_auto(nfsd_nl_cmd_sock, msg);
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
+	if (ret < 0)
+		xlog(L_WARNING, "%s: SET_REQS failed: %d", __func__, ret);
+	return ret;
+}
+
+static void cache_nl_process_export(void)
+{
+	struct export_req *reqs = NULL;
+	int nreqs = 0;
+	struct nl_msg *msg;
+	int i;
+
+	/* Drain pending notifications */
+	cache_nfsd_nl_drain();
+
+	/* Fetch all pending requests from the kernel */
+	if (cache_nl_get_export_reqs(&reqs, &nreqs)) {
+		xlog(L_WARNING, "cache_nl_process_export: failed to get export requests");
+		return;
+	}
+
+	if (!nreqs)
+		return;
+
+	xlog(D_CALL, "cache_nl_process_export: %d pending export requests", nreqs);
+
+	/* Build the SET_REQS response */
+	msg = cache_nl_new_msg(nfsd_nl_family,
+			       NFSD_CMD_SVC_EXPORT_SET_REQS, 0);
+	if (!msg)
+		goto out_free;
+
+	auth_reload();
+
+	for (i = 0; i < nreqs; i++) {
+		char *dom = reqs[i].client;
+		char *path = reqs[i].path;
+		struct addrinfo *ai = NULL;
+		nfs_export *found = NULL;
+		struct exportent *epp = NULL;
+		int ttl = 0;
+
+		if (is_ipaddr_client(dom)) {
+			ai = lookup_client_addr(dom);
+			if (!ai)
+				xlog(D_AUTH, "cache_nl_process_export: "
+				     "failed to resolve client %s", dom);
+		}
+
+		if (ai || !is_ipaddr_client(dom))
+			found = lookup_export(dom, path, ai);
+
+		if (found) {
+			char *mp = found->m_export.e_mountpoint;
+
+			if (mp && !*mp)
+				mp = found->m_export.e_path;
+			if (mp && !is_mountpoint(mp)) {
+				xlog(L_WARNING,
+				     "Cannot export path '%s': not a mountpoint",
+				     path);
+				ttl = 60;
+			} else {
+				epp = &found->m_export;
+			}
+		}
+
+		if (nfsd_nl_add_export(msg, dom, path, epp, ttl) < 0) {
+			cache_nl_set_reqs(msg);
+			nlmsg_free(msg);
+			msg = cache_nl_new_msg(nfsd_nl_family,
+					       NFSD_CMD_SVC_EXPORT_SET_REQS, 0);
+			if (!msg) {
+				nfs_freeaddrinfo(ai);
+				goto out_free;
+			}
+			if (nfsd_nl_add_export(msg, dom, path,
+					       epp, ttl) < 0)
+				xlog(L_WARNING, "%s: skipping oversized "
+				     "entry for %s", __func__, path);
+		}
+
+		nfs_freeaddrinfo(ai);
+	}
+
+	cache_nl_set_reqs(msg);
+	nlmsg_free(msg);
+
+out_free:
+	for (i = 0; i < nreqs; i++) {
+		free(reqs[i].client);
+		free(reqs[i].path);
+	}
+	free(reqs);
+}
+
 static int can_reexport_via_fsidnum(struct exportent *exp, struct statfs *st)
 {
 	if (st->f_type != 0x6969 /* NFS_SUPER_MAGIC */)
@@ -1612,7 +2159,7 @@ extern int manage_gids;
  * cache_open - prepare communications channels with kernel RPC caches
  *
  */
-void cache_open(void) 
+void cache_open(void)
 {
 	int i;
 
@@ -1623,6 +2170,7 @@ void cache_open(void)
 		sprintf(path, "/proc/net/rpc/%s/channel", cachelist[i].cache_name);
 		cachelist[i].f = open(path, O_RDWR);
 	}
+	cache_nfsd_nl_open();
 }
 
 /**
@@ -1636,13 +2184,15 @@ void cache_set_fds(fd_set *fdset)
 		if (cachelist[i].f >= 0)
 			FD_SET(cachelist[i].f, fdset);
 	}
+	if (nfsd_nl_notify_sock)
+		FD_SET(nl_socket_get_fd(nfsd_nl_notify_sock), fdset);
 }
 
 /**
  * cache_process_req - process any active cache file descriptors during service loop iteration
  * @fdset: pointer to fd_set to examine for activity
  */
-int cache_process_req(fd_set *readfds) 
+int cache_process_req(fd_set *readfds)
 {
 	int i;
 	int cnt = 0;
@@ -1654,6 +2204,12 @@ int cache_process_req(fd_set *readfds)
 			FD_CLR(cachelist[i].f, readfds);
 		}
 	}
+	if (nfsd_nl_notify_sock &&
+	    FD_ISSET(nl_socket_get_fd(nfsd_nl_notify_sock), readfds)) {
+		cnt++;
+		cache_nl_process_export();
+		FD_CLR(nl_socket_get_fd(nfsd_nl_notify_sock), readfds);
+	}
 	return cnt;
 }
 

-- 
2.53.0


