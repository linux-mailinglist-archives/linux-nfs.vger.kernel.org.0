Return-Path: <linux-nfs+bounces-20338-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K4OCJukwWknUQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20338-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 21:37:47 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0182FD5A9
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 21:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82420300E6AF
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 20:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB63E0C5F;
	Mon, 23 Mar 2026 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDPAGtet"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE393E121C
	for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774298236; cv=none; b=La1d7kOgNHg0vQoS0wTaogr65upEN1QFdRXSAekRJN2OL7GyOwnnegWgyFvZntCDNuRDvfnzlhpY61v2Q6EkGZMVKiSsxdddv9O90R/j+RjSqMhJKtKhhw9Jv+rtH/44olKFpk+kJ7knUUhBR7xdVXvi1xPdp0xwaBexD7JrlsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774298236; c=relaxed/simple;
	bh=S91miKWk95aYJmvKZTwjAtqM3EoOw9IRJnXmQtV0DWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OXEnSK+IfGuJD4d/nBtOUUEXsdwq6OIVsPPm8WpUqFMqVeUZuDK92+iCYYvWIZRrykFMEV5Hnp3NSE1X4oWumrPXK2aIVFv/WtTLBNfSRhtCiAFKRN3BkdnTiCHt7h/uY2G9dyTpkrX01Q51AiC2q4i+yhXQ1kk0FY4k1PE5td0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDPAGtet; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774298234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1uNQGjBx4IeJNslF34FAR3MMmyiROPiaXS1Y36SU7EU=;
	b=eDPAGtetBc0f2sFifFT1l/Zpl6/V2sQ0KRpupAieTsW+mVmiYnvtHRA8XZMxEnSTmsEfdC
	nNOd0wtxp2IaulxZusNrlzP6zmZxB1fRcf2hXcu29SRUa1aesHcbx0/U0Ic0MPUJspkljU
	aKGy1RQq2+efVWkKY0Psp5S2Jv2uS8E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-z7eC9ynVOK2RUsh1MCW1Zw-1; Mon,
 23 Mar 2026 16:37:12 -0400
X-MC-Unique: z7eC9ynVOK2RUsh1MCW1Zw-1
X-Mimecast-MFC-AGG-ID: z7eC9ynVOK2RUsh1MCW1Zw_1774298231
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE507195609F
	for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 20:37:11 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.38])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 386E8180058B;
	Mon, 23 Mar 2026 20:37:11 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] nfsdctl: check for listeners before starting threads
Date: Mon, 23 Mar 2026 16:37:10 -0400
Message-ID: <20260323203710.83237-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20338-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D0182FD5A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a thread command is executed and yet no listeners have been
added prior to it, instead of failing with EIO error print an
informative error. Also, "thread 0" command should not error
regardless of the listener status.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 6a20d180..ac23e753 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -162,6 +162,8 @@ static const char *nfsd4_ops[] = {
 	[OP_REMOVEXATTR]	= "OP_REMOVEXATTR",
 };
 
+static int fetch_current_listeners(struct nl_sock *sock);
+
 static int error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
 			 void *arg)
 {
@@ -721,6 +723,7 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 	int *pool_threads = NULL;
 	int minthreads = -1;
 	int opt, pools = 0;
+	bool zero_threads = false;
 
 	optind = 1;
 	while ((opt = getopt_long(argc, argv, "hm:", threads_options, NULL)) != -1) {
@@ -762,12 +765,31 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 			}
 
 			pool_threads[i] = strtol(targv[i], &endptr, 0);
+			if (!pool_threads[i])
+				zero_threads = true;
 			if (!endptr || *endptr != '\0') {
 				xlog(L_ERROR, "Invalid threads value %s.", argv[1]);
 				return 1;
 			}
 		}
 	}
+	/* check if there are active listeners added */
+	if (fetch_current_listeners(sock)) {
+		xlog(L_ERROR, "Unable to determine if listeners were added");
+		return 1;
+	}
+	if (!nfsd_socket_count) {
+		if (zero_threads) {
+			/* Note: we can never have a server with threads and no
+			 * listener. If we ever add functionality to remove
+			 * listeners on an active server, we need to revisit this.
+			 */
+			return 0;
+		}
+		xlog(L_ERROR, "No active listeners added, not starting threads");
+		return 1;
+	}
+
 	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL, minthreads);
 }
 
-- 
2.52.0


