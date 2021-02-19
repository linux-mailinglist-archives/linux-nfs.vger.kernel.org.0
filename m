Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01B531FFF5
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 21:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBSUn7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 15:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBSUn6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 15:43:58 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547AFC061786;
        Fri, 19 Feb 2021 12:43:18 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id q10so12022599edt.7;
        Fri, 19 Feb 2021 12:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lSeaVrPeec4ECCwg6LalvxT8Ul5o3kLa4g87FbTgMo=;
        b=AayP6dQplefJBvCcBH4ZndVdTFYoJO3Xm8kt0i050nWPTynJc5l8zm6GNFOBCu/W4B
         pEHXun27IdajNtUxAx8d3mk/jQ9L1uQ2x0Xwm6le5QkRQJ87QHWhgTfulAUP6a4cKpnX
         dxTpBwHAOSzWE2kFOlhft2of+drgRtQhP8bJawkfkIQ81I9EcXvBpH1YdhvJqosKliSc
         rREdeaYHJdfBDSW0xvRTeER/5RBH1mzj5xwFudbQCUKykm0bHIvC5uBpeaJhBnBZ9z3V
         EkzVqhhpBhI9EgBiTuLCk86dd/leSajS64V+M12jnGMdGVGqfwGuYkW+ur5qXYdal7yS
         CUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lSeaVrPeec4ECCwg6LalvxT8Ul5o3kLa4g87FbTgMo=;
        b=r0ARrYkN7q/vL1QpIVOTYHcsLS02S7Q2FOR81q2oDxTHW1BYvmalSqflD47ZLDggZg
         4yrNYDRiaGE/41+7H5w6dstVqPxjqVA55qCF5L8AjdnZG/yYranpaU5IDFDofrEHR0LB
         HCO5F99ffZ7la60BazkERShLwHdVToRhJByrJvLVGXvUlcsllCIZeuy8vSagYS2aPK5q
         iF0e5hJgR5+IHOk4rcR2vW/QIASq+QQR3/BTWTFawXrkoFx1oJgsKfVCXoPiMOS2BRCq
         JvAALFa4SRv4uxdzWHLQ3x2Uf8HD84ooYRSA7b/qFxHjtNzw5f2CRUMxDPi7DwqDZekH
         4zLQ==
X-Gm-Message-State: AOAM5338/Wq9VzNxZK30ruzeL/a7RejZ4UY88vL0PKX6vU5Z0MwOuKOj
        xefFU9b2hZl8cSwpJrYYidwXp+5+2yddBlOGmnvMAbDFwzc=
X-Google-Smtp-Source: ABdhPJzrrhhhKCYHZ8dMRTcbwjA+OY+qGOEDIBZvzxhq53CStri3xjUGowF/255e3PhnPvt5BDfJoP7Xex2us2IZgx4=
X-Received: by 2002:aa7:d98f:: with SMTP id u15mr11053067eds.267.1613767397014;
 Fri, 19 Feb 2021 12:43:17 -0800 (PST)
MIME-Version: 1.0
References: <57f67888-160f-891c-6217-69e174d7e42b@rothenpieler.org>
 <CAN-5tyE4OyNOZRXGnyONcdGsHaRAF39LSE5416Kj964m-+_C2A@mail.gmail.com>
 <81cb9aef-c10d-f11c-42c0-5144ee2608bc@rothenpieler.org> <0e49471c-e640-a331-c7b4-4e0a49a7a967@rothenpieler.org>
 <CAN-5tyG9Ly9tqKxguFNhg_PGXCxE2=Zn6LQPLY59twdVkD3Auw@mail.gmail.com>
 <51a8caa7-52c2-8155-10a7-1e8d21866924@rothenpieler.org> <CAN-5tyFT4+kkqk6E0Jxe-vMYm7q5mHyTeq0Ht7AEYasA30ZaGw@mail.gmail.com>
 <3f946e6b-6872-641c-8828-35ddd5c8fed0@rothenpieler.org> <e89ab742-7984-6a2c-2f01-402283ba6e89@rothenpieler.org>
 <CAN-5tyGhyh0ZF77voaN4TNgMt+jSUG0PMp-KixfTvgUhDdhDUQ@mail.gmail.com>
 <def12560-2481-b17d-5a42-7236edbd5392@rothenpieler.org> <CAN-5tyHLRn4HEs9R291N6Y=boOvQ9-qvKfJzA8Khkqie2kVVWQ@mail.gmail.com>
 <6478B738-0C33-46DC-B711-B0BF7069FD82@oracle.com> <19c74710-bf35-6412-dd06-071331419ab5@rothenpieler.org>
 <E4BAC726-2FFA-47A8-A1B6-F0D2848ABB98@oracle.com>
