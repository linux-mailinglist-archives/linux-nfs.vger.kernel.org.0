Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96A433B90
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhJSQGH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 12:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhJSQGG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 12:06:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598EBC061746
        for <linux-nfs@vger.kernel.org>; Tue, 19 Oct 2021 09:03:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r18so14957580edv.12
        for <linux-nfs@vger.kernel.org>; Tue, 19 Oct 2021 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCsWOZ0lLQb2sTiDh0zcVluPb2BJjaHGR/Locn0Ft4I=;
        b=AwZilIsv4+zxZnWpzvAxHxEQ43QlkAP95szK2lsH3S78kS5CaE/cF7FrITPkNzXFdf
         Qznq6jCVSPQ5lhvSCgK4/iCy1DEGpsPF2SLoKSZAyDMRYNjPtaiABC+Z5VcQr4u4e4Qo
         b2hOlKB9KnQrzNq5I8v7tpr8ZRZAsgAiavsDwivTmh2oHB0iYOEmDyltVHrCJV0PC55A
         iOcZ/L4hae1HdiPY/z2inFxBF6IxoVJ52eaDoxrkdD4XCUGfgM0zD91coFwXhlUX6BCu
         8XToquti7pCL5XejrHqYX0huQ2BCAavtVx38Wjv9La4qt1i08XjukjxjwxRPdyVBPPRX
         U1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCsWOZ0lLQb2sTiDh0zcVluPb2BJjaHGR/Locn0Ft4I=;
        b=LPwEh/ovUVV0XeNyvQprnGdAPN8bWqIZKeNBRh68ZLicG4B6lB/kolzSUMisSajyQW
         p+lN4WTS172DXrRgASksMTaS2xdkh/aMUDdxSdDjhGx6Rnk3Ig1LyS0PkxRR5lcWFAJE
         FYtQ9jh2zm8JuMEM5Vpc926I5m1PxIRCzOwpXGVzqHnHwVjPWvLvjSy52+Ik3uCqkZkT
         AxVo0SjgytcOfzAZsGUFxvNCB2znWImunKj+pl/UP2f4KY9Nk4iJCEvBBbcqcoIPpoQH
         mEn3txV9A5IFCHsAS7K3/GICRONBwKTabqQs/+H4AyOowNVIoxoA/Rp01p69YkIhwCbv
         B5pA==
X-Gm-Message-State: AOAM530XZtFmEksv6vi6gl+PnRvJYmTkBTV/obGDgGYoBWeyl4YuzFHD
        aZ1Uqn1j/hhObOdjolv84SlbuK74Yp1WO01PQU0=
X-Google-Smtp-Source: ABdhPJwdvnEq8WDSFsBJMGEQeYIWZ1Mpu1yMLwUF1YyYFddFBBM4w+NlJvXqdrHGcudfOvXOioSrBbFMVDpk3WXzVPw=
X-Received: by 2002:a05:6402:3586:: with SMTP id y6mr54951806edc.292.1634659272990;
 Tue, 19 Oct 2021 09:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
 <20211018220314.85115-6-olga.kornievskaia@gmail.com> <9B0CDAB8-670F-4D34-815D-49AC44B4DFC6@oracle.com>
