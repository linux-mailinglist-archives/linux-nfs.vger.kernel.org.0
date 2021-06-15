Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488E33A83BB
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jun 2021 17:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFOPP0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 11:15:26 -0400
Received: from out20-15.mail.aliyun.com ([115.124.20.15]:53335 "EHLO
        out20-15.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhFOPP0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 11:15:26 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0461472|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.235363-0.00113347-0.763503;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KSiKe4N_1623769997;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KSiKe4N_1623769997)
          by smtp.aliyun-inc.com(10.147.41.187);
          Tue, 15 Jun 2021 23:13:18 +0800
Date:   Tue, 15 Jun 2021 23:13:18 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "NeilBrown" <neilb@suse.de>
Subject: Re: any idea about auto export multiple btrfs snapshots?
Cc:     linux-nfs@vger.kernel.org
In-Reply-To: <162371103543.23575.13662722966178222587@noble.neil.brown.name>
References: <20210613115313.BC59.409509F4@e16-tech.com> <162371103543.23575.13662722966178222587@noble.neil.brown.name>
Message-Id: <20210615231318.F40F.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, NeilBrown

> On Sun, 13 Jun 2021, Wang Yugui wrote:
> > Hi,
> > 
> > Any idea about auto export multiple btrfs snapshots?
> > 
> > One related patch is yet not merged to nfs-utils 2.5.3.
> > From:   "NeilBrown" <neilb@suse.de>
> > Subject: [PATCH/RFC v2 nfs-utils] Fix NFSv4 export of tmpfs filesystems.
> > 
> > In this patch, an UUID is auto generated when a tmpfs have no UUID.
> > 
> > for btrfs, multiple subvolume snapshot have the same filesystem UUID.
> > Could we generate an UUID for btrfs subvol with 'filesystem UUID' + 'subvol ID'?
> 
> You really need to ask this question of btrfs developers.  'mountd'
> already has a special-case exception for btrfs, to prefer the uuid
> provided by statfs64() rather than the uuid extracted from the block
> device.  It would be quite easy to add another exception.
> But it would only be reasonable to do that if the btrfs team told us how
> that wanted us to generate a UUID for a given mount point, and promised
> that would always provide a unique stable result.
> This is completely separate from the tmpfs patch you identified.

Thanks a lot for the replay.

Now btrfs statfs64() return 8 byte unique/stable result.

It is based on two parts.
1) 16 byte blkid of file system. this is uniq/stable between btrfs filesystems.
2) 8 byte of btrfs sub volume objectid. this is uniq/stable inside a
btrfs filesystem.

the code of linux/fs/btrfs
static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)

    /* We treat it as constant endianness (it doesn't matter _which_)
       because we want the fsid to come out the same whether mounted
       on a big-endian or little-endian host */
    buf->f_fsid.val[0] = be32_to_cpu(fsid[0]) ^ be32_to_cpu(fsid[2]);
    buf->f_fsid.val[1] = be32_to_cpu(fsid[1]) ^ be32_to_cpu(fsid[3]);
    /* Mask in the root object ID too, to disambiguate subvols */
    buf->f_fsid.val[0] ^=
        BTRFS_I(d_inode(dentry))->root->root_key.objectid >> 32;
    buf->f_fsid.val[1] ^=
        BTRFS_I(d_inode(dentry))->root->root_key.objectid;


for nfs, we need a 16 byte UUID now.

The best way I though:
16 byte blkid , math add 8 byte btrfs sub volume objectid.
but there is yet no a simple/easy way to get the raw value of 'btrfs sub
volume objectid'.

A simple but good enough way:
1) first 8 byte copy from blkid
2) second 8 byte copy from btrfs_statfs()
	the uniq/stable of multiple subvolume inside a btrfs filesystem is kept.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/15

