Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4337308E1
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jun 2023 21:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjFNT6c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jun 2023 15:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFNT6b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Jun 2023 15:58:31 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECE71FEF
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jun 2023 12:58:29 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b1b1dd208dso14631201fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jun 2023 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1686772708; x=1689364708;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SQzvw4jDUVpJJ0ZJv41fJuc8RXX+BQlEmY4bplunmnQ=;
        b=Tq0ixaRtP8+11i4wgHG24S9EVOwhPhY9tg1QOR0SdCFIHVdWqmSNRgIoOt7VkeXAE0
         lEtguPR48gUgwm2SH2D2Gn49mgEFrwyxEmvGdsNpa4abZFJketusPjGFGPTHHlatC8nL
         baCLc3q4guLtiRIcfG2RfakWX2mkBiTfdWU96rZcC86LhLb1G6pCIe9xtIb6AU565ZsJ
         ig10b/H+23bzQIJQ3iaUp3xIn6D+9kK7BQ49YRh02Z9F/2fpJgvihrO+L52WRv5KvCMR
         CDvA3xU6jYta31KMOXsd63K2gOZOnebGL376I3XUiPRPNwpJ3RiWjPKqkF2IazzH+r5V
         WemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686772708; x=1689364708;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQzvw4jDUVpJJ0ZJv41fJuc8RXX+BQlEmY4bplunmnQ=;
        b=Eol5I7SO3dVu6hxUtZlo8By6oobRbTnn2E9213tx/iKXH1JUQw5TSkpVHMr7oDkpkN
         EexweB7exi15S/sa1ZzelPHYse9/YAuS7RN3Auj6acQk8iRSc4XK0GW+DvJIc+UsrbxM
         YaKJIS5CxKv9hrKi/aGMCLatt7uJVxyyj32GlV9+3sOxye5yumLaDmGu6p9LonL3m3/W
         vVmXuHv5t3czRgJH7bhhZR/WY0x51OyKmHjujENLJ6vgEeEhRwH5wwg5jVngEruOLyNL
         iGZ/9N3pZGQgAaJlSrR5armkkoge1bl5f/9nuZ5VOHtE8anDE3qGwyH6+U270zHKAT5+
         oGRw==
X-Gm-Message-State: AC+VfDz9thIqHjI1ixsW7Ynv1NbN/Zfo/jCMD1BbmwhBerRj/WGtxlax
        Pj91xBZJwBgOwI2PAG69JrCDqIttUE1Puk2NG7aJ/p6QNqU=
X-Google-Smtp-Source: ACHHUZ6gelzD3GBneUXPkRSc8PaVK4+FQls0wgSDHUpK79Ce/W+Wg1nMKdQK0+jpdsCnatcZoaDdIatqK83JBT9lc5E=
X-Received: by 2002:a2e:a498:0:b0:2b3:4e9f:906b with SMTP id
 h24-20020a2ea498000000b002b34e9f906bmr1162580lji.1.1686772707640; Wed, 14 Jun
 2023 12:58:27 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 14 Jun 2023 15:58:16 -0400
Message-ID: <CAN-5tyGD2NCwgsUmaOVjhxjdtjxBng_LyjY1k5ap0qP0w+bxdg@mail.gmail.com>
Subject: Handling of BADSESSON error
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Trond,

I'm looking for advice on how to handle the problem that when
BADSESSION is received (on an interrupted slot) and we don't increment
the seqid for that slot. The client releases the slot and it's
possible for another thread to use it before the session is frozen.
Here are the (unfiltered sequential) tracepoints showing the problem.
Follow slot_nr=0 and seq_nr=7673

   kworker/u2:26-541     [000] .....   869.508658: nfs4_sequence_done:
error=-10052 (BADSESSION) session=0x90caa481 slot_nr=4 seq_nr=4259
highest_slotid=0 target_highest_slotid=0 status_flags=0x0 ()
   kworker/u2:26-541     [000] .....   869.508661: nfs4_write:
error=-10052 (BADSESSION) fileid=00:3b:111 fhandle=0x59c8ccff
offset=2304664 count=7992 res=0 stateid=1:0x3f4f04cd
layoutstateid=0:0x00000000
    kworker/u2:1-3198    [000] .....   869.508898: nfs4_xdr_status:
task:0000a2ae@00000011 xid=0x5d0f6dda error=-10052 (BADSESSION)
operation=53
    kworker/u2:1-3198    [000] .....   869.508905: nfs4_sequence_done:
error=-10052 (BADSESSION) session=0x90caa481 slot_nr=0 seq_nr=7673
highest_slotid=0 target_highest_slotid=0 status_flags=0x0 ()
              dt-3684    [000] .....   869.508918: nfs4_set_lock:
