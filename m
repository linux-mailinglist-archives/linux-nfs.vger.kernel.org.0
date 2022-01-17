Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CF049007F
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jan 2022 04:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiAQDOG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Jan 2022 22:14:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236914AbiAQDOG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Jan 2022 22:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642389245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tFFgTnxS7HysSFmGAOo4u/tG+5A0qQDOijO1xLOoKog=;
        b=MTGchAGYZir8RzmtC0bGsTQjjjvgrnTHU32x2IYDUIhBT5lEMKiJkx8IRM2PN3tSR7UppN
        0Dqrso8flTUpwHNR5p8U2sGBKDPqwCa5LCv/6WXATfCaPXiZOcXQUouCk/BBvkYQI57qQ7
        J1ep/hM+Z+4AF75JYX6FE8D3EGR4LBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-v9tog8QqMLm7As1fGe0D-g-1; Sun, 16 Jan 2022 22:14:02 -0500
X-MC-Unique: v9tog8QqMLm7As1fGe0D-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFE35807901;
        Mon, 17 Jan 2022 03:14:00 +0000 (UTC)
Received: from localhost (unknown [10.66.61.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CC224ABAF;
        Mon, 17 Jan 2022 03:14:00 +0000 (UTC)
From:   Yongcheng Yang <yoyang@redhat.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        Yongcheng Yang <yongcheng.yang@gmail.com>
Subject: [PATCH 1/1] manpage: remove the no longer supported value "vers2"
Date:   Mon, 17 Jan 2022 11:13:56 +0800
Message-Id: <20220117031356.13361-1-yoyang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Yongcheng Yang <yongcheng.yang@gmail.com>

Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
---

Hi SteveD,

We have removed the ability to enable NFS v2 and there is no default value
"vers2" (in file nfs.conf) anymore. But some man pages are still mentioning
this word.

Thanks,
Yongcheng

 systemd/nfs.conf.man    | 1 -
 utils/mountd/mountd.man | 3 +--
 utils/nfsd/nfsd.man     | 2 --
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index 4436a38a..be487a11 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -171,7 +171,6 @@ Recognized values:
 .BR lease-time ,
 .BR udp ,
 .BR tcp ,
-.BR vers2 ,
 .BR vers3 ,
 .BR vers4 ,
 .BR vers4.0 ,
diff --git a/utils/mountd/mountd.man b/utils/mountd/mountd.man
index 77e6299a..a206a3e2 100644
--- a/utils/mountd/mountd.man
+++ b/utils/mountd/mountd.man
@@ -286,10 +286,9 @@ The values recognized in the
 section include
 .BR TCP ,
 .BR UDP ,
-.BR vers2 ,
 .BR vers3 ", and"
 .B vers4
-which each have same same meaning as given by
+which each have the same meaning as given by
 .BR rpc.nfsd (8).
 
 .SH TCP_WRAPPERS SUPPORT
diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
index 716f538b..634b8a63 100644
--- a/utils/nfsd/nfsd.man
+++ b/utils/nfsd/nfsd.man
@@ -156,8 +156,6 @@ Enable (with "on" or "yes" etc) or disable ("off", "no") UDP support.
 .B TCP
 Enable or disable TCP support.
 .TP
-.B vers2
-.TP
 .B vers3
 .TP
 .B vers4
-- 
2.20.1

