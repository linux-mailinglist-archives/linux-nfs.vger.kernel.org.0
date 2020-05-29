Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65A91E8AE9
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 00:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgE2WGO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 May 2020 18:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgE2WGN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 May 2020 18:06:13 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8607DC03E969
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2020 15:06:09 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0DADB1BE7; Fri, 29 May 2020 18:06:08 -0400 (EDT)
Date:   Fri, 29 May 2020 18:06:08 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: nfs4_show_superblock considered harmful :-)
Message-ID: <20200529220608.GA22758@fieldses.org>
References: <871rn38suc.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rn38suc.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 29, 2020 at 10:53:15AM +1000, NeilBrown wrote:
>  I've received a report of a 5.3 kernel crashing in
>  nfs4_show_superblock().
>  I was part way through preparing a patch when I concluded that
>  the problem wasn't as straight forward as I thought.
>
>  In the crash, the 'struct file *' passed to nfs4_show_superblock()
>  was NULL.
>  This file was acquired from find_any_file(), and every other caller
>  of find_any_file() checks that the returned value is not NULL (though
>  one BUGs if it is NULL - another WARNs).
>  But nfs4_show_open() and nfs4_show_lock() don't.
>  Maybe they should.  I didn't double check, but I suspect they don't
>  hold enough locks to ensure that the files don't get removed.

I think the only lock held is cl_lock, acquired in states_start.

We're starting here with an nfs4_stid that was found in the cl_stateids
idr.

A struct nfs4_stid is freed by nfs4_put_stid(), which removes it from
that idr under cl_lock before freeing the nfs4_stid and anything it
points to.

I think that was the theory....

One possible problem is downgrades, like nfs4_stateid_downgrade.

I'll keep mulling it over, thanks.

--b.

> 
> 
>  Then I noticed that nfs4_show_deleg() accesses fi_deleg_file without
>  checking if it is NULL - Should it take fi_lock and make sure it is
>  not NULL - and get a counted reference?
>  And maybe nfs4_show_layout() has the same problem?
> 
>  I could probably have worked my way through fixing all of these, but
>  then I discovered that these things are now 'struct nfsd_file *' rather
>  than 'struct file *' and that the helpful documentation says:
> 
>  *    Note that this object doesn't
>  * hold a reference to the inode by itself, so the nf_inode pointer should
>  * never be dereferenced, only used for comparison.
> 
>  and yet nfs4_show_superblock() contains:
> 
> 	struct inode *inode = f->nf_inode;
> 
> 	seq_printf(s, "superblock: \"%02x:%02x:%ld\"",
> 					MAJOR(inode->i_sb->s_dev),
> 					 MINOR(inode->i_sb->s_dev),
> 					 inode->i_ino);
> 
>  do you see my problem?
> 
>  Is this really safe and the doco wrong? (I note that the use of nf_inode
>  in nfsd_file_mark_find_or_create() looks wrong, but is actually safe).
>  Or should we check if nf_file is non-NULL and use that?
> 
>  In short:
>  - We should check find_any_file() return value - correct?
>  - Do we need extra locking to stabilize fi_deleg_file?
>  - ditto for ->ls_file
>  - how can nfs4_show_superblock safely get s_dev and i_ino from a
>    nfsd_file?
> 
> Thanks,
> 
> NeilBrown


