Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9095B3920AE
	for <lists+linux-nfs@lfdr.de>; Wed, 26 May 2021 21:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhEZTPf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 May 2021 15:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232133AbhEZTPf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 May 2021 15:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622056443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YW0lZ03+1zTVRIfc0cRojaIWoUt8b8NcYeIxoSvj/ss=;
        b=RhF+nfnL0GbH8aC/CyfTpyCqwkO9+3ZbgjyJi8IvAzvm/DfxzqtjYY/eA+Fpzfrj7/X1ln
        30eY6tVSalrKnXoa/NwOS2lV6GmjFuOCkDdkwNDBMyw79TbOoedcCTmTabSDbZ4jx+tM07
        APiTgAa4Eyd9hfkQT6PmmFlbV8w3cDs=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-wC9-5rfmPQmTOxoDd2NF6w-1; Wed, 26 May 2021 15:14:01 -0400
X-MC-Unique: wC9-5rfmPQmTOxoDd2NF6w-1
Received: by mail-yb1-f200.google.com with SMTP id j7-20020a258b870000b029052360b1e3e2so2812422ybl.8
        for <linux-nfs@vger.kernel.org>; Wed, 26 May 2021 12:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YW0lZ03+1zTVRIfc0cRojaIWoUt8b8NcYeIxoSvj/ss=;
        b=R0k1HY8tViixSIHvwTm7HAxEWb9K5ys9nVXH2wRZYFxgk6y02b5oqgjwMoARupJBj4
         3uAndMUBX+QSSxZ1t52VsqSEl2zeK1u8rYg9+E60euzuizfVl/G5pZ70/aBnDCigBtdP
         /res3xQpGdQGwB6piG8rcVrXYaMbPW5N6qNh7furwRNE8VgzcMA1ktuW3u5VVm/8KR2I
         3mAk0NSgFFi76J2TiVrm6rYLfMUb/SijJehUdyofcgBgJL1mLYFE9oKVODwTkvFFolH2
         bWfqmkICTleZTHPeQagkzdo8n/5T2/Ytvs9+P3OXTFEFZBg1wT5CE0ZOT2NQKN17ksxP
         Mhdw==
X-Gm-Message-State: AOAM533t/CXn7CcLteb+v5h4gvlfBAv/RYdWnq8tOwPKBzN6FA7w0cE/
        kaLHusTay8gc0MdvFbhe51koftCSkvOpt+QLOCZVa+qeMS2s+l1XHcNc8T/ENjqJtkK7BMeIuUT
        kQGRUbFi2ClLbdAoHT4S2QGdhnaDsLnEADdKV
X-Received: by 2002:a5b:492:: with SMTP id n18mr34623632ybp.102.1622056441166;
        Wed, 26 May 2021 12:14:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9WvOh0kWhAeL9xIfamG//wVzXBnk/9Ib253NgeGeyAXiWoQLUCeQI07qfv67pshdTlEoiHm1qXK2dHD9mwos=
X-Received: by 2002:a5b:492:: with SMTP id n18mr34623610ybp.102.1622056440969;
 Wed, 26 May 2021 12:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <1621283385-24390-1-git-send-email-dwysocha@redhat.com>
 <1621283385-24390-2-git-send-email-dwysocha@redhat.com> <20210525205845.GB4162@fieldses.org>
 <6C2F8C95-E29F-4BB3-9127-6ED5D825ACB7@oracle.com> <20210526183011.GA7823@fieldses.org>
In-Reply-To: <20210526183011.GA7823@fieldses.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 26 May 2021 15:13:24 -0400
Message-ID: <CALF+zOnwEgMEv6FS=888x6_YHFTama-qdeoCWroiHnrtxe6QVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] nfsd4: Expose the callback address and state of
 each NFS4 client
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 26, 2021 at 2:30 PM Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, May 25, 2021 at 09:48:38PM +0000, Chuck Lever III wrote:
> >
> >
> > > On May 25, 2021, at 4:58 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > When I run trace-cmd report I get output like:
> > >
> > >  [nfsd:nfsd_cb_state] function cb_state2str not defined
> > >  [nfsd:nfsd_cb_shutdown] function cb_state2str not defined
> > >  [nfsd:nfsd_cb_probe] function cb_state2str not defined
> > >  [nfsd:nfsd_cb_lost] function cb_state2str not defined
> > >
> > > I don't know how this is supposed to work.  Is it OK for tracepoint definitions
> > > to reference kernel functions if they're defined in the right way somehow?  If
> > > not, I don't know what the solution would be for sharing this--define a macro
> > > that expands to the array literal and use that in both places?  Or maybe just
> > > live with the the redundancy.
> >
> > Living with the redundancy is OK with me.
>
> OK, I'll revert back to Dave's first version of this patch.
>

