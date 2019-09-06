Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC71BAC15E
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 22:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbfIFU1o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 16:27:44 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35821 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732004AbfIFU1o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 16:27:44 -0400
Received: by mail-vk1-f193.google.com with SMTP id d66so1566338vka.2
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 13:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bo7j8p7t0xM0NWAwjydV5dyEmcCZHwShkl42HYXyWD4=;
        b=BI+kK/Y7Fm30VWaKy2sQHbY25XZk+y+Eir8aIsb1ghH+gevK6hISZaMELQUR1fZg5l
         mgJb9Cdz4R44QjnhOTSWTVkFHq/21VSNdF1Hqi4Sj2O65erSH9z03lUwkZR8Iiy0aWdc
         YdaHR6nOFxnjJLkUZY1yklLj8gCq3xGr0yiZAFOT/b6ifM3l2O6ensh4PD4atoisaclS
         W2GK3QJF+d/0SIhZMqnRrXxGTEAL5LBNH9uLWYCYn0AgJCH2XZS2MaI+H2Ss2w2N6Z9B
         IG2PJwDPEYNEDACIeZuYufYvnC4SDvJRJE/rIXlp/itMbC39GWICc8UhPmdcNbiJZ8hv
         u+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bo7j8p7t0xM0NWAwjydV5dyEmcCZHwShkl42HYXyWD4=;
        b=YY+AjPqgEZXKM9e1BTnnit+2J0c3CX7lWk25b/nKObhUF/gFlJKFF4h7wBME8SEGdj
         vej1HhOynr6cZo93Zn5BEIQvMDix/Yl5fn+R2uCU5odsdsPcyDvwKIWFQxg2vyp7CgDm
         9Odc1M9b+2Z67dAJ+DlYcn4OpYX25oiWOPkLjlcI51eHnFSXMv/N9gTkP3KZkmSkngGS
         4jVE6C9KV37zVDoW2Vrco6ItY02t2g4kH+ryKqWWG7xwuAfvadq+vsLhEyZLGBhxy0s0
         DpKegGEGmP85NOXm2oF04KvAdrQpT3pyCfG24/H5s+IvkuDFNcHkriy8NGlsprS42dAK
         yEDA==
X-Gm-Message-State: APjAAAWdWdCRx2yt5TNdzF4GajikJ9+nHQuXwSQIO1/oAbC9MYuktPDz
        RK8vKRAXHKRtOcl5FT4QdDE621mcPNeYZ1qblSH+Q6rd
X-Google-Smtp-Source: APXvYqwPl0nT1Lz00i3P4zmgJL67ie8rfxaltpwEoustA+zEUU4MB+TpDtthgL1EJsxVNwETi17sD1mgR4NPWwYfg/w=
X-Received: by 2002:ac5:c24b:: with SMTP id n11mr5449638vkk.83.1567801663322;
 Fri, 06 Sep 2019 13:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 6 Sep 2019 16:27:32 -0400
Message-ID: <CAN-5tyE3nzK5BF1sP1aYWOR-=ZWWYkLDwxHEiFkM3YPxqHJtYA@mail.gmail.com>
Subject: Re: [PATCH v6 00/19] client and server support for "inter" SSC copy
To:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond/Anna,

Please ignore this current version. With working on the server, I have
forgotten that I had change(s) to the client side but didn't include
them here. I'll repost with those changes.

Bruce, server side changes are all here.

On Fri, Sep 6, 2019 at 3:46 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> As per Bruce's request submitting the client and server series together
> as there is a common patch that's needed by both.
>
> No client side changes were made since the previous submission
>
> v6 server-side changes
> --- removed global copy notify list and instead relying only on the idr
> list of stateids. Laundromat now traverses that list and if copy notify
> state wasn't referenced in a lease period, state is deleted.
> --- removed storing parent's stid pointer in the copy notify state.
> instead storing the parent's stateid and client id then using it to
> lookup the stid structure and client structure during validation of
> the stateid of the READ.
> --- added a refcount to the copy notify state to make sure only 1 will
> delete it (as it can be delete either by the nfs4_put_stid(),
> laundromat, or offload_cancel op. basically all access to the copy state
> is using just one global lock now (netd->s2s_cp_lock).
> --- added a type to the copy_stateid_t to distinguish copy notify state
> kept by the source server and copy state used by the destination server.
> --- previously with a global copy notify list, the check if client has
> state before unmounting checked if the list was empty, now the code
> traverses the idr list and looks for anything with a matching clientid
> (again under the global s2s_cp_lock).
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
>  fs/nfsd/nfs4proc.c        | 440 ++++++++++++++++++++++++++++++++++++++++++----
>  fs/nfsd/nfs4state.c       | 215 +++++++++++++++++++---
>  fs/nfsd/nfs4xdr.c         | 154 +++++++++++++++-
>  fs/nfsd/nfsd.h            |  32 ++++
>  fs/nfsd/nfsfh.h           |   5 +-
>  fs/nfsd/nfssvc.c          |   6 +
>  fs/nfsd/state.h           |  34 +++-
>  fs/nfsd/xdr4.h            |  39 +++-
>  include/linux/nfs4.h      |  25 +++
>  include/linux/nfs_fs.h    |   3 +-
>  include/linux/nfs_fs_sb.h |   1 +
>  include/linux/nfs_xdr.h   |  17 ++
>  22 files changed, 1431 insertions(+), 122 deletions(-)
>
> --
> 1.8.3.1
>
