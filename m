Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEDD6C0C0
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2019 20:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfGQSF2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jul 2019 14:05:28 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39861 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfGQSF2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Jul 2019 14:05:28 -0400
Received: by mail-vs1-f67.google.com with SMTP id u3so17135569vsh.6
        for <linux-nfs@vger.kernel.org>; Wed, 17 Jul 2019 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ilyAowP3PY6OGg+uV+rO14AEC5hHbsj1G4FmTx17kw=;
        b=dJgE/5IHlqtXpckWi2jBXsT6ofgCio5iaUw6mBR6QdRIl0+Bp/UX3P8THcXNY7dpwe
         NiRLarBWiExCJKIW1QlD3nuCzE8qRWNFAFMYJP3Lsw61YbdBLG8wUHRSZ/Gn4FfewpXy
         Acp6KA9VFqUXXpVtABK/h2DLK6r6ZB7OwDoeBqoq62T/Q+omwGAxyoIlFKJZXB/I7sRt
         MPN7/AMJFK/BL6PGcXxXXAqpFN+2i+DfK5fgaV7F0IZ/emZXgX4wx3ejeRBOhFLPY+VP
         hwGkTYNccDPVfKmo+80t603mZGbIwhJbaJdFsc+d6tLum1Xu+gWdfpnhgs51mzXV70ZG
         3fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ilyAowP3PY6OGg+uV+rO14AEC5hHbsj1G4FmTx17kw=;
        b=Sx6FOJCfL31fuXQ9tLy8XijnaR6tJGV5+boOGvZoickDFFo1mJx2y3c0XsZlElQgZW
         pWC40GJnR2pO/2O1lDJ1wBn5c9zyRsDPly5fNpHwwgdj+iWDnEzUB65ybqIf8/6IlMYn
         2wQ6gI5PGE0Y8drIr8qwJaLQRmvwmoB+Ik9vzZ6lz6N24E22tO8qErV/Gk68092zE78h
         gFY1pGMFIVx/srhqEAhh2ye0sPa7EXX+9KQFl4GaSGxQG3e6A+fYsNo++lCJ4oGY+vu6
         7xVvp4T3IZ6NTWxWd604+om9uGty4KQxEmOPIjr5w5qFfNwLlFpK+715e87mt5VdfJYC
         lTPQ==
X-Gm-Message-State: APjAAAVbVc1WwG4ahLx0eg4FtGeAKGj5s95zMiDqcOiVycdF7m4CrodT
        X0/0EKPPfgeduxvxrgRr1J8lgUWCWEK9rwJ5NofdFw==
X-Google-Smtp-Source: APXvYqznNi5MbwBZJMfWJF3Md87Q3jxNkND4MH1U+unTYsIU4X2NdlQaexR6pr44ezEc9pEHcTnOUOyuxq7ttq7UuGg=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr2548290vsd.215.1563386726961;
 Wed, 17 Jul 2019 11:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190709035308.GA15860@fieldses.org> <CAN-5tyHku5mjwcZh+VFt28c_DG=MQa_gOqg71q38RdBtciTcBg@mail.gmail.com>
In-Reply-To: <CAN-5tyHku5mjwcZh+VFt28c_DG=MQa_gOqg71q38RdBtciTcBg@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 17 Jul 2019 14:05:18 -0400
Message-ID: <CAN-5tyHSQ--P9XZ3kxZeg601C-0--z9T0jKZuESNaDGvOdfQdg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] server-side support for "inter" SSC copy
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

Do you have any more comments than what Anna already provided? I have
been waiting for more comments before putting up those 2 small
changes.

