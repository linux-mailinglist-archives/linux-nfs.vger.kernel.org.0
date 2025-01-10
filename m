Return-Path: <linux-nfs+bounces-9116-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7AEA09C4E
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 21:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D149188EDA6
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 20:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA502236E4;
	Fri, 10 Jan 2025 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFbJvieW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3B22332E
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540274; cv=none; b=d6Rji10LvKojN0lKF/G99SBz44+63lmp9slFxFxURxKIy6qY/rHkgQTBwTf0tuItpfj9uf8qZcWnarQcz8teZ4Yn0Wu8hmGF1taWEQQZ2zZJfo0UxkImnHFTnCeNeag2KH+aJL7vQX6c1Mvx74bJqzLSfdEBZMT+i9hxaZQgges=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540274; c=relaxed/simple;
	bh=wnYD0G7QP4i4+qSvTuKV9PF3RL5pnK4EFuXoe4jLEVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLtNj34s7xph74ZgpUPM/pMAvlwZVpuPp3GRqn6l2S44+Hu8q2asfKVhwCRWqbWqMqQ99hzR93x2lvlhIgl6hU10CpuVx7E+QlEcWL/3h3vlKZZPXvSOAaOpHzXgF06hYoKUpdHSyiy7+Be079hG7kkBJ1cacKMEicAw1962j8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFbJvieW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736540271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQnUCckzSmR7Ppf2Fzmd86K8p9quW7bHkYQwmz4n2h0=;
	b=SFbJvieWVTLJEUeUXHQXj+mIbZ8uDm3rBmbDbNWE1u9S0gWmVEHwvdfLPRk+EHI8FftEJI
	i9T7y5jVYz/i3lwiHxzzGDTrC3tlVAs0JrL9+veoYK8R43MlcBfCtpIWBdWVACfaRSboFj
	7JHnvEfh9pxwykx+shxJRgxB5iCtuno=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-oFZMWLwGOyKeFQYlkE7UOA-1; Fri,
 10 Jan 2025 15:17:49 -0500
X-MC-Unique: oFZMWLwGOyKeFQYlkE7UOA-1
X-Mimecast-MFC-AGG-ID: oFZMWLwGOyKeFQYlkE7UOA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3B561955DDD;
	Fri, 10 Jan 2025 20:17:48 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.211])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9711A19560AB;
	Fri, 10 Jan 2025 20:17:48 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 2774D2EA23A;
	Fri, 10 Jan 2025 15:17:47 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: jlayton@kernel.org,
	yoyang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v2 2/2] nfsdctl: tweak the nfs.conf version handling
Date: Fri, 10 Jan 2025 15:17:46 -0500
Message-ID: <20250110201746.869995-3-smayhew@redhat.com>
In-Reply-To: <20250110201746.869995-1-smayhew@redhat.com>
References: <20250110201746.869995-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 38c22225..49de55ab 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1305,13 +1305,34 @@ read_nfsd_conf(void)
 
 static void configure_versions(void)
 {
-	bool v4 = conf_get_bool("nfsd", "vers4", true);
+	int i, j, max_minor;
+	char tag[20];
+
+	max_minor = get_max_minorversion();
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
 }
 
 static void configure_listeners(void)
-- 
2.45.2


