Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D49F3455CF
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 03:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhCWC6O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 22:58:14 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47159 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbhCWC5w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 22:57:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UT1O3RM_1616468270;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UT1O3RM_1616468270)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Mar 2021 10:57:50 +0800
Date:   Tue, 23 Mar 2021 10:57:50 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] nfs: hornor timeo and retrans option when mounting
 NFSv3
Message-ID: <20210323025750.GF95214@e18g06458.et15sqa>
References: <20210322052904.83508-1-eguan@linux.alibaba.com>
 <5b0d0bf03b7bcb1562588aa8137df22964a246db.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b0d0bf03b7bcb1562588aa8137df22964a246db.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 22, 2021 at 03:53:01PM +0000, Trond Myklebust wrote:
> On Mon, 2021-03-22 at 13:29 +0800, Eryu Guan wrote:
> > Mounting NFSv3 uses default timeout parameters specified by underlying
> > sunrpc transport, and mount options like 'timeo' and 'retrans', unlike
> > NFSv4, are not honored.
> > 
> > But sometimes we want to set non-default timeout value when mounting
> > NFSv3, so pass 'timeo' and 'retrans' to nfs_mount() and fill the
> > 'timeout' field of struct rpc_create_args before creating RPC
> > connection. This is also consistent with NFSv4 behavior.
> > 
> > Note that this only sets the timeout value of rpc connection to mountd,
> > but the timeout of rpcbind connection should be set as well. A later
> > patch will fix the rpcbind part.
> > 
> > Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
> > ---
> >  fs/nfs/internal.h   |  2 +-
> >  fs/nfs/mount_clnt.c | 12 +++++++-----
> >  fs/nfs/super.c      |  2 +-
> >  3 files changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> > index 7b644d6c09e4..cf0d7db24d44 100644
> > --- a/fs/nfs/internal.h
> > +++ b/fs/nfs/internal.h
> > @@ -180,7 +180,7 @@ struct nfs_mount_request {
> >         struct net              *net;
> >  };
> >  
> > -extern int nfs_mount(struct nfs_mount_request *info);
> > +extern int nfs_mount(struct nfs_mount_request *info, int timeo, int
> > retrans);
> >  extern void nfs_umount(const struct nfs_mount_request *info);
> >  
> >  /* client.c */
> > diff --git a/fs/nfs/mount_clnt.c b/fs/nfs/mount_clnt.c
> > index dda5c3e65d8d..248319254672 100644
> > --- a/fs/nfs/mount_clnt.c
> > +++ b/fs/nfs/mount_clnt.c
> > @@ -137,13 +137,13 @@ struct mnt_fhstatus {
> >   * nfs_mount - Obtain an NFS file handle for the given host and path
> >   * @info: pointer to mount request arguments
> >   *
> > - * Uses default timeout parameters specified by underlying transport.
> > On
> > - * successful return, the auth_flavs list and auth_flav_len will be
> > populated
> > - * with the list from the server or a faked-up list if the server
> > didn't
> > - * provide one.
> > + * Uses timeout parameters specified by caller. On successful return,
> > the
> > + * auth_flavs list and auth_flav_len will be populated with the list
> > from the
> > + * server or a faked-up list if the server didn't provide one.
> >   */
> > -int nfs_mount(struct nfs_mount_request *info)
> > +int nfs_mount(struct nfs_mount_request *info, int timeo, int retrans)
> 
> 
> fs/nfs/mount_clnt.c:145: warning: Function parameter or member 'timeo'
> not described in 'nfs_mount'
> fs/nfs/mount_clnt.c:145: warning: Function parameter or member
> 'retrans' not described in 'nfs_mount'

Fixed in v2, thanks!

Eryu

> 
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
