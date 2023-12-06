Return-Path: <linux-nfs+bounces-374-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E51807A84
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 22:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09E51C20C10
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 21:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E1B70966;
	Wed,  6 Dec 2023 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSg3uRtv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590CCD5C
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 13:33:39 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77f3c8fb126so1124985a.0
        for <linux-nfs@vger.kernel.org>; Wed, 06 Dec 2023 13:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701898418; x=1702503218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDBBkNVLVNjZb1IaiGSr+kR7X/bG36A548ZQUO4n/6I=;
        b=YSg3uRtvVfNPzO0zouUCOUchYWtIjY5CIk+FwHkLUoM4Tt3Hm4aTyUmQHFUXjvgTi/
         B9efrB+JaOQkL1yH5rP619ABih/+xmrcF4DR53PPFoBzJWtapVxkeN+/GRH30djyDNxe
         dCuMjIYVYPsaIiA4geAHf+RBTnumswjZ80ZlCzbwS+SdcgvPVExKtM6LUtWYngwVQg6g
         7D88iNRi8xh70Fou5ixaQYoOWE+6HF4mzzZuk0QZY6KwKvRlZhWhaQFLUDi5ZO131wgZ
         AzOt6RsxGCPKsyvvbdf5PvFD0n6AiVyJF2YL/TaCbclUILD1knptj4ApQ3Eq2pt1zgNR
         o1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898418; x=1702503218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDBBkNVLVNjZb1IaiGSr+kR7X/bG36A548ZQUO4n/6I=;
        b=SnaXFd653+4R8z2Pyd8fOISmJ0E/GHibOOaaLMTCt9j3q0occ4Xmj9mtylGxbJYO3k
         NY9cuuz7ljkbrm1yGUJlrl5Hc0I8DxyUvsHYMP7HHrKK5//j9GZqNIk4kqZ8QNhjuNTJ
         MUVQn7lYaL0WEATy1gYUulnl2KYs2Lnzf4v3rwHFEhy32wbvV1GL22bPol5FBnV4eeKm
         6Gkxjy9lZhxseGbM4Abwzjn7AYY5LGRkxc2Uxphpw8twWKYdJ/DhfgnaqPuLcQaB1T4b
         3IoTa09JQVlWsVYoWMpGMG4Ui6e9u/lJ48GoFIknu1qttldjziCpL2GdtoxJ6hhOCGip
         3hQQ==
X-Gm-Message-State: AOJu0YzEkmY5b9cnCodJtkiRzoGqGOoIGWKJj4F0NSgqODDPpnoJoc5R
	wiCrcBA0DE1pmYk+1FbV2tWGF5r0kfc=
X-Google-Smtp-Source: AGHT+IHLF751oFdPFWQGkXFFtFYcWG02ueD2A3KSdn0QSTWqBAl/2Ia8V2DQeXDSRjA7gWtyy2ugxQ==
X-Received: by 2002:a05:620a:468a:b0:77d:c4eb:3d99 with SMTP id bq10-20020a05620a468a00b0077dc4eb3d99mr3261212qkb.0.1701898418410;
        Wed, 06 Dec 2023 13:33:38 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b4ac:108b:be40:79b])
        by smtp.gmail.com with ESMTPSA id ro3-20020a05620a398300b0077da601f06csm256435qkn.10.2023.12.06.13.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:33:37 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	chuck.lever@oracle.com
Subject: [PATCH 3/6] gssd: switch to using rpc_gss_seccreate()
Date: Wed,  6 Dec 2023 16:33:29 -0500
Message-Id: <20231206213332.55565-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

If available from the libtirpc library, switch to using
rpc_gss_seccreate() instead of authgss_create_default() which does not
expose gss error codes.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 utils/gssd/gssd_proc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index 4fb6b72d..99761157 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -70,6 +70,9 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <syscall.h>
+#ifdef HAVE_TIRPC_GSS_SECCREATE
+#include <rpc/rpcsec_gss.h>
+#endif
 
 #include "gssd.h"
 #include "err_util.h"
@@ -330,6 +333,11 @@ create_auth_rpc_client(struct clnt_info *clp,
 	struct timeval	timeout;
 	struct sockaddr		*addr = (struct sockaddr *) &clp->addr;
 	socklen_t		salen;
+#ifdef HAVE_TIRPC_GSS_SECCREATE
+	rpc_gss_options_req_t	req;
+	rpc_gss_options_ret_t	ret;
+	char			mechanism[] = "kerberos_v5";
+#endif
 	pthread_t tid = pthread_self();
 
 	sec.qop = GSS_C_QOP_DEFAULT;
@@ -410,7 +418,14 @@ create_auth_rpc_client(struct clnt_info *clp,
 
 	printerr(3, "create_auth_rpc_client(0x%lx): creating context with server %s\n", 
 		tid, tgtname);
+#ifdef HAVE_TIRPC_GSS_SECCREATE
+	memset(&req, 0, sizeof(req));
+	req.my_cred = sec.cred;
+	auth = rpc_gss_seccreate(rpc_clnt, tgtname, mechanism,
+			rpcsec_gss_svc_none, NULL, &req, &ret);
+#else
 	auth = authgss_create_default(rpc_clnt, tgtname, &sec);
+#endif
 	if (!auth) {
 		/* Our caller should print appropriate message */
 		printerr(2, "WARNING: Failed to create krb5 context for "
-- 
2.39.1


