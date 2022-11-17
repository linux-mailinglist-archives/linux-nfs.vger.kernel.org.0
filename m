Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF3B62D9DF
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 12:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiKQLwM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 06:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiKQLvv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 06:51:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744352CDFB
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 03:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668685830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EU22jHrMKKoTjGDe3A7fuyDcGmQNlSSXebz5PYPQ51c=;
        b=NPL7pNi+PeOUEMCWLcyrOTqcpVf/BEjUG2mKD2y4QidbW5iD5tC6qH3J1BF+13MlpQOYyb
        ekPbA9/nbwNgcaFAD2bAtnmjfcHSkFnbJRSH5vrNqO3AF1KmqLDvpAAxWnE+r4nD4cuSD2
        AsHdHkGdC+dWVYVyrL3Xr4Y+pmNAgis=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-vMTZk_T_Na-LqOb_jSTs8A-1; Thu, 17 Nov 2022 06:50:27 -0500
X-MC-Unique: vMTZk_T_Na-LqOb_jSTs8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF51129A8AEB;
        Thu, 17 Nov 2022 11:50:26 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.32.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92D48C1E88E;
        Thu, 17 Nov 2022 11:50:26 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Daire Byrne <daire.byrne@gmail.com>,
        Benjamin Maynard <benmaynard@google.com>
Cc:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] Fix oops in cachefiles_prepare_write due to cookie_lru and use_cookie race
Date:   Thu, 17 Nov 2022 06:50:22 -0500
Message-Id: <20221117115023.1350181-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch should fix the oops seen by Daire while testing the latest
NFS netfs fscache conversion patches [1][2].  What follows is a detailed
explanation of the analysis, mostly for reference and in case any of
the patch header is unclear.

I am not sure if David Howells will see something else here or another
approach, but if not Daire please give this patch a try and let me know
if this fixes the problem and if you see any side-effects.

The patch has been lightly tested with my unit tests and also some
test which attempted (unsuccessfully so far) to reproduce this oops.

Note: My full set of NFS netfs conversion patches I'm testing (which now
includes the patch in this series) is pushed to github:
https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs
https://github.com/DaveWysochanskiRH/kernel/commit/3a7100256a78a7617941c7b142e079bafb71c459

[1] https://listman.redhat.com/archives/linux-cachefs/2022-October/007259.html
[2] https://marc.info/?l=linux-nfs&m=166600357429305&w=4


Analysis
========

From Daire's latest ftrace log while running the debug patch, we see the
following:

$ grep -B 4000 "object == NULL:" loncloudnfscache5-serial.log | egrep '(c=00000b95|R=00278174)'
[29690.046137] kworker/-19194     1..... 9424710955us : fscache_cookie: c=00000b95 -   lrudo r=3
[29690.082232] kworker/-19194     1..... 9424710955us : fscache_access: c=00000b95 UNPIN cache   r=3 a=0
[29690.091621] kworker/-19194     1..... 9424710955us : fscache_cookie: c=00000b95 GQ  endac r=4
[29690.261035] kworker/-19194     1..... 9424710957us : fscache_cookie: c=00000b95 PUT lru   r=3
[29690.607434]     nfsd-2004      5...1. 9424710960us : fscache_active: c=00000b95 USE           r=3 a=0 c=1
[29692.215455]     nfsd-2004      5..... 9424710975us : fscache_access: c=00000b95 BEGIN io_read r=3 a=1
[29692.405546] kworker/-25371     0..... 9424710975us : fscache_cookie: c=00000b95 -   work  r=3
[29692.421426]     nfsd-2004      5..... 9424710976us : netfs_read: R=00278174 READAHEAD c=00000b95 ni=8bb0005 s=0 10000
[29692.488038] kworker/-25371     0..... 9424710976us : cachefiles_ref: c=00000b95 o=0009b320 u=1 SEE withdraw_cookie
[29692.520323] kworker/-25371     0...1. 9424710976us : cachefiles_ref: c=00000b95 o=0009b320 u=1 SEE withdrawal
[29692.656826] kworker/-25371     0..... 9424710977us : cachefiles_ref: c=00000b95 o=0009b320 u=1 SEE clean_commit
[29692.683613]     nfsd-2004      5..... 9424710977us : netfs_rreq_ref: R=00278174 GET SUBREQ  r=2
[29692.750300]     nfsd-2004      5..... 9424710977us : cachefiles_prep_read: R=00278174[0] DOWN no-data    f=01 s=0 10000 ni=8bb0005 B=5a601b9
[29692.837249]     nfsd-2004      5..... 9424710977us : netfs_sreq: R=00278174[0] DOWN PREP  f=01 s=0 0/10000 e=0
[29692.916087]     nfsd-2004      5..... 9424710978us : netfs_sreq: R=00278174[0] DOWN SUBMT f=01 s=0 0/10000 e=0
[29693.315546] kworker/-25371     0..... 9424710983us : cachefiles_ref: c=00000b95 o=0009b320 u=1 PUT detach
[29693.381768] kworker/-25371     0..... 9424710983us : fscache_cookie: c=00000b95 PUT obj   r=2
[29693.427768] kworker/-25371     0...1. 9424710983us : fscache_cookie: c=00000b95 -   x-lru r=2
[29693.446174] kworker/-25371     0..... 9424710984us : fscache_cookie: c=00000b95 PQ  work  r=1
[29720.026557] kworker/-23613     3..... 9424722078us : netfs_sreq: R=00278174[0] DOWN TERM  f=01 s=0 10000/10000 e=0
[29720.037562] kworker/-23613     3..... 9424722078us : netfs_rreq: R=00278174 RA ASSESS  f=22
[29720.061359] kworker/-23613     3..... 9424722079us : netfs_rreq: R=00278174 RA UNLOCK  f=22
[29720.132747] kworker/-23613     3..... 9424722087us : netfs_sreq_ref: R=00278174[0] PUT TERM    r=1
[29720.145155] kworker/-23613     3..... 9424722088us : netfs_rreq: R=00278174 RA COPY    f=02
[29720.158119] kworker/-23613     3..... 9424722090us : cachefiles_prepare_write: object == NULL: c=00000b95


Decode the above trace envents one by one and figure out what happened.

kworker/-19194: Runs because the LRU timer expired

fscache_cookie_lru_timed_out()
  fscache_cookie_lru_worker()
    fscache_cookie_lru_do_one()


[29690.046137] kworker/-19194     1..... 9424710955us : fscache_cookie: c=00000b95 -   lrudo r=3
	EM(fscache_cookie_see_lru_do_one,	"-   lrudo")		\

    848 static void fscache_cookie_lru_do_one(struct fscache_cookie *cookie)
    849 {
    850         fscache_see_cookie(cookie, fscache_cookie_see_lru_do_one);
    851 
    852         spin_lock(&cookie->lock);
    853         if (cookie->state != FSCACHE_COOKIE_STATE_ACTIVE ||
    854             time_before(jiffies, cookie->unused_at + fscache_lru_cookie_timeout) ||
    855             atomic_read(&cookie->n_active) > 0) {
...
    860         } else {
    859                 set_bit(FSCACHE_COOKIE_DO_LRU_DISCARD, &cookie->flags);
    860                 spin_unlock(&cookie->lock);
    861                 fscache_stat(&fscache_n_cookies_lru_expired);
    862                 _debug("lru c=%x", cookie->debug_id);
    863                 __fscache_withdraw_cookie(cookie);
...
	    827 /*
	    828  * Wait for the object to become inactive.  The cookie's work item will be
	    829  * scheduled when someone transitions n_accesses to 0 - but if someone's
	    830  * already done that, schedule it anyway.
	    831  */
	    832 static void __fscache_withdraw_cookie(struct fscache_cookie *cookie)
	    833 {
	    834         int n_accesses;
	    835         bool unpinned;
	    836 
	    837         unpinned = test_and_clear_bit(FSCACHE_COOKIE_NO_ACCESS_WAKE, &cookie->flags);
	    838 
	    839         /* Need to read the access count after unpinning */
	    840         n_accesses = atomic_read(&cookie->n_accesses);
	    841         if (unpinned)

[29690.082232] kworker/-19194     1..... 9424710955us : fscache_access: c=00000b95 UNPIN cache   r=3 a=0
		EM(fscache_access_cache_unpin,		"UNPIN cache  ")	\

	    842                 trace_fscache_access(cookie->debug_id, refcount_read(&cookie->ref),
	    843                                      n_accesses, fscache_access_cache_unpin);
	    844         if (n_accesses == 0)

[29690.091621] kworker/-19194     1..... 9424710955us : fscache_cookie: c=00000b95 GQ  endac r=4
	EM(fscache_cookie_get_end_access,	"GQ  endac")		\

	    845                 fscache_queue_cookie(cookie, fscache_cookie_get_end_access);
	    846 }
...
    864         }
    865 

[29690.261035] kworker/-19194     1..... 9424710957us : fscache_cookie: c=00000b95 PUT lru   r=3
	EM(fscache_cookie_put_lru,		"PUT lru  ")		\

    866         fscache_put_cookie(cookie, fscache_cookie_put_lru);
    867 }


