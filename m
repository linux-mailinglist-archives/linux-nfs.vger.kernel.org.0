Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CEB1B0E71
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 16:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgDTOck (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 10:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728028AbgDTOck (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Apr 2020 10:32:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075DDC061A0C
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 07:32:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h11so4002570plr.11
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rUqO6QlZHeEXl6zpcPj9kR9Nnw9AFd6QRuPujM5jXQ4=;
        b=eiYpZ0EDcopg0wTFDSpOOw8NixZog92xQAgnEZKKWvbjq1Fz9gbUqyBBkV7erVCXmk
         wVQdCHaOe0TRg/CG6FyP0S79smSgFpCX6vs5hGNT6OX40DfpOaRpP+2ijBSJ00tvdAzG
         0Eo6gr+kK3wUINhibrSlbc1Bzjioc3tgmc/u7c4+HV0Wr3J4bSlvqAbsvl5t8gYx5g/N
         WpNPMxxp675En7lx8zEVNS1IYjW3jEaB5sLedRd8gBsavxV9WKW8zigEy3CgbbNCErm9
         J8vc1C2Qn0ySiLqnydYhlaaYcsgzypmnppVuOC1od6k/xI7TtTIpPlzpCj4dghWlnKpX
         TW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rUqO6QlZHeEXl6zpcPj9kR9Nnw9AFd6QRuPujM5jXQ4=;
        b=S91uswxTmGVmbwfFqmj0/RTVGws23yr0l6co9AZsrqiEZ1chQSt1jKFg/bOQSbB0wv
         mWUupdF4hKJhsOwvS5vrxfCPud6TqV1VBt5Qjgkqg4gZbNgwFlCiXsZOEE1MAStjkldY
         HViV8N/0KszN8W8HY9O6y+ukXjKKdxsgf8f9yu5aJSsqLZs7kC5FjjqOn3Jx5/D3+pby
         b01t8NYWXUYYz/lB/lb2m4fK209LD3XgFjiuwxfuaJNGygVJc6gpahb2bpqWnyT5uwj2
         tIJLRQAMNnX/4LVqIUydP/f23XLcm1h7oGXwhfQZTzwQuwtbnH+WrjoZZnLRYTRY5Xp0
         zt8g==
X-Gm-Message-State: AGi0PuYC8nx91I5jVVj7VlyUS1LTjiSwyPy+8JPZ27088yfmhW6j5cg2
        tFTtkCuzZRMK940cbpe2MSJ8QOsdbxnYRlh9VV4crtIhdjvoDg==
X-Google-Smtp-Source: APiQypL9vb8ARYh0+aOCCCMiSAhM3UsAGVlJhTeEnHgXCwrfBqzfK9jaLm1BGSl6/xb3rc6dzeU3iuKI5e8Plg6bZis=
X-Received: by 2002:a17:902:7489:: with SMTP id h9mr14643700pll.212.1587393159065;
 Mon, 20 Apr 2020 07:32:39 -0700 (PDT)
MIME-Version: 1.0
From:   sea you <seayou@gmail.com>
Date:   Mon, 20 Apr 2020 16:32:27 +0200
Message-ID: <CAL9i7GFknrUDyp9PsGK-wbJ=0m30vHnvzoxpOjKtpRJPGDArjQ@mail.gmail.com>
Subject: TestStateID woes with recent clients
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dear all,

Time-to-time we're plagued with a lot of "TestStateID" RPC calls on a
4.15.0-88 (Ubuntu Bionic) kernel, where clients (~310 VMS) are using
either 4.19.106 or 4.19.107 (Flatcar Linux). What we see during these
"storms", is that _some_ clients are testing the same id for callback
like

[Thu Apr  9 15:18:57 2020] NFS reply test_stateid: succeeded, 0
[Thu Apr  9 15:18:57 2020] NFS call  test_stateid 00000000ec5d02eb
[Thu Apr  9 15:18:57 2020] --> nfs41_call_sync_prepare
data->seq_server 000000006dfc86c9
[Thu Apr  9 15:18:57 2020] --> nfs4_alloc_slot used_slots=0000
highest_used=4294967295 max_slots=31
[Thu Apr  9 15:18:57 2020] <-- nfs4_alloc_slot used_slots=0001
highest_used=0 slotid=0
[Thu Apr  9 15:18:57 2020] encode_sequence:
sessionid=1585584999:2538115180:5741:0 seqid=13899229 slotid=0
max_slotid=0 cache_this=0
[Thu Apr  9 15:18:57 2020] nfs41_handle_sequence_flag_errors:
"10.1.4.65" (client ID 671b825e6c904897) flags=0x00000040
[Thu Apr  9 15:18:57 2020] --> nfs4_alloc_slot used_slots=0001
highest_used=0 max_slots=31
[Thu Apr  9 15:18:57 2020] <-- nfs4_alloc_slot used_slots=0003
highest_used=1 slotid=1
[Thu Apr  9 15:18:57 2020] nfs4_free_slot: slotid 1 highest_used_slotid 0
[Thu Apr  9 15:18:57 2020] nfs41_sequence_process: Error 0 free the slot
[Thu Apr  9 15:18:57 2020] nfs4_free_slot: slotid 0
highest_used_slotid 4294967295
[Thu Apr  9 15:18:57 2020] NFS reply test_stateid: succeeded, 0
[Thu Apr  9 15:18:57 2020] NFS call  test_stateid 00000000ec5d02eb
[Thu Apr  9 15:18:57 2020] --> nfs41_call_sync_prepare
data->seq_server 000000006dfc86c9
[Thu Apr  9 15:18:57 2020] --> nfs4_alloc_slot used_slots=0000
highest_used=4294967295 max_slots=31
[Thu Apr  9 15:18:57 2020] <-- nfs4_alloc_slot used_slots=0001
highest_used=0 slotid=0
[Thu Apr  9 15:18:57 2020] encode_sequence:
sessionid=1585584999:2538115180:5741:0 seqid=13899230 slotid=0
max_slotid=0 cache_this=0
[Thu Apr  9 15:18:57 2020] nfs41_handle_sequence_flag_errors:
"10.1.4.65" (client ID 671b825e6c904897) flags=0x00000040
[Thu Apr  9 15:18:57 2020] --> nfs4_alloc_slot used_slots=0001
highest_used=0 max_slots=31
[Thu Apr  9 15:18:57 2020] <-- nfs4_alloc_slot used_slots=0003
highest_used=1 slotid=1
[Thu Apr  9 15:18:57 2020] nfs4_free_slot: slotid 1 highest_used_slotid 0
[Thu Apr  9 15:18:57 2020] nfs41_sequence_process: Error 0 free the slot
[Thu Apr  9 15:18:57 2020] nfs4_free_slot: slotid 0
highest_used_slotid 4294967295
[Thu Apr  9 15:18:57 2020] NFS reply test_stateid: succeeded, 0

Due to this, some processes on some clients are stuck and these nodes
need to be rebooted. Initially, we thought we're facing the issue that
was fixed in 44f411c353bf, but as I see we're already using a kernel
where it was backported to via 90d73c1cadb8.

Clients are mounting as
"rw,nosuid,nodev,noexec,noatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,acregmin=600,acregmax=600,acdirmin=600,acdirmax=600,hard,proto=tcp,timeo=600,retrans=2,sec=sys"

Export options are the following
"<world>(rw,async,wdelay,crossmnt,no_root_squash,no_subtree_check,fsid=762,sec=sys,rw,secure,no_root_squash,no_all_squash)"
(fsid varies from export to export of course)

Our workload is super metadata heavy (PHP) and data being served
changes a lot as clients are uploading files etc.

We have a similar setup where clients are 4.19.(6|7)8 (CoreOS) and the
server is 4.15.0-76, where we rarely see these TestID RPC calls.

It's worth to mention that between the two setups that is okay and the
one that is not, the main difference is using different block size
(the one with 512byte is okay, the other one with 4k isn't) in the
backing filesystem (ZFS), although I'm unsure how would that affect
NFS at all.

The issue manifests at least once every day.

Can you please point me in a direction that I should check further?

Doma
