Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809293B39BC
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Jun 2021 01:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFXXaF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Jun 2021 19:30:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55510 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXXaF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Jun 2021 19:30:05 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D8871FDEB;
        Thu, 24 Jun 2021 23:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624577264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTs7aLX9BvXZvapKtwM82PJl3bhsoouSmRv14kpnh1U=;
        b=LDmysPi0SAq9UsO4Ks7TDkYoednJptUxAXnsYuJtXc/P8Qef9KCckzLrgBFAABB2hd7vEK
        t7ng5lwY0QfXf6ePpB5GMDFAVtgD3A6XdjFoqe4B0rZt/XYhbwxmi635d3+JZsL4KFq5CX
        hCB3ZC1PmlvW2Mf65RXZIRTkaIX+zFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624577264;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTs7aLX9BvXZvapKtwM82PJl3bhsoouSmRv14kpnh1U=;
        b=iT/kbsD/8aYdrNI/nTIRI21iOQq95wd9vcGOTjGEUJLKZr3v45ma9fauzZo2NCHny0xqJV
        EFuGwKLXDmjGr6AQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 9909A11A97;
        Thu, 24 Jun 2021 23:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624577264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTs7aLX9BvXZvapKtwM82PJl3bhsoouSmRv14kpnh1U=;
        b=LDmysPi0SAq9UsO4Ks7TDkYoednJptUxAXnsYuJtXc/P8Qef9KCckzLrgBFAABB2hd7vEK
        t7ng5lwY0QfXf6ePpB5GMDFAVtgD3A6XdjFoqe4B0rZt/XYhbwxmi635d3+JZsL4KFq5CX
        hCB3ZC1PmlvW2Mf65RXZIRTkaIX+zFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624577264;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTs7aLX9BvXZvapKtwM82PJl3bhsoouSmRv14kpnh1U=;
        b=iT/kbsD/8aYdrNI/nTIRI21iOQq95wd9vcGOTjGEUJLKZr3v45ma9fauzZo2NCHny0xqJV
        EFuGwKLXDmjGr6AQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id dJ6HEu4U1WD6fAAALh3uQQ
        (envelope-from <neilb@suse.de>); Thu, 24 Jun 2021 23:27:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Patrick Goetz" <pgoetz@math.utexas.edu>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Wang Yugui" <wangyugui@e16-tech.com>, linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-reply-to: <3ac9c4f3-6bc2-9753-6f0f-937aa4f13efa@math.utexas.edu>
References: <162432531379.17441.15110145423567943074@noble.neil.brown.name>,
 <20210622112253.DAEE.409509F4@e16-tech.com>,
 <20210622151407.C002.409509F4@e16-tech.com>,
 <162440994038.28671.7338874000115610814@noble.neil.brown.name>,
 <20210623153548.GF20232@fieldses.org>,
 <162448589701.28671.8402117125966499268@noble.neil.brown.name>,
 <3ac9c4f3-6bc2-9753-6f0f-937aa4f13efa@math.utexas.edu>
Date:   Fri, 25 Jun 2021 09:27:38 +1000
Message-id: <162457725899.28671.14092003979067994699@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 25 Jun 2021, Patrick Goetz wrote:
> 
> On 6/23/21 5:04 PM, NeilBrown wrote:
> > 
> > Probably the best approach to fixing this completely on the btrfs side
> > would be to copy the auto-mount approach used in NFS.  NFS sees multiple
> > different volumes on the server and transparently creates new vfsmounts,
> > using the automount infrastructure to mount and unmount them.
> 
> I'm very confused about what you're talking about.  Is this documented 
> somewhere? I mean, I do use autofs, but see that as a separate software 
> system working with NFS.
> 

autofs (together with the user-space automountd) is a special filesystem
that provides automount functionality to the sysadmin.
It makes use of some core automount functionality in the Linux VFS.
This functionality is referred to as "managed" dentries.
See "Revalidation and automounts" in https://lwn.net/Articles/649115/.

autofs makes use of this functionality to provide automounts.  NFS makes
use of this same functionality to provide the same mount-point structure
on the client that it finds on the server.

I don't think there is any documentation specifically about NFS using
this infrastructure.  It should be largely transparent to users.

Suppose that on the server "/export/foo" is a mount of some
filesystem, and you nfs4 mount "server:/export" to "/import" on the
client.
Then you will at first see only "/import" in /proc/mounts on client.
If you "ls -ld /import/foo" you will still only see /import.
But if you "ls -l /import/foo" so it lists the contents of that other
filesytem, then check /proc/mounts, you will now see "/import" and
"/import/foo".

After a while (between 500 and 1000 seconds I think) of not accessing
/import/foo, that entry will disappear from /proc/mounts.

I'm sure you will recognise this as very similar to autofs behaviour.
It uses the same core functionality.  The timeout for inactive NFS
sub-filesystems to be unmounted can be controlled via
/proc/sys/fs/nfs/nfs_mountpoint_timeout and, since Linux 5.7, via the
nfs_mountpoint_expiry_timeout module parameter.
These aren't documented.

Note that I'm no longer sure that btrfs using automount like this would
actually make things easier for nfsd.  But in some ways I think it would
be the "right" thing to do.

NeilBrown

