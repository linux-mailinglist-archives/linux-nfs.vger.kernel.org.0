Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ABC6100A9
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 20:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiJ0Svs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 14:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbiJ0Svh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 14:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3355AC40
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 11:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666896696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TR4HqfQeWYLPodwoI+HMP5Np8zgtGnTeMnHyDuUJ5PU=;
        b=ZCMqILL59iyc4+NSb349wGupYCOpPNvIXuELTJwSEBvdhtOnw/3Rn11aKUVjqjN8L9IRs1
        b7eDer09CpXLTGcgd8eKM/V+Drf0BDIQ4DB7ndrwOFpoTRBYczzb2CV4cG5X0AB6vfjvHf
        1O48n3SaYbi662vvmpilDlL1AE5zME4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-6o2areM3Nm2ehBxtRFk-yA-1; Thu, 27 Oct 2022 14:51:34 -0400
X-MC-Unique: 6o2areM3Nm2ehBxtRFk-yA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CAC28582B9
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 18:51:33 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A19A40C94AA
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 18:51:25 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/1] nfsd: Set v4 version when only a minor version is set
Date:   Thu, 27 Oct 2022 14:51:21 -0400
Message-Id: <20221027185121.15044-2-steved@redhat.com>
In-Reply-To: <20221027185121.15044-1-steved@redhat.com>
References: <20221027185121.15044-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Make sure the v4 version is set when only a minor
version is set in /etc/nfs.conf

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/nfsd/nfsd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
index 4016a76..87c5ce9 100644
--- a/utils/nfsd/nfsd.c
+++ b/utils/nfsd/nfsd.c
@@ -154,6 +154,9 @@ main(int argc, char **argv)
 		if (conf_get_bool("nfsd", tag, 0)) {
 			NFSCTL_MINORSET(minorversset, i);
 			NFSCTL_MINORSET(minorvers, i);
+			/* Make sure v4 is set */
+			if (!NFSCTL_VERISSET(versbits, 4))
+				NFSCTL_VERSET(versbits, 4);
 			if (i == 0)
 				force4dot0 = 1;
 		}
-- 
2.37.3

