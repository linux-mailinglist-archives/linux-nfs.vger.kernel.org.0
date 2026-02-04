Return-Path: <linux-nfs+bounces-18699-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMnmHVY8g2ngjwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18699-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 13:32:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB09E5D47
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 13:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E45A530689B6
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 12:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13A03EDABC;
	Wed,  4 Feb 2026 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XugCNSrS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED853EDAB7
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208123; cv=none; b=Snik0sibJ61z8bhpiZhls8KSCNVpBw/MqJYVe9Zs4QQTCbPQBhN9Hz71sLmIioADfAhA2Y6ip7fFNqkEuamlkuSio48Q4mEmlH0P2A4e64hQrUEXGVVK0ohR5QFi/MLgfSHmXdXTwAkeL4Iysdc+zF2PoLVhoerDscH0cHViBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208123; c=relaxed/simple;
	bh=EUn5HLp25hQcfdWkP7lBvHIYb/yKaPLaWCjj+FYzJ+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUA9z+XKRWu+Pkui10fyUjAB4D54hxE1BsHLjXQBgh1sMcAaz8sNbsFviFr8VIg2tIvKQdsw64zESONLfobRBkF8HgCZO6YmapYAMIH1ShFOneUi8gOD6pn88MrPo3kvqgTtbA01YIYnkPTsDgiekTv8xY4UVhzmlQ4VJgHf5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XugCNSrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EA0C2BC87;
	Wed,  4 Feb 2026 12:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770208123;
	bh=EUn5HLp25hQcfdWkP7lBvHIYb/yKaPLaWCjj+FYzJ+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XugCNSrSF81KbR7SbhWHnBjDjK3o9P0IM+UB3pcGqcb1kLZZaqf1bf3UqpfIVZu1/
	 wBMqyVi965nWzjsRlaKmazxAPbNNJ1OMxzX5QTGYxBXt71K25BqxdJmoZuKbyiZ015
	 cwpt4OI38Xm7WCUElc0IgRxba8krlihh/QpilN7squsv1/QCW8hPa25lyy5H4HAEed
	 hSK0sTTxOLDuALUvpOzRAIMdhjOH8qI2rVOv0sah513jE604Ey7loOeWlAuq8travw
	 9UfnGQs0bUOEkJI+ISjC6e0i0E/ezLeN9lfR2yTCQUWt9zivEL29YIiK/RVXeU3ltw
	 LtuiUfR3ShdRg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Feb 2026 07:28:27 -0500
Subject: [PATCH nfs-utils 2/3] nfsdctl: query netlink policy before sending
 the minthreads attribute to kernel
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-minthreads-v1-2-9f348608f884@kernel.org>
References: <20260204-minthreads-v1-0-9f348608f884@kernel.org>
In-Reply-To: <20260204-minthreads-v1-0-9f348608f884@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Ben Coddington <bcodding@hammerspace.com>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5012; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EUn5HLp25hQcfdWkP7lBvHIYb/yKaPLaWCjj+FYzJ+4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpgzt45652kV8kO7MHkPx3pfXeIAZB5xCz3xbGs
 ma67o+GX8KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaYM7eAAKCRAADmhBGVaC
 FTHhD/9w06a9ZFJ/56n5EICyGpUQbrdbknLESOSc8mFYIEml+aTD6E5DyMNgZPGTQFZk6C+QC2+
 +1u03p88nxRex2CQZgrqwUhfRh2iI4AB4RBbNe8hP9Ac3qoeOtJ/qLQbSkflhzznXiivvKXMOXb
 PLB5oy3/SAIr0jLaz466ygFIGZgUiz0oG1/PbmbjbIgKZsQE9kdp3bIINEZLMK3/ivbcvjlbiaa
 4wWda3NNynRKMcb8LyRW2UmzUqZYy5BlNfheW3q/wtYRJkWitse+jvSCQTUC1oRjwsueTwjVid8
 7myDu1zik5gs11HgP0NBC+iAF/VbvxkrnrP1vqNVh9qhEV3VHoLOjTpNQCjaeFOVy9Npl6DhkUX
 EUWSc2M7AuplQBiVoPLSo5aUlatYX5qfxDl89y8t4QhrJcn/IKhbbyGrRpBbGoXV7jBV8wsQ9fE
 L/v/Oo3RiI3AdfnbUyD2qd/u9KztopFwKxOGX0WxvvgympTXJcMd07XQvjTVv/d2P+ib273X6gZ
 1w3uduLXIJpQkkDEkEA8GwARAPhG1GcGVy87ZrY1UEOwO7rYh/brqv1EPpXJ0ZMnA/dy67jxKto
 vmuPlBZ3rPolXiRJ21w8ezhWurNx94DALD0ZgiTm1AwcWDOamMBBN6qefG/tOZ3q86V1AWkGtWm
 Uo7QSN+58lYyfKg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18699-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECB09E5D47
X-Rspamd-Action: no action

