Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3C63CF1FF
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jul 2021 04:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhGTBkS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 21:40:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35606 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346408AbhGSXXN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jul 2021 19:23:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB8FC222C3;
        Tue, 20 Jul 2021 00:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626739375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vJrtL8bkhlgGTUFCD0HxOaMzWJzCPRp3RIcvlQb0bng=;
        b=tg+Iyy4INSMaUAeEVddizrLa22gp5nfq91feNmRNTbvQI+K6W0hDhpc3kCVFVnLkTmS7dE
        bgVGt3uPwYHf8u4VijQRIWDiV+0lhL1AlPxZoakn8nUbWblAIVwx+cL4HP56jHcKuBydJE
        YDIH+FIhSEz5APQccKXKU5tCrzV72ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626739375;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vJrtL8bkhlgGTUFCD0HxOaMzWJzCPRp3RIcvlQb0bng=;
        b=2Y5eCJdBDRTmawZLLda4n+YmmdgmdPARn2SP4hCcYWTHK2VVGmYFoMf6fNEm/ZU4J9R+Ic
        DousxA/vpdNVVsAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A25A13BD3;
        Tue, 20 Jul 2021 00:02:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z+WBOqsS9mAfHQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 20 Jul 2021 00:02:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Josef Bacik" <josef@toxicpanda.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        "Wang Yugui" <wangyugui@e16-tech.com>,
        "Ulli Horlacher" <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
In-reply-to: <20210719154907.GA28482@fieldses.org>
References: <20210613115313.BC59.409509F4@e16-tech.com>,
 <20210310074620.GA2158@tik.uni-stuttgart.de>,
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>,
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>,
 <YPBmGknHpFb06fnD@infradead.org>,
 <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>,
 <YPBvUfCNmv0ElBpo@infradead.org>,
 <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>,
 <162638862766.13764.8566962032225976326@noble.neil.brown.name>,
 <20210719154907.GA28482@fieldses.org>
Date:   Tue, 20 Jul 2021 10:02:48 +1000
Message-id: <162673936876.4136.15592386101064503795@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 20 Jul 2021, J. Bruce Fields wrote:
> On Fri, Jul 16, 2021 at 08:37:07AM +1000, NeilBrown wrote:
> > On Fri, 16 Jul 2021, Josef Bacik wrote:
> > > On 7/15/21 1:24 PM, Christoph Hellwig wrote:
> > > > On Thu, Jul 15, 2021 at 01:11:29PM -0400, Josef Bacik wrote:
> > > >> Because there's no alternative.  We need a way to tell userspace the=
y've
> > > >> wandered into a different inode namespace.  There's no argument that=
 what
> > > >> we're doing is ugly, but there's never been a clear "do X instead". =
 Just a
> > > >> lot of whinging that btrfs is broken.  This makes userspace happy an=
d is
> > > >> simple and straightforward.  I'm open to alternatives, but there hav=
e been 0
> > > >> workable alternatives proposed in the last decade of complaining abo=
ut it.
> > > >=20
> > > > Make sure we cross a vfsmount when crossing the "st_dev" domain so
> > > > that it is properly reported.   Suggested many times and ignored all
> > > > the time beause it requires a bit of work.
> > > >=20
> > >=20
> > > You keep telling me this but forgetting that I did all this work when y=
ou=20
> > > originally suggested it.  The problem I ran into was the automount stuf=
f=20
> > > requires that we have a completely different superblock for every vfsmo=
unt.=20
> > > This is fine for things like nfs or samba where the automount literally=
 points=20
> > > to a completely different mount, but doesn't work for btrfs where it's =
on the=20
> > > same file system.  If you have 1000 subvolumes and run sync() you're go=
ing to=20
> > > write the superblock 1000 times for the same file system.  You are goin=
g to=20
> > > reclaim inodes on the same file system 1000 times.  You are going to re=
claim=20
> > > dcache on the same filesytem 1000 times.  You are also going to pin 100=
0=20
> > > dentries/inodes into memory whenever you wander into these things becau=
se the=20
> > > super is going to hold them open.
> > >=20
> > > This is not a workable solution.  It's not a matter of simply tying int=
o=20
> > > existing infrastructure, we'd have to completely rework how the VFS dea=
ls with=20
> > > this stuff in order to be reasonable.  And when I brought this up to Al=
 he told=20
> > > me I was insane and we absolutely had to have a different SB for every =
vfsmount,=20
> > > which means we can't use vfsmount for this, which means we don't have a=
ny other=20
> > > options.  Thanks,
> >=20
> > When I was first looking at this, I thought that separate vfsmnts
> > and auto-mounting was the way to go "just like NFS".  NFS still shares a
> > lot between the multiple superblock - certainly it shares the same
> > connection to the server.
> >=20
> > But I dropped the idea when Bruce pointed out that nfsd is not set up to
> > export auto-mounted filesystems.
>=20
> Yes.  I wish it was....  But we'd need some way to look a
> not-currently-mounted filesystem by filehandle:
>=20
> > It needs to be able to find a
> > filesystem given a UUID (extracted from a filehandle), and it does this
> > by walking through the mount table to find one that matches.  So unless
> > all btrfs subvols were mounted all the time (which I wouldn't propose),
> > it would need major work to fix.
> >=20
> > NFSv4 describes the fsid as having a "major" and "minor" component.
> > We've never treated these as having an important meaning - just extra
> > bits to encode uniqueness in.  Maybe we should have used "major" for the
> > vfsmnt, and kept "minor" for the subvol.....
>=20
> So nfsd would use the "major" ID to find the parent export, and then
> btrfs would use the "minor" ID to identify the subvolume?

Maybe, though I don't think it would be really useful - just a
thought-bubble.

As the spec doesn't define any behaviour of these two numbers, there is
no point trying to impose any.
But (as described in another email) I think we do need to clearly
differentiate between "volume" and "subvolume" in the Linux API.
We cannot really use "different mount point" to mean "different volume"
as bind mounts broke that model long ago.

I think that "different st_dev" means "different subvolume" is a core
requirement as many applications assume that.  So the question is "how
to determine if two objects in different subvolumes are still in the
same volume".  This is something that nfsd needs to know.

NeilBrown
