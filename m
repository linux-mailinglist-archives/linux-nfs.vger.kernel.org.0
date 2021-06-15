Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E703A8435
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jun 2021 17:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhFOPnK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 11:43:10 -0400
Received: from out20-74.mail.aliyun.com ([115.124.20.74]:48915 "EHLO
        out20-74.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhFOPnK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 11:43:10 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04467168|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.732369-0.00460715-0.263024;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KSiwkGl_1623771663;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KSiwkGl_1623771663)
          by smtp.aliyun-inc.com(10.147.42.135);
          Tue, 15 Jun 2021 23:41:03 +0800
Date:   Tue, 15 Jun 2021 23:41:04 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "NeilBrown" <neilb@suse.de>, linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-Reply-To: <20210615231318.F40F.409509F4@e16-tech.com>
References: <162371103543.23575.13662722966178222587@noble.neil.brown.name> <20210615231318.F40F.409509F4@e16-tech.com>
Message-Id: <20210615234103.F413.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, NeilBrown

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
> 
> A simple but good enough way:
> 1) first 8 byte copy from blkid
> 2) second 8 byte copy from btrfs_statfs()
> 	the uniq/stable of multiple subvolume inside a btrfs filesystem is kept.

By the way, the random 16 byte UUID still have very little chance to
conflict.

Could we keep the first 4 byte of the UUID of nfs/tmpfs alwasy ZERO?  ,
the first 4 byte zero will limit the conflict inside nfs/tmpfs, and it is
easy to diag.

Here we use the first same 8 byte for UUID of btrfs and nfs/btrfs, 
so it is easy to diag too.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/15


