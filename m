Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49CC17AC1
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfEHNft (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbfEHNft (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 370833078ABB
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:49 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E66745C269
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:48 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 16/19] Removed a resource leak from mount/stropts.c
Date:   Wed,  8 May 2019 09:35:33 -0400
Message-Id: <20190508133536.6077-17-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 08 May 2019 13:35:49 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

mount/stropts.c:986: leaked_storage: Variable "address"
	going out of scope leaks the storage it points to.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mount/stropts.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index a093926..1bb7a73 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -983,8 +983,11 @@ static int nfs_try_mount(struct nfsmount_info *mi)
 		}
 
 		if (!nfs_append_addr_option(address->ai_addr,
-					    address->ai_addrlen, mi->options))
+					    address->ai_addrlen, mi->options)) {
+			nfs_freeaddrinfo(address);
+			errno = ENOMEM;
 			return 0;
+		}
 		mi->address = address;
 	}
 
-- 
2.20.1

