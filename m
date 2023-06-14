Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521D47309CF
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jun 2023 23:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjFNV17 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jun 2023 17:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjFNV16 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Jun 2023 17:27:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1501FFA
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jun 2023 14:27:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b4fef08cfdso7969425ad.1
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jun 2023 14:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686778076; x=1689370076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZQO4x072u4cWnbh0GBpHCvDSH4/8vzU3XXZujf36v4=;
        b=f6m1MavHcSWfkB9fhLCpYFudDd1P0LHH1OKR68keI55X7RLI6JFYir5xiFF/IzygAu
         /xrjsjD/Fr2JrQOyWvdMLxNSTdgOlC4HVK+gHLn1T0iUeEX+1M9Y78j/X4ye/OqrLmcN
         kVkTRO9Ru/FnbNccZuZJKnFGGP0uvGvdhhFVfCj22fzoPQeMpmmalVxMAs4lqV6YtiV/
         tZ7MFRO0al6uk2u60qiA6+jf2Ez0xjdLjVgsgvmZrNeMvk0DwlmMiVc7827Uj9TwxcnZ
         NG1iPr7O1Ff7IepDSGkGK6wI/uBlWJnsEYM0SOG0wUl3a+sz7/wrSYIopnwi0cF20brq
         /fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686778076; x=1689370076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZQO4x072u4cWnbh0GBpHCvDSH4/8vzU3XXZujf36v4=;
        b=eLqKDQ/BxSC35/SQ7zssXDtpK7pXOdsuB2H1FMzqf1kvmSbjumeq9S0HhFWUtBTq8h
         5zZHTnm8yyJ+L5aszBrnvH86no1P6TDovAdCyNtqieF8R487gOTZY0bx56qsLtJ4uBzi
         8+tl7Niihj5yhlySMEfYbyWxgxArUCTlbd766Cr59DUdQfbcqSZT0Q8gfdo3sE4i9iKo
         OkMux1SSoSZZBzu8bPIGjT+veoKozLEz+aJar4diAkyp5gjMe7Iu/eVG6UNlwL9ef/Eu
         ym6Mb6aS3hjprK8HlFkhor7j5nLrIKxmHCnOFIfeqxJvmiXeW7aq7Up7zGMRCIvwAp26
         zweA==
X-Gm-Message-State: AC+VfDxJmnXy+BWOscghTfTIxFUpbbcZL/xEd1cfq8e2Zb4VdYRgfNrm
        PqC0b2Z1/Q0RYaMwuAr1LrFo/J+mapt819BJz5DVj8w=
X-Google-Smtp-Source: ACHHUZ6EA9+iVs+srhfTGr035F/ZihjO5Or7bGkWJEsopHqP60k3qTQbT7GvHWagZAFPCFKDWo0yO579i0L9gYBqFMI=
X-Received: by 2002:a17:90b:4f8a:b0:25b:be4a:84c9 with SMTP id
 qe10-20020a17090b4f8a00b0025bbe4a84c9mr2381376pjb.17.1686778075842; Wed, 14
 Jun 2023 14:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGD2NCwgsUmaOVjhxjdtjxBng_LyjY1k5ap0qP0w+bxdg@mail.gmail.com>
 <CAM5tNy6LEEWbwE8Ema5kEMCJ3oB=ta7HndbUCKXuF5QJkjSTWw@mail.gmail.com>
 <CAN-5tyGMfARBVM2ZPju5tJA9yM-DLNvcp-OqAEVEApXOQ4df5A@mail.gmail.com> <CAN-5tyGiBP3XMS3wiOeQWVhO06JVMssURR0zd2xZhesdb8t8pQ@mail.gmail.com>
