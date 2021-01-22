Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32412FF9FD
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 02:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbhAVBbG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 20:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbhAVBbA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 20:31:00 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAFAC0613ED
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 17:30:19 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1CB4B68A6; Thu, 21 Jan 2021 20:30:19 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1CB4B68A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611279019;
        bh=lzbigEGh+9n7fzFS8r9wxWwPX+gZgekQAEuo4Ulk0ZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fFSYDRmY4R3yo04FNE4/pTb3Bgx9yhc3RhUvVFqmfn3BhStmZdcXqh54b2oERAGZJ
         Okn68sCWl9gyPi9sNDJx84t+Ev8CGcZCpXSBxO4ZbQUKK+jgah/pAzzfFYDX+kLNTU
         RQZAZiGHXrXkRvqBy6sqO9HU0Nv4W9aL/C5klRJo=
Date:   Thu, 21 Jan 2021 20:30:19 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>,
        "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: nfsd vurlerability submit
Message-ID: <20210122013019.GA30323@fieldses.org>
References: <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org>
 <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu>
 <20210112180326.GI9248@fieldses.org>
 <eb09db3a-9b43-cf03-5db4-3af33cb160e6@math.utexas.edu>
 <20210121220402.GF20964@fieldses.org>
 <a6429a2c-ce90-caec-0704-6626cd564300@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6429a2c-ce90-caec-0704-6626cd564300@math.utexas.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 21, 2021 at 05:19:32PM -0600, Patrick Goetz wrote:
> On 1/21/21 4:04 PM, bfields@fieldses.org wrote:
> >As I said, NFS allows you to look up objects by filehandle (so,
> >basically by inode number), not just by path
> 
> Except surely this doesn't buy you much if you don't have root
> access to the system?  Is this all only an issue when the
> filesystems are exported with no_root_squash?
> 
> I feel like I must be missing something, but it seems to me that if
> I'm not root, I'm not going to be able to access inodes I don't have
> permissions to access even when directly connected to the exporting
> server.

If an attacker has access to the network (so they can send their own
hand-crafted NFS requests), then filehandle guessing allows them to
bypass the normal process of looking up a file.  So if you were
depending on lookup permissions along that path, or on hiding that path
somehow, you're out of luck.

But it doesn't let them bypass the permissions on the file itself once
they get there.  If the permissions on the file don't allow read, the
server still won't let them read it.

> >>It's not practical to making everything you export its own partition;
> >>although I suppose one could do this with ZFS datasets.
> >
> >I'd be happy to hear about any use cases where that's not practical.
> 
> Sure. The xray example is taken from one of my research groups which
> collects thousands of very large electron microscopy images, along
> with some xray data. I will certainly design this differently in the
> next iteration (most likely using ZFS), but our current server has a
> 519T attached storage device which presents itself as a single
> device: /dev/sdg.  Different groups need access to different classes
> of data, which I export separately and with are presented on the
> workstations as /xray, /EM, etc..
> 
> Yes, I could partition the storage device, but then I run into the
> usual issues where one partition runs out of space while others are
> barely utilized. This is one good reason to switch to ZFS datasets.
> The other is that -- with 450T+ of ever changing data, currently
> rsync backups are almost impossible.  I'm hoping zfs send/receive is
> going to save me here.
> 
> >As Christophe pointed out, xfs/ext4 project ids are another option.
> 
> I must have missed this one, but it just leaves me more confused.
> Project ID's are filesystem metadata, yet this affords better
> boundary enforcement than a bind mount?

Right.  The project ID is stored in the inode, so it's easy to look up
from the filehandle.  (Whereas figuring out what paths might lead to
that inode is a little tricker.)

> Also, the only use case for Project ID's I was able to find are
> project quotas, so am not even sure how this would be implemented, and
> used by NFS.

Project ID's were implemented for quotas, but they also have the
characteristics to work well as NFS export boundaries.

That said, I think Christoph was suggesting this is something we *could*
support, not something that we now do.  Though looking at it quickly, I
think it shouldn't take much code at all.  I'll put it on my list....

Other options for doing this kind of thing might be btrfs subvolumes or
lvm thin provisioning.  I haven't personally used either, but they
should both work now.

--b.
