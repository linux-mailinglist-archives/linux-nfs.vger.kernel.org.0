Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF07B86A2
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 19:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243498AbjJDRcx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 13:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243676AbjJDRcx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 13:32:53 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5222AD
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 10:32:47 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a2874d2820so1523139f.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Oct 2023 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696440767; x=1697045567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIrUaub9xbgh9JA6eu/SKHUdTohV+B8D2DY3q1ptAy8=;
        b=TM3hkiE1jNcwqgDj/87Y07KeoUXcW8OsLwFNvsiB3L8tSy/aNvxVvUq+Q2ruQa13X4
         B4T5w29KYlyjAidIIJ0SV+Z1GyAgVtZ32CNNGKf/ao1QSmLUWW4A55JZ+xVKeJ0zwvgW
         gZaiEBUFGIStCigdAiywamjt74NdNJdktkdJkFOxlQ1RUMsSYxJ5Fw2gtwevEKTE+d9f
         CrPElEGwpIxWcSEEEmuZPquem15A9fAW9BHAdfZMd0okuitL4FC8vAFhWwhqML5IRVd3
         uSrINFvmD0HnrQ3BC6+B6BydrYPCws786kglpcyhrHQsNX7apBJ4kO6yv4cHVGAonPeY
         bA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440767; x=1697045567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIrUaub9xbgh9JA6eu/SKHUdTohV+B8D2DY3q1ptAy8=;
        b=CibLNqzUx0oH/Mh2cZrJ4EwRqrHh52DHwmqn5Hx5PUr4Vl0RW53t3A5ynXU7TQmqEK
         7HrEM7Re/1sRLPghOdu45JdyK9iTHc9ZQZi59guOsV0CjIOLkwOJmtp5mO4nDXmoKU0h
         RsD0nyNeAXKrgtLcSq58S2KxOFFsSgKGlSF0SjcpJ7V2aRQfdM1LXlo1oW/v/DgdmzcY
         rt2KWCdzgH8LTiu7v8TZrDLE4RzC8C9YO2/vtwykRaqkJG216xpd7c8w4H1bDMH6ZpfI
         y69JSr3bMpX7goL3bGZRsykcg9x4YHM3aMRjpOheMzXRx5l+83AUGC/Z6YQ291Qn8mgl
         UuGQ==
X-Gm-Message-State: AOJu0Yyd/KAVMw/+7i8JonWyT9P+ZG0aL9YhHuBIkv+WG0Axc21MyF+M
        7zXwW+nyZyijsj24W5TZrrg=
X-Google-Smtp-Source: AGHT+IGCcVQKwTI0/+fNTbYf7kWFfTgBRs/iBo/4wjqeksm5zcnFQiVa+YTF5rQt4FjvAXmH+FXxaQ==
X-Received: by 2002:a05:6602:3a11:b0:79f:922b:3809 with SMTP id by17-20020a0566023a1100b0079f922b3809mr3229009iob.1.1696440767201;
        Wed, 04 Oct 2023 10:32:47 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:d99c:94dd:ccd6:fb22])
        by smtp.gmail.com with ESMTPSA id u23-20020a6be417000000b007870289f4fdsm1066598iog.51.2023.10.04.10.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 10:32:46 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] nfs-utils: gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials
Date:   Wed,  4 Oct 2023 13:32:39 -0400
Message-Id: <20231004173240.46924-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20231004173240.46924-1-olga.kornievskaia@gmail.com>
References: <20231004173240.46924-1-olga.kornievskaia@gmail.com>
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

