Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F632A6FC8
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 22:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgKDVkr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 16:40:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726827AbgKDVkr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 16:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604526044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BfsJ0FWzTY/cAKHR6bdvCzL/d89foQuZHwZN/WhjuGY=;
        b=XAcQFVwwZwBfhX9rn+drEbdgovUoxQ88hICEkpJZtK4Khon5dptBogYySv076BrryFMvgb
        ZJ8Hl+bu3HHyvjnS93nfyRcyafCg+3GehR8/lqIAn/hlvCpDn3QE6/gTIZYF/RHIXo8E9S
        HlDyFQ1mM66+gRG41eyMnndjG89Dm9I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-S7H2uTY8PJmrNMi4DwtYgA-1; Wed, 04 Nov 2020 16:40:41 -0500
X-MC-Unique: S7H2uTY8PJmrNMi4DwtYgA-1
Received: by mail-ed1-f69.google.com with SMTP id n16so9393142edw.19
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 13:40:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BfsJ0FWzTY/cAKHR6bdvCzL/d89foQuZHwZN/WhjuGY=;
        b=RESRthhwFS3wmABZr7es/Ezz+iFCPVPbyZX/IB0f/Fh73k+lU8M2KO4/USRUBpmhdQ
         LGSWv3oIpJ2vEn6bk/h6TfcoeYIjHFqXmcOnQW4h4LbyIvz5/6KCC5zb3UWc2lsiRtbu
         aBF2YWkh+dIXfzjm5cJknXaG16a6uU3cjX1/beu5cS2FbI2igSZv4o+fTyyWmPJonl5j
         /dTEUOvO+qDb25xK7S0qYwX3pqgzyRPWqdWXdHeGIcwnMyUjl6+ka7xE8QdECbf8HIZ2
         7NlQ/I6osG7zSjVuL2q45UMjZuJHerAMxRpajf90b1F8a+WCF4aRMsFWu/ibQcjxn15q
         Jdtw==
X-Gm-Message-State: AOAM532msQXa/l+rsVKLeL3NRGOPUN1KGrHxg6tcp3CILTmBTE1HEo1n
        Yi30H9CIU91LWm7/mCa/+2aY6A1ht00fESyiJ26scf86Gk/NUnHFj3GzzWKdFk3ZosnPSlvzve9
        h0FksRSkkY4m7f3R5iXNLbYdPcbFcnhFxIJ6o
X-Received: by 2002:aa7:c358:: with SMTP id j24mr29349746edr.265.1604526040200;
        Wed, 04 Nov 2020 13:40:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9SdwBJzJE92XrCsnrm7KsTZLGa6D+9JJJG438CfgcB3oUUM8ThVGmnwI97PvP/K2wX4sNvsPAEsjglijEZSU=
X-Received: by 2002:aa7:c358:: with SMTP id j24mr29349731edr.265.1604526039928;
 Wed, 04 Nov 2020 13:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com> <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com> <20201104161638.300324-5-trond.myklebust@hammerspace.com>
 <20201104161638.300324-6-trond.myklebust@hammerspace.com> <20201104161638.300324-7-trond.myklebust@hammerspace.com>
 <20201104161638.300324-8-trond.myklebust@hammerspace.com> <20201104161638.300324-9-trond.myklebust@hammerspace.com>
 <20201104161638.300324-10-trond.myklebust@hammerspace.com>
 <20201104161638.300324-11-trond.myklebust@hammerspace.com>
 <20201104161638.300324-12-trond.myklebust@hammerspace.com>
 <20201104161638.300324-13-trond.myklebust@hammerspace.com>
 <20201104161638.300324-14-trond.myklebust@hammerspace.com>
 <20201104161638.300324-15-trond.myklebust@hammerspace.com>
 <20201104161638.300324-16-trond.myklebust@hammerspace.com>
 <20201104161638.300324-17-trond.myklebust@hammerspace.com>
 <CALF+zOnbaR3x0FqLFY85_5y4e640h7kcm+ibwHsxPc0zocdrJA@mail.gmail.com> <5D348A8A-B486-4752-8F28-CB55C05F80D0@hammerspace.com>
