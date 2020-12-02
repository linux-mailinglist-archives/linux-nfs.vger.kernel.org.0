Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34102CCA3C
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 00:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgLBXEZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Dec 2020 18:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgLBXEY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Dec 2020 18:04:24 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F6FC0617A6
        for <linux-nfs@vger.kernel.org>; Wed,  2 Dec 2020 15:03:44 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id DC4E16F4B; Wed,  2 Dec 2020 18:03:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DC4E16F4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606950222;
        bh=BGYYI0dix7aaYcTj94e1Pfh1EJXZvap34bYc1btok5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MtktlmBM+qqLEooXejBs2dOtsk/5dsFmpdYnWDBj/FY/XtjBAoH6U6rv1f5I/21A3
         tCj9t4CtzOIoRiHJQGp9wJ5f4GJhKraIym/Qlg4N/4r+TI4F6EWpJME4NEhsGUgJDM
         yVmnWkkM6gGfaggX9ZVDB0NKAjQCqyvEYQVbfyUc=
Date:   Wed, 2 Dec 2020 18:03:42 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: Re: [PATCH 1/2] mountd: allow high ports on all pseudofs exports
Message-ID: <20201202230342.GA31481@fieldses.org>
References: <1606949804-31417-1-git-send-email-bfields@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606949804-31417-1-git-send-email-bfields@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 02, 2020 at 05:56:43PM -0500, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> We originally tried to grant permissions on the v4 pseudoroot filesystem
> that were the absolute minimum required for a client to reach a given
> export.  This turns out to be complicated, and we've never gotten it
> quite right.  Also, the tradition from the MNT protocol was to allow
> anyone to browse the list of exports.
> 
> So, do as we already did with security flavors and just allow clients
> from high ports to access the whole pseudofilesystem.

Oh, except then we may as well also remove this "flags" parameter.

--b.

diff --git a/utils/mountd/v4root.c b/utils/mountd/v4root.c
index 36543401f296..f6eb126660f3 100644
--- a/utils/mountd/v4root.c
+++ b/utils/mountd/v4root.c
@@ -55,7 +55,7 @@ static nfs_export pseudo_root = {
 };
 
 static void
-set_pseudofs_security(struct exportent *pseudo, int flags)
+set_pseudofs_security(struct exportent *pseudo)
 {
 	struct flav_info *flav;
 	int i;
@@ -85,7 +85,7 @@ v4root_create(char *path, nfs_export *export)
 	strncpy(eep.e_path, path, sizeof(eep.e_path)-1);
 	if (strcmp(path, "/") != 0)
 		eep.e_flags &= ~NFSEXP_FSID;
-	set_pseudofs_security(&eep, curexp->e_flags);
+	set_pseudofs_security(&eep);
 	exp = export_create(&eep, 0);
 	if (exp == NULL)
 		return NULL;
@@ -133,7 +133,7 @@ pseudofs_update(char *hostname, char *path, nfs_export *source)
 		return 0;
 	}
 	/* Update an existing V4ROOT export: */
-	set_pseudofs_security(&exp->m_export, source->m_export.e_flags);
+	set_pseudofs_security(&exp->m_export);
 	return 0;
 }
 
