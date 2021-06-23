Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674CA3B23FB
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 01:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhFWXkg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 19:40:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59958 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWXkf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 19:40:35 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E95991FD66;
        Wed, 23 Jun 2021 23:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624491496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4usO9qBj0zmmW8sFJyypKh+P3K97ceT3cJ+C5yYkWZ0=;
        b=u0WfFqjPr7SVs3PFl8q+xAmggt1NIv2JGCu+5mqRaF+cDA25H24l5E8nwRnU+wgavsnOXK
        +yi2QBMxiU4tqxnuxihboIa7R+9oIRcFml4nCEx0SnbbjfZr2xa55gs0mWDegi92kk0m+c
        D1ja3n0n0qlBSZjVJ+/hGGGKAqjohMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624491496;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4usO9qBj0zmmW8sFJyypKh+P3K97ceT3cJ+C5yYkWZ0=;
        b=STa0J3EY3dN/E0OcoEPjfveX2Y4X5HX7qjGwINlRs9zGMfDIajscYEHi2gXw06iBRsDFU4
        ikqyL0uH2Qga+QCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E3F2511A97;
        Wed, 23 Jun 2021 23:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624491496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4usO9qBj0zmmW8sFJyypKh+P3K97ceT3cJ+C5yYkWZ0=;
        b=u0WfFqjPr7SVs3PFl8q+xAmggt1NIv2JGCu+5mqRaF+cDA25H24l5E8nwRnU+wgavsnOXK
        +yi2QBMxiU4tqxnuxihboIa7R+9oIRcFml4nCEx0SnbbjfZr2xa55gs0mWDegi92kk0m+c
        D1ja3n0n0qlBSZjVJ+/hGGGKAqjohMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624491496;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4usO9qBj0zmmW8sFJyypKh+P3K97ceT3cJ+C5yYkWZ0=;
        b=STa0J3EY3dN/E0OcoEPjfveX2Y4X5HX7qjGwINlRs9zGMfDIajscYEHi2gXw06iBRsDFU4
        ikqyL0uH2Qga+QCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id WPODJOfF02DRVAAALh3uQQ
        (envelope-from <neilb@suse.de>); Wed, 23 Jun 2021 23:38:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wang Yugui" <wangyugui@e16-tech.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-reply-to: <20210623173403.08C2.409509F4@e16-tech.com>
References: <20210623141444.C4F2.409509F4@e16-tech.com>,
 <162442979121.28671.4357679695701460832@noble.neil.brown.name>,
 <20210623173403.08C2.409509F4@e16-tech.com>