error=-10052 (BADSESSION) cmd=SETLK:WRLCK range=1603340:1834535
fileid=00:3b:109 fhandle=0x7c6bc6b4 stateid=1:0x8f5f1fe4
lockstateid=0:0x7bd5c66f

*** this is use of slot_nr=0 seq_nr=7673 that gets BADSESSION. Slot
gets released without incrementing the seq#. The next tracepoint shows
the use of the slot again by another lock call ***

    kworker/u2:1-3198    [000] .....   869.508928:
nfs4_setup_sequence: session=0x90caa481 slot_nr=0 seq_nr=7673
highest_used_slotid=1
   kworker/u2:29-549     [000] .....   869.509746: nfs4_sequence_done:
error=0 (OK) session=0x90caa481 slot_nr=0 seq_nr=7673
highest_slotid=63 target_highest_slotid=63 status_flags=0x0 ()
              dt-3672    [000] .....   869.509770: nfs4_set_lock:
error=0 (OK) cmd=SETLK:WRLCK range=146432:159743 fileid=00:3b:129
fhandle=0x50fa2dd4 stateid=1:0xcf065b31 lockstateid=1:0x5c571804
   kworker/u2:26-541     [000] .....   869.509814:
nfs4_setup_sequence: session=0x90caa481 slot_nr=0 seq_nr=7674
highest_used_slotid=0
   kworker/u2:26-541     [000] .....   869.509857:
nfs4_setup_sequence: session=0x90caa481 slot_nr=1 seq_nr=7805
highest_used_slotid=1

** finally the state manager gets to run? But only after 3 "NEW" use
of slots are done **

 172.28.68.180-m-3751    [000] .....   869.510267: nfs4_state_mgr:
hostname=172.28.68.180 clp state=MANAGER_RUNNING|CHECK_LEASE|0xc040
   kworker/u2:29-549     [000] .....   869.510977: nfs4_xdr_status:
task:0000a2c8@00000011 xid=0x5e0f6dda error=-10052 (BADSESSION)
operation=53
   kworker/u2:29-549     [000] .....   869.510983: nfs4_sequence_done:
error=-10052 (BADSESSION) session=0x90caa481 slot_nr=1 seq_nr=7805
highest_slotid=0 target_highest_slotid=0 status_flags=0x0 ()
   kworker/u2:29-549     [000] .....   869.510985: nfs4_write:
error=-10052 (BADSESSION) fileid=00:3b:129 fhandle=0x50fa2dd4
offset=146432 count=13312 res=0 stateid=1:0xcf065b31
layoutstateid=0:0x00000000
   kworker/u2:26-541     [000] .....   869.511318: nfs4_sequence_done:
error=0 (OK) session=0x90caa481 slot_nr=0 seq_nr=7674
highest_slotid=63 target_highest_slotid=63 status_flags=0x0 ()
              dt-3669    [000] .....   869.511337: nfs4_set_lock:
error=0 (OK) cmd=SETLK:WRLCK range=2462720:2469375 fileid=00:3b:138
fhandle=0xe30d8cf3 stateid=1:0xe2787aa1 lockstateid=1:0x216421fe
 172.28.68.180-m-3751    [000] .....   869.511918:
nfs4_destroy_session: error=0 (OK) dstaddr=172.28.68.180
 172.28.68.180-m-3751    [000] .....   869.513347:
nfs4_create_session: error=0 (OK) dstaddr=172.28.68.180

To prevent reuse of the same slot/seqid for when we receive
BADSESSION, can we perhaps set slot->seq_done? Then, when
nfs41_sequence_process() calls nfs41_sequence_free_slot(), it'd
increment seq_nr then. Slot re-use would be prevented.

Or, perhaps we set the NFS4_SLOT_TBL_DRAINING bit right in
nfs41_sequence_process() for BADSESSION so that nothing else can get
the slot when it's released?

Or some other way or preventing slots being (re)used after receiving
BADSESSION on that slot. The problem if re-using (interrupted) slots
is that they get cached reply from the server and those operations
"think" operation succeeded and they have wrong/invalid stateids for
instance.

Here's the sequence of events. First of all this is a session trunking
scenario where one of the servers leaves the group.
NFS OP uses slot=0 seq=0 sends it to server 1. Server 1 processes the
request populates its session cache. But the reply never reaches the
client. Connection gets reset.
NFS OP is resent using slot=0 seq=0 to server 2 which just left the
trunking group. It replies with BADSESSION
(session is not frozen on the client yet) new NFS OP uses slot=0 seq=0
and sends it to server 1. Server 1 responds out of the session cache.
Client destroys the session
Client uses stateid returned from the new OP which is really invalid
for the operation. Server fails the operation. Application failure
occurs.

Thank you..
