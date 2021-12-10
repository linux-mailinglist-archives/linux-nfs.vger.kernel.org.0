Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04769470EAB
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Dec 2021 00:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhLJXdN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Dec 2021 18:33:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239348AbhLJXdM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Dec 2021 18:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639178975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=13zlYbSIumxDOzpxrk00lAIpGj3hrp4oQbwOkXVCazE=;
        b=HQkz5BhlfSn/neQ/WUT+6hiffFZYnsrl8k5m9Lty980BDSXMn2hrlpp1UUUFW4zObeF09g
        jY54qVweErxgKD6FCxku5e6nPEPBsl3RWeURb+dJGG7onsRYFQKin6GhBd0SssLcm041oI
        RUJJeu8SyCkw0/SVH9MRgX18Bbw/JUU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-ldG58juhPz2wNRadua0ipw-1; Fri, 10 Dec 2021 18:29:34 -0500
X-MC-Unique: ldG58juhPz2wNRadua0ipw-1
Received: by mail-ed1-f70.google.com with SMTP id i19-20020a05640242d300b003e7d13ebeedso9517524edc.7
        for <linux-nfs@vger.kernel.org>; Fri, 10 Dec 2021 15:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=13zlYbSIumxDOzpxrk00lAIpGj3hrp4oQbwOkXVCazE=;
        b=F0KSG/Sa7TJxzMNqjRJeAyONUT5lf0Hntcwx/DZ0iJbk4I8XNils9VoS95Ju/ogOYS
         A5sGJ9jKUAyYEdm4EJBYoVSmK0+BkzVV6QkC/qT3+73R0OFL4B9u8xIwYTjQz2RuNglq
         utm1mf8tbl22bf42B38KOAnPNR/aPPy4/5IpFfwXJmHfM4dryouqX3zCMGTPkAUUpGSz
         TQuZ5TTj9p7EVvaSXaZkyklTBHhR+IO0Hrld5MNlu/X2VKqpPEL8EBiQ6TTX3cFkuWuf
         m9tzKlWz998TIRgBK1oOHgvC4CtSefiuNH9Odrzz5RSAdib4GMCX5CdFu6kxn0otRhWH
         JNEg==
X-Gm-Message-State: AOAM530iUXhob7yVInCJU6h/m93PSV7x8ynRK7mjhZRUtMeMQkGtq9sb
        UG56sgq+5SZ6ZeBytGXOD2Dd8qswV6K1cHeKQhjO7DS1K8vEBJRtksn/T1CUf4B8DffI9Rljmgs
        1BCcJFg/Hi4D40fcAIzbzlAICqGD2GlJ6J/pV
X-Received: by 2002:a17:906:4fc8:: with SMTP id i8mr27628341ejw.427.1639178972209;
        Fri, 10 Dec 2021 15:29:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAYmobHMWH+YlcDrh/egERoydSMFXDYS49PFIj2gXGp5bPlFIU1wgI0Wt9joxkR8tWgK+g3H8UsLKBMMYYrCU=
X-Received: by 2002:a17:906:4fc8:: with SMTP id i8mr27628307ejw.427.1639178971803;
 Fri, 10 Dec 2021 15:29:31 -0800 (PST)
