Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91822CCA1F
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Dec 2020 23:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgLBW52 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Dec 2020 17:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgLBW51 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Dec 2020 17:57:27 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E16CC0617A6
        for <linux-nfs@vger.kernel.org>; Wed,  2 Dec 2020 14:56:47 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 3A92FBC8; Wed,  2 Dec 2020 17:56:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 3A92FBC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606949806;
        bh=4NzDPZA4mXxMik1ooI5NvPahkHk1d62zw4FBvIR/aTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/5j/iw5TQnkfcTvYGHNSy2td8yNVDnOzaPvqX3SXoJDgso41SeeZexTzOhgs9qPL
         zeXzZBu/+xUGgDgg+pGJsc5V8E+pboklWs7HSvUee0OrUlyO/V8UL6aHs3GHgXp1YV
         dwLeFexDnj42DCZ0H12uMBWrcwr7y4jpVirLEPlM=
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/2] mountd: always root squash on the pseudofs
Date:   Wed,  2 Dec 2020 17:56:44 -0500
Message-Id: <1606949804-31417-2-git-send-email-bfields@fieldses.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1606949804-31417-1-git-send-email-bfields@fieldses.org>
References: <1606949804-31417-1-git-send-email-bfields@fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

As with security flavors and "secure" ports, we tried to code this so
that pseudofs directories would inherit root squashing from their
children, but it doesn't really work as coded and I'm not sure it's
useful.

Just root squash always.  If it turns out somebody's exporting
directories that are only readable by root, I guess we can try to do
something else here, but frankly that sounds like a pretty weird
configuration.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 utils/mountd/v4root.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/utils/mountd/v4root.c b/utils/mountd/v4root.c
index 2ac4e87898c0..36543401f296 100644
--- a/utils/mountd/v4root.c
+++ b/utils/mountd/v4root.c
@@ -60,8 +60,6 @@ set_pseudofs_security(struct exportent *pseudo, int flags)
 	struct flav_info *flav;
 	int i;
 
-	if ((flags & NFSEXP_ROOTSQUASH) == 0)
-		pseudo->e_flags &= ~NFSEXP_ROOTSQUASH;
 	for (flav = flav_map; flav < flav_map + flav_map_size; flav++) {
 		struct sec_entry *new;
 
-- 
2.28.0

