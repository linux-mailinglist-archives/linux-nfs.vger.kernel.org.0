Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778557B06EA
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 16:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjI0OdS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjI0OdS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 10:33:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD343F3
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 07:33:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3B4C433C8
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695825196;
        bh=uFg/UcDHVkoMxvpMof+HKq4HJucI4BiOWXTAqDLc8g0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=khK13IZYGs7CYNG2g9IrgnlmjyHt9p6ESl4Ba/fqBHve1gDo1QtHP2KdDkgTlMMrh
         rSqImMxvbASB7aDovvz6ynTlZ7vzjrXTo+3Ul6cYztqeB2LTpqdRLqCweqKlvU7rS/
         lZogwVMqT84ScO++rUP6xD4e1mQ73jtwMhulR6JbF+FSRAZZDhNhxbY7x4WBuyV+Of
         2U17eQb3AugVN2yTg6ppILdq/I0hSh00wc8zxZcdmxzOu8JA6i3wIjQBNxjY5hsjbz
         FQB7pP82SBk7vskO2ncnkkp+97jvpc22EDSGdyjEME53jzpRVJgkknbla/DL9AQF3v
         ArHdwDKEGVX2w==
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-41808baf6abso58591541cf.3
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 07:33:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YxD94gPInKQLtnoQEtddWy4m1HrGSaivCg40n/UEIcdsP1q4Gci
        H3q3tEBqZTCqFU4yPr7PDRBy4J3IcdK6m+fQt7I=
X-Google-Smtp-Source: AGHT+IEEZ7Nr/b6g+gxBaXAtjDadHghrDu7twWIpbeFYQQ++Z6Ci3TuslIIsIPoZUR5dOLnDENtaZEf9BlYyjiOaJyU=
X-Received: by 2002:a05:622a:296:b0:417:a095:60ab with SMTP id
 z22-20020a05622a029600b00417a09560abmr2290492qtw.50.1695825195549; Wed, 27
 Sep 2023 07:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230926210322.184335-1-anna@kernel.org> <188347CB-B870-4C6B-8E16-4D9C854A5CCC@oracle.com>
In-Reply-To: <188347CB-B870-4C6B-8E16-4D9C854A5CCC@oracle.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Wed, 27 Sep 2023 10:32:59 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfm8sJk2QkY9T7KLM9HnhTdUo9ij5uxeZ8GqHbwGtuct0w@mail.gmail.com>
Message-ID: <CAFX2Jfm8sJk2QkY9T7KLM9HnhTdUo9ij5uxeZ8GqHbwGtuct0w@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC/TLS: Lock the lower_xprt during the tls handshake
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 26, 2023 at 5:17=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Sep 26, 2023, at 5:03 PM, Anna Schumaker <anna@kernel.org> wrote:
> >
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > Otherwise we run the risk of having the lower_xprt freed from underneat=
h
> > us, causing an oops that looks like this:
> >
> > [  224.150698] BUG: kernel NULL pointer dereference, address: 000000000=
0000018
> > [  224.150951] #PF: supervisor read access in kernel mode
> > [  224.151117] #PF: error_code(0x0000) - not-present page
> > [  224.151278] PGD 0 P4D 0
> > [  224.151361] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [  224.151499] CPU: 2 PID: 99 Comm: kworker/u10:6 Not tainted 6.6.0-rc3=
-g6465e260f487 #41264 a00b0960990fb7bc6d6a330ee03588b67f08a47b
> > [  224.151977] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 unknown 2/2/2022
> > [  224.152216] Workqueue: xprtiod xs_tcp_tls_setup_socket [sunrpc]
> > [  224.152434] RIP: 0010:xs_tcp_tls_setup_socket+0x3cc/0x7e0 [sunrpc]
> > [  224.152643] Code: 00 00 48 8b 7c 24 08 e9 f3 01 00 00 48 83 7b c0 00=
 0f 85 d2 01 00 00 49 8d 84 24 f8 05 00 00 48 89 44 24 10 48 8b 00 48 89 c5=
 <4c> 8b 68 18 66 41 83 3f 0a 75 71 45 31 ff 4c 89 ef 31 f6 e8 5c 76
