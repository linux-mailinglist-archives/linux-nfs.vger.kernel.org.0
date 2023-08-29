Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A4278CD78
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Aug 2023 22:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbjH2UTd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 16:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbjH2UTL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 16:19:11 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BED2E9
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 13:19:08 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-760dff4b701so50424439f.0
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 13:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693340348; x=1693945148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIrUaub9xbgh9JA6eu/SKHUdTohV+B8D2DY3q1ptAy8=;
        b=ePjpATKgFRLPjxXn6t5aQaga2YBB1ohkzE6HThacLE7dE7t+9jQTKq8mUS4lmfhOhU
         MmDHlTe7ZT/MCeBXL6+DIpVnELlVRqQ5R48FKMmLvDwIE7kLaJso/f5gOal2RooyGloZ
         VQggzmK2uqcy/QbyxwOVgO5Mt4FVp9pFmnpRQnL4l86LHKX/gHFNMTpZaa3qUTtBQhbk
         aaWLxwXwLZSCtxmElRXW1tJheQ+MrK+VtiwUze4lKJFqqvE8m0QiLwb7y8ZxMu0bVdul
         9xfKycHMaRqsX8Iz1CRVLE22hRVP71PqsHOvpD2Fk7NyJ6F1iOpZZZSNCWA1asuI3FxI
         WgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693340348; x=1693945148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIrUaub9xbgh9JA6eu/SKHUdTohV+B8D2DY3q1ptAy8=;
        b=UeEEiDZdthsFGTDb/RwHcB8WgqAZOtxZFlovaNYBzzrEiKnwiUT99ePvbGZ0JV0gpF
         CqUC2WSwTecac8+iv3ooLJIQ90RoB5hKtJ7vQHkzKbQC6bvazTgy/W+DPJvfu52dJgOG
         n459vDoDpW5xxlvH+HuzJxYv6kNNb1QYKg9wv2WG8jdW1KFV4Q51YhqsWzYQA1JcX3NR
         vGxHIq5ELAoQVGjJ8ZUVxsZK7f6vdXgfBsj4dUKlZF988RVSRjKmI5btTklDYLryvotW
         ShYNUp4PS22iUMRIIrHO8xwNzjYrU4PdnZPwDTVNwi/h0tIKGOSdv/1P56MvpOxKcB0c
         DVxg==
X-Gm-Message-State: AOJu0Yy3ir2vObMudkgAcxj64lPBD7Q/YT1TzXOsI2+GfnrxqVjWMZsn
        9P+Qag3CNJNd2Jiqf8GIkpAv0KSFcTo=
X-Google-Smtp-Source: AGHT+IHje/3kX4JjtJB4NU2NUB4goNYxkR3hI3JqM25lUXHdCBzaKwyoVVOYPms0g3AYA4CpDhR86w==
X-Received: by 2002:a05:6602:3789:b0:794:da1e:b249 with SMTP id be9-20020a056602378900b00794da1eb249mr412307iob.1.1693340348021;
        Tue, 29 Aug 2023 13:19:08 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b9e5:28ab:6ad7:257e])
        by smtp.gmail.com with ESMTPSA id gk8-20020a0566386a8800b0042b2f0b77aasm3300798jab.95.2023.08.29.13.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:19:07 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] nfs-utils: gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials
Date:   Tue, 29 Aug 2023 16:19:01 -0400
Message-Id: <20230829201902.63036-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20230829201902.63036-1-olga.kornievskaia@gmail.com>
References: <20230829201902.63036-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

During context establishment, when the client received
KRB5_AP_ERR_BAD_INTEGRITY error, it might be due to the server
updating its key material. To handle such error, get a new
service ticket and re-try the AP_REQ.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 utils/gssd/gssd_proc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index 4fb6b72d..e5cc1d98 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -412,13 +412,27 @@ create_auth_rpc_client(struct clnt_info *clp,
 		tid, tgtname);
 	auth = authgss_create_default(rpc_clnt, tgtname, &sec);
 	if (!auth) {
+		if (sec.minor_status == KRB5KRB_AP_ERR_BAD_INTEGRITY) {
+			printerr(2, "WARNING: server=%s failed context "
+				 "creation with KRB5_AP_ERR_BAD_INTEGRITY\n",
+				 clp->servername);
+			if (cred == GSS_C_NO_CREDENTIAL)
+				retval = gssd_refresh_krb5_machine_credential(clp->servername,
+					"*", NULL, 1);
+			if (!retval) {
+				auth = authgss_create_default(rpc_clnt, tgtname,
+						&sec);
+				if (auth)
+					goto success;
+			}
+		}
 		/* Our caller should print appropriate message */
 		printerr(2, "WARNING: Failed to create krb5 context for "
 			    "user with uid %d for server %s\n",
 			 uid, tgtname);
 		goto out_fail;
 	}
-
+success:
 	/* Success !!! */
 	rpc_clnt->cl_auth = auth;
 	*clnt_return = rpc_clnt;
-- 
2.39.1

