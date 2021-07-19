Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9E3CF0CD
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jul 2021 02:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbhGSXvy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 19:51:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47056 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241957AbhGSXN6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jul 2021 19:13:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8DC4F1FDAB;
        Mon, 19 Jul 2021 23:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626738820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xn3Kime99faUn2IslGRMGLij4vJk3LETvCd4yBPfL+w=;
        b=IQiLzqPe5Cywq6DRc0eFGbpGxDng4vmT/fBOzgnk4NGh+kPs46Jh6HBpY/9qwIV0YEZqLb
        l6QKwyxK9TTzPOmRSbu7RJkRfbX4BcbH5zV8ev77iqErfVqKsrwfHjqUbsDAul2dsffVh/
        qm3KfvnLxi6kBLNe/a2xM8wUtY9610Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626738820;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xn3Kime99faUn2IslGRMGLij4vJk3LETvCd4yBPfL+w=;
        b=jc445sSuYA1tpv99NPOypno25xnGJwDuqpXRfZ7Fum/lBqHLMDG4JWM4Qb4YdkjPagRuic
        0Yy0Wr3gH++zvKCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20FAD13D45;
        Mon, 19 Jul 2021 23:53:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 51a+MIAQ9mBBGgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 19 Jul 2021 23:53:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Josef Bacik" <josef@toxicpanda.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        "Wang Yugui" <wangyugui@e16-tech.com>,
        "Ulli Horlacher" <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
In-reply-to: <56bd8b67-a72c-1946-e877-838d9c0c65bd@toxicpanda.com>
References: <20210613115313.BC59.409509F4@e16-tech.com>,
 <20210310074620.GA2158@tik.uni-stuttgart.de>,
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>,
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>,
 <YPBmGknHpFb06fnD@infradead.org>,
 <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>,
 <YPBvUfCNmv0ElBpo@infradead.org>,
 <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>,
 <162638862766.13764.8566962032225976326@noble.neil.brown.name>,
 <15d0f450-cae5-22bc-eef3-8a973e6dda27@toxicpanda.com>,
 <20210719200003.GA32471@fieldses.org>,
 <56bd8b67-a72c-1946-e877-838d9c0c65bd@toxicpanda.com>
Date:   Tue, 20 Jul 2021 09:53:33 +1000
Message-id: <162673881350.4136.12509628629501906644@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 20 Jul 2021, Josef Bacik wrote:
> On 7/19/21 4:00 PM, J. Bruce Fields wrote:
> > On Mon, Jul 19, 2021 at 11:40:28AM -0400, Josef Bacik wrote:
> >> Ok so setting aside btrfs for the moment, how does NFS deal with
> >> exporting a directory that has multiple other file systems under
> >> that tree?  I assume the same sort of problem doesn't occur, but why
> >> is that?  Is it because it's a different vfsmount/sb or is there
> >> some other magic making this work?  Thanks,
> >=20
> > There are two main ways an NFS client can look up a file: by name or by
> > filehandle.  The former's the normal filesystem directory lookup that
> > we're used to.  If the name refers to a mountpoint, the server can cross
> > into the mounted filesystem like anyone else.
> >=20
> > It's the lookup by filehandle that's interesting.  Typically the
> > filehandle includes a UUID and an inode number.  The server looks up the
> > UUID with some help from mountd, and that gives a superblock that nfsd
> > can use for the inode lookup.
> >=20
> > As Neil says, mountd does that basically by searching among mounted
> > filesystems for one with that uuid.
> >=20
> > So if you wanted to be able to handle a uuid for a filesystem that's not
> > even mounted yet, you'd need some new mechanism to look up such uuids.
> >=20
> > That's something we don't currently support but that we'd need to
> > support if BTRFS subvolumes were automounted.  (And it might have other
> > uses as well.)
> >=20
> > But I'm not entirely sure if that answers your question....
> >=20
>=20
> Right, because btrfs handles the filehandles ourselves properly with the=20
> export_operations and we encode the subvolume id's into those things to mak=
e=20
> sure we can always do the proper lookup.
>=20
> I suppose the real problem is that NFS is exposing the inode->i_ino to the =

