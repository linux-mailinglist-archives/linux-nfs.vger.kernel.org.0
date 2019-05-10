Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC731A4F9
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2019 23:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfEJVys (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 May 2019 17:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfEJVys (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 10 May 2019 17:54:48 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DEDE217D6;
        Fri, 10 May 2019 21:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557525287;
        bh=OlL2+v8U1rTwUryIIhYhCqJpysGNxtNHY09Fq/O9t74=;
        h=From:To:Cc:Subject:Date:From;
        b=eYUM6pqOPCLapV1ItJQzqJ8LffhgN/N4pizwCd4w7L2S+lSGBXP6iJKprYgMaE15R
         OUlfjdPfcYDT6dFIeKU1+AEYrmVWOGgHZ7uZf2EUmbn/C6eEs4SwD3EQbofkFczfs0
         9wRCnyFzUU7KdSHgLQ4k1yJ9Vj/Qo68jV9bMnei0=
From:   Jeff Layton <jlayton@kernel.org>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org, jfajerski@suse.com
Subject: [PATCH] manpage: explain why showmount doesn't really work against a v4-only server
Date:   Fri, 10 May 2019 17:54:45 -0400
Message-Id: <20190510215445.1823-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

I occasionally see people that expect valid info when running showmount
against a server that may export some or all filesystems via NFSv4.
Let's make it clear that it only works by talking to the remote MNT
service, and that that may not be available from a v4-only server.

Cc: Jan Fajerski <jfajerski@suse.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 utils/showmount/showmount.man | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/utils/showmount/showmount.man b/utils/showmount/showmount.man
index a2f510fb5617..35818e1b61c5 100644
--- a/utils/showmount/showmount.man
+++ b/utils/showmount/showmount.man
@@ -56,5 +56,10 @@ Because
 .B showmount
 sorts and uniqs the output, it is impossible to determine from
 the output whether a client is mounting the same directory more than once.
+.P
+.B showmount
+works by contacting the server's MNT service directly. NFSv4-only servers have
+no need to advertise their exported root filehandles via this method, and may
+not expose their MNT service to clients.
 .SH AUTHOR
 Rick Sladkey <jrs@world.std.com>
-- 
2.21.0

