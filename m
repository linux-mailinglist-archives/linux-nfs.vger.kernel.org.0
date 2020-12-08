Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821CF2D3390
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Dec 2020 21:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgLHUVv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Dec 2020 15:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgLHUVs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Dec 2020 15:21:48 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ECDC061794
        for <linux-nfs@vger.kernel.org>; Tue,  8 Dec 2020 12:21:08 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id x16so26460378ejj.7
        for <linux-nfs@vger.kernel.org>; Tue, 08 Dec 2020 12:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tOg6jDmYv3LEafME4AzFkN9bMBvuDOxPv8/okPxcbwo=;
        b=oL3H8rBFPYFtDHX01k2TqWrKlLofuYVByVUtuyBot9QrFT3tYFbtT/RfPWYMeJC8LJ
         5JIXvJSFd7YT7tE/vCn+ff2+JBvTE/UIceE8GqGLMU4+rY7keoqEMnNdVTgNJKqeKBGD
         bCHgevvYtsHqFPrkx7l45IQ2CS7At3oLsquxVsq+0DPKS6vqg+4jpa/KC9ntyHCXq8DL
         X3TtOTA9QGSKCNLh9k31QlYDOLpb5CczfyQHih6Q5Ukl6fUNywbCFNodnyuXa7qzEb6/
         VIqUit7XrVgPRkJulSqPg5sOd5MKxV/5hEd8qFVerAoBdTmYIJzmgN+G1mVo+JtRo3zW
         Pu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOg6jDmYv3LEafME4AzFkN9bMBvuDOxPv8/okPxcbwo=;
        b=qJEf/ytbH4NyZZW3J+3r3TjJucP9QeUuNJBKg5MjPmaB2+qfCaGouRZv2N246goVyU
         LJsV740tI1g8GUZwlzlyHQ3AisU46HaEpuinnlhiVnL/Cr1xycr+3j1h+SsRZihImIJn
         Bxz7HvNwoXWXkUegVGoiOI+Mcd7ifz/8bSfRImNKEHcQPRK0CsX09I2yT0zOQxagTGQD
         96P4/20VneBvibrLWthX+3Yb4LEfVhCoHm2D7+3RKph4FP2f/9ysd1/vlkaCd/nLExxx
         aNXYiZOPqZW3AWgnIb8BBxAJ4HEWwxSH+tXznrZvjdkMHHSe8sj/a6Yulf9H+K+eHyXn
         lOBg==
X-Gm-Message-State: AOAM531GItpDOM1pwolkC/3OewTGjbZZVWPBt7b+YI8igyk6NF4gglVL
        WoIazxVmhDcW2U7cO+HIn1sC680WB662IJ8dp+JAVjCOyGk=
X-Google-Smtp-Source: ABdhPJxaKmIIBCOfHr+Hse0d8mth7eCxdXtdyXA/aEWtmHxGCzwXzfQeKTD20KqSInDsNam1ZcQNiZbb1sAMBgkL0Lk=
X-Received: by 2002:a17:906:ccc5:: with SMTP id ot5mr24477549ejb.248.1607458866827;
 Tue, 08 Dec 2020 12:21:06 -0800 (PST)
MIME-Version: 1.0
References: <160719971621.32538.11224487886769737849.stgit@manet.1015granger.net>
 <CAN-5tyFAmWL_Y73pgnaBEP3y_QeFAogRqXjtzPhsOpTvZt_o8w@mail.gmail.com> <841D209E-2FE1-47A9-BFBB-C7EDA6D73CD1@oracle.com>
