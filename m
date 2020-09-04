Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3347A25E16B
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 20:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIDSUE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 14:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbgIDSUC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 14:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599243601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MhtvFGyWgPeohVCJ3gKqvcwTyrfaCuSn2P1NAQ3lBeI=;
        b=MH/LSqLte5pIqkNqs9lTcgXe8sOhuYooCtHHEMepQUaoA4j6FfrUSgCkQJZeorPP/Zo/Pt
        36gn+EtkzNf1HkVNfMnVL7+BIIsUXo0lMdslSifdotd0J08YpMu48fal8n7fZW7ew0Eq+q
        94SJv1xyDonh0Fz6j1c25Gz3fN45k/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-4tj1-2GpM0CmAvMrCJQR1Q-1; Fri, 04 Sep 2020 14:19:59 -0400
X-MC-Unique: 4tj1-2GpM0CmAvMrCJQR1Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24707801AB8
        for <linux-nfs@vger.kernel.org>; Fri,  4 Sep 2020 18:19:59 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-89.phx2.redhat.com [10.3.113.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D813310013BD
        for <linux-nfs@vger.kernel.org>; Fri,  4 Sep 2020 18:19:58 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] rpc.idmapd: Do not free config varibles
Date:   Fri,  4 Sep 2020 14:19:57 -0400
Message-Id: <20200904181957.9772-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 93e8f092e added a conf_cleanup() call to clean
up memory after the config file was parsed. It turns
out that memory still needed and it is not very much
so the call is removed.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1873965

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/idmapd/idmapd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index f3d2314..51c71fb 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -306,9 +306,6 @@ main(int argc, char **argv)
 			serverstart = 0;
 	}
 
-	/* Config memory is no longer needed */
-	conf_cleanup();
-
 	while ((opt = getopt(argc, argv, GETOPTSTR)) != -1)
 		switch (opt) {
 		case 'v':
-- 
2.26.2

