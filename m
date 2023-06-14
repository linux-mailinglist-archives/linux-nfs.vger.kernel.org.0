Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAF5730963
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jun 2023 22:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjFNUoM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jun 2023 16:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjFNUoL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Jun 2023 16:44:11 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C6610F6
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jun 2023 13:44:10 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b1b1dd208dso14747971fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jun 2023 13:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1686775448; x=1689367448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z89A2CXQJmGwOB5hRCNbTXuEaIm8LPH5dO0j91q1+cA=;
        b=cpwwWFJsC9xlFZJ/lh24VB9GwCLZQOGUcb+1+dDP3bHYtO4E2aNjmi9Fey2bEaKavp
         743ofFOp+5rx7MRnyanTYTmgo/fQ+e8/jc/ALW8yLC7nLy+Y+J75YMYXfV/DwGS66+m+
         Fjmec6x6gnTr2vAIF9PNYcRAM1tFl2T7i5jF6ZXaqa9Zdcd7TQ3kcrXIroQGkpxCOTER
         S/ksPRORbBEdHZlBdCUJ1x8G1uOmkdrKcihl6CW/pC807KnjW8DyEDy8UbttRpOZIKLD
         zWlz38POZuMD0lTlVDDQCoSgjkmX2neGVwNqRbEk/COgDTyhB32+aeAR2xKJf/YgrerT
         DSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686775448; x=1689367448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z89A2CXQJmGwOB5hRCNbTXuEaIm8LPH5dO0j91q1+cA=;
        b=PzdGyKMXLKz584ezzaUF8Rex0ZCGT4XVlnGFkBcvk6pbA19ZDqIDXB194fyNc2vtp7
         EJau05VWpNM2qnxrflWW7DoT591xl3U9WhaXuSGDUoXPHbPa4wM9unesGjuL/nXc1PdO
         nDtsY7Mr4dQWjaCkXlPY1CKJOQyAC2mnmlecyhukz+KzWUV36HgOh37OU4aPYyKLxldo
         HS1t8UqbG03Jc3YKz+DBEwohgetxP/13w0Exc9bQsdjMH3tf34V8LLAUnSV4b6GV0K2A
         gU8BLoIrCIZ3SdktDrVHkdVHWqohJ6eSqP1gt6sPcxrzDEWuFs0XhKJyo3bFoeb+MBlM
         6QyA==
X-Gm-Message-State: AC+VfDw4AoSr6xLOLqyBlPcXVljwOADytHpbodk/hWketeOQi7JFdJgE
        cSNaBwSs8rKwksKCviQK8x0VwltQB5OjDQVkWFQ=
X-Google-Smtp-Source: ACHHUZ5mHEDjoYN1Xsgs2KO3+k9hDpxBGHBe64/nQSZoU6vy+Qgw7SL/zmbxAAEfeY/ZIpt3TgYSqXPMnB/KHs/79SI=
X-Received: by 2002:a2e:a498:0:b0:2b3:4e9f:906b with SMTP id
 h24-20020a2ea498000000b002b34e9f906bmr1222521lji.1.1686775447974; Wed, 14 Jun
 2023 13:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGD2NCwgsUmaOVjhxjdtjxBng_LyjY1k5ap0qP0w+bxdg@mail.gmail.com>
 <CAM5tNy6LEEWbwE8Ema5kEMCJ3oB=ta7HndbUCKXuF5QJkjSTWw@mail.gmail.com> <CAN-5tyGMfARBVM2ZPju5tJA9yM-DLNvcp-OqAEVEApXOQ4df5A@mail.gmail.com>
