Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C3F65DAFD
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 18:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbjADRKR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 12:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjADRJq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 12:09:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2B9193D0
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 09:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672852137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/fYuYDiDevwijuYBqTTwkHnkRIQO5JYBJ5x9Vyv6GiE=;
        b=IWzUatVBMchxLndWWxwGRkdT74o25GbUCmjP4VBpm4QnmRbdzeFRirRBT/YdUcr3f3HUMV
        xqidn7KIjV+P13FuUAYxIxk3q7DwEe2E+3C/ZoZUGglOkyi90D3xOVvouCkl9Bx0geqRPS
        qxpF5kLWwZIxbdYABBWMwvE92/JhHCk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-ihgl1jfnMrOUO4RSYeU7LQ-1; Wed, 04 Jan 2023 12:08:56 -0500
X-MC-Unique: ihgl1jfnMrOUO4RSYeU7LQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD1993802B80
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 17:08:55 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB2921121315
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 17:08:55 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/2] Covscan Scan: Wrong Check of Return Value
Date:   Wed,  4 Jan 2023 12:08:54 -0500
Message-Id: <20230104170855.19822-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2151966
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/export/client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/support/export/client.c b/support/export/client.c
index ea4f89d..79164fe 100644
--- a/support/export/client.c
+++ b/support/export/client.c
@@ -699,6 +699,9 @@ check_netgroup(const nfs_client *clp, const struct addrinfo *ai)
 
 	/* check whether the IP itself is in the netgroup */
 	ip = calloc(INET6_ADDRSTRLEN, 1);
+	if (ip == NULL)
+		goto out;
+
 	if (inet_ntop(ai->ai_family, &(((struct sockaddr_in *)ai->ai_addr)->sin_addr), ip, INET6_ADDRSTRLEN) == ip) {
 		if (innetgr(netgroup, ip, NULL, NULL)) {
 			free(hname);
-- 
2.38.1

