Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC78C2B86FC
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Nov 2020 22:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgKRVoz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Nov 2020 16:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgKRVoz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Nov 2020 16:44:55 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0136AC0613D4
        for <linux-nfs@vger.kernel.org>; Wed, 18 Nov 2020 13:44:55 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id w13so4857073eju.13
        for <linux-nfs@vger.kernel.org>; Wed, 18 Nov 2020 13:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7IWkepJAE1IkXCk8QFeK0Z7jlhEARWgqxuc2gkYzn6s=;
        b=mXZWhIHNCHeZehiaiDNgRqhaOIHPfkb3v5KKUw8+s0AAzbgjghy11nTMDRVkbFjcbw
         0gIqg12HhWxwbGECk4ioLmtxjfL88YO+bx+DchjtGiVRyvhTyy3QBEgkZN4hU9XovFTr
         SndvHi0sCoZpXnqZ4O6mcnMqqxDAxz4iPu/2SD2FXq4IErKowKxfzg9DGn+Apng6zSAs
         qp0NortUtlV6V10nGlM78LJUBrwl6GYcVy1S8sXh4ncvwzK6brYC5Xq9wkfjS/7vnGTt
         oz1fCJl3URUjaDh4l71zOlrW+edzgf6Gb61zVlc7vCB6MV322UlmIdpC93JAXyW3a7WN
         b1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7IWkepJAE1IkXCk8QFeK0Z7jlhEARWgqxuc2gkYzn6s=;
        b=hpj6kSRJhyF+QUKAz56enIqo3QNyH7DFf/po0C8HwHgl3sOkarFKOOrZXf56sryYtL
         Ho6TLVDdqo8sbyf4yCtcc6f/HCVa48A8DxdvqBkRGbSvr/KKr0+R1UiqT+JsRZIvpdGp
         Ws7EK51ADugi4cfFsnDBL4hiVNW0TJ79Wqz8/Cvinnu4h7pK5XEXRgWapsJ0wz3GNuwG
         4vWZ483ow4gdkbBneQrd23iM0kGZIxNxS+Rb5CxB7rYCZs+JNw1v5zG0oH+uWEiFyjcP
         kHywCzQ9jCH2oGGxVUFBVa5IElruHRTehfQRAadCjSwb+Lm/9Iw7/vipOJBclh7p2wSf
         bAhw==
X-Gm-Message-State: AOAM533NtWOA+zbLAYO4FuTC3/CpxDVPyNlcaLFqYk/NGDpPO9KRzQy1
        CDyQ2ciSiwht27x9gcplRLd2yfebfKzGbzKhNz4=
X-Google-Smtp-Source: ABdhPJxrlUEWhREFkbKkjbcveqIyQijxSiqgjTJe6hf1W5oIp1GdhH2rfQ8aXKiJz8+Um9BhySessInfThEXdoGv2bY=
X-Received: by 2002:a17:906:14cd:: with SMTP id y13mr7631399ejc.510.1605735893506;
 Wed, 18 Nov 2020 13:44:53 -0800 (PST)
MIME-Version: 1.0
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com> <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com>
In-Reply-To: <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 18 Nov 2020 16:44:42 -0500
Message-ID: <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
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

Hi Chuck,

The first problem I found was from 5.10-rc3 testing was from the fact
that tail's iov_len was set to -4 and reply_chunk was trying to call
rpcrdma_convert_kvec() for a tail that didn't exist.

