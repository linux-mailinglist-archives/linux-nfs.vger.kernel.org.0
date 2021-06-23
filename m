Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B843B22E8
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 00:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFWWHV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 18:07:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55848 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhFWWHV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 18:07:21 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 181A31FD36;
        Wed, 23 Jun 2021 22:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624485902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jIBNDClKgTqguyVB6nEuspuctIstN1rDK2CE7vek5BM=;
        b=JZ7zFOORW1+mWvhsJWKatTX2Zk+1qIKHlbAYjdkgPYpsLPkA1Ck9ZJE03SGp7dVgMAQcbv
        OIwmJNhGOOhYN6GU/TKbym1JStGf4MHtEK7rsbkpje30MrUcJ5Oj9U2Or0frJ6aSMm+Jnv
        8TiKVgO2VsPD3z4CbpL0qlsdIBy+o+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624485902;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jIBNDClKgTqguyVB6nEuspuctIstN1rDK2CE7vek5BM=;
        b=bwgX4nHH9vZG8PkY2tdisAzMeb6O1aURyErphimuuAhDKANdnHTixlB/60m0o/+h7wG8Gz
        kHnixBBz7HpUQ4BA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id C02FC11A97;
        Wed, 23 Jun 2021 22:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624485902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jIBNDClKgTqguyVB6nEuspuctIstN1rDK2CE7vek5BM=;
        b=JZ7zFOORW1+mWvhsJWKatTX2Zk+1qIKHlbAYjdkgPYpsLPkA1Ck9ZJE03SGp7dVgMAQcbv
        OIwmJNhGOOhYN6GU/TKbym1JStGf4MHtEK7rsbkpje30MrUcJ5Oj9U2Or0frJ6aSMm+Jnv
        8TiKVgO2VsPD3z4CbpL0qlsdIBy+o+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624485902;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jIBNDClKgTqguyVB6nEuspuctIstN1rDK2CE7vek5BM=;
        b=bwgX4nHH9vZG8PkY2tdisAzMeb6O1aURyErphimuuAhDKANdnHTixlB/60m0o/+h7wG8Gz
        kHnixBBz7HpUQ4BA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id AqtqHAyw02BnMwAALh3uQQ
        (envelope-from <neilb@suse.de>); Wed, 23 Jun 2021 22:05:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Wang Yugui" <wangyugui@e16-tech.com>, linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-reply-to: <20210623153548.GF20232@fieldses.org>
References: <162432531379.17441.15110145423567943074@noble.neil.brown.name>,
 <20210622112253.DAEE.409509F4@e16-tech.com>,
 <20210622151407.C002.409509F4@e16-tech.com>,
 <162440994038.28671.7338874000115610814@noble.neil.brown.name>,
 <20210623153548.GF20232@fieldses.org>
Date:   Thu, 24 Jun 2021 08:04:57 +1000
Message-id: <162448589701.28671.8402117125966499268@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 24 Jun 2021, J. Bruce Fields wrote:
> Is there any hope of solving this problem within btrfs?
> 
> It doesn't seem like it should have been that difficult for it to give
> subvolumes separate superblocks and vfsmounts.
> 
> But this has come up before, and I think the answer may have been that
> it's just too late to fix.

It is never too late to do the right thing!

Probably the best approach to fixing this completely on the btrfs side
would be to copy the auto-mount approach used in NFS.  NFS sees multiple
different volumes on the server and transparently creates new vfsmounts,
using the automount infrastructure to mount and unmount them.  BTRFS
effective sees multiple volumes on the block device and could do the
same thing.

I can only think of one change to the user-space API (other than
/proc/mounts contents) that this would cause and I suspect it could be
resolved if needed.

Currently when you 'stat' the mountpoint of a btrfs subvol you see the
root of that subvol.  However when you 'stat' the mountpoint of an NFS
sub-filesystem (before any access below there) you see the mountpoint
(s_dev matches the parent).  This is how automounts are expected to work
and if btrfs were switched to use automounts for subvols, stating the
mountpoint would initially show the mountpoint, not the subvol root.

If this were seen to be a problem I doubt it would be hard to add
optional functionality to automount so that 'stat' triggers the mount.

All we really need is:
1/ someone to write the code
2/ someone to review the code
3/ someone to accept the code

How hard can it be :-)

NeilBrown
