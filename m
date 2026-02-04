Return-Path: <linux-nfs+bounces-18716-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGYfKvJ4g2nyngMAu9opvQ
	(envelope-from <linux-nfs+bounces-18716-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:50:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AC1EA8EE
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E22013013FD9
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAC833BBD9;
	Wed,  4 Feb 2026 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5Y00AqQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C427B327
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223729; cv=none; b=VL1bLpPgXyayRH3/SHgIAZCUmHsxhLZCPADX+cURD/gtgDYysC57DCz5BvQFOyVJEJZF5KHcIQJCpfsdUdAhPCYy9evrPE1pCJw/i8jQIV6wBMbqMOUvx2yHJqAgmauQuVzGRDrMKRbyKkHdw14q1a8LCCrFTfK8fFo69//o0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223729; c=relaxed/simple;
	bh=rmXxO4FkWl+No9pwIE14K7Rao9XIGDztrYneyjSFgaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RIz8TZ4MPVdftM3Cvv+K1jFB6ZYdezXiYaXpEMmqhpz05K+AXbDcDAKP4lrv2p1jKQ6aV2mm6d6WMeRDiRvLqhZTQTPHtIG5sfxsyCK4PUOZu5AKJ6EQmBv8bqUzzlKFkI1pMGAzHoPsRGgke/gLodTuoyGzA7yuyQi0fEdUuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5Y00AqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218CCC19423;
	Wed,  4 Feb 2026 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770223729;
	bh=rmXxO4FkWl+No9pwIE14K7Rao9XIGDztrYneyjSFgaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J5Y00AqQz8QFQhyhUbhFfGjsCWXNxm2W5z71uHnXlJNZipb5HIde7AitQWjbv3QY0
	 zBDw2J5APTrp12a49MYroK4zev8kIdkiGtCKFh3rSG5XoltsSJeRN7L2H4n16pYBDx
	 X1UFCh+Mra3DFPLLe48iRTLrsQOwqjrZfMGYBZOYNMhGg9I3DJzqpHvf0/EZrw6at7
	 z8+eWW4zv29+fEwYDHPuHfwzvLiQ3XqqZbpdwtKSZKZYfwSJOC8UUMRgAcx0FYw7/1
	 fGSgBBm9cP+S7IXi/5WSTYKzq4OjsDmzbQIZhMs+nt8cXihjw+fES1v/NdVljxgzZS
	 0svLS//ifAxBA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Feb 2026 11:48:24 -0500
Subject: [PATCH nfs-utils v2 3/4] nfsdctl: query netlink policy before
 sending the minthreads attribute to kernel
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-minthreads-v2-3-a7eba34201e9@kernel.org>
References: <20260204-minthreads-v2-0-a7eba34201e9@kernel.org>
In-Reply-To: <20260204-minthreads-v2-0-a7eba34201e9@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Ben Coddington <bcodding@hammerspace.com>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4926; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rmXxO4FkWl+No9pwIE14K7Rao9XIGDztrYneyjSFgaQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpg3humaAU9ogp0higsxyjZeTPoSRq5gzEdJB1W
 2zghXiWA9SJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaYN4bgAKCRAADmhBGVaC
 FYHXD/0SZ6b1dJiJg2ynp/SW55nuPdAeOcpX7YdRiTzjCzeS+8c2ERCIRYz9BBwvJXFZmvzU+Sf
 YLYjrSZAqbZ4Sn1BUWuWbEezi68sVYXWB7eu4dfWOjTfFk1G7MNJWHxnBxHdznIhXKYBFE5K2Ta
 rsah8CUeOeA25n4vAe/bPs43JXSMCqHxClLo3sJzPoPvKjhObb8STgVp1fbzSWPk7DuZmw7hrCA
 iYMe7G3MlnFdXvGIrSTvjvz+6Qz509F1MBPNplFDxVD1I5+iyJM74Nsfa6KTsrzlLGMF/D0z2PO
 e07PVpxi1em3wlT4hdrqNEPk7XjaXST9YEzM1LTl+JmyKG2pOBrcJ47Wm3DwpD/JFh6akf1ly2b
 RQWD2dRT94le+xN4FVRgPIUgTKzmgdKyjAE2ILWCiBEK6YGirSBGzg3TryDC1y3IUyDY+ohgX5Y
 C9VfAIVdigMGJs4nP/+bICzC/Zq7pK4aCb1xNGtEpc25O7Dd7mJpEeavgyc8jd2k50Kk3Zuf6C/
 x2Se0xYt3S3zq5uLNyd/piJFLa+xclt6XTBt1P0ov4nFlhyM/imGFKQkAoAPCnbE3OkYNS1yiOJ
 JyetIOM+7B07g0WwsXAKyNuhjCLxW2sOUEWCI+0Y4ke8hZTQjognSSJSfH1bQuThFGp2EZ5KMlM
 o+ZvGBb5DyDjgJQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18716-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: D6AC1EA8EE
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
 utils/nfsdctl/nfsdctl.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 86a4a944d4e131f1114ca358d81779de0a034872..4a3744a1c22e6beac7c039bded05fc087a121200 100644
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
@@ -480,6 +483,83 @@ static int nfsd_nl_family_setup(struct nl_sock *sock)
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
+	return NL_SKIP;
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
@@ -639,6 +719,11 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 			threads_usage();
 			return 0;
 		case 'm':
+			if (nfsd_threads_max_nlattr < NFSD_A_SERVER_MIN_THREADS) {
+				xlog(L_ERROR, "This kernel does not support dynamic threading.");
+				return 1;
+			}
+
 			errno = 0;
 			minthreads = strtoul(optarg, NULL, 0);
 			if (minthreads == ULONG_MAX && errno != 0) {
@@ -1743,7 +1828,12 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 
 	lease = conf_get_num("nfsd", "lease-time", 0);
 	scope = conf_get_str("nfsd", "scope");
-	minthreads = conf_get_num("nfsd", "min-threads", 0);
+	minthreads = conf_get_num("nfsd", "min-threads", -1);
+
+	if (minthreads >= 0 && nfsd_threads_max_nlattr < NFSD_A_SERVER_MIN_THREADS) {
+		xlog(L_WARNING, "This kernel does not support dynamic threading. min-threads setting ignored.");
+		minthreads = -1;
+	}
 
 	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
 			   threads, scope, minthreads);
@@ -1936,6 +2026,9 @@ int main(int argc, char **argv)
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


