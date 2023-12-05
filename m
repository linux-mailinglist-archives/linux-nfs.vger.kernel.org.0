Return-Path: <linux-nfs+bounces-340-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8532A805E9E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 20:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA08281F27
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 19:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4746D1DE;
	Tue,  5 Dec 2023 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7sY13Z1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B4FAB
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 11:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701804567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2eq2DMq1WO4X/Xd7+NI5PjO+TbnA8mrc7ic+TXsok6c=;
	b=X7sY13Z1jJD6HvD4JTMxYSBPQwL24pCw44IMOKkpXTfk5xJQJNIWAa3CpWDuLE+rytuYv0
	eLKuAFn2xGS7PO9qcWPHuIOzqHuJdC17RIbJyM6T+ZkZSX1vXqcZQC8wkaAm5xHPBjL2uz
	LMyuiBhwV6RW8IDE8mF6JDF9/3mnRx0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-HF3KbUiRNSOz1lJTjwlbPg-1; Tue, 05 Dec 2023 14:29:25 -0500
X-MC-Unique: HF3KbUiRNSOz1lJTjwlbPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A63E2890FC2
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 19:29:25 +0000 (UTC)
Received: from bighat.boston.devel.redhat.com (bighat.boston.devel.redhat.com [10.19.60.48])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9375F2166B35
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 19:29:25 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] conf_init_file: Fixed warn_unused_result error
Date: Tue,  5 Dec 2023 14:29:24 -0500
Message-ID: <20231205192924.99320-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

conffile.c: In function 'conf_init_file':
conffile.c:776:17: error: ignoring return value of 'asprintf' declared with attribute 'warn_unused_result' [-Werror=unused-result]
  776 |                 asprintf(&usrconf, "/usr%s", conf_file);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfs/conffile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index 884eca9..1e9c22b 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -754,6 +754,7 @@ void
 conf_init_file(const char *conf_file)
 {
 	unsigned int i;
+	int j;
 
 	for (i = 0; i < sizeof conf_bindings / sizeof conf_bindings[0]; i++)
 		LIST_INIT (&conf_bindings[i]);
@@ -773,8 +774,8 @@ conf_init_file(const char *conf_file)
 	if (strncmp(conf_file, "/etc/", 5) == 0) {
 		char *usrconf = NULL;
 
-		asprintf(&usrconf, "/usr%s", conf_file);
-		if (usrconf) {
+		j = asprintf(&usrconf, "/usr%s", conf_file);
+		if (usrconf && j > 0) {
 			conf_load_file(usrconf);
 			conf_init_dir(usrconf);
 			free(usrconf);
-- 
2.41.0


