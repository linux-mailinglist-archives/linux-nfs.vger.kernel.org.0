Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA5638D9
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2019 17:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfGIPry (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jul 2019 11:47:54 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42012 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfGIPry (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Jul 2019 11:47:54 -0400
Received: by mail-ua1-f65.google.com with SMTP id a97so6583642uaa.9
        for <linux-nfs@vger.kernel.org>; Tue, 09 Jul 2019 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v55yOAF9vSDUtrExSAdNNBFG9HGRQtHHofZV7/AIrmc=;
        b=hGvuOAM4hRDzuu5x2hegDQ7gIot9aCwLjt5l3n5gLdpne4vGJbSi/WamPnm3CeFYF6
         68ociXDHwMaqj0tvrocyT3QNYnRfOX+Qyzkt5SUqc+odAaXuU+chtN6LDNwadmmh7R1a
         OmVA5kD0InhN6uBKakjfqVdK+GfilXiyMCT6nMSgQjfonPHPVxeYkWbJTeMRhS6mOLhj
         KuiVaTQ/Zami6ymuUP+yy5O7BK1YiDXb4vllmS7x1lrdDCTJeEEMIEQ3EHo51iZ44HvN
         YHjjbTMJUUpl/UlFHsrXX3UHYrCSOYCCjEjCt695K4PAih2Wp+IC45mNp3YJXGvBqM4K
         y+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v55yOAF9vSDUtrExSAdNNBFG9HGRQtHHofZV7/AIrmc=;
        b=On3AD3i/8Ph7X+iP3SwZ+z/BEz07yoHO5mPhAc8ArrxmHwEUGP+sE74QCmJhSGw9+e
         I+XPIImeNVljc9NuX73Az7JAjyGs4Nfd1C0TloG9khovJv1tDdXKdjxQVYzlRhP+J3o0
         ohnqI9Jqsy3FoRUp92V+yeRWxJsXgpBQFLhTSxLJIoAJOE6dr9zx1cCQ69Liuul+bXTT
         DJzXVT4GGztgfP4mt8/pbAwF0Xz7nf5qFTXWg8CwmZOZACpnu+xd//JiZ5DK0veioQN4
         8L4HTWdvlTvaN6l/B0qxD/DZnJb8gXV0q5m74CvYXadiH0ADb+CkEp8qcFzkzGFSLc0b
         S7oA==
X-Gm-Message-State: APjAAAV4CNGSUt7x7c37JZC3ZZg2rC8MhgtPj+UGj4QtiWrtILSItBgp
        9TpPhWoGaME7bXyZqw72RLD7EAKz95IJmpUtDFU=
X-Google-Smtp-Source: APXvYqz6oQpDlV3bQHQ864BGcMGeCBiIwDJTOWDpCeIU4kmMzM8FutPSdlAoE3bTib2YZ5S1kM8tz/r6HbYSBpLL66k=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr4937411uag.40.1562687273192;
 Tue, 09 Jul 2019 08:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com> <20190709035308.GA15860@fieldses.org>
In-Reply-To: <20190709035308.GA15860@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 9 Jul 2019 11:47:42 -0400
Message-ID: <CAN-5tyHku5mjwcZh+VFt28c_DG=MQa_gOqg71q38RdBtciTcBg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] server-side support for "inter" SSC copy
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Amir's patches have been in the linux-next xfs tree and will go into
5.3. I would like for NFS patches to go into 5.4 (I'm assuming hoping
for 5.3 is unrealistic).

On Mon, Jul 8, 2019 at 11:53 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> Thanks for resending.  What's the status of Amir's series?  I guess I've
> been using that as an excuse to put off reviewing these, but I really
> should anyway....
>
> --b.
>
> On Mon, Jul 08, 2019 at 03:23:44PM -0400, Olga Kornievskaia wrote:
> > This patch series adds support for NFSv4.2 copy offload feature
> > allowing copy between two different NFS servers.
> >
> > This functionality depends on the VFS ability to support generic
> > copy_file_range() where a copy is done between an NFS file and
> > a local file system. This is on top of Amir's VFS generic copy
> > offload series.
> >
> > This feature is enabled by the kernel module parameter --
> > inter_copy_offload_enable -- and by default is disabled. There is
> > also a kernel compile configuration of NFSD_V4_2_INTER_SSC that
> > adds dependency on the NFS client side functions called from the
> > server.
> >
> > These patches work on top of existing async intra copy offload
> > patches. For the "inter" SSC, the implementation only supports
> > asynchronous inter copy.
> >
> > On the source server, upon receiving a COPY_NOTIFY, it generate a
> > unique stateid that's kept in the global list. Upon receiving a READ
> > with a stateid, the code checks the normal list of open stateid and
> > now additionally, it'll check the copy state list as well before
> > deciding to either fail with BAD_STATEID or find one that matches.
> > The stored stateid is only valid to be used for the first time
> > with a choosen lease period (90s currently). When the source server
> > received an OFFLOAD_CANCEL, it will remove the stateid from the
> > global list. Otherwise, the copy stateid is removed upon the removal
> > of its "parent" stateid (open/lock/delegation stateid).
> >
> > On the destination server, upon receiving a COPY request, the server
> > establishes the necessary clientid/session with the source server.
> > It calls into the NFS client code to establish the necessary
> > open stateid, filehandle, file description (without doing an NFS open).
> > Then the server calls into the copy_file_range() to preform the copy
> > where the source file will issue NFS READs and then do local file
> > system writes (this depends on the VFS ability to do cross device
> > copy_file_range().
> >
> > v4:
> > --- allowing for synchronous inter server-to-server copy
> > --- added missing offload_cancel on the source server
> >
> > Already presented numbers for performance improvement for large
> > file transfer but here are times for copying linux kernel tree
> > (which is mostly small files):
> > -- regular cp 6m1s (intra)
> > -- copy offload cp 4m11s (intra)
> >    -- benefit of using copy offload with small copies using sync copy
> > -- regular cp 6m9s (inter)
> > -- copy offload cp 6m3s (inter)
> >    -- same performance as traditional as for most it fallback to traditional
> > copy offload
> >
> > Olga Kornievskaia (8):
> >   NFSD fill-in netloc4 structure
> >   NFSD add ca_source_server<> to COPY
> >   NFSD return nfs4_stid in nfs4_preprocess_stateid_op
> >   NFSD add COPY_NOTIFY operation
> >   NFSD check stateids against copy stateids
> >   NFSD generalize nfsd4_compound_state flag names
> >   NFSD: allow inter server COPY to have a STALE source server fh
> >   NFSD add nfs4 inter ssc to nfsd4_copy
> >
> >  fs/nfsd/Kconfig     |  10 ++
> >  fs/nfsd/nfs4proc.c  | 434 +++++++++++++++++++++++++++++++++++++++++++++++-----
> >  fs/nfsd/nfs4state.c | 135 ++++++++++++++--
> >  fs/nfsd/nfs4xdr.c   | 172 ++++++++++++++++++++-
> >  fs/nfsd/nfsd.h      |  32 ++++
> >  fs/nfsd/nfsfh.h     |   5 +-
> >  fs/nfsd/nfssvc.c    |   6 +
> >  fs/nfsd/state.h     |  25 ++-
> >  fs/nfsd/xdr4.h      |  37 ++++-
> >  9 files changed, 790 insertions(+), 66 deletions(-)
> >
> > --
> > 1.8.3.1
