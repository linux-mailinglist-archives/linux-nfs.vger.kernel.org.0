Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968DF433D01
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 19:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhJSRKl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 19 Oct 2021 13:10:41 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174]:34612 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbhJSRKl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 13:10:41 -0400
Received: by mail-yb1-f174.google.com with SMTP id q189so5591227ybq.1
        for <linux-nfs@vger.kernel.org>; Tue, 19 Oct 2021 10:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/LoT/KIPg9OJT0Xn3mQK6qgO6Hl5Y6KB0240BATO4lw=;
        b=00Uccb96T/7gO00KlnI3HSDrxWcywkEmAZL8uyfV5M1yWbMw8yCl252FVio0+aI1O2
         BevOnjMd1a0+ZxBPlDZ5Zi/ixB5RsKwI4KEcGkC5bwKrfnxb+kTnmarcRgeeugS7yz0a
         rv3wMiJz4claR3wlnhgPYDdHQMuau0TRSy+VfgZ5vEi0yMh/Z2iPIqNes109cH6d6few
         PcF2zB+man+oCkHDM/X1FsmN+sevBOZaw3rzAsHDHTXM5mK1P/jiDdLWznCIIiKPVxc5
         jJc3wTAl2qi4KB3AXsxCOskEIyy547/FXWxK3uMy2sLGPrq3GtGHLrctseeS7gTCXHjA
         HRoA==
X-Gm-Message-State: AOAM533k48Q6g8b7qriqbLJZxdqeNH0Hi6lofnjy95aTgXpvvyW06MbR
        spTw1gCmt1A/YDzRhrX5aMExAI8hIUqI4FKReyIsMXoPayc=
X-Google-Smtp-Source: ABdhPJwT0e0r0bX/jxEw6IBgZ3ZWLcSEGJTC/2z47CWERPigaifPuO6AkI4zq4b45KgmZYi48wU4V5w0okDnkfJ8Wo8=
X-Received: by 2002:a05:6902:1004:: with SMTP id w4mr16739402ybt.509.1634663307645;
 Tue, 19 Oct 2021 10:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211018220314.85115-1-olga.kornievskaia@gmail.com> <20211018220314.85115-2-olga.kornievskaia@gmail.com>
In-Reply-To: <20211018220314.85115-2-olga.kornievskaia@gmail.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 19 Oct 2021 13:08:11 -0400
Message-ID: <CAFX2Jf=Se+x77694V1ctgeb5MgmJL-H4vOLVU_NiTSu-eAy9yA@mail.gmail.com>
Subject: Re: [PATCH 1/7] NFSv4.2 add tracepoint to SEEK
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

On Mon, Oct 18, 2021 at 6:05 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Add a tracepoint to the SEEK operation.

Compiling with CONFIG_NFS_V4_1=y but CONFIG_NFS_V4_2=n gives me the following:

In file included from fs/nfs/nfs4trace.h:11,
                 from fs/nfs/nfs4state.c:63:
fs/nfs/nfs4trace.h:2432:38: error: ‘struct nfs42_seek_res’ declared
inside parameter list will not be visible outside of this definition
or declaration [-Werror]
 2432 |                         const struct nfs42_seek_res *res,

You probably need to check for CONFIG_NFS_V4_2 inside nfs4trace.h

Anna

>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/nfs42proc.c |  1 +
>  fs/nfs/nfs4trace.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index a24349512ffe..87c0dcb8823b 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -678,6 +678,7 @@ static loff_t _nfs42_proc_llseek(struct file *filep,
>
>         status = nfs4_call_sync(server->client, server, &msg,
>                                 &args.seq_args, &res.seq_res, 0);
> +       trace_nfs4_llseek(inode, &args, &res, status);
>         if (status == -ENOTSUPP)
>                 server->caps &= ~NFS_CAP_SEEK;
>         if (status)
> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> index 7a2567aa2b86..81dcbfca7f74 100644
> --- a/fs/nfs/nfs4trace.h
> +++ b/fs/nfs/nfs4trace.h
> @@ -2417,6 +2417,71 @@ TRACE_EVENT(ff_layout_commit_error,
>                 )
>  );
>
> +TRACE_DEFINE_ENUM(NFS4_CONTENT_DATA);
> +TRACE_DEFINE_ENUM(NFS4_CONTENT_HOLE);
> +
> +#define show_llseek_mode(what)                 \
> +       __print_symbolic(what,                  \
> +               { NFS4_CONTENT_DATA, "DATA" },          \
> +               { NFS4_CONTENT_HOLE, "HOLE" })
> +
> +TRACE_EVENT(nfs4_llseek,
> +               TP_PROTO(
> +                       const struct inode *inode,
> +                       const struct nfs42_seek_args *args,
> +                       const struct nfs42_seek_res *res,
> +                       int error
> +               ),
> +
> +               TP_ARGS(inode, args, res, error),
> +
> +               TP_STRUCT__entry(
> +                       __field(unsigned long, error)
> +                       __field(u32, fhandle)
> +                       __field(u32, fileid)
> +                       __field(dev_t, dev)
> +                       __field(int, stateid_seq)
> +                       __field(u32, stateid_hash)
> +                       __field(loff_t, offset_s)
> +                       __field(u32, what)
> +                       __field(loff_t, offset_r)
> +                       __field(u32, eof)
> +               ),
> +
> +               TP_fast_assign(
> +                       const struct nfs_inode *nfsi = NFS_I(inode);
> +                       const struct nfs_fh *fh = args->sa_fh;
> +
> +                       __entry->fileid = nfsi->fileid;
> +                       __entry->dev = inode->i_sb->s_dev;
> +                       __entry->fhandle = nfs_fhandle_hash(fh);
> +                       __entry->offset_s = args->sa_offset;
> +                       __entry->error = error < 0 ? -error : 0;
> +                       __entry->stateid_seq =
> +                               be32_to_cpu(args->sa_stateid.seqid);
> +                       __entry->stateid_hash =
> +                               nfs_stateid_hash(&args->sa_stateid);
> +                       __entry->what = args->sa_what;
> +                       __entry->offset_r = error < 0 ? 0 : res->sr_offset;
> +                       __entry->eof = error < 0 ? 0 : res->sr_eof;
> +               ),
> +
> +               TP_printk(
> +                       "error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
> +                       "stateid=%d:0x%08x offset_s=%llu what=%s "
> +                       "offset_r=%llu eof=%u",
> +                       -__entry->error,
> +                       show_nfsv4_errors(__entry->error),
> +                       MAJOR(__entry->dev), MINOR(__entry->dev),
> +                       (unsigned long long)__entry->fileid,
> +                       __entry->fhandle,
> +                       __entry->stateid_seq, __entry->stateid_hash,
> +                       __entry->offset_s,
> +                       show_llseek_mode(__entry->what),
> +                       __entry->offset_r,
> +                       __entry->eof
> +               )
> +);
>
>  #endif /* CONFIG_NFS_V4_1 */
>
> --
> 2.27.0
>
