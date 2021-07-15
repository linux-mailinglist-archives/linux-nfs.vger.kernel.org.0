Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C389D3CAF38
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jul 2021 00:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhGOWkK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 18:40:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42248 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhGOWkJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jul 2021 18:40:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D5A6522ADE;
        Thu, 15 Jul 2021 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626388634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FuRexorNhTCnUXe3dimi/nsOEYPMUp+LaDN4hllMJqM=;
        b=kjm+JrMJTGd4jq4wdEG2nM/SEot1PZ9/2jflIYbZZcMeDkWqF/KYnOz2TRU9eWc3XPg211
        tdyrC59Oi4yy0qoM0JC4WKwZmlchkNSDYMgAsyiFMaIyb8zjx2+7hTXAPborQKZc2VhmfR
        iCph+JqPeYjcuWrKpOianqu9gh1p+OA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626388634;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FuRexorNhTCnUXe3dimi/nsOEYPMUp+LaDN4hllMJqM=;
        b=G8FuSlEJQ8oAvndJ/MJk9/jk6q1IKEqyi4WLLArFphht/2rQ1GkDY998WgbwKNZ890H+1b
        0t/NfW/DxU5uepCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7347D13C4D;
        Thu, 15 Jul 2021 22:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I1+zCZe48GADYgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 15 Jul 2021 22:37:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Josef Bacik" <josef@toxicpanda.com>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        "Wang Yugui" <wangyugui@e16-tech.com>,
        "Ulli Horlacher" <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
In-reply-to: <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>
References: <20210613115313.BC59.409509F4@e16-tech.com>,
 <20210310074620.GA2158@tik.uni-stuttgart.de>,
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>,
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>,
 <YPBmGknHpFb06fnD@infradead.org>,
 <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>,
 <YPBvUfCNmv0ElBpo@infradead.org>,
 <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>
Date:   Fri, 16 Jul 2021 08:37:07 +1000
Message-id: <162638862766.13764.8566962032225976326@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 16 Jul 2021, Josef Bacik wrote:
> On 7/15/21 1:24 PM, Christoph Hellwig wrote:
> > On Thu, Jul 15, 2021 at 01:11:29PM -0400, Josef Bacik wrote:
> >> Because there's no alternative.  We need a way to tell userspace they've
> >> wandered into a different inode namespace.  There's no argument that what
> >> we're doing is ugly, but there's never been a clear "do X instead".  Jus=
t a
> >> lot of whinging that btrfs is broken.  This makes userspace happy and is
> >> simple and straightforward.  I'm open to alternatives, but there have be=
en 0
> >> workable alternatives proposed in the last decade of complaining about i=
t.
> >=20
> > Make sure we cross a vfsmount when crossing the "st_dev" domain so
> > that it is properly reported.   Suggested many times and ignored all
> > the time beause it requires a bit of work.
> >=20
>=20
> You keep telling me this but forgetting that I did all this work when you=20
> originally suggested it.  The problem I ran into was the automount stuff=20
> requires that we have a completely different superblock for every vfsmount.=
=20
> This is fine for things like nfs or samba where the automount literally poi=
nts=20
> to a completely different mount, but doesn't work for btrfs where it's on t=
he=20
> same file system.  If you have 1000 subvolumes and run sync() you're going =
to=20
> write the superblock 1000 times for the same file system.  You are going to=
=20
> reclaim inodes on the same file system 1000 times.  You are going to reclai=
m=20
> dcache on the same filesytem 1000 times.  You are also going to pin 1000=20
> dentries/inodes into memory whenever you wander into these things because t=
he=20
> super is going to hold them open.
>=20
> This is not a workable solution.  It's not a matter of simply tying into=20
> existing infrastructure, we'd have to completely rework how the VFS deals w=
ith=20
> this stuff in order to be reasonable.  And when I brought this up to Al he =
told=20
> me I was insane and we absolutely had to have a different SB for every vfsm=
ount,=20
> which means we can't use vfsmount for this, which means we don't have any o=
ther=20
> options.  Thanks,

When I was first looking at this, I thought that separate vfsmnts
and auto-mounting was the way to go "just like NFS".  NFS still shares a
lot between the multiple superblock - certainly it shares the same
connection to the server.

But I dropped the idea when Bruce pointed out that nfsd is not set up to
export auto-mounted filesystems.  It needs to be able to find a
filesystem given a UUID (extracted from a filehandle), and it does this
by walking through the mount table to find one that matches.  So unless
all btrfs subvols were mounted all the time (which I wouldn't propose),
it would need major work to fix.

NFSv4 describes the fsid as having a "major" and "minor" component.
We've never treated these as having an important meaning - just extra
bits to encode uniqueness in.  Maybe we should have used "major" for the
vfsmnt, and kept "minor" for the subvol.....

The idea for a single vfsmnt exposing multiple inode-name-spaces does
appeal to me.  The "st_dev" is just part of the name, and already a
fairly blurry part.  Thanks to bind mounts, multiple mounts can have the
same st_dev.  I see no intrinsic reason that a single mount should not
have multiple fsids, provided that a coherent picture is provided to
userspace which doesn't contain too many surprises.

NeilBrown