In-Reply-To: <CAN-5tyGiBP3XMS3wiOeQWVhO06JVMssURR0zd2xZhesdb8t8pQ@mail.gmail.com>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Wed, 14 Jun 2023 14:27:45 -0700
Message-ID: <CAM5tNy6U9w4NuqKK2sSfxHs-utXzjrGtj+iWUm3XDUSmfGj=UA@mail.gmail.com>
Subject: Re: Handling of BADSESSON error
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 14, 2023 at 1:44=E2=80=AFPM Olga Kornievskaia <aglo@umich.edu> =
wrote:
>
> On Wed, Jun 14, 2023 at 4:43=E2=80=AFPM Olga Kornievskaia <aglo@umich.edu=
> wrote:
> >
> > On Wed, Jun 14, 2023 at 4:24=E2=80=AFPM Rick Macklem <rick.macklem@gmai=
l.com> wrote:
> > >
> > > On Wed, Jun 14, 2023 at 12:58=E2=80=AFPM Olga Kornievskaia <aglo@umic=
h.edu> wrote:
> > > >
> > > >
> > > > Hi Trond,
> > > >
> > > > I'm looking for advice on how to handle the problem that when
> > > > BADSESSION is received (on an interrupted slot) and we don't increm=
ent
> > > > the seqid for that slot. The client releases the slot and it's
> > > > possible for another thread to use it before the session is frozen.
> > > > Here are the (unfiltered sequential) tracepoints showing the proble=
m.
> > > > Follow slot_nr=3D0 and seq_nr=3D7673
> > > >
> > > >    kworker/u2:26-541     [000] .....   869.508658: nfs4_sequence_do=
ne:
> > > > error=3D-10052 (BADSESSION) session=3D0x90caa481 slot_nr=3D4 seq_nr=
=3D4259
> > > > highest_slotid=3D0 target_highest_slotid=3D0 status_flags=3D0x0 ()
> > > >    kworker/u2:26-541     [000] .....   869.508661: nfs4_write:
> > > > error=3D-10052 (BADSESSION) fileid=3D00:3b:111 fhandle=3D0x59c8ccff
> > > > offset=3D2304664 count=3D7992 res=3D0 stateid=3D1:0x3f4f04cd
> > > > layoutstateid=3D0:0x00000000
> > > >     kworker/u2:1-3198    [000] .....   869.508898: nfs4_xdr_status:
> > > > task:0000a2ae@00000011 xid=3D0x5d0f6dda error=3D-10052 (BADSESSION)
> > > > operation=3D53
> > > >     kworker/u2:1-3198    [000] .....   869.508905: nfs4_sequence_do=
ne:
> > > > error=3D-10052 (BADSESSION) session=3D0x90caa481 slot_nr=3D0 seq_nr=
=3D7673
> > > > highest_slotid=3D0 target_highest_slotid=3D0 status_flags=3D0x0 ()
> > > >               dt-3684    [000] .....   869.508918: nfs4_set_lock:
> > > > error=3D-10052 (BADSESSION) cmd=3DSETLK:WRLCK range=3D1603340:18345=
35
> > > > fileid=3D00:3b:109 fhandle=3D0x7c6bc6b4 stateid=3D1:0x8f5f1fe4
> > > > lockstateid=3D0:0x7bd5c66f
> > > >
> > > > *** this is use of slot_nr=3D0 seq_nr=3D7673 that gets BADSESSION. =
Slot
> > > > gets released without incrementing the seq#. The next tracepoint sh=
ows
> > > > the use of the slot again by another lock call ***
> > > >
> > > >     kworker/u2:1-3198    [000] .....   869.508928:
> > > > nfs4_setup_sequence: session=3D0x90caa481 slot_nr=3D0 seq_nr=3D7673
> > > > highest_used_slotid=3D1
> > > >    kworker/u2:29-549     [000] .....   869.509746: nfs4_sequence_do=
ne:
> > > > error=3D0 (OK) session=3D0x90caa481 slot_nr=3D0 seq_nr=3D7673
> > > > highest_slotid=3D63 target_highest_slotid=3D63 status_flags=3D0x0 (=
)
> > > >               dt-3672    [000] .....   869.509770: nfs4_set_lock:
> > > > error=3D0 (OK) cmd=3DSETLK:WRLCK range=3D146432:159743 fileid=3D00:=
3b:129
> > > > fhandle=3D0x50fa2dd4 stateid=3D1:0xcf065b31 lockstateid=3D1:0x5c571=
804
> > > >    kworker/u2:26-541     [000] .....   869.509814:
> > > > nfs4_setup_sequence: session=3D0x90caa481 slot_nr=3D0 seq_nr=3D7674
> > > > highest_used_slotid=3D0
> > > >    kworker/u2:26-541     [000] .....   869.509857:
> > > > nfs4_setup_sequence: session=3D0x90caa481 slot_nr=3D1 seq_nr=3D7805
> > > > highest_used_slotid=3D1
> > > >
> > > > ** finally the state manager gets to run? But only after 3 "NEW" us=
e
> > > > of slots are done **
> > > >
> > > >  172.28.68.180-m-3751    [000] .....   869.510267: nfs4_state_mgr:
> > > > hostname=3D172.28.68.180 clp state=3DMANAGER_RUNNING|CHECK_LEASE|0x=
c040
> > > >    kworker/u2:29-549     [000] .....   869.510977: nfs4_xdr_status:
> > > > task:0000a2c8@00000011 xid=3D0x5e0f6dda error=3D-10052 (BADSESSION)
> > > > operation=3D53
> > > >    kworker/u2:29-549     [000] .....   869.510983: nfs4_sequence_do=
ne:
> > > > error=3D-10052 (BADSESSION) session=3D0x90caa481 slot_nr=3D1 seq_nr=
=3D7805
> > > > highest_slotid=3D0 target_highest_slotid=3D0 status_flags=3D0x0 ()
> > > >    kworker/u2:29-549     [000] .....   869.510985: nfs4_write:
> > > > error=3D-10052 (BADSESSION) fileid=3D00:3b:129 fhandle=3D0x50fa2dd4
> > > > offset=3D146432 count=3D13312 res=3D0 stateid=3D1:0xcf065b31
> > > > layoutstateid=3D0:0x00000000
> > > >    kworker/u2:26-541     [000] .....   869.511318: nfs4_sequence_do=
ne:
> > > > error=3D0 (OK) session=3D0x90caa481 slot_nr=3D0 seq_nr=3D7674
> > > > highest_slotid=3D63 target_highest_slotid=3D63 status_flags=3D0x0 (=
)
> > > >               dt-3669    [000] .....   869.511337: nfs4_set_lock:
> > > > error=3D0 (OK) cmd=3DSETLK:WRLCK range=3D2462720:2469375 fileid=3D0=
0:3b:138
> > > > fhandle=3D0xe30d8cf3 stateid=3D1:0xe2787aa1 lockstateid=3D1:0x21642=
1fe
> > > >  172.28.68.180-m-3751    [000] .....   869.511918:
> > > > nfs4_destroy_session: error=3D0 (OK) dstaddr=3D172.28.68.180
> > > >  172.28.68.180-m-3751    [000] .....   869.513347:
> > > > nfs4_create_session: error=3D0 (OK) dstaddr=3D172.28.68.180
> > > >
> > > > To prevent reuse of the same slot/seqid for when we receive
> > > > BADSESSION, can we perhaps set slot->seq_done? Then, when
> > > > nfs41_sequence_process() calls nfs41_sequence_free_slot(), it'd
> > > > increment seq_nr then. Slot re-use would be prevented.
> > > >
> > > > Or, perhaps we set the NFS4_SLOT_TBL_DRAINING bit right in
> > > > nfs41_sequence_process() for BADSESSION so that nothing else can ge=
t
> > > > the slot when it's released?
> > > >
> > > > Or some other way or preventing slots being (re)used after receivin=
g
> > > > BADSESSION on that slot. The problem if re-using (interrupted) slot=
s
> > > > is that they get cached reply from the server and those operations
> > > > "think" operation succeeded and they have wrong/invalid stateids fo=
r
> > > > instance.
Yep. On thinking about it a little more, I think you are correct. The
client either
needs to avoid using that slot again (the FreeBSD client marks slots "bad" =
when
an RPC is interrupted without having received/processed a reply) or the cli=
ent
needs to stop using the session for regular RPCs when a BADSESSION reply is
received.

