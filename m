Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD842B95D7
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Nov 2020 16:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgKSPKI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Nov 2020 10:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgKSPKH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Nov 2020 10:10:07 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B7AC0613CF
        for <linux-nfs@vger.kernel.org>; Thu, 19 Nov 2020 07:10:07 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id m16so6198976edr.3
        for <linux-nfs@vger.kernel.org>; Thu, 19 Nov 2020 07:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jblG5vlnIeQi/f1s88g0/ph9RJwWEH7YXXODET8ZxII=;
        b=D96hBqn1wgvqgPTQWEUfDoj4aVh1PFF+J3U7ybWcYdKTY8pJetISbH67FI+YLxqOyc
         p/5TmHdu7dg/+4JC5ygDrrQ+T5bq3NKJSS2OoMOKZ2DuRGJFFmA9ahtFYNzN3oqdCOZx
         hfmOs5F7qAWvteHxWs3IZ4WCpb4iMgvZBmN1W8ha/crVpPXaH8oTwOCawjjjqJQFjKCz
         wUHkdhFgbjHqWxc73+Mqgf8XPf8qto1FgOorTHW50T/qNcS3AFFRonHOlL22XHOqkk7d
         6N5xd3oWHLj8Z9zLAZNzZ7Vr5jH+6MMPt9D1lQAMnni3sw2DGFdmhn+18e+dBRUDe78C
         EMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jblG5vlnIeQi/f1s88g0/ph9RJwWEH7YXXODET8ZxII=;
        b=QPS6PJZ2/88hBp5wbBm2o4zkQhQRNJrS8RlvnNEr2g/dszUk6J5n+3hXZq9ayWEh35
         zJgFY33rAEFs1zmtJ+fBCqJClTsjD4gn3pW9oGoMrRvFH/V+6zT6Ax8owejyVF21scyz
         1qa07xJIkgHgiwyJ3+mtcSYnmQgNFOHx20gfxiOmkiLlu2zqRuRTuNWyoeg80lkHU8dG
         Sr5uJnCyRqNsgQgk24II/F1LcoUuzWSkGDjD5ezWs2woo8u06qEEuiYSGXXZk2rJeW51
         Djgd37QPBGjceoiVUl5iscSMh3jLQPr5NChWLD5xrf9wgVQ+vUWHiZlMNuhQQ18FJdHR
         8KpA==
X-Gm-Message-State: AOAM531mSwaqSrio7f6XVHwltPUyrv8xpBiwLZr+XG9MUo/YNAuS+YpA
        9PdPMaRtKKjdm5lJu62VwKYvAresQnoELgFHY1jsR/Uc
X-Google-Smtp-Source: ABdhPJyMWDDXkMdrj1jXG+NAX9hj0C8v/Hae8iSYUM2w7JigfpknUvGFl3R57Ep5aPSuauHttAN/iUC51fP3+liYq08=
X-Received: by 2002:a05:6402:559:: with SMTP id i25mr33578117edx.128.1605798605928;
 Thu, 19 Nov 2020 07:10:05 -0800 (PST)
MIME-Version: 1.0
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com> <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com>
In-Reply-To: <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 19 Nov 2020 10:09:54 -0500
Message-ID: <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Frank van der Linden <fllinden@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 19, 2020 at 9:37 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi Olga-
>
> > On Nov 18, 2020, at 4:44 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > Hi Chuck,
> >
> > The first problem I found was from 5.10-rc3 testing was from the fact
> > that tail's iov_len was set to -4 and reply_chunk was trying to call
> > rpcrdma_convert_kvec() for a tail that didn't exist.
> >
> > Do you see issues with this fix?
> >
> > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > index 71e03b930b70..2e6a228abb95 100644
> > --- a/net/sunrpc/xdr.c
> > +++ b/net/sunrpc/xdr.c
> > @@ -193,7 +193,7 @@ xdr_inline_pages(struct xdr_buf *xdr, unsigned int offset,
> >
> >        tail->iov_base = buf + offset;
> >        tail->iov_len = buflen - offset;
> > -       if ((xdr->page_len & 3) == 0)
> > +       if ((xdr->page_len & 3) == 0 && tail->iov_len)
> >                tail->iov_len -= sizeof(__be32);
> >
> >        xdr->buflen += len;
>
> It's not clear to me whether only the listxattrs encoder is
> not providing a receive tail kvec, or whether all the encoders
> fail to provide a tail in this case.

There is nothing specific that listxattr does, it just calls
rpc_prepare_pages(). Isn't tail[0] always there (xdr_buf structure has
tail[1] defined)? But not all requests have data in the page. So as
far as I understand, tail->iov_len can be 0 so not checking for it is
wrong.

