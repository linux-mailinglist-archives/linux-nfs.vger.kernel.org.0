Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CE33CF52C
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jul 2021 09:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhGTGgt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Jul 2021 02:36:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50086 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhGTGgo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Jul 2021 02:36:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F9BD22363;
        Tue, 20 Jul 2021 07:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626765442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSxL6Y+9oiEXAmxYmiKVE5BTquu8g7wV+aZTyTGOjdc=;
        b=fnTi/F+cRF31ctXj75etKh5AKCon3zXPQhmE5oY5dvyTYnHtovjZHVBIF2OIza3ZD/aAxO
        JOqBZGsUUXLR/3qUfC+5Cm3CuglTR2XslZJ3Zvw4ZDuYuNb6P2nBL78xGTyrZQ+URPNtHj
        9yPPc3x9fyuhaKkjyZfUw7i/8TFHY6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626765442;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSxL6Y+9oiEXAmxYmiKVE5BTquu8g7wV+aZTyTGOjdc=;
        b=OyjTjOMonJUuSlglWIu9Dp8FwZZvXpJr1khsXA/6TjkqlmRhhSi4Ya2TLwTbWCaLy7hy6m
        9e8IyxB5rYNPTwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2A3013D5A;
        Tue, 20 Jul 2021 07:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lPfmJH549mAHfAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 20 Jul 2021 07:17:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        "Wang Yugui" <wangyugui@e16-tech.com>,
        "Ulli Horlacher" <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
In-reply-to: <YPZr9woK584Oc61H@infradead.org>
References: <20210613115313.BC59.409509F4@e16-tech.com>,
 <20210310074620.GA2158@tik.uni-stuttgart.de>,
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>,
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>,
 <YPBmGknHpFb06fnD@infradead.org>,
 <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>,
 <YPBvUfCNmv0ElBpo@infradead.org>,
 <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>,
 <YPVC/w4kw3y/14oF@infradead.org>,
 <162673888433.4136.7451392112850411713@noble.neil.brown.name>,
 <YPZr9woK584Oc61H@infradead.org>
Date:   Tue, 20 Jul 2021 17:17:12 +1000
Message-id: <162676543271.12554.10226255548215795177@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 20 Jul 2021, Christoph Hellwig wrote:
> On Tue, Jul 20, 2021 at 09:54:44AM +1000, NeilBrown wrote:
> > Do you have any pointers to other breakage caused by this particular
> > behaviour of btrfs? It would to have all requirements clearly on the
> > table while designing a solution.
>=20
> A quick google find:
>=20
> https://lore.kernel.org/linux-btrfs/b5e7e64a-741c-baee-bc4d-cd51ca9b3a38@gm=
ail.com/T/
> https://savannah.gnu.org/bugs/?50859
> https://github.com/coreos/bugs/issues/301
> https://bugs.kde.org/show_bug.cgi?id=3D317127
> https://github.com/borgbackup/borg/issues/4009
> https://bugs.python.org/issue37339
> http://mail.openjdk.java.net/pipermail/nio-dev/2017-June/004292.html
>=20
> and that is just the first 2 or three pages of trivial search results.
>=20


Thanks a lot for these!  Very helpful.

The details vary, but the core problem seems to be that the device
number found in /proc/self/mountinfo is the same for all mounts from a
given btrfs filesystem, no matter which subvol happens to be found at or
beneath that mountpoint.  So it can even be that 'stat' on a mountpoint
returns different numbers to what is found for that mountpoint in
/proc/self/mountinfo.

To address these issues we would need to:
1/ make every btrfs subvol which is not already a mountpoint into an
   automount point which mounts the subvol (similar to the use of
   automount in NFS).
2/ either give each subvol a separate 'struct super_block' (which is
   apparently a bad idea) or change show_mountinfo() to allow an
   alternate dev_t to be used. e.g. some new s_op which is given
   mnt->mnt_root and returns a dev_t.  If the new s_op is not
   available, sb->s_dev is used.

For nfsd to be able to work with this, those automount points need to
have an inode in the parent filesystem with a distinct inode number, and
the mount must be marked in some way that nfsd can tell that it is
"internal".  Possibly a helper function that tests if mnt_parent has the
same mnt.mnt_sb would be sufficient, though it might be nice to export
this fact to user-space somehow.

Also exportfs_decode_fh() needs to be enhanced, probably to return a
'struct path'.

Does anything there seem unreasonable to you?

Thanks,
NeilBrown

=20
