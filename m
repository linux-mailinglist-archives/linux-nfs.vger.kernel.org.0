Return-Path: <linux-nfs+bounces-196-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33BB7FEEB0
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 13:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8AB281B1C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 12:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57D645C02;
	Thu, 30 Nov 2023 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ImkDuXNZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706A1D46
	for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 04:15:35 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4b28354a249so303242e0c.2
        for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 04:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1701346534; x=1701951334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M61bJMFcEoPmZwdh+zExToswuuNacooU7Mgdyy9VbVk=;
        b=ImkDuXNZ7PAaksxD7cjSwvUGRVOY5P9QMlN0bwOwMYcEiXJnCCRIBniVm2nYpI1Xb2
         3xaswJj9XQhOMwVQKypo/ZfVr86px1pFRgLue70hF4lYi2arf4wHgwMczSh2FDaRM+RS
         PyisvfTA9N+vBDAmwt+HgLRSx2UZKOGzzAwALPgFnc7SayRMZ65miQbPTDOq0MKb/55A
         /2K5XUewaaKAzjD7kmZs2BcjC13+//zOT03HO2EVo7rnAMZT6Wi7rotYNIsVU1Pd44Dz
         y+HCk0NItTcP8+3az0EzRvSf7a+tftKKqZ7qt3+Y418ZCieAGXghDGkW3XvWEn3XQqNA
         8iAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701346534; x=1701951334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M61bJMFcEoPmZwdh+zExToswuuNacooU7Mgdyy9VbVk=;
        b=JTKWMH9sh6jRb6V7EgdLVCmTwJ5XnOZF8gSuiUztlvjI3iWKQyXQWEqtfF8hFaSMlO
         GyNVcaZSLroRBQYIG4LeHxHBJjtxqSLy1iDMxHMtE8QDJlTIg8VWsuxJAUFZ22PPBKl4
         QCdsMhgOBnlM0CHx9w9nl9aAqtu2m7fqrJu0KXIYEHbr1g9T6z4+XcT5Rx9QmPvU37w8
         xjQW5jHhSmtup5A0p42hTC4IZjL0+8HN2JuXo2F68Nlpj3eKo81wuiNs1zQSz3SbyQ/I
         uIoR3eQGJCrLKbIJniosxvJVpcpmOXUVtnoh9/8I8m0NoCFGP/9YCrKj3cL0qi8wGzGo
         lkZQ==
X-Gm-Message-State: AOJu0YywkmpSloZmDnRBMTQOH5gUM56ei2tL+JmwY5WPX/Xx/czsXFg1
	9hoAxbYGQOR3Vm+O0CodyQMf8p9hBzXadPx3vmdjd9DLGBDhn/3tBos=
X-Google-Smtp-Source: AGHT+IHPabZKTDDXwTcSKIkEvfnr3XmDLEDQrQATuqTFW2BX8WeHedcshhSSAdoYN3nnlsrNC2DI9+694trRrfl9ri0=
X-Received: by 2002:a05:6122:794:b0:4b2:a40b:87df with SMTP id
 k20-20020a056122079400b004b2a40b87dfmr856163vkr.15.1701346534529; Thu, 30 Nov
 2023 04:15:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMyEAb9XbL55taNXD_MrTxJz62s6ByDWiK8m1Nxj1_G3pg-M6A@mail.gmail.com>
 <ZWg7gGnvVOYjIhx1@archie.me>
In-Reply-To: <ZWg7gGnvVOYjIhx1@archie.me>
From: "Sukruth Sridharan (he/him)" <susridharan@purestorage.com>
Date: Thu, 30 Nov 2023 17:45:23 +0530
Message-ID: <CAMyEAb9aAMwKByOx38VJP1+N0+d12sDF5FiEx-aCMdOnEF_sww@mail.gmail.com>
Subject: Re: Hung task panic as part of NFS RDMA Disconnect due to possible
 bug on 6.2.0-34-generic client
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Network File System <linux-nfs@vger.kernel.org>, Linux RDMA <linux-rdma@vger.kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The issue has been seen once in the past few weeks.
Unfortunately, we're yet to see a repro of the same.
We will try to repro it on the latest kernel.
Curious if there's any improvements gone in that you suspect would
have resolved the issue?

Thanks,
Sukruth


