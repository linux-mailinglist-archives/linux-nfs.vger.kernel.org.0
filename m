Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E95C2C339A
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 22:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbgKXV5V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 16:57:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731696AbgKXV5U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 16:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606255038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=h1j6H6PPap+hb6uybzk9YP9knA/OxRftS+4ES69N5Hw=;
        b=QMst0lzTIpP9ci5y6fnAmE1yBPcuMKuK2atPYDsZ6ax1WuzHca+3F2Rkm+TMupQWg1IUY5
        HMvXEThDuLfFXHkUvFYJBjpjrs69fSjvF3A8e6zJKrCqGIbkOauUoQIX8kCJSfSHC324Uw
        eU2Xj6+ooECtWbTaURQBCuhZTdFLr/w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-Pf7S3_epNhGI6J_PNazXWw-1; Tue, 24 Nov 2020 16:57:15 -0500
X-MC-Unique: Pf7S3_epNhGI6J_PNazXWw-1
Received: by mail-ed1-f69.google.com with SMTP id b68so186335edf.9
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 13:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h1j6H6PPap+hb6uybzk9YP9knA/OxRftS+4ES69N5Hw=;
        b=kusK4fPZjJU4qdpmdq2Rt8t5ps6/yCdvRzCkYHlns/aw/T6EsJeIg20p1lx+ouMkho
         ++dwjSWDi0Yyahzdc8tvG10M8xjk2zM+s1cJ40cmQeDqzdNCabfZ2IuEmK1eVituPpD5
         5g2rO4qBZTa75xPb4eog+1akFDsCm37mcCy43P+ER8hbLKdg2JPohqtqN3Gkm7ei8E9/
         NcNkOxtf0bjhGBpw3n3qPCywfQXpOwF7cVVJ9+9+vF/m10u57I8brQ7WGfHUU4iaBYUU
         lgVWVLA3URlfC9DeRBgB4w1r40HBIS5rqosO2tmW1SJr0ktEGoqt8tJz8uvt9PhKJNMC
         2omA==
X-Gm-Message-State: AOAM5332dl2SPJ0CLavuco4s+v9R4DzBrXBYeiTD+TC7O62dXzUI+wC3
        aaovKQ5oUhbUeED0KMdE4Myii6dn0AHRuGg/K0eSST+bj4FYHeVw4H6GXF3Z6r9imQmqnh1TaHk
        W0b6i6usN+dec7JI83dfo+FGINmG/B7gNLwws
X-Received: by 2002:a05:6402:54d:: with SMTP id i13mr604033edx.3.1606255033807;
        Tue, 24 Nov 2020 13:57:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+mJWZaf4ImqbgM16NPYMyOhH5xXhpDg6CwWuqCeWpBQ8KflxxTI4FlCVfs+jYkJ1N7J2ryZnPzf53aQWGGaw=
X-Received: by 2002:a05:6402:54d:: with SMTP id i13mr604024edx.3.1606255033596;
 Tue, 24 Nov 2020 13:57:13 -0800 (PST)
MIME-Version: 1.0
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 24 Nov 2020 16:56:37 -0500
Message-ID: <CALF+zOntimx8nyiAUyN5Y58T9_-PztLpUU2vpYgOzQkcK7C09w@mail.gmail.com>
Subject: NFS failure with generic/074 when lockdep is enabled - BUG: Invalid
 wait context
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've started seeing this failure since testing 5.10-rc4 - this does
not happen on 5.9


