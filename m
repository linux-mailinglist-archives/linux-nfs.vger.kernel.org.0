Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AEA31FE0B
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 18:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBSRjx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 12:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhBSRjw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 12:39:52 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FE9C061756;
        Fri, 19 Feb 2021 09:39:11 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id u20so14238400ejb.7;
        Fri, 19 Feb 2021 09:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OkgIU4hSFcSCqAzQ5o5DHejRV17VOf8Art5rBjH2a3E=;
        b=HqIwhpR8YAwOi1dMUErTJcL/1fys1z5Y5jIt7YF2PGebKp2vzYOQT2M23RBhB6FgOk
         fRH2cIEPKkOgNx9qulKY/JL6RrZ4jTkMAilNavqkvcK2UrOgM6PDsp5qjvIdtEOfbP+u
         BrL0yaLjJVvOYjtG4GU+IWRaKI8T2suN1knZz2stvJIUaqPgXwekG8z/0juZwZnXCPwn
         cJqH5hcwSQWJMr4YDl+ypZF+ZIGunmBJn7QjZ/JC8qv582R2xCIYpoipX6IYK5ZQ2cop
         mFv+kdpMbB+Z53S/SxPzZaolZgy1T8/kZZvIAWr9rh5OIeP6YdFZs/ClfSf6U/hWUMyR
         +x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OkgIU4hSFcSCqAzQ5o5DHejRV17VOf8Art5rBjH2a3E=;
        b=rKaEAKmfSrMoER/qgPXtFgN/fsdH+CBoQzQTVIG+KJgeEzqxUY4twhmNKYBvalU7VA
         u5H4OMZpEu2D1fdJIrsrimEgreV8AbgD9/vYD8NY7lfGqzp/yC/DwZTsIOyVMc2h2kGU
         fsk5uhGwiVXph+AZOqUCirlQGHTw6wV4H1Jtk5ITClYtfii5VXpBgzn6xUkR9mrTI30Y
         I3rk4GQRtY0F7k8o7iuYOAa7tPOraIh/4YW605F37g7oy//FM3bZdbkjt/1rCelPuY+Q
         NkFuVp0PSF15YWtsi4BOUY72zM8po21dWRe7bCLb/lBX1EH/5kYA0QCMeGG1h5bsY00g
         aBlg==
X-Gm-Message-State: AOAM532/f4NQToBHCcDwnYivpOB9svUtytMrAEYLCfOP/mW4zjwSLoOT
        KWJqCfbCq1x2CcB4xgJnNktN4HdYPUlllY8c8c8=
X-Google-Smtp-Source: ABdhPJxf+62pk2/M9y+O2i3OKhy9ACmOMBP+l7zlqJ9vGXpl4N2tZI48wjBPrYnal8bp53KA8eyXlquPBYwIrKpU66Y=
X-Received: by 2002:a17:906:c08e:: with SMTP id f14mr10217597ejz.388.1613756349840;
 Fri, 19 Feb 2021 09:39:09 -0800 (PST)
MIME-Version: 1.0
References: <57f67888-160f-891c-6217-69e174d7e42b@rothenpieler.org>
 <CAN-5tyE4OyNOZRXGnyONcdGsHaRAF39LSE5416Kj964m-+_C2A@mail.gmail.com>
 <81cb9aef-c10d-f11c-42c0-5144ee2608bc@rothenpieler.org> <0e49471c-e640-a331-c7b4-4e0a49a7a967@rothenpieler.org>
 <CAN-5tyG9Ly9tqKxguFNhg_PGXCxE2=Zn6LQPLY59twdVkD3Auw@mail.gmail.com>
 <51a8caa7-52c2-8155-10a7-1e8d21866924@rothenpieler.org> <CAN-5tyFT4+kkqk6E0Jxe-vMYm7q5mHyTeq0Ht7AEYasA30ZaGw@mail.gmail.com>
 <3f946e6b-6872-641c-8828-35ddd5c8fed0@rothenpieler.org> <e89ab742-7984-6a2c-2f01-402283ba6e89@rothenpieler.org>
 <CAN-5tyGhyh0ZF77voaN4TNgMt+jSUG0PMp-KixfTvgUhDdhDUQ@mail.gmail.com> <def12560-2481-b17d-5a42-7236edbd5392@rothenpieler.org>
