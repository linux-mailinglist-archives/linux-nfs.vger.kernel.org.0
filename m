Return-Path: <linux-nfs+bounces-11380-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 107A8AA5E27
	for <lists+linux-nfs@lfdr.de>; Thu,  1 May 2025 14:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B1E1BA3CA1
	for <lists+linux-nfs@lfdr.de>; Thu,  1 May 2025 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C284315E;
	Thu,  1 May 2025 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTK5sFDJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6FD2B9B7
	for <linux-nfs@vger.kernel.org>; Thu,  1 May 2025 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746101752; cv=none; b=TAMYe1kl0OWoF8KjhQFGG9kQnuwn3bVQP/TlNHXerACx5imbnSLNGuhowlc0kA6bYET3OiZCk2B7ciCgIVm0bvkI5h4Z0WbizAKmo8F1NeDheMdv5brbHA/25/M1iQXgOzln7cdD4o99Md7vU/NoLlblgXViVan5o6T8TfHO9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746101752; c=relaxed/simple;
	bh=5veFqfmstKSb9o5s3TFe8aSWk6xrIs4Qv1JXDP/ooE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruGpz6sXrWB2KaxlDR8XU3aoVjAWQzUf017+f/UwbESw1tPiFC8J3VscZzoM4w1OXmBvqWWPDCO8/Y/Tpv3TsPZF0w7/PNM4A0b1iUfkIVPuwBTDkw++xSqzi2S46oODbxEO+wLc1jpLtUkcQEadVajBIoa9eQVL0dpK3ux3gVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTK5sFDJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746101748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WN1F83Zxao9ML2QbrCiNjdJIUh/be6HN3BM0ACz4Xak=;
	b=ZTK5sFDJM8dHY0rgYsTgQQ1fRjiWizmOzvR2j7IaFIcCimcTIkTcX9YCZZK2dw51/yU6j+
	4I2Qn0Fouzv+99TPl51321vNLNJGBcbnHT1/yH8KyjxmCcHbd6N6mFtF4DFqjXR1ctVwn0
	vInBHP5fpESJwlS3rFg1HqxO+r1tFZY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-r9GhrygMPdWAMACbhEFHVQ-1; Thu,
 01 May 2025 08:15:47 -0400
X-MC-Unique: r9GhrygMPdWAMACbhEFHVQ-1
X-Mimecast-MFC-AGG-ID: r9GhrygMPdWAMACbhEFHVQ_1746101746
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5156719560A6;
	Thu,  1 May 2025 12:15:46 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.153])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21F4E1956094;
	Thu,  1 May 2025 12:15:46 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id E8C46345301;
	Thu, 01 May 2025 08:15:43 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v2] nfsdctl: debug logging fixups
Date: Thu,  1 May 2025 08:15:43 -0400
Message-ID: <20250501121543.4181345-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move read_nfsd_conf() out of autostart_func() and into main() so we
don't lose any messages.  Remove hard-coded NFSD_FAMILY_NAME in the
first error message in netlink_msg_alloc() so the error message has the
correct family and make both error messages in netlink_msg_alloc()
more descriptive/unique.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
SteveD - the original patch was supposed to go on top of Jeff's
"nfsdctl: add support for new lockd configuration interface" patches,
but seems to have gotten lost in the shuffle.  The v2 patch is the same, 
I've just reworded the commit message a bit.

 utils/nfsdctl/nfsdctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 733756a9..1fdbb44d 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -436,7 +436,7 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family
 
 	id = genl_ctrl_resolve(sock, family);
 	if (id < 0) {
-		xlog(L_ERROR, "%s not found", NFSD_FAMILY_NAME);
+		xlog(L_ERROR, "failed to resolve %s generic netlink family", family);
 		return NULL;
 	}
 
@@ -447,7 +447,7 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family
 	}
 
 	if (!genlmsg_put(msg, 0, 0, id, 0, 0, 0, 0)) {
-		xlog(L_ERROR, "failed to allocate netlink message");
+		xlog(L_ERROR, "failed to add generic netlink headers to netlink message");
 		nlmsg_free(msg);
 		return NULL;
 	}
@@ -1592,8 +1592,6 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 		}
 	}
 
-	read_nfsd_conf();
-
 	grace = conf_get_num("nfsd", "grace-time", 0);
 	ret = lockd_configure(sock, grace);
 	if (ret) {
@@ -1824,6 +1822,8 @@ int main(int argc, char **argv)
 	xlog_syslog(0);
 	xlog_stderr(1);
 
+	read_nfsd_conf();
+
 	/* Parse the preliminary options */
 	while ((opt = getopt_long(argc, argv, "+hdsV", pre_options, NULL)) != -1) {
 		switch (opt) {
-- 
2.48.1