In-Reply-To: <CAN-5tyGMfARBVM2ZPju5tJA9yM-DLNvcp-OqAEVEApXOQ4df5A@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 14 Jun 2023 16:43:56 -0400
Message-ID: <CAN-5tyGiBP3XMS3wiOeQWVhO06JVMssURR0zd2xZhesdb8t8pQ@mail.gmail.com>
Subject: Re: Handling of BADSESSON error
To:     Rick Macklem <rick.macklem@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 14, 2023 at 4:43=E2=80=AFPM Olga Kornievskaia <aglo@umich.edu> =
wrote:
>
> On Wed, Jun 14, 2023 at 4:24=E2=80=AFPM Rick Macklem <rick.macklem@gmail.=
com> wrote:
> >
> > On Wed, Jun 14, 2023 at 12:58=E2=80=AFPM Olga Kornievskaia <aglo@umich.=
edu> wrote:
> > >
> > >
> > > Hi Trond,
> > >
> > > I'm looking for advice on how to handle the problem that when
> > > BADSESSION is received (on an interrupted slot) and we don't incremen=
t
> > > the seqid for that slot. The client releases the slot and it's
> > > possible for another thread to use it before the session is frozen.
> > > Here are the (unfiltered sequential) tracepoints showing the problem.
> > > Follow slot_nr=3D0 and seq_nr=3D7673
> > >
> > >    kworker/u2:26-541     [000] .....   869.508658: nfs4_sequence_done=
:
> > > error=3D-10052 (BADSESSION) session=3D0x90caa481 slot_nr=3D4 seq_nr=
=3D4259
> > > highest_slotid=3D0 target_highest_slotid=3D0 status_flags=3D0x0 ()
> > >    kworker/u2:26-541     [000] .....   869.508661: nfs4_write:
> > > error=3D-10052 (BADSESSION) fileid=3D00:3b:111 fhandle=3D0x59c8ccff
> > > offset=3D2304664 count=3D7992 res=3D0 stateid=3D1:0x3f4f04cd
> > > layoutstateid=3D0:0x00000000
> > >     kworker/u2:1-3198    [000] .....   869.508898: nfs4_xdr_status:
> > > task:0000a2ae@00000011 xid=3D0x5d0f6dda error=3D-10052 (BADSESSION)
> > > operation=3D53
> > >     kworker/u2:1-3198    [000] .....   869.508905: nfs4_sequence_done=
:
> > > error=3D-10052 (BADSESSION) session=3D0x90caa481 slot_nr=3D0 seq_nr=
=3D7673
> > > highest_slotid=3D0 target_highest_slotid=3D0 status_flags=3D0x0 ()
> > >               dt-3684    [000] .....   869.508918: nfs4_set_lock:
> > > error=3D-10052 (BADSESSION) cmd=3DSETLK:WRLCK range=3D1603340:1834535
> > > fileid=3D00:3b:109 fhandle=3D0x7c6bc6b4 stateid=3D1:0x8f5f1fe4
> > > lockstateid=3D0:0x7bd5c66f
> > >
> > > *** this is use of slot_nr=3D0 seq_nr=3D7673 that gets BADSESSION. Sl=
ot
> > > gets released without incrementing the seq#. The next tracepoint show=
s
> > > the use of the slot again by another lock call ***
> > >
> > >     kworker/u2:1-3198    [000] .....   869.508928:
> > > nfs4_setup_sequence: session=3D0x90caa481 slot_nr=3D0 seq_nr=3D7673
> > > highest_used_slotid=3D1
> > >    kworker/u2:29-549     [000] .....   869.509746: nfs4_sequence_done=
:
> > > error=3D0 (OK) session=3D0x90caa481 slot_nr=3D0 seq_nr=3D7673
> > > highest_slotid=3D63 target_highest_slotid=3D63 status_flags=3D0x0 ()
> > >               dt-3672    [000] .....   869.509770: nfs4_set_lock:
> > > error=3D0 (OK) cmd=3DSETLK:WRLCK range=3D146432:159743 fileid=3D00:3b=
:129
> > > fhandle=3D0x50fa2dd4 stateid=3D1:0xcf065b31 lockstateid=3D1:0x5c57180=
4
> > >    kworker/u2:26-541     [000] .....   869.509814:
> > > nfs4_setup_sequence: session=3D0x90caa481 slot_nr=3D0 seq_nr=3D7674
> > > highest_used_slotid=3D0
> > >    kworker/u2:26-541     [000] .....   869.509857:
> > > nfs4_setup_sequence: session=3D0x90caa481 slot_nr=3D1 seq_nr=3D7805
> > > highest_used_slotid=3D1
> > >
> > > ** finally the state manager gets to run? But only after 3 "NEW" use
> > > of slots are done **
> > >
> > >  172.28.68.180-m-3751    [000] .....   869.510267: nfs4_state_mgr:
> > > hostname=3D172.28.68.180 clp state=3DMANAGER_RUNNING|CHECK_LEASE|0xc0=
40
> > >    kworker/u2:29-549     [000] .....   869.510977: nfs4_xdr_status:
> > > task:0000a2c8@00000011 xid=3D0x5e0f6dda error=3D-10052 (BADSESSION)
> > > operation=3D53
> > >    kworker/u2:29-549     [000] .....   869.510983: nfs4_sequence_done=
:
> > > error=3D-10052 (BADSESSION) session=3D0x90caa481 slot_nr=3D1 seq_nr=
=3D7805
> > > highest_slotid=3D0 target_highest_slotid=3D0 status_flags=3D0x0 ()
> > >    kworker/u2:29-549     [000] .....   869.510985: nfs4_write:
> > > error=3D-10052 (BADSESSION) fileid=3D00:3b:129 fhandle=3D0x50fa2dd4
> > > offset=3D146432 count=3D13312 res=3D0 stateid=3D1:0xcf065b31
> > > layoutstateid=3D0:0x00000000
> > >    kworker/u2:26-541     [000] .....   869.511318: nfs4_sequence_done=
:
> > > error=3D0 (OK) session=3D0x90caa481 slot_nr=3D0 seq_nr=3D7674
> > > highest_slotid=3D63 target_highest_slotid=3D63 status_flags=3D0x0 ()
> > >               dt-3669    [000] .....   869.511337: nfs4_set_lock:
> > > error=3D0 (OK) cmd=3DSETLK:WRLCK range=3D2462720:2469375 fileid=3D00:=
3b:138
> > > fhandle=3D0xe30d8cf3 stateid=3D1:0xe2787aa1 lockstateid=3D1:0x216421f=
e
> > >  172.28.68.180-m-3751    [000] .....   869.511918:
> > > nfs4_destroy_session: error=3D0 (OK) dstaddr=3D172.28.68.180
> > >  172.28.68.180-m-3751    [000] .....   869.513347:
> > > nfs4_create_session: error=3D0 (OK) dstaddr=3D172.28.68.180
> > >
> > > To prevent reuse of the same slot/seqid for when we receive
> > > BADSESSION, can we perhaps set slot->seq_done? Then, when
> > > nfs41_sequence_process() calls nfs41_sequence_free_slot(), it'd
> > > increment seq_nr then. Slot re-use would be prevented.
> > >
> > > Or, perhaps we set the NFS4_SLOT_TBL_DRAINING bit right in
> > > nfs41_sequence_process() for BADSESSION so that nothing else can get
> > > the slot when it's released?
> > >
> > > Or some other way or preventing slots being (re)used after receiving
> > > BADSESSION on that slot. The problem if re-using (interrupted) slots
> > > is that they get cached reply from the server and those operations
> > > "think" operation succeeded and they have wrong/invalid stateids for
> > > instance.
> > >
> > > Here's the sequence of events. First of all this is a session trunkin=
g
> > > scenario where one of the servers leaves the group.
> > > NFS OP uses slot=3D0 seq=3D0 sends it to server 1. Server 1 processes=
 the
