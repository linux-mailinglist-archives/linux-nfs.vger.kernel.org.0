Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060E759121E
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Aug 2022 16:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiHLOXZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Aug 2022 10:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHLOXY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Aug 2022 10:23:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69AF9C52E
        for <linux-nfs@vger.kernel.org>; Fri, 12 Aug 2022 07:23:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gb36so2282592ejc.10
        for <linux-nfs@vger.kernel.org>; Fri, 12 Aug 2022 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=I80XlA9qYcpNbLl+w7V0SnmQdGiGJXIBAK+ZUAQY/Ho=;
        b=Vn9Z7sZTWkohDf+vMRXvUlFGtfX1fn+6iATzaqARYOQrp2y5p6CXv6hBLve2YTedbM
         AEEHrTZB/KJDEFrLgGUWQ0r05T8lo2QJ4WGTaFOHi9bwX3oH+leb7yIjuNjUPMt97Uy5
         5q60jxZEl8KAG84qISYZ7n3yDkDO3OCERcWQSrx2N5EKjmMg6z21LkQ8kh5H15tmBaua
         zHd40N92gVDfiP+vb4Z/fqvSL9pSjSUwhKO55XlR9yadft4S04KhK7WsQEV2jf0g3A9z
         BbwGWNofMX7D6JvR6HEF6BgFgN2YzQUPUbeEelWtmIm0v0hLbiI5RTEsJdYdnHFGq+WC
         /d7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=I80XlA9qYcpNbLl+w7V0SnmQdGiGJXIBAK+ZUAQY/Ho=;
        b=QkcTzDnMzQhvZ4WUJQv0m6Jc5/gQdohjiXfILNnvy81+Rmlm3qn0aMulN9Dsa3Dd4M
         SmymI1Gebrrep/+qQXQkvDP13iPVbcZFIZJ63cjO09ANRXYT9Hyvl6uOD3sLtk7T8ppd
         32oYT4gChFr0DN8WP6DgQtyBYk1jbyUggAqke2vAVwwfYImvE3p4AxPaRRPCYjptO1rU
         yFqMdjJuaItZjmNEmFwLGGha6k3yCvE0iYVbbeVb8Im/rE+ey06DCa1xWD2HwFUKEE5z
         Bl2ftPoDJBp2WLM255z8e1dE0UINMIn9zT/lEfjUT40KvKysdM73ul5G7xXey+M8kPei
         MxDw==
X-Gm-Message-State: ACgBeo02CMstff10SKLeeygpZGef0nfU545eN0mYjMGf29XjEXJiT25o
        QVOTjeow54CZEoxm7n/24reZlOCfl3ncfJvy0ekxuIQt
X-Google-Smtp-Source: AA6agR5sAt++ZoGJCfOo5sD0VEMxohH+dq1HZrRVg2u2QqXsgtHgZBoVfTJaKMJezGbPBQPOosQl9PV/n1eSBhv3q1o=
X-Received: by 2002:a17:907:1c93:b0:730:c9c3:f6f8 with SMTP id
 nb19-20020a1709071c9300b00730c9c3f6f8mr2975810ejc.17.1660314201131; Fri, 12
 Aug 2022 07:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyFLDrUMaTTi8ECTrKkAxxSdXGPEweGj8sQk5yW-vkmJ5g@mail.gmail.com>
 <ac641c57-2153-b2a3-a48b-0433dc6102da@oracle.com>
In-Reply-To: <ac641c57-2153-b2a3-a48b-0433dc6102da@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 12 Aug 2022 10:23:09 -0400
Message-ID: <CAN-5tyFv+fPQ4T1HzWUAs7OcGvz_FyrAsAWwK8X=yu6yxP+Tcw@mail.gmail.com>
Subject: Re: help with nfsd kernel oops
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 11, 2022 at 9:34 PM <dai.ngo@oracle.com> wrote:
>
> On 8/10/22 5:50 PM, Olga Kornievskaia wrote:
> > Hi folks (Chuck/Jeff specifically),
> >
> > We've had this outstanding kernel oops that happens (infrequently) in
> > copy_offload testing (stack trace in the end). I've been trying to
> > debug it for a while, added printks and such. I can hand-wavey explain
> > what I'm seeing but I need help (a) nailing down exactly the problem
> > and (b) get a helpful hint how to address it?
> >
> > Ok so what happens. Test case: source file is opened, locked,
> > (blah-blah destination file), copy_notify to the source server, copy
> > is done (src dest), source file unlocked (etc dest file), files
> > closed. Copy/Copy_notify, uses a locking stateid.
> >
> > When unlocking happens it triggers LOCKU and FREE_STATEID. Copy_notify
> > stateid is associated with the locking stateid on the server. When the
> > last reference on the locking stateid goes nfs4_put_stateid() also
> > calls nfs4_free_cpntf_statelist() which deals with cleaning up the
> > copy_notify stateid.
> >
> > In the laundry thread, there is a failsafe that if for some reason the
> > copy_notify state was not cleaned up/expired, then it would be deleted
> > there.
> >
> > However in the failing case, where everything should be cleaned up as
> > it's supposed to be, instead I see calling to put_ol_stateid_locked()
> > (before FREE_STATEID is processed) which cleans up the parent but
> > doesn't touch the copy_notify stateids so instead the laundry thread
> > runs and walks the copy_notify list (since it's not empty) and tries
> > to free the entries but that leads to this oops (since part of the
> > memory was freed by put_ol_stateid_locked() and parent stateid)?.
> >
> > Perhaps the fix is to add the  nfs4_free_cpntf_statelist() to
> > put_ol_stateid_locked() which I tried and it seems to work. But I'm
> > not confident about it.
> >
> > Thoughts?
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index fa67ecd5fe63..b988d3c4e5fd 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1408,6 +1408,7 @@ static void put_ol_stateid_locked(struct
> > nfs4_ol_stateid *stp,
> >          }
> >
> >          idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> > +       nfs4_free_cpntf_statelist(clp->net, s);
> >          list_add(&stp->st_locks, reaplist);
> >   }
> >
> >
> In the use-after-free scenario, the copy_state is inserted on the
> sc_cp_list of the lock state.
>
> So when put_ol_stateid_locked is called from nfsd4_close_open_stateid,
> with your proposed patch, nfs4_free_cpntf_statelist does not remove
> any copy_state since 's' is the open state.