MIME-Version: 1.0
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 10 Dec 2021 18:28:55 -0500
Message-ID: <CALF+zOnMPQ1F2sBce=q2NbGT-YGwc30QNiRTjXDNbKhZW1gJHw@mail.gmail.com>
Subject: BUG: KASAN: use-after-free in __fscache_acquire_cookie+0x437/0x9b0
 [fscache] with NFSv3 and xfstests on [PATCH v2 00/67] fscache, cachefiles: Rewrite
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After rebuild and some re-runs, I finally hit another use-after-free.
Unfortunately there is not as much information here.  Note that before
kasan was enabled I also did see a kernel crash inside the same
__fscache_acquire_cookie RIP called from nfs_fscache_init_inode
(actual call chain is __fscache_acquire_cookie -> fscache_hash_cookie
-> fscache_compare_cookie

Looks like the bad address, "BUG: kernel NULL pointer dereference,
address: 0000000000000070" refers to RBX: 0000000000000004  since
FAULTING ADDRESS is 0x6c + 0x4 == 0x70
So far I'm not able to decode this much further unfortunately I think
due to kasan assembly.

crash> dis -lr __fscache_acquire_cookie+0x437 | tail --lines=20
0xffffffffc0f33de4 <__fscache_acquire_cookie+0x3f4>:    jne
0xffffffffc0f33e0e <__fscache_acquire_cookie+0x41e>
0xffffffffc0f33de6 <__fscache_acquire_cookie+0x3f6>:    jmpq
0xffffffffc0f33f35 <__fscache_acquire_cookie+0x545>
/mnt/build/kernel/fs/fscache/cookie.c: 299
0xffffffffc0f33deb <__fscache_acquire_cookie+0x3fb>:    mov    %r15,%rax
0xffffffffc0f33dee <__fscache_acquire_cookie+0x3fe>:    sub    %rdx,%rax
0xffffffffc0f33df1 <__fscache_acquire_cookie+0x401>:    test   %rax,%rax
0xffffffffc0f33df4 <__fscache_acquire_cookie+0x404>:    je
0xffffffffc0f33e8f <__fscache_acquire_cookie+0x49f>
/mnt/build/kernel/fs/fscache/cookie.c: 400
0xffffffffc0f33dfa <__fscache_acquire_cookie+0x40a>:    mov    %rbx,%rdi
0xffffffffc0f33dfd <__fscache_acquire_cookie+0x40d>:    callq
0xffffffff834c4390 <__asan_load8>
0xffffffffc0f33e02 <__fscache_acquire_cookie+0x412>:    mov    (%rbx),%rbx
0xffffffffc0f33e05 <__fscache_acquire_cookie+0x415>:    test   %rbx,%rbx
0xffffffffc0f33e08 <__fscache_acquire_cookie+0x418>:    je
0xffffffffc0f33f35 <__fscache_acquire_cookie+0x545>
/mnt/build/kernel/fs/fscache/cookie.c: 401
0xffffffffc0f33e0e <__fscache_acquire_cookie+0x41e>:    mov    %rbp,%rdi
0xffffffffc0f33e11 <__fscache_acquire_cookie+0x421>:    callq
0xffffffff834c4250 <__asan_load4>
0xffffffffc0f33e16 <__fscache_acquire_cookie+0x426>:    mov    0x94(%r12),%r15d
0xffffffffc0f33e1e <__fscache_acquire_cookie+0x42e>:    lea    0x6c(%rbx),%rdi
0xffffffffc0f33e22 <__fscache_acquire_cookie+0x432>:    callq
0xffffffff834c4250 <__asan_load4>
0xffffffffc0f33e27 <__fscache_acquire_cookie+0x437>:    mov
0x6c(%rbx),%edx   <---------- FAULTING ADDRESS is 0x6c + 0x4 == 0x70
crash>
crash> mod -s fscache
     MODULE       NAME                       BASE           SIZE  OBJECT FILE
ffffffffc0f52bc0  fscache              ffffffffc0f30000   450560
/lib/modules/5.16.0-rc4-fscache-rewrite-82abe23a0865-kasan+/kernel/fs/fscache/fscache.ko
crash> struct -o fscache_cookie -x
struct fscache_cookie {
   [0x0] refcount_t ref;
   [0x4] atomic_t n_active;
   [0x8] atomic_t n_accesses;
   [0xc] unsigned int debug_id;
  [0x10] unsigned int inval_counter;
  [0x14] spinlock_t lock;
  [0x18] struct fscache_volume *volume;
  [0x20] void *cache_priv;
  [0x28] struct hlist_bl_node hash_link;
  [0x38] struct list_head proc_link;
  [0x48] struct list_head commit_link;
  [0x58] struct work_struct work;
  [0x78] loff_t object_size;
  [0x80] unsigned long unused_at;
  [0x88] unsigned long flags;
  [0x90] enum fscache_cookie_state state;
  [0x91] u8 advice;
  [0x92] u8 key_len;
  [0x93] u8 aux_len;
  [0x94] u32 key_hash;
         union {
  [0x98]     void *key;
  [0x98]     u8 inline_key[16];
         };
         union {
  [0xa8]     void *aux;
  [0xa8]     u8 inline_aux[8];
         };
}
SIZE: 0xb0


# eu-addr2line -e fs/fscache/fscache.ko __fscache_acquire_cookie+0x437
fs/fscache/cookie.c:296:22

    291 static long fscache_compare_cookie(const struct fscache_cookie *a,
    292                                    const struct fscache_cookie *b)
    293 {
    294         const void *ka, *kb;
    295
    296         if (a->key_hash != b->key_hash)
    297                 return (long)a->key_hash - (long)b->key_hash;

    389 static bool fscache_hash_cookie(struct fscache_cookie *candidate)
    390 {
    391         struct fscache_cookie *cursor, *wait_for = NULL;
    392         struct hlist_bl_head *h;
    393         struct hlist_bl_node *p;
    394         unsigned int bucket;
    395
    396         bucket = candidate->key_hash &
(ARRAY_SIZE(fscache_cookie_hash) - 1);
    397         h = &fscache_cookie_hash[bucket];
    398
    399         hlist_bl_lock(h);
    400         hlist_bl_for_each_entry(cursor, p, h, hash_link) {
    401                 if (fscache_compare_cookie(candidate, cursor) == 0) {
    402                         if
(!test_bit(FSCACHE_COOKIE_RELINQUISHED, &cursor->flags))
    403                                 goto collision;
    404                         wait_for = fscache_get_cookie(cursor,
    405
fscache_cookie_get_hash_collision);
    406                         break;
    407                 }
    408         }

    437 struct fscache_cookie *__fscache_acquire_cookie(
    438         struct fscache_volume *volume,
    439         u8 advice,
    440         const void *index_key, size_t index_key_len,
    441         const void *aux_data, size_t aux_data_len,
    442         loff_t object_size)
    443 {
    444         struct fscache_cookie *cookie;
    445
    446         _enter("V=%x", volume->debug_id);
    447
    448         if (!index_key || !index_key_len || index_key_len >
255 || aux_data_len > 255)
    449                 return NULL;
    450         if (!aux_data || !aux_data_len) {
    451                 aux_data = NULL;
    452                 aux_data_len = 0;
    453         }
    454
    455         fscache_stat(&fscache_n_acquires);
    456
    457         cookie = fscache_alloc_cookie(volume, advice,
    458                                       index_key, index_key_len,
    459                                       aux_data, aux_data_len,
    460                                       object_size);
    461         if (!cookie) {
    462                 fscache_stat(&fscache_n_acquires_oom);
    463                 return NULL;
    464         }
    465
    466         if (!fscache_hash_cookie(cookie)) {
    467                 fscache_see_cookie(cookie, fscache_cookie_discard);
    468                 fscache_free_cookie(cookie);
    469                 return NULL;
    470         }
    471
    472         trace_fscache_acquire(cookie);
    473         fscache_stat(&fscache_n_acquires_ok);
    474         _leave(" = c=%08x", cookie->debug_id);
    475         return cookie;
    476 }
    477 EXPORT_SYMBOL(__fscache_acquire_cookie);


Fedora 34 (Thirty Four)
Kernel 5.16.0-rc4-fscache-rewrite-82abe23a0865-kasan+ on an x86_64 (ttyS0)

dwysocha-f33-node1 login: [  116.240815] Key type dns_resolver registered
[  117.080094] NFS: Registering the id_resolver key type
[  117.080998] Key type id_resolver registered
[  117.081643] Key type id_legacy registered
[  117.883587] run fstests generic/001 at 2021-12-10 16:46:13
[  166.930231] run fstests generic/002 at 2021-12-10 16:47:02
[  170.010369] run fstests generic/003 at 2021-12-10 16:47:05
[  171.409436] run fstests generic/004 at 2021-12-10 16:47:06
[  172.898169] run fstests generic/005 at 2021-12-10 16:47:08
[  175.357500] run fstests generic/006 at 2021-12-10 16:47:10
[  242.079183] run fstests generic/007 at 2021-12-10 16:48:17
[  279.459361] hrtimer: interrupt took 2998911 ns
[  465.511517] run fstests generic/008 at 2021-12-10 16:52:00
[  466.972933] run fstests generic/009 at 2021-12-10 16:52:02
[  468.431876] run fstests generic/010 at 2021-12-10 16:52:03
[  469.777769] run fstests generic/011 at 2021-12-10 16:52:05
[  513.637667] run fstests generic/012 at 2021-12-10 16:52:48
[  515.183967] run fstests generic/013 at 2021-12-10 16:52:50
[  532.679299] CacheFiles: cachefiles: Inode already in use:
Infs,3.0,2,,917aa8c0,11b6fbb0c280227,,,c0,80000,80000,bb8,ea60,7530,ea60,1
[  542.768838] run fstests generic/014 at 2021-12-10 16:53:17
[  608.708004] run fstests generic/015 at 2021-12-10 16:54:23
[  610.067994] run fstests generic/016 at 2021-12-10 16:54:25
[  611.577736] run fstests generic/017 at 2021-12-10 16:54:26
[  613.059498] run fstests generic/018 at 2021-12-10 16:54:28
[  615.072617] run fstests generic/020 at 2021-12-10 16:54:30
[  616.634443] run fstests generic/021 at 2021-12-10 16:54:31
[  618.247911] run fstests generic/022 at 2021-12-10 16:54:33
[  619.751842] run fstests generic/023 at 2021-12-10 16:54:34
[  624.933556] run fstests generic/024 at 2021-12-10 16:54:40
[  626.426606] run fstests generic/025 at 2021-12-10 16:54:41
[  627.936932] run fstests generic/026 at 2021-12-10 16:54:43
[  629.655207] run fstests generic/027 at 2021-12-10 16:54:44
[  631.116553] run fstests generic/028 at 2021-12-10 16:54:46
[  637.674524] run fstests generic/029 at 2021-12-10 16:54:52
[  641.175538] run fstests generic/030 at 2021-12-10 16:54:56
[  645.253008] run fstests generic/031 at 2021-12-10 16:55:00
[  646.721333] run fstests generic/032 at 2021-12-10 16:55:01
[  648.242824] run fstests generic/033 at 2021-12-10 16:55:03
[  649.790584] run fstests generic/034 at 2021-12-10 16:55:05
[  651.252185] run fstests generic/035 at 2021-12-10 16:55:06
[  652.844684] run fstests generic/036 at 2021-12-10 16:55:08
[  664.426043] run fstests generic/037 at 2021-12-10 16:55:19
[  665.807165] run fstests generic/038 at 2021-12-10 16:55:21
[  667.165004] run fstests generic/039 at 2021-12-10 16:55:22
[  668.602477] run fstests generic/040 at 2021-12-10 16:55:23
[  670.010817] run fstests generic/041 at 2021-12-10 16:55:25
[  671.359989] run fstests generic/043 at 2021-12-10 16:55:26
[  673.201808] run fstests generic/044 at 2021-12-10 16:55:28
[  675.092145] run fstests generic/045 at 2021-12-10 16:55:30
[  677.136490] run fstests generic/046 at 2021-12-10 16:55:32
[  679.115816] run fstests generic/047 at 2021-12-10 16:55:34
[  681.169568] run fstests generic/048 at 2021-12-10 16:55:36
[  683.257478] run fstests generic/049 at 2021-12-10 16:55:38
[  685.372013] run fstests generic/050 at 2021-12-10 16:55:40
[  687.444304] run fstests generic/051 at 2021-12-10 16:55:42
[  689.583228] run fstests generic/052 at 2021-12-10 16:55:44
[  691.517190] run fstests generic/053 at 2021-12-10 16:55:46
[  694.986012] run fstests generic/054 at 2021-12-10 16:55:50
[  696.902722] run fstests generic/055 at 2021-12-10 16:55:52
[  699.031353] run fstests generic/056 at 2021-12-10 16:55:54
[  700.677167] run fstests generic/057 at 2021-12-10 16:55:55
[  702.205106] run fstests generic/058 at 2021-12-10 16:55:57
[  703.609498] run fstests generic/059 at 2021-12-10 16:55:58
[  704.950963] run fstests generic/060 at 2021-12-10 16:56:00
[  706.358202] run fstests generic/061 at 2021-12-10 16:56:01
[  707.769142] run fstests generic/062 at 2021-12-10 16:56:03
[  709.173821] run fstests generic/063 at 2021-12-10 16:56:04
[  710.500507] run fstests generic/064 at 2021-12-10 16:56:05
[  711.892195] run fstests generic/065 at 2021-12-10 16:56:07
[  713.396597] run fstests generic/066 at 2021-12-10 16:56:08
[  714.855525] run fstests generic/067 at 2021-12-10 16:56:10
[  716.297302] run fstests generic/068 at 2021-12-10 16:56:11
[  717.667039] run fstests generic/069 at 2021-12-10 16:56:12
[  732.553128] run fstests generic/070 at 2021-12-10 16:56:27
[  734.024395] run fstests generic/071 at 2021-12-10 16:56:29
[  735.423585] run fstests generic/072 at 2021-12-10 16:56:30
[  736.855479] run fstests generic/073 at 2021-12-10 16:56:32
[  738.258477] run fstests generic/074 at 2021-12-10 16:56:33
[  993.158606] run fstests generic/075 at 2021-12-10 17:00:48
[ 1018.989222] run fstests generic/076 at 2021-12-10 17:01:14
[ 1020.338886] run fstests generic/077 at 2021-12-10 17:01:15
[ 1023.279252] run fstests generic/078 at 2021-12-10 17:01:18
[ 1024.710569] run fstests generic/079 at 2021-12-10 17:01:19
[ 1026.039652] run fstests generic/080 at 2021-12-10 17:01:21
[ 1029.559264] run fstests generic/081 at 2021-12-10 17:01:24
[ 1030.893468] run fstests generic/082 at 2021-12-10 17:01:26
[ 1032.200867] run fstests generic/083 at 2021-12-10 17:01:27
[ 1033.541158] run fstests generic/084 at 2021-12-10 17:01:28
[ 1040.703757] run fstests generic/085 at 2021-12-10 17:01:35
[ 1042.241096] run fstests generic/086 at 2021-12-10 17:01:37
[ 1043.773658] run fstests generic/087 at 2021-12-10 17:01:39
[ 1045.782729] run fstests generic/088 at 2021-12-10 17:01:41
[ 1047.354347] run fstests generic/089 at 2021-12-10 17:01:42
[ 1048.524600] ==================================================================
[ 1048.525846] BUG: KASAN: use-after-free in
__fscache_acquire_cookie+0x437/0x9b0 [fscache]
[ 1048.527153] Read of size 4 at addr ffff888118baf264 by task rm/25988
[ 1048.528174]
[ 1048.528460] CPU: 5 PID: 25988 Comm: rm Kdump: loaded Not tainted
5.16.0-rc4-fscache-rewrite-82abe23a0865-kasan+ #1
[ 1048.530048] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-4.fc34 04/01/2014
[ 1048.531379] Call Trace:
[ 1048.531805]  <TASK>
[ 1048.532172]  dump_stack_lvl+0x48/0x5e
[ 1048.532782]  print_address_description.constprop.0+0x1f/0x140
[ 1048.533731]  ? __fscache_acquire_cookie+0x437/0x9b0 [fscache]
[ 1048.534693]  kasan_report.cold+0x7f/0x11b
[ 1048.535363]  ? __fscache_acquire_cookie+0x437/0x9b0 [fscache]
[ 1048.536321]  __fscache_acquire_cookie+0x437/0x9b0 [fscache]
[ 1048.537249]  nfs_fscache_init_inode+0x20b/0x270 [nfs]
[ 1048.538210]  ? nfs_fscache_release_super_cookie+0x90/0x90 [nfs]
[ 1048.539266]  ? _raw_spin_unlock+0x16/0x30
[ 1048.539941]  ? map_id_range_down+0x13f/0x160
[ 1048.540657]  ? nfs_drop_inode+0x70/0x70 [nfs]
[ 1048.541441]  ? nfs_setsecurity+0x26/0xd0 [nfs]
[ 1048.542246]  nfs_fhget+0x757/0xcd0 [nfs]
[ 1048.542967]  ? nfs_setattr+0x390/0x390 [nfs]
[ 1048.543732]  nfs_readdir_page_filler+0xd0c/0x10c0 [nfs]
[ 1048.544634]  ? kasan_quarantine_put+0x32/0x1d0
[ 1048.545343]  ? nfs_unlink+0x4e0/0x4e0 [nfs]
[ 1048.546093]  ? nfs3_proc_get_root+0x90/0x90 [nfsv3]
[ 1048.546890]  ? policy_node+0x4c/0x70
[ 1048.547483]  nfs_readdir_xdr_to_array+0x74c/0xa30 [nfs]
[ 1048.548391]  ? nfs_readdir_page_filler+0x10c0/0x10c0 [nfs]
[ 1048.549329]  ? nfs_readdir_page_get_locked+0x14d/0x190 [nfs]
[ 1048.550310]  nfs_readdir+0x53d/0x15b0 [nfs]
[ 1048.551064]  ? preempt_count_sub+0x14/0xc0
[ 1048.551741]  ? _raw_spin_unlock+0x16/0x30
[ 1048.552392]  ? nfs_readdir_xdr_to_array+0xa30/0xa30 [nfs]
[ 1048.553919]  ? fsnotify_perm.part.0+0xa0/0x250
[ 1048.554650]  iterate_dir+0x101/0x2d0
[ 1048.555255]  __x64_sys_getdents64+0xdc/0x190
[ 1048.555965]  ? filldir+0x270/0x270
[ 1048.556539]  ? up_read+0x15/0x80
[ 1048.557096]  ? __ia32_sys_getdents+0x190/0x190
[ 1048.557812]  do_syscall_64+0x3b/0x90
[ 1048.558400]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1048.559206] RIP: 0033:0x7f7cfd846937
[ 1048.559800] Code: 00 00 0f 05 eb b7 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 00 f3 0f 1e fa b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 11 a5 0f 00 f7 d8 64 89
02 48
[ 1048.562662] RSP: 002b:00007ffd605b7518 EFLAGS: 00000293 ORIG_RAX:
00000000000000d9
[ 1048.563869] RAX: ffffffffffffffda RBX: 00007f7cfd6fa010 RCX: 00007f7cfd846937
[ 1048.564978] RDX: 0000000000080000 RSI: 00007f7cfd6fa040 RDI: 0000000000000003
[ 1048.566108] RBP: 00007f7cfd6fa040 R08: 0000000000000030 R09: 0000000000000000
[ 1048.567199] R10: 0000000000000022 R11: 0000000000000293 R12: ffffffffffffff88
[ 1048.568303] R13: 00007f7cfd6fa014 R14: 0000000000000000 R15: 00005621b20be5a0
[ 1048.569406]  </TASK>
[ 1048.569770]
[ 1048.570039] The buggy address belongs to the page:
[ 1048.570780] page:00000000ef916ee4 refcount:0 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x118baf
[ 1048.572203] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[ 1048.573198] raw: 0017ffffc0000000 0000000000000000 dead000000000122
0000000000000000
[ 1048.574391] raw: 0000000000000000 0000000000000000 00000000ffffffff
0000000000000000
[ 1048.575601] page dumped because: kasan: bad access detected
[ 1048.576469]
[ 1048.576742] Memory state around the buggy address:
[ 1048.577504]  ffff888118baf100: ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff
[ 1048.578640]  ffff888118baf180: ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff
[ 1048.579742] >ffff888118baf200: ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff
[ 1048.580854]                                                        ^
[ 1048.581836]  ffff888118baf280: ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff
[ 1048.582955]  ffff888118baf300: ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff
[ 1048.584073] ==================================================================
[ 1048.585204] Disabling lock debugging due to kernel taint
[ 1048.586068] BUG: kernel NULL pointer dereference, address: 0000000000000070
[ 1048.587147] #PF: supervisor read access in kernel mode
[ 1048.587968] #PF: error_code(0x0000) - not-present page
[ 1048.588771] PGD 0 P4D 0
[ 1048.589203] Oops: 0000 [#1] PREEMPT SMP KASAN PTI
[ 1048.589938] CPU: 5 PID: 25988 Comm: rm Kdump: loaded Tainted: G
B             5.16.0-rc4-fscache-rewrite-82abe23a0865-kasan+ #1
[ 1048.591695] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-4.fc34 04/01/2014
[ 1048.593004] RIP: 0010:__fscache_acquire_cookie+0x437/0x9b0 [fscache]
[ 1048.594013] Code: e8 8e 05 59 c2 48 8b 1b 48 85 db 0f 84 27 01 00
00 48 89 ef e8 3a 04 59 c2 45 8b bc 24 94 00 00 00 48 8d 7b 6c e8 29
04 59 c2 <8b> 53 6c 44 89 f8 48 29 d0 41 39 d7 75 bc 4c 89 f7 e8 53 05
59 c2
[ 1048.596817] RSP: 0018:ffff888105377740 EFLAGS: 00010282
[ 1048.597644] RAX: 0000000000000000 RBX: 0000000000000004 RCX: ffffffffc0f33e27
[ 1048.598767] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000070
[ 1048.599868] RBP: ffff888104124ae4 R08: ffffffffc0f33e27 R09: ffffffff864f5c67
[ 1048.600946] R10: fffffbfff0c9eb8c R11: 0000000000000001 R12: ffff888104124a50
[ 1048.603185] R13: ffffffffc0f6ead8 R14: ffff888104124a68 R15: 00000000fa13375b
[ 1048.608592] FS:  00007f7cfd77b740(0000) GS:ffff888225a80000(0000)
knlGS:0000000000000000
[ 1048.612951] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1048.614019] CR2: 0000000000000070 CR3: 000000011c01c005 CR4: 0000000000770ee0
[ 1048.615325] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1048.616702] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1048.618138] PKRU: 55555554
[ 1048.618628] Call Trace:
[ 1048.619087]  <TASK>
[ 1048.619523]  nfs_fscache_init_inode+0x20b/0x270 [nfs]
[ 1048.620456]  ? nfs_fscache_release_super_cookie+0x90/0x90 [nfs]
[ 1048.621415]  ? _raw_spin_unlock+0x16/0x30
[ 1048.622056]  ? map_id_range_down+0x13f/0x160
[ 1048.622740]  ? nfs_drop_inode+0x70/0x70 [nfs]
[ 1048.623500]  ? nfs_setsecurity+0x26/0xd0 [nfs]
[ 1048.624266]  nfs_fhget+0x757/0xcd0 [nfs]
[ 1048.624971]  ? nfs_setattr+0x390/0x390 [nfs]
[ 1048.625720]  nfs_readdir_page_filler+0xd0c/0x10c0 [nfs]
[ 1048.626623]  ? kasan_quarantine_put+0x32/0x1d0
[ 1048.627328]  ? nfs_unlink+0x4e0/0x4e0 [nfs]
[ 1048.628066]  ? nfs3_proc_get_root+0x90/0x90 [nfsv3]
[ 1048.628866]  ? policy_node+0x4c/0x70
[ 1048.629458]  nfs_readdir_xdr_to_array+0x74c/0xa30 [nfs]
[ 1048.630350]  ? nfs_readdir_page_filler+0x10c0/0x10c0 [nfs]
[ 1048.631285]  ? nfs_readdir_page_get_locked+0x14d/0x190 [nfs]
[ 1048.632234]  nfs_readdir+0x53d/0x15b0 [nfs]
[ 1048.632971]  ? preempt_count_sub+0x14/0xc0
[ 1048.633634]  ? _raw_spin_unlock+0x16/0x30
[ 1048.634281]  ? nfs_readdir_xdr_to_array+0xa30/0xa30 [nfs]
[ 1048.635185]  ? down_read+0x180/0x180
[ 1048.635776]  ? fsnotify_perm.part.0+0xa0/0x250
[ 1048.636492]  iterate_dir+0x101/0x2d0
[ 1048.637079]  __x64_sys_getdents64+0xdc/0x190
[ 1048.637766]  ? filldir+0x270/0x270
[ 1048.638327]  ? up_read+0x15/0x80
[ 1048.638867]  ? __ia32_sys_getdents+0x190/0x190
[ 1048.639571]  do_syscall_64+0x3b/0x90
[ 1048.640155]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1048.640946] RIP: 0033:0x7f7cfd846937
[ 1048.641537] Code: 00 00 0f 05 eb b7 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 00 f3 0f 1e fa b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 11 a5 0f 00 f7 d8 64 89
02 48
[ 1048.644359] RSP: 002b:00007ffd605b7518 EFLAGS: 00000293 ORIG_RAX:
00000000000000d9
[ 1048.645549] RAX: ffffffffffffffda RBX: 00007f7cfd6fa010 RCX: 00007f7cfd846937
[ 1048.646628] RDX: 0000000000080000 RSI: 00007f7cfd6fa040 RDI: 0000000000000003
[ 1048.647744] RBP: 00007f7cfd6fa040 R08: 0000000000000030 R09: 0000000000000000
[ 1048.648864] R10: 0000000000000022 R11: 0000000000000293 R12: ffffffffffffff88
[ 1048.649961] R13: 00007f7cfd6fa014 R14: 0000000000000000 R15: 00005621b20be5a0
[ 1048.651065]  </TASK>
[ 1048.651446] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver
nfsv3 nfs rfkill cachefiles fscache netfs intel_rapl_msr
intel_rapl_common isst_if_common kvm_intel iTCO_wdt intel_pmc_bxt kvm
iTCO_vendor_support nfsd joydev i2c_i801 irqbypass virtio_balloon
lpc_ich i2c_smbus nfs_acl lockd auth_rpcgss grace drm sunrpc fuse zram
ip_tables xfs crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel virtio_console serio_raw virtio_net net_failover
virtio_blk failover qemu_fw_cfg
[ 1048.657895] CR2: 0000000000000070
[ 1048.658450] ---[ end trace b69def88bec5c486 ]---
[ 1048.659182] RIP: 0010:__fscache_acquire_cookie+0x437/0x9b0 [fscache]
[ 1048.660179] Code: e8 8e 05 59 c2 48 8b 1b 48 85 db 0f 84 27 01 00
00 48 89 ef e8 3a 04 59 c2 45 8b bc 24 94 00 00 00 48 8d 7b 6c e8 29
04 59 c2 <8b> 53 6c 44 89 f8 48 29 d0 41 39 d7 75 bc 4c 89 f7 e8 53 05
59 c2
[ 1048.662998] RSP: 0018:ffff888105377740 EFLAGS: 00010282
[ 1048.663828] RAX: 0000000000000000 RBX: 0000000000000004 RCX: ffffffffc0f33e27
[ 1048.664934] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000070
[ 1048.666054] RBP: ffff888104124ae4 R08: ffffffffc0f33e27 R09: ffffffff864f5c67
[ 1048.667154] R10: fffffbfff0c9eb8c R11: 0000000000000001 R12: ffff888104124a50
[ 1048.668257] R13: ffffffffc0f6ead8 R14: ffff888104124a68 R15: 00000000fa13375b
[ 1048.669356] FS:  00007f7cfd77b740(0000) GS:ffff888225a80000(0000)
knlGS:0000000000000000
[ 1048.670607] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1048.671507] CR2: 0000000000000070 CR3: 000000011c01c005 CR4: 0000000000770ee0
[ 1048.672609] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1048.673718] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1048.674822] PKRU: 55555554
[ 1048.675277] note: rm[25988] exited with preempt_count 1
[ 1048.769127] BUG: Dentry 00000000f445c28a{i=0,n=00000454}  still in
use (1) [unmount of nfs 0:43]
[ 1048.771134] ------------[ cut here ]------------
[ 1048.771904] WARNING: CPU: 5 PID: 25997 at fs/dcache.c:1651
umount_check.cold+0x6b/0x77
[ 1048.773164] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver
nfsv3 nfs rfkill cachefiles fscache netfs intel_rapl_msr
intel_rapl_common isst_if_common kvm_intel iTCO_wdt intel_pmc_bxt kvm
iTCO_vendor_support nfsd joydev i2c_i801 irqbypass virtio_balloon
lpc_ich i2c_smbus nfs_acl lockd auth_rpcgss grace drm sunrpc fuse zram
i
p_tables xfs crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel virtio_console serio_raw virtio_net net_failover
virtio_blk failover qemu_fw_cfg
[ 1048.779629] CPU: 5 PID: 25997 Comm: umount.nfs Kdump: loaded
Tainted: G    B D
5.16.0-rc4-fscache-rewrite-82abe23a0865-kasan+ #1
[ 1048.781546] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-4.fc34 04/01/2014
[ 1048.782875] RIP: 0010:umount_check.cold+0x6b/0x77
[ 1048.783632] Code: 31 49 8d 7c 24 40 e8 2c 3c 1a ff 49 8b 54 24 40
41 55 4d 89 f1 41 89 d8 48 89 e9 48 89 ee 48 c7 c7 e0 f6 94 84 e8 89
35 ff ff <0f> 0b 58 e9 23 42 22 ff 31 d2 eb da 49 8d 7c 24 28 49 c7 c7
d8 ff
[ 1048.786486] RSP: 0018:ffff88810b827d70 EFLAGS: 00010282
[ 1048.787346] RAX: 0000000000000054 RBX: 0000000000000001 RCX: 0000000000000000
[ 1048.788491] RDX: 0000000000000003 RSI: ffffffff84a9ba80 RDI: ffffed1021704fa5
[ 1048.789630] RBP: ffff88815632f900 R08: 0000000000000054 R09: ffff888225abc8c7
[ 1048.790762] R10: ffffed1044b57918 R11: 0000000000000001 R12: 0000000000000000
[ 1048.791900] R13: ffff888131c303c8 R14: ffffffffc1345e60 R15: ffff88815632f990
[ 1048.793033] FS:  00007f3b1b4f9540(0000) GS:ffff888225a80000(0000)
knlGS:0000000000000000
[ 1048.794310] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1048.795240] CR2: 00007f3b1bcef670 CR3: 000000012d47a006 CR4: 0000000000770ee0
[ 1048.796382] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1048.797508] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1048.798618] PKRU: 55555554
[ 1048.799093] Call Trace:
[ 1048.799511]  <TASK>
[ 1048.799896]  d_walk+0xf2/0x2f0
[ 1048.800407]  ? shrink_lock_dentry.part.0+0x130/0x130
[ 1048.801213]  shrink_dcache_for_umount+0xf8/0x180
[ 1048.801983]  generic_shutdown_super+0x3c/0x1d0
[ 1048.802718]  nfs_kill_super+0x35/0x60 [nfs]
[ 1048.803486]  deactivate_locked_super+0x5d/0xd0
[ 1048.804213]  cleanup_mnt+0x1f4/0x260
[ 1048.804819]  task_work_run+0x8b/0xc0
[ 1048.805417]  exit_to_user_mode_prepare+0x229/0x230
[ 1048.806389]  syscall_exit_to_user_mode+0x18/0x40
[ 1048.807148]  do_syscall_64+0x48/0x90
[ 1048.807749]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1048.808590] RIP: 0033:0x7f3b1bbb938b
[ 1048.809189] Code: 2a 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3
0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 b9 2a 0c 00
f7 d8
[ 1048.812032] RSP: 002b:00007ffddff3db58 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[ 1048.813216] RAX: 0000000000000000 RBX: 0000562c6bcc4660 RCX: 00007f3b1bbb938b
[ 1048.814364] RDX: 0000562c6bcc4b50 RSI: 0000000000000000 RDI: 0000562c6bcc3d70
[ 1048.815484] RBP: 0000562c6bcc32c0 R08: 0000000000000000 R09: 00000000000000ca
[ 1048.816586] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
[ 1048.817714] R13: 0000562c6bcc3d70 R14: 0000562c6bcc33d0 R15: 0000562c6bcc3410
[ 1048.818839]  </TASK>
[ 1048.819221] ---[ end trace b69def88bec5c487 ]---
[ 1048.846355] VFS: Busy inodes after unmount of 0:43. Self-destruct
in 5 seconds.  Have a nice day...
[ 1049.162920] run fstests generic/090 at 2021-12-10 17:01:44
[ 1050.821567] run fstests generic/091 at 2021-12-10 17:01:46

