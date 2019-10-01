Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E409BC3EEE
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2019 19:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfJARre (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Oct 2019 13:47:34 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43919 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfJARre (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Oct 2019 13:47:34 -0400
Received: by mail-ua1-f65.google.com with SMTP id k24so5756371uag.10
        for <linux-nfs@vger.kernel.org>; Tue, 01 Oct 2019 10:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hSlZggZOvkm85L0bhG3KGhXU50qtdtUX1NBmTdtWTpY=;
        b=JGCXnmBGP6SNoAqy5Sq26M7Rpk/22Is0iTos1bBE44MsBIJnA1u5SwkIY/yYzgO/Ba
         IqPIAsIi6CK0zj3Juh1jrX/wWq+eKVevziJhy8PfOt5YEwLN9npJ5je5MNpTVWNbcohx
         GIhAEs2khOxaXVA/QQea7Fqa9g+kenCUqznl/l0RCWWKRKtzON08MAVIVInFlIcIB2VI
         8AoFwOWJA6Ca3n4rw2/raeui67tx9khRlDIw5ek6eFhQEcRF+ACflGUmWRGTLzZxEUcY
         e1ce1/F9BiNG5ELkgdWrMLPga9Q3h1irT2CIeex/Zfpkbl8S9HcOele53iBwukCsz2pj
         dQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSlZggZOvkm85L0bhG3KGhXU50qtdtUX1NBmTdtWTpY=;
        b=S5kMS/e6S9xRls/d2MMvREbRYLtPQ1Iavy6jC7rWClbVnrfoYG8O2JnQKh+pShSN0k
         rY1ui16yjETOQqV8UlFDS5XDzNL52RfHfedFZTj7kQlW9S3Vjyiluh9ny/Y2EjYsm4dm
         VYh0bTfERkfwALnAl5BGRKF5EZUo+0IhY3TgkjXBDc4qTcfklbMJgEzzhcPLH0iPJIpi
         /R8N/u+TU7fWIt9EmM4aL2kUUQzYS11NoCR/5Ddk/z8VP0lUPjFF4oMJBnZxUjTF19aH
         OMRXTnvVdxsvBYHkY6tOmgPv3k6TXV7Qf1bo+c2IQx7CMKm3DuDsyMyQMs8NLY4g1DYR
         W43w==
X-Gm-Message-State: APjAAAXwhlkedN/Im28em28wGfMKA/Pz00mB+1Wtghmp0NurpSffMWpE
        R8S7qJnRGWnAzCZN3zjK2Lv4sjy5DoK+HLhAkXI=
X-Google-Smtp-Source: APXvYqwHR+4RtrCumcFrQ2A2YZX/hRzyxw/9nD+BDrL6RcA32XB/ONJV/pD9Kp58uH4zNAjsCwQqqc9CNRmdt+ipVr0=
X-Received: by 2002:ab0:1c0b:: with SMTP id a11mr804799uaj.65.1569952053449;
 Tue, 01 Oct 2019 10:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
 <CAN-5tyHGq=4AiMuST1kqkZWOfijvuR3bUNChL+KaNnUN900cdA@mail.gmail.com> <20191001171355.GA2372@fieldses.org>
In-Reply-To: <20191001171355.GA2372@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 1 Oct 2019 13:47:22 -0400
Message-ID: <CAN-5tyHRKu-pYAvhW0f+t4SoDs1iMCuu4JiBaNFnZmUXso4wag@mail.gmail.com>
Subject: Re: [PATCH v7 00/19] client and server support for "inter" SSC copy
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 1, 2019 at 1:13 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Sep 30, 2019 at 03:06:11PM -0400, Olga Kornievskaia wrote:
> > Have you had a chance to take a look at the new patch series and have
> > any more comments?
>
> Honestly, last time I checked I was having trouble finding things to
> complain about--it looked OK to me.
>
> But I'm not sure I understood the management of copy id's, should I
> should give it one more read.  And then agree on how to merge it.

Let me know what you would like to discuss about how copy ids are
managed on the server. I thought that cover letter plus commit
descriptions talk about how copy stateids and copy_notify states are
managed. Do you want me to cut and paste that together here? Yes I did
skip putting the same summary in v7 as I did in earlier submissions.

> I was thinking maybe you could give us a git branch based on 5.5-rc1 or
> 5.5-rc2, Trond (I think it's Trond this time?) could pull the client
> ones into his tree, and I could pull the rest into mine.

I do have git space on linux-nfs so I could put my patches there.
However, I'm confused about the ask to be based on 5.5-rc1 as we are
still on 5.4-rc. Are you estimating that review will skip pushing this
feature for 5.5 and you are aiming for 5.6? I guess just tell me of
whose (current) git branch you'd like me to based off. The last one
was of your tree and your branch was in 5.3-rc (my default is to go
from Trond's).

> Trond/Anna?
>
> --b.
>
> >
> > On Mon, Sep 16, 2019 at 5:13 PM Olga Kornievskaia
> > <olga.kornievskaia@gmail.com> wrote:
> > >
> > > v7:
> > > --- rebased patches ontop of Bruce's nfsd-next
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
> > >  fs/nfsd/nfs4proc.c        | 436 +++++++++++++++++++++++++++++++++++++++++-----
> > >  fs/nfsd/nfs4state.c       | 215 ++++++++++++++++++++---
> > >  fs/nfsd/nfs4xdr.c         | 155 +++++++++++++++-
> > >  fs/nfsd/nfsd.h            |  32 ++++
> > >  fs/nfsd/nfsfh.h           |   5 +-
> > >  fs/nfsd/nfssvc.c          |   6 +
> > >  fs/nfsd/state.h           |  34 +++-
> > >  fs/nfsd/xdr4.h            |  39 ++++-
> > >  include/linux/nfs4.h      |  25 +++
> > >  include/linux/nfs_fs.h    |   3 +-
> > >  include/linux/nfs_fs_sb.h |   1 +
> > >  include/linux/nfs_xdr.h   |  17 ++
> > >  22 files changed, 1429 insertions(+), 121 deletions(-)
> > >
> > > --
> > > 1.8.3.1
> > >