In-Reply-To: <9B0CDAB8-670F-4D34-815D-49AC44B4DFC6@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 19 Oct 2021 12:01:01 -0400
Message-ID: <CAN-5tyH90dMe2QyLXVjZBZU_BV34a1=xc_NhwxDQmt1MbcnXQQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] NFSv4.2 add tracepoint to CB_OFFLOAD
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 19, 2021 at 11:17 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Oct 18, 2021, at 6:03 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Add a tracepoint to the CB_OFFLOAD operation.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> > fs/nfs/callback_proc.c |  3 +++
> > fs/nfs/nfs4trace.h     | 50 ++++++++++++++++++++++++++++++++++++++++++
> > 2 files changed, 53 insertions(+)
> >
> > diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
> > index ed9d580826f5..09c5b1cb3e07 100644
> > --- a/fs/nfs/callback_proc.c
> > +++ b/fs/nfs/callback_proc.c
> > @@ -739,6 +739,9 @@ __be32 nfs4_callback_offload(void *data, void *dummy,
> >               kfree(copy);
> >       spin_unlock(&cps->clp->cl_lock);
> >
> > +     trace_nfs4_cb_offload(&args->coa_fh, &args->coa_stateid,
> > +                     args->wr_count, args->error,
> > +                     args->wr_writeverf.committed);
> >       return 0;
> > }
> > #endif /* CONFIG_NFS_V4_2 */
> > diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> > index cc6537a20ebe..33f52d486528 100644
> > --- a/fs/nfs/nfs4trace.h
> > +++ b/fs/nfs/nfs4trace.h
> > @@ -2714,6 +2714,56 @@ TRACE_EVENT(nfs4_clone,
> >               )
> > );
> >
> > +#define show_write_mode(how)                 \
> > +        __print_symbolic(how,                        \
> > +                { NFS_UNSTABLE, "UNSTABLE" },        \
> > +                { NFS_DATA_SYNC, "DATA_SYNC" },      \
> > +             { NFS_FILE_SYNC, "FILE_SYNC"})
>
> Is there no way to reuse fs/nfs/nfstrace.h::nfs_show_stable() ?
>
> Btw, I have patches that move some NFS trace infrastructure
> into include/trace/events so that it can be shared between the
> NFS client and server trace subsystems. They might be useful
> here too.
>
> The generic FS macros are moved in this commit:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-more-tracepoints&id=495731e1332c7e26af1e04a88eb65e3c08dfbf53
>
> Some NFS macros are moved in this commit:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-more-tracepoints&id=24763f8889e0a18a8d06ddcd05bac06a7d043515
>
> Additional macros are introduced later in that same branch.
>
> I don't have any opinion about whether these should be
> applied before your patches or after them.

It sounds like, if there was already a show_nfs_stable_how() that I
could call then I don't need to define what I'm defining? So if I
apply your patches and and then my patches on top of that, that seems
like the way to go? That depends on if your patch(es) are ready to be
submitted or not? Alternatively, your patch(es) can fix my code. I
don't have a preference either way.

>
>
> > +
> > +TRACE_EVENT(nfs4_cb_offload,
> > +             TP_PROTO(
> > +                     const struct nfs_fh *cb_fh,
> > +                     const nfs4_stateid *cb_stateid,
> > +                     uint64_t cb_count,
> > +                     int cb_error,
> > +                     int cb_how_stable
> > +             ),
> > +
> > +             TP_ARGS(cb_fh, cb_stateid, cb_count, cb_error,
> > +                     cb_how_stable),
> > +
> > +             TP_STRUCT__entry(
> > +                     __field(unsigned long, error)
> > +                     __field(u32, fhandle)
> > +                     __field(loff_t, cb_count)
> > +                     __field(int, cb_how)
> > +                     __field(int, cb_stateid_seq)
> > +                     __field(u32, cb_stateid_hash)
> > +             ),
> > +
> > +             TP_fast_assign(
> > +                     __entry->error = cb_error < 0 ? -cb_error : 0;
> > +                     __entry->fhandle = nfs_fhandle_hash(cb_fh);
> > +                     __entry->cb_stateid_seq =
> > +                             be32_to_cpu(cb_stateid->seqid);
> > +                     __entry->cb_stateid_hash =
> > +                             nfs_stateid_hash(cb_stateid);
> > +                     __entry->cb_count = cb_count;
> > +                     __entry->cb_how = cb_how_stable;
> > +             ),
> > +
> > +             TP_printk(
> > +                     "error=%ld (%s) fhandle=0x%08x cb_stateid=%d:0x%08x "
> > +                     "cb_count=%llu cb_how=%s",
> > +                     -__entry->error,
> > +                     show_nfsv4_errors(__entry->error),
> > +                     __entry->fhandle,
> > +                     __entry->cb_stateid_seq, __entry->cb_stateid_hash,
> > +                     __entry->cb_count,
> > +                     show_write_mode(__entry->cb_how)
> > +             )
> > +);
> > +
> > #endif /* CONFIG_NFS_V4_1 */
> >
> > #endif /* _TRACE_NFS4_H */
> > --
> > 2.27.0
> >
>
> --
> Chuck Lever
>
>
>