> > [  224.153246] RSP: 0018:ffffb00ec060fd18 EFLAGS: 00010246
> > [  224.153427] RAX: 0000000000000000 RBX: ffff8c06c2e53e40 RCX: 0000000=
000000001
> > [  224.153652] RDX: ffff8c073bca2408 RSI: 0000000000000282 RDI: ffff8c0=
6c259ee00
> > [  224.153868] RBP: 0000000000000000 R08: ffffffff9da55aa0 R09: 0000000=
000000001
> > [  224.154084] R10: 00000034306c30f1 R11: 0000000000000002 R12: ffff8c0=
6c2e51800
> > [  224.154300] R13: ffff8c06c355d400 R14: 0000000004208160 R15: ffff8c0=
6c2e53820
> > [  224.154521] FS:  0000000000000000(0000) GS:ffff8c073bd00000(0000) kn=
lGS:0000000000000000
> > [  224.154763] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  224.154940] CR2: 0000000000000018 CR3: 0000000062c1e000 CR4: 0000000=
000750ee0
> > [  224.155157] PKRU: 55555554
> > [  224.155244] Call Trace:
> > [  224.155325]  <TASK>
> > [  224.155395]  ? __die_body+0x68/0xb0
> > [  224.155507]  ? page_fault_oops+0x34c/0x3a0
> > [  224.155635]  ? _raw_spin_unlock_irqrestore+0xe/0x40
> > [  224.155793]  ? exc_page_fault+0x7a/0x1b0
> > [  224.155916]  ? asm_exc_page_fault+0x26/0x30
> > [  224.156047]  ? xs_tcp_tls_setup_socket+0x3cc/0x7e0 [sunrpc ae3a15912=
ae37fd51dafbdbc2dbd069117f8f5c8]
> > [  224.156367]  ? xs_tcp_tls_setup_socket+0x2fe/0x7e0 [sunrpc ae3a15912=
ae37fd51dafbdbc2dbd069117f8f5c8]
> > [  224.156697]  ? __pfx_xs_tls_handshake_done+0x10/0x10 [sunrpc ae3a159=
12ae37fd51dafbdbc2dbd069117f8f5c8]
> > [  224.157013]  process_scheduled_works+0x24e/0x450
> > [  224.157158]  worker_thread+0x21c/0x2d0
> > [  224.157275]  ? __pfx_worker_thread+0x10/0x10
> > [  224.157409]  kthread+0xe8/0x110
> > [  224.157510]  ? __pfx_kthread+0x10/0x10
> > [  224.157628]  ret_from_fork+0x37/0x50
> > [  224.157741]  ? __pfx_kthread+0x10/0x10
> > [  224.157859]  ret_from_fork_asm+0x1b/0x30
> > [  224.157983]  </TASK>
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
> I don't have any quibbles with this. Thanks!

Great! I'm putting together another client bugfixes pull request for
6.6, so I'll plan to include it in that!

Anna

>
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com <mailto:chuck.lever@orac=
le.com>>
>
>
> > ---
> > net/sunrpc/xprtsock.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> >
> > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > index 71cd916e384f..a15bf2ede89b 100644
> > --- a/net/sunrpc/xprtsock.c
> > +++ b/net/sunrpc/xprtsock.c
> > @@ -2672,6 +2672,10 @@ static void xs_tcp_tls_setup_socket(struct work_=
struct *work)
> > rcu_read_lock();
> > lower_xprt =3D rcu_dereference(lower_clnt->cl_xprt);
> > rcu_read_unlock();
> > +
> > + if (wait_on_bit_lock(&lower_xprt->state, XPRT_LOCKED, TASK_KILLABLE))
> > + goto out_unlock;
> > +
> > status =3D xs_tls_handshake_sync(lower_xprt, &upper_xprt->xprtsec);
> > if (status) {
> > trace_rpc_tls_not_started(upper_clnt, upper_xprt);
> > @@ -2681,6 +2685,7 @@ static void xs_tcp_tls_setup_socket(struct work_s=
truct *work)
> > status =3D xs_tcp_tls_finish_connecting(lower_xprt, upper_transport);
> > if (status)
> > goto out_close;
> > + xprt_release_write(lower_xprt, NULL);
> >
> > trace_rpc_socket_connect(upper_xprt, upper_transport->sock, 0);
> > if (!xprt_test_and_set_connected(upper_xprt)) {
> > @@ -2702,6 +2707,7 @@ static void xs_tcp_tls_setup_socket(struct work_s=
truct *work)
> > return;
> >
> > out_close:
> > + xprt_release_write(lower_xprt, NULL);
> > rpc_shutdown_client(lower_clnt);
> >
> > /* xprt_force_disconnect() wakes tasks with a fixed tk_status code.
> > --
> > 2.42.0
> >
>
> --
> Chuck Lever
>
>
