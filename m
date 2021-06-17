Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5363E3AA8E1
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jun 2021 04:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhFQCR7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 22:17:59 -0400
Received: from out20-75.mail.aliyun.com ([115.124.20.75]:37578 "EHLO
        out20-75.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhFQCR7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 22:17:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05980935|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.319709-0.00874698-0.671544;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KTW82DK_1623896150;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KTW82DK_1623896150)
          by smtp.aliyun-inc.com(10.147.41.138);
          Thu, 17 Jun 2021 10:15:50 +0800
Date:   Thu, 17 Jun 2021 10:15:51 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "NeilBrown" <neilb@suse.de>
Subject: Re: any idea about auto export multiple btrfs snapshots?
Cc:     linux-nfs@vger.kernel.org
In-Reply-To: <162371103543.23575.13662722966178222587@noble.neil.brown.name>
References: <20210613115313.BC59.409509F4@e16-tech.com> <162371103543.23575.13662722966178222587@noble.neil.brown.name>
Message-Id: <20210617101551.BE66.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

nfs need to treat btrfs subvols as different filesystems, so nfs need
crossmnt feature to support multiple btrfs subvol auto export?

It is yet not clear what prevent nfs/crossmnt from work well.

1, stat() and the result 'struct stat'
	btrfs subvol support it well.
	multiple subvols will have different st_dev of 'struct stat'.
	/bin/find works well too.

2, statfs() and the result 'struct statfs'
	btrfs subvol support it well.
	multiple subvols will have different f_fsid of 'struct statfs'.

3, stx_mnt_id of statx
	btrfs subvol does NOT support it well.
	but stx_mnt_id seems yet not used.

4, d_mountpoint() in kernel
	d_mountpoint() seems not support btrfs subvol.
	but we can add some dirty fix such as.

+//#define BTRFS_FIRST_FREE_OBJECTID 256ULL
+//#define BTRFS_SUPER_MAGIC    0x9123683E
+static inline bool is_btrfs_subvol_d(const struct dentry *dentry)
+{
+    return dentry->d_inode && dentry->d_inode->i_ino == 256ULL &&
+       dentry->d_sb && dentry->d_sb->s_magic == 0x9123683E;
+}

so the problem list is yet not clear.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/17

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
> 
> This is completely separate from the tmpfs patch you identified.
> 
> NeilBrown
> 
> 
> > 
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2021/06/13
> > 
> > 
> > 