What it should do after that is not so obvious to me.
There is the suggested algorithm in 2.10.13.1.4, but it does seem complex a=
nd
it only describes the cases where a Sequence by itself either succeeds or f=
ails
on the other connections. (It does not describe what to do if some succeed =
and
others fail, if I am reading it correctly.)
--> It might be easier to just CREATE_SESSION a new session and avoid using
     the old one any more?
This sounds like one of your suggested ways to handle it.

Good luck with whatever you choose and sorry about the noise w.r.t. a broke=
n
server (although I'd personally prefer to consider such a server as broken,=
 the
RFC allows it, so;-). rick

> > > >
> > > > Here's the sequence of events. First of all this is a session trunk=
ing
> > > > scenario where one of the servers leaves the group.
> > > > NFS OP uses slot=3D0 seq=3D0 sends it to server 1. Server 1 process=
es the
> > > > request populates its session cache. But the reply never reaches th=
e
> > > > client. Connection gets reset.
> > > > NFS OP is resent using slot=3D0 seq=3D0 to server 2 which just left=
 the
> > > > trunking group. It replies with BADSESSION
> > > > (session is not frozen on the client yet) new NFS OP uses slot=3D0 =
seq=3D0
> > > > and sends it to server 1. Server 1 responds out of the session cach=
e.
> > > To me, this sounds like a broken NFSv4.1/4.2 server. Once a session i=
s bad,
> > > I do not think there should ever be a reply that was cached in that b=
ad session.
> > > Put another way, the server should not leave the "trunking group' (wh=
atever that
> > > means?) without making the session bad for all trunks. I do not think
> > > a session should
> > > ever work on one server and not on another one.
> >
> > The spec allows for server to leave the group and session to be still v=
alid.
> >
> > From section 2.10.13.1.4
> > "If the SEQUENCE requests fail with NFS4ERR_BADSESSION, then the
> > session no longer exists on any of the server network addresses for
> > which the client has connections associated with that session ID. It
> > is possible the session is still alive and available on other network
> > addresses. "
> >
> > Linux server
>
> I meant to say Linux client
>
> > throws away the session on getting the BADSESSION but the
> > problem is that it doesn't happen instantly. So some new requests can
> > sneak before the session gets killed. Thus I'm advocating that slotid
> > still happens on BADSESSION or I'm suggesting that we freeze the
> > session table on BADSESSION which we currently don't do -- which
> > allows new requests to go.
> >
> > >
> > > Having said the above, I have no opinion w.r.t. how such a case shoul=
d
> > > be handled.
> > > (Except to tell the NFS server vendor that their server is broken.)
> > >
> > > Just mho, rick
> > >
> > > > Client destroys the session
> > > > Client uses stateid returned from the new OP which is really invali=
d
> > > > for the operation. Server fails the operation. Application failure
> > > > occurs.
> > > >
> > > > Thank you..
