Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEBD254A39
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Aug 2020 18:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgH0QIK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Aug 2020 12:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgH0QIH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Aug 2020 12:08:07 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86702C06121B
        for <linux-nfs@vger.kernel.org>; Thu, 27 Aug 2020 09:08:07 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E5FF86EEB; Thu, 27 Aug 2020 12:08:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E5FF86EEB
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/2] Documentation: update RPCSEC_GSSv3 RFC link
Date:   Thu, 27 Aug 2020 12:08:03 -0400
Message-Id: <1598544483-14296-2-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598544483-14296-1-git-send-email-bfields@redhat.com>
References: <1598544483-14296-1-git-send-email-bfields@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

This draft is an official RFC now.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 Documentation/filesystems/nfs/rpc-server-gss.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/nfs/rpc-server-gss.rst b/Documentation/filesystems/nfs/rpc-server-gss.rst
index abed4a2b1b82..ccaea9e7cea2 100644
--- a/Documentation/filesystems/nfs/rpc-server-gss.rst
+++ b/Documentation/filesystems/nfs/rpc-server-gss.rst
@@ -13,10 +13,9 @@ RPCGSS is specified in a few IETF documents:
  - RFC2203 v1: https://tools.ietf.org/rfc/rfc2203.txt
  - RFC5403 v2: https://tools.ietf.org/rfc/rfc5403.txt
 
-and there is a 3rd version  being proposed:
+There is a third version that we don't currently implement:
 
- - https://tools.ietf.org/id/draft-williams-rpcsecgssv3.txt
-   (At draft n. 02 at the time of writing)
+ - RFC7861 v3: https://tools.ietf.org/rfc/rfc7861.txt
 
 Background
 ==========
-- 
2.26.2

