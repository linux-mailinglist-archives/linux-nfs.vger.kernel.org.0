Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4C4783CF2
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Aug 2023 11:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbjHVJb5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Aug 2023 05:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjHVJbz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Aug 2023 05:31:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F85E1B2;
        Tue, 22 Aug 2023 02:31:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so5076785a12.3;
        Tue, 22 Aug 2023 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692696712; x=1693301512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNX2IV1j4PZK8nopwhCfzUNR+eUalyCnwM/ftlbIWPU=;
        b=P/UKIOThGf9Fr8sxxWn4TmRAyV5vCNzeOVlZi9tqHfmP+xRuNHVKHGF+JEnw7HqyIb
         2o5fGm/j7fA4MUJFRfgHcx2qqaBQ+HWDU9Pxg/G4KyOcCJFpd+3Ua/TINQw4TiXmRkxi
         uGSLjiHm78teUXpgwY06amFBmsQbZdbL1XzWV8ON6okNh6gp9ra8zGehWD3AnZcqkr6e
         LyP+KoU52S7ajBDOTAedz2j+Ec9Ax9Vip+5VqePqFjaUWYdRjpnGXZVeUMbmUlkwOtwb
         +I3OE5jdt7TuAeFkA/cjUTFv7jEYg7PAfQgApQwiVFotQWrIIuQ6p9MxfvFhboyntGSf
         C9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692696712; x=1693301512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNX2IV1j4PZK8nopwhCfzUNR+eUalyCnwM/ftlbIWPU=;
        b=ihZOpsw7gbFyqgoAsbWIajrd5Izcl1T4Ssv8A7KiSRVAwYwFyNGxGKp114AwwtOv0u
         wcUOZQvILmYg1jYecv8oualQJd89OEB2171RHaTrEN43NyuxzbyFJnUBKr3+yARXW9zD
         I/V1oibmprKlzAee9rdaypD4Z8wBWKp8GZTbQeIJKMCpfo5wjdbDuUgYBp87ANVoGMVi
         ZwEeQohsqeLr8qozVopK8ighY6BEN5OUdBKkxl5/Midnr/fKPdevXIXk2jk2lZ2tzUkK
         CGNk9QfFasKbSG2cz8OebsF8mLK5gqIp/WXPBMMOZSvhQXyAOtDK6Y9boOfUbndnEkbB
         bDQQ==
X-Gm-Message-State: AOJu0Yzx59V9VfJMj+8AkivWDQWM4YpVMgSyADVFyWHT+42Bwo8colR4
        9Rnptds4pjVLUC2nKAW8QOiemSvtI9q/xs8sUHM=
X-Google-Smtp-Source: AGHT+IF2IUMia1kKiqzsQDG69r4ar2gkcgotjenKtdBb/YR/kaH/G+OFKUkUkxRYpR1ro7OP1NvYU9joOCqfW38LHkE=
X-Received: by 2002:aa7:dad5:0:b0:523:2847:fb5a with SMTP id
 x21-20020aa7dad5000000b005232847fb5amr6046620eds.40.1692696711376; Tue, 22
 Aug 2023 02:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230818065507.1280625-1-haydenw.kernel@gmail.com> <169257764320.11865.9867985815081936092@noble.neil.brown.name>
