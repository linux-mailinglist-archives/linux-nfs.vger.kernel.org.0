Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABABA17AB5
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfEHNfl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57483 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfEHNfl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 196E53087950
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:41 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C46595C269
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:40 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 04/19] Removed a resource leak from nfs/rpcmisc.c
Date:   Wed,  8 May 2019 09:35:21 -0400
Message-Id: <20190508133536.6077-5-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 08 May 2019 13:35:41 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs/rpcmisc.c:105: leaked_handle: Handle variable "sock"
	going out of scope leaks the handle.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfs/rpcmisc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/support/nfs/rpcmisc.c b/support/nfs/rpcmisc.c
index abe89ba..d84c04f 100644
--- a/support/nfs/rpcmisc.c
+++ b/support/nfs/rpcmisc.c
@@ -102,6 +102,7 @@ makesock(int port, int proto)
 	if (bind(sock, (struct sockaddr *) &sin, sizeof(sin)) == -1) {
 		xlog(L_FATAL, "Could not bind name to socket: %s",
 					strerror(errno));
+		close(sock);
 		return -1;
 	}
 
-- 
2.20.1

