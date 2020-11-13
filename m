Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA542B2882
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 23:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgKMW0C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 17:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMW0C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 17:26:02 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED459C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 14:26:01 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E2747BC8; Fri, 13 Nov 2020 17:26:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E2747BC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1605306360;
        bh=hMeP0skOVg0AJwg/0m7ZFv4bsiMgQXseCzoFBQYwqU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cv9DO2rr5OyUhbjKd31K93ZZ4kdllOLZtjrDjjbGyK/WzoXCFcMleJ9pS3v4q8NZW
         mMPzIBHIrNYtoII1px9RYZTWM4gP03YDGXmLjdCrTXzLZhriGTAYdv+gajrTMevn48
         lqP6KmkL2l8Poma2P7Gndz8Wl7gSzZHqDI2RcOfE=
Date:   Fri, 13 Nov 2020 17:26:00 -0500
From:   bfields <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201113222600.GC1299@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
 <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com>
 <20201109160256.GB11144@fieldses.org>
 <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
 <20201112135733.GA9243@fieldses.org>
 <444227972.86442677.1605206025305.JavaMail.zimbra@dneg.com>
 <20201112205524.GI9243@fieldses.org>
 <883314904.86570901.1605222357023.JavaMail.zimbra@dneg.com>
 <20201113145050.GB1299@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113145050.GB1299@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 13, 2020 at 09:50:50AM -0500, bfields wrote:
> On Thu, Nov 12, 2020 at 11:05:57PM +0000, Daire Byrne wrote:
> > So, I can't lay claim to identifying the exact optimisation/hack that
> > improves the retention of the re-export server's client cache when
> > re-exporting an NFSv3 server (which is then read by many clients). We
> > were working with an engineer at the time who showed an interest in
> > our use case and after we supplied a reproducer he suggested modifying
> > the nfs/inode.c
> > 
> > -		if (!inode_eq_iversion_raw(inode, fattr->change_attr)) {
> > +		if (inode_peek_iversion_raw(inode) < fattr->change_attr)
> > {
> > 
> > His reasoning at the time was:
> > 
> > "Fixes inode invalidation caused by read access. The least important
> > bit is ORed with 1 and causes the inode version to differ from the one
> > seen on the NFS share. This in turn causes unnecessary re-download
> > impacting the performance significantly. This fix makes it only
> > re-fetch file content if inode version seen on the server is newer
> > than the one on the client."
> > 
> > But I've always been puzzled by why this only seems to be the case
> > when using knfsd to re-export the (NFSv3) client mount. Using multiple
> > processes on a standard client mount never causes any similar
> > re-validations. And this happens with a completely read-only share
> > which is why I started to think it has something to do with atimes as
> > that could perhaps still cause a "write" modification even when
> > read-only?
> 
> Ah-hah!  So, it's inode_query_iversion() that's modifying a nfs inode's
> i_version.  That's a special thing that only nfsd would do.
> 
> I think that's totally fixable, we'll just have to think a little about
> how....

I wonder if something like this helps?--b.

commit 0add88a9ccc5
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Fri Nov 13 17:03:04 2020 -0500

    nfs: don't mangle i_version on NFS
    
    The i_version on NFS has pretty much opaque to the client, so we don't
    want to give the low bit any special interpretation.
    
    Define a new FS_PRIVATE_I_VERSION flag for filesystems that manage the
    i_version on their own.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 29ec8b09a52d..9b8dd5b713a7 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1488,7 +1488,8 @@ struct file_system_type nfs_fs_type = {
 	.init_fs_context	= nfs_init_fs_context,
 	.parameters		= nfs_fs_parameters,
 	.kill_sb		= nfs_kill_super,
-	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
+				  FS_PRIVATE_I_VERSION,
 };
 MODULE_ALIAS_FS("nfs");
 EXPORT_SYMBOL_GPL(nfs_fs_type);
@@ -1500,7 +1501,8 @@ struct file_system_type nfs4_fs_type = {
 	.init_fs_context	= nfs_init_fs_context,
 	.parameters		= nfs_fs_parameters,
 	.kill_sb		= nfs_kill_super,
-	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
+				  FS_PRIVATE_I_VERSION,
 };
 MODULE_ALIAS_FS("nfs4");
 MODULE_ALIAS("nfs4");
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21cc971fd960..c5bb4268228b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2217,6 +2217,7 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
+#define FS_PRIVATE_I_VERSION	32	/* i_version managed by filesystem */
 #define FS_THP_SUPPORT		8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index 2917ef990d43..52c790a847de 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -307,6 +307,8 @@ inode_query_iversion(struct inode *inode)
 	u64 cur, old, new;
 
 	cur = inode_peek_iversion_raw(inode);
+	if (inode->i_sb->s_type->fs_flags & FS_PRIVATE_I_VERSION)
+		return cur;
 	for (;;) {
 		/* If flag is already set, then no need to swap */
 		if (cur & I_VERSION_QUERIED) {
