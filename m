Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F69F73098E
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jun 2023 23:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjFNVBZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jun 2023 17:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjFNVBX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Jun 2023 17:01:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA3C19B5
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jun 2023 14:01:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b4f8523197so756875ad.1
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jun 2023 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686776481; x=1689368481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqzNhXnVKleZjAFqZcvq28bdOn7rQ5PfJAcEE59t/iI=;
        b=eg0KzfuC3EOhBECfvfRc7z6G6fpTTJ2vg1ltG4QwK/6rJtzU6yl2MbdmSLTqQ5dzqi
         jHbzXTEfVXYF0dVksx4tjmbVbI4x3XBPl+/HxfU3py25A/6Fud5CIINvxXpqkDNqCdeB
         gnajzcbInRmFYMkIQlVDyfYA2g1g53An+paiHL8qGjmwE4ZA1MwWS05vp27n5z5bezWf
         ndv5kyZeaq4BQg/1WZtzGNTQAsSlB7IPskfaZNEZrhuNZAVjZyyG+Z9lNEFgiXZe7c+o
         g3iI1ef2GRZB6L/HlXrybPkxo4S4eviy5bowZurvNiB/EvwHfHbkGkmTFPbF2W3p+0/a
         Gghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686776481; x=1689368481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqzNhXnVKleZjAFqZcvq28bdOn7rQ5PfJAcEE59t/iI=;
        b=XI/ZyGrcEBbPZdXOOZOZagyem4lVULjG52+RBHKZ1nr0zGKynajVvXG8ZHKSUWC+B9
         HV8CmEr5nTlzpgULGrJcKw4iEl9YJ7Ea3PLLQIG9DjlztomUbpqc26C2fw+0uYPviLqa
         xwWNGvoyIYJdLsujV30QSx8TR+GlcBOVJOLGDMMc0jM1hkxWZ+q4ALieXIbRmjIzjDea
         FnuaB8Glun61Lsv6OgjdgzboXqEYoAqJ/pjw3bchvH1yie1xv8QZCm5DolRfzh6aW3SU
         I6hRIJHzBbYKiBUiAy9E+p6mIAJiIvjEQHhMaGGPMQjUadm1q4W2nTiQT81IgCJlEFRq
         SClg==
X-Gm-Message-State: AC+VfDzradjilOJ43f7KZom4WvNSQF4gR4nB+dXVicpdin8ijcvIIfAE
        L3WhexlW2JSNR+ydD7WXq4BENf1I+vmzGfgpEGhruz0=
X-Google-Smtp-Source: ACHHUZ51gOXpk+JWdJnbRkgKCNNEueCRKcURMNaCXMZx8YxdNhjx6KLwjll0oxtoD6vsZS+auDjlFfX5YvtBwksCmIU=
X-Received: by 2002:a17:90b:3686:b0:25e:8076:dd04 with SMTP id
 mj6-20020a17090b368600b0025e8076dd04mr2329876pjb.6.1686776481155; Wed, 14 Jun
 2023 14:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGD2NCwgsUmaOVjhxjdtjxBng_LyjY1k5ap0qP0w+bxdg@mail.gmail.com>
 <CAM5tNy6LEEWbwE8Ema5kEMCJ3oB=ta7HndbUCKXuF5QJkjSTWw@mail.gmail.com> <CAN-5tyGMfARBVM2ZPju5tJA9yM-DLNvcp-OqAEVEApXOQ4df5A@mail.gmail.com>
In-Reply-To: <CAN-5tyGMfARBVM2ZPju5tJA9yM-DLNvcp-OqAEVEApXOQ4df5A@mail.gmail.com>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Wed, 14 Jun 2023 14:01:11 -0700
Message-ID: <CAM5tNy4yrTviKMSVPKGypU0Oe2p8AAv_C5RDDA2mbxRURrUneg@mail.gmail.com>
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

On Wed, Jun 14, 2023 at 1:43=E2=80=AFPM Olga Kornievskaia <aglo@umich.edu> =
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
Yep. I just noticed that myself. (It's item 3. in 2.10.13.1.4.)
I suppose a client should not use a session at all once it receives a BADSE=
SSION
for it, or it can go through the suggested algorithm in 2.10.13.1.4, sendin=
g a
Sequence by itself on each connection, etc...

A bother, but I guess it has no choice. I'm glad the FreeBSD client mostly
avoids trunking, rick

> Linux server throws away the session on getting the BADSESSION but the
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
