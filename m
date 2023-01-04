Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABD665DAFC
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 18:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjADRJp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 12:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239938AbjADRJo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 12:09:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5E013F5D
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 09:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672852137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTSprZ+Z8XShxgvny8jNKPs7/O65OqalRhTQ0/X3gLY=;
        b=FNZvikwWSCWAEW9uq/Q9uIUI+z8q8Dnd00/4/6DoBTZOfhdGu9nJxpuQty4j9E+2rMpscs
        6M5SjmtaeCzh3/EC7CE2LY0SYDSQqLzfJ3FglbCPE7mW0Tth+hzLua3xc4WBIr/crG05wz
        J7JEEFIMpILqcXBJuNPkXtuyjzEaf2I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-VtdXP4UUMYq0WAoG5Eqrgw-1; Wed, 04 Jan 2023 12:08:56 -0500
X-MC-Unique: VtdXP4UUMYq0WAoG5Eqrgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03090858F09
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 17:08:56 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E52801121315
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 17:08:55 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/2] Covscan Scan: Fixed a couple CLANG_WARNINGs
Date:   Wed,  4 Jan 2023 12:08:55 -0500
Message-Id: <20230104170855.19822-2-steved@redhat.com>
In-Reply-To: <20230104170855.19822-1-steved@redhat.com>
References: <20230104170855.19822-1-steved@redhat.com>
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

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2151971
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 tools/nfsrahead/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index c83c6f7..8a11cf1 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -167,7 +167,7 @@ int main(int argc, char **argv)
 		if ((ret = get_device_info(argv[optind], &device)) == 0)
 			break;
 
-	if (ret != 0) {
+	if (ret != 0 || device.fstype == NULL) {
 		xlog(D_GENERAL, "unable to find device %s\n", argv[optind]);
 		goto out;
 	}
-- 
2.38.1

