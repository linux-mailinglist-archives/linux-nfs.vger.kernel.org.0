Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EEF1B789A
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2020 16:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDXOzL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Apr 2020 10:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726717AbgDXOzK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Apr 2020 10:55:10 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98790C09B045
        for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2020 07:55:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r4so4734911pgg.4
        for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2020 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=UmviXZKoTq1aIP7UfH9EcEx1a66aEITqLB5DoD4w0s4=;
        b=Km/0OcxQVhqNs95bln+mA4y1APEAcw/podGeKr8cvqdQWUHrUux5f3oVITXHPV4aN+
         QHonMPQY0Tm923DXcTtT2klCV58mJuaApoBuEPhy/1PhkDvTgQpRBqZTevWNuia3dCgg
         5XTLtIyjcQlnK/BDYd4urVUtNlc3+AX3AQwnC72lw8Ask6yZlJqVBNgFef2qBRFQEJlS
         ulBMXFIYKrjzsp8RSFhQzCeKkKgLtvG12u/1jdaF/IeT6lyAld/+CfcIeBXURoOW3giC
         jPiLjNf9Q6WdU1xMFxzfnxhr3J1RqutwIslsIZTEfSCVRL+N91aaJvdBBFJoL5DF5rUI
         VoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UmviXZKoTq1aIP7UfH9EcEx1a66aEITqLB5DoD4w0s4=;
        b=qZTRszueWOLdSNX7CBlY/uCuNxCH2Xk7akB6VJHP8VGXe0bZHrr75yvLCekm5LufFi
         Vo8rC62AlSwdFTixMUoEeTD8G2SxF++xZVIkrXK0UXG+6hRs7uJm6LGQvsAPV2IgyasU
         0FTSc560SZ85+2d7CKoxh9aFPDHhklb15a+Z065p9wX76/VDiyjh66D8ECNP+hF38TAE
         s+FP2/SjHQ2lDAKvcMlhBG23MAktdhpgJPzmFW8YM2ei9Qq89+JdzJQZEhK/woHvumLC
         N6dGeqt+NUHfghAIJ0F8Ze/N1EIX294XNCOdAQ1HMzBAM1PqCLWLC4nr6E9BsjYMCD2s
         2tEg==
X-Gm-Message-State: AGi0PuaFMBaUjU1L71AkYzcVn6sv1FIyQ5TjYNtNR93m1vxPV4Wg9hof
        gL1ZjfJe4sDnREzAGVquiw8FdDpQN2ikuSi6a9/Znlt4bVhk6w==
X-Google-Smtp-Source: APiQypLqKkPSnjNR6S27+edcZG5YCmkaZPE6wvMV9VMF49F9aNSAUl+J/CjWEjzyJURH0FbSlJJlgp5CdQkz5PPHbm4=
X-Received: by 2002:a63:e74b:: with SMTP id j11mr9876818pgk.145.1587740109747;
 Fri, 24 Apr 2020 07:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAL9i7GFknrUDyp9PsGK-wbJ=0m30vHnvzoxpOjKtpRJPGDArjQ@mail.gmail.com>
 <CAL9i7GGLd4mPEeBGUmSaKXAqPh2fv+1Dn2wnNUjGONc-33ybbw@mail.gmail.com>
In-Reply-To: <CAL9i7GGLd4mPEeBGUmSaKXAqPh2fv+1Dn2wnNUjGONc-33ybbw@mail.gmail.com>
From:   sea you <seayou@gmail.com>
Date:   Fri, 24 Apr 2020 16:54:58 +0200
Message-ID: <CAL9i7GGG+jfARA=BscntNK-eq1tLH2pLzBvs6FFWX6GBo_O_Gg@mail.gmail.com>
Subject: Re: TestStateID woes with recent clients
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey all,

I would really appreciate some help here, I took a capture on the
client when this was happening and as you can see from it, it churns
the same dozens of times over and over again.

https://filebin.net/zs9hfipxbz2mn7i8

Thanks in advance,
Doma

