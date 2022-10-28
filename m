Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1A611581
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJ1PG6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 11:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJ1PGt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 11:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B52D1BB55C
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666969549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0H7SxGpFvl3T5WJVmn5971FabcUd4rpwdMYKjpJF7Ac=;
        b=L0YGHv4R6LEtBj28xuVfT6nuHp9z8cMRTlgfY8NrH7HKm1TRXDTzolOl/RZkebX3YvFZOk
        adtvxTsB5D0pBqopXa3NocIckaJY/2snMKpfcH3Yb8OAr3y4lFyQ+T7Tu8sKzwQmbDfjgL
        YOO7igp2mKIscZZ8v91i3MsYT/3EzVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-95Dzu1VJO7a4NbANASTQ6Q-1; Fri, 28 Oct 2022 11:05:48 -0400
X-MC-Unique: 95Dzu1VJO7a4NbANASTQ6Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDFF0101A56D
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 15:05:47 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (unknown [10.2.16.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1C41492B06
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 15:05:47 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfsd.man: Explain that setting nfsv4=n turns off all v4 versions
Date:   Fri, 28 Oct 2022 11:05:47 -0400
Message-Id: <20221028150547.19646-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Update the man page to explicitly say setting
nfsv4=n turns off all v4 versions

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/nfsd/nfsd.man | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
index 634b8a6..bb99fe2 100644
--- a/utils/nfsd/nfsd.man
+++ b/utils/nfsd/nfsd.man
@@ -159,7 +159,9 @@ Enable or disable TCP support.
 .B vers3
 .TP
 .B vers4
-Enable or disable a major NFS version.  3 and 4 are normally enabled
+Enable or disable 
+.B all 
+NFSv4 versions.  All versions are normally enabled
 by default.
 .TP
 .B vers4.1
-- 
2.37.3