I'm ok with the above.

If reuse was desired we could do something like this, but it's a bit
ugly / convoluted:

diff --git a/fs/nfsd/trace.c b/fs/nfsd/trace.c
index f008b95ceec2..54c31b5f42d4 100644
--- a/fs/nfsd/trace.c
+++ b/fs/nfsd/trace.c
@@ -2,3 +2,16 @@

 #define CREATE_TRACE_POINTS
 #include "trace.h"
+
+const char *cb_state2str(const int state)
+{
+       int i;
+       const struct trace_print_flags state_array[] = { CB_STATE_ARRAY,
+                                                        { -1, NULL } };
+
+       for (i = 0; state_array[i].name; i++)
+               if (state == state_array[i].mask)
+                       return state_array[i].name;
+
+       return "UNDEFINED";
+}
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 10cc3aaf1089..f21841f4ae3b 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -876,12 +876,12 @@ TRACE_EVENT(nfsd_cb_nodelegs,
        TP_printk("client %08x:%08x", __entry->cl_boot, __entry->cl_id)
 )

-#define show_cb_state(val)                                             \
-       __print_symbolic(val,                                           \
-               { NFSD4_CB_UP,          "UP" },                         \
-               { NFSD4_CB_UNKNOWN,     "UNKNOWN" },                    \
-               { NFSD4_CB_DOWN,        "DOWN" },                       \
-               { NFSD4_CB_FAULT,       "FAULT"})
+#define CB_STATE_ARRAY \
+       { NFSD4_CB_UP,          "UP" },                 \
+       { NFSD4_CB_UNKNOWN,     "UNKNOWN" },            \
+       { NFSD4_CB_DOWN,        "DOWN" },               \
+       { NFSD4_CB_FAULT,       "FAULT"}
+extern const char *cb_state2str(const int state);

 DECLARE_EVENT_CLASS(nfsd_cb_class,
        TP_PROTO(const struct nfs4_client *clp),
@@ -901,7 +901,7 @@ DECLARE_EVENT_CLASS(nfsd_cb_class,
        ),
        TP_printk("addr=%pISpc client %08x:%08x state=%s",
                __entry->addr, __entry->cl_boot, __entry->cl_id,
-               show_cb_state(__entry->state))
+               __print_symbolic(__entry->state, CB_STATE_ARRAY))
 );

 #define DEFINE_NFSD_CB_EVENT(name)                     \


> --b.
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 49c052243b5c..89a7cada334d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2357,6 +2357,21 @@ static void seq_quote_mem(struct seq_file *m, char *data, int len)
>         seq_printf(m, "\"");
>  }
>
> +static const char *cb_state_str(int state)
> +{
> +       switch (state) {
> +               case NFSD4_CB_UP:
> +                       return "UP";
> +               case NFSD4_CB_UNKNOWN:
> +                       return "UNKNOWN";
> +               case NFSD4_CB_DOWN:
> +                       return "DOWN";
> +               case NFSD4_CB_FAULT:
> +                       return "FAULT";
> +       }
> +       return "UNDEFINED";
> +}
> +
>  static int client_info_show(struct seq_file *m, void *v)
>  {
>         struct inode *inode = m->private;
> @@ -2385,6 +2400,8 @@ static int client_info_show(struct seq_file *m, void *v)
>                 seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
>                         clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
>         }
> +       seq_printf(m, "callback state: %s\n", cb_state_str(clp->cl_cb_state));
> +       seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
>         drop_client(clp);
>
>         return 0;
> --
> 1.8.3.1
>