On Fri, Apr 24, 2020 at 3:45 PM sea you <seayou@gmail.com> wrote:
>
> Hey all,
>
> I would really appreciate some help here, I took a capture on the client when this was happening and as you can see from it, it churns the same dozens of times over and over again.
>
> https://filebin.net/zs9hfipxbz2mn7i8
>
> Thanks in advance.
> Doma
>
> On Mon, Apr 20, 2020 at 4:32 PM sea you <seayou@gmail.com> wrote:
>>
>> Dear all,
>>
>> Time-to-time we're plagued with a lot of "TestStateID" RPC calls on a
>> 4.15.0-88 (Ubuntu Bionic) kernel, where clients (~310 VMS) are using
>> either 4.19.106 or 4.19.107 (Flatcar Linux). What we see during these
>> "storms", is that _some_ clients are testing the same id for callback
>> like
>>
>> [Thu Apr  9 15:18:57 2020] NFS reply test_stateid: succeeded, 0
>> [Thu Apr  9 15:18:57 2020] NFS call  test_stateid 00000000ec5d02eb
>> [Thu Apr  9 15:18:57 2020] --> nfs41_call_sync_prepare
>> data->seq_server 000000006dfc86c9
>> [Thu Apr  9 15:18:57 2020] --> nfs4_alloc_slot used_slots=0000
>> highest_used=4294967295 max_slots=31
>> [Thu Apr  9 15:18:57 2020] <-- nfs4_alloc_slot used_slots=0001
>> highest_used=0 slotid=0
>> [Thu Apr  9 15:18:57 2020] encode_sequence:
>> sessionid=1585584999:2538115180:5741:0 seqid=13899229 slotid=0
>> max_slotid=0 cache_this=0
>> [Thu Apr  9 15:18:57 2020] nfs41_handle_sequence_flag_errors:
>> "10.1.4.65" (client ID 671b825e6c904897) flags=0x00000040
>> [Thu Apr  9 15:18:57 2020] --> nfs4_alloc_slot used_slots=0001
>> highest_used=0 max_slots=31
>> [Thu Apr  9 15:18:57 2020] <-- nfs4_alloc_slot used_slots=0003
>> highest_used=1 slotid=1
>> [Thu Apr  9 15:18:57 2020] nfs4_free_slot: slotid 1 highest_used_slotid 0
>> [Thu Apr  9 15:18:57 2020] nfs41_sequence_process: Error 0 free the slot
>> [Thu Apr  9 15:18:57 2020] nfs4_free_slot: slotid 0
>> highest_used_slotid 4294967295
>> [Thu Apr  9 15:18:57 2020] NFS reply test_stateid: succeeded, 0
>> [Thu Apr  9 15:18:57 2020] NFS call  test_stateid 00000000ec5d02eb
>> [Thu Apr  9 15:18:57 2020] --> nfs41_call_sync_prepare
>> data->seq_server 000000006dfc86c9
>> [Thu Apr  9 15:18:57 2020] --> nfs4_alloc_slot used_slots=0000
>> highest_used=4294967295 max_slots=31
>> [Thu Apr  9 15:18:57 2020] <-- nfs4_alloc_slot used_slots=0001
>> highest_used=0 slotid=0
>> [Thu Apr  9 15:18:57 2020] encode_sequence:
>> sessionid=1585584999:2538115180:5741:0 seqid=13899230 slotid=0
>> max_slotid=0 cache_this=0
>> [Thu Apr  9 15:18:57 2020] nfs41_handle_sequence_flag_errors:
>> "10.1.4.65" (client ID 671b825e6c904897) flags=0x00000040
>> [Thu Apr  9 15:18:57 2020] --> nfs4_alloc_slot used_slots=0001
>> highest_used=0 max_slots=31
>> [Thu Apr  9 15:18:57 2020] <-- nfs4_alloc_slot used_slots=0003
>> highest_used=1 slotid=1
>> [Thu Apr  9 15:18:57 2020] nfs4_free_slot: slotid 1 highest_used_slotid 0
>> [Thu Apr  9 15:18:57 2020] nfs41_sequence_process: Error 0 free the slot
>> [Thu Apr  9 15:18:57 2020] nfs4_free_slot: slotid 0
>> highest_used_slotid 4294967295
>> [Thu Apr  9 15:18:57 2020] NFS reply test_stateid: succeeded, 0
>>
>> Due to this, some processes on some clients are stuck and these nodes
>> need to be rebooted. Initially, we thought we're facing the issue that
>> was fixed in 44f411c353bf, but as I see we're already using a kernel
>> where it was backported to via 90d73c1cadb8.
>>
>> Clients are mounting as
>> "rw,nosuid,nodev,noexec,noatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,acregmin=600,acregmax=600,acdirmin=600,acdirmax=600,hard,proto=tcp,timeo=600,retrans=2,sec=sys"
>>
>> Export options are the following
>> "<world>(rw,async,wdelay,crossmnt,no_root_squash,no_subtree_check,fsid=762,sec=sys,rw,secure,no_root_squash,no_all_squash)"
>> (fsid varies from export to export of course)
>>
>> Our workload is super metadata heavy (PHP) and data being served
>> changes a lot as clients are uploading files etc.
>>
>> We have a similar setup where clients are 4.19.(6|7)8 (CoreOS) and the
>> server is 4.15.0-76, where we rarely see these TestID RPC calls.
>>
>> It's worth to mention that between the two setups that is okay and the
>> one that is not, the main difference is using different block size
>> (the one with 512byte is okay, the other one with 4k isn't) in the
>> backing filesystem (ZFS), although I'm unsure how would that affect
>> NFS at all.
>>
>> The issue manifests at least once every day.
>>
>> Can you please point me in a direction that I should check further?
>>
>> Doma