> client without understanding that it's on a different subvolume.
>=20
> Our trick of simply allocating an anonymous bdev every time you wander into=
 a=20
> subvolume to get a unique st_dev doesn't help you guys because you are look=
ing=20
> for mounted file systems.
>=20
> I'm not concerned about the FH case, because for that it's already been cra=
fted=20
> by btrfs and we know what to do with it, so it's always going to be correct.
>=20
> The actual problem is that we can do
>=20
> getattr(/file1)
> getattr(/snap/file1)
>=20
> on the client and the NFS server just blind sends i_ino with the same fsid =

> because / and /snap are the same fsid.
>=20
> Which brings us back to what HCH is complaining about.  In his view if we h=
ad a=20
> vfsmount for /snap then you would know that it was a different fs.  However=
 that=20
> would only actually work if we generated a completely different superblock =
and=20
> thus gave /snap a unique fsid, right?

No, I don't think it needs to be a different superblock to have a
vfsmount.  (I don't know if it does to keep HCH happy).

If I "mount --bind /snap /snap" then I've created a vfsmnt with the
upper and lower directories identical - same inode, same superblock.
This is an existence-proof that you don't need a separate super-block.

>=20
> If we did the automount thing, and the NFS server went down and came back u=
p and=20
> got a getattr(/snap/file1) from a previously generated FH it would still wo=
rk=20
> right, because it would come into the export_operations with the format tha=
t=20
> btrfs is expecting and it would be able to do the lookup.  This FH lookup w=
ould=20
> do the automount magic it needs to and then NFS would have the fsid it need=
s,=20
> correct?  Thanks,

Not quite.
An NFS filehandle (as generated by linux-nfsd) has two components (plus
a header).  The filesystem-part and the file-part.
The filesystem-part is managed by userspace (/usr/sbin/mountd).  The
code relies on every filesystem appearing in /proc/self/mounts.
The bytes chosen are either based on the uuid reported by 'libblkid', or the
fsid reported by statfs(), based on a black-list of filesystems for
which libblkid is not useful.  This list includes btrfs.
The file-part is managed in the kernel using export_operations.

For any given 'struct path' in the kernel, a filehandle is generated
(conceptually) by finding the closest vfsmnt (close to inode, far from
root) and asking user-space to map that.  Then passing the inode to the
filesystem and asking it to map that.

So, in your example, if /snap were a mount point, the kernel would ask
mountd to determine the filesystem-part of /snap, and the fact that the
file-part from btrfs contained the objectid for snap just be redundant
information.  If /snap couldn't be found in /proc/self/mounts after a
server restart, the filehandle would be stale.

If btrfs were to use automounts and create the vfsmnts that one might
normally expect, then nfsd would need there to be two different sorts of
mount points, ideally visible in /proc/mounts (maybe a new flag that
appears in the list of mount options? "internal" ??).

- there needs to be the current mountpoint which a expected to be
  present after a reboot, and is likely to introduce a new filesystem,
  and
- there are these "new" mountpoints which are on-demand and expose
  something that is (in some sense) part of the same filesystem.
  The key property that NFSd would depend on is that these mount points
  do NOT introduce a new name-space for file-handles (in the sense of
  export_operations).

To expand on that last point:
- If a filehandle is requested for an inode above the "new" mountpoint
  and another "below" the new mountpoint, they are guaranteed to be
  different.
- If a filehandle that was "below" the new mountpoint is passed to
  exportfs_decode_fh() together with the vfsmnt that was *above* the
  mountpoint, then it somehow does "the right thing".  Probably
  that would require changing exportfs_decode_fh() to return a
  'struct path' rather than just a 'struct dentry *'.

When nfsd detected one of these "internal" mountpoints during a lookup,
it would *not* call-out to user-space to create a new export, but it
*would* ensure that a new fsid was reported for all inodes in the new
vfsmnt.

NeilBrown
