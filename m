Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D126B4C7AA4
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 21:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiB1Uiv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 15:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiB1Uiu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 15:38:50 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D85717E0C
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:38:11 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id jr3so295507qvb.11
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ew6ex4ImrmoYJbAwJO0QlqYMqMREyKypAqRYlO3rTk0=;
        b=fMfJsgq92t7I7DVxS+jm3jZhNRnNb1iwzt8rg2DJmW825p5PlDdPMrr6W8wlCJekxF
         7NndACtZtjXWTOd273wivLWj5Sol0uN6fLBBc5ohbb/GaR23GflqO6W/W/xqoeFA6u3E
         L5XJMfOtAi2IQXF5EAkmGXbJecOFDE697HNCGDGCZ2e+t0Jrlh+e69OxE762h+4+V2XC
         vf8RMa9myT8B4mEX2wSAis6cig6BklxGrWgUlkZ/4VVo7IB+22awaWqtjflPlv7XaW7/
         s1LdJzbuAWdWymJLkEbdr3d4jEnoHXhsoStfOS7oSsLZOmxRW141xW164IRw3YTI3x9b
         +l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ew6ex4ImrmoYJbAwJO0QlqYMqMREyKypAqRYlO3rTk0=;
        b=3GP8uqPOxUoTIPk8uz6XPJjCh+lVLRTyFWkmax3As0acwNsnAnfEnWaiLOZUzypTqs
         Qi0MsIANkf2imTM/Gsq9ZrvVoiXJIk3Dh8sQQWjM3rFFaOV0b2Xv5NE/dCVySqJnHxRm
         ABFK/NuhEbIacLDoDj8GzTHmWPPM8cSB0X07KAXhVpFmIXoTvHvUrGDH3ITd2nJ827zN
         YaQzmU/x+71toK5AxPpZb37tXo0JEvBlXkP9EatCo7cYr2FXFYytPvsXnndO0yaHpb6V
         e+LnlZP/wWGPJeNHYf14tmx22eaq/QCk92TuLqIh5eAV4x/wyMd7ST66sVFWNLfGkEve
         1JPw==
X-Gm-Message-State: AOAM532t6C9SJf0JCTrJHb8C7Z+56H++Izd3lHvGlk1E+6cZrQyz1KNK
        sYggkPt6ELfX3Hjz8YxFTwy3gfLsE3o=
X-Google-Smtp-Source: ABdhPJyZLs6VDUC9pSXcJwYufAkvllIOS7gN9KgcZFZNAnAcm8Keqwmn+H4OV9p3fqKLVY/5twKyrA==
X-Received: by 2002:ad4:5ca5:0:b0:42c:4daa:ea3b with SMTP id q5-20020ad45ca5000000b0042c4daaea3bmr14948757qvh.99.1646080690461;
        Mon, 28 Feb 2022 12:38:10 -0800 (PST)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:4cc0:8dcd:bb8c:75c2])
        by smtp.gmail.com with ESMTPSA id p20-20020a05620a22b400b00648ca1458b4sm5457606qkh.5.2022.02.28.12.38.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:38:09 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 3/3] NFSv4.1 destroy trunkable transport when destroying the session
Date:   Mon, 28 Feb 2022 15:38:04 -0500
Message-Id: <20220228203804.61803-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220228203804.61803-1-olga.kornievskaia@gmail.com>
References: <20220228203804.61803-1-olga.kornievskaia@gmail.com>
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

Trunking connections to different IPs represending the same server
are initially discovered and associated with a session. It stands
to reason that once the session is destroyed those connections
might no longer be representing the same server for the newly
created session.

This patch proposed that when the sesssion is destroyed, also iterate
thru available transports and terminate any trunkable connections.
Main transport and nconnect connections are not effected.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 73a9b6de666c..08597e2e0571 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9193,6 +9193,7 @@ int nfs4_proc_destroy_session(struct nfs4_session *session,
 	if (status)
 		dprintk("NFS: Got error %d from the server on DESTROY_SESSION. "
 			"Session has been destroyed regardless...\n", status);
+	rpc_clnt_destroy_trunked_xprts(session->clp->cl_rpcclient);
 	return status;
 }
 
-- 
2.27.0