In-Reply-To: <5D348A8A-B486-4752-8F28-CB55C05F80D0@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 4 Nov 2020 16:40:04 -0500
Message-ID: <CALF+zOmnYs1EW3nGpHsoF3=KBZNZWRbVsKX45CtcOSjHDvD=4g@mail.gmail.com>
Subject: Re: [PATCH v3 16/17] NFS: Improve handling of directory verifiers
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 4, 2020 at 4:32 PM Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>
>
>
> > On Nov 4, 2020, at 16:01, David Wysochanski <dwysocha@redhat.com> wrote=
:
> >
> > On Wed, Nov 4, 2020 at 11:28 AM <trondmy@gmail.com> wrote:
> >>
> >> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >>
> >> If the server insists on using the readdir verifiers in order to allow
> >> cookies to expire, then we should ensure that we cache the verifier
> >> with the cookie, so that we can return an error if the application
> >> tries to use the expired cookie.
> >>
> >> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> >> ---
> >> fs/nfs/dir.c           | 35 +++++++++++++++++++++++------------
> >> fs/nfs/inode.c         |  7 -------
> >> include/linux/nfs_fs.h |  8 +++++++-
> >> 3 files changed, 30 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> >> index 3b44bef3a1b4..454377228167 100644
> >> --- a/fs/nfs/dir.c
> >> +++ b/fs/nfs/dir.c
> >> @@ -155,6 +155,7 @@ struct nfs_readdir_descriptor {
> >>        loff_t          current_index;
> >>        loff_t          prev_index;
> >>
> >> +       __be32          verf[NFS_DIR_VERIFIER_SIZE];
> >>        unsigned long   dir_verifier;
> >>        unsigned long   timestamp;
> >>        unsigned long   gencount;
> >> @@ -466,15 +467,15 @@ static int nfs_readdir_search_array(struct nfs_r=
eaddir_descriptor *desc)
> >>
> >> /* Fill a page with xdr information before transferring to the cache p=
age */
> >> static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
> >> -                                 u64 cookie, struct page **pages,
> >> -                                 size_t bufsize)
> >> +                                 __be32 *verf, u64 cookie,
> >> +                                 struct page **pages, size_t bufsize,
> >> +                                 __be32 *verf_res)
> >> {
> >>        struct inode *inode =3D file_inode(desc->file);
> >> -       __be32 verf_res[2];
> >>        struct nfs_readdir_arg arg =3D {
> >>                .dentry =3D file_dentry(desc->file),
> >>                .cred =3D desc->file->f_cred,
> >> -               .verf =3D NFS_I(inode)->cookieverf,
> >> +               .verf =3D verf,
> >>                .cookie =3D cookie,
> >>                .pages =3D pages,
> >>                .page_len =3D bufsize,
> >> @@ -503,8 +504,6 @@ static int nfs_readdir_xdr_filler(struct nfs_readd=
ir_descriptor *desc,
> >>        }
> >>        desc->timestamp =3D timestamp;
> >>        desc->gencount =3D gencount;
> >> -       memcpy(NFS_I(inode)->cookieverf, res.verf,
> >> -              sizeof(NFS_I(inode)->cookieverf));
> >> error:
> >>        return error;
> >> }
> >> @@ -770,11 +769,13 @@ static struct page **nfs_readdir_alloc_pages(siz=
e_t npages)
> >> }
> >>
> >> static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *des=
c,
> >> -                                   struct page *page, struct inode *i=
node)
> >> +                                   struct page *page, __be32 *verf_ar=
g,
> >> +                                   __be32 *verf_res)
> >> {
> >>        struct page **pages;
> >>        struct nfs_entry *entry;
> >>        size_t array_size;
> >> +       struct inode *inode =3D file_inode(desc->file);
> >>        size_t dtsize =3D NFS_SERVER(inode)->dtsize;
> >>        int status =3D -ENOMEM;
> >>
> >> @@ -801,8 +802,9 @@ static int nfs_readdir_xdr_to_array(struct nfs_rea=
ddir_descriptor *desc,
> >>
> >>        do {
> >>                unsigned int pglen;
> >> -               status =3D nfs_readdir_xdr_filler(desc, entry->cookie,
> >> -                                               pages, dtsize);
> >> +               status =3D nfs_readdir_xdr_filler(desc, verf_arg, entr=
y->cookie,
> >> +                                               pages, dtsize,
> >> +                                               verf_res);
> >>                if (status < 0)
> >>                        break;
> >>
> >> @@ -854,13 +856,15 @@ static int find_and_lock_cache_page(struct nfs_r=
eaddir_descriptor *desc)
> >> {
> >>        struct inode *inode =3D file_inode(desc->file);
> >>        struct nfs_inode *nfsi =3D NFS_I(inode);
> >> +       __be32 verf[NFS_DIR_VERIFIER_SIZE];
> >>        int res;
> >>
> >>        desc->page =3D nfs_readdir_page_get_cached(desc);
> >>        if (!desc->page)
> >>                return -ENOMEM;
> >>        if (nfs_readdir_page_needs_filling(desc->page)) {
> >> -               res =3D nfs_readdir_xdr_to_array(desc, desc->page, ino=
de);
> >> +               res =3D nfs_readdir_xdr_to_array(desc, desc->page,
> >> +                                              nfsi->cookieverf, verf)=
;
> >>                if (res < 0) {
> >>                        nfs_readdir_page_unlock_and_put_cached(desc);
> >>                        if (res =3D=3D -EBADCOOKIE || res =3D=3D -ENOTS=
YNC) {
> >> @@ -870,6 +874,7 @@ static int find_and_lock_cache_page(struct nfs_rea=
ddir_descriptor *desc)
> >>                        }
> >>                        return res;
> >>                }
> >> +               memcpy(nfsi->cookieverf, verf, sizeof(nfsi->cookieverf=
));
> >>        }
> >>        res =3D nfs_readdir_search_array(desc);
> >>        if (res =3D=3D 0) {
> >> @@ -902,6 +907,7 @@ static int readdir_search_pagecache(struct nfs_rea=
ddir_descriptor *desc)
> >> static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
> >> {
> >>        struct file     *file =3D desc->file;
> >> +       struct nfs_inode *nfsi =3D NFS_I(file_inode(file));
> >>        struct nfs_cache_array *array;
> >>        unsigned int i =3D 0;
> >>
> >> @@ -915,6 +921,7 @@ static void nfs_do_filldir(struct nfs_readdir_desc=
riptor *desc)
> >>                        desc->eof =3D true;
> >>                        break;
> >>                }
> >> +               memcpy(desc->verf, nfsi->cookieverf, sizeof(desc->verf=
));
> >>                if (i < (array->size-1))
> >>                        desc->dir_cookie =3D array->array[i+1].cookie;
> >>                else
> >> @@ -949,8 +956,8 @@ static void nfs_do_filldir(struct nfs_readdir_desc=
riptor *desc)
> >> static int uncached_readdir(struct nfs_readdir_descriptor *desc)
> >> {
> >>        struct page     *page =3D NULL;
> >> +       __be32          verf[NFS_DIR_VERIFIER_SIZE];
> >>        int             status;
> >> -       struct inode *inode =3D file_inode(desc->file);
> >>
> >>        dfprintk(DIRCACHE, "NFS: uncached_readdir() searching for cooki=
e %Lu\n",
> >>                        (unsigned long long)desc->dir_cookie);
> >> @@ -967,7 +974,7 @@ static int uncached_readdir(struct nfs_readdir_des=
criptor *desc)
> >>        desc->duped =3D 0;
> >>
> >>        nfs_readdir_page_init_array(page, desc->dir_cookie);
> >> -       status =3D nfs_readdir_xdr_to_array(desc, page, inode);
> >> +       status =3D nfs_readdir_xdr_to_array(desc, page, desc->verf, ve=
rf);
> >>        if (status < 0)
> >>                goto out_release;
> >>
> >> @@ -1023,6 +1030,7 @@ static int nfs_readdir(struct file *file, struct=
 dir_context *ctx)
> >>        desc->dup_cookie =3D dir_ctx->dup_cookie;
> >>        desc->duped =3D dir_ctx->duped;
> >>        desc->attr_gencount =3D dir_ctx->attr_gencount;
> >> +       memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
> >>        spin_unlock(&file->f_lock);
> >>
> >>        do {
> >> @@ -1061,6 +1069,7 @@ static int nfs_readdir(struct file *file, struct=
 dir_context *ctx)
> >>        dir_ctx->dup_cookie =3D desc->dup_cookie;
> >>        dir_ctx->duped =3D desc->duped;
> >>        dir_ctx->attr_gencount =3D desc->attr_gencount;
> >> +       memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
> >>        spin_unlock(&file->f_lock);
> >>
> >>        kfree(desc);
> >> @@ -1101,6 +1110,8 @@ static loff_t nfs_llseek_dir(struct file *filp, =
loff_t offset, int whence)
> >>                        dir_ctx->dir_cookie =3D offset;
> >>                else
> >>                        dir_ctx->dir_cookie =3D 0;
> >> +               if (offset =3D=3D 0)
> >> +                       memset(dir_ctx->verf, 0, sizeof(dir_ctx->verf)=
);
> >>                dir_ctx->duped =3D 0;
> >>        }
> >>        spin_unlock(&filp->f_lock);
> >
> > Thanks for doing these patches!
> >
> > For some reason this patch does not apply but I get a problem at this h=
unk.
> > Is there a fixup or hunk or two missing from 01/17 ?
> > I'm starting at 3cea11cd5e3b (Linux 5.10-rc2).
> >
> > Problem looks like it's at the spin_unlock - here's what the hunk
> > looks like for me:
> > fs/nfs/dir.c
> > 1092         inode_lock(inode);
> > 1093         offset +=3D filp->f_pos;
> > 1094         if (offset < 0) {
> > 1095             inode_unlock(inode);
> > 1096             return -EINVAL;
> > 1097         }
> > 1098     }
> > 1099     if (offset !=3D filp->f_pos) {
> > 1100         filp->f_pos =3D offset;
> > 1101         if (nfs_readdir_use_cookie(filp))
> > 1102             dir_ctx->dir_cookie =3D offset;
> > 1103         else
> > 1104             dir_ctx->dir_cookie =3D 0;
> > 1105         dir_ctx->duped =3D 0;
> > 1106     }
> > 1107     inode_unlock(inode);
> > 1108     return offset;
> > 1109 }
> >
>
> Yes, it depends on the patch "[PATCH 1/2] NFS: Remove unnecessary inode l=
ocking in nfs_llseek_dir()=E2=80=9D that I sent out to the list on Oct 30.
> I can include that in future updates of this patchset.
>

FWIW, the statement of the dependency is fine with me - I grabbed the
other two patches and now applies cleanly.
Thanks!

