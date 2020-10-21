Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71CF294EB9
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Oct 2020 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443542AbgJUOeQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Oct 2020 10:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443539AbgJUOeQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Oct 2020 10:34:16 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC20C0613CE
        for <linux-nfs@vger.kernel.org>; Wed, 21 Oct 2020 07:34:16 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id F1CE51C81; Wed, 21 Oct 2020 10:34:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org F1CE51C81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1603290856;
        bh=vYsuBQdMbxYyWVXhHeP/ieHFJkCaobM4EKgUs9xY+eI=;
        h=Date:To:Cc:Subject:From:From;
        b=qCH/JwZk9fP7vdBqts73EMBddwqvic0XwoFWs+TyP2ArwCbSJxSyd200Rt4ezL7ib
         MygJdV9gXjOSABGNIV2YRzD3EsVuKA+BBl/efftce0+6Z7E79cP8YibTFhDZAIS8Z7
         69Gx8CM8Wd5wm1kxmPrSh7KY+zzB+wl8cKf+ayRE=
Date:   Wed, 21 Oct 2020 10:34:15 -0400
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4.2: fix failure to unregister shrinker
Message-ID: <20201021143415.GA27122@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

We forgot to unregister the nfs4_xattr_large_entry_shrinker.

That leaves the global list of shrinkers corrupted after unload of the
nfs module, after which possibly unrelated code that calls
register_shrinker() or unregister_shrinker() gets a BUG() with
"supervisor write access in kernel mode".

And similarly for the nfs4_xattr_large_entry_lru.

Reported-by: Kris Karas <bugs-a17@moonlit-rail.com>
Tested-By: Kris Karas <bugs-a17@moonlit-rail.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfs/nfs42xattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 86777996cfec..55b44a42d625 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -1048,8 +1048,10 @@ int __init nfs4_xattr_cache_init(void)
 
 void nfs4_xattr_cache_exit(void)
 {
+	unregister_shrinker(&nfs4_xattr_large_entry_shrinker);
 	unregister_shrinker(&nfs4_xattr_entry_shrinker);
 	unregister_shrinker(&nfs4_xattr_cache_shrinker);
+	list_lru_destroy(&nfs4_xattr_large_entry_lru);
 	list_lru_destroy(&nfs4_xattr_entry_lru);
 	list_lru_destroy(&nfs4_xattr_cache_lru);
 	kmem_cache_destroy(nfs4_xattr_cache_cachep);
-- 
2.26.2

