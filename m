Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D4C4A3868
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jan 2022 20:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiA3TGV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jan 2022 14:06:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234607AbiA3TGU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jan 2022 14:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643569580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XpVqDi2EgUoJpNGpy71IT7jsdzoUHW4CLA2EtNQFIo=;
        b=QtHZtsia7hcn5YBSBcxS4AGQYBjnSRe6BE8Oh0zPwyseB0pQfAkkLucjAYlkua3JH+TgML
        ggOW1lJZhRgUW+zoXY0klBcd2PZ7jVW19UMU1pB4FDMuKulyjS9mSLWJKxVzZVYGddYDTv
        FUNRVfy+TcTHlvGVYFiP4XOnHcItJw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-TIg6wjTQOVedZUvxTfRBuw-1; Sun, 30 Jan 2022 14:06:16 -0500
X-MC-Unique: TIg6wjTQOVedZUvxTfRBuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB0181083F60;
        Sun, 30 Jan 2022 19:06:15 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (unknown [10.2.16.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DC286091B;
        Sun, 30 Jan 2022 19:06:15 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Bill Baker <webbaker@gmail.com>,
        Calum Mackay <calum.mackay@oracle.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 4/5] saveto verb: Document updated
Date:   Sun, 30 Jan 2022 14:06:10 -0500
Message-Id: <20220130190611.12292-5-steved@redhat.com>
In-Reply-To: <20220130190611.12292-1-steved@redhat.com>
References: <20220130190611.12292-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Document that fact any verbs after the saveto
line will not be processed.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 fdrd.man    | 7 +++++++
 samples/nfs | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/fdrd.man b/fdrd.man
index 99f7f80..f62a23b 100644
--- a/fdrd.man
+++ b/fdrd.man
@@ -102,6 +102,13 @@ can be harvested manually by reading:
 The ftrace buffers in the kernel are circular. If no
 process harvests the data, new data will overwrite old data.
 .P
+Note, the 
+.B saveto 
+verbs has to be last line in a configuration
+file. Verbs after the 
+.B saveto 
+verbs will not be seen.
+.P
 .B minfree
 value
 .P
diff --git a/samples/nfs b/samples/nfs
index 0c635e6..c1dbb57 100644
--- a/samples/nfs
+++ b/samples/nfs
@@ -58,4 +58,6 @@ enable sunrpc/rpc_xdr_overflow
 enable sunrpc/xprt_ping
 enable sunrpc/xprt_timer
 #
+# Needs to be the last line in the config
+# file. Verbs after this verb will not be seen.
 saveto /var/log/nfs.log 128k
-- 
2.34.1

