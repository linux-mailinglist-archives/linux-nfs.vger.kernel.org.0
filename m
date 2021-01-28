Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DE830812E
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jan 2021 23:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhA1WhX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 17:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhA1WhT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jan 2021 17:37:19 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321E3C061574
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jan 2021 14:36:39 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1F3BE4599; Thu, 28 Jan 2021 17:36:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1F3BE4599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611873398;
        bh=OYg2VGbTwljuLBa9YVX5iDbBvqHFXoQusva4QGv5tus=;
        h=Date:To:Cc:Subject:From:From;
        b=hLWBDIhhoEqf++TD7+M2XeVJu81wkhBkd51aOC9DY/HBbL0kd5Jqj+tJinPkZLgru
         QOd/++n7SZ8VvDMi9hgV3FbayazhRi4O16pn0x+GpKZarZG5m6F8OEp0lpfuaD8X0f
         ZgUW8nnVqn31BygbkCt8mMWfBwWNeetxLcnvLQ6o=
Date:   Thu, 28 Jan 2021 17:36:38 -0500
To:     Anna Schumaker <schumakeranna@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: we don't support removing system.nfs4_acl
Message-ID: <20210128223638.GE29887@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

The NFSv4 protocol doesn't have any notion of reomoving an attribute, so
removexattr(path,"system.nfs4_acl") doesn't make sense.

There's no documented return value.  Arguably it could be EOPNOTSUPP but
I'm a little worried an application might take that to mean that we
don't support ACLs or xattrs.  How about EINVAL?

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfs/nfs4proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2f4679a62712..d50dea5f5723 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5895,6 +5895,9 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t bufl
 	unsigned int npages = DIV_ROUND_UP(buflen, PAGE_SIZE);
 	int ret, i;
 
+	/* You can't remove system.nfs4_acl: */
+	if (buflen == 0)
+		return -EINVAL;
 	if (!nfs4_server_supports_acls(server))
 		return -EOPNOTSUPP;
 	if (npages > ARRAY_SIZE(pages))
-- 
2.29.2