At this point, the kworker is done and we have queued the cookie to run the state machine,
but it has not yet run.  And we know the cookie has the following values in various fields:
1. cookie->state == FSCACHE_COOKIE_STATE_ACTIVE
* Otherwise, we would have the 'then' clause would have executed in fscache_cookie_lru_do_one() lines 853-855
2. cookie->flags has set FSCACHE_COOKIE_DO_LRU_DISCARD
3. cookie->n_accesses == 0 (the "a=0" in the "UNPIN cache" trace event



nfsd-2004: Runs because nfs_fscache_open_file() is called upon opening a file for read (will_modify == false)

[29690.607434]     nfsd-2004      5...1. 9424710960us : fscache_active: c=00000b95 USE           r=3 a=0 c=1
	EM(fscache_active_use,			"USE          ")	\

    565 /*
    566  * Start using the cookie for I/O.  This prevents the backing object from being
    567  * reaped by VM pressure.
    568  */
    569 void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
    570 {
    571         enum fscache_cookie_state state;
    572         bool queue = false;
    573         int n_active;
    574 
    575         _enter("c=%08x", cookie->debug_id);
    576 
    577         if (WARN(test_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags),
    578                  "Trying to use relinquished cookie\n"))
    579                 return;
    580 
    581         spin_lock(&cookie->lock);
    582 
    583         n_active = atomic_inc_return(&cookie->n_active);
    584         trace_fscache_active(cookie->debug_id, refcount_read(&cookie->ref),
    585                              n_active, atomic_read(&cookie->n_accesses),
    586                              will_modify ?
    587                              fscache_active_use_modify : fscache_active_use);
    588 
    589 again:
    590         state = fscache_cookie_state(cookie);
    591         switch (state) {


Called from NFS here:
fs/nfs/fscache.c
    216 void nfs_fscache_open_file(struct inode *inode, struct file *filp)
    217 {
    218         struct nfs_fscache_inode_auxdata auxdata;
    219         struct fscache_cookie *cookie = netfs_i_cookie(netfs_inode(inode));
    220         bool open_for_write = inode_is_open_for_write(inode);
    221 
    222         if (!fscache_cookie_valid(cookie))
    223                 return;
    224 
    225         fscache_use_cookie(cookie, open_for_write);
    226         if (open_for_write) {
    227                 nfs_fscache_update_auxdata(&auxdata, inode);
    228                 fscache_invalidate(cookie, &auxdata, i_size_read(inode),
    229                                    FSCACHE_INVAL_DIO_WRITE);
    230         }
    231 }
    232 EXPORT_SYMBOL_GPL(nfs_fscache_open_file);


[29692.215455]     nfsd-2004      5..... 9424710975us : fscache_access: c=00000b95 BEGIN io_read r=3 a=1
	EM(fscache_access_io_read,		"BEGIN io_read")	\

fs/fscache/io.c
int __fscache_begin_read_operation(struct netfs_cache_resources *cres,
                                   struct fscache_cookie *cookie)
{
        return fscache_begin_operation(cres, cookie, FSCACHE_WANT_PARAMS,
                                       fscache_access_io_read);
}
EXPORT_SYMBOL(__fscache_begin_read_operation);
include/linux/fscache.h
    431 /**
    432  * fscache_begin_read_operation - Begin a read operation for the netfs lib
    433  * @cres: The cache resources for the read being performed
    434  * @cookie: The cookie representing the cache object
    435  *
    436  * Begin a read operation on behalf of the netfs helper library.  @cres
    437  * indicates the cache resources to which the operation state should be
    438  * attached; @cookie indicates the cache object that will be accessed.
    439  *
    440  * This is intended to be called from the ->begin_cache_operation() netfs lib
    441  * operation as implemented by the network filesystem.
    442  *
    443  * @cres->inval_counter is set from @cookie->inval_counter for comparison at
    444  * the end of the operation.  This allows invalidation during the operation to
    445  * be detected by the caller.
    446  *
    447  * Returns:
    448  * * 0          - Success
    449  * * -ENOBUFS   - No caching available
    450  * * Other error code from the cache, such as -ENOMEM.
    451  */
    452 static inline
    453 int fscache_begin_read_operation(struct netfs_cache_resources *cres,
    454                                  struct fscache_cookie *cookie)
    455 {
    456         if (fscache_cookie_enabled(cookie))
    457                 return __fscache_begin_read_operation(cres, cookie);
    458         return -ENOBUFS;
    459 }

    277 static inline int nfs_netfs_begin_cache_operation(struct netfs_io_request *rreq)
    278 {
    279         return fscache_begin_read_operation(&rreq->cache_resources,
    280                                             netfs_i_cookie(netfs_inode(rreq->inode)));
    281 }

[The rest of the call chain is from netfs lib and is not shown]

This looks like the bug because nfsd-2004 shouldn't be able to begin an IO read for a
cookie that has been scheduled for LRU_DISCARD due to expiring timer.  Better yet, since
the cookie state machine has not run yet for LRU_DISCARD bit, we can probably just ensure
that part of the state machine does not run if we get another thread racing in between
with a use_cookie - basically we took the cookie off the LRU and were about to go through
the logic in the state machine that would withdraw the cookie, but we didn't get to that
yet, and the 'use' should indicate we don't want to do that anymore.

At this point I'm thinking some small patch inside __fscache_use_cookie() may work.
Since the cookie_lru timer has popped and as stated earlier, we have the following
set on various fields of the cookie:
1. cookie->state == FSCACHE_COOKIE_STATE_ACTIVE
* Otherwise, we would have the 'then' clause would have executed in fscache_cookie_lru_do_one() lines 853-855
2. cookie->flags has set FSCACHE_COOKIE_DO_LRU_DISCARD
3. cookie->n_accesses == 0 (the "a=0" in the "UNPIN cache" trace event

Something that clears the FSCACHE_COOKIE_DO_LRU_DISCARD bit should fix the problem since
the next time the state machine runs it won't transition from 
cookie->state == FSCACHE_COOKIE_STATE_ACTIVE
to
cookie->state = FSCACHE_COOKIE_STATE_LRU_DISCARDING

$  git diff fs/fscache/cookie.c
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 451d8a077e12..a90c743fec79 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -605,6 +605,13 @@ void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
                        set_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags);
                        queue = true;
                }
+               /*
+                * We could race with cookie_lru which may set LRU_DISCARD bit
+                * but has yet to run the cookie state machine.  If this happens
+                * and another thread tries to use the cookie, clear LRU_DISCARD
+                * so we don't end up withdrawing the cookie while in use.
+                */
+               clear_bit(FSCACHE_COOKIE_DO_LRU_DISCARD, &cookie->flags);
                break;
 
        case FSCACHE_COOKIE_STATE_FAILED:



kworker/-25371: Runs because kworker/-19194 (LRU timer) end calls fscache_queue_cookie(cookie, fscache_cookie_get_end_access);
fscache_cookie_worker()
  fscache_cookie_state_machine()

[29692.405546] kworker/-25371     0..... 9424710975us : fscache_cookie: c=00000b95 -   work  r=3
	E_(fscache_cookie_see_work,		"-   work ")
    818 static void fscache_cookie_worker(struct work_struct *work)
    819 {
    820         struct fscache_cookie *cookie = container_of(work, struct fscache_cookie, work);
    821 
    822         fscache_see_cookie(cookie, fscache_cookie_see_work);
    823         fscache_cookie_state_machine(cookie);
    824         fscache_put_cookie(cookie, fscache_cookie_put_work);
    825 }

fs/fscache/internal.h
     68 static inline void fscache_see_cookie(struct fscache_cookie *cookie,
     69                                       enum fscache_cookie_trace where)
     70 {
     71         trace_fscache_cookie(cookie->debug_id, refcount_read(&cookie->ref),
     72                              where);
     73 }


nfsd-2004: Runs to read the file after the process has has opened it (per the above)

[29692.421426]     nfsd-2004      5..... 9424710976us : netfs_read: R=00278174 READAHEAD c=00000b95 ni=8bb0005 s=0 10000
	EM(netfs_read_trace_readahead,		"READAHEAD")	\
    140 /**
    141  * netfs_readahead - Helper to manage a read request
    142  * @ractl: The description of the readahead request
    143  *
    144  * Fulfil a readahead request by drawing data from the cache if possible, or
    145  * the netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O
    146  * requests from different sources will get munged together.  If necessary, the
    147  * readahead window can be expanded in either direction to a more convenient
    148  * alighment for RPC efficiency or to make storage in the cache feasible.
    149  *
    150  * The calling netfs must initialise a netfs context contiguous to the vfs
    151  * inode before calling this.
    152  *
    153  * This is usable whether or not caching is enabled.
    154  */
    155 void netfs_readahead(struct readahead_control *ractl)
    156 {
    157         struct netfs_io_request *rreq;
    158         struct netfs_inode *ctx = netfs_inode(ractl->mapping->host);
    159         int ret;
    160 
    161         _enter("%lx,%x", readahead_index(ractl), readahead_count(ractl));
    162 
    163         if (readahead_count(ractl) == 0)
    164                 return;
    165 
    166         rreq = netfs_alloc_request(ractl->mapping, ractl->file,
    167                                    readahead_pos(ractl),
    168                                    readahead_length(ractl),
    169                                    NETFS_READAHEAD);
    170         if (IS_ERR(rreq))
    171                 return;
    172 
    173         if (ctx->ops->begin_cache_operation) {
    174                 ret = ctx->ops->begin_cache_operation(rreq);
    175                 if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
    176                         goto cleanup_free;
    177         }
    178 
    179         netfs_stat(&netfs_n_rh_readahead);
    180         trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
    181                          netfs_read_trace_readahead);
    182 
    183         netfs_rreq_expand(rreq, ractl);
    184 
    185         /* Drop the refs on the folios here rather than in the cache or
    186          * filesystem.  The locks will be dropped in netfs_rreq_unlock().
    187          */
    188         while (readahead_folio(ractl))
    189                 ;
    190 
    191         netfs_begin_read(rreq, false);
    192         return;
    193 
    194 cleanup_free:
    195         netfs_put_request(rreq, false, netfs_rreq_trace_put_failed);
    196         return;
    197 }
    198 EXPORT_SYMBOL(netfs_readahead);


