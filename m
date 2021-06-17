Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED243AAA18
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jun 2021 06:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhFQEbX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Jun 2021 00:31:23 -0400
Received: from out20-27.mail.aliyun.com ([115.124.20.27]:51219 "EHLO
        out20-27.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQEbA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Jun 2021 00:31:00 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04437152|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0255494-0.00110153-0.973349;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KTaF.tm_1623904132;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KTaF.tm_1623904132)
          by smtp.aliyun-inc.com(10.147.41.199);
          Thu, 17 Jun 2021 12:28:52 +0800
Date:   Thu, 17 Jun 2021 12:28:53 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "NeilBrown" <neilb@suse.de>
Subject: Re: any idea about auto export multiple btrfs snapshots?
Cc:     linux-nfs@vger.kernel.org
In-Reply-To: <162389895501.29912.12470238090250719500@noble.neil.brown.name>
References: <20210615231318.F40F.409509F4@e16-tech.com> <162389895501.29912.12470238090250719500@noble.neil.brown.name>
Message-Id: <20210617122852.BE6A.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> On Wed, 16 Jun 2021, Wang Yugui wrote:
> > Hi, NeilBrown
> > 
> > > On Sun, 13 Jun 2021, Wang Yugui wrote:
> > > > Hi,
> > > > 
> > > > Any idea about auto export multiple btrfs snapshots?
> > > > 
> > > > One related patch is yet not merged to nfs-utils 2.5.3.
> > > > From:   "NeilBrown" <neilb@suse.de>
> > > > Subject: [PATCH/RFC v2 nfs-utils] Fix NFSv4 export of tmpfs filesystems.
> > > > 
> > > > In this patch, an UUID is auto generated when a tmpfs have no UUID.
> > > > 
> > > > for btrfs, multiple subvolume snapshot have the same filesystem UUID.
> > > > Could we generate an UUID for btrfs subvol with 'filesystem UUID' + 'subvol ID'?
> > > 
> > > You really need to ask this question of btrfs developers.  'mountd'
> > > already has a special-case exception for btrfs, to prefer the uuid
> > > provided by statfs64() rather than the uuid extracted from the block
> > > device.  It would be quite easy to add another exception.
> > > But it would only be reasonable to do that if the btrfs team told us how
> > > that wanted us to generate a UUID for a given mount point, and promised
> > > that would always provide a unique stable result.
> > > This is completely separate from the tmpfs patch you identified.
> > 
> > Thanks a lot for the replay.
> > 
> > Now btrfs statfs64() return 8 byte unique/stable result.
> > 
> > It is based on two parts.
> > 1) 16 byte blkid of file system. this is uniq/stable between btrfs filesystems.
> > 2) 8 byte of btrfs sub volume objectid. this is uniq/stable inside a
> > btrfs filesystem.
> > 
> > the code of linux/fs/btrfs
> > static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> > 
> >     /* We treat it as constant endianness (it doesn't matter _which_)
> >        because we want the fsid to come out the same whether mounted
> >        on a big-endian or little-endian host */
> >     buf->f_fsid.val[0] = be32_to_cpu(fsid[0]) ^ be32_to_cpu(fsid[2]);
> >     buf->f_fsid.val[1] = be32_to_cpu(fsid[1]) ^ be32_to_cpu(fsid[3]);
> >     /* Mask in the root object ID too, to disambiguate subvols */
> >     buf->f_fsid.val[0] ^=
> >         BTRFS_I(d_inode(dentry))->root->root_key.objectid >> 32;
> >     buf->f_fsid.val[1] ^=
> >         BTRFS_I(d_inode(dentry))->root->root_key.objectid;
> > 
> > 
> > for nfs, we need a 16 byte UUID now.
> > 
> > The best way I though:
> > 16 byte blkid , math add 8 byte btrfs sub volume objectid.
> > but there is yet no a simple/easy way to get the raw value of 'btrfs sub
> > volume objectid'.
> 
> I'm a bit confused now.  You started out talking about snapshots, but
> now you are talking about sub volumes.  Are they the same thing?
> 
> NFS export of btrfs sub volumes has worked for the past 10 years I
> believe.
> 
> Can we go back to the beginning.  What, exactly, is the problem you are
> trying to solve?  How can you demonstrate the problem?
> 
> NeilBrown

I nfs/exported a btrfs with 2 subvols and 2 snapshot(subvol).

# btrfs subvolume list /mnt/test
ID 256 gen 53 top level 5 path sub1
ID 260 gen 56 top level 5 path sub2
ID 261 gen 57 top level 5 path .snapshot/sub1-s1
ID 262 gen 57 top level 5 path .snapshot/sub2-s1

and then mount.nfs4 it to /nfs/test.

# /bin/find /nfs/test/
/nfs/test/
find: File system loop detected; ¡®/nfs/test/sub1¡¯ is part of the same file system loop as ¡®/nfs/test/¡¯.
/nfs/test/.snapshot
find: File system loop detected; ¡®/nfs/test/.snapshot/sub1-s1¡¯ is part of the same file system loop as ¡®/nfs/test/¡¯.
find: File system loop detected; ¡®/nfs/test/.snapshot/sub2-s1¡¯ is part of the same file system loop as ¡®/nfs/test/¡¯.
/nfs/test/dir1
/nfs/test/dir1/a.txt
find: File system loop detected; ¡®/nfs/test/sub2¡¯ is part of the same file system loop as ¡®/nfs/test/¡¯

/bin/find report 'File system loop detected'. so I though there is
something wrong.

but when I checked the file content through /mnt/test and /nfs/test,
the file through /mnt/test/xxx and /nfs/test/xxx return the same result.

I have used nfs/crossmnt, and then I thought that btrfs subvol/snapshot
support is through 'nfs/crossmnt' feature. but in fact, it is not
through nfs/crossmnt feature?

/bin/find report 'File system loop detected', it means that vfs cache on
nfs client side will have some problem?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/17


