Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD6581AC7
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 22:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiGZUNs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 16:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiGZUNs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 16:13:48 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740DD32477
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 13:13:46 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j11so11470889qvt.10
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cfa.harvard.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xN/m9n+QB+L0yLZWGe1DxdsMbZbPfnSILzV2EtfRlDU=;
        b=zgnMm/bKDjtWlOn9Njjd+LKqzZAyNsLo9uVwnCmF8IDUCB+OVL9Dc7rLjcp9M6to3d
         5u0XjMktfnBNywIz7Q5DJ0nJwZkXa85/uT38/+CWBZXqYPg0w5/roMD1PogjOP7oGnzY
         YsLTkOfQ7i00WC193bJ6dsexJ8gtuPvP9/7UqSmjgflSlBOFezkcTH97Yzn2BQ5/rqbo
         lUUb4LUMba+GmuYBrzdHOCT8ozeP4AGvhRJfJvi4FgRfqO/yOa9pFzsGjf3pUKtSgEt5
         Mw+TKbWrjehIPbrJqjjYRqnFLhJmxn9Gb9tlSKcSpKvoy/Sv+9nN2zNvqiS6HgQQou2a
         +RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xN/m9n+QB+L0yLZWGe1DxdsMbZbPfnSILzV2EtfRlDU=;
        b=1NSCfkqDL9e+ksb02TzskyZXzKUrPKvJnJNwDoQ6XdTglpWNw5fPkBrt8O/zuD2AEc
         ngFLRbhCG2BPvkXU03HYxZiO9FX1tjFuFkLWm+wY+qPF5sz9XwuvcSzPTE8yvpaw9bLe
         iMUT/uuDengb1gU+Ck2PXTFHkZoJ2rDKGl0XNwVr33e84lfvjkNcA+6/91hILp2ZpG6W
         nS8wk90b8yKr8Hyxo7FhiqyeeAK4U1AzMqERG2tyrMlk3qThSrRd38fW/cF9AdLBR+PD
         ETLSY5jIA3omYN6iBE07/DvJ2PCFebGPCOZ5YUBa4ygHAoMaxVoITQhsLQv79aT84L6a
         EROA==
X-Gm-Message-State: AJIora/o1SqI9f5gqFAzfHIqYtJoIIxnrNSekid7j+iBVRk3Q5aXfDsE
        hjh3a0UdxaZf5k2y2ZpdQRJ9pN4g4ptPYg==
X-Google-Smtp-Source: AGRyM1t+OJ+x9Y3ppLe0bHOjVbrzo6h434eEvmBvXc+cYdk+AF9CFQA70QTqj+Fj8w9rKgUMhtbhuQ==
X-Received: by 2002:a05:6214:2423:b0:474:184d:866d with SMTP id gy3-20020a056214242300b00474184d866dmr16909122qvb.25.1658866425422;
        Tue, 26 Jul 2022 13:13:45 -0700 (PDT)
Received: from pihe (dhcp-131-142-152-103.cfa.harvard.edu. [131.142.152.103])
        by smtp.gmail.com with ESMTPSA id o7-20020a05620a2a0700b006b5683ee311sm12747714qkp.100.2022.07.26.13.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:13:45 -0700 (PDT)
Received: from pihe (localhost [127.0.0.1])
        by pihe (8.17.1/8.17.1) with ESMTPS id 26QKDhog103918
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 16:13:43 -0400
Received: (from pumukli@localhost)
        by pihe (8.17.1/8.17.1/Submit) id 26QKDh36103809;
        Tue, 26 Jul 2022 16:13:43 -0400
From:   Attila Kovacs <attila.kovacs@cfa.harvard.edu>
To:     Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] SUNRPC: mutexed access blacklist_read state variable.
Date:   Tue, 26 Jul 2022 16:12:43 -0400
Message-Id: <20220726201243.103800-1-attila.kovacs@cfa.harvard.edu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Attila Kovacs <attipaci@gmail.com>

bindresvport()_sa(), in bidresvport.c checks blacklist_read w/o mutex
before calling load_blacklist() which changes blacklist_read() also
unmutexed.

Clearly, the point is to read the blacklist only once on the first call,
but because the checking whether the blacklist is loaded is not mutexed,
more than one thread may race to load the blacklist concurrently, which
of course can jumble the list because of the race condition.

The fix simply moves the checking within the mutexed aread of the code
to eliminate the race condition.

---
 src/bindresvport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/bindresvport.c b/src/bindresvport.c
index ef9b345..5c0ddcf 100644
--- a/src/bindresvport.c
+++ b/src/bindresvport.c
@@ -164,10 +164,11 @@ bindresvport_sa(sd, sa)
 	int endport = ENDPORT;
 	int i;
 
+	mutex_lock(&port_lock);
+
 	if (!blacklist_read)
 		load_blacklist();
 
-	mutex_lock(&port_lock);
 	nports = ENDPORT - startport + 1;
 
         if (sa == NULL) {
-- 
2.37.1