In-Reply-To: <841D209E-2FE1-47A9-BFBB-C7EDA6D73CD1@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 8 Dec 2020 15:20:55 -0500
Message-ID: <CAN-5tyH4Z9S-H4ugMbRZ4SGsgjC+4kzCgNchtz7Ei6zjD8HdyA@mail.gmail.com>
Subject: Re: [PATCH 4] xprtrdma: Fix XDRBUF_SPARSE_PAGES support
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 8, 2020 at 2:59 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Dec 8, 2020, at 2:49 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Sat, Dec 5, 2020 at 3:24 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >> Olga K. observed that rpcrdma_marsh_req() allocates sparse pages
> >> only when it has determined that a Reply chunk is necessary. There
> >> are plenty of cases where no Reply chunk is needed, but the
> >> XDRBUF_SPARSE_PAGES flag is set. The result would be a crash in
> >> rpcrdma_inline_fixup() when it tries to copy parts of the received
> >> Reply into a missing page.
> >>
> >> To avoid crashing, handle sparse page allocation up front.
> >>
> >> Until XATTR support was added, this issue did not appear often
> >> because the only SPARSE_PAGES consumer always expected a reply large
> >> enough to always require a Reply chunk.
> >
> > Ok so given that ACL never utilizes this, the only way to test this is
> > to remove the xattr fixes and try this and run the xfstest generic/013
> > would that be correct?
>
> I'm simply hoisting the SPARSE_PAGES logic out of convert_iovs and into
> marshal_req, to ensure that it is visited no matter what chunk type is
> being encoded. NFSv3 GETACL would use this new code path instead of the
> old one, so it would still get exercised.
>
>
> > If so, then just applying this patch on top of pure say -rc4 produces problems.
>
> I don't follow you. What problems would occur? On -rc4, the LISTXATTRS
> crash you found should go away after this patch is applied.

This is my git (on top of Trond's origin/testing though might not be
totally current, but still -rc4):
commit 0abdda88e25673a8daed06481ba2e91152a311d6 (HEAD -> 12082020-deleteme)
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Sat Dec 5 15:22:57 2020 -0500

    xprtrdma: Fix XDRBUF_SPARSE_PAGES support

    Olga K. observed that rpcrdma_marsh_req() allocates sparse pages
    only when it has determined that a Reply chunk is necessary. There
    are plenty of cases where no Reply chunk is needed, but the
    XDRBUF_SPARSE_PAGES flag is set. The result would be a crash in
    rpcrdma_inline_fixup() when it tries to copy parts of the received
    Reply into a missing page.

    To avoid crashing, handle sparse page allocation up front.

    Until XATTR support was added, this issue did not appear often
    because the only SPARSE_PAGES consumer always expected a reply large
    enough to always require a Reply chunk.

    Reported-by: Olga Kornievskaia <kolga@netapp.com>
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Cc: <stable@vger.kernel.org>

commit 66ff5a8a60a4eaa26d19a8fd8aff30ce319b14fb
Author: Trond Myklebust <trond.myklebust@hammerspace.com>
Date:   Sun Nov 15 17:04:35 2020 -0500

