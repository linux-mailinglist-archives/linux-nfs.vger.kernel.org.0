Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D93A9DDA
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 16:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhFPOnp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 10:43:45 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:54741 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234083AbhFPOno (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 10:43:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ucd2UNb_1623854494;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ucd2UNb_1623854494)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Jun 2021 22:41:36 +0800
Date:   Wed, 16 Jun 2021 22:41:34 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: set block size according to pnfs_blksize first
Message-ID: <YMoNnr1RYDOLXtKJ@B-P7TQMD6M-0146.local>
References: <1623847469-150122-1-git-send-email-hsiangkao@linux.alibaba.com>
 <4898aa11dc26396c13bbc3d8bf18c13efe4d513a.camel@hammerspace.com>
 <YMoFcdhVwMXJQPJ+@B-P7TQMD6M-0146.local>
 <2c14b63eacf1742bb0bcd2ae02f2d7005f7682d8.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c14b63eacf1742bb0bcd2ae02f2d7005f7682d8.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Wed, Jun 16, 2021 at 02:20:49PM +0000, Trond Myklebust wrote:
> On Wed, 2021-06-16 at 22:06 +0800, Gao Xiang wrote:
> > On Wed, Jun 16, 2021 at 01:47:13PM +0000, Trond Myklebust wrote:
> > > On Wed, 2021-06-16 at 20:44 +0800, Gao Xiang wrote:
> > > > When testing fstests with ext4 over nfs 4.2, I found generic/486
> > > > failed. The root cause is that the length of its xattr value is
> > > >   min(st_blksize * 3 / 4, XATTR_SIZE_MAX)
> > > > 
> > > > which is 4096 * 3 / 4 = 3072 for underlayfs ext4 rather than
> > > > XATTR_SIZE_MAX = 65536 for nfs since the block size would be
> > > > wsize
> > > > (=131072) if bsize is not specified.
> > > > 
> > > > Let's use pnfs_blksize first instead of using wsize directly if
> > > > bsize isn't specified. And the testcase itself can pass now.
> > > > 
> > > > Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > Cc: Anna Schumaker <anna.schumaker@netapp.com>
> > > > Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> > > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > > ---
> > > > Considering bsize is not specified, we might use pnfs_blksize
> > > > directly first rather than wsize.
> > > > 
> > > >  fs/nfs/super.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> > > > index fe58525cfed4..5015edf0cd9a 100644
> > > > --- a/fs/nfs/super.c
> > > > +++ b/fs/nfs/super.c
> > > > @@ -1068,9 +1068,13 @@ static void nfs_fill_super(struct
> > > > super_block
> > > > *sb, struct nfs_fs_context *ctx)
> > > >         snprintf(sb->s_id, sizeof(sb->s_id),
> > > >                  "%u:%u", MAJOR(sb->s_dev), MINOR(sb->s_dev));
> > > >  
> > > > -       if (sb->s_blocksize == 0)
> > > > -               sb->s_blocksize = nfs_block_bits(server->wsize,
> > > > +       if (sb->s_blocksize == 0) {
> > > > +               unsigned int blksize = server->pnfs_blksize ?
> > > > +                       server->pnfs_blksize : server->wsize;
> > > 
> > > NACK. The pnfs block size is a layout driver-specific quantity, and
> > > should not be used to substitute for the server-advertised block
> > > size.
> > > It only applies to I/O _if_ the client is holding a layout for a
> > > specific file and is using pNFS to do I/O to that file.
> > 
> > Honestly, I'm not sure if it's ok as well.
> > 
> > > 
> > > It has nothing to do with xattrs at all.
> > 
> > Yet my question is how to deal with generic/486, should we just skip
> > the case directly? I cannot find some proper way to get underlayfs
> > block size or real xattr value limit.
> > 
> 
> RFC8276 provides no method for determining the xattr size limits. It
> just notes that such limits may exist, and provides the error code
> NFS4ERR_XATTR2BIG, that the server may use as a return value when those
> limits are exceeded.
> 
> > For now, generic/486 will return ENOSPC at
> > fsetxattr(fd, "user.world", value, 65536, XATTR_REPLACE);
> > when testing new nfs4.2 xattr support.
> > 
> 
> As noted above, the NFS server should really be returning
> NFS4ERR_XATTR2BIG in this case, which the client, again, should be
> transforming into -E2BIG. Where does ENOSPC come from?

Thanks for the detailed explanation...

I think that is due to ext4 returning ENOSPC since I tested

fsetxattr(fd, "user.world", value, 65536, XATTR_REPLACE);
with ext4 as well and it returned ENOSPC, and I think it's reasonable
since setxattr() will return ENOSPC for such cases.
https://man7.org/linux/man-pages/man2/setxattr.2.html

should we transform it to E2BIG instead (at least in NFS
protocol)? but I'm still not sure that E2BIG is a valid return code for
setxattr()...

If necessary, I will look into it more tomorrow....

Thanks,
Gao Xiang

> 
> > Thanks,
> > Gao Xiang
> > 
> > > 
> > > > +
> > > > +               sb->s_blocksize = nfs_block_bits(blksize,
> > > >                                                  &sb-
> > > > > s_blocksize_bits);
> > > > +       }
> > > >  
> > > >         nfs_super_set_maxbytes(sb, server->maxfilesize);
> > > >         server->has_sec_mnt_opts = ctx->has_sec_mnt_opts;
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
