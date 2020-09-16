Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B220926CCDF
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Sep 2020 22:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgIPUuf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 16:50:35 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:29452 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgIPQzK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 12:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600275310; x=1631811310;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=6ob0BV7LnNRWdj/YzgA6m/Bpxb59FBXjuzFp1afNqa0=;
  b=amcMWvjPsMpobV1ex/TIF0g9z1EFYnAESVbZ5/gqpxtgOIqJIrQFI48V
   7ikdTqET/XLW2xVEF0PXuoEGASMNU9JFRMax9UhStM7FkmwAOI/Gg4jeS
   LGQIvBW9PwGGvKvgXCJOIM3Uz++5bndcgNuBruKpb2JTY3/3OQ+opqbHx
   M=;
X-IronPort-AV: E=Sophos;i="5.76,433,1592870400"; 
   d="scan'208";a="54428960"
Subject: Re: [PATCH] nfs: round down reported block numbers in statfs
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 16 Sep 2020 16:35:07 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 06102A1E26;
        Wed, 16 Sep 2020 16:35:05 +0000 (UTC)
Received: from EX13D35UWB004.ant.amazon.com (10.43.161.230) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 16 Sep 2020 16:35:05 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D35UWB004.ant.amazon.com (10.43.161.230) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 16 Sep 2020 16:35:05 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Wed, 16 Sep 2020 16:35:04 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 0347FC13E8; Wed, 16 Sep 2020 16:35:05 +0000 (UTC)
Date:   Wed, 16 Sep 2020 16:35:04 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Message-ID: <20200916163504.GA3598@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200910200644.8165-1-fllinden@amazon.com>
 <38d81562153d8168a54d93f452407a24f5cf5240.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <38d81562153d8168a54d93f452407a24f5cf5240.camel@hammerspace.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 16, 2020 at 03:14:52PM +0000, Trond Myklebust wrote:
> On Thu, 2020-09-10 at 20:06 +0000, Frank van der Linden wrote:
> > nfs_statfs rounds up the numbers of blocks as computed
> > from the numbers the server return values.
> >
> > This works out well if the client block size, which is
> > the same as wrsize, is smaller than or equal to the actual
> > filesystem block size on the server.
> >
> > But, for NFS4, the size is usually larger (1M), meaning
> > that statfs reports more free space than actually is
> > available. This confuses, for example, fstest generic/103.
> >
> > Given a choice between reporting too much or too little
> > space, the latter is the safer option, so don't round
> > up the number of blocks. This also simplifies the code.
> >
> > Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> > ---
> >  fs/nfs/super.c | 25 ++++---------------------
> >  1 file changed, 4 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> > index 7a70287f21a2..45d368a5cc95 100644
> > --- a/fs/nfs/super.c
> > +++ b/fs/nfs/super.c
> > @@ -217,8 +217,6 @@ EXPORT_SYMBOL_GPL(nfs_client_for_each_server);
> >  int nfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> >  {
> >       struct nfs_server *server = NFS_SB(dentry->d_sb);
> > -     unsigned char blockbits;
> > -     unsigned long blockres;
> >       struct nfs_fh *fh = NFS_FH(d_inode(dentry));
> >       struct nfs_fsstat res;
> >       int error = -ENOMEM;
> > @@ -241,26 +239,11 @@ int nfs_statfs(struct dentry *dentry, struct
> > kstatfs *buf)
> >
> >       buf->f_type = NFS_SUPER_MAGIC;
> >
> > -     /*
> > -      * Current versions of glibc do not correctly handle the
> > -      * case where f_frsize != f_bsize.  Eventually we want to
> > -      * report the value of wtmult in this field.
> > -      */
> > -     buf->f_frsize = dentry->d_sb->s_blocksize;
> 
> NACK. This comment and explicit setting is there to document why we're
> not propagating the true value of the filesystem block size. Please do
> not remove it.

It's a comment from 2006, which is a bit outdated. wtmult is an NFSv3
value, and glibc hasn't had that issue for a while. Maybe the comment
should be updated? I'm happy to not touch it, though - will leave that
change out.

> 
> > -
> > -     /*
> > -      * On most *nix systems, f_blocks, f_bfree, and f_bavail
> > -      * are reported in units of f_frsize.  Linux hasn't had
> > -      * an f_frsize field in its statfs struct until recently,
> > -      * thus historically Linux's sys_statfs reports these
> > -      * fields in units of f_bsize.
> > -      */
> >       buf->f_bsize = dentry->d_sb->s_blocksize;
> > -     blockbits = dentry->d_sb->s_blocksize_bits;
> > -     blockres = (1 << blockbits) - 1;
> > -     buf->f_blocks = (res.tbytes + blockres) >> blockbits;
> > -     buf->f_bfree = (res.fbytes + blockres) >> blockbits;
> > -     buf->f_bavail = (res.abytes + blockres) >> blockbits;
> > +
> > +     buf->f_blocks = res.tbytes / buf->f_bsize;
> > +     buf->f_bfree = res.fbytes / buf->f_bsize;
> > +     buf->f_bavail = res.abytes / buf->f_bsize;
> >
> >       buf->f_files = res.tfiles;
> >       buf->f_ffree = res.afiles;
> 
> As far as I can tell, all we're doing here is changing rounding up to
> rounding down, since dentry->d_sb->s_blocksize should always equal to
> (1 << dentry->d_sb->s_blocksize_bits).
> 
> Otherwise, switching from a shift to division seems like it is just
> making the calculation less efficient. Why?

Well, my thinking here was that using a straight division made the code
simpler, and it's not a code path that is performance-sensitive.

But, I forgot about needing a div64 macro for 32bit archs anyway, which
kind of undoes the 'make the code simpler' argument a bit..

I'll change it to just rounding down (e.g. remove blockres from the
equation).

Thanks,

- Frank