In-Reply-To: <169257764320.11865.9867985815081936092@noble.neil.brown.name>
From:   Hayden Wong <haydenw.kernel@gmail.com>
Date:   Tue, 22 Aug 2023 17:31:39 +0800
Message-ID: <CACjG_2yAFvYu1L3MJ9Q6ZcL2JW0KJzpUXeLKUtiA27V+500sTg@mail.gmail.com>
Subject: Re: [PATCH] nfsd: fix race condition in nfsd_file_acquire
To:     NeilBrown <neilb@suse.de>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, haodong.wong@nio.com,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 21, 2023 at 8:27=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 18 Aug 2023, Haodong Wong wrote:
> > Before Kernel 6.1, we observed the following OOPS in the stress test
> > caused by reorder on set bit NFSD_FILE_HASHED and NFSD_FILE_PENDING,
> > and smp_mb__after_atomic() should be a paire.
>
> If you saw this "before kernel 6.1" does that mean you don't see it
> after kernel 6.1?  So has it already been fixed?
>
I just found after the patched c4c649ab413ba "NFSD: Convert filecache
to rhltable" ,  this issue should not have .
It was fixed as below:
-nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
+nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
+               bool want_gc)
 {
        struct nfsd_file *nf;

        nf =3D kmem_cache_alloc(nfsd_file_slab, GFP_KERNEL);
-       if (nf) {
-               INIT_LIST_HEAD(&nf->nf_lru);
-               nf->nf_birthtime =3D ktime_get();
-               nf->nf_file =3D NULL;
-               nf->nf_cred =3D get_current_cred();
-               nf->nf_net =3D key->net;
-               nf->nf_flags =3D 0;
-               __set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
-               __set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
-               if (key->gc)
-                       __set_bit(NFSD_FILE_GC, &nf->nf_flags);
-               nf->nf_inode =3D key->inode;
-               refcount_set(&nf->nf_ref, 1);
-               nf->nf_may =3D key->need;
-               nf->nf_mark =3D NULL;
-       }
+       if (unlikely(!nf))
+               return NULL;
+
+       INIT_LIST_HEAD(&nf->nf_lru);
+       nf->nf_birthtime =3D ktime_get();
+       nf->nf_file =3D NULL;
+       nf->nf_cred =3D get_current_cred();
+       nf->nf_net =3D net;
+       nf->nf_flags =3D want_gc ?
+               BIT(NFSD_FILE_HASHED) | BIT(NFSD_FILE_PENDING) |
BIT(NFSD_FILE_GC) :
+               BIT(NFSD_FILE_HASHED) | BIT(NFSD_FILE_PENDING);
+       nf->nf_inode =3D inode;
+       refcount_set(&nf->nf_ref, 1);
+       nf->nf_may =3D need;
+       nf->nf_mark =3D NULL;
        return nf;
 }

Before above patch, this OOPS happen as below

Task A
                                  Task B

nfs_read
                                nfs_read
      nfsd_file_acquire
                               nfsd_file_acquire
          __set_bit(NFSD_FILE_HASHED, &nf->nf_flags)
             nf =3D nfsd_file_find_locked();



wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING);
            since rcu_assign_pointer has barrier in
hlist_add_head_rcu, but before smp_store_release in which
            two __set_bit can cross update rcu hlist head pointer
(first), so Task B wait_on_bit didn't wait, just go below:


                                                 *pnf =3D nf;

                                        file =3D nf->nf_file

                                        file->f_op->splice_read  *OOPS
here in nfs_read!

I also found similar issue at here https://lkml.org/lkml/2023/1/4/880

Since this  patch can fix this issue, I discard my commit
Very glad to receive your reply.
Thanks a lot!

Regards,
Haodong Wong

> What kernel are you targeting with your patch?  It doesn't apply to
> mainline, but looks like it might to 6.0.  The oops message is from
> 5.10.104.  Maybe that is where you want a fix?
>
The target is before kernel 6.1

> I assume you want this fix to go to a -stable kernel?  It would be good
> to identify which upstream patch fixed the problem, then either backport
> that, or explain why something simpler is needed.
>