kworker/-25371 - This is where the kworker picks back up to run the cookie_lru work item and
we are running through the state machine.  The running through the state machine is the problem
if the LRU_DISCARD bit is set, since we'll transition the state to LRU_DISCARDING and then
eventually call withdraw_cookie.

[29692.488038] kworker/-25371     0..... 9424710976us : cachefiles_ref: c=00000b95 o=0009b320 u=1 SEE withdraw_cookie
	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\

fs/cachefiles/interface.c
    346 /*
    347  * Withdraw caching for a cookie.
    348  */
    349 static void cachefiles_withdraw_cookie(struct fscache_cookie *cookie)
    350 {
    351         struct cachefiles_object *object = cookie->cache_priv;
    352         struct cachefiles_cache *cache = object->volume->cache;
    353         const struct cred *saved_cred;
    354 
    355         _enter("o=%x", object->debug_id);
    356         cachefiles_see_object(object, cachefiles_obj_see_withdraw_cookie);
    357 
    358         if (!list_empty(&object->cache_link)) {
    359                 spin_lock(&cache->object_list_lock);
    360                 cachefiles_see_object(object, cachefiles_obj_see_withdrawal);
    361                 list_del_init(&object->cache_link);
    362                 spin_unlock(&cache->object_list_lock);
    363         }
    364 
    365         cachefiles_ondemand_clean_object(object);
    366 
    367         if (object->file) {
    368                 cachefiles_begin_secure(cache, &saved_cred);
    369                 cachefiles_clean_up_object(object, cache);
    370                 cachefiles_end_secure(cache, saved_cred);
    371         }
    372 
    373         cookie->cache_priv = NULL;
    374         cachefiles_put_object(object, cachefiles_obj_put_detach);
    375 }

