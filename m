Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2528A23CEC9
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Aug 2020 21:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgHETFF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Aug 2020 15:05:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51648 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728527AbgHETBw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Aug 2020 15:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596654060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JLqa+MAv7jPDr+cHdCpQFs/slcQCkBQUMol1ozhrJSA=;
        b=ignP0JIu8GpeMrzkwNkZty2TKz0J7MsCTmDnjBbYxPEb5hWbgbKBg13AozVzMzxFjArTE+
        MhwrpwAaxm7kAdcVEHrNxMHWrbRBo8EmObgByvy1xUYE+x+9tNgpF9kTaxEJlRFU8Dk9xt
        eJAxd0bYA0zCSL0uDn/Wt8zdWHG1HI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-mf-IFr-qN8q8HUVgoQICYg-1; Wed, 05 Aug 2020 15:00:57 -0400
X-MC-Unique: mf-IFr-qN8q8HUVgoQICYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 124A11005504
        for <linux-nfs@vger.kernel.org>; Wed,  5 Aug 2020 19:00:57 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-70.phx2.redhat.com [10.3.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6ADC5DA60
        for <linux-nfs@vger.kernel.org>; Wed,  5 Aug 2020 19:00:56 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] idmapd: Turn down the verbosity in flush_inotify()
Date:   Wed,  5 Aug 2020 15:00:54 -0400
Message-Id: <20200805190054.39513-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

So idmapd does not flood the logs with messages
nobody will understand, only print the message
with verbose is set.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/idmapd/idmapd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index 8631414..7d1096d 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -500,7 +500,8 @@ flush_inotify(int fd)
 		     ptr += sizeof(struct inotify_event) + ev->len) {
 
 			ev = (const struct inotify_event *)ptr;
-			xlog_warn("pipefs inotify: wd=%i, mask=0x%08x, len=%i, name=%s",
+			if (verbose > 1)
+				xlog_warn("pipefs inotify: wd=%i, mask=0x%08x, len=%i, name=%s",
 				  ev->wd, ev->mask, ev->len, ev->len ? ev->name : "");
 		}
 	}
-- 
2.24.1

