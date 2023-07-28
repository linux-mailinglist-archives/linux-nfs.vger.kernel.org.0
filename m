Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47A3766FEA
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jul 2023 16:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbjG1O6A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jul 2023 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbjG1O57 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jul 2023 10:57:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CE41FFF;
        Fri, 28 Jul 2023 07:57:58 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8ad356f03so13415465ad.1;
        Fri, 28 Jul 2023 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690556277; x=1691161077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWih78y74Ukc7tMBq7op5SFjYJrM34VhQ6EyDtgFMU4=;
        b=qyhJpkRNW5HBXmr5I5Wd6yIoCQjowGdk0dvkGn9Igw8BRhjmw7u3jH73rqkOk9FyV6
         61JwHLhiljEePIVTZiH/a8IES3ShoZhRn4V6WhVHybU4uy49F2ap2MAujgZoYjtVTYeW
         cUa2nCnOI1b1owZz0SJG4RVoQcD/lKywjbjoAoJLXjmvGf3Skj1sZip88qgg1R4kw+td
         Bnj/iDYMDt7JPxaZh9ZslEX7WMjXpfeFXqTaihKcWamKyI6/2VEk0+J1u4IMl5Hq9nxj
         bYTIrplYpQz07kS4j12vBy4HR34xBHAHwy1tZy91HNWjuCJJQjb/EJbk5aGcDYOC8nFU
         QidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556277; x=1691161077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWih78y74Ukc7tMBq7op5SFjYJrM34VhQ6EyDtgFMU4=;
        b=e3F7S091m2R/yiVoZhNbx8BbGTiSHj+C1r+jsWZARlEMHCklJ7UBJaEToHWBjkKBY6
         rLBOw+830Rjc2QI8kIGzmvZ6B+LjxHlPmGgX+W3sLG0foxvE5Z8NYeG14MnfwCmCNQf2
         GIU8G2yRw1IQMKvQWtMiZ3TAfMSRDGYBX/8TtsMktvhS+YZD818f4eYt3aqMOn9oOfEh
         vcwkWjv6dzjiE7wuJtVfONkCzqpbB/Y2MJ63tAd+kYjVrasTTmDIgPOK0tomYbRxXsiw
         xrRiJLUc5gQgPtAN3ouQGQRTtoIYoGFYSwXsLg8FYstadw8kkE3mtcZbiuI4BJ12h0hb
         +QqA==
X-Gm-Message-State: ABy/qLbbxX83KeMgIa2geRG5AtR7EB2+Ek9IJT/C8lfkdfCtQ68dsTxF
        eTaPxNwPy8Bmg3F24mvkzIk=
X-Google-Smtp-Source: APBJJlHf75Ucy13XE140hxL8itT7EhC/1kUs+N+64as49WqRmyugumIN1FWfiplpvy0d7gSmMv5hYw==
X-Received: by 2002:a17:903:32cf:b0:1b9:c68f:91a5 with SMTP id i15-20020a17090332cf00b001b9c68f91a5mr1946142plr.6.1690556277539;
        Fri, 28 Jul 2023 07:57:57 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-95-101.dynamic-ip.hinet.net. [36.228.95.101])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902e9c200b001bba27d1b65sm3690346plk.85.2023.07.28.07.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:57:56 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sunrpc: wrap debug symobls with CONFIG_SUNRPC_DEBUG
Date:   Fri, 28 Jul 2023 22:57:50 +0800
Message-Id: <20230728145751.138057-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

rpc_debug, nfs_debug, nfsd_debug, and nlm_debug are used
if CONFIG_SUNRPC_DEBUG is set. Wrap them with CONFIG_SUNRPC_DEBUG
and fix the following sparse warnings:

net/sunrpc/sysctl.c:29:17: sparse: warning: symbol 'rpc_debug' was not declared. Should it be static?
net/sunrpc/sysctl.c:32:17: sparse: warning: symbol 'nfs_debug' was not declared. Should it be static?
net/sunrpc/sysctl.c:35:17: sparse: warning: symbol 'nfsd_debug' was not declared. Should it be static?
net/sunrpc/sysctl.c:38:17: sparse: warning: symbol 'nlm_debug' was not declared. Should it be static?

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 net/sunrpc/sysctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index 93941ab12549..887bdeae3c89 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -23,6 +23,8 @@
 
 #include "netns.h"
 
+#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
+
 /*
  * Declare the debug flags here
  */
@@ -38,8 +40,6 @@ EXPORT_SYMBOL_GPL(nfsd_debug);
 unsigned int	nlm_debug;
 EXPORT_SYMBOL_GPL(nlm_debug);
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-
 static int proc_do_xprt(struct ctl_table *table, int write,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {
-- 
2.34.1

