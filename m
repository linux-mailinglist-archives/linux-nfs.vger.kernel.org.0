Return-Path: <linux-nfs+bounces-9188-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F281A0C562
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 00:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FAC16011F
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 23:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CCE1F9F6A;
	Mon, 13 Jan 2025 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIKzk9UY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7E1F9ECE
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810008; cv=none; b=UlTaEFVB4lEXjSfZ97Lw5cYZOxMGU4LAT75usXDyUDb3gV9f6K8KRFrz5GP4weEPUEY91Rj4cFlf8+slO+n5qh5XSyRwQ8bxtdH94gEoagvJ7I9koij2DWDbSUFrq3tYRYmXIPW+PvKCOjYZEl5n/6auk/HxxEOGDWXx+5VUgak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810008; c=relaxed/simple;
	bh=nEqeSqXcwXULdwjNsru0XHWuK09sT9zO1oRd8riTGH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RP4dwKDJO2LeNRuIOTHfe+kAxJZVCnPh3MK+2Wp+kuI5ZduPqx/O/ldAm/YOq4Z6Kq2Hmq4lAScT3A7/foQQBdFI6i6o2Mba4PEV4yYxdWSbgdOcpFbMCgL1cHEatojYJX7DAfaAJeadTvfcj7YZtNt7n42RJy8Tq3EXXo7Asoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LIKzk9UY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736810005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUyWMIMIxmSIACL9HKmHg5znT0xyGnVWjVAOAfPZcQE=;
	b=LIKzk9UY/55g+aaDnOlFnmrMe93mnUZl2vn1iB+SjttbDJxdhjUNjcGucDJfxUKnuCzfuf
	FbtreGbx72ru7ZhKNsPEqW5lzttxEcwT2M8m8HvDk4qYcebTqJ0fpTJcQolKDN+HpAUmwv
	9ECpUvF7VNrRsB8SngO4XkdacfW1kQ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-mfUSi9BmMLurEfeojLazhQ-1; Mon,
 13 Jan 2025 18:13:22 -0500
X-MC-Unique: mfUSi9BmMLurEfeojLazhQ-1
X-Mimecast-MFC-AGG-ID: mfUSi9BmMLurEfeojLazhQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 700801956053;
	Mon, 13 Jan 2025 23:13:21 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.152])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43E7319560A3;
	Mon, 13 Jan 2025 23:13:21 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id C95E92EA88E;
	Mon, 13 Jan 2025 18:13:19 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: jlayton@kernel.org,
	yoyang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v3 2/3] nfsdctl: tweak the nfs.conf version handling
Date: Mon, 13 Jan 2025 18:13:18 -0500
Message-ID: <20250113231319.951885-3-smayhew@redhat.com>
In-Reply-To: <20250113231319.951885-1-smayhew@redhat.com>
References: <20250113231319.951885-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

I noticed I was getting different results when comparing nfsdctl's
config file handling versus rpc.nfsd's.

First, the vers4 config option was being treated as a mask, e.g. if
vers4=n and vers4.2=y then end result was still that all minorversions
were disabled.  Change it so that vers4=n would initially toggle off all
minorversions, but individual v4.x=y would turn that minorversion back
on.

Second, don't make assumptions about what default should be passed to
conf_get_bool.  Instead, test both possible values and only update the
nfsd_versions array if an option was explicitly specified.

Finally, add a check so that 'nfsdctl autostart' will error out if no
versions or minorversions are enabled.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 50 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 88b728e0..78200624 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1457,15 +1457,47 @@ read_nfsd_conf(void)
 	xlog_set_debug("nfsd");
 }
 
-static void configure_versions(void)
+static int configure_versions(void)
 {
-	bool v4 = conf_get_bool("nfsd", "vers4", true);
+	int i, j, max_minor = get_max_minorversion();
+	bool found_one = false;
+	char tag[20];
+
+	for (i = 2; i <= 4; ++i) {
+		sprintf(tag, "vers%d", i);
+		if (!conf_get_bool("nfsd", tag, true)) {
+			update_nfsd_version(i, 0, false);
+			if (i == 4)
+				for (j = 0; j <= max_minor; ++j)
+					update_nfsd_version(4, j, false);
+		}
+		if (conf_get_bool("nfsd", tag, false)) {
+			update_nfsd_version(i, 0, true);
+			if (i == 4)
+				for (j = 0; j <= max_minor; ++j)
+					update_nfsd_version(4, j, true);
+		}
+	}
 
-	update_nfsd_version(2, 0, conf_get_bool("nfsd", "vers2", false));
-	update_nfsd_version(3, 0, conf_get_bool("nfsd", "vers3", true));
-	update_nfsd_version(4, 0, v4 && conf_get_bool("nfsd", "vers4.0", true));
-	update_nfsd_version(4, 1, v4 && conf_get_bool("nfsd", "vers4.1", true));
-	update_nfsd_version(4, 2, v4 && conf_get_bool("nfsd", "vers4.2", true));
+	for (i = 0; i <= max_minor; ++i) {
+		sprintf(tag, "vers4.%d", i);
+		if (!conf_get_bool("nfsd", tag, true))
+			update_nfsd_version(4, i, false);
+		if (conf_get_bool("nfsd", tag, false))
+			update_nfsd_version(4, i, true);
+	}
+
+	for (i = 0; i < MAX_NFS_VERSIONS; ++i) {
+		if (nfsd_versions[i].enabled) {
+			found_one = true;
+			break;
+		}
+	}
+	if (!found_one) {
+		xlog(L_ERROR, "no version specified");
+		return 1;
+	}
+	return 0;
 }
 
 static void configure_listeners(void)
@@ -1556,7 +1588,9 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	ret = fetch_nfsd_versions(sock);
 	if (ret)
 		return ret;
-	configure_versions();
+	ret = configure_versions();
+	if (ret)
+		return ret;
 	ret = set_nfsd_versions(sock);
 	if (ret)
 		return ret;
-- 
2.45.2


