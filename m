Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3642218C02D
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 20:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCSTQf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 15:16:35 -0400
Received: from fieldses.org ([173.255.197.46]:47020 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgCSTQf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Mar 2020 15:16:35 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 1DA1420AE; Thu, 19 Mar 2020 15:16:34 -0400 (EDT)
Date:   Thu, 19 Mar 2020 15:16:34 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsd(7): minimal /proc/fs/nfsd/clients/ documentation
Message-ID: <20200319191634.GC2624@fieldses.org>
References: <20200319191532.GB2624@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319191532.GB2624@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

We should really say more, but this is at least a starting point.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 utils/exportfs/nfsd.man | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/utils/exportfs/nfsd.man b/utils/exportfs/nfsd.man
index 1392f3926053..514153f024fa 100644
--- a/utils/exportfs/nfsd.man
+++ b/utils/exportfs/nfsd.man
@@ -81,6 +81,16 @@ for that path as exported to the given client.  The filehandle's length
 will be at most the number of bytes given.
 
 The filehandle will be represented in hex with a leading '\ex'.
+
+.TP
+.B clients/
+This directory contains a subdirectory for each NFSv4 client.  Each file
+under that subdirectory gives some details about the client in YAML
+format.  In addition, writing "expire\\n" to the
+.B ctl
+file will force the server to immediately revoke all state held by that
+client.
+
 .PP
 The directory
 .B /proc/net/rpc
-- 
2.25.1

