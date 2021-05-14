Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA1380FB0
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 20:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhENSYD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 14:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhENSYD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 14:24:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A13C06174A
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 11:22:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k10so19044ejj.8
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxQBxQDJMg3hbnaVS+4dFc1QE+KLGMlNk3S6HxLwxxU=;
        b=E9CDSAvx4WsGxUnrQid4Yva9n0ZoHp3ryXb/TNmN/k5q/InTJ3ig6huqD3oHtRuzoa
         aA9wYChj/3MCta0H6IJoNvFuwj72eU9fOT3iAEkpcT1zEDYZRVB1q/aMqucy1ha/xig7
         fJYL46neiWtbfq7uxOh86YO3Y2zTQTHvMaRapTAaVlaPaBdua+1BgXdxM1Vq7yA8z5ZC
         aBUeNKqmTMt4wQbzrrNUrEyqmkyA5PNN9G/gOVG+ov0BIFJGbvmJyH8DIcpGgwU/x/el
         iCLcU3svCCT4W6P7rU/9R+xOM2j3eNZAsysXIJh8vASyXLbLGBWJ4pPWSt64vVKbuwTT
         kJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxQBxQDJMg3hbnaVS+4dFc1QE+KLGMlNk3S6HxLwxxU=;
        b=UafrXqHGO3Iwv//yX4a6HqDcYydr0ks10kBhCZwelldpKJFYwuXOHslKkEo40Yhf/C
         wM3benY+HHRAg0J2fFR1vGHCAMIY3+43hRedejM67GFGMwik38oVc6wl6a/es7Vkg7+h
         2++oun1n6DPHRThLyX2Ynn/5NjsRuwYwCuEyRK3lZacnQnYo3CXCn+8C/Wl8JhJc9HNv
         U2U4Haol2t8LPfm6A4+5/h1rQRRlkPK7OQgGdC32y+YGiSNAdoiKOvOzlsKMPOnjLCus
         8x9kvkbt2vXsp0kka1ZC/d+lFNpLeIm3RcAgi/TsPWHw0Q2YhiIRpJECYkFMYK/dgZFA
         2C5Q==
X-Gm-Message-State: AOAM533Gf1WiypbqgtSRb3Dkb1QkJV6Ozv2ki7dlXfU93tm5jQEqdVgg
        2Dl5RkimtVTUyd3yYl5fFxXPMOfK6ouX7gDE1FC3c4/SV4E=
X-Google-Smtp-Source: ABdhPJyn1ozo7dCaLtUkR5XUJbgvEwHmOCek7AxFlijuVfO2jw0o/5XWBRJ9zeY45ChYaNsUyON5I4ViAEwNPa/naMI=
X-Received: by 2002:a17:906:7c02:: with SMTP id t2mr15028430ejo.0.1621016569558;
 Fri, 14 May 2021 11:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
 <162066195300.94415.3319200148715325125.stgit@klimt.1015granger.net>
In-Reply-To: <162066195300.94415.3319200148715325125.stgit@klimt.1015granger.net>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 14 May 2021 14:22:38 -0400
Message-ID: <CAN-5tyEOW8bgsSsM2euG3JZ7oOd58Ee6hCGHu52SEUoSKRoFdw@mail.gmail.com>
Subject: Re: [PATCH RFC 09/21] NFSD: Add an nfsd_cb_offload tracepoint
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Mon, May 10, 2021 at 12:05 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Record the arguments of CB_OFFLOAD callbacks so we can better
> observe asynchronous copy-offload behavior. For example:
>
>             nfsd-995   [008]  7721.934222: nfsd_cb_offload:      addr=192.168.2.51:0 client 6092a47c:35a43fc1 fh_hash=0x8739113a

I like the idea but can we include copy->nfserr if there is one and/or
if not then size copied?

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: Olga Kornievskaia <kolga@netapp.com>
> Cc: Dai Ngo <Dai.Ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c |    1 +
>  fs/nfsd/trace.h    |   30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index daf43b980d4b..7a13f6c848c6 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1497,6 +1497,7 @@ static int nfsd4_do_async_copy(void *data)
>         memcpy(&cb_copy->fh, &copy->fh, sizeof(copy->fh));
>         nfsd4_init_cb(&cb_copy->cp_cb, cb_copy->cp_clp,
>                         &nfsd4_cb_offload_ops, NFSPROC4_CLNT_CB_OFFLOAD);
> +       trace_nfsd_cb_offload(copy->cp_clp, &copy->cp_res.cb_stateid, &copy->fh);
>         nfsd4_run_cb(&cb_copy->cp_cb);
>  out:
>         if (!copy->cp_intra)
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 1dce41b3bd4d..15cacbdac411 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1004,6 +1004,36 @@ TRACE_EVENT(nfsd_cb_notify_lock,
>                 __entry->fh_hash)
>  );
>
> +TRACE_EVENT(nfsd_cb_offload,
> +       TP_PROTO(
> +               const struct nfs4_client *clp,
> +               const stateid_t *stp,
> +               const struct knfsd_fh *fh
> +       ),
> +       TP_ARGS(clp, stp, fh),
> +       TP_STRUCT__entry(
> +               __field(u32, cl_boot)
> +               __field(u32, cl_id)
> +               __field(u32, si_id)
> +               __field(u32, si_generation)
> +               __field(u32, fh_hash)
> +               __array(unsigned char, addr, sizeof(struct sockaddr_in6))
> +       ),
> +       TP_fast_assign(
> +               __entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
> +               __entry->cl_id = stp->si_opaque.so_clid.cl_id;
> +               __entry->si_id = stp->si_opaque.so_id;
> +               __entry->si_generation = stp->si_generation;
> +               __entry->fh_hash = knfsd_fh_hash(fh);
> +               memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
> +                       sizeof(struct sockaddr_in6));
> +       ),
> +       TP_printk("addr=%pISpc client %08x:%08x stateid %08x:%08x fh_hash=0x%08x",
> +               __entry->addr, __entry->cl_boot, __entry->cl_id,
> +               __entry->si_id, __entry->si_generation,
> +               __entry->fh_hash)
> +);
> +
>  #endif /* _NFSD_TRACE_H */
>
>  #undef TRACE_INCLUDE_PATH
>
>