On Thu, Nov 30, 2023 at 1:06=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Thu, Nov 30, 2023 at 10:52:59AM +0530, Sukruth Sridharan (he/him) wrot=
e:
> > I notice the following hung task panic on 6.2.0-34 kernel during RDMA d=
isconnect
> >
> > [Wed Nov  1 08:03:54 2023] INFO: task kworker/u16:5:2274646 blocked
> > for more than 120 seconds.
> > [Wed Nov  1 08:03:55 2023]       Tainted: G        W  OE
> > 6.2.0-34-generic #34-Ubuntu
> > [Wed Nov  1 08:03:55 2023] "echo 0 >
> > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [Wed Nov  1 08:03:55 2023] task:kworker/u16:5   state:D stack:0
> > pid:2274646 ppid:2      flags:0x00004000
> > [Wed Nov  1 08:03:55 2023] Workqueue: xprtiod xprt_autoclose [sunrpc]
> > [Wed Nov  1 08:03:55 2023] Call Trace:
> > [Wed Nov  1 08:03:55 2023]  <TASK>
> > [Wed Nov  1 08:03:55 2023]  __schedule+0x2aa/0x610
> > [Wed Nov  1 08:03:55 2023]  schedule+0x63/0x110
> > [Wed Nov  1 08:03:55 2023]  schedule_timeout+0x157/0x170
> > [Wed Nov  1 08:03:55 2023]  wait_for_completion+0x88/0x150
> > [Wed Nov  1 08:03:55 2023]  rpcrdma_xprt_disconnect+0x33f/0x350 [rpcrdm=
a]
> > [Wed Nov  1 08:03:55 2023]  xprt_rdma_close+0x12/0x40 [rpcrdma]
> > [Wed Nov  1 08:03:55 2023]  xprt_autoclose+0x5c/0x120 [sunrpc]
> > [Wed Nov  1 08:03:55 2023]  process_one_work+0x225/0x430
> > [Wed Nov  1 08:03:55 2023]  worker_thread+0x50/0x3e0
> > [Wed Nov  1 08:03:55 2023]  ? __pfx_worker_thread+0x10/0x10
> > [Wed Nov  1 08:03:55 2023]  kthread+0xe9/0x110
> > [Wed Nov  1 08:03:55 2023]  ? __pfx_kthread+0x10/0x10
> > [Wed Nov  1 08:03:55 2023]  ret_from_fork+0x2c/0x50
> > [Wed Nov  1 08:03:55 2023]  </TASK>
> >
> > The flow which induced the bug is as follows:
> > 1. Client initiates connection
> > 2. Server hands off the response to the first RPC on the connection to
> > the NIC (Mellanox ConnectX-5)
> > 3. NIC tries to send the response around 6 times and fails the response=
 with RNR
> > 4. Client issues disconnect (possibly because it didn't receive a respo=
nse)
> > 5. Server cleans up the connection state
> > 6. Client runs into the above panic as part of disconnect while drainin=
g the IOs
> >
> > It looks like re_receiving is set only in rpcrdma_post_recvs, and the
> > reason why it wouldn't be reset is if memory-region allocation code
> > fails.
> > That is possible if disconnect on the client somehow blocks allocation.
> >
> > void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool t=
emp)
> > {
> >         // ... (some initialization code)
> >
> >     if (atomic_inc_return(&ep->re_receiving) > 1)
> >         goto out;
> >
> >         // ... (some allocation code)
> >
> >     if (!wr) // <<<<<<<<<<<<<<<<<< PROBLEM HERE >>>>>>>>>>>>>>>>>>>
> >         goto out;
> >
> >         // ... (post recv code, and some error handling)
> >
> >     if (atomic_dec_return(&ep->re_receiving) > 0)
> >         complete(&ep->re_done);
> >
> > out:
> >     trace_xprtrdma_post_recvs(r_xprt, count);
> >     ep->re_receive_count +=3D count;
> >     return;
> > }
> >
> > static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
> > {
> >     struct rpcrdma_ep *ep =3D r_xprt->rx_ep;
> >     struct rdma_cm_id *id =3D ep->re_id;
> >
> >     /* Wait for rpcrdma_post_recvs() to leave its critical
> >      * section.
> >      */
> >     if (atomic_inc_return(&ep->re_receiving) > 1) //
> > <<<<<<<<<<<<<<<<<<< This is not reset, so wait gets stuck
> > >>>>>>>>>>>>>>>>>
> >         wait_for_completion(&ep->re_done);
> >
> >     /* Flush Receives, then wait for deferred Reply work
> >      * to complete.
> >      */
> >     ib_drain_rq(id->qp);
> >
> >     /* Deferred Reply processing might have scheduled
> >      * local invalidations.
> >      */
> >     ib_drain_sq(id->qp);
> >
> >     rpcrdma_ep_put(ep);
> > }
> >
> > Can you help conclude if the above theory around the bug being in the
> > client code is right? If not, can you help with steps/data points
> > required to debug this further?
> >
>
> Can you verify that the bug still occurs with latest vanilla kernel
> (currently v6.7-rc3)?
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara

