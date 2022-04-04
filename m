Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCE34F1483
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Apr 2022 14:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbiDDMQP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Apr 2022 08:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbiDDMQO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Apr 2022 08:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABE93273F
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 05:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649074457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60796q+R66q6PScXM7sZ0KwUoDSRalaBUU99w2DeJQA=;
        b=WOvPq1Z3GbFAG5nmyvnVyYkitaS/tCPWn4M6Mi10JRGV0X0qKnHy2fOb7Vy3bz082cZUyG
        J7KPu6iuNnRubJ8/6vLE8PyOZLeCNuk8Zx4Bff1a+F3KvEpD3byoevgG1OZpjCqg3D6yp2
        pdR7RlJGPqN+ni6sFt9PqA7bOiwUot4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-r7hPr-VDPTe8ifEvNlpAEA-1; Mon, 04 Apr 2022 08:14:14 -0400
X-MC-Unique: r7hPr-VDPTe8ifEvNlpAEA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81F911C068D1;
        Mon,  4 Apr 2022 12:14:13 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-103.gru2.redhat.com [10.97.116.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AEDB64428E8;
        Mon,  4 Apr 2022 12:14:07 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [PATCH v4 7/7] nfsrahead: retry getting the device if it fails.
Date:   Mon,  4 Apr 2022 09:13:08 -0300
Message-Id: <20220404121308.14228-1-tbecker@redhat.com>
In-Reply-To: <20220401153208.3120851-1-tbecker@redhat.com>
References: <20220401153208.3120851-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sometimes the mountinfo entry is not available when nfsrahead is called,
leading to failure to set the readahead. Retry getting the device before
failing.

Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 tools/nfsrahead/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index 1a312ac9..b3af3aa8 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -127,7 +127,7 @@ static int conf_get_readahead(const char *kind) {
 
 int main(int argc, char **argv)
 {
-	int ret = 0;
+	int ret = 0, retry;
 	struct device_info device;
 	unsigned int readahead = 128, verbose = 0, log_stderr = 0;
 	char opt;
@@ -154,7 +154,11 @@ int main(int argc, char **argv)
 	if ((argc - optind) != 1)
 		xlog_err("expected the device number of a BDI; is udev ok?");
 
-	if ((ret = get_device_info(argv[optind], &device)) != 0) {
+	for (retry = 0; retry <= 10; retry++ )
+		if ((ret = get_device_info(argv[optind], &device)) == 0)
+			break;
+
+	if (ret != 0) {
 		xlog(L_ERROR, "unable to find device %s\n", argv[optind]);
 		goto out;
 	}
-- 
2.35.1

