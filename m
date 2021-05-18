Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3413387F7A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 20:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344389AbhERSWf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 14:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245506AbhERSWe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 14:22:34 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4041EC061573
        for <linux-nfs@vger.kernel.org>; Tue, 18 May 2021 11:21:16 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1688C64B9; Tue, 18 May 2021 14:21:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1688C64B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1621362075;
        bh=eDZ5wijqSsSeETdzDqG2bQWmCJjMFwhiJ2aNURILkjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSnQ6lCQDcVnjwpekBKIKvlfhoTLk513jTU4K4vAL6hZKsPYTkk+cbrzYUz4hDXqU
         Ja8XX9ZvZbvB/fD/2n1bL/ZOpjuHE/aqgsmQoI9ZeDnX7EX+SykYAF4oqj2asr8ZlT
         S037iWBEbNPvPf5jSFWXY5KaSSGt15IRgNppjW4A=
Date:   Tue, 18 May 2021 14:21:15 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "robbieko@synology.com" <robbieko@synology.com>,
        "bingjingc@synology.com" <bingjingc@synology.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nickhuang@synology.com" <nickhuang@synology.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH] nfsd: Prevent truncation of an unlinked inode from
 blocking access to its directory
Message-ID: <20210518182115.GB26957@fieldses.org>
References: <20210514035829.5230-1-nickhuang@synology.com>
 <00195ec8bf1752306f549540eed74c3938c5e312.camel@hammerspace.com>
 <YJ9yD1S6Yl2m0gOO@infradead.org>
 <4387867bd64c5d3d8c67830a633b90e4a7e1ba38.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4387867bd64c5d3d8c67830a633b90e4a7e1ba38.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 18, 2021 at 05:53:47PM +0000, Trond Myklebust wrote:
> On Sat, 2021-05-15 at 08:02 +0100, Christoph Hellwig wrote:
> > On Fri, May 14, 2021 at 03:46:57PM +0000, Trond Myklebust wrote:
> > > Why leave the commit_metadata() call under the lock? If you're
> > > concerned about latency, then it makes more sense to call
> > > fh_unlock()
> > > before flushing those metadata updates to disk.
> > 
> > Also I'm not sure why the extra inode reference is needed.  What
> > speaks
> > against just moving the dput out of the locked section?
> 
> Isn't the inode reference taken just in order to ensure that the call
> to iput_final() (and in particular the call to
> truncate_inode_pages_final()) is performed outside the lock?
> 
> The dput() is presumably usually not particularly expensive, since the
> dentry is just a completely ordinary negative dentry at this point.

Right, but why bother with the extra ihold/iput instead of just
postponing the dput?

diff --git a/fs/namei.c b/fs/namei.c
index 79b0ff9b151e..aeed93c9874c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4084,7 +4084,6 @@ long do_unlinkat(int dfd, struct filename *name)
 		inode = dentry->d_inode;
 		if (d_is_negative(dentry))
 			goto slashes;
-		ihold(inode);
 		error = security_path_unlink(&path, dentry);
 		if (error)
 			goto exit2;
@@ -4092,11 +4091,10 @@ long do_unlinkat(int dfd, struct filename *name)
 		error = vfs_unlink(mnt_userns, path.dentry->d_inode, dentry,
 				   &delegated_inode);
 exit2:
-		dput(dentry);
 	}
 	inode_unlock(path.dentry->d_inode);
-	if (inode)
-		iput(inode);	/* truncate the inode here */
+	if (!IS_ERR(dentry))
+		dput(dentry);	/* truncate the inode here */
 	inode = NULL;
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);

?

--b.