...
    442         .withdraw_cookie        = cachefiles_withdraw_cookie,


Called from
fs/fscache/cookie.c
    699 static void fscache_cookie_state_machine(struct fscache_cookie *cookie)
    700 {
    701         enum fscache_cookie_state state;
    702         bool wake = false;
    703 
    704         _enter("c=%x", cookie->debug_id);
    705 
    706 again:
    707         spin_lock(&cookie->lock);
    708 again_locked:
    709         state = cookie->state;
    710         switch (state) {
...
    770         case FSCACHE_COOKIE_STATE_LRU_DISCARDING:
    771         case FSCACHE_COOKIE_STATE_RELINQUISHING:
    772         case FSCACHE_COOKIE_STATE_WITHDRAWING:
    773                 if (cookie->cache_priv) {
    774                         spin_unlock(&cookie->lock);
    775                         cookie->volume->cache->ops->withdraw_cookie(cookie);
    776                         spin_lock(&cookie->lock);
    777                 }


kworker/-25371 - The rest of this is just withdrawal of the cookie, and at this
point I think we're down the wrong path because an IO is in progress.

[29692.520323] kworker/-25371     0...1. 9424710976us : cachefiles_ref: c=00000b95 o=0009b320 u=1 SEE withdrawal
	E_(cachefiles_obj_see_withdrawal,	"SEE withdrawal")

[29692.656826] kworker/-25371     0..... 9424710977us : cachefiles_ref: c=00000b95 o=0009b320 u=1 SEE clean_commit
	EM(cachefiles_obj_see_clean_commit,	"SEE clean_commit")	\

nfsd-2004 - The rest of the IO submit path.  We'll eventually see 'no-data' in the cache,
and submit this to the netfs for data retrieval

[29692.683613]     nfsd-2004      5..... 9424710977us : netfs_rreq_ref: R=00278174 GET SUBREQ  r=2
[29692.750300]     nfsd-2004      5..... 9424710977us : cachefiles_prep_read: R=00278174[0] DOWN no-data    f=01 s=0 10000 ni=8bb0005 B=5a601b9
[29692.837249]     nfsd-2004      5..... 9424710977us : netfs_sreq: R=00278174[0] DOWN PREP  f=01 s=0 0/10000 e=0
[29692.916087]     nfsd-2004      5..... 9424710978us : netfs_sreq: R=00278174[0] DOWN SUBMT f=01 s=0 0/10000 e=0

kworker/-25371 - This is the end of the cookie_lru path

[29693.315546] kworker/-25371     0..... 9424710983us : cachefiles_ref: c=00000b95 o=0009b320 u=1 PUT detach
[29693.381768] kworker/-25371     0..... 9424710983us : fscache_cookie: c=00000b95 PUT obj   r=2
[29693.427768] kworker/-25371     0...1. 9424710983us : fscache_cookie: c=00000b95 -   x-lru r=2
[29693.446174] kworker/-25371     0..... 9424710984us : fscache_cookie: c=00000b95 PQ  work  r=1


kworker/-23613 - This is the end of the IO and we are going to try to write the data to the
cache.  When we eventually get inside cachefiles we blow up in cachefiles_prepare_write because
the object == NULL (we've withdrawn it above)

[29720.026557] kworker/-23613     3..... 9424722078us : netfs_sreq: R=00278174[0] DOWN TERM  f=01 s=0 10000/10000 e=0
[29720.037562] kworker/-23613     3..... 9424722078us : netfs_rreq: R=00278174 RA ASSESS  f=22
[29720.061359] kworker/-23613     3..... 9424722079us : netfs_rreq: R=00278174 RA UNLOCK  f=22
[29720.132747] kworker/-23613     3..... 9424722087us : netfs_sreq_ref: R=00278174[0] PUT TERM    r=1
[29720.145155] kworker/-23613     3..... 9424722088us : netfs_rreq: R=00278174 RA COPY    f=02

NOTE: This last trace event was added in a debug patch for this problem, and is not present
in mainline

[29720.158119] kworker/-23613     3..... 9424722090us : cachefiles_prepare_write: object == NULL: c=00000b95




Notes on cookie_lru
===================

The LRU is controlled by a timer, fscache_cookie_lru_timer.

DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);

static unsigned int fscache_lru_cookie_timeout = 10 * HZ;

static void fscache_cookie_lru_timed_out(struct timer_list *timer)
{
	queue_work(fscache_wq, &fscache_cookie_lru_work);
}

The lru_timer calls lru_worker

static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);

static void fscache_cookie_lru_do_one(struct fscache_cookie *cookie)
{
	fscache_see_cookie(cookie, fscache_cookie_see_lru_do_one);

	spin_lock(&cookie->lock);
	if (cookie->state != FSCACHE_COOKIE_STATE_ACTIVE ||
	    time_before(jiffies, cookie->unused_at + fscache_lru_cookie_timeout) ||
	    atomic_read(&cookie->n_active) > 0) {
		spin_unlock(&cookie->lock);
		fscache_stat(&fscache_n_cookies_lru_removed);
	} else {
		set_bit(FSCACHE_COOKIE_DO_LRU_DISCARD, &cookie->flags);
		spin_unlock(&cookie->lock);
		fscache_stat(&fscache_n_cookies_lru_expired);
		_debug("lru c=%x", cookie->debug_id);
		__fscache_withdraw_cookie(cookie);
	}

	fscache_put_cookie(cookie, fscache_cookie_put_lru);
}

static void fscache_cookie_lru_worker(struct work_struct *work)
{
	struct fscache_cookie *cookie;
	unsigned long unused_at;

	spin_lock(&fscache_cookie_lru_lock);

	while (!list_empty(&fscache_cookie_lru)) {
		cookie = list_first_entry(&fscache_cookie_lru,
					  struct fscache_cookie, commit_link);
		unused_at = cookie->unused_at + fscache_lru_cookie_timeout;
		if (time_before(jiffies, unused_at)) {
			timer_reduce(&fscache_cookie_lru_timer, unused_at);
			break;
		}

		list_del_init(&cookie->commit_link);
		fscache_stat_d(&fscache_n_cookies_lru);
		spin_unlock(&fscache_cookie_lru_lock);
		fscache_cookie_lru_do_one(cookie);
		spin_lock(&fscache_cookie_lru_lock);
	}

	spin_unlock(&fscache_cookie_lru_lock);
}



Also note unuse_cookie involvement

static void fscache_unuse_cookie_locked(struct fscache_cookie *cookie)
{
	clear_bit(FSCACHE_COOKIE_DISABLED, &cookie->flags);
	if (!test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags))
		return;

	cookie->unused_at = jiffies;
	spin_lock(&fscache_cookie_lru_lock);
	if (list_empty(&cookie->commit_link)) {
		fscache_get_cookie(cookie, fscache_cookie_get_lru);
		fscache_stat(&fscache_n_cookies_lru);
	}
	list_move_tail(&cookie->commit_link, &fscache_cookie_lru);

	spin_unlock(&fscache_cookie_lru_lock);
	timer_reduce(&fscache_cookie_lru_timer,
		     jiffies + fscache_lru_cookie_timeout);
}



Dave Wysochanski (1):
  fscache: Fix oops due to race with cookie_lru and use_cookie

 fs/fscache/cookie.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.31.1

