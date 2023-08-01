Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5C476AE2C
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 11:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjHAJgh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Aug 2023 05:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjHAJgM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Aug 2023 05:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A902D198D
        for <linux-nfs@vger.kernel.org>; Tue,  1 Aug 2023 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690882409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wGkfL2h20K8rfxu1RiAQUij0LXBrKAIUByFP/l4aZkU=;
        b=EAvymvlr4HyaVRcQFjV1n/nUB/70eK4OgJELhocJgIMfFUo9vit3cm2rmAaDdmpKJbu8if
        EE7RTWlOYCdDxQrYiwjRQd1DwYYIXHa4qx1uofYqgyKaIuNYNi7xRMjMk225p3+PBy2DdC
        7Qypjj6ba3UC34y1sAyHCtXbAL6lIPs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451--YNng13dMFS1OsCXMMopVA-1; Tue, 01 Aug 2023 05:33:26 -0400
X-MC-Unique: -YNng13dMFS1OsCXMMopVA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 585E3185A7A5;
        Tue,  1 Aug 2023 09:33:26 +0000 (UTC)
Received: from localhost (yoyang-vm.hosts.qa.psi.pek2.redhat.com [10.73.149.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1361492CAC;
        Tue,  1 Aug 2023 09:33:25 +0000 (UTC)
From:   Yongcheng Yang <yoyang@redhat.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        Herb Wartens <wartens2@llnl.gov>,
        Yongcheng Yang <yoyang@redhat.com>
Subject: [PATCH 0/2] Double-Free and Memory Leak Found In libtirpc
Date:   Tue,  1 Aug 2023 17:33:08 +0800
Message-Id: <20230801093310.594942-1-yoyang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey,

These 2 patches are from "Wartens, Herb" <wartens2@llnl.gov> and I
have just tried to make it appliable to the libtirpc upstream version.
Please help double check and apply them if there's no problem.

Herb Wartens (2):
  rpcb_clnt.c: fix a possible double free
  rpcb_clnt.c: fix memory leak in destroy_addr

 src/rpcb_clnt.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

-- 
2.31.1

