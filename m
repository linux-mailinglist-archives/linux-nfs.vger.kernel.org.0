Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F3E73091F
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jun 2023 22:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjFNUYT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jun 2023 16:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjFNUYS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Jun 2023 16:24:18 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF25D2107
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jun 2023 13:24:16 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b291d55f52so4396608a34.2
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jun 2023 13:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686774256; x=1689366256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7xQlUKAKu/DyDGOJ81axHlrEXOOrBA4kpx7lUYtaAg=;
        b=N3ePdpWljtdoGYJXN+SENEdHMwYBGOYGCfYOIeOunm9v9MC75SIlT4752/CWs12uav
         8fylAK8suoj5gHP1sIUSdhRXqhlm/ojhuZxQxWz1lAlJdeGpA5ETA91xFbLzLJOnXPZf
         Lbgup2S87mNjNqRhVDb8XVy6eiiHVriw2iEOVmYDgnT+f12ZPQfPZXQKDTpjrWpWkT+G
         iHmllEcnAjOCsuzq8lk64aJcU4aZRUjZP3zxEJ0l7o8g1aYEOflkS7QmEuAEaAYkLch3
         INpAGN2khyJqgqOG2WXqZFDVRnSmwVkQ589uFF1RqGZzmeCUJ0cIw+u0mrxvOi/0Fiw1
         yXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686774256; x=1689366256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7xQlUKAKu/DyDGOJ81axHlrEXOOrBA4kpx7lUYtaAg=;
        b=BmjPrPOJ0zNhvucKQkCpyqj+cRW9jm/p3WfLhl3dWGYSEEYbZmzBM6KGrwLLHeL0Sr
         U5jbvr0tTzGkuW7XbSHwlsdc8z3I/enDIS74RWRLfbFKVmlyPjCUWr24LJbDm2fKA/Ic
         KvuYxMPe6k4jGUEbGj6OAH16Dx6wzkDdKA4Hm+xJByL2Nr07a++Qbn4O39leRvb7+pjG
         +HZYbHLA1fMJUFItP6VNe92rb+uwSQvqxj4qzOxagpX0omOSUDFmcz4ioGxu89J7HgyE
         msAPROZtUkZZf4CZZ62qdlRixJXcsIO0NrDdKCjYzPoYFQct3JKc5THawnTYjzzCPKsM
         94Jg==
X-Gm-Message-State: AC+VfDwwZ4KlIn0G9W6Ve6rlBqIi5O2OtGnkDRavuX0Ny23eUSerIlFQ
        W7cUNWYfaKpG5jrY/y/EiedfUhPfw1fb7AV/Oig0VNQ=
X-Google-Smtp-Source: ACHHUZ6drMpwwuE08nVNVta+w8M0X00lKxm1XELt/FzN5EBS450Ei53cttw8rmpzVrc+/dG38r1oWZDUdn88pv8LQkk=
X-Received: by 2002:a05:6870:8445:b0:1a6:aa38:f383 with SMTP id
 n5-20020a056870844500b001a6aa38f383mr6154321oak.58.1686774255984; Wed, 14 Jun
 2023 13:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGD2NCwgsUmaOVjhxjdtjxBng_LyjY1k5ap0qP0w+bxdg@mail.gmail.com>
In-Reply-To: <CAN-5tyGD2NCwgsUmaOVjhxjdtjxBng_LyjY1k5ap0qP0w+bxdg@mail.gmail.com>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Wed, 14 Jun 2023 13:24:05 -0700
Message-ID: <CAM5tNy6LEEWbwE8Ema5kEMCJ3oB=ta7HndbUCKXuF5QJkjSTWw@mail.gmail.com>
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

On Wed, Jun 14, 2023 at 12:58=E2=80=AFPM Olga Kornievskaia <aglo@umich.edu>=
 wrote:
>
>
> Hi Trond,
>
> I'm looking for advice on how to handle the problem that when
> BADSESSION is received (on an interrupted slot) and we don't increment
> the seqid for that slot. The client releases the slot and it's
> possible for another thread to use it before the session is frozen.
> Here are the (unfiltered sequential) tracepoints showing the problem.
> Follow slot_nr=3D0 and seq_nr=3D7673
>
>    kworker/u2:26-541     [000] .....   869.508658: nfs4_sequence_done:
> error=3D-10052 (BADSESSION) session=3D0x90caa481 slot_nr=3D4 seq_nr=3D425=
9
> highest_slotid=3D0 target_highest_slotid=3D0 status_flags=3D0x0 ()
>    kworker/u2:26-541     [000] .....   869.508661: nfs4_write:
> error=3D-10052 (BADSESSION) fileid=3D00:3b:111 fhandle=3D0x59c8ccff
> offset=3D2304664 count=3D7992 res=3D0 stateid=3D1:0x3f4f04cd
> layoutstateid=3D0:0x00000000
>     kworker/u2:1-3198    [000] .....   869.508898: nfs4_xdr_status:
> task:0000a2ae@00000011 xid=3D0x5d0f6dda error=3D-10052 (BADSESSION)
> operation=3D53
>     kworker/u2:1-3198    [000] .....   869.508905: nfs4_sequence_done:
> error=3D-10052 (BADSESSION) session=3D0x90caa481 slot_nr=3D0 seq_nr=3D767=
3
> highest_slotid=3D0 target_highest_slotid=3D0 status_flags=3D0x0 ()
>               dt-3684    [000] .....   869.508918: nfs4_set_lock:
> error=3D-10052 (BADSESSION) cmd=3DSETLK:WRLCK range=3D1603340:1834535
> fileid=3D00:3b:109 fhandle=3D0x7c6bc6b4 stateid=3D1:0x8f5f1fe4
> lockstateid=3D0:0x7bd5c66f
>
> *** this is use of slot_nr=3D0 seq_nr=3D7673 that gets BADSESSION. Slot
> gets released without incrementing the seq#. The next tracepoint shows
> the use of the slot again by another lock call ***
>
>     kworker/u2:1-3198    [000] .....   869.508928:
> nfs4_setup_sequence: session=3D0x90caa481 slot_nr=3D0 seq_nr=3D7673
> highest_used_slotid=3D1
>    kworker/u2:29-549     [000] .....   869.509746: nfs4_sequence_done:
> error=3D0 (OK) session=3D0x90caa481 slot_nr=3D0 seq_nr=3D7673
> highest_slotid=3D63 target_highest_slotid=3D63 status_flags=3D0x0 ()
>               dt-3672    [000] .....   869.509770: nfs4_set_lock:
> error=3D0 (OK) cmd=3DSETLK:WRLCK range=3D146432:159743 fileid=3D00:3b:129
> fhandle=3D0x50fa2dd4 stateid=3D1:0xcf065b31 lockstateid=3D1:0x5c571804
>    kworker/u2:26-541     [000] .....   869.509814:
> nfs4_setup_sequence: session=3D0x90caa481 slot_nr=3D0 seq_nr=3D7674
> highest_used_slotid=3D0
>    kworker/u2:26-541     [000] .....   869.509857:
> nfs4_setup_sequence: session=3D0x90caa481 slot_nr=3D1 seq_nr=3D7805
> highest_used_slotid=3D1
>
> ** finally the state manager gets to run? But only after 3 "NEW" use
> of slots are done **
>
>  172.28.68.180-m-3751    [000] .....   869.510267: nfs4_state_mgr:
> hostname=3D172.28.68.180 clp state=3DMANAGER_RUNNING|CHECK_LEASE|0xc040
>    kworker/u2:29-549     [000] .....   869.510977: nfs4_xdr_status:
> task:0000a2c8@00000011 xid=3D0x5e0f6dda error=3D-10052 (BADSESSION)
> operation=3D53
>    kworker/u2:29-549     [000] .....   869.510983: nfs4_sequence_done:
> error=3D-10052 (BADSESSION) session=3D0x90caa481 slot_nr=3D1 seq_nr=3D780=
5
> highest_slotid=3D0 target_highest_slotid=3D0 status_flags=3D0x0 ()
>    kworker/u2:29-549     [000] .....   869.510985: nfs4_write:
> error=3D-10052 (BADSESSION) fileid=3D00:3b:129 fhandle=3D0x50fa2dd4
> offset=3D146432 count=3D13312 res=3D0 stateid=3D1:0xcf065b31
> layoutstateid=3D0:0x00000000
>    kworker/u2:26-541     [000] .....   869.511318: nfs4_sequence_done:
> error=3D0 (OK) session=3D0x90caa481 slot_nr=3D0 seq_nr=3D7674
> highest_slotid=3D63 target_highest_slotid=3D63 status_flags=3D0x0 ()
>               dt-3669    [000] .....   869.511337: nfs4_set_lock:
> error=3D0 (OK) cmd=3DSETLK:WRLCK range=3D2462720:2469375 fileid=3D00:3b:1=
38
> fhandle=3D0xe30d8cf3 stateid=3D1:0xe2787aa1 lockstateid=3D1:0x216421fe
>  172.28.68.180-m-3751    [000] .....   869.511918:
> nfs4_destroy_session: error=3D0 (OK) dstaddr=3D172.28.68.180
>  172.28.68.180-m-3751    [000] .....   869.513347:
> nfs4_create_session: error=3D0 (OK) dstaddr=3D172.28.68.180
>
> To prevent reuse of the same slot/seqid for when we receive
> BADSESSION, can we perhaps set slot->seq_done? Then, when
> nfs41_sequence_process() calls nfs41_sequence_free_slot(), it'd
> increment seq_nr then. Slot re-use would be prevented.
>
> Or, perhaps we set the NFS4_SLOT_TBL_DRAINING bit right in
> nfs41_sequence_process() for BADSESSION so that nothing else can get
> the slot when it's released?
>
> Or some other way or preventing slots being (re)used after receiving
> BADSESSION on that slot. The problem if re-using (interrupted) slots
> is that they get cached reply from the server and those operations
> "think" operation succeeded and they have wrong/invalid stateids for
> instance.
>
> Here's the sequence of events. First of all this is a session trunking
> scenario where one of the servers leaves the group.
> NFS OP uses slot=3D0 seq=3D0 sends it to server 1. Server 1 processes the
> request populates its session cache. But the reply never reaches the
> client. Connection gets reset.
> NFS OP is resent using slot=3D0 seq=3D0 to server 2 which just left the
> trunking group. It replies with BADSESSION
> (session is not frozen on the client yet) new NFS OP uses slot=3D0 seq=3D=
0
> and sends it to server 1. Server 1 responds out of the session cache.
To me, this sounds like a broken NFSv4.1/4.2 server. Once a session is bad,
I do not think there should ever be a reply that was cached in that bad ses=
sion.
Put another way, the server should not leave the "trunking group' (whatever=
 that
means?) without making the session bad for all trunks. I do not think
a session should
ever work on one server and not on another one.

Having said the above, I have no opinion w.r.t. how such a case should
be handled.
(Except to tell the NFS server vendor that their server is broken.)

Just mho, rick

> Client destroys the session
> Client uses stateid returned from the new OP which is really invalid
> for the operation. Server fails the operation. Application failure
> occurs.
>
> Thank you..
