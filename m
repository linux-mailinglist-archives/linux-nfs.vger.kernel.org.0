Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37783D044E
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jul 2021 00:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhGTVat (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Jul 2021 17:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhGTVap (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Jul 2021 17:30:45 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E314C0613E0;
        Tue, 20 Jul 2021 15:10:47 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CDD006801; Tue, 20 Jul 2021 18:10:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CDD006801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1626819044;
        bh=LtQY5pxcSArdGZFknLSBlW9FrCcEI34fvbHFuaQyogg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z/mUlVP4bhdzK/bCfP9BbYrmPf9FswIlx1cglIiLZyW5C9RzXTBYq5Gdwn0nMtQQR
         g63IIkVYRnrPdSRr43VG0oSuxVUMNHhX/uDzQf1Fe666RFKXGvd4H9T2451nNzaq11
         1Tfqda1//Qzecw6mQbuQX+KJsTmPCX76mv3yWzh8=
Date:   Tue, 20 Jul 2021 18:10:44 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@infradead.org>, NeilBrown <neilb@suse.de>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
Message-ID: <20210720221044.GD19507@fieldses.org>
References: <20210613115313.BC59.409509F4@e16-tech.com>
 <20210310074620.GA2158@tik.uni-stuttgart.de>
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>
 <YPBmGknHpFb06fnD@infradead.org>
 <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>
 <YPBvUfCNmv0ElBpo@infradead.org>
 <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 15, 2021 at 02:01:11PM -0400, Josef Bacik wrote:
> The problem I ran into was the automount stuff requires that we have a
> completely different superblock for every vfsmount. This is fine for
> things like nfs or samba where the automount literally points to a
> completely different mount, but doesn't work for btrfs where it's on
> the same file system.  If you have 1000 subvolumes and run sync()
> you're going to write the superblock 1000 times for the same file
> system.

Dumb question: why do you have to write the superblock 1000 times, and
why is that slower than writing to 1000 different filesystems?

> You are
> going to reclaim inodes on the same file system 1000 times.  You are
> going to reclaim dcache on the same filesytem 1000 times.  You are
> also going to pin 1000 dentries/inodes into memory whenever you
> wander into these things because the super is going to hold them
> open.

That last part at least is the same for the 1000-different-filesystems
case, isn't it?

--b.

> This is not a workable solution.  It's not a matter of simply tying
> into existing infrastructure, we'd have to completely rework how the
> VFS deals with this stuff in order to be reasonable.  And when I
> brought this up to Al he told me I was insane and we absolutely had
> to have a different SB for every vfsmount, which means we can't use
> vfsmount for this, which means we don't have any other options.
> Thanks,
> 
> Josef