> > This one fixes KASAN's reported problem of added at the end of this message.
> >
> > The next problem that I can't figure out yet is another KASAN's report
> > during the completion of the request.
> >
> > [   99.610666] BUG: KASAN: wild-memory-access in
> > rpcrdma_complete_rqst+0x41b/0x680 [rpcrdma]
> > [   99.617947] Write of size 4 at addr 0005088000000000 by task kworker/1:1H/490
> >
> >
> > This is the KASAN for the negative tail problem:
> > [  665.767611] ==================================================================
> > [  665.772202] BUG: KASAN: slab-out-of-bounds in
> > rpcrdma_convert_kvec.isra.29+0x4a/0xc4 [rpcrdma]
> > [  665.777860] Write of size 8 at addr ffff88803ded9b70 by task fsstress/3123
> > [  665.783754]
> > [  665.784981] CPU: 0 PID: 3123 Comm: fsstress Not tainted 5.10.0-rc3+ #38
> > [  665.790534] Hardware name: VMware, Inc. VMware Virtual
> > Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
> > [  665.798538] Call Trace:
> > [  665.800398]  dump_stack+0x7c/0xa2
> > [  665.802647]  ? rpcrdma_convert_kvec.isra.29+0x4a/0xc4 [rpcrdma]
> > [  665.808145]  print_address_description.constprop.7+0x1e/0x230
> > [  665.812543]  ? record_print_text.cold.38+0x11/0x11
> > [  665.816093]  ? _raw_write_lock_irqsave+0xe0/0xe0
> > [  665.819257]  ? rpcrdma_convert_kvec.isra.29+0x4a/0xc4 [rpcrdma]
> > [  665.823368]  ? rpcrdma_convert_kvec.isra.29+0x4a/0xc4 [rpcrdma]
> > [  665.827837]  kasan_report.cold.9+0x37/0x7c
> > [  665.830076]  ? rpcrdma_convert_kvec.isra.29+0x4a/0xc4 [rpcrdma]
> > [  665.834066]  rpcrdma_convert_kvec.isra.29+0x4a/0xc4 [rpcrdma]
> > [  665.837342]  rpcrdma_convert_iovs.isra.30.cold.41+0x9b/0xa0 [rpcrdma]
> > [  665.841766]  ? decode_read_list+0x40/0x40 [rpcrdma]
> > [  665.845063]  ? _raw_spin_lock_irqsave+0x80/0xe0
> > [  665.848444]  ? xdr_reserve_space+0x12e/0x360 [sunrpc]
> > [  665.852186]  ? xdr_init_encode+0x104/0x130 [sunrpc]
> > [  665.855305]  rpcrdma_marshal_req.cold.43+0x39/0x1fa [rpcrdma]
> > [  665.859771]  ? _raw_spin_lock+0x7a/0xd0
> > [  665.862516]  ? rpcrdma_prepare_send_sges+0x7e0/0x7e0 [rpcrdma]
> > [  665.866533]  ? call_bind+0x60/0xf0 [sunrpc]
> > [  665.869382]  xprt_rdma_send_request+0x79/0x190 [rpcrdma]
> > [  665.872965]  xprt_transmit+0x2ae/0x6c0 [sunrpc]
> > [  665.875955]  ? call_bind+0xf0/0xf0 [sunrpc]
> > [  665.878372]  call_transmit+0xdd/0x110 [sunrpc]
> > [  665.881539]  ? call_bind+0xf0/0xf0 [sunrpc]
> > [  665.884629]  __rpc_execute+0x11c/0x6e0 [sunrpc]
> > [  665.888300]  ? trace_event_raw_event_xprt_cong_event+0x270/0x270 [sunrpc]
> > [  665.893935]  ? rpc_make_runnable+0x54/0xe0 [sunrpc]
> > [  665.898021]  rpc_run_task+0x29c/0x2c0 [sunrpc]
> > [  665.901142]  nfs4_call_sync_custom+0xc/0x40 [nfsv4]
> > [  665.904903]  nfs4_do_call_sync+0x114/0x160 [nfsv4]
> > [  665.908633]  ? nfs4_call_sync_custom+0x40/0x40 [nfsv4]
> > [  665.913094]  ? __alloc_pages_nodemask+0x200/0x410
> > [  665.916831]  ? kasan_unpoison_shadow+0x30/0x40
> > [  665.920393]  ? __kasan_kmalloc.constprop.8+0xc1/0xd0
> > [  665.924403]  _nfs42_proc_listxattrs+0x1f6/0x2f0 [nfsv4]
> > [  665.928552]  ? kasan_set_free_info+0x1b/0x30
> > [  665.932283]  ? nfs42_offload_cancel_done+0x50/0x50 [nfsv4]
> > [  665.936240]  ? _raw_spin_lock+0x7a/0xd0
> > [  665.938677]  nfs42_proc_listxattrs+0xf4/0x150 [nfsv4]
> > [  665.942532]  ? nfs42_proc_setxattr+0x150/0x150 [nfsv4]
> > [  665.946410]  ? nfs4_xattr_cache_list+0x21/0x120 [nfsv4]
> > [  665.950095]  nfs4_listxattr+0x34d/0x3d0 [nfsv4]
> > [  665.952951]  ? _nfs4_proc_access+0x260/0x260 [nfsv4]
> > [  665.956383]  ? __ia32_sys_rename+0x40/0x40
> > [  665.959559]  ? __ia32_sys_lstat+0x30/0x30
> > [  665.962519]  ? __check_object_size+0x178/0x220
> > [  665.965830]  ? strncpy_from_user+0xe9/0x230
> > [  665.968401]  ? security_inode_listxattr+0x20/0x60
> > [  665.971653]  listxattr+0xd1/0xf0
> > [  665.974065]  path_listxattr+0xa1/0x100
> > [  665.977023]  ? listxattr+0xf0/0xf0
> > [  665.979305]  do_syscall_64+0x33/0x40
> > [  665.981561]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [  665.985559] RIP: 0033:0x7fe3f5a1fc8b
> > [  665.988136] Code: f0 ff ff 73 01 c3 48 8b 0d fa 21 2c 00 f7 d8 64
> > 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 c2 00 00
> > 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cd 21 2c 00 f7 d8 64 89
> > 01 48
> > [  666.002248] RSP: 002b:00007ffc826128e8 EFLAGS: 00000206 ORIG_RAX:
> > 00000000000000c2
> > [  666.007760] RAX: ffffffffffffffda RBX: 0000000000000021 RCX: 00007fe3f5a1fc8b
> > [  666.012999] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000016eaf70
> > [  666.018963] RBP: 00000000000001f4 R08: 0000000000000000 R09: 00007ffc82612537
> > [  666.025553] R10: 0000000000000004 R11: 0000000000000206 R12: 0000000000000021
> > [  666.030600] R13: 0000000000403e60 R14: 0000000000000000 R15: 0000000000000000
> > [  666.035780]
> > [  666.036906] Allocated by task 2837:
> > [  666.039447]  kasan_save_stack+0x19/0x40
> > [  666.042815]  __kasan_kmalloc.constprop.8+0xc1/0xd0
> > [  666.046626]  rpcrdma_req_create+0x58/0x1f0 [rpcrdma]
> > [  666.050283]  rpcrdma_buffer_create+0x217/0x270 [rpcrdma]
> > [  666.053727]  xprt_setup_rdma+0x1a3/0x2c0 [rpcrdma]
> > [  666.057287]  xprt_create_transport+0xc7/0x300 [sunrpc]
> > [  666.061656]  rpc_create+0x185/0x360 [sunrpc]
> > [  666.064803]  nfs_create_rpc_client+0x2d9/0x350 [nfs]
> > [  666.068233]  nfs4_init_client+0x111/0x3d0 [nfsv4]
> > [  666.071563]  nfs4_set_client+0x18c/0x2b0 [nfsv4]
> > [  666.075287]  nfs4_create_server+0x303/0x590 [nfsv4]
> > [  666.079563]  nfs4_try_get_tree+0x60/0xe0 [nfsv4]
> > [  666.082835]  vfs_get_tree+0x45/0x120
> > [  666.085165]  path_mount+0x8da/0xcc0
> > [  666.087352]  do_mount+0xcb/0xf0
> > [  666.089377]  __x64_sys_mount+0xf4/0x110
> > [  666.091894]  do_syscall_64+0x33/0x40
> > [  666.094215]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [  666.097181]
> > [  666.098548] The buggy address belongs to the object at ffff88803ded8000
> > [  666.098548]  which belongs to the cache kmalloc-8k of size 8192
> > [  666.108266] The buggy address is located 7024 bytes inside of
> > [  666.108266]  8192-byte region [ffff88803ded8000, ffff88803deda000)
> > [  666.115709] The buggy address belongs to the page:
> > [  666.118516] page:00000000e08a579f refcount:1 mapcount:0
> > mapping:0000000000000000 index:0x0 pfn:0x3ded8
> > [  666.124078] head:00000000e08a579f order:3 compound_mapcount:0
> > compound_pincount:0
> > [  666.130104] flags: 0xfffffc0010200(slab|head)
> > [  666.133692] raw: 000fffffc0010200 dead000000000100 dead000000000122
> > ffff88800104ee40
> > [  666.139286] raw: 0000000000000000 0000000000020002 00000001ffffffff
> > 0000000000000000
> > [  666.145052] page dumped because: kasan: bad access detected
> > [  666.149341]
> > [  666.150408] Memory state around the buggy address:
>
> --
> Chuck Lever
>
>
>
