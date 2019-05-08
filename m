Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91F8217AB4
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfEHNfl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfEHNfk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F6E33088B77
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:40 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A9611724D
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:40 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 03/19] Removed a resource leak from nfs/mydaemon.c
Date:   Wed,  8 May 2019 09:35:20 -0400
Message-Id: <20190508133536.6077-4-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 08 May 2019 13:35:40 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs/mydaemon.c:130: leaked_handle: Handle variable "tempfd"
	going out of scope leaks the handle.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfs/mydaemon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/support/nfs/mydaemon.c b/support/nfs/mydaemon.c
index 343e80b..d1cf08d 100644
--- a/support/nfs/mydaemon.c
+++ b/support/nfs/mydaemon.c
@@ -123,6 +123,7 @@ daemon_init(bool fg)
 	dup2(tempfd, 0);
 	dup2(tempfd, 1);
 	dup2(tempfd, 2);
+	close(tempfd);
 	closelog();
 	dup2(pipefds[1], 3);
 	pipefds[1] = 3;
-- 
2.20.1

