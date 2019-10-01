Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E04AEC3E52
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2019 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfJARNz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Oct 2019 13:13:55 -0400
Received: from fieldses.org ([173.255.197.46]:39648 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729439AbfJARNz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 1 Oct 2019 13:13:55 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 48F9A150D; Tue,  1 Oct 2019 13:13:55 -0400 (EDT)
Date:   Tue, 1 Oct 2019 13:13:55 -0400
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Subject: Re: [PATCH v7 00/19] client and server support for "inter" SSC copy
Message-ID: <20191001171355.GA2372@fieldses.org>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
 <CAN-5tyHGq=4AiMuST1kqkZWOfijvuR3bUNChL+KaNnUN900cdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyHGq=4AiMuST1kqkZWOfijvuR3bUNChL+KaNnUN900cdA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 30, 2019 at 03:06:11PM -0400, Olga Kornievskaia wrote:
> Have you had a chance to take a look at the new patch series and have
> any more comments?

Honestly, last time I checked I was having trouble finding things to
complain about--it looked OK to me.

But I'm not sure I understood the management of copy id's, should I
should give it one more read.  And then agree on how to merge it.

I was thinking maybe you could give us a git branch based on 5.5-rc1 or
5.5-rc2, Trond (I think it's Trond this time?) could pull the client
ones into his tree, and I could pull the rest into mine.

Trond/Anna?

--b.

> 
> On Mon, Sep 16, 2019 at 5:13 PM Olga Kornievskaia
> <olga.kornievskaia@gmail.com> wrote:
> >
> > v7:
> > --- rebased patches ontop of Bruce's nfsd-next
> >
> > Olga Kornievskaia (19):
> >   NFS NFSD: defining nl4_servers structure needed by both
> >   NFS: add COPY_NOTIFY operation
> >   NFS: add ca_source_server<> to COPY
> >   NFS: also send OFFLOAD_CANCEL to source server
> >   NFS: inter ssc open
> >   NFS: skip recovery of copy open on dest server
> >   NFS: for "inter" copy treat ESTALE as ENOTSUPP
> >   NFS: COPY handle ERR_OFFLOAD_DENIED
> >   NFS: handle source server reboot
> >   NFS: replace cross device check in copy_file_range
> >   NFSD fill-in netloc4 structure
> >   NFSD add ca_source_server<> to COPY
> >   NFSD return nfs4_stid in nfs4_preprocess_stateid_op
> >   NFSD COPY_NOTIFY xdr
> >   NFSD add COPY_NOTIFY operation
> >   NFSD check stateids against copy stateids
> >   NFSD generalize nfsd4_compound_state flag names
> >   NFSD: allow inter server COPY to have a STALE source server fh
> >   NFSD add nfs4 inter ssc to nfsd4_copy
> >
> >  fs/nfs/nfs42.h            |  15 +-
> >  fs/nfs/nfs42proc.c        | 193 ++++++++++++++++----
> >  fs/nfs/nfs42xdr.c         | 190 +++++++++++++++++++-
> >  fs/nfs/nfs4_fs.h          |  11 ++
> >  fs/nfs/nfs4client.c       |   2 +-
> >  fs/nfs/nfs4file.c         | 125 ++++++++++++-
> >  fs/nfs/nfs4proc.c         |   6 +-
> >  fs/nfs/nfs4state.c        |  29 ++-
> >  fs/nfs/nfs4xdr.c          |   1 +
> >  fs/nfsd/Kconfig           |  10 ++
> >  fs/nfsd/nfs4proc.c        | 436 +++++++++++++++++++++++++++++++++++++++++-----
> >  fs/nfsd/nfs4state.c       | 215 ++++++++++++++++++++---
> >  fs/nfsd/nfs4xdr.c         | 155 +++++++++++++++-
> >  fs/nfsd/nfsd.h            |  32 ++++
> >  fs/nfsd/nfsfh.h           |   5 +-
> >  fs/nfsd/nfssvc.c          |   6 +
> >  fs/nfsd/state.h           |  34 +++-
> >  fs/nfsd/xdr4.h            |  39 ++++-
> >  include/linux/nfs4.h      |  25 +++
> >  include/linux/nfs_fs.h    |   3 +-
> >  include/linux/nfs_fs_sb.h |   1 +
> >  include/linux/nfs_xdr.h   |  17 ++
> >  22 files changed, 1429 insertions(+), 121 deletions(-)
> >
> > --
> > 1.8.3.1
> >
