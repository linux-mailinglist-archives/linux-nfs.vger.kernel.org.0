Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C0024FFC0
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Aug 2020 16:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgHXOWo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Aug 2020 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXOWn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Aug 2020 10:22:43 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541CAC061573
        for <linux-nfs@vger.kernel.org>; Mon, 24 Aug 2020 07:22:43 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id DF51D7AAC; Mon, 24 Aug 2020 10:22:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DF51D7AAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1598278957;
        bh=5mSq3DvSk1LB4QLR120p24q/zwEfi1g4cz4xExf2sGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BkyOTIJQv3j+ayprYNdR+dWOCHC3KqBmrNSuBqkym6HxdHVD23nU1htT5lmMD/HIL
         /s/n5v6VdBNdkS4B82Iag0hY1G0cnQpSMO658pB+hU1fDMYZvs6pvUT5Bk0bhZMjwP
         2hMXRBjKjj4/LwD+hxTy1h5apGY+59PQeV+bwumk=
Date:   Mon, 24 Aug 2020 10:22:37 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
Message-ID: <20200824142237.GA29837@fieldses.org>
References: <227E18E8-5A45-47E3-981C-549042AFB391@oracle.com>
 <20200810190729.GB13266@fieldses.org>
 <00CAA5B7-418E-4AB5-AE08-FE2F87B06795@oracle.com>
 <20200810201001.GC13266@fieldses.org>
 <CA3288FC-8B9A-4F19-A51C-E1169726E946@oracle.com>
 <F20E4EC5-71DD-4A92-A583-41BEE177F53C@oracle.com>
 <20200817222034.GA6390@fieldses.org>
 <CD4B80B9-4F58-46B4-872C-F2F139AFB231@oracle.com>
 <20200819212927.GB30476@fieldses.org>
 <5D346E9E-C7C5-49F7-9694-8DD98AF1149A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D346E9E-C7C5-49F7-9694-8DD98AF1149A@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 24, 2020 at 09:39:31AM -0400, Chuck Lever wrote:
> 
> 
> > On Aug 19, 2020, at 5:29 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Tue, Aug 18, 2020 at 05:26:26PM -0400, Chuck Lever wrote:
> >> 
> >>> On Aug 17, 2020, at 6:20 PM, Bruce Fields <bfields@fieldses.org> wrote:
> >>> 
> >>> On Sun, Aug 16, 2020 at 04:46:00PM -0400, Chuck Lever wrote:
> >>> 
> >>>> In order of application:
> >>>> 
> >>>> 5920afa3c85f ("nfsd: hook nfsd_commit up to the nfsd_file cache")
> >>>> 961.68user 5252.40system 20:12.30elapsed 512%CPU, 2541 DELAY errors
> >>>> These results are similar to v5.3.
> >>>> 
> >>>> fd4f83fd7dfb ("nfsd: convert nfs4_file->fi_fds array to use nfsd_files")
> >>>> Does not build
> >>>> 
> >>>> eb82dd393744 ("nfsd: convert fi_deleg_file and ls_file fields to nfsd_file")
> >>>> 966.92user 5425.47system 33:52.79elapsed 314%CPU, 1330 DELAY errors
> >>>> 
> >>>> Can you take a look and see if there's anything obvious?
> >>> 
> >>> Unfortunately nothing about the file cache code is very obvious to me.
> >>> I'm looking at it....
> >>> 
> >>> It adds some new nfserr_jukebox returns in nfsd_file_acquire.  Those
> >>> mostly look like kmalloc failures, the one I'm not sure about is the
> >>> NFSD_FILE_HASHED check.
> >>> 
> >>> Or maybe it's the lease break there.
> >> 
> >> nfsd_file_acquire() always calls fh_verify() before it invokes nfsd_open().
> >> Replacing nfs4_get_vfs_file's nfsd_open() call with nfsd_file_acquire() adds
> >> almost 10 million fh_verify() calls to my test run.
> > 
> > Checking out the code as of fd4f83fd7dfb....
> > 
> > nfsd_file_acquire() calls nfsd_open_verified().
> > 
> > And nfsd_open() is basically just fh_verify()+nfsd_open_verified().
> > 
> > So it doesn't look like the replacement of nfsd_open() by
> > nfsd_file_acquire() should have changed the number of fh_verify() calls.
> 
> I see a lot more vfs_setlease() failures after fd4f83fd7dfb.
> check_conflicting_open() fails because "inode is open for write":
> 
> 1780         if (arg == F_RDLCK)
> 1781                 return inode_is_open_for_write(inode) ? -EAGAIN : 0;
> 
> The behavior on the wire is that the server simply doesn't hand out
> many delegations.
> 
> NFSv4 OPEN uses nfsd_file_acquire() now, but I don't see CLOSE
> releasing the cached file descriptor. Wouldn't that cached
> descriptor conflict with subsequent OPENs?

Could be, yes.

That also reminds me of this patch, did I already send it to you?

--b.

commit 055e7b94ef32
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Fri Jul 17 18:54:54 2020 -0400

    nfsd: Cache R, RW, and W opens separately
    
    The nfsd open code has always kept separate read-only, read-write, and
    write-only opens as necessary to ensure that when a client closes or
    downgrades, we don't retain more access than necessary.
    
    Honestly, I'm not sure if that's completely necessary, but I'd rather
    stick to that behavior.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 82198d747c4c..4b6f70e0d987 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -891,7 +891,7 @@ nfsd_file_find_locked(struct inode *inode, unsigned int may_flags,
 
 	hlist_for_each_entry_rcu(nf, &nfsd_file_hashtbl[hashval].nfb_head,
 				 nf_node, lockdep_is_held(&nfsd_file_hashtbl[hashval].nfb_lock)) {
-		if ((need & nf->nf_may) != need)
+		if (nf->nf_may != need)
 			continue;
 		if (nf->nf_inode != inode)
 			continue;
