Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B468E2CCB7D
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 02:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgLCBPt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Dec 2020 20:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgLCBPt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Dec 2020 20:15:49 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57384C0613D6
        for <linux-nfs@vger.kernel.org>; Wed,  2 Dec 2020 17:15:09 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id EFE041BE7; Wed,  2 Dec 2020 20:15:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EFE041BE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606958101;
        bh=6Bi9Zq0zZLKu28AxyDSGdjngTwfi3CSIqfmJUr5KNqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZkR3XsScig5HR+HgK5DHKtHAI0FJ3yYvZ1v+1FIJjDrKQ09lQfnJRqJjAav7dz9P
         PF2YwEA1iG2dzzVwpweFfTwn8a2BJyF60fyKxFlCTfZsddYlMGdmsbAYZ+RoL1PNEw
         R770Jl8KlhFJGEp0yCZor1LC5+AWdFWWEIvYDEAw=
From:   bfields@fieldses.org
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/2] mountd: never root squash on the pseudofs
Date:   Wed,  2 Dec 2020 20:14:57 -0500
Message-Id: <1606958097-9041-2-git-send-email-bfields@fieldses.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1606958097-9041-1-git-send-email-bfields@fieldses.org>
References: <20201203010546.GB348347@pick.fieldses.org>
 <1606958097-9041-1-git-send-email-bfields@fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

As with security flavors and "secure" ports, we tried to code this so
that pseudofs directories would inherit root squashing from their
children, but it doesn't really work as coded and I'm not sure it's
useful.

Let's just not root squash.  The risk is pretty low since the pseudofs
is readonly, and we'd rather not risk failing a mount unnecessarily.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 utils/mountd/v4root.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/utils/mountd/v4root.c b/utils/mountd/v4root.c
index 39dd87a94e59..c42ba72380ea 100644
--- a/utils/mountd/v4root.c
+++ b/utils/mountd/v4root.c
@@ -34,7 +34,7 @@ static nfs_export pseudo_root = {
 	.m_export = {
 		.e_hostname = "*",
 		.e_path = "/",
-		.e_flags = NFSEXP_READONLY | NFSEXP_ROOTSQUASH
+		.e_flags = NFSEXP_READONLY
 				| NFSEXP_NOSUBTREECHECK | NFSEXP_FSID
 				| NFSEXP_V4ROOT | NFSEXP_INSECURE_PORT,
 		.e_anonuid = 65534,
@@ -60,8 +60,6 @@ set_pseudofs_security(struct exportent *pseudo)
 	struct flav_info *flav;
 	int i;
 
-	if ((flags & NFSEXP_ROOTSQUASH) == 0)
-		pseudo->e_flags &= ~NFSEXP_ROOTSQUASH;
 	for (flav = flav_map; flav < flav_map + flav_map_size; flav++) {
 		struct sec_entry *new;
 
-- 
2.28.0

