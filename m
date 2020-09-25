Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F4D2788D6
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 14:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgIYM6P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbgIYM6P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 08:58:15 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E033DC0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 05:58:14 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C5766448D; Fri, 25 Sep 2020 08:58:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C5766448D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601038693;
        bh=gCCJxb/0DquHJNEPu1djqUX+jjr0NPycxUSjLaHNxjM=;
        h=Date:To:Subject:From:From;
        b=b1ab3B9j3hPkibXoPduB4XawuyqtaAN0LGOroFcSeSglKlZOruGPep868YPiUz5w9
         FoeKv4Ytp4Xpjk0O+d3V22zKhwRYi+iwlq9GWEmVVeeb+2v3pkFlx6ucZtt9pJZSgn
         QOgsv4FiZhaQcC+1LkWiZM1SU0GVZYSvhWYjrvy0=
Date:   Fri, 25 Sep 2020 08:58:13 -0400
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] sunrpc: simplify do_cache_clean
Message-ID: <20200925125813.GA1096@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Is it just me, or is the logic written in a slightly convoluted way?

I find it a little easier to read this way.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 net/sunrpc/cache.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 9e68e443f497..2990a7ab9e2a 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -498,16 +498,17 @@ static int cache_clean(void)
  */
 static void do_cache_clean(struct work_struct *work)
 {
-	int delay = 5;
-	if (cache_clean() == -1)
-		delay = round_jiffies_relative(30*HZ);
+	int delay;
 
 	if (list_empty(&cache_list))
-		delay = 0;
+		return;
+
+	if (cache_clean() == -1)
+		delay = round_jiffies_relative(30*HZ);
+	else
+		delay = 5;
 
-	if (delay)
-		queue_delayed_work(system_power_efficient_wq,
-				   &cache_cleaner, delay);
+	queue_delayed_work(system_power_efficient_wq, &cache_cleaner, delay);
 }
 
 
-- 
2.26.2

