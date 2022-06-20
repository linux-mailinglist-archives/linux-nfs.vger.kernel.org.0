Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977645520C6
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244416AbiFTPZ5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244612AbiFTPZX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:25:23 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8AEDC6
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:35 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 89so16384637qvc.0
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9FyxGlb8wrzVlWXd/m4jVF2xUpvcFWGXIfAh3DX6L4E=;
        b=p3uPJU0bUcEKR+IpYw6TApHqxeESdU2AytligxoT21eSy++Rse52bSoPrcuVrYIIFU
         vtPMaxuToUsR0WGdk8ZkbQWcwx5w+dC39bceB5uzg+61ezxoyDQCReLH0+vsEU4WuoAF
         CvFEiDXdmDgVBOUAAfLu04usaYRv3aUItUgokNuzmqul81GH7VnCfOgtHLoiSKIZHEE7
         3V2yRBjPr6++IQvGgajlf9ngqGOZkZYeXR4O+RVYdA3VGYoPUM/EeGCtdNG2VWL4Ywh+
         nGdmAtWr5/QTX7UfDE9nx6DLkpOg67D0rVJKe6Aq5KMeK/E7l0FloANnod3cYRb/dqfB
         /zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9FyxGlb8wrzVlWXd/m4jVF2xUpvcFWGXIfAh3DX6L4E=;
        b=icdZXuAQvuRqY67PeZLJJ1EqLVQ7PhA6m1ouNHxkGU4yIFYIPLU8/wuHOcWJO8YxT+
         EXlRHlammTnS5thCVxRPhv/vO35kfKOeltwsekfz0hm/aa9siBmPyb561vtwcuEfLl/4
         BTf9KpQR1gPqxSPEVM0OwJ3vZAmyjf2bGUnwW+YJPSr2017izFdfNhc32dvqogdcNriD
         ngGbElTGTvWpfqhaiT5K6Vw3cAB2JypjzdzlzzFKqim2k6xhG2eLJ/i+Oqlzwc6bEEOf
         3jI8xOstzIdEgnPXqDg76rzdNrnH3ASrSbL2OM4E4RKDrK9yys9PnDOfSZu57wrKXtbQ
         RKSg==
X-Gm-Message-State: AJIora+xsJmmnqxWiq4hVOvQ+z5RrcJ8muO07Vmil3lOSAlc4ynrezlF
        R40fw4xpUMZqI3v3HF+vX/E=
X-Google-Smtp-Source: AGRyM1vRorNCn/XYxZjkRDobrGwOsud499eh6S9hb+Nhksm5VJTRYwDgl55c3kyywKuzSVHP6MIk5g==
X-Received: by 2002:ac8:5d49:0:b0:305:2d22:3242 with SMTP id g9-20020ac85d49000000b003052d223242mr20104132qtx.470.1655738674049;
        Mon, 20 Jun 2022 08:24:34 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:48cb:6eb8:1da1:a5c0])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006a791a42693sm12517862qko.133.2022.06.20.08.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:24:33 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 03/12] NFSv4.1 offline trunkable transports on DESTROY_SESSION
Date:   Mon, 20 Jun 2022 11:23:58 -0400
Message-Id: <20220620152407.63127-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
References: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

When session is destroy, some of the transports might no longer be
valid trunks for the new session. Offline existing transports.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c0fdcf8c0032..cf898bea3bfd 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9273,7 +9273,7 @@ int nfs4_proc_destroy_session(struct nfs4_session *session,
 		.rpc_argp = session,
 		.rpc_cred = cred,
 	};
-	int status = 0;
+	int status = 0, offline = 0;
 
 	/* session is still being setup */
 	if (!test_and_clear_bit(NFS4_SESSION_ESTABLISHED, &session->session_state))
@@ -9286,6 +9286,7 @@ int nfs4_proc_destroy_session(struct nfs4_session *session,
 	if (status)
 		dprintk("NFS: Got error %d from the server on DESTROY_SESSION. "
 			"Session has been destroyed regardless...\n", status);
+	rpc_clnt_manage_trunked_xprts(session->clp->cl_rpcclient, &offline);
 	return status;
 }
 
-- 
2.27.0