> > > request populates its session cache. But the reply never reaches the
> > > client. Connection gets reset.
> > > NFS OP is resent using slot=3D0 seq=3D0 to server 2 which just left t=
he
> > > trunking group. It replies with BADSESSION
> > > (session is not frozen on the client yet) new NFS OP uses slot=3D0 se=
q=3D0
> > > and sends it to server 1. Server 1 responds out of the session cache.
> > To me, this sounds like a broken NFSv4.1/4.2 server. Once a session is =
bad,
> > I do not think there should ever be a reply that was cached in that bad=
 session.
> > Put another way, the server should not leave the "trunking group' (what=
ever that
> > means?) without making the session bad for all trunks. I do not think
> > a session should
> > ever work on one server and not on another one.
>
> The spec allows for server to leave the group and session to be still val=
id.
>
> From section 2.10.13.1.4
> "If the SEQUENCE requests fail with NFS4ERR_BADSESSION, then the
> session no longer exists on any of the server network addresses for
> which the client has connections associated with that session ID. It
> is possible the session is still alive and available on other network
> addresses. "
>
> Linux server

I meant to say Linux client

> throws away the session on getting the BADSESSION but the
> problem is that it doesn't happen instantly. So some new requests can
> sneak before the session gets killed. Thus I'm advocating that slotid
> still happens on BADSESSION or I'm suggesting that we freeze the
> session table on BADSESSION which we currently don't do -- which
> allows new requests to go.
>
> >
> > Having said the above, I have no opinion w.r.t. how such a case should
> > be handled.
> > (Except to tell the NFS server vendor that their server is broken.)
> >
> > Just mho, rick
> >
> > > Client destroys the session
> > > Client uses stateid returned from the new OP which is really invalid
> > > for the operation. Server fails the operation. Application failure
> > > occurs.
> > >
> > > Thank you..