In-Reply-To: <E4BAC726-2FFA-47A8-A1B6-F0D2848ABB98@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 19 Feb 2021 15:43:05 -0500
Message-ID: <CAN-5tyHq-1SM8o-qpeF-_UGd0a74ky8Atcam=gY9HqUrMhfp_g@mail.gmail.com>
Subject: Re: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Timo Rothenpieler <timo@rothenpieler.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 19, 2021 at 1:48 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Feb 19, 2021, at 1:01 PM, Timo Rothenpieler <timo@rothenpieler.org> wrote:
> >
> > On 19.02.2021 18:48, Chuck Lever wrote:
> >>> On Feb 19, 2021, at 12:38 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >>>
> >>> On Thu, Feb 18, 2021 at 3:22 PM Timo Rothenpieler <timo@rothenpieler.org> wrote:
> >>>>
> >>>> On 18.02.2021 19:30, Olga Kornievskaia wrote:
> >>>>> Thank you for getting tracepoints from a busy server but can you get
> >>>>> more? As suspected, the server is having issues sending the callback.
> >>>>> I'm not sure why. Any chance to turn on the server's sunrpc
> >>>>> tracespoints, probably both sunrpc and rdmas tracepoints, I wonder if
> >>>>> we can any more info about why it's failing?
> >>>>
> >>>> I isolated out two of the machines on that cluster now, one acting as
> >>>> NFS server from an ext4 mount, the other is the same client as before.
> >>>> That way I managed to capture a trace and ibdump of an entire cycle:
> >>>> mount + successful copy + 5 minutes later a copy that got stuck
> >>>>
> >>>> Next to no noise happened during those traces, you can find them attached.
> >>>>
> >>>> Another observation made due to this: unmount and re-mounting the NFS
> >>>> share also gets it back into working condition for a while, no reboot
> >>>> necessary.
> >>>> During this trace, I got "lucky", and after just 5 minutes of waiting,
> >>>> it got stuck.
> >>>>
> >>>> Before that, I had a run of mount + trying to copy every 5 minutes where
> >>>> it ran for 45 minutes without getting stuck. At which point I decided to
> >>>> remount once more.
> >>>
> >>> Timo, thank you for gathering the debug info.
> >>>
> >>> Chuck, I need your help. Why would the server lose a callback channel?
> >>>
> >>>           <...>-1461944 [001] 2076465.200151: rpc_request:
> >>> task:57752@6 nfs4_cbv1 CB_OFFLOAD (async)
> >>>           <...>-1461944 [001] 2076465.200151: rpc_task_run_action:
> >>> task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >>> runstate=RUNNING|ACTIVE status=0 action=call_reserve
> >>>           <...>-1461944 [001] 2076465.200154: xprt_reserve:
> >>> task:57752@6 xid=0x00a0aaf9
> >>>           <...>-1461944 [001] 2076465.200155: rpc_task_run_action:
> >>> task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >>> runstate=RUNNING|ACTIVE status=0 action=call_reserveresult
> >>>           <...>-1461944 [001] 2076465.200156: rpc_task_run_action:
> >>> task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >>> runstate=RUNNING|ACTIVE status=0 action=call_refresh
> >>>           <...>-1461944 [001] 2076465.200163: rpc_task_run_action:
> >>> task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >>> runstate=RUNNING|ACTIVE status=0 action=call_refreshresult
> >>>           <...>-1461944 [001] 2076465.200163: rpc_task_run_action:
> >>> task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >>> runstate=RUNNING|ACTIVE status=0 action=call_allocate
> >>>           <...>-1461944 [001] 2076465.200168: rpc_buf_alloc:
> >>> task:57752@6 callsize=548 recvsize=104 status=0
> >>>           <...>-1461944 [001] 2076465.200168: rpc_task_run_action:
> >>> task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >>> runstate=RUNNING|ACTIVE status=0 action=call_encode
> >>>           <...>-1461944 [001] 2076465.200173: rpc_task_run_action:
> >>> task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >>> runstate=RUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=0
> >>> action=call_connect
> >>>           <...>-1461944 [001] 2076465.200174: rpc_call_rpcerror:
> >>> task:57752@6 tk_status=-107 rpc_status=-107
> >>>           <...>-1461944 [001] 2076465.200174: rpc_task_run_action:
> >>> task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >>> runstate=RUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=-107
> >>> action=rpc_exit_task
> >>>
> >>> It's reporting ENOTCON. I'm not really sure if this is related to copy
> >>> offload but more perhaps doing callbacks over RDMA/IB.
> >> If the client is awaiting a COPY notification callback, I can see why
> >> a lost CB channel would cause the client to wait indefinitely.
> >> The copy mechanism has to deal with this contingency... Perhaps the
> >> server could force a disconnect so that the client and server have an
> >> opportunity to re-establish the callback channel. <shrug>
> >> In any event, the trace log above shows nothing more than "hey, it's
> >> not working." Are there any rpcrdma trace events we can look at to
> >> determine why the backchannel is getting lost?
> >
> > The trace log attached to my previous mail has it enabled, along with nfsd and sunrpc.
> > I'm attaching the two files again here.
>
> Thanks, Timo.
>
> The first CB_OFFLOAD callback succeeds:
>
> 2076155.216687: nfsd_cb_work:         addr=10.110.10.252:0 client 602eb645:daa037ae procedure=CB_OFFLOAD
> 2076155.216704: rpc_request:          task:57746@6 nfs4_cbv1 CB_OFFLOAD (async)
>
> 2076155.216975: rpc_stats_latency:    task:57746@6 xid=0xff9faaf9 nfs4_cbv1 CB_OFFLOAD backlog=33 rtt=195 execute=282
> 2076155.216977: nfsd_cb_done:         addr=10.110.10.252:0 client 602eb645:daa037ae status=0
>
>
> About 305 seconds later, the autodisconnect timer fires. I'm not sure if this is the backchannel transport, but it looks suspicious:
>
> 2076460.314954: xprt_disconnect_auto: peer=[10.110.10.252]:0 state=LOCKED|CONNECTED|BOUND
> 2076460.314957: xprt_disconnect_done: peer=[10.110.10.252]:0 state=LOCKED|CONNECTED|BOUND
>
>
> The next CB_OFFLOAD callback fails because the xprt has been marked "disconnected" and the request's NOCONNECT flag is set.
>
> 2076465.200136: nfsd_cb_work:         addr=10.110.10.252:0 client 602eb645:daa037ae procedure=CB_OFFLOAD
> 2076465.200151: rpc_request:          task:57752@6 nfs4_cbv1 CB_OFFLOAD (async)
>
> 2076465.200168: rpc_task_run_action:  task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT runstate=RUNNING|ACTIVE status=0 action=call_encode
> 2076465.200173: rpc_task_run_action:  task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT runstate=RUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=0 action=call_connect
> 2076465.200174: rpc_call_rpcerror:    task:57752@6 tk_status=-107 rpc_status=-107
> 2076465.200174: rpc_task_run_action:  task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT runstate=RUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=-107 action=rpc_exit_task
> 2076465.200179: nfsd_cb_done:         addr=10.110.10.252:0 client 602eb645:daa037ae status=-107
> 2076465.200180: nfsd_cb_state:        addr=10.110.10.252:0 client 602eb645:daa037ae state=FAULT
>
>
> Perhaps RPC clients for NFSv4.1+ callback should be created with
> the RPC_CLNT_CREATE_NO_IDLE_TIMEOUT flag.

Do you know if this callback behavior is new? The same problem would
exist with delegation recalls.

>
>
> --
> Chuck Lever
>
>
>
