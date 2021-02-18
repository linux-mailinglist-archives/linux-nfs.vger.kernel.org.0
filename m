Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024A931EF20
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Feb 2021 20:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhBRTAo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Feb 2021 14:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhBRSdL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Feb 2021 13:33:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EE6C061222;
        Thu, 18 Feb 2021 10:30:15 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h10so5584738edl.6;
        Thu, 18 Feb 2021 10:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+smuLYtbr/pzemzJUHohUAfEz52XBhtosdIvQ0wrqg8=;
        b=p8U5MG0k3+1HciOGF7IZXB+1Wnmt8sThOBtsc0rYJgvhVlKrlqvMVko/Hj/SnS3kEe
         24LN2WWbsMx6Gj5hNuRh8+s1MOJLrS5ZE5SQHWHY4KC0HX87TXqKVllySxp2JFWU7tbo
         7vJ0aEW6cAj+vl3AvWqPo67XCbyw4p4dE756IRSZMU5GlF3shHDbJSRMUYASzD/DSqg8
         zMTo9XCZzxz3rJI8WMzQbZttmjCxZwASkZ/YWB4WcpMr4LSZzuikOwwp5yieJCjbO/LO
         uJlxFStZ97uy5DynkS739xvrw1hnBBCzOC3cYSE1Nzfb4HfxPTaTCjDnkAseNcaJNRvw
         2QIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+smuLYtbr/pzemzJUHohUAfEz52XBhtosdIvQ0wrqg8=;
        b=Q3TJQCaQmeeTPl48B+zYyW8cV7I/OFQBhTp5A7RMBVBAWObJ4lgQSkc8PuwDFe8rIc
         u625CRS0vCcGfsr73BYLkwu0BifY/OC/jbO6tC7tytYoIjBJTPaCQ/TMpokj0bmCdBJj
         qdVkCOa/r2DwFzmvSmxU3T87YXqEvhf/gYBqtHZR7PMEXsYUdHeTEbE9Fzxg5sgVSEdG
         w/jyu78zd1jDCRnE9afIbdZigCCuIjTSLxT2AxJI2/c4XrBnWNwnTaVu5NWZzzqWlyzT
         9It/Ot+sy/Wp4DRBQZgcOwnBusNRS/tpIF3/55CxnmMjj4Dib3hb6zUzW05IbhuRgbZ5
         Us7g==
X-Gm-Message-State: AOAM532lFBtBwpJmcpt1+El+Tl7DmkoveYrMtcBa3KsR3+zhOmjiRZFL
        61G4zkuhy6seWlkLLFQ59Kbv2L+ZXAOm0dZ0RVk=
X-Google-Smtp-Source: ABdhPJyf3ejHIWkfPUgk6HLgxVDu8fNZiyGqobWsyDibisA6N7HUoBpBe/cTXXUHsOGb+Ht6+jThj1fg7X72BM8Rpos=
X-Received: by 2002:a05:6402:10c3:: with SMTP id p3mr5331883edu.67.1613673014085;
 Thu, 18 Feb 2021 10:30:14 -0800 (PST)
MIME-Version: 1.0
References: <57f67888-160f-891c-6217-69e174d7e42b@rothenpieler.org>
 <CAN-5tyE4OyNOZRXGnyONcdGsHaRAF39LSE5416Kj964m-+_C2A@mail.gmail.com>
 <81cb9aef-c10d-f11c-42c0-5144ee2608bc@rothenpieler.org> <0e49471c-e640-a331-c7b4-4e0a49a7a967@rothenpieler.org>
 <CAN-5tyG9Ly9tqKxguFNhg_PGXCxE2=Zn6LQPLY59twdVkD3Auw@mail.gmail.com>
 <51a8caa7-52c2-8155-10a7-1e8d21866924@rothenpieler.org> <CAN-5tyFT4+kkqk6E0Jxe-vMYm7q5mHyTeq0Ht7AEYasA30ZaGw@mail.gmail.com>
 <3f946e6b-6872-641c-8828-35ddd5c8fed0@rothenpieler.org> <e89ab742-7984-6a2c-2f01-402283ba6e89@rothenpieler.org>