Do you see issues with this fix?

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 71e03b930b70..2e6a228abb95 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -193,7 +193,7 @@ xdr_inline_pages(struct xdr_buf *xdr, unsigned int offset,

        tail->iov_base = buf + offset;
        tail->iov_len = buflen - offset;
-       if ((xdr->page_len & 3) == 0)
+       if ((xdr->page_len & 3) == 0 && tail->iov_len)
                tail->iov_len -= sizeof(__be32);

        xdr->buflen += len;

This one fixes KASAN's reported problem of added at the end of this message.

The next problem that I can't figure out yet is another KASAN's report
during the completion of the request.

[   99.610666] BUG: KASAN: wild-memory-access in
rpcrdma_complete_rqst+0x41b/0x680 [rpcrdma]
[   99.617947] Write of size 4 at addr 0005088000000000 by task kworker/1:1H/490


This is the KASAN for the negative tail problem:
[  665.767611] ==================================================================
[  665.772202] BUG: KASAN: slab-out-of-bounds in
rpcrdma_convert_kvec.isra.29+0x4a/0xc4 [rpcrdma]
[  665.777860] Write of size 8 at addr ffff88803ded9b70 by task fsstress/3123
[  665.783754]
[  665.784981] CPU: 0 PID: 3123 Comm: fsstress Not tainted 5.10.0-rc3+ #38
[  665.790534] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[  665.798538] Call Trace:
[  665.800398]  dump_stack+0x7c/0xa2
[  665.802647]  ? rpcrdma_convert_kvec.isra.29+0x4a/0xc4 [rpcrdma]
[  665.808145]  print_address_description.constprop.7+0x1e/0x230
[  665.812543]  ? record_print_text.cold.38+0x11/0x11
[  665.816093]  ? _raw_write_lock_irqsave+0xe0/0xe0
[  665.819257]  ? rpcrdma_convert_kvec.isra.29+0x4a/0xc4 [rpcrdma]
[  665.823368]  ? rpcrdma_convert_kvec.isra.29+0x4a/0xc4 [rpcrdma]
[  665.827837]  kasan_report.cold.9+0x37/0x7c
[  665.830076]  ? rpcrdma_convert_kvec.isra.29+0x4a/0xc4 [rpcrdma]
[  665.834066]  rpcrdma_convert_kvec.isra.29+0x4a/0xc4 [rpcrdma]
[  665.837342]  rpcrdma_convert_iovs.isra.30.cold.41+0x9b/0xa0 [rpcrdma]
[  665.841766]  ? decode_read_list+0x40/0x40 [rpcrdma]
[  665.845063]  ? _raw_spin_lock_irqsave+0x80/0xe0
[  665.848444]  ? xdr_reserve_space+0x12e/0x360 [sunrpc]
[  665.852186]  ? xdr_init_encode+0x104/0x130 [sunrpc]
[  665.855305]  rpcrdma_marshal_req.cold.43+0x39/0x1fa [rpcrdma]
[  665.859771]  ? _raw_spin_lock+0x7a/0xd0
[  665.862516]  ? rpcrdma_prepare_send_sges+0x7e0/0x7e0 [rpcrdma]
[  665.866533]  ? call_bind+0x60/0xf0 [sunrpc]
[  665.869382]  xprt_rdma_send_request+0x79/0x190 [rpcrdma]
[  665.872965]  xprt_transmit+0x2ae/0x6c0 [sunrpc]
[  665.875955]  ? call_bind+0xf0/0xf0 [sunrpc]
[  665.878372]  call_transmit+0xdd/0x110 [sunrpc]
[  665.881539]  ? call_bind+0xf0/0xf0 [sunrpc]
[  665.884629]  __rpc_execute+0x11c/0x6e0 [sunrpc]
[  665.888300]  ? trace_event_raw_event_xprt_cong_event+0x270/0x270 [sunrpc]
[  665.893935]  ? rpc_make_runnable+0x54/0xe0 [sunrpc]
[  665.898021]  rpc_run_task+0x29c/0x2c0 [sunrpc]
[  665.901142]  nfs4_call_sync_custom+0xc/0x40 [nfsv4]
[  665.904903]  nfs4_do_call_sync+0x114/0x160 [nfsv4]
[  665.908633]  ? nfs4_call_sync_custom+0x40/0x40 [nfsv4]
[  665.913094]  ? __alloc_pages_nodemask+0x200/0x410
[  665.916831]  ? kasan_unpoison_shadow+0x30/0x40
[  665.920393]  ? __kasan_kmalloc.constprop.8+0xc1/0xd0
[  665.924403]  _nfs42_proc_listxattrs+0x1f6/0x2f0 [nfsv4]
[  665.928552]  ? kasan_set_free_info+0x1b/0x30
[  665.932283]  ? nfs42_offload_cancel_done+0x50/0x50 [nfsv4]
[  665.936240]  ? _raw_spin_lock+0x7a/0xd0
[  665.938677]  nfs42_proc_listxattrs+0xf4/0x150 [nfsv4]
[  665.942532]  ? nfs42_proc_setxattr+0x150/0x150 [nfsv4]
[  665.946410]  ? nfs4_xattr_cache_list+0x21/0x120 [nfsv4]
[  665.950095]  nfs4_listxattr+0x34d/0x3d0 [nfsv4]
[  665.952951]  ? _nfs4_proc_access+0x260/0x260 [nfsv4]
[  665.956383]  ? __ia32_sys_rename+0x40/0x40
[  665.959559]  ? __ia32_sys_lstat+0x30/0x30
[  665.962519]  ? __check_object_size+0x178/0x220
[  665.965830]  ? strncpy_from_user+0xe9/0x230
[  665.968401]  ? security_inode_listxattr+0x20/0x60
[  665.971653]  listxattr+0xd1/0xf0
[  665.974065]  path_listxattr+0xa1/0x100
[  665.977023]  ? listxattr+0xf0/0xf0
[  665.979305]  do_syscall_64+0x33/0x40
[  665.981561]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  665.985559] RIP: 0033:0x7fe3f5a1fc8b
[  665.988136] Code: f0 ff ff 73 01 c3 48 8b 0d fa 21 2c 00 f7 d8 64
89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 c2 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cd 21 2c 00 f7 d8 64 89
01 48
[  666.002248] RSP: 002b:00007ffc826128e8 EFLAGS: 00000206 ORIG_RAX:
00000000000000c2
[  666.007760] RAX: ffffffffffffffda RBX: 0000000000000021 RCX: 00007fe3f5a1fc8b
[  666.012999] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000016eaf70
[  666.018963] RBP: 00000000000001f4 R08: 0000000000000000 R09: 00007ffc82612537
[  666.025553] R10: 0000000000000004 R11: 0000000000000206 R12: 0000000000000021
[  666.030600] R13: 0000000000403e60 R14: 0000000000000000 R15: 0000000000000000
[  666.035780]
[  666.036906] Allocated by task 2837:
[  666.039447]  kasan_save_stack+0x19/0x40
[  666.042815]  __kasan_kmalloc.constprop.8+0xc1/0xd0
[  666.046626]  rpcrdma_req_create+0x58/0x1f0 [rpcrdma]
[  666.050283]  rpcrdma_buffer_create+0x217/0x270 [rpcrdma]
[  666.053727]  xprt_setup_rdma+0x1a3/0x2c0 [rpcrdma]
[  666.057287]  xprt_create_transport+0xc7/0x300 [sunrpc]
[  666.061656]  rpc_create+0x185/0x360 [sunrpc]
[  666.064803]  nfs_create_rpc_client+0x2d9/0x350 [nfs]
[  666.068233]  nfs4_init_client+0x111/0x3d0 [nfsv4]
[  666.071563]  nfs4_set_client+0x18c/0x2b0 [nfsv4]
[  666.075287]  nfs4_create_server+0x303/0x590 [nfsv4]
[  666.079563]  nfs4_try_get_tree+0x60/0xe0 [nfsv4]
[  666.082835]  vfs_get_tree+0x45/0x120
[  666.085165]  path_mount+0x8da/0xcc0
[  666.087352]  do_mount+0xcb/0xf0
[  666.089377]  __x64_sys_mount+0xf4/0x110
[  666.091894]  do_syscall_64+0x33/0x40
[  666.094215]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  666.097181]
[  666.098548] The buggy address belongs to the object at ffff88803ded8000
[  666.098548]  which belongs to the cache kmalloc-8k of size 8192
[  666.108266] The buggy address is located 7024 bytes inside of
[  666.108266]  8192-byte region [ffff88803ded8000, ffff88803deda000)
[  666.115709] The buggy address belongs to the page:
[  666.118516] page:00000000e08a579f refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x3ded8
[  666.124078] head:00000000e08a579f order:3 compound_mapcount:0
compound_pincount:0
[  666.130104] flags: 0xfffffc0010200(slab|head)
[  666.133692] raw: 000fffffc0010200 dead000000000100 dead000000000122
ffff88800104ee40
[  666.139286] raw: 0000000000000000 0000000000020002 00000001ffffffff
0000000000000000
[  666.145052] page dumped because: kasan: bad access detected
[  666.149341]
[  666.150408] Memory state around the buggy address:

On Fri, Nov 13, 2020 at 3:34 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi Olga-
>
> > On Nov 13, 2020, at 2:08 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > xfstest generic/013 over on a NFSoRDMA over SoftRoCE or iWarp panics
> > and running with KASAN reports:
>
> There is still only a highly circumstantial connection between
> soft RoCE and iWarp and these crashes, so this description seems
> misleading and/or pre-mature.
>
>
> > [  216.018711] BUG: KASAN: wild-memory-access in rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
> > [  216.024195] Write of size 12 at addr 0005088000000000 by task kworker/1:1H/480
> > [  216.028820]
> > [  216.029776] CPU: 1 PID: 480 Comm: kworker/1:1H Not tainted 5.8.0-rc5+ #37
> > [  216.034247] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
> > [  216.040604] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> > [  216.043739] Call Trace:
> > [  216.045014]  dump_stack+0x7c/0xb0
> > [  216.046757]  ? rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
> > [  216.050008]  ? rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
> > [  216.053091]  kasan_report.cold.10+0x6a/0x85
> > [  216.055703]  ? rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
> > [  216.058979]  check_memory_region+0x183/0x1e0
> > [  216.061933]  memcpy+0x38/0x60
> > [  216.064077]  rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
> > [  216.067502]  ? rpcrdma_reset_cwnd+0x70/0x70 [rpcrdma]
> > [  216.070268]  ? recalibrate_cpu_khz+0x10/0x10
> > [  216.072585]  ? rpcrdma_reply_handler+0x604/0x6e0 [rpcrdma]
> > [  216.075469]  __ib_process_cq+0xa7/0x220 [ib_core]
> > [  216.078077]  ib_cq_poll_work+0x31/0xb0 [ib_core]
> > [  216.080451]  process_one_work+0x387/0x6c0
> > [  216.082498]  worker_thread+0x57/0x5a0
> > [  216.084425]  ? process_one_work+0x6c0/0x6c0
> > [  216.086583]  kthread+0x1ca/0x200
> > [  216.088775]  ? kthread_create_on_node+0xc0/0xc0
> > [  216.091847]  ret_from_fork+0x22/0x30
> >
> > Fixes: 6c2190b3fcbc ("NFS: Fix listxattr receive buffer size")
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> > fs/nfs/nfs42xdr.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > index 6e060a8..e88bc7a 100644
> > --- a/fs/nfs/nfs42xdr.c
> > +++ b/fs/nfs/nfs42xdr.c
> > @@ -196,7 +196,8 @@
> >                                1 + nfs4_xattr_name_maxsz + 1)
> > #define decode_setxattr_maxsz   (op_decode_hdr_maxsz + decode_change_info_maxsz)
> > #define encode_listxattrs_maxsz  (op_encode_hdr_maxsz + 2 + 1)
> > -#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1 + 1)
> > +#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1 + \
> > +                               XDR_QUADLEN(NFS4_OPAQUE_LIMIT))
>
> From RFC 8276, Section 8.4.3.2:
>
>    /// struct LISTXATTRS4resok {
>    ///         nfs_cookie4    lxr_cookie;
>    ///         xattrkey4      lxr_names<>;
>    ///         bool           lxr_eof;
>    /// };
>
> The decode_listxattrs_maxsz macro defines the maximum size of
> the /fixed portion/ of the LISTXATTRS reply. That is the operation
> status code, the cookie, and the EOF flag. maxsz has an extra
> "+ 1" for rpc_prepare_reply_pages() to deal with possible XDR
> padding. The post-6c2190b3fcbc value of this macro is already
> correct, and removing the "+ 1" is wrong.
>
> In addition, the variable portion of the result is an unbounded
> array of component4 fields, nothing to do with NFS4_OPAQUE_LIMIT,
> so that's just an arbitrary constant here with no justification.
>
> Adding more space to the receive buffer happens to help the case
> where there are no xattrs to list. That doesn't mean its the
> correct solution in general. It certainly won't be sufficient to
> handle an xattr name array that is larger than 1024 bytes.
>
>
> The client manages the variable portion of that result in the
> reply's pages array, which is set up by nfs4_xdr_enc_listxattrs().
>
> Further:
>
> > rpcrdma_complete_rqst+0x447
>
> is in the paragraph of rpcrdma_inline_fixup() that copies received
> bytes into the receive xdr_buf's pages array.
>
> The address "0005088000000000" is bogus. Since
> nfs4_xdr_enc_listxattrs() sets XDRBUF_SPARSE_PAGES, it's likely
> it is relying on the transport to allocate pages for this buffer,
> and possibly that page allocation has failed or has a bug.
>
> Please determine why the encode side has not set up the correct
> number of pages to handle the LISTXATTRS result. Until then I
> have to NACK this one.
>
>
> > #define encode_removexattr_maxsz (op_encode_hdr_maxsz + 1 + \
> >                                 nfs4_xattr_name_maxsz)
> > #define decode_removexattr_maxsz (op_decode_hdr_maxsz + \
> > --
> > 1.8.3.1
>
> --
> Chuck Lever
>
>
>