Ben reported a problem when using new nfs-utils with an old kernel that
doesn't support the min-threads setting. While netlink is an extensible
format, genetlink (which we are using) will reject unknown attributes by
default with -EINVAL.

We could fix this in the kernel by having it ignore unknown attributes,
but there is no way to fix old kernels and silently ignoring it is less
than ideal. By handling this in userland, we can properly error out when
the kernel doesn't support this attribute.

When starting, have nfsdctl query the kernel for the "policy" of the
threads operation, and determine the highest attribute index it
supports.  For the "threads" command, have it fail if the --min-threads
option is passed and the kernel doesn't support it. For "autostart", log
a warning and ignore the setting.

Fixes: 00e2e62b8998 ("nfsdctl: add support for min-threads parameter")
Reported-by: Ben Coddington <bcodding@hammerspace.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsdctl/nfsdctl.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 0d624d4de6016e3c9189d488736eb1b9b2f6fe6e..68c93039f3440a73285fd3f1e8b1131c1c945efb 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -52,6 +52,9 @@ static int lockd_nl_family;
 /* The index of the "nfsd" netlink family */
 static int nfsd_nl_family;
 
+/* The highest attribute index supported by NFSD_CMD_THREADS_SET on this kernel */
+int nfsd_threads_max_nlattr;
+
 struct nfs_version {
 	uint8_t	major;
 	uint8_t	minor;
@@ -482,6 +485,83 @@ static int nfsd_nl_family_setup(struct nl_sock *sock)
 	return nfsd_nl_family;
 }
 
+static int getpolicy_handler(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attr;
+	int rem;
+
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0), genlmsg_attrlen(gnlh, 0), rem) {
+		struct nlattr *a, *b;
+		int i, j, index;
+
+		if (nla_type(attr) == CTRL_ATTR_POLICY) {
+			nla_for_each_nested(a, attr, i) {
+				nla_for_each_nested(b, a, j) {
+					int idx = nla_type(b);
+
+					if (nfsd_threads_max_nlattr < idx)
+						nfsd_threads_max_nlattr = idx;
+				}
+			}
+		}
+	}
+	return 0;
+}
+
+static int query_nfsd_nl_policy(struct nl_sock *sock)
+{
+	struct genlmsghdr *ghdr;
+	struct nlmsghdr *nlh;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int opt, ret, id;
+
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, GENL_ID_CTRL);
+	if (!msg)
+		return 1;
+
+	nlh = nlmsg_hdr(msg);
+	nlh->nlmsg_flags |= NLM_F_DUMP;
+	ghdr = nlmsg_data(nlh);
+	ghdr->cmd = CTRL_CMD_GETPOLICY;
+
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		xlog(L_ERROR, "failed to allocate netlink callbacks");
+		ret = 1;
+		goto out;
+	}
+
+	nla_put_u16(msg, CTRL_ATTR_FAMILY_ID, nfsd_nl_family);
+	nla_put_u32(msg, CTRL_ATTR_OP, NFSD_CMD_THREADS_SET);
+
+	ret = nl_send_auto(sock, msg);
+	if (ret < 0)
+		goto out_cb;
+
+	ret = 1;
+	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, getpolicy_handler, NULL);
+
+	while (ret > 0)
+		nl_recvmsgs(sock, cb);
+	if (ret < 0) {
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
+		ret = 1;
+	}
+out_cb:
+	nl_cb_put(cb);
+out:
+	nlmsg_free(msg);
+	return ret;
+}
+
 static void status_usage(void)
 {
 	printf("Usage: %s status\n", taskname);
@@ -652,6 +732,11 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 			return 0;
 #if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
 		case 'm':
+			if (nfsd_threads_max_nlattr < NFSD_A_SERVER_MIN_THREADS) {
+				xlog(L_ERROR, "Kernel does not support dynamic threading.");
+				return 1;
+			}
+
 			errno = 0;
 			minthreads = strtoul(optarg, NULL, 0);
 			if (minthreads == ULONG_MAX && errno != 0) {
@@ -1757,7 +1842,17 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 
 	lease = conf_get_num("nfsd", "lease-time", 0);
 	scope = conf_get_str("nfsd", "scope");
-	minthreads = conf_get_num("nfsd", "min-threads", 0);
+
+#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
+	minthreads = conf_get_num("nfsd", "min-threads", -1);
+
+	if (minthreads >= 0 && nfsd_threads_max_nlattr < NFSD_A_SERVER_MIN_THREADS) {
+		xlog(L_WARNING, "kernel does not support dynamic threading. min-threads setting ignored.");
+		minthreads = -1;
+	}
+#else
+	minthreads = -1;
+#endif
 
 	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
 			   threads, scope, minthreads);
@@ -1950,6 +2045,9 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+	if (query_nfsd_nl_policy(sock))
+		return 1;
+
 	if (optind > argc) {
 		usage();
 		return 1;

-- 
2.52.0