Then I run generic/013 and it crashes with:
[  107.792204] run fstests generic/013 at 2020-12-08 15:12:07
[  108.330372] ==================================================================
[  108.333913] BUG: KASAN: slab-out-of-bounds in
rpcrdma_alloc_sparse_pages+0x5d/0xa0 [rpcrdma]
[  108.337696] Read of size 8 at addr ffff88801a16a098 by task fsstress/2999
[  108.341357]
[  108.342138] CPU: 0 PID: 2999 Comm: fsstress Not tainted 5.10.0-rc4+ #54
[  108.345725] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[  108.351232] Call Trace:
[  108.352322]  dump_stack+0x7c/0xa2
[  108.353935]  ? rpcrdma_alloc_sparse_pages+0x5d/0xa0 [rpcrdma]
[  108.356870]  print_address_description.constprop.7+0x1e/0x230
[  108.359354]  ? record_print_text.cold.38+0x11/0x11
[  108.361437]  ? _raw_write_lock_irqsave+0xe0/0xe0
[  108.363665]  ? rpcrdma_alloc_sparse_pages+0x5d/0xa0 [rpcrdma]
[  108.367476]  ? rpcrdma_alloc_sparse_pages+0x5d/0xa0 [rpcrdma]
[  108.370174]  kasan_report.cold.9+0x37/0x7c
[  108.372428]  ? _raw_spin_lock_irqsave+0x80/0xe0
[  108.374489]  ? rpcrdma_alloc_sparse_pages+0x5d/0xa0 [rpcrdma]
[  108.376978]  rpcrdma_alloc_sparse_pages+0x5d/0xa0 [rpcrdma]
[  108.379404]  rpcrdma_marshal_req+0xbdb/0x1450 [rpcrdma]
[  108.381941]  ? _raw_spin_lock+0x7a/0xd0
[  108.383628]  ? _raw_spin_lock+0x7a/0xd0
[  108.385305]  ? _raw_write_lock_bh+0xe0/0xe0
[  108.387184]  ? rpcrdma_prepare_send_sges+0x7e0/0x7e0 [rpcrdma]
[  108.390980]  ? call_bind+0x60/0xf0 [sunrpc]
[  108.392840]  xprt_rdma_send_request+0x79/0x190 [rpcrdma]
[  108.395195]  xprt_transmit+0x2ae/0x6c0 [sunrpc]
[  108.397639]  ? call_bind+0xf0/0xf0 [sunrpc]
[  108.399581]  call_transmit+0xdd/0x110 [sunrpc]
[  108.401583]  ? call_bind+0xf0/0xf0 [sunrpc]
[  108.403518]  __rpc_execute+0x11c/0x6e0 [sunrpc]
[  108.406016]  ? trace_event_raw_event_xprt_cong_event+0x270/0x270 [sunrpc]
[  108.409178]  ? rpc_make_runnable+0x54/0xe0 [sunrpc]
[  108.411599]  rpc_run_task+0x29c/0x2c0 [sunrpc]
[  108.414020]  nfs4_call_sync_custom+0xc/0x40 [nfsv4]
[  108.417269]  nfs4_do_call_sync+0x114/0x160 [nfsv4]
[  108.419665]  ? nfs4_call_sync_custom+0x40/0x40 [nfsv4]
[  108.423873]  ? __alloc_pages_nodemask+0x200/0x410
[  108.426445]  ? kasan_unpoison_shadow+0x30/0x40
[  108.428737]  ? __kasan_kmalloc.constprop.8+0xc1/0xd0
[  108.431076]  _nfs42_proc_listxattrs+0x1f6/0x2f0 [nfsv4]
[  108.433381]  ? kasan_set_free_info+0x1b/0x30
[  108.435278]  ? nfs42_offload_cancel_done+0x50/0x50 [nfsv4]
[  108.438490]  ? page_put_link+0x90/0x90
[  108.440328]  ? lockref_get+0x120/0x120
[  108.442344]  ? _raw_spin_lock+0x7a/0xd0
[  108.444199]  nfs42_proc_listxattrs+0xf4/0x150 [nfsv4]
[  108.447745]  ? nfs42_proc_setxattr+0x150/0x150 [nfsv4]
[  108.450851]  ? nfs4_xattr_cache_list+0x21/0x120 [nfsv4]
[  108.454063]  nfs4_listxattr+0x34d/0x3d0 [nfsv4]
[  108.456597]  ? _nfs4_proc_access+0x260/0x260 [nfsv4]
[  108.458953]  ? __ia32_sys_rename+0x40/0x40
[  108.460722]  ? __ia32_sys_lstat+0x30/0x30
[  108.462696]  ? __check_object_size+0x178/0x220
[  108.464679]  ? strncpy_from_user+0xe9/0x230
[  108.466576]  ? security_inode_listxattr+0x20/0x60
[  108.468639]  listxattr+0xd1/0xf0
[  108.470303]  path_listxattr+0xa1/0x100
[  108.471946]  ? listxattr+0xf0/0xf0
[  108.473498]  do_syscall_64+0x33/0x40
[  108.475079]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  108.477447] RIP: 0033:0x7f1c8b904c8b
[  108.479147] Code: f0 ff ff 73 01 c3 48 8b 0d fa 21 2c 00 f7 d8 64
89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 c2 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cd 21 2c 00 f7 d8 64 89
01 48
[  108.488040] RSP: 002b:00007fffef42b718 EFLAGS: 00000206 ORIG_RAX:
00000000000000c2
[  108.491606] RAX: ffffffffffffffda RBX: 000000000000001e RCX: 00007f1c8b904c8b
[  108.495231] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000d8b440
[  108.498424] RBP: 00000000000001f4 R08: 00007f1c8bbc7ba0 R09: 00007fffef42b367
[  108.501888] R10: 0000000000000004 R11: 0000000000000206 R12: 000000000000001e
[  108.505872] R13: 0000000000403e30 R14: 0000000000000000 R15: 0000000000000000
[  108.508933]
[  108.509616] Allocated by task 2999:
[  108.511161]  kasan_save_stack+0x19/0x40
[  108.513068]  __kasan_kmalloc.constprop.8+0xc1/0xd0
[  108.515313]  _nfs42_proc_listxattrs+0x1b2/0x2f0 [nfsv4]
[  108.518041]  nfs42_proc_listxattrs+0xf4/0x150 [nfsv4]
[  108.520832]  nfs4_listxattr+0x34d/0x3d0 [nfsv4]
[  108.522954]  listxattr+0xd1/0xf0
[  108.524684]  path_listxattr+0xa1/0x100
[  108.526699]  do_syscall_64+0x33/0x40
[  108.528435]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  108.530892]
[  108.531671] The buggy address belongs to the object at ffff88801a16a000
[  108.531671]  which belongs to the cache kmalloc-192 of size 192
[  108.537195] The buggy address is located 152 bytes inside of
[  108.537195]  192-byte region [ffff88801a16a000, ffff88801a16a0c0)
[  108.542548] The buggy address belongs to the page:
[  108.544756] page:000000006639f664 refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x1a168
[  108.548725] head:000000006639f664 order:2 compound_mapcount:0
compound_pincount:0
[  108.551925] flags: 0xfffffc0010200(slab|head)
[  108.553980] raw: 000fffffc0010200 ffffea0000111700 0000000800000008
ffff88800104f5c0
[  108.557364] raw: 0000000000000000 0000000080400040 00000001ffffffff
ffff88804ba9b001
[  108.560996] page dumped because: kasan: bad access detected
[  108.564008] page->mem_cgroup:ffff88804ba9b001
[  108.566736]
[  108.567607] Memory state around the buggy address:
[  108.569839]  ffff88801a169f80: fb fb fb fb fb fb fb fb fc fc fc fc
fc fc fc fc
[  108.573164]  ffff88801a16a000: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[  108.576348] >ffff88801a16a080: 00 00 00 fc fc fc fc fc fc fc fc fc
fc fc fc fc
[  108.579457]                             ^
[  108.581212]  ffff88801a16a100: fa fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  108.584368]  ffff88801a16a180: fb fb fb fb fb fb fb fb fc fc fc fc
fc fc fc fc
[  108.588425] ==================================================================



