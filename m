Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902A657D67F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 00:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiGUWHW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 18:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiGUWHV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 18:07:21 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF093C25
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:21 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id q2so954089ilv.4
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KMTLbdj5i3kARc8Yruolj18QKT6xCIBawJHHHx0dEl0=;
        b=Ei+C/n1YSnW8SD7gH8po9nOxCXP0S6MheqZfcWaDxQSU5Oz4QPZAeVYBT5aSWqM2MZ
         QYcL7uy44oOHVxe+IOLyqdzGhTRbKtrvCiADUbGJ02pb/ZKGJVgeeDGKHdU9sQGkoVv6
         r7fZ3j9LilAaJfesw5U8moaDc+CYyNuAe/b7yJzPX79uvvp4MnXexYD7AZf9UMM0Urpm
         QDQ2kdoAA2GmO790ipqWWFNUaZ0TkkkcbuLDF05Vfh+JJZ255DJlDLAH6zC6lU6dSIoN
         sgXxutMyss2Km8t1bgykBDWKpKSj3EbKlNwcWVt/WcYbKyGbCtEqW1ezj0Kd3Z7oS7su
         yqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KMTLbdj5i3kARc8Yruolj18QKT6xCIBawJHHHx0dEl0=;
        b=PwFUQM0xHv/kWMVN/3eA2eQvelbOgtezsKogx7N5dofRmosNTkBNEITW48hLR36tpT
         CIj67AqC5BiwJlTVLIKNZIlNf7wpIA4uaiI6RrM3XBO6LuQC8khTIjSHhElNAEYdaD/V
         KOfJmoVzykjsYvwf+7YzL8cFxi53muyGdOZGyhNfchpEMnFlXfMWIgDmEZ2NPq988Wxt
         /hAuZ/gpNRB9FHwTdkgAzFjwJxVg9vKMVaZgHLZhXbhFpeK6k4T9pduMAhR8tCusX2jc
         pZI+MwDVLqyoYpP/+v+cqXDWEOSV9fRXwPGqht/88vsAfevzCKq8jK5WzVco0oEfGccI
         DJvw==
X-Gm-Message-State: AJIora8kTbYJluFAGsDnUb2NZRz40J5TVg8IWjccsKv4iEYNIC+1UGnR
        T1aAB9qJkaeAdUKeI3+WjsY=
X-Google-Smtp-Source: AGRyM1uFN6ikur0KGqqXW27Ze3Qz3SbVKw8eikOk8LNxAnLbXzSAx9EofLtFWH8/hATHFxizt76iXA==
X-Received: by 2002:a05:6e02:1d19:b0:2dd:1c61:c8ca with SMTP id i25-20020a056e021d1900b002dd1c61c8camr178381ila.49.1658441240511;
        Thu, 21 Jul 2022 15:07:20 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id g11-20020a05663811cb00b00341668383cfsm1281105jas.33.2022.07.21.15.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:07:20 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 03/11] NFSv4.1 offline trunkable transports on DESTROY_SESSION
Date:   Thu, 21 Jul 2022 18:07:06 -0400
Message-Id: <20220721220714.22620-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
References: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
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
index bb0e84a46d61..9ae7d792beee 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9293,6 +9293,7 @@ int nfs4_proc_destroy_session(struct nfs4_session *session,
 	if (status)
 		dprintk("NFS: Got error %d from the server on DESTROY_SESSION. "
 			"Session has been destroyed regardless...\n", status);
+	rpc_clnt_manage_trunked_xprts(session->clp->cl_rpcclient);
 	return status;
 }
 
-- 
2.27.0