In-Reply-To: <def12560-2481-b17d-5a42-7236edbd5392@rothenpieler.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 19 Feb 2021 12:38:58 -0500
Message-ID: <CAN-5tyHLRn4HEs9R291N6Y=boOvQ9-qvKfJzA8Khkqie2kVVWQ@mail.gmail.com>
Subject: Re: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
To:     Timo Rothenpieler <timo@rothenpieler.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 18, 2021 at 3:22 PM Timo Rothenpieler <timo@rothenpieler.org> wrote:
>
> On 18.02.2021 19:30, Olga Kornievskaia wrote:
> > Thank you for getting tracepoints from a busy server but can you get
> > more? As suspected, the server is having issues sending the callback.
> > I'm not sure why. Any chance to turn on the server's sunrpc
> > tracespoints, probably both sunrpc and rdmas tracepoints, I wonder if
> > we can any more info about why it's failing?
>
> I isolated out two of the machines on that cluster now, one acting as
> NFS server from an ext4 mount, the other is the same client as before.
> That way I managed to capture a trace and ibdump of an entire cycle:
> mount + successful copy + 5 minutes later a copy that got stuck
>
> Next to no noise happened during those traces, you can find them attached.
>
> Another observation made due to this: unmount and re-mounting the NFS
> share also gets it back into working condition for a while, no reboot
> necessary.
> During this trace, I got "lucky", and after just 5 minutes of waiting,
> it got stuck.
>
> Before that, I had a run of mount + trying to copy every 5 minutes where
> it ran for 45 minutes without getting stuck. At which point I decided to
> remount once more.

Timo, thank you for gathering the debug info.

Chuck, I need your help. Why would the server lose a callback channel?

           <...>-1461944 [001] 2076465.200151: rpc_request:
task:57752@6 nfs4_cbv1 CB_OFFLOAD (async)
           <...>-1461944 [001] 2076465.200151: rpc_task_run_action:
task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
runstate=RUNNING|ACTIVE status=0 action=call_reserve
           <...>-1461944 [001] 2076465.200154: xprt_reserve:
task:57752@6 xid=0x00a0aaf9
           <...>-1461944 [001] 2076465.200155: rpc_task_run_action:
task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
runstate=RUNNING|ACTIVE status=0 action=call_reserveresult
           <...>-1461944 [001] 2076465.200156: rpc_task_run_action:
task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
runstate=RUNNING|ACTIVE status=0 action=call_refresh
           <...>-1461944 [001] 2076465.200163: rpc_task_run_action:
task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
runstate=RUNNING|ACTIVE status=0 action=call_refreshresult
           <...>-1461944 [001] 2076465.200163: rpc_task_run_action:
task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
runstate=RUNNING|ACTIVE status=0 action=call_allocate
           <...>-1461944 [001] 2076465.200168: rpc_buf_alloc:
task:57752@6 callsize=548 recvsize=104 status=0
           <...>-1461944 [001] 2076465.200168: rpc_task_run_action:
task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
runstate=RUNNING|ACTIVE status=0 action=call_encode
           <...>-1461944 [001] 2076465.200173: rpc_task_run_action:
task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
runstate=RUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=0
action=call_connect
           <...>-1461944 [001] 2076465.200174: rpc_call_rpcerror:
task:57752@6 tk_status=-107 rpc_status=-107
           <...>-1461944 [001] 2076465.200174: rpc_task_run_action:
task:57752@6 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
runstate=RUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=-107
action=rpc_exit_task

It's reporting ENOTCON. I'm not really sure if this is related to copy
offload but more perhaps doing callbacks over RDMA/IB.
