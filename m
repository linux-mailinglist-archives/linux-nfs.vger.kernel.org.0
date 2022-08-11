Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB02258FD55
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Aug 2022 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiHKNYD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Aug 2022 09:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiHKNYC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Aug 2022 09:24:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CCF81696
        for <linux-nfs@vger.kernel.org>; Thu, 11 Aug 2022 06:24:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x21so22943174edd.3
        for <linux-nfs@vger.kernel.org>; Thu, 11 Aug 2022 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qg+PG03DTXPyQyDK8lq5ohI2IgdB/CC7V/w3loiHFG4=;
        b=HDDlBfrLDgoUJJjIrCY/IUOiUWYSCDirKdgFalcTAWAL5PEt6uiDmYMD3xgJ+PI8o3
         Zra+NnUKfRUPLCgVSZYwmkTrCl4GNqsxKskQjunwhn9BHLKU9QZWCW4VJ+Bs+3vw80mo
         RNnJamKxolo24GJyHGC4XjTRhWLxYvuD7UNIRegfOTsxNCGqmaMSljjpG38eNT+071zh
         XoCfoS2Y8wPJZUBLwdyjbxBQwkLuB822C6CMf+YLIte+QEGmmDQrfVRIfC+YRAyvrD/K
         PXbZ6Gy0Vhf6emFtiAbuUbIx8U8tzPcODIhbsIS6QfVzaEzNxM8gfOzl5rCvxM4qvLnT
         T/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qg+PG03DTXPyQyDK8lq5ohI2IgdB/CC7V/w3loiHFG4=;
        b=Z2KvLIMba+a5jCgcShcjdg/Wzq1682QI1CNLqKTtV8lEYcNT9+lwzb97cxZJr3oLZW
         wpip516Bjjxc58tCylXfojjyCA/S56NIEyQjS+ejkWg7rIxKrCfwEdyuuUb7nAolt44m
         ThvrSy5cQXu3GaJp5WreQvrFfoYemC4vUHvDxXN/XRJGSS0E4rbSErPBXYWZrnENlbpv
         tCDeH7YJPJ3XjUlWPjtuC0wYc6DNLgqbvRaP45rFlkzEIfg6WhkqBnsHnZKri3FgXVZi
         kOZRo73f0I3d+HIXBco4Evw54hc5XSutyImNJhcN4Q7HG/w2LlmPaAs1BBhIYPw5TpXk
         Wo1Q==
X-Gm-Message-State: ACgBeo1FcLXi0SspR9kL7MdPoW3ZBvS6i0hqN0lTcu/uZBeeJU5taopW
        rkub5depIdOynr5HJrrvB/MgtA1hz9Oq8GW97o8=
X-Google-Smtp-Source: AA6agR6oTODWf9DQZJBO8R3tmMaWbTKB0WBxUx/2TsObOajuwh1FpkVaZEuq+2uKihEQGVnlIa7gbdvO+vINxfnRLEQ=
X-Received: by 2002:a05:6402:5216:b0:43e:81c5:82dd with SMTP id
 s22-20020a056402521600b0043e81c582ddmr31552408edd.345.1660224239899; Thu, 11
 Aug 2022 06:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyFLDrUMaTTi8ECTrKkAxxSdXGPEweGj8sQk5yW-vkmJ5g@mail.gmail.com>
 <bba793f649cf4d5955f0ea3311a57ca0d15b2938.camel@kernel.org> <CAN-5tyFtjC1utV_GMXepF79mHTZb4y3LJjttoWbC2O9-Qs4EcA@mail.gmail.com>
In-Reply-To: <CAN-5tyFtjC1utV_GMXepF79mHTZb4y3LJjttoWbC2O9-Qs4EcA@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 11 Aug 2022 09:23:48 -0400
Message-ID: <CAN-5tyHCuiKuhHLNJNPQZ0G_k8kGVzFraASVNKBpiPJjERqwLw@mail.gmail.com>
Subject: Re: help with nfsd kernel oops
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
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

