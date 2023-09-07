Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7616C797EAD
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Sep 2023 00:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjIGWZr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Sep 2023 18:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjIGWZr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Sep 2023 18:25:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E891BC6
        for <linux-nfs@vger.kernel.org>; Thu,  7 Sep 2023 15:25:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 698171F747;
        Thu,  7 Sep 2023 22:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694125541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s6NUCsx7zjr85OcOsClYrUGJYknP65kimroZB0vKYUE=;
        b=UM1snRskm3CQT6x2hKgj0qW/rRJyTbDsJSM6jHIEMV6JhyxyGsTREpkV8CXffnykkIZzFZ
        ll9JX9IAsr0+hZ9le38O1OhSVa1clMOhStHr1VQ2Wa9UXYHx1d+AVX69rfMtw58I7lxpOf
        BepYbB67pOARI9AESBDnXdtIGb+OkLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694125541;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s6NUCsx7zjr85OcOsClYrUGJYknP65kimroZB0vKYUE=;
        b=omjRAOAStAD9mH8zbnunrV1AdzYxJ6zJNiM9JFFIPYH/AQUV8P6YT95mRGD0LOzfkSfI9z
        AtyDx6wajLmQ4UCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D189E138FA;
        Thu,  7 Sep 2023 22:25:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DE9/IONN+mSANAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 07 Sep 2023 22:25:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Christian Brauner" <brauner@kernel.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: BUG_ON() hit in sunrpc
In-reply-to: <EA6B6884-C189-4E70-B1C8-1FDE3D982B99@oracle.com>
References: <20230905-netzzugang-kubikmeter-6437d53204a2@brauner>,
 <615A8DB3-F931-4EFC-A6EC-CC4DA3766D7A@oracle.com>,
 <0B563F93-A30A-4BFD-BBAE-F712F8011E04@oracle.com>,
 <169412075594.22057.580928756094478654@noble.neil.brown.name>,
 <EA6B6884-C189-4E70-B1C8-1FDE3D982B99@oracle.com>
