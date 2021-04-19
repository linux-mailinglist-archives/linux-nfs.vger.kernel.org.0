Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F32364ACC
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 21:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbhDSTxu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 15:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241901AbhDSTxq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Apr 2021 15:53:46 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D351C06174A
        for <linux-nfs@vger.kernel.org>; Mon, 19 Apr 2021 12:53:16 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 65F75727A; Mon, 19 Apr 2021 15:53:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 65F75727A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1618861995;
        bh=5FYAyZiBPK3xk5cQbamaTf/Lu71MX1K7VtgeM2lJ750=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=zhh617qFtbdSnfEweo7YCMc7VnnxhWJGaJNQgiIOv0pxmO+vWv08il8sefbonpYht
         ZyhuPfgkMzxUNK/Eb5bj1hnrnPWY8hHrMEHhj2suwQkOzQXZQFDS7jvEEksfntHc70
         MUSXAF26VLuRxTOGQR2/AFIZLxPNpatkz22TzqW8=
Date:   Mon, 19 Apr 2021 15:53:15 -0400
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/5] nfsd: hash nfs4_files by inode number
Message-ID: <20210419195315.GA17661@fieldses.org>
References: <1618596018-9899-1-git-send-email-bfields@redhat.com>
 <1618596018-9899-2-git-send-email-bfields@redhat.com>
 <7342A4CD-0B93-4C13-AD32-4DADC26CD8ED@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7342A4CD-0B93-4C13-AD32-4DADC26CD8ED@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 16, 2021 at 07:21:16PM +0000, Chuck Lever III wrote:
> 
> 
> > On Apr 16, 2021, at 2:00 PM, J. Bruce Fields <bfields@redhat.com> wrote:
> > 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > The nfs4_file structure is per-filehandle, not per-inode, because the
> > spec requires open and other state to be per filehandle.
> > 
> > But it will turn out to be convenient for nfs4_files associated with the
> > same inode to be hashed to the same bucket, so let's hash on the inode
> > instead of the filehandle.
> > 
> > Filehandle aliasing is rare, so that shouldn't have much performance
> > impact.
> > 
> > (If you have a ton of exported filesystems, though, and all of them have
> > a root with inode number 2, could that get you an overlong has chain?
> 
> ^has ^hash
> 
> Also, I'm getting this new warning:
> 
> /home/cel/src/linux/linux/include/linux/hash.h:81:38: warning: shift too big (4294967104) for type unsigned long long

Whoops; it needs this: would you like me to resend?--b.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b0c74dbde07b..47a76284b47c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -547,7 +547,7 @@ static unsigned int file_hashval(struct svc_fh *fh)
 	struct inode *inode = d_inode(fh->fh_dentry);
 
 	/* XXX: why not (here & in file cache) use inode? */
-	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_SIZE);
+	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
 }
 
 static struct hlist_head file_hashtbl[FILE_HASH_SIZE];