> >
> > Task A:                         Task B:
> >
> > nfsd_file_acquire:
> >
> >                           new =3D nfsd_file_alloc()
> >                           open_file:
> >                           refcount_inc(&nf->nf_ref);
>
> The key step in Task A is
>         hlist_add_head_rcu(&nf->nf_node,
>                  &nfsd_file_hashtbl[hashval].nfb_head);
>
> Until that completes, nfsd_file_find_locked() cannot find the new file.
> hlist_add_head_rcu() uses "rcu_assign_pointer()" which should include
> all the barriers needed.
>
> >                                  nf =3D nfsd_file_find_locked();
> >                                  wait_for_construction:
> >
> >                                  since nf_flags is zero it will not wai=
t
> >
> >                                  wait_on_bit(&nf->nf_flags,
> >                                                     NFSD_FILE_PENDING);
> >
> >                                 if (status =3D=3D nfs_ok) {
> >                                      *pnf =3D nf;      //OOPS happen!
>
> The oops message suggests that after nfsd_read() calls
> nfsd_file_acquire() there is no error, but nf is NULL.
> So the  nf->nf_file access causes the oops.  nf_file is at offset
> 0x28, which is the virtual address mentioned in the oops.
>
> So do you think 'nf' is NULL at this point where you write "OOPS
> happen!" ??

Sorry, something missing, it oops happened in nfs_read after
nfsd_file_acquire *pnf =3D nf, because it copy nf_file is still NULL as
above

> I cannot see how that might happen even if wait_on_bit() didn't
> actually wait.
>
> Maybe if you could explain if a bit more detail what you think is
> happening.  What exactly is NULL which causes the OOPS, and how exactly
> does it end up being NULL.
> I cannot see what might be the cause, but the oops makes it clear that
> it did happen.
>
> Also is this a pure 5.10.104 kernel, or are there other patches on it?
>
It is applied with PREEMPT_RT Patch

> Thanks,
> NeilBrown

>
>
>
> >
> > Unable to handle kernel NULL pointer at virtual address 000000000000002=
8
> > Mem abort info:
> >   ESR =3D 0x96000004
> >   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> >   SET =3D 0, FnV =3D 0
> >   EA =3D 0, S1PTW =3D 0
> > Data abort info:
> >   ISV =3D 0, ISS =3D 0x00000004
> >   CM =3D 0, WnR =3D 0
> > user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000152546000
> > [0000000000000028] pgd=3D0000000000000000, p4d=3D0000000000000000
> > Internal error: Oops: 96000004 [#1] PREEMPT_RT SMP
> > CPU: 7 PID: 1767 Comm: nfsd Not tainted 5.10.104 #1
> > pstate: 40c00005 (nZcv daif +PAN +UAO -TCO BTYPE=3D--)
> > pc : nfsd_read+0x78/0x280 [nfsd]
> > lr : nfsd_read+0x68/0x280 [nfsd]
> > sp : ffff80001c0b3c70
> > x29: ffff80001c0b3c70 x28: 0000000000000000
> > x27: 0000000000000002 x26: ffff0000c8a3ca70
> > x25: ffff0000c8a45180 x24: 0000000000002000
> > x23: ffff0000c8a45178 x22: ffff0000c8a45008
> > x21: ffff0000c31aac40 x20: ffff0000c8a3c000
> > x19: 0000000000000000 x18: 0000000000000001
> > x17: 0000000000000007 x16: 00000000b35db681
> > x15: 0000000000000156 x14: ffff0000c3f91300
> > x13: 0000000000000000 x12: 0000000000000000
> > x11: 0000000000000000 x10: 0000000000000000
> > x9 : 0000000000000000 x8 : ffff000118014a80
> > x7 : 0000000000000002 x6 : ffff0002559142dc
> > x5 : ffff0000c31aac40 x4 : 0000000000000004
> > x3 : 0000000000000001 x2 : 0000000000000000
> > x1 : 0000000000000001 x0 : ffff000255914280
> > Call trace:
> >  nfsd_read+0x78/0x280 [nfsd]
> >  nfsd3_proc_read+0x98/0xc0 [nfsd]
> >  nfsd_dispatch+0xc8/0x160 [nfsd]
> >  svc_process_common+0x440/0x790
> >  svc_process+0xb0/0xd0
> >  nfsd+0xfc/0x160 [nfsd]
> >  kthread+0x17c/0x1a0
> >  ret_from_fork+0x10/0x18
> >
> > Signed-off-by: Haodong Wong <haydenw.kernel@gmail.com>
> > ---
> >  fs/nfsd/filecache.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index e30e1ddc1ace..ba980369e6b4 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -974,8 +974,12 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> >       nfsd_file_slab_free(&new->nf_rcu);
> >
> >  wait_for_construction:
> > +     /* In case of set bit NFSD_FILE_PENDING and NFSD_FILE_HASHED reor=
der */
> > +     smp_rmb();
> >       wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBL=
E);
> >
> > +     /* Be a paire of smp_mb after clear bit NFSD_FILE_PENDING */
> > +     smp_mb__after_atomic();
> >       /* Did construction of this file fail? */
> >       if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> >               if (!retry) {
> > @@ -1018,8 +1022,11 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> >       nf =3D new;
> >       /* Take reference for the hashtable */
> >       refcount_inc(&nf->nf_ref);
> > -     __set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
> >       __set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
> > +     /* Ensure set bit order set NFSD_FILE_HASHED after set NFSD_FILE_=
PENDING */
> > +     smp_wmb();
> > +     __set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
> > +
> >       list_lru_add(&nfsd_file_lru, &nf->nf_lru);
> >       hlist_add_head_rcu(&nf->nf_node, &nfsd_file_hashtbl[hashval].nfb_=
head);
> >       ++nfsd_file_hashtbl[hashval].nfb_count;
> > --
> > 2.25.1
> >
> >
>
