Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007B0B167B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2019 00:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfILWxU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 18:53:20 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40224 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfILWxU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Sep 2019 18:53:20 -0400
Received: by mail-vs1-f68.google.com with SMTP id v10so14114048vsc.7
        for <linux-nfs@vger.kernel.org>; Thu, 12 Sep 2019 15:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+tzydyzwa6mByrDkvBfhuwNlvRwczNGAmdZkRtq7uc=;
        b=WjYmtPu5Sd8LZPqK2C6lH7srnU6SLS2nILy0eaZ5PH+Yb+mkOXarg7elxLfEzDfMwf
         aG2oL5/jQS1KCNEwC08SG5wt+9wcb+SBFV5Fe6Yi5Rf/GCsjJ9G0E2l7eQDfhbWVe4nj
         ADblmUDWKfg4nlWT1MM03C6mvzlntk3HijI8lWtudHcnozhAqvR6BhIGuewuPydKsmhD
         W25WBtVKN/bevXi4ompzxsSKn34R8UI7a5be3dyGabeQnyPpC7omK47OZuWMPUkm0Idb
         Q4aZQDljRdde7o/CBSQWrr8JrZ0K3CxXD4bhCUpa5NyiA/1Wh7BeEMkjBZMbUadXzVlh
         oW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+tzydyzwa6mByrDkvBfhuwNlvRwczNGAmdZkRtq7uc=;
        b=f5MahcvdpGWFyI+elJYkLmAplcg0T22kxL0bs6eZ25T8/WllJnlhtthn49of3rUWMN
         gWiH6qGPWIrb2EzepuRhc0DBWvcvI/f3XU1m42lqBenfHeQzdwVgyRUeZbbCRdnmZxY7
         K/CmnFO2Fsxq53lvT1kfWw5ORR94Aay4th5AJ8ZGVobwy9gUKWmyV58LNPmEU7euS6up
         Itk1dDowEaSyU0JOaTXiEnKyHo9NWsquc2SbQslc8oyz7UlFzWWQex0emHeOwYlQfp/K
         7qZg00QHqxvkQTqE72JvgDqeLA4hGgzOshvfDAwQWL3WBr6/Qz+Krzz+RLsHc6Xw++Bv
         Oycw==
X-Gm-Message-State: APjAAAURXREb1anWI23cpxdeVnKsbjlDEjDKekre1+YhKg76Qg9ATC8d
        2qZr5pvqaSgj/tXoeKv2MUPhqDRcfKha+MtmiiA=
X-Google-Smtp-Source: APXvYqwuumE0Lmk534kgwsymSKlrxpCZ63c2qOrWPfWkL6wB38ZeygmK2xXgNk+BAFW3+WRvY1wQzYd2Mxmwpqb/7j4=
X-Received: by 2002:a67:f584:: with SMTP id i4mr24421618vso.134.1568328796695;
 Thu, 12 Sep 2019 15:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
 <CAN-5tyE3nzK5BF1sP1aYWOR-=ZWWYkLDwxHEiFkM3YPxqHJtYA@mail.gmail.com> <20190912202624.GC5054@fieldses.org>
In-Reply-To: <20190912202624.GC5054@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 12 Sep 2019 18:52:46 -0400
Message-ID: <CAN-5tyH59duLvsg+tR_PcFr1DDZfFkoaenjnTUWDjPnxuC4k7Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/19] client and server support for "inter" SSC copy
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 12, 2019 at 4:26 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Fri, Sep 06, 2019 at 04:27:32PM -0400, Olga Kornievskaia wrote:
> > Trond/Anna,
> >
> > Please ignore this current version. With working on the server, I have
> > forgotten that I had change(s) to the client side but didn't include
> > them here. I'll repost with those changes.
> >
> > Bruce, server side changes are all here.
>
> There are conflicts with my 5.4 tree, mostly due to the file caching
> stuff.  I started trying to fix them up myself but there were more than
> I expected and as I was afraid I'd screw it up.  Could you take a look?

I can work off your tree.