On Thu, Aug 11, 2022 at 9:09 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Thu, Aug 11, 2022 at 6:45 AM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Wed, 2022-08-10 at 20:50 -0400, Olga Kornievskaia wrote:
> > > Hi folks (Chuck/Jeff specifically),
> > >
> > > We've had this outstanding kernel oops that happens (infrequently) in
> > > copy_offload testing (stack trace in the end). I've been trying to
> > > debug it for a while, added printks and such. I can hand-wavey explain
> > > what I'm seeing but I need help (a) nailing down exactly the problem
> > > and (b) get a helpful hint how to address it?
> > >
> > > Ok so what happens. Test case: source file is opened, locked,
> > > (blah-blah destination file), copy_notify to the source server, copy
> > > is done (src dest), source file unlocked (etc dest file), files
> > > closed. Copy/Copy_notify, uses a locking stateid.
> > >
> > > When unlocking happens it triggers LOCKU and FREE_STATEID. Copy_notify
> > > stateid is associated with the locking stateid on the server. When the
> > > last reference on the locking stateid goes nfs4_put_stateid() also
> > > calls nfs4_free_cpntf_statelist() which deals with cleaning up the
> > > copy_notify stateid.
> > >
> > > In the laundry thread, there is a failsafe that if for some reason the
> > > copy_notify state was not cleaned up/expired, then it would be deleted
> > > there.
> > >
> > > However in the failing case, where everything should be cleaned up as
> > > it's supposed to be, instead I see calling to put_ol_stateid_locked()
> > > (before FREE_STATEID is processed) which cleans up the parent but
> > > doesn't touch the copy_notify stateids so instead the laundry thread
> > > runs and walks the copy_notify list (since it's not empty) and tries
> > > to free the entries but that leads to this oops (since part of the
> > > memory was freed by put_ol_stateid_locked() and parent stateid)?.
> > >
> > > Perhaps the fix is to add the  nfs4_free_cpntf_statelist() to
> > > put_ol_stateid_locked() which I tried and it seems to work. But I'm
> > > not confident about it.
> > >
> > > Thoughts?
> > >
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index fa67ecd5fe63..b988d3c4e5fd 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -1408,6 +1408,7 @@ static void put_ol_stateid_locked(struct
> > > nfs4_ol_stateid *stp,
> > >         }
> > >
> > >         idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> > > +       nfs4_free_cpntf_statelist(clp->net, s);
> > >         list_add(&stp->st_locks, reaplist);
> > >  }
> > >
> > >
> > >
> > > [  338.681529] ------------[ cut here ]------------
> > > [  338.683090] kernel BUG at lib/list_debug.c:53!
> > > [  338.684372] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> > > [  338.685977] CPU: 1 PID: 493 Comm: kworker/u256:27 Tainted: G    B
> > >           5.19.0-rc6+ #104
> > > [  338.688266] Hardware name: VMware, Inc. VMware Virtual
> > > Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> > > [  338.691019] Workqueue: nfsd4 laundromat_main [nfsd]
> > > [  338.692224] RIP: 0010:__list_del_entry_valid.cold.3+0x3d/0x53
> > > [  338.693626] Code: 0b 4c 89 e1 4c 89 ee 48 c7 c7 e0 1a e3 8f e8 5b
> > > 60 fe ff 0f 0b 48 89 e9 4c 89 ea 48 89 de 48 c7 c7 60 1a e3 8f e8 44
> > > 60 fe ff <0f> 0b 48 89 ea 48 89 de 48 c7 c7 00 1a e3 8f e8 30 60 fe ff
> > > 0f 0b
> > > [  338.697651] RSP: 0018:ffff88800d03fc68 EFLAGS: 00010286
> > > [  338.698762] RAX: 000000000000006d RBX: ffff888028a14798 RCX: 0000000000000000
> > > [  338.700442] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffffffff917e9240
> > > [  338.702257] RBP: ffff88801bb0ae90 R08: ffffed100a795f0e R09: ffffed100a795f0e
> > > [  338.704016] R10: ffff888053caf86b R11: ffffed100a795f0d R12: ffff88801bb0ae90
> > > [  338.705703] R13: d9c0013300000a39 R14: 000000000000005a R15: ffff88801b9f5800
> > > [  338.707510] FS:  0000000000000000(0000) GS:ffff888053c80000(0000)
> > > knlGS:0000000000000000
> > > [  338.709319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  338.710715] CR2: 00005640baab74d0 CR3: 0000000017574005 CR4: 00000000001706e0
> > > [  338.712282] Call Trace:
> > > [  338.712898]  <TASK>
> > > [  338.713430]  _free_cpntf_state_locked+0x6b/0x120 [nfsd]
> > > [  338.714806]  nfs4_laundromat+0x8ef/0xf30 [nfsd]
> > > [  338.716013]  ? dequeue_entity+0x18b/0x6c0
> > > [  338.716970]  ? release_lock_stateid+0x60/0x60 [nfsd]
> > > [  338.718169]  ? _raw_spin_unlock+0x15/0x30
> > > [  338.719064]  ? __switch_to+0x2fa/0x690
> > > [  338.719879]  ? __schedule+0x67d/0xf20
> > > [  338.720678]  laundromat_main+0x15/0x40 [nfsd]
> > > [  338.721760]  process_one_work+0x3b4/0x6b0
> > > [  338.722629]  worker_thread+0x5a/0x640
> > > [  338.723425]  ? process_one_work+0x6b0/0x6b0
> > > [  338.724324]  kthread+0x162/0x190
> > > [  338.725030]  ? kthread_complete_and_exit+0x20/0x20
> > > [  338.726074]  ret_from_fork+0x22/0x30
> > > [  338.726856]  </TASK>
> >
> > Does the kernel you're testing have Dai's patch that he posted on August
> > 1st?
> >
> >     [PATCH v2] NFSD: fix use-after-free on source server when doing inter-server copy
> >
> > This sounds very similar to the problem he was fixing.
>
> I'm testing upstream (5.19-rc6 Chuck's based) for both source and
> destination server.

Oh, I missed that thread entirely (will be reading it now). I'll try
Dai's patch but I think our approaches differ.

>
> > --
> > Jeff Layton <jlayton@kernel.org>