i dont know about all the cases but i'm 100% certain that "s" is there
a locking state (in linux client using nfstest_ssc). Since i've tested
it and it works and i have heavy debugging added to knfsd tracking all
the pointers of copy_notify stateids and its parents.

> Also put_ol_stateid_locked can return without calling idr_remove
> and nfs4_free_cpntf_statelist (your proposed fix).
>
> -Dai
>
> >
> >
> > [  338.681529] ------------[ cut here ]------------
> > [  338.683090] kernel BUG at lib/list_debug.c:53!
> > [  338.684372] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> > [  338.685977] CPU: 1 PID: 493 Comm: kworker/u256:27 Tainted: G    B
> >            5.19.0-rc6+ #104
> > [  338.688266] Hardware name: VMware, Inc. VMware Virtual
> > Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> > [  338.691019] Workqueue: nfsd4 laundromat_main [nfsd]
> > [  338.692224] RIP: 0010:__list_del_entry_valid.cold.3+0x3d/0x53
> > [  338.693626] Code: 0b 4c 89 e1 4c 89 ee 48 c7 c7 e0 1a e3 8f e8 5b
> > 60 fe ff 0f 0b 48 89 e9 4c 89 ea 48 89 de 48 c7 c7 60 1a e3 8f e8 44
> > 60 fe ff <0f> 0b 48 89 ea 48 89 de 48 c7 c7 00 1a e3 8f e8 30 60 fe ff
> > 0f 0b
> > [  338.697651] RSP: 0018:ffff88800d03fc68 EFLAGS: 00010286
> > [  338.698762] RAX: 000000000000006d RBX: ffff888028a14798 RCX: 0000000000000000
> > [  338.700442] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffffffff917e9240
> > [  338.702257] RBP: ffff88801bb0ae90 R08: ffffed100a795f0e R09: ffffed100a795f0e
> > [  338.704016] R10: ffff888053caf86b R11: ffffed100a795f0d R12: ffff88801bb0ae90
> > [  338.705703] R13: d9c0013300000a39 R14: 000000000000005a R15: ffff88801b9f5800
> > [  338.707510] FS:  0000000000000000(0000) GS:ffff888053c80000(0000)
> > knlGS:0000000000000000
> > [  338.709319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  338.710715] CR2: 00005640baab74d0 CR3: 0000000017574005 CR4: 00000000001706e0
> > [  338.712282] Call Trace:
> > [  338.712898]  <TASK>
> > [  338.713430]  _free_cpntf_state_locked+0x6b/0x120 [nfsd]
> > [  338.714806]  nfs4_laundromat+0x8ef/0xf30 [nfsd]
> > [  338.716013]  ? dequeue_entity+0x18b/0x6c0
> > [  338.716970]  ? release_lock_stateid+0x60/0x60 [nfsd]
> > [  338.718169]  ? _raw_spin_unlock+0x15/0x30
> > [  338.719064]  ? __switch_to+0x2fa/0x690
> > [  338.719879]  ? __schedule+0x67d/0xf20
> > [  338.720678]  laundromat_main+0x15/0x40 [nfsd]
> > [  338.721760]  process_one_work+0x3b4/0x6b0
> > [  338.722629]  worker_thread+0x5a/0x640
> > [  338.723425]  ? process_one_work+0x6b0/0x6b0
> > [  338.724324]  kthread+0x162/0x190
> > [  338.725030]  ? kthread_complete_and_exit+0x20/0x20
> > [  338.726074]  ret_from_fork+0x22/0x30
> > [  338.726856]  </TASK>