>
>
> > This patch on top of all the fixes (getxattr + listxattr patches),
> > seems ok but I'm not sure if it gets exercised.
> >>
> >> Reported-by: Olga Kornievskaia <kolga@netapp.com>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> Cc: <stable@vger.kernel.org>
> >> ---
> >> net/sunrpc/xdr.c               |    1 +
> >> net/sunrpc/xprtrdma/rpc_rdma.c |   41 +++++++++++++++++++++++++++++++---------
> >> 2 files changed, 33 insertions(+), 9 deletions(-)
> >>
> >> Changes since v3:
> >> - I swear I am not drunk. I forgot to commit the change before mailing it.
> >>
> >> Changes since v2:
> >> - Actually fix the xdr_buf_pagecount() problem
> >>
> >> Changes since RFC:
> >> - Ensure xdr_buf_pagecount() is defined in rpc_rdma.c
> >> - noinline the sparse page allocator -- it's an uncommon path
> >>
> >> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> >> index 71e03b930b70..878f4c4fec1a 100644
> >> --- a/net/sunrpc/xdr.c
> >> +++ b/net/sunrpc/xdr.c
> >> @@ -141,6 +141,7 @@ xdr_buf_pagecount(struct xdr_buf *buf)
> >>                return 0;
> >>        return (buf->page_base + buf->page_len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> >> }
> >> +EXPORT_SYMBOL_GPL(xdr_buf_pagecount);
> >>
> >> int
> >> xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp)
> >> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
> >> index 0f5120c7668f..6c9a1810a70a 100644
> >> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> >> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> >> @@ -179,6 +179,32 @@ rpcrdma_nonpayload_inline(const struct rpcrdma_xprt *r_xprt,
> >>                r_xprt->rx_ep->re_max_inline_recv;
> >> }
> >>
> >> +/* ACL likes to be lazy in allocating pages. For TCP, these
> >> + * pages can be allocated during receive processing. Not true
> >> + * for RDMA, which must always provision receive buffers
> >> + * up front.
> >> + */
> >> +static noinline int
> >> +rpcrdma_alloc_sparse_pages(struct rpc_rqst *rqst)
> >> +{
> >> +       struct xdr_buf *xb = &rqst->rq_rcv_buf;
> >> +       struct page **ppages;
> >> +       int len;
> >> +
> >> +       len = xb->page_len;
> >> +       ppages = xb->pages + xdr_buf_pagecount(xb);
> >> +       while (len > 0) {
> >> +               if (!*ppages)
> >> +                       *ppages = alloc_page(GFP_NOWAIT | __GFP_NOWARN);
> >> +               if (!*ppages)
> >> +                       return -ENOBUFS;
> >> +               ppages++;
> >> +               len -= PAGE_SIZE;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> /* Split @vec on page boundaries into SGEs. FMR registers pages, not
> >>  * a byte range. Other modes coalesce these SGEs into a single MR
> >>  * when they can.
> >> @@ -233,15 +259,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
> >>        ppages = xdrbuf->pages + (xdrbuf->page_base >> PAGE_SHIFT);
> >>        page_base = offset_in_page(xdrbuf->page_base);
> >>        while (len) {
> >> -               /* ACL likes to be lazy in allocating pages - ACLs
> >> -                * are small by default but can get huge.
> >> -                */
> >> -               if (unlikely(xdrbuf->flags & XDRBUF_SPARSE_PAGES)) {
> >> -                       if (!*ppages)
> >> -                               *ppages = alloc_page(GFP_NOWAIT | __GFP_NOWARN);
> >> -                       if (!*ppages)
> >> -                               return -ENOBUFS;
> >> -               }
> >>                seg->mr_page = *ppages;
> >>                seg->mr_offset = (char *)page_base;
> >>                seg->mr_len = min_t(u32, PAGE_SIZE - page_base, len);
> >> @@ -867,6 +884,12 @@ rpcrdma_marshal_req(struct rpcrdma_xprt *r_xprt, struct rpc_rqst *rqst)
> >>        __be32 *p;
> >>        int ret;
> >>
> >> +       if (unlikely(rqst->rq_rcv_buf.flags & XDRBUF_SPARSE_PAGES)) {
> >> +               ret = rpcrdma_alloc_sparse_pages(rqst);
> >> +               if (ret)
> >> +                       return ret;
> >> +       }
> >> +
> >>        rpcrdma_set_xdrlen(&req->rl_hdrbuf, 0);
> >>        xdr_init_encode(xdr, &req->rl_hdrbuf, rdmab_data(req->rl_rdmabuf),
> >>                        rqst);
>
> --
> Chuck Lever
>
>
>
