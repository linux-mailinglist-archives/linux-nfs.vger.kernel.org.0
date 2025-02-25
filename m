Return-Path: <linux-nfs+bounces-10347-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC9EA44F23
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 22:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529504202E2
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 21:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4488420D506;
	Tue, 25 Feb 2025 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMGxfJPH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF383209
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519980; cv=none; b=a/y+DvcATOGyQGNlMlGgnE0wrqdfXgnpV9DQwpXiqSnA0soFiSRLRTO/XiSBZRiwOL9H1xNkbWfwSsWCu3r2v74XLDRLcr9B52R+ZX9uXUYqbVFCKUdKafU7yU1vFkGLvXbr4cYHJatyEKjrKIZbtOXZDTvc3pAKyAOBbRZ2xvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519980; c=relaxed/simple;
	bh=jjmJUedpe79OSqh9KVDnjthxbmNl9CGaunxmEKAIlw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbgYlJ+5xWZytv7O2l3e03+1CRnU5cTUjJeA7cYubV54A/m2WiyG9pL1vd4k6kMbrGrOhHdLQO36iQ9DvTlV0U3RkIx/fwQisEzDziaAfnz98XXQpd7PEgFL22Z7y0mHSxmcV3t5LKDKmTuhigsob2iFENBw4+z5RSYiyjdrft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMGxfJPH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740519976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFH8DhbpWHleEt+6Uu4bY4tFQ54LZ45dlCnksQcmETc=;
	b=UMGxfJPH7VaiXpZzXgVOlKzEP7nlMQX4pm9OXJjmxOCdoN+sD64VQEAWsn+mvkdGHPhuDD
	JvlUBisovvNnx6M4/na0eu/WQ0oHp1Tflnw+u/qBMqWFO264MNZquuqJU7p47EYTRlQAvI
	n3wkzl9DjCh3RpewZEtCWLzTz/9B0lM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-m4TvyeZwPDyUv3w4Q_w3sQ-1; Tue,
 25 Feb 2025 16:46:14 -0500
X-MC-Unique: m4TvyeZwPDyUv3w4Q_w3sQ-1
X-Mimecast-MFC-AGG-ID: m4TvyeZwPDyUv3w4Q_w3sQ_1740519973
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 463D61800874
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 21:46:13 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57B181800357;
	Tue, 25 Feb 2025 21:46:12 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/2] nfs-utils: gssd: unconditionally use krb5_get_init_creds_opt_alloc
Date: Tue, 25 Feb 2025 16:46:06 -0500
Message-Id: <20250225214607.20449-2-okorniev@redhat.com>
In-Reply-To: <20250225214607.20449-1-okorniev@redhat.com>
References: <20250225214607.20449-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Modern kerberos API uses krb5_get_init_creds_opt_alloc() for managing
its options for credential data structure.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 utils/gssd/krb5_util.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index d7116d93..201585ed 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -397,12 +397,7 @@ gssd_get_single_krb5_cred(krb5_context context,
 			  struct gssd_k5_kt_princ *ple,
 			  int force_renew)
 {
-#ifdef HAVE_KRB5_GET_INIT_CREDS_OPT_SET_ADDRESSLESS
-	krb5_get_init_creds_opt *init_opts = NULL;
-#else
-	krb5_get_init_creds_opt options;
-#endif
-	krb5_get_init_creds_opt *opts;
+	krb5_get_init_creds_opt *opts = NULL;
 	krb5_creds my_creds;
 	krb5_ccache ccache = NULL;
 	char kt_name[BUFSIZ];
@@ -443,33 +438,23 @@ gssd_get_single_krb5_cred(krb5_context context,
 	if ((krb5_unparse_name(context, ple->princ, &pname)))
 		pname = NULL;
 
-#ifdef HAVE_KRB5_GET_INIT_CREDS_OPT_SET_ADDRESSLESS
-	code = krb5_get_init_creds_opt_alloc(context, &init_opts);
+	code = krb5_get_init_creds_opt_alloc(context, &opts);
 	if (code) {
 		k5err = gssd_k5_err_msg(context, code);
 		printerr(0, "ERROR: %s allocating gic options\n", k5err);
 		goto out;
 	}
-	if (krb5_get_init_creds_opt_set_addressless(context, init_opts, 1))
+#ifdef HAVE_KRB5_GET_INIT_CREDS_OPT_SET_ADDRESSLESS
+	if (krb5_get_init_creds_opt_set_addressless(context, opts, 1))
 		printerr(1, "WARNING: Unable to set option for addressless "
 			 "tickets.  May have problems behind a NAT.\n");
-#ifdef TEST_SHORT_LIFETIME
-	/* set a short lifetime (for debugging only!) */
-	printerr(1, "WARNING: Using (debug) short machine cred lifetime!\n");
-	krb5_get_init_creds_opt_set_tkt_life(init_opts, 5*60);
+#else
+	krb5_get_init_creds_opt_set_address_list(opts, NULL);
 #endif
-	opts = init_opts;
-
-#else	/* HAVE_KRB5_GET_INIT_CREDS_OPT_SET_ADDRESSLESS */
-
-	krb5_get_init_creds_opt_init(&options);
-	krb5_get_init_creds_opt_set_address_list(&options, NULL);
 #ifdef TEST_SHORT_LIFETIME
 	/* set a short lifetime (for debugging only!) */
-	printerr(0, "WARNING: Using (debug) short machine cred lifetime!\n");
-	krb5_get_init_creds_opt_set_tkt_life(&options, 5*60);
-#endif
-	opts = &options;
+	printerr(1, "WARNING: Using (debug) short machine cred lifetime!\n");
+	krb5_get_init_creds_opt_set_tkt_life(opts, 5*60);
 #endif
 
 	if ((code = krb5_get_init_creds_keytab(context, &my_creds, ple->princ,
@@ -530,10 +515,8 @@ gssd_get_single_krb5_cred(krb5_context context,
 	printerr(2, "%s(0x%lx): principal '%s' ccache:'%s'\n", 
 		__func__, tid, pname, cc_name);
   out:
-#ifdef HAVE_KRB5_GET_INIT_CREDS_OPT_SET_ADDRESSLESS
-	if (init_opts)
-		krb5_get_init_creds_opt_free(context, init_opts);
-#endif
+	if (opts)
+		krb5_get_init_creds_opt_free(context, opts);
 	if (pname)
 		k5_free_unparsed_name(context, pname);
 	if (ccache)
-- 
2.47.1


