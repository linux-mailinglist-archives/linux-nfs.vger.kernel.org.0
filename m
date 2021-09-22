Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33268414D34
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 17:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhIVPho (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 11:37:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236455AbhIVPhn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Sep 2021 11:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632324973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gHK8LswhxzhbPNVk9wxln1eGPiyRdTryFnDj15tEJMg=;
        b=doxwzzTTJilfip/LgOVEHb5i3E/aYAB+DNpS6lf7qQiMRvUcBM/hQVqqzfBDVCEFPvwKLP
        AjoQrvW7x/LQO8xkAGoOvHGvnhwJ4QCW0XTwE7A0P0LiaeBGUznCEhmQIcTZNEqJgdfvev
        Zq3Xchp9tqR739RvU07AhIqHlJNrpxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-d0uUGJf6MF-REpPWl0aNdQ-1; Wed, 22 Sep 2021 11:36:11 -0400
X-MC-Unique: d0uUGJf6MF-REpPWl0aNdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12547801E72
        for <linux-nfs@vger.kernel.org>; Wed, 22 Sep 2021 15:36:11 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (ovpn-114-242.phx2.redhat.com [10.3.114.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C085D1000358
        for <linux-nfs@vger.kernel.org>; Wed, 22 Sep 2021 15:36:10 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/2] Move version.h into a common include directory
Date:   Wed, 22 Sep 2021 11:36:09 -0400
Message-Id: <20210922153610.60548-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/include/version.h | 1 +
 utils/gssd/svcgssd_krb5.c | 2 +-
 utils/nfsd/nfssvc.c       | 2 +-
 utils/nfsdcld/nfsdcld.c   | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)
 create mode 120000 support/include/version.h

diff --git a/support/include/version.h b/support/include/version.h
new file mode 120000
index 00000000..b7db0bbb
--- /dev/null
+++ b/support/include/version.h
@@ -0,0 +1 @@
+../../utils/mount/version.h
\ No newline at end of file
diff --git a/utils/gssd/svcgssd_krb5.c b/utils/gssd/svcgssd_krb5.c
index 305d4751..2503c384 100644
--- a/utils/gssd/svcgssd_krb5.c
+++ b/utils/gssd/svcgssd_krb5.c
@@ -46,7 +46,7 @@
 #include "gss_oids.h"
 #include "err_util.h"
 #include "svcgssd_krb5.h"
-#include "../mount/version.h"
+#include "version.h"
 
 #define MYBUFLEN 1024
 
diff --git a/utils/nfsd/nfssvc.c b/utils/nfsd/nfssvc.c
index 720bdd97..46452d97 100644
--- a/utils/nfsd/nfssvc.c
+++ b/utils/nfsd/nfssvc.c
@@ -25,7 +25,7 @@
 #include "nfslib.h"
 #include "xlog.h"
 #include "nfssvc.h"
-#include "../mount/version.h"
+#include "version.h"
 
 #ifndef NFSD_FS_DIR
 #define NFSD_FS_DIR	  "/proc/fs/nfsd"
diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
index 636c3983..dbc7a57f 100644
--- a/utils/nfsdcld/nfsdcld.c
+++ b/utils/nfsdcld/nfsdcld.c
@@ -45,7 +45,7 @@
 #include "cld.h"
 #include "cld-internal.h"
 #include "sqlite.h"
-#include "../mount/version.h"
+#include "version.h"
 #include "conffile.h"
 #include "legacy.h"
 
-- 
2.31.1

