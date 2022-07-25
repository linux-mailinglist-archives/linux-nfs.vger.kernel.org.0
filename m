Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B517457FFE0
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiGYNcm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 09:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiGYNck (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 09:32:40 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54118DE96
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:38 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id a7so3733594vkl.0
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mq8rVpsA9nDNnsFZV5XL3YFvIErJctRzBpIaaJJkMPw=;
        b=S7uOJ4nQt/z0rGScaEoG6C7rKnDmRNww1sfiHvqub7g4FmTvUcAo6hzr4xjLkM490g
         ovbZWgpEXKGL+M4qQEI+lENxkcmAiG5ubR0CPKzzyR4LrvVOG1hYt+gjYwKaH0BuhhdX
         4xV8sFOBUduNKJAv96AenyKtyuwpxA5++eZlgc2sZf7WO0hClTbM1/3XLAh4gwYW8tXQ
         jirAMr+4zFDKD5s2h7ErQ3IlWa/lFM0QTWIiylVbRZWJ6Uqj3mlcRidxbPGKC5G7Mkbb
         LAwaFeo+NiXDJq8CEEt3/J4cUAm3c+3fZmREp8JYiXxTHmsjbf8DFjS7kc7EBwVyZWYK
         0XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mq8rVpsA9nDNnsFZV5XL3YFvIErJctRzBpIaaJJkMPw=;
        b=1MpZ+CSzc7I+W0cqm+VIn6GHjwMaYmdy4bZfpIr+8j4VSXs28WUxVpGmOLhG5yLvmI
         KegBQUna8h/ugidNA9zkipcNkbRy0PnFHpcJmKuwtqawDNvHNNdratOM81AZDMvS3rrO
         lDFsctyKsREAS/HVXfDYKzyecCK35q+1FMJeZCgmUBHae7lYWVVihSDlUFtM/xPDI7Wp
         OqzFDQuZYcIf+kPT5LsCWkzwnlUf+eAua6/5IDR+PhYvKhbTLA9oyPVHsxH32tZjL7Av
         vYMkK8dYk/87Q6HkHMYzpyVvZ3WSS0bBM+eAk37HHrbdmrWfW7dIcRoou3b+LLtK6j1f
         jVHw==
X-Gm-Message-State: AJIora9UxO6vIGnB+VbAMxqsoEpoeCghViguaStL9r2SIJCYu56JZ81M
        yvDZcx826hjVFOzgcxzpYFtrFl/NzgE=
X-Google-Smtp-Source: AGRyM1s7HBq4WtcaJ0w6Ughud1gDUL9j4ZUNapOoqtALtkaShHOIapwy1Z1QC5AT/tSMQX8R2qPzLA==
X-Received: by 2002:a1f:34d0:0:b0:375:c0d6:79ff with SMTP id b199-20020a1f34d0000000b00375c0d679ffmr3311856vka.37.1658755957339;
        Mon, 25 Jul 2022 06:32:37 -0700 (PDT)
Received: from localhost.localdomain (071-047-011-047.res.spectrum.com. [71.47.11.47])
        by smtp.gmail.com with ESMTPSA id a6-20020ab06306000000b00383aeb53100sm2128826uap.16.2022.07.25.06.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:36 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 03/11] NFSv4.1 offline trunkable transports on DESTROY_SESSION
Date:   Mon, 25 Jul 2022 09:32:23 -0400
Message-Id: <20220725133231.4279-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
References: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When session is destroy, some of the transports might no longer be
valid trunks for the new session. Offline existing transports.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 4e0dcc19ca71..3f4e84e9646e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9291,6 +9291,7 @@ int nfs4_proc_destroy_session(struct nfs4_session *session,
 	if (status)
 		dprintk("NFS: Got error %d from the server on DESTROY_SESSION. "
 			"Session has been destroyed regardless...\n", status);
+	rpc_clnt_manage_trunked_xprts(session->clp->cl_rpcclient);
 	return status;
 }
 
-- 
2.27.0

