Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9C8AC26FB
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2019 22:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfI3UoA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Sep 2019 16:44:00 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33743 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfI3UoA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Sep 2019 16:44:00 -0400
Received: by mail-vs1-f67.google.com with SMTP id p13so7791178vso.0
        for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2019 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KK3XB86IJ7pGNg3LN0yl73wWT5hxuUXdH3AcjggSHFI=;
        b=Vh9W7f8tKssgUVeTsWcXfIWO1I3eDq4IfBhGtGkJO3b22RBIThXyR/p8UAma/RDr9T
         kUYQ6l/SYOtZlCTqHOX0+0GiDGfEo1BHhiuKX41DadOrt6gJR6fsvBTYEatSmMxxEccO
         QbUza/N1GrsgwjYJtCGtBzTLLR9/nPn6WLE1lGJ7yrQ2BOMTvCcrJrLiWiTmSzThaokD
         5ZA9biagxDpr8Pd2Iit9iwEUetuMMc5NRwCjnXU1TzU/kOuNyNDLSnTj460+qW2UTTXW
         GW5H+8pEPywJIuTpOk+54PMp0mRe7EswG1Kg3oNX8U7gTqnxVio1ZkCNKohgXUCnnxsA
         /r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KK3XB86IJ7pGNg3LN0yl73wWT5hxuUXdH3AcjggSHFI=;
        b=NYjHsS4au53CNm4AgE7FCHQgXAJctjs1mwplk84jYu1b3u6EWV5T9hER+DQU8AvaY2
         54pgOapdZtoqFzzdb1Z2IizsRF1FQ9JmOz9uUlk1jtk/Ci3bcdC20IY8103sVfzbPqTr
         6bzYBJPWdZ3xbKjk88wB+TOrGBHJUK+Y5bbv8R1uJ7j5FsMRQabTXjlFeFc+D5Qr7D9M
         sUA9vfUw1jeSAh/njI0tBT9tzBvcC2pv7q3oAaVeh8jy4SGdq0f5bY7tVyX0Hz6Ev/gz
         MjzF375N0c/CTsbh1BTZvUehSSTb5x+gPYXOoulFQwj/p2dMVe/WQvHJQjEv6wJZCnKo
         +52w==
X-Gm-Message-State: APjAAAUVpRZtgOn/Sv/3PvUea8V3bngX9E7BVta+rpJgoxV8hUN+5OQB
        Az9CtSMfNEVD+IRXbu9HKpYwmeF4C0BrUiQNR87Kxw==
X-Google-Smtp-Source: APXvYqzOj2sVQYpKCGeIwolVvNA6j7Wd4vPd8zPR2YdQ5jvPcInrnLzXuztNFntza4buLWH7KJkjGldOWA1nZjB1OLc=
X-Received: by 2002:a67:db09:: with SMTP id z9mr10388973vsj.134.1569870382382;
 Mon, 30 Sep 2019 12:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 30 Sep 2019 15:06:11 -0400
Message-ID: <CAN-5tyHGq=4AiMuST1kqkZWOfijvuR3bUNChL+KaNnUN900cdA@mail.gmail.com>
Subject: Re: [PATCH v7 00/19] client and server support for "inter" SSC copy
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

Have you had a chance to take a look at the new patch series and have
any more comments?

On Mon, Sep 16, 2019 at 5:13 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> v7:
> --- rebased patches ontop of Bruce's nfsd-next
>
> Olga Kornievskaia (19):
>   NFS NFSD: defining nl4_servers structure needed by both
>   NFS: add COPY_NOTIFY operation
>   NFS: add ca_source_server<> to COPY
>   NFS: also send OFFLOAD_CANCEL to source server
>   NFS: inter ssc open
>   NFS: skip recovery of copy open on dest server
>   NFS: for "inter" copy treat ESTALE as ENOTSUPP
>   NFS: COPY handle ERR_OFFLOAD_DENIED
>   NFS: handle source server reboot
>   NFS: replace cross device check in copy_file_range
>   NFSD fill-in netloc4 structure
>   NFSD add ca_source_server<> to COPY
>   NFSD return nfs4_stid in nfs4_preprocess_stateid_op
>   NFSD COPY_NOTIFY xdr
>   NFSD add COPY_NOTIFY operation
>   NFSD check stateids against copy stateids
>   NFSD generalize nfsd4_compound_state flag names
>   NFSD: allow inter server COPY to have a STALE source server fh
>   NFSD add nfs4 inter ssc to nfsd4_copy
>
>  fs/nfs/nfs42.h            |  15 +-
>  fs/nfs/nfs42proc.c        | 193 ++++++++++++++++----
>  fs/nfs/nfs42xdr.c         | 190 +++++++++++++++++++-
>  fs/nfs/nfs4_fs.h          |  11 ++
>  fs/nfs/nfs4client.c       |   2 +-
>  fs/nfs/nfs4file.c         | 125 ++++++++++++-
>  fs/nfs/nfs4proc.c         |   6 +-
>  fs/nfs/nfs4state.c        |  29 ++-
>  fs/nfs/nfs4xdr.c          |   1 +
>  fs/nfsd/Kconfig           |  10 ++
>  fs/nfsd/nfs4proc.c        | 436 +++++++++++++++++++++++++++++++++++++++++-----
>  fs/nfsd/nfs4state.c       | 215 ++++++++++++++++++++---
>  fs/nfsd/nfs4xdr.c         | 155 +++++++++++++++-
>  fs/nfsd/nfsd.h            |  32 ++++
>  fs/nfsd/nfsfh.h           |   5 +-
>  fs/nfsd/nfssvc.c          |   6 +
>  fs/nfsd/state.h           |  34 +++-
>  fs/nfsd/xdr4.h            |  39 ++++-
>  include/linux/nfs4.h      |  25 +++
>  include/linux/nfs_fs.h    |   3 +-
>  include/linux/nfs_fs_sb.h |   1 +
>  include/linux/nfs_xdr.h   |  17 ++
>  22 files changed, 1429 insertions(+), 121 deletions(-)
>
> --
> 1.8.3.1
>