Date:   Fri, 08 Sep 2023 08:25:36 +1000
Message-id: <169412553623.22057.2407417994833945901@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 08 Sep 2023, Chuck Lever III wrote:
>=20
> > On Sep 7, 2023, at 5:05 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Fri, 08 Sep 2023, Chuck Lever III wrote:
> >>=20
> >>> On Sep 5, 2023, at 11:01 AM, Chuck Lever III <chuck.lever@oracle.com> w=
rote:
> >>>=20
> >>>> On Sep 5, 2023, at 10:54 AM, Christian Brauner <brauner@kernel.org> wr=
ote:
> >>>>=20
> >>>> Hey,
> >>>>=20
> >>>> I just tried to test some changes which had commit
> >>>> 99d99825fc07 ("Merge tag 'nfs-for-6.6-1' of git://git.linux-nfs.org/pr=
ojects/anna/linux-nfs")
> >>>> as base and when I booted with the appended config I saw a splat right=
 at boot:
> >>>>=20
> >>>> [   92.804377][ T5306] kernel BUG at net/sunrpc/svc.c:581!
> >=20
> > The most likely cause for this BUG_ON that I can see is if the
> > svc_set_num_threads() call in nfsd_svc() fails.
> >=20
> > Either some listening sockets had previously been created via
> > write_ports(), or they have just been created in nfsd_startup_net().
> > ->sv_nrthreads is 0 and this is an attempt to increase that.
> > However the thread creation fails - presumably ENOMEM.
> > So we goto out_shutdown, stepping right over the nfsd_shutdown_net()
> > ca..
> > Then the svc_put() calls (probably two, as keep_active was probably
> > set).  result in the kref reaching zero and svc_destroy() being called
> > even though there are still sockets present (because nfsd_shutdown_net()
> > was skipped).
> >=20
> > I tried
> > - error =3D svc_set_num_threads(serv, NULL, nrservs);
> > + error =3D -ENOMEM; //svc_set_num_threads(serv, NULL, nrservs);
> > if (error)
> > goto out_shutdown;
> >=20
> > and I get exactly the same BUG_ON() as you got.
>=20
> Christian, can you provide the arguments your system uses for
> rpc.nfsd? I'm not sure which distribution you're using, so I
> can't provide the exact steps. /etc/nfs.conf is one place to
> look.

I'd also be interested in what the changes you were testing were, and
whether they might cause a memory allocation failure.  If the BUG_ON
is reproducible, can you check if the is a memory allocation failure,
and which one?

>=20
> Neil, do we really need a BUG_ON for this assertion? I'm
> considering making it a simple pr_warn(). Interested in
> opinions.

Maybe replace the BUG_ON() will a call to svc_xprt_destroy_all() and
maybe svc_rpcb_cleanup().

>=20
> Past that, obviously input checking is missing here, so the
> error flows in nfsd_svc() need improvement.
Like:
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 5e455ced0711..f2c4e62e4591 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -819,12 +819,12 @@ nfsd_svc(int nrservs, struct net *net, const struct cre=
d *cred)
 	if (error)
 		goto out_shutdown;
 	error =3D serv->sv_nrthreads;
-	if (error =3D=3D 0)
-		nfsd_last_thread(net);
 out_shutdown:
 	if (error < 0 && !nfsd_up_before)
 		nfsd_shutdown_net(net);
 out_put:
+	if (serv->sv_nrthreads =3D=3D 0)
+		nfsd_last_thread(net);
 	/* Threads now hold service active */
 	if (xchg(&nn->keep_active, 0))
 		svc_put(serv);
 ??

NeilBrown


>=20
>=20
> > NeilBrown
> >=20
> >=20
> >>>> [   92.811194][ T5306] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> >>>> [   92.821472][ T5306] CPU: 6 PID: 5306 Comm: rpc.nfsd Tainted: G
> >>>> [   92.828578][ T5306] Hardware name: QEMU Standard PC (Q35 + ICH9, 20=
09)/LXD, BIOS unknown 2/2/2022
> >>>> [   92.836319][ T5306] RIP: 0010:svc_destroy+0x206/0x270
> >>>> [   92.852006][ T5306] Code: 72 49 8b bc 24 a0 00 00 00 e8 a6 a3 5e f8=
 48 8b 3c 24 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f e9 8f a3 5e f8 e8 aa d=
f 1c f8 <0f> 0b e8 a3 df 1c f8 0f 0b 4c 89 ff e8 39 03 79 f8 e9 ae fe ff ff
> >>>> [   92.867075][ T5306] RSP: 0018:ffffc9000a347b60 EFLAGS: 00010293
> >>>> [   92.872714][ T5306] RAX: 0000000000000000 RBX: ffff88813abf5c68 RCX=
: 0000000000000000
> >>>> [   92.884809][ T5306] RDX: ffff888126c38000 RSI: ffffffff896bcf46 RDI=
: 0000000000000005
> >>>> [   92.894190][ T5306] RBP: 00000000fffffff4 R08: 0000000000000005 R09=
: 0000000000000000
> >>>> [   92.900512][ T5306] R10: 0000000000000000 R11: 0000000000000000 R12=
: ffff88813abf5c50
> >>>> [   92.907935][ T5306] R13: ffff88813abf5c50 R14: ffff88813abf5c00 R15=
: ffff8881183c8000
> >>>> [   92.917264][ T5306] FS:  00007fabf0bba740(0000) GS:ffff8883a9100000=
(0000) knlGS:0000000000000000
> >>>> [   92.924880][ T5306] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> >>>> [   92.930358][ T5306] CR2: 00005568a27d60e8 CR3: 00000001737c3000 CR4=
: 0000000000750ee0
> >>>> [   92.937465][ T5306] DR0: 0000000000000000 DR1: 0000000000000000 DR2=
: 0000000000000000
> >>>> [   92.943057][ T5306] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7=
: 0000000000000400
> >>>> [   92.948673][ T5306] PKRU: 55555554
> >>>> [   92.953452][ T5306] Call Trace:
> >>>> [   92.958082][ T5306]  <TASK>
> >>>> [   92.962546][ T5306]  ? show_regs+0x94/0xa0
> >>>> [   92.967221][ T5306]  ? die+0x3b/0xb0
> >>>> [   92.971702][ T5306]  ? do_trap+0x231/0x410
> >>>> [   92.976275][ T5306]  ? svc_destroy+0x206/0x270
> >>>> [   92.980717][ T5306]  ? do_error_trap+0xf9/0x230
> >>>> [   92.985287][ T5306]  ? svc_destroy+0x206/0x270
> >>>> [   92.989693][ T5306]  ? handle_invalid_op+0x34/0x40
> >>>> [   92.994044][ T5306]  ? svc_destroy+0x206/0x270
> >>>> [   92.998317][ T5306]  ? exc_invalid_op+0x2d/0x40
> >>>> [   93.002503][ T5306]  ? asm_exc_invalid_op+0x1a/0x20
> >>>> [   93.006701][ T5306]  ? svc_destroy+0x206/0x270
> >>>> [   93.010766][ T5306]  ? svc_destroy+0x206/0x270
> >>>> [   93.014727][ T5306]  nfsd_svc+0x6d4/0xac0
> >>>> [   93.018510][ T5306]  write_threads+0x296/0x4e0
> >>>> [   93.022298][ T5306]  ? write_filehandle+0x760/0x760
> >>>> [   93.026072][ T5306]  ? simple_transaction_get+0xf8/0x140
> >>>> [   93.029819][ T5306]  ? preempt_count_sub+0x150/0x150
> >>>> [   93.033456][ T5306]  ? do_raw_spin_lock+0x133/0x2c0
> >>>> [   93.037013][ T5306]  ? _copy_from_user+0x5d/0xf0
> >>>> [   93.040385][ T5306]  ? write_filehandle+0x760/0x760
> >>>> [   93.043610][ T5306]  nfsctl_transaction_write+0x100/0x180
> >>>> [   93.046900][ T5306]  vfs_write+0x2a9/0xe40
> >>>> [   93.049930][ T5306]  ? export_features_open+0x60/0x60
> >>>> [   93.053124][ T5306]  ? kernel_write+0x6c0/0x6c0
> >>>> [   93.056116][ T5306]  ? do_sys_openat2+0xb6/0x1e0
> >>>> [   93.059167][ T5306]  ? build_open_flags+0x690/0x690
> >>>> [   93.062197][ T5306]  ? __fget_light+0x201/0x270
> >>>> [   93.065020][ T5306]  ksys_write+0x134/0x260
> >>>> [   93.067775][ T5306]  ? __ia32_sys_read+0xb0/0xb0
> >>>> [   93.070501][ T5306]  ? rcu_is_watching+0x12/0xb0
> >>>> [   93.073073][ T5306]  ? trace_irq_enable.constprop.0+0xd0/0x100
> >>>> [   93.075937][ T5306]  do_syscall_64+0x38/0xb0
> >>>> [   93.078394][ T5306]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >>>>=20
> >>>> I haven't spent time debugging this further. Maybe you see the issue r=
ight
> >>>> away.
> >>>=20
> >>> I don't, unfortunately. A bisect would be appropriate.
> >>>=20
> >>> I will pull today's master branch and see if I can reproduce.
> >>=20
> >> I wasn't able to reproduce this with yesterday's master. I don't
> >> recall anything in Anna's NFS client PR that might account for
> >> this crash.
> >>=20
> >> Neil, I think you were the last person to touch the code in and
> >> around svc_destroy(). Can you have a look at this?
> >>=20
> >>=20
> >>>> This problem is only happening after the nfs merges afaict. I'm
> >>>> currently using commit 3ef96fcfd50b ("Merge tag 'ext4_for_linus-6.6-rc=
1'
> >>>> of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4") as base
> >>>> and that splat doesn't appear.
> >>>>=20
> >>>> Hopefully this is not a red herring.
> >>>> Christian
> >>>> <.config.txt>
> >>>=20
> >>> --
> >>> Chuck Lever
> >>=20
> >>=20
> >> --
> >> Chuck Lever
> >>=20
> >>=20
> >>=20
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

