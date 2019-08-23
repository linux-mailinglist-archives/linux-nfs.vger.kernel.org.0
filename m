Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4AF9AAF2
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2019 11:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389598AbfHWI7t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Aug 2019 04:59:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732254AbfHWI7t (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 23 Aug 2019 04:59:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47EAB3C928;
        Fri, 23 Aug 2019 08:59:49 +0000 (UTC)
Received: from localhost (dhcp-12-152.nay.redhat.com [10.66.12.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6D2460E1C;
        Fri, 23 Aug 2019 08:59:48 +0000 (UTC)
From:   Yongcheng Yang <yongcheng.yang@gmail.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, plambri@redhat.com,
        Yongcheng Yang <yongcheng.yang@gmail.com>
Subject: [nfs-utils PATCH] gssd: add configure options verbosity to man page rpc.gssd(8)
Date:   Fri, 23 Aug 2019 16:59:45 +0800
Message-Id: <20190823085945.14465-1-yongcheng.yang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 23 Aug 2019 08:59:49 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Pierguido Lambri <plambri@redhat.com>
Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
---
 utils/gssd/gssd.man | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
index e620f0d1..cc3a210a 100644
--- a/utils/gssd/gssd.man
+++ b/utils/gssd/gssd.man
@@ -305,6 +305,14 @@ section of the
 .I /etc/nfs.conf
 configuration file.  Values recognized include:
 .TP
+.B verbosity
+Value which is equivalent to the number of
+.BR -v .
+.TP
+.B rpc-verbosity
+Value which is equivalent to the number of
+.BR -r .
+.TP
 .B use-memcache
 A Boolean flag equivalent to
 .BR -M .
-- 
2.20.1