Date:   Thu, 24 Jun 2021 09:38:12 +1000
Message-id: <162449149249.28671.872540415366683072@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 23 Jun 2021, Wang Yugui wrote:
> Hi,
>=20
> > On Wed, 23 Jun 2021, Wang Yugui wrote:
> > > Hi,
> > >=20
> > > This patch works very well. Thanks a lot.
> > > -  crossmnt of btrfs subvol works as expected.
> > > -  nfs/umount subvol works well.
> > > -  pseudo mount point inode(255) is good.
> > >=20
> > > I test it in 5.10.45 with a few minor rebase.
> > > ( see 0001-any-idea-about-auto-export-multiple-btrfs-snapshots.patch,
> > > just fs/nfsd/nfs3xdr.c rebase)
> > >=20
> > > But when I tested it with another btrfs system without subvol but with
> > > more data, 'find /nfs/test' caused a OOPS .  and this OOPS will not
> > > happen just without this patch.
> > >=20
> > > The data in this filesystem is created/left by xfstest(FSTYP=3Dnfs,
> > > TEST_DEV).
> > >=20
> > > #nfs4 option: default mount.nfs4, nfs-utils-2.3.3
> > >=20
> > > # access btrfs directly
> > > $ find /mnt/test | wc -l
> > > 6612
> > >=20
> > > # access btrfs through nfs
> > > $ find /nfs/test | wc -l
> > >=20
> > > [  466.164329] BUG: kernel NULL pointer dereference, address: 000000000=
0000004
> > > [  466.172123] #PF: supervisor read access in kernel mode
> > > [  466.177857] #PF: error_code(0x0000) - not-present page
> > > [  466.183601] PGD 0 P4D 0
> > > [  466.186443] Oops: 0000 [#1] SMP NOPTI
> > > [  466.190536] CPU: 27 PID: 1819 Comm: nfsd Not tainted 5.10.45-7.el7.x=
86_64 #1
> > > [  466.198418] Hardware name: Dell Inc. PowerEdge T620/02CD1V, BIOS 2.9=
.0 12/06/2019
> > > [  466.206806] RIP: 0010:fsid_source+0x7/0x50 [nfsd]
> >=20
> > in nfsd4_encode_fattr there is code:
> >=20
> > 	if ((bmval0 & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) && !fhp) {
> > 		tempfh =3D kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
> > 		status =3D nfserr_jukebox;
> > 		if (!tempfh)
> > 			goto out;
> > 		fh_init(tempfh, NFS4_FHSIZE);
> > 		status =3D fh_compose(tempfh, exp, dentry, NULL);
> > 		if (status)
> > 			goto out;
> > 		fhp =3D tempfh;
> > 	}
> >=20
> > Change that to test for (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) as
> > well.
> >=20
> > NeilBrown
>=20
>=20
> It works well.
>=20
> -	if ((bmval0 & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) && !fhp) {
> +	if (((bmval0 & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) ||
> +		 (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID))
> +		 && !fhp) {
>  		tempfh =3D kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
>  		status =3D nfserr_jukebox;
>  		if (!tempfh)

Good. Thanks for testing.

>=20
>=20
> And I tested some case about statfs.f_fsid conflict between btrfs
> filesystem, and it works well too.=20
>=20
> Is it safe in theory too?

Probably .... :-)

>=20
> test case:
> two btrfs filesystem with just 1 bit diff of UUID
> # blkid /dev/sdb1 /dev/sdb2
> /dev/sdb1: UUID=3D"35327ecf-a5a7-4617-a160-1fdbfd644940" UUID_SUB=3D"a831eb=
de-1e66-4592-bfde-7a86fd6478b5" BLOCK_SIZE=3D"4096" TYPE=3D"btrfs" PARTLABEL=
=3D"primary" PARTUUID=3D"3e30a849-88db-4fb3-92e6-b66bfbe9cb98"
> /dev/sdb2: UUID=3D"35327ecf-a5a7-4617-a160-1fdbfd644941" UUID_SUB=3D"31e07d=
66-a656-48a8-b1fb-5b438565238e" BLOCK_SIZE=3D"4096" TYPE=3D"btrfs" PARTLABEL=
=3D"primary" PARTUUID=3D"93a2db85-065a-4ecf-89d4-6a8dcdb8ff99"

Having two UUIDs that differ in just one bit would be somewhat unusual.

>=20
> both have 3 subvols.
> # btrfs subvolume list /mnt/test
> ID 256 gen 13 top level 5 path sub1
> ID 257 gen 13 top level 5 path sub2
> ID 258 gen 13 top level 5 path sub3
> # btrfs subvolume list /mnt/scratch
> ID 256 gen 13 top level 5 path sub1
> ID 257 gen 13 top level 5 path sub2
> ID 258 gen 13 top level 5 path sub3
>=20
>=20
> statfs.f_fsid.c is the source of 'statfs' command.

You can use "stat -f".

>=20
> # statfs /mnt/test/sub1 /mnt/test/sub2 /mnt/test/sub3 /mnt/scratch/sub1 /mn=
t/scratch/sub2 /mnt/scratch/sub3
> /mnt/test/sub1
>         f_fsid=3D0x9452611458c30e57
> /mnt/test/sub2
>         f_fsid=3D0x9452611458c30e56
> /mnt/test/sub3
>         f_fsid=3D0x9452611458c30e55
> /mnt/scratch/sub1
>         f_fsid=3D0x9452611458c30e56
> /mnt/scratch/sub2
>         f_fsid=3D0x9452611458c30e57
> /mnt/scratch/sub3
>         f_fsid=3D0x9452611458c30e54
>=20
> statfs.f_fsid is uniq inside a btrfs and it's subvols.
> but statfs.f_fsid is NOT uniq between btrfs filesystems because just 1
> bit diff of UUID.

Maybe we should be using a hash function to mix the various numbers into
the fsid rather than a simple xor.

In general we have no guarantee that the stable identifier for each
filesystem is unique.  We rely on randomness and large numbers of bits
making collisions extremely unlikely.
Using xor doesn't help, but we would need some hash scheme that is
guaranteed to be stable.  Maybe the Jenkins Hash.

NeilBrown


>=20
> 'find /mnt/test/' and 'find /mnt/scratch/' works as expected.
>=20
>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/06/23
>=20
>=20
