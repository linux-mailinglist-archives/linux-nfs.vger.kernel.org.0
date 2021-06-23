Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709EF3B16F5
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jun 2021 11:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFWJgU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 05:36:20 -0400
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:48654 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJgU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 05:36:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04449416|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0332679-0.00228032-0.964452;FP=0|0|0|0|0|0|0|0;HT=ay29a033018047212;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KWkV1zH_1624440841;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KWkV1zH_1624440841)
          by smtp.aliyun-inc.com(10.147.41.158);
          Wed, 23 Jun 2021 17:34:01 +0800
Date:   Wed, 23 Jun 2021 17:34:03 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "NeilBrown" <neilb@suse.de>
Subject: Re: any idea about auto export multiple btrfs snapshots?
Cc:     linux-nfs@vger.kernel.org
In-Reply-To: <162442979121.28671.4357679695701460832@noble.neil.brown.name>
References: <20210623141444.C4F2.409509F4@e16-tech.com> <162442979121.28671.4357679695701460832@noble.neil.brown.name>
Message-Id: <20210623173403.08C2.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------_60D2FD310000000008BD_MULTIPART_MIXED_"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------_60D2FD310000000008BD_MULTIPART_MIXED_
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi,

> On Wed, 23 Jun 2021, Wang Yugui wrote:
> > Hi,
> > 
> > This patch works very well. Thanks a lot.
> > -  crossmnt of btrfs subvol works as expected.
> > -  nfs/umount subvol works well.
> > -  pseudo mount point inode(255) is good.
> > 
> > I test it in 5.10.45 with a few minor rebase.
> > ( see 0001-any-idea-about-auto-export-multiple-btrfs-snapshots.patch,
> > just fs/nfsd/nfs3xdr.c rebase)
> > 
> > But when I tested it with another btrfs system without subvol but with
> > more data, 'find /nfs/test' caused a OOPS .  and this OOPS will not
> > happen just without this patch.
> > 
> > The data in this filesystem is created/left by xfstest(FSTYP=nfs,
> > TEST_DEV).
> > 
> > #nfs4 option: default mount.nfs4, nfs-utils-2.3.3
> > 
> > # access btrfs directly
> > $ find /mnt/test | wc -l
> > 6612
> > 
> > # access btrfs through nfs
> > $ find /nfs/test | wc -l
> > 
> > [  466.164329] BUG: kernel NULL pointer dereference, address: 0000000000000004
> > [  466.172123] #PF: supervisor read access in kernel mode
> > [  466.177857] #PF: error_code(0x0000) - not-present page
> > [  466.183601] PGD 0 P4D 0
> > [  466.186443] Oops: 0000 [#1] SMP NOPTI
> > [  466.190536] CPU: 27 PID: 1819 Comm: nfsd Not tainted 5.10.45-7.el7.x86_64 #1
> > [  466.198418] Hardware name: Dell Inc. PowerEdge T620/02CD1V, BIOS 2.9.0 12/06/2019
> > [  466.206806] RIP: 0010:fsid_source+0x7/0x50 [nfsd]
> 
> in nfsd4_encode_fattr there is code:
> 
> 	if ((bmval0 & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) && !fhp) {
> 		tempfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
> 		status = nfserr_jukebox;
> 		if (!tempfh)
> 			goto out;
> 		fh_init(tempfh, NFS4_FHSIZE);
> 		status = fh_compose(tempfh, exp, dentry, NULL);
> 		if (status)
> 			goto out;
> 		fhp = tempfh;
> 	}
> 
> Change that to test for (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) as
> well.
> 
> NeilBrown


It works well.

-	if ((bmval0 & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) && !fhp) {
+	if (((bmval0 & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) ||
+		 (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID))
+		 && !fhp) {
 		tempfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
 		status = nfserr_jukebox;
 		if (!tempfh)


And I tested some case about statfs.f_fsid conflict between btrfs
filesystem, and it works well too. 

Is it safe in theory too?

test case:
two btrfs filesystem with just 1 bit diff of UUID
# blkid /dev/sdb1 /dev/sdb2
/dev/sdb1: UUID="35327ecf-a5a7-4617-a160-1fdbfd644940" UUID_SUB="a831ebde-1e66-4592-bfde-7a86fd6478b5" BLOCK_SIZE="4096" TYPE="btrfs" PARTLABEL="primary" PARTUUID="3e30a849-88db-4fb3-92e6-b66bfbe9cb98"
/dev/sdb2: UUID="35327ecf-a5a7-4617-a160-1fdbfd644941" UUID_SUB="31e07d66-a656-48a8-b1fb-5b438565238e" BLOCK_SIZE="4096" TYPE="btrfs" PARTLABEL="primary" PARTUUID="93a2db85-065a-4ecf-89d4-6a8dcdb8ff99"

both have 3 subvols.
# btrfs subvolume list /mnt/test
ID 256 gen 13 top level 5 path sub1
ID 257 gen 13 top level 5 path sub2
ID 258 gen 13 top level 5 path sub3
# btrfs subvolume list /mnt/scratch
ID 256 gen 13 top level 5 path sub1
ID 257 gen 13 top level 5 path sub2
ID 258 gen 13 top level 5 path sub3


statfs.f_fsid.c is the source of 'statfs' command.

# statfs /mnt/test/sub1 /mnt/test/sub2 /mnt/test/sub3 /mnt/scratch/sub1 /mnt/scratch/sub2 /mnt/scratch/sub3
/mnt/test/sub1
        f_fsid=0x9452611458c30e57
/mnt/test/sub2
        f_fsid=0x9452611458c30e56
/mnt/test/sub3
        f_fsid=0x9452611458c30e55
/mnt/scratch/sub1
        f_fsid=0x9452611458c30e56
/mnt/scratch/sub2
        f_fsid=0x9452611458c30e57
/mnt/scratch/sub3
        f_fsid=0x9452611458c30e54

statfs.f_fsid is uniq inside a btrfs and it's subvols.
but statfs.f_fsid is NOT uniq between btrfs filesystems because just 1
bit diff of UUID.

'find /mnt/test/' and 'find /mnt/scratch/' works as expected.


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/23


--------_60D2FD310000000008BD_MULTIPART_MIXED_
Content-Type: application/octet-stream;
 name="statfs.f_fsid.c"
Content-Disposition: attachment;
 filename="statfs.f_fsid.c"
Content-Transfer-Encoding: base64

I2RlZmluZSBfX1VTRV9MQVJHRUZJTEU2NAoKI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxz
dGRpby5oPgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5oPgojaW5j
bHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzeXMvc3RhdGZzLmg+CgppbnQgbWFpbihpbnQgYXJn
YywgY2hhciAqKmFyZ3YpCnsKCQlzdHJ1Y3Qgc3RhdGZzIHN0OwoJCWNoYXIgKnBhdGg7CgkJaW50
IHJldD0wOwoKCQlpZiAoYXJnYyA8IDIpIHsKCQkJCWZwcmludGYoc3RkZXJyLCAiVXNhZ2U6JXMg
cGF0aCBbcGF0aF0uLiBcbiIsIGFyZ3ZbMF0pOwoJCQkJcmV0dXJuIDE7CgkJfQoJCWZvciAoaW50
IGkgPSAxOyBpIDwgYXJnYzsgKytpKSB7CgkJCQlwYXRoID0gYXJndltpXTsKCQkJCWlmIChzdGF0
ZnMocGF0aCwgJnN0KSA9PSAwICYmCgkJCQkJKHN0LmZfZnNpZC5fX3ZhbFswXSB8fCBzdC5mX2Zz
aWQuX192YWxbMV0pKSB7CgkJCQkJCWZwcmludGYoc3Rkb3V0LCAiJXNcblx0Zl9mc2lkPTB4JTA4
eCUwOHhcbiIsIHBhdGgsCgkJCQkJCQkJc3QuZl9mc2lkLl9fdmFsWzBdLCBzdC5mX2ZzaWQuX192
YWxbMV0pOwoJCQkJfSBlbHNlIHsKCQkJCQkJZnByaW50ZihzdGRvdXQsICIlc1xuXHRzdGF0ZnMg
ZXJyb3Igb3IgbnVsbCBmX2ZzaWQuXG4iLHBhdGgpOwoJCQkJCQlyZXQ9MTsKCQkJCX0KCQl9CgkJ
cmV0dXJuIHJldDsKfQo=
--------_60D2FD310000000008BD_MULTIPART_MIXED_--