On Tue, Jul 9, 2019 at 11:47 AM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> Amir's patches have been in the linux-next xfs tree and will go into
> 5.3. I would like for NFS patches to go into 5.4 (I'm assuming hoping
> for 5.3 is unrealistic).
>
> On Mon, Jul 8, 2019 at 11:53 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > Thanks for resending.  What's the status of Amir's series?  I guess I've
> > been using that as an excuse to put off reviewing these, but I really
> > should anyway....
> >
> > --b.
> >
> > On Mon, Jul 08, 2019 at 03:23:44PM -0400, Olga Kornievskaia wrote:
> > > This patch series adds support for NFSv4.2 copy offload feature
> > > allowing copy between two different NFS servers.
> > >
> > > This functionality depends on the VFS ability to support generic
> > > copy_file_range() where a copy is done between an NFS file and
> > > a local file system. This is on top of Amir's VFS generic copy
> > > offload series.
> > >
> > > This feature is enabled by the kernel module parameter --
> > > inter_copy_offload_enable -- and by default is disabled. There is
> > > also a kernel compile configuration of NFSD_V4_2_INTER_SSC that
> > > adds dependency on the NFS client side functions called from the
> > > server.
> > >
> > > These patches work on top of existing async intra copy offload
> > > patches. For the "inter" SSC, the implementation only supports
> > > asynchronous inter copy.
> > >
> > > On the source server, upon receiving a COPY_NOTIFY, it generate a
> > > unique stateid that's kept in the global list. Upon receiving a READ
> > > with a stateid, the code checks the normal list of open stateid and
> > > now additionally, it'll check the copy state list as well before
> > > deciding to either fail with BAD_STATEID or find one that matches.
> > > The stored stateid is only valid to be used for the first time
> > > with a choosen lease period (90s currently). When the source server
> > > received an OFFLOAD_CANCEL, it will remove the stateid from the
> > > global list. Otherwise, the copy stateid is removed upon the removal
> > > of its "parent" stateid (open/lock/delegation stateid).
> > >
> > > On the destination server, upon receiving a COPY request, the server
> > > establishes the necessary clientid/session with the source server.
> > > It calls into the NFS client code to establish the necessary
> > > open stateid, filehandle, file description (without doing an NFS open).
> > > Then the server calls into the copy_file_range() to preform the copy
> > > where the source file will issue NFS READs and then do local file
> > > system writes (this depends on the VFS ability to do cross device
> > > copy_file_range().
> > >
> > > v4:
> > > --- allowing for synchronous inter server-to-server copy
> > > --- added missing offload_cancel on the source server
> > >
> > > Already presented numbers for performance improvement for large
> > > file transfer but here are times for copying linux kernel tree
> > > (which is mostly small files):
> > > -- regular cp 6m1s (intra)
> > > -- copy offload cp 4m11s (intra)
> > >    -- benefit of using copy offload with small copies using sync copy
> > > -- regular cp 6m9s (inter)
> > > -- copy offload cp 6m3s (inter)
> > >    -- same performance as traditional as for most it fallback to traditional
> > > copy offload
> > >
> > > Olga Kornievskaia (8):
> > >   NFSD fill-in netloc4 structure
> > >   NFSD add ca_source_server<> to COPY
> > >   NFSD return nfs4_stid in nfs4_preprocess_stateid_op
> > >   NFSD add COPY_NOTIFY operation
> > >   NFSD check stateids against copy stateids
> > >   NFSD generalize nfsd4_compound_state flag names
> > >   NFSD: allow inter server COPY to have a STALE source server fh
> > >   NFSD add nfs4 inter ssc to nfsd4_copy
> > >
> > >  fs/nfsd/Kconfig     |  10 ++
> > >  fs/nfsd/nfs4proc.c  | 434 +++++++++++++++++++++++++++++++++++++++++++++++-----
> > >  fs/nfsd/nfs4state.c | 135 ++++++++++++++--
> > >  fs/nfsd/nfs4xdr.c   | 172 ++++++++++++++++++++-
> > >  fs/nfsd/nfsd.h      |  32 ++++
> > >  fs/nfsd/nfsfh.h     |   5 +-
> > >  fs/nfsd/nfssvc.c    |   6 +
> > >  fs/nfsd/state.h     |  25 ++-
> > >  fs/nfsd/xdr4.h      |  37 ++++-
> > >  9 files changed, 790 insertions(+), 66 deletions(-)
> > >
> > > --
> > > 1.8.3.1
