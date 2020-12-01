Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5995F2CACAB
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 20:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392341AbgLATrF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 14:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbgLATrF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 14:47:05 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53989C0613D4
        for <linux-nfs@vger.kernel.org>; Tue,  1 Dec 2020 11:46:25 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 954D46F4C; Tue,  1 Dec 2020 14:46:23 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 954D46F4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606851983;
        bh=A8EOWggx0zXT+n9wTWwAKAvzUaiisph2+7LlHQsB3wQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e6Iju4Xwfmi8QeVIXYi9T3K+MU4/E3OsEwF1fiMLOuj8qotw4xVI0d2rQnU1dkpRg
         o8/0eRsPDjqyQ3dIWJ2rSMPy7qy/+8RThOC5/eiFRItvb21iVRIVxsbAbAmgO8QjoN
         JUItwGPRbCWq+TQW3Rxjuu5HwXdsRUtNXnBS6sYI=
Date:   Tue, 1 Dec 2020 14:46:23 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     trondmy@kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Message-ID: <20201201194623.GB21355@fieldses.org>
References: <20201130212455.254469-1-trondmy@kernel.org>
 <20201130212455.254469-2-trondmy@kernel.org>
 <20201130225842.GA22446@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130225842.GA22446@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 30, 2020 at 05:58:42PM -0500, J. Bruce Fields wrote:
> This is great, thanks:
> 
> On Mon, Nov 30, 2020 at 04:24:50PM -0500, trondmy@kernel.org wrote:
> > From: Jeff Layton <jeff.layton@primarydata.com>
> > 
> > With NFSv3 nfsd will always attempt to send along WCC data to the
> > client. This generally involves saving off the in-core inode information
> > prior to doing the operation on the given filehandle, and then issuing a
> > vfs_getattr to it after the op.
> > 
> > Some filesystems (particularly clustered or networked ones) have an
> > expensive ->getattr inode operation. Atomicitiy is also often difficult
> > or impossible to guarantee on such filesystems. For those, we're best
> > off not trying to provide WCC information to the client at all, and to
> > simply allow it to poll for that information as needed with a GETATTR
> > RPC.
> > 
> > This patch adds a new flags field to struct export_operations, and
> > defines a new EXPORT_OP_NOWCC flag that filesystems can use to indicate
> > that nfsd should not attempt to provide WCC info in NFSv3 replies. It
> > also adds a blurb about the new flags field and flag to the exporting
> > documentation.
> 
> In the v4 case I think it should also turn off the "atomic" flag in the
> change_info4 structure that's returned by some operations.

And then it looks to me like all you need is something like the
following, no need for a fh_no_wcc field or anything, just skip the
stuff you don't want in fill_post_wcc when the flag is set:

--b.

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index bd4edf904bba..0b51f9dd0752 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -289,13 +289,16 @@ void fill_post_wcc(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
 	struct inode *inode = d_inode(fhp->fh_dentry);
+	struct export_operations *ops = inode->i_sb->s_export_op;
 
 	if (fhp->fh_post_saved)
 		printk("nfsd: inode locked twice during operation.\n");
 
 	fhp->fh_post_saved = true;
 
-	if (!v4 || !inode->i_sb->s_export_op->fetch_iversion) {
+	if (ops->flags & EXPORT_OP_NOWCC)
+		fhp->fh_post_saved = false;
+	else if (!v4 || !ops->fetch_iversion) {
 		__be32 err = fh_getattr(fhp, &fhp->fh_post_attr);
 		if (err) {
 			fhp->fh_post_saved = false;