>
> --b.
>
> >
> > On Fri, Sep 6, 2019 at 3:46 PM Olga Kornievskaia
> > <olga.kornievskaia@gmail.com> wrote:
> > >
> > > As per Bruce's request submitting the client and server series together
> > > as there is a common patch that's needed by both.
> > >
> > > No client side changes were made since the previous submission
> > >
> > > v6 server-side changes
> > > --- removed global copy notify list and instead relying only on the idr
> > > list of stateids. Laundromat now traverses that list and if copy notify
> > > state wasn't referenced in a lease period, state is deleted.
> > > --- removed storing parent's stid pointer in the copy notify state.
> > > instead storing the parent's stateid and client id then using it to
> > > lookup the stid structure and client structure during validation of
> > > the stateid of the READ.
> > > --- added a refcount to the copy notify state to make sure only 1 will
> > > delete it (as it can be delete either by the nfs4_put_stid(),
> > > laundromat, or offload_cancel op. basically all access to the copy state
> > > is using just one global lock now (netd->s2s_cp_lock).
> > > --- added a type to the copy_stateid_t to distinguish copy notify state
> > > kept by the source server and copy state used by the destination server.
> > > --- previously with a global copy notify list, the check if client has
> > > state before unmounting checked if the list was empty, now the code
> > > traverses the idr list and looks for anything with a matching clientid
> > > (again under the global s2s_cp_lock).
> > >
> > > Olga Kornievskaia (19):
> > >   NFS NFSD: defining nl4_servers structure needed by both
> > >   NFS: add COPY_NOTIFY operation
> > >   NFS: add ca_source_server<> to COPY
> > >   NFS: also send OFFLOAD_CANCEL to source server
> > >   NFS: inter ssc open
> > >   NFS: skip recovery of copy open on dest server
> > >   NFS: for "inter" copy treat ESTALE as ENOTSUPP
> > >   NFS: COPY handle ERR_OFFLOAD_DENIED
> > >   NFS: handle source server reboot
> > >   NFS: replace cross device check in copy_file_range
> > >   NFSD fill-in netloc4 structure
> > >   NFSD add ca_source_server<> to COPY
> > >   NFSD return nfs4_stid in nfs4_preprocess_stateid_op
> > >   NFSD COPY_NOTIFY xdr
> > >   NFSD add COPY_NOTIFY operation
> > >   NFSD check stateids against copy stateids
> > >   NFSD generalize nfsd4_compound_state flag names
> > >   NFSD: allow inter server COPY to have a STALE source server fh
> > >   NFSD add nfs4 inter ssc to nfsd4_copy
> > >
> > >  fs/nfs/nfs42.h            |  15 +-
> > >  fs/nfs/nfs42proc.c        | 193 ++++++++++++++++----
> > >  fs/nfs/nfs42xdr.c         | 190 +++++++++++++++++++-
> > >  fs/nfs/nfs4_fs.h          |  11 ++
> > >  fs/nfs/nfs4client.c       |   2 +-
> > >  fs/nfs/nfs4file.c         | 125 ++++++++++++-
> > >  fs/nfs/nfs4proc.c         |   6 +-
> > >  fs/nfs/nfs4state.c        |  29 ++-
> > >  fs/nfs/nfs4xdr.c          |   1 +
> > >  fs/nfsd/Kconfig           |  10 ++
> > >  fs/nfsd/nfs4proc.c        | 440 ++++++++++++++++++++++++++++++++++++++++++----
> > >  fs/nfsd/nfs4state.c       | 215 +++++++++++++++++++---
> > >  fs/nfsd/nfs4xdr.c         | 154 +++++++++++++++-
> > >  fs/nfsd/nfsd.h            |  32 ++++
> > >  fs/nfsd/nfsfh.h           |   5 +-
> > >  fs/nfsd/nfssvc.c          |   6 +
> > >  fs/nfsd/state.h           |  34 +++-
> > >  fs/nfsd/xdr4.h            |  39 +++-
> > >  include/linux/nfs4.h      |  25 +++
> > >  include/linux/nfs_fs.h    |   3 +-
> > >  include/linux/nfs_fs_sb.h |   1 +
> > >  include/linux/nfs_xdr.h   |  17 ++
> > >  22 files changed, 1431 insertions(+), 122 deletions(-)
> > >
> > > --
> > > 1.8.3.1
> > >
