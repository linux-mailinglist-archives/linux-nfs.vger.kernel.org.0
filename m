Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7E73A9161
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 07:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhFPFtQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 01:49:16 -0400
Received: from out20-97.mail.aliyun.com ([115.124.20.97]:35886 "EHLO
        out20-97.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhFPFtO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 01:49:14 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04508309|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.433153-0.00164647-0.5652;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KT0hfmF_1623822422;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KT0hfmF_1623822422)
          by smtp.aliyun-inc.com(10.147.41.187);
          Wed, 16 Jun 2021 13:47:02 +0800
Date:   Wed, 16 Jun 2021 13:47:02 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "NeilBrown" <neilb@suse.de>, linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-Reply-To: <20210615231318.F40F.409509F4@e16-tech.com>
References: <162371103543.23575.13662722966178222587@noble.neil.brown.name> <20210615231318.F40F.409509F4@e16-tech.com>
Message-Id: <20210616134702.A114.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> Hi, NeilBrown
> 
> > On Sun, 13 Jun 2021, Wang Yugui wrote:
> > > Hi,
> > > 
> > > Any idea about auto export multiple btrfs snapshots?
> > > 
> > > One related patch is yet not merged to nfs-utils 2.5.3.
> > > From:   "NeilBrown" <neilb@suse.de>
> > > Subject: [PATCH/RFC v2 nfs-utils] Fix NFSv4 export of tmpfs filesystems.
> > > 
> > > In this patch, an UUID is auto generated when a tmpfs have no UUID.
> > > 
> > > for btrfs, multiple subvolume snapshot have the same filesystem UUID.
> > > Could we generate an UUID for btrfs subvol with 'filesystem UUID' + 'subvol ID'?
> > 
> > You really need to ask this question of btrfs developers.  'mountd'
> > already has a special-case exception for btrfs, to prefer the uuid
> > provided by statfs64() rather than the uuid extracted from the block
> > device.  It would be quite easy to add another exception.
> > But it would only be reasonable to do that if the btrfs team told us how
> > that wanted us to generate a UUID for a given mount point, and promised
> > that would always provide a unique stable result.
> > This is completely separate from the tmpfs patch you identified.
> 
> Thanks a lot for the replay.
> 
> Now btrfs statfs64() return 8 byte unique/stable result.
> 
> It is based on two parts.
> 1) 16 byte blkid of file system. this is uniq/stable between btrfs filesystems.
> 2) 8 byte of btrfs sub volume objectid. this is uniq/stable inside a
> btrfs filesystem.
> 
> the code of linux/fs/btrfs
> static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> 
>     /* We treat it as constant endianness (it doesn't matter _which_)
>        because we want the fsid to come out the same whether mounted
>        on a big-endian or little-endian host */
>     buf->f_fsid.val[0] = be32_to_cpu(fsid[0]) ^ be32_to_cpu(fsid[2]);
>     buf->f_fsid.val[1] = be32_to_cpu(fsid[1]) ^ be32_to_cpu(fsid[3]);
>     /* Mask in the root object ID too, to disambiguate subvols */
>     buf->f_fsid.val[0] ^=
>         BTRFS_I(d_inode(dentry))->root->root_key.objectid >> 32;
>     buf->f_fsid.val[1] ^=
>         BTRFS_I(d_inode(dentry))->root->root_key.objectid;
> 
> 
> for nfs, we need a 16 byte UUID now.
> 
> The best way I though:
> 16 byte blkid , math add 8 byte btrfs sub volume objectid.
> but there is yet no a simple/easy way to get the raw value of 'btrfs sub
> volume objectid'.

The btrfs subvol objectid (8byte) can be extracted from the
statfs.f_fsid(8 byte) with the help of blkid(16btye) of the btrfs file
system just do a revert cacl in btrfs_statfs().

if we need 8 byte id for btrfs subvol, just use statfs.f_fsid.

if we need 16 byte id for btrfs subvol, use the blkid(16btye) of the
btrfs filesystem, plus the btrfs subvol objectid (8byte) , and keep 
the result in 16 byte.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/16



> A simple but good enough way:
> 1) first 8 byte copy from blkid
> 2) second 8 byte copy from btrfs_statfs()
> 	the uniq/stable of multiple subvolume inside a btrfs filesystem is kept.
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/06/15