In-Reply-To: <e89ab742-7984-6a2c-2f01-402283ba6e89@rothenpieler.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 18 Feb 2021 13:30:02 -0500
Message-ID: <CAN-5tyGhyh0ZF77voaN4TNgMt+jSUG0PMp-KixfTvgUhDdhDUQ@mail.gmail.com>
Subject: Re: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
To:     Timo Rothenpieler <timo@rothenpieler.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 18, 2021 at 10:55 AM Timo Rothenpieler
<timo@rothenpieler.org> wrote:
>
> On 18.02.2021 14:28, Timo Rothenpieler wrote:
> > I'll report back once I got a trace log.
>
> Find the trace log attached.
> It also grabbed quite a bit of unrelated noise, but I think it's still
> helpful:
>
> >            nfsd-7226  [025] 2228027.306471: nfsd_compound:        xid=0xbca1d6e9 opcnt=5
> >             nfsd-7226  [025] 2228027.306472: nfsd_compound_status: op=1/5 OP_SEQUENCE status=0
> >             nfsd-7226  [025] 2228027.306479: nfsd_compound_status: op=2/5 OP_PUTFH status=0
> >             nfsd-7226  [025] 2228027.306480: nfsd_compound_status: op=3/5 OP_SAVEFH status=0
> >             nfsd-7226  [025] 2228027.306483: nfsd_compound_status: op=4/5 OP_PUTFH status=0
> >             nfsd-7226  [025] 2228027.306590: nfsd_compound_status: op=5/5 OP_COPY status=0
> >             nfsd-7226  [025] 2228027.306702: nfsd_compound:        xid=0xbda1d6e9 opcnt=2
> >             nfsd-7226  [025] 2228027.306703: nfsd_compound_status: op=1/2 OP_SEQUENCE status=0
> >             nfsd-7226  [025] 2228027.306703: nfsd_compound_status: op=2/2 OP_TEST_STATEID status=0
> >             nfsd-7226  [025] 2228027.306741: nfsd_compound:        xid=0xbea1d6e9 opcnt=2
> >             nfsd-7226  [025] 2228027.306742: nfsd_compound_status: op=1/2 OP_SEQUENCE status=0
> >             nfsd-7226  [025] 2228027.306747: nfsd_compound_status: op=2/2 OP_TEST_STATEID status=0
> >             nfsd-7226  [025] 2228027.306791: nfsd_compound:        xid=0xbfa1d6e9 opcnt=2
> >             nfsd-7226  [025] 2228027.306792: nfsd_compound_status: op=1/2 OP_SEQUENCE status=0
> >             nfsd-7226  [025] 2228027.306793: nfsd_compound_status: op=2/2 OP_TEST_STATEID status=0
> >             nfsd-7226  [025] 2228027.306829: nfsd_compound:        xid=0xc0a1d6e9 opcnt=2
> >             nfsd-7226  [025] 2228027.306830: nfsd_compound_status: op=1/2 OP_SEQUENCE status=0
> >             nfsd-7226  [025] 2228027.306831: nfsd_compound_status: op=2/2 OP_TEST_STATEID status=0
> >             nfsd-7226  [025] 2228027.306865: nfsd_compound:        xid=0xc1a1d6e9 opcnt=2
> >             nfsd-7226  [025] 2228027.306866: nfsd_compound_status: op=1/2 OP_SEQUENCE status=0
> >             nfsd-7226  [025] 2228027.306866: nfsd_compound_status: op=2/2 OP_TEST_STATEID status=0
> >            <...>-2019374 [012] 2228027.307694: nfsd_file_put:        hash=0x275 inode=0x0xffffa0c8c35ab490 ref=4 flags=HASHED|REFERENCED may=READ file=0xffffa0e819758800
> >            <...>-2019374 [012] 2228027.307694: nfsd_file_put:        hash=0x365 inode=0x0xffffa0d70dd5dec0 ref=5 flags=HASHED|REFERENCED may=READ|WRITE file=0xffffa0e819759000
> >            <...>-2019374 [012] 2228027.307701: nfsd_file_put:        hash=0x365 inode=0x0xffffa0d70dd5dec0 ref=4 flags=HASHED|REFERENCED may=READ|WRITE file=0xffffa0e819759000
> >            <...>-2019374 [012] 2228027.307701: nfsd_file_put:        hash=0x275 inode=0x0xffffa0c8c35ab490 ref=3 flags=HASHED|REFERENCED may=READ file=0xffffa0e819758800
> >            <...>-1885588 [029] 2228027.307725: nfsd_cb_work:         addr=10.110.10.252:0 client 600c8efc:868a6681 procedure=CB_OFFLOAD
> >            <...>-1885588 [029] 2228027.307746: nfsd_cb_done:         addr=10.110.10.252:0 client 600c8efc:868a6681 status=-107
> >            <...>-1885588 [029] 2228027.307747: nfsd_cb_state:        addr=10.110.10.252:0 client 600c8efc:868a6681 state=FAULT

Thank you for getting tracepoints from a busy server but can you get
more? As suspected, the server is having issues sending the callback.
I'm not sure why. Any chance to turn on the server's sunrpc
tracespoints, probably both sunrpc and rdmas tracepoints, I wonder if
we can any more info about why it's failing?
