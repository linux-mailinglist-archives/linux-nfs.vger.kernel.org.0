Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAD03AE290
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jun 2021 06:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhFUEyf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 00:54:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56778 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhFUEye (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Jun 2021 00:54:34 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3EC6C219CA;
        Mon, 21 Jun 2021 04:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624251140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5D9Hc2QYijRcMHm9TBbUzX8yWE4IJUSfidGKxPoTNw=;
        b=0umeI8ktBpmIBU8GviJVrjgq1K34oMeiJaqrlgVpfhUAf1Qvbrqytt0GasIQvr7L71rrL3
        hlj7RjOWgaKbs4EAnF2TsFLXR62Bq+jA8Tc7vBlsTRn9RzurNun63oZgYneU7i+XJ3pPni
        T+y2ajgXBa7IQFE9Fu7eaTHHOwbPMwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624251140;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5D9Hc2QYijRcMHm9TBbUzX8yWE4IJUSfidGKxPoTNw=;
        b=tyiFcnxSUo4upT+0J4vllwn2oObi3l6qMTaHltrxOBH1jVIsAr8rThafP09ILURQaUqO7o
        0Q4Ux0lgnMGUJQBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 38D60118DD;
        Mon, 21 Jun 2021 04:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624251140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5D9Hc2QYijRcMHm9TBbUzX8yWE4IJUSfidGKxPoTNw=;
        b=0umeI8ktBpmIBU8GviJVrjgq1K34oMeiJaqrlgVpfhUAf1Qvbrqytt0GasIQvr7L71rrL3
        hlj7RjOWgaKbs4EAnF2TsFLXR62Bq+jA8Tc7vBlsTRn9RzurNun63oZgYneU7i+XJ3pPni
        T+y2ajgXBa7IQFE9Fu7eaTHHOwbPMwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624251140;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5D9Hc2QYijRcMHm9TBbUzX8yWE4IJUSfidGKxPoTNw=;
        b=tyiFcnxSUo4upT+0J4vllwn2oObi3l6qMTaHltrxOBH1jVIsAr8rThafP09ILURQaUqO7o
        0Q4Ux0lgnMGUJQBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id c2KPNgIb0GChTAAALh3uQQ
        (envelope-from <neilb@suse.de>); Mon, 21 Jun 2021 04:52:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wang Yugui" <wangyugui@e16-tech.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-reply-to: <20210618152631.F3DE.409509F4@e16-tech.com>
References: <20210617122852.BE6A.409509F4@e16-tech.com>,
 <162397637680.29912.2268876490205517592@noble.neil.brown.name>,
 <20210618152631.F3DE.409509F4@e16-tech.com>
Date:   Mon, 21 Jun 2021 14:52:15 +1000
Message-id: <162425113589.17441.4163890972298681569@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 18 Jun 2021, Wang Yugui wrote:
> Hi,
>=20
> > On Thu, 17 Jun 2021, Wang Yugui wrote:
> > > > Can we go back to the beginning.  What, exactly, is the problem you a=
re
> > > > trying to solve?  How can you demonstrate the problem?
> > > >=20
> > > > NeilBrown
> > >=20
> > > I nfs/exported a btrfs with 2 subvols and 2 snapshot(subvol).
> > >=20
> > > # btrfs subvolume list /mnt/test
> > > ID 256 gen 53 top level 5 path sub1
> > > ID 260 gen 56 top level 5 path sub2
> > > ID 261 gen 57 top level 5 path .snapshot/sub1-s1
> > > ID 262 gen 57 top level 5 path .snapshot/sub2-s1
> > >=20
> > > and then mount.nfs4 it to /nfs/test.
> > >=20
> > > # /bin/find /nfs/test/
> > > /nfs/test/
> > > find: File system loop detected; '/nfs/test/sub1' is part of the same f=
ile system loop as '/nfs/test/'.
> > > /nfs/test/.snapshot
> > > find: File system loop detected; '/nfs/test/.snapshot/sub1-s1' is part =
of the same file system loop as '/nfs/test/'.
> > > find: File system loop detected; '/nfs/test/.snapshot/sub2-s1' is part =
of the same file system loop as '/nfs/test/'.
> > > /nfs/test/dir1
> > > /nfs/test/dir1/a.txt
> > > find: File system loop detected; '/nfs/test/sub2' is part of the same f=
ile system loop as '/nfs/test/'
> > >=20
> > > /bin/find report 'File system loop detected'. so I though there is
> > > something wrong.
> >=20
> > Certainly something is wrong.  The error message implies that some
> > directory is reporting the same dev an ino as an ancestor directory.
> > Presumably /nfs/test and /nfs/test/sub1.
> > Can you confirm that please. e.g. run the command
> >=20
> >    stat /nfs/test /nfs/test/sub1
> > and examine the output.
>=20
> # stat /nfs/test /nfs/test/sub1
>   File: /nfs/test
>   Size: 42              Blocks: 32         IO Block: 32768  directory
> Device: 36h/54d Inode: 256         Links: 1
> Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2021-06-18 13:50:55.409457648 +0800
> Modify: 2021-06-13 10:05:10.830825901 +0800
> Change: 2021-06-13 10:05:10.830825901 +0800
>  Birth: -
>   File: /nfs/test/sub1
>   Size: 8               Blocks: 0          IO Block: 32768  directory
> Device: 36h/54d Inode: 256         Links: 1
> Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2021-06-18 13:51:14.463621411 +0800
> Modify: 2021-06-12 21:59:10.598089917 +0800
> Change: 2021-06-12 21:59:10.598089917 +0800
>  Birth: -
>=20
> same 'Device/Inode' are reported.
>=20
>=20
> but the local btrfs mount,
> # stat /mnt/test/ /mnt/test/sub1
>   File: /mnt/test/
>   Size: 42              Blocks: 32         IO Block: 4096   directory
> Device: 33h/51d Inode: 256         Links: 1
> Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2021-06-18 13:50:55.409457648 +0800
> Modify: 2021-06-13 10:05:10.830825901 +0800
> Change: 2021-06-13 10:05:10.830825901 +0800
>  Birth: -
>   File: /mnt/test/sub1
>   Size: 8               Blocks: 0          IO Block: 4096   directory
> Device: 34h/52d Inode: 256         Links: 1
> Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2021-06-18 13:51:14.463621411 +0800
> Modify: 2021-06-12 21:59:10.598089917 +0800
> Change: 2021-06-12 21:59:10.598089917 +0800
>  Birth: -
>=20
> 'stat' command should cause nfs/crossmnt to happen auto, and then return
> the 'stat' result?
>=20
>=20
> > As sub1 is considered a different file system, it should have a
> > different dev number.  NFS will assign a different device number only
> > when the server reports a different fsid.  The Linux NFS server will
> > report a different fsid if d_mountpoint() is 'true' for the dentry, and
> > follow_down() results in no change the the vfsmnt,dentry in a 'struct
> > path'.
> >=20
> > You have already said that d_mountpoint doesn't work for btrfs, so that
> > is part of the problem.  NFSD doesn't trust d_mountpoint completely as
> > it only reports that the dentry is a mountpoint in some namespace, not
> > necessarily in this namespace.  So you really need to fix
> > nfsd_mountpoint.
> >=20
> > I suggest you try adding your "dirty fix" to nfsd_mountpoint() so that
> > it reports the root of a btrfs subvol as a mountpoint, and see if that
> > fixes the problem.  It should change the problem at least.  You would
> > need to get nfsd_mountpoint() to return '1' in this case, not '2'.
> >=20
> > NeilBrown
>=20
> I changed the return value from 2 to 1.
>         if (nfsd4_is_junction(dentry))
>                 return 1;
> +       if (is_btrfs_subvol_d(dentry))
> +               return 1;
>         if (d_mountpoint(dentry))
>=20
> but the crossmnt still does not happen auto.
>=20
> I tried to mount the subvol manual,=20
> # mount.nfs4 T7610:/mnt/test/sub1 /nfs/test/sub1
> mount.nfs4: Stale file handle
>=20
> we add trace to is_btrfs_subvol_d(), it works as expected.
> +static inline bool is_btrfs_subvol_d(const struct dentry *dentry)
> +{
> +    bool ret=3D dentry->d_inode && dentry->d_inode->i_ino =3D=3D 256ULL &&
> +		dentry->d_sb && dentry->d_sb->s_magic =3D=3D 0x9123683E;
> +	printk(KERN_INFO "is_btrfs_subvol_d(%s)=3D%d\n", dentry->d_name.name, ret=
);
> +	return ret;
> +}
>=20
> It seems more fixes are needed.

I think the problem is that the submount doesn't appear in /proc/mounts.
"nfsd_fh()" in nfs-utils needs to be able to map from the uuid for a
filesystem to the mount point.  To do this it walks through /proc/mounts
checking the uuid of each filesystem.  If a filesystem isn't listed
there, it obviously fails.

I guess you could add code to nfs-utils to do whatever "btrfs subvol
list" does to make up for the fact that btrfs doesn't register in
/proc/mounts.

NeilBrown
