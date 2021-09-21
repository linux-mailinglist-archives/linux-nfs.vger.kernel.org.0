Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA94136DF
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Sep 2021 18:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhIUQCS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Sep 2021 12:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhIUQCA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Sep 2021 12:02:00 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB69C061575
        for <linux-nfs@vger.kernel.org>; Tue, 21 Sep 2021 09:00:31 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7A2AE7027; Tue, 21 Sep 2021 12:00:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7A2AE7027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632240030;
        bh=YV65ku4X7Jk7aAFKb7wEWlTcnAiyfZMqNNmP/+OXEpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2bZHZhZ2A1JgMGp0DQ4M195rmnFH9x/4JB1cOX67KvSqOCKRVkaoDqJiQvjNIwqD
         WQX8PG3qAS/oN8q61l9WbrlJ/FJasHitpEn5Sq4OacvK81gmw9OnZDk+paXkUqDqPJ
         SIuBYT8yghsHt1+7Ca5zxKLuYmd26YWVPBAB1/DY=
Date:   Tue, 21 Sep 2021 12:00:30 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: reexport documentation
Message-ID: <20210921160030.GC21704@fieldses.org>
References: <20210921143259.GB21704@fieldses.org>
 <37851433-48C9-4585-9B68-834474AA6E06@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37851433-48C9-4585-9B68-834474AA6E06@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 21, 2021 at 02:39:39PM +0000, Chuck Lever III wrote:
> > On Sep 21, 2021, at 10:32 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > +It is possible to reexport an NFS filesystem over NFS.  However, this
> > +feature comes with a number of limitations.  Before trying it, we
> > +recommend some careful research to determine wether it will work for
> > +your purposes.
> 
> ^wether^whether

Fixed.

> > +
> > +A discussion of current known limitations follows.
> > +
> > +"fsid=" required, crossmnt broken
> > +---------------------------------
> > +
> > +We require the "fsid=" export option on any reexport of an NFS
> > +filesystem.
> 
> Recommended approach? I would just say use 'uuidgen -r'

Looking at the manual.... I'd somehow missed that fsid= would take a
uuid (and not just a small integer) now.  So, sure, I'll add that as a
suggestion.

Longer term I wonder if it would work to do this automatically for new
nfs reexports.  The annoying part is you'd have to keep the fsid=
argument on disk somehow, either by modifying the export configuration
in /etc or by keeping them on the side somewhere.  That'd fix crossmnt
too.

> > +The "crossmnt" export option does not work in the reexport case.
> 
> Can you expand on this a little? Consequences? Risks?

crossmnt doesn't propagate fsid= (for obvious reasons), so if you cross
into another nfs filesystem then it'll fail.

Actually if you just had disk filesystems mounted underneath it'd
probably work.

> > +Reboot recovery
> > +---------------
> > +
> > +The NFS protocol's normal reboot recovery mechanisms don't work for the
> > +case when the reexport server reboots.  Clients will lose any locks
> > +they held before the reboot, and further IO will result in errors.
> > +Closing and reopening files should clear the errors.
> 
> Any recommended workarounds? Or does this simply mean that
> administrators need to notify client users to unmount (or
> at least stop their workloads) before rebooting the proxy?

I think so.

If you don't use any file locking or delegations I suppose you're also
OK.  Delegations might be useful, though.

I'd expect reexport to be useful mainly for data that changes very
rarely, if that helps.

--b.

diff --git a/Documentation/filesystems/nfs/reexport.rst b/Documentation/filesystems/nfs/reexport.rst
index 892cb1e9c45c..ff9ae4a46530 100644
--- a/Documentation/filesystems/nfs/reexport.rst
+++ b/Documentation/filesystems/nfs/reexport.rst
@@ -6,7 +6,7 @@ Overview
 
 It is possible to reexport an NFS filesystem over NFS.  However, this
 feature comes with a number of limitations.  Before trying it, we
-recommend some careful research to determine wether it will work for
+recommend some careful research to determine whether it will work for
 your purposes.
 
 A discussion of current known limitations follows.
@@ -15,9 +15,12 @@ A discussion of current known limitations follows.
 ---------------------------------
 
 We require the "fsid=" export option on any reexport of an NFS
-filesystem.
+filesystem.  You can use "uuidgen -r" to generate a unique argument.
 
-The "crossmnt" export option does not work in the reexport case.
+The "crossmnt" export does not propagate "fsid=", so it will not allow
+traversing into further nfs filesystems; if you wish to export nfs
+filesystems mounted under the exported filesystem, you'll need to export
+them explicitly, assigning each its own unique "fsid= option.
 
 Reboot recovery
 ---------------
