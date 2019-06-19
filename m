Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC44C2C2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 23:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfFSVLK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 17:11:10 -0400
Received: from fieldses.org ([173.255.197.46]:42524 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfFSVLK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 19 Jun 2019 17:11:10 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 3B9C11E19; Wed, 19 Jun 2019 17:11:10 -0400 (EDT)
Date:   Wed, 19 Jun 2019 17:11:10 -0400
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: fix out-of-date connectathon talk URL
Message-ID: <20190619211110.GD3044@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Reported-by: David Wysochanski <dwysocha@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 net/sunrpc/svc_xprt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 869ce7737997..de3c077733a7 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -35,7 +35,7 @@ static void svc_delete_xprt(struct svc_xprt *xprt);
 /* apparently the "standard" is that clients close
  * idle connections after 5 minutes, servers after
  * 6 minutes
- *   http://www.connectathon.org/talks96/nfstcp.pdf
+ *   http://nfsv4bat.org/Documents/ConnectAThon/1996/nfstcp.pdf
  */
 static int svc_conn_age_period = 6*60;
 
-- 
2.21.0