f31-node1 login: [  124.055768] FS-Cache: Netfs 'nfs' registered for caching
[  125.046104] Key type dns_resolver registered
[  125.770354] NFS: Registering the id_resolver key type
[  125.780599] Key type id_resolver registered
[  125.782440] Key type id_legacy registered
[  126.563717] run fstests generic/074 at 2020-11-24 11:23:49
[  178.736479]
[  178.751380] =============================
[  178.753249] [ BUG: Invalid wait context ]
[  178.754886] 5.10.0-rc4 #127 Not tainted
[  178.756423] -----------------------------
[  178.758055] kworker/1:2/848 is trying to lock:
[  178.759866] ffff8947fffd33d8 (&zone->lock){..-.}-{3:3}, at:
get_page_from_freelist+0x897/0x2190
[  178.763333] other info that might help us debug this:
[  178.765354] context-{5:5}
[  178.766437] 3 locks held by kworker/1:2/848:
[  178.768158]  #0: ffff8946ce825538
((wq_completion)nfsiod){+.+.}-{0:0}, at: process_one_work+0x1be/0x540
[  178.771871]  #1: ffff9e6b408f7e58
((work_completion)(&task->u.tk_work)#2){+.+.}-{0:0}, at:
process_one_work+0x1be/0x540
[  178.776562]  #2: ffff8947f7c5b2b0 (krc.lock){..-.}-{2:2}, at:
kvfree_call_rcu+0x69/0x230
[  178.779803] stack backtrace:
[  178.780996] CPU: 1 PID: 848 Comm: kworker/1:2 Kdump: loaded Not
tainted 5.10.0-rc4 #127
[  178.784374] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[  178.787071] Workqueue: nfsiod rpc_async_release [sunrpc]
[  178.789308] Call Trace:
[  178.790386]  dump_stack+0x8d/0xb5
[  178.791816]  __lock_acquire.cold+0x20b/0x2c8
[  178.793605]  lock_acquire+0xca/0x380
[  178.795113]  ? get_page_from_freelist+0x897/0x2190
[  178.797116]  _raw_spin_lock+0x2c/0x40
[  178.798638]  ? get_page_from_freelist+0x897/0x2190
[  178.800620]  get_page_from_freelist+0x897/0x2190
[  178.802537]  __alloc_pages_nodemask+0x1b4/0x460
[  178.804416]  __get_free_pages+0xd/0x30
[  178.805987]  kvfree_call_rcu+0x168/0x230
[  178.807687]  nfs_free_request+0xab/0x180 [nfs]
[  178.809547]  nfs_page_group_destroy+0x41/0x80 [nfs]
[  178.811588]  nfs_read_completion+0x129/0x1f0 [nfs]
[  178.813633]  rpc_free_task+0x39/0x60 [sunrpc]
[  178.815481]  rpc_async_release+0x29/0x40 [sunrpc]
[  178.817451]  process_one_work+0x23e/0x540
[  178.819136]  worker_thread+0x50/0x3a0
[  178.820657]  ? process_one_work+0x540/0x540
[  178.822427]  kthread+0x10f/0x150
[  178.823805]  ? kthread_park+0x90/0x90
[  178.825339]  ret_from_fork+0x22/0x30


# eu-addr2line -e ./fs/nfs/nfs.ko nfs_free_request+0xab
fs/nfs/pagelist.c:559:24

    541 static void nfs_clear_request(struct nfs_page *req)
    542 {
    543         struct page *page = req->wb_page;
    544         struct nfs_lock_context *l_ctx = req->wb_lock_context;
    545         struct nfs_open_context *ctx;
    546
    547         if (page != NULL) {
    548                 put_page(page);
    549                 req->wb_page = NULL;
    550         }
    551         if (l_ctx != NULL) {
    552                 if (atomic_dec_and_test(&l_ctx->io_count)) {
    553                         wake_up_var(&l_ctx->io_count);
    554                         ctx = l_ctx->open_context;
    555                         if (test_bit(NFS_CONTEXT_UNLOCK, &ctx->flags))
    556
rpc_wake_up(&NFS_SERVER(d_inode(ctx->dentry))->uoc_rpcwaitq);
    557                 }
    558                 nfs_put_lock_context(l_ctx);
    559                 req->wb_lock_context = NULL;
    560         }
    561 }

    924 void nfs_put_lock_context(struct nfs_lock_context *l_ctx)
    925 {
    926         struct nfs_open_context *ctx = l_ctx->open_context;
    927         struct inode *inode = d_inode(ctx->dentry);
    928
    929         if (!refcount_dec_and_lock(&l_ctx->count, &inode->i_lock))
    930                 return;
    931         list_del_rcu(&l_ctx->list);
    932         spin_unlock(&inode->i_lock);
    933         put_nfs_open_context(ctx);
    934         kfree_rcu(l_ctx, rcu_head);
    935 }
    936 EXPORT_SYMBOL_GPL(nfs_put_lock_context);


# eu-addr2line -e ./vmlinux get_page_from_freelist+0x897
mm/page_alloc.c:2887:2

   2875 /*
   2876  * Obtain a specified number of elements from the buddy
allocator, all under
   2877  * a single hold of the lock, for efficiency.  Add them to the
supplied list.
   2878  * Returns the number of new pages which were placed at *list.
   2879  */
   2880 static int rmqueue_bulk(struct zone *zone, unsigned int order,
   2881                         unsigned long count, struct list_head *list,
   2882                         int migratetype, unsigned int alloc_flags)
   2883 {
   2884         int i, alloced = 0;
   2885
   2886         spin_lock(&zone->lock);
   2887         for (i = 0; i < count; ++i) {
   2888                 struct page *page = __rmqueue(zone, order, migratetype,
   2889
 alloc_flags);



# eu-addr2line -e ./vmlinux kvfree_call_rcu+0x168
kernel/rcu/tree.c:3391:6

   3362         /* Check if a new block is required. */
   3363         if (!krcp->bkvhead[idx] ||
   3364                         krcp->bkvhead[idx]->nr_records ==
KVFREE_BULK_MAX_ENTR) {
   3365                 bnode = get_cached_bnode(krcp);
   3366                 if (!bnode) {
   3367                         /*
   3368                          * To keep this path working on raw
non-preemptible
   3369                          * sections, prevent the optional entry into the
   3370                          * allocator as it uses sleeping
locks. In fact, even
   3371                          * if the caller of kfree_rcu() is
preemptible, this
   3372                          * path still is not, as krcp->lock is
a raw spinlock.
   3373                          * With additional page pre-allocation
in the works,
   3374                          * hitting this return is going to be
much less likely.
   3375                          */
   3376                         if (IS_ENABLED(CONFIG_PREEMPT_RT))
   3377                                 return false;
   3378
   3379                         /*
   3380                          * NOTE: For one argument of kvfree_rcu() we can
   3381                          * drop the lock and get the page in sleepable
   3382                          * context. That would allow to
maintain an array
   3383                          * for the CONFIG_PREEMPT_RT as well
if no cached
   3384                          * pages are available.
   3385                          */
   3386                         bnode = (struct kvfree_rcu_bulk_data *)
   3387                                 __get_free_page(GFP_NOWAIT |
__GFP_NOWARN);
   3388                 }
   3389
   3390                 /* Switch to emergency path. */
   3391                 if (unlikely(!bnode))
   3392                         return false;

