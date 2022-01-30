Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB924A3865
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jan 2022 20:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiA3TGT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jan 2022 14:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230314AbiA3TGT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jan 2022 14:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643569578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jcIk85AtyisDsGBlA0GIH4kblXPVbB7HTcaWLspdKK4=;
        b=IPfz4OIJurUSD8fbPmUOONilFEYVI1j9ucZHxWbeEqJd5aptsCz9EcA/58420+YpMarHVH
        IlHjkWPZ3DtDd7z40glNuQRSKvqE8hskq3hgQvehRHAAvfC1MZbjmzxhtI64kEyfG8tCgY
        1diYfPNa7yXprIDW56uPJrAOuTmQYqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-_iA4JOrUPuaWUPXAZJfz_Q-1; Sun, 30 Jan 2022 14:06:14 -0500
X-MC-Unique: _iA4JOrUPuaWUPXAZJfz_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC2ED1853020;
        Sun, 30 Jan 2022 19:06:13 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (unknown [10.2.16.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41E1260854;
        Sun, 30 Jan 2022 19:06:13 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Bill Baker <webbaker@gmail.com>,
        Calum Mackay <calum.mackay@oracle.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/5] Makefile: cleaned up the usage of RPMBUILD_DIR
Date:   Sun, 30 Jan 2022 14:06:07 -0500
Message-Id: <20220130190611.12292-2-steved@redhat.com>
In-Reply-To: <20220130190611.12292-1-steved@redhat.com>
References: <20220130190611.12292-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index ac4a501..34d7279 100644
--- a/Makefile
+++ b/Makefile
@@ -46,11 +46,11 @@ release:
 
 rpm: tarball
 	cp buildrpm/$(LATEST_VERS)/fdr.spec \
-		$(RPMBUILD_DIR)/rpmbuild/SPECS/fdr.spec
-	rpmbuild -bb $(RPMBUILD_DIR)/rpmbuild/SPECS/fdr.spec 
+		$(RPMBUILD_DIR)/SPECS/fdr.spec
+	rpmbuild -bb $(RPMBUILD_DIR)/SPECS/fdr.spec 
 
 srpm: tarball
 	cp buildrpm/$(LATEST_VERS)/fdr.spec \
-		$(RPMBUILD_DIR)/rpmbuild/SPECS/fdr.spec
-	rpmbuild -bs $(RPMBUILD_DIR)/rpmbuild/SPECS/fdr.spec 
+		$(RPMBUILD_DIR)/SPECS/fdr.spec
+	rpmbuild -bs $(RPMBUILD_DIR)/SPECS/fdr.spec 
 
-- 
2.34.1

