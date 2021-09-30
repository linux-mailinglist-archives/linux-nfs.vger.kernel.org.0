Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B45341DF28
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Sep 2021 18:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351988AbhI3Qiz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Sep 2021 12:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352059AbhI3Qiy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Sep 2021 12:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633019831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LTRCkphn2KY4US5x0UBqe8lxMhx2X7b4KiRs1ukZ6cc=;
        b=TJHJ+OZfBos+ct8eBWrCLqpYpiPIys/t4xQsDs9rmRtwtNuATAjhiU7ilT/nDGffFtB8uY
        4kDh0dPoHVq5N860hFcOmG+NA6J8cTVWBssML3W+fLPvnZ/nBKCnBtLqRPDZazgauXS9ZV
        2QTKx9LOddPph8BAj62R4tdt6InDP14=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-9TmD6B-NN0eFxyQ8amPSQA-1; Thu, 30 Sep 2021 12:37:08 -0400
X-MC-Unique: 9TmD6B-NN0eFxyQ8amPSQA-1
Received: by mail-qt1-f200.google.com with SMTP id c19-20020ac81e93000000b002a71180fd3dso7502499qtm.1
        for <linux-nfs@vger.kernel.org>; Thu, 30 Sep 2021 09:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=LTRCkphn2KY4US5x0UBqe8lxMhx2X7b4KiRs1ukZ6cc=;
        b=H9y9alZuFfKbHXDEWIyGVxHMpUKN431GLEMlv0XRANoBKauBawXZVQ9xogEkKbkgDb
         8pxAhUdZRY+vyQZ1BUjP+DaBPj2KYljLMhTs3pBdrOPsmdFsNgpe/ejsVprzEMcghpK4
         nzd3rQ0nqHnbaggyYMozUIrz8XbMV16OFzLFCpsHEjs3T8SZTDFnqNyyl1x7SpKjvakw
         1giefd4pCn4XZ7f7GrxpYDwA2PfA3QJ7Uxz02+T8FBYlBhkWrFdBXqlAbJX8/3XQkiI/
         2Nx8V2/BAm4oDt/Dw8YexL56HAjxnSH1xUbhPKcIfOM7GDfhR23vz6Zu/TFDktkU/KLK
         sRJg==
X-Gm-Message-State: AOAM533v5zkqHXwMn8a5wXJl1TCaMlZpRtLEXtmojvKC4aXgCPXgjoct
        turmWl0IzL7ErT/UuWmVHsHId/4X/kAhiyPaqzmlziUbcSSDp+CUW2+4B040CQ3wk2Vz6/2LY7q
        bB5gQHdebJGl4rGxVkBPhyg2g1bx/C5iMQVkctoUv982Wm9u7EP4rWvvp7hanXWc31zisEQ==
X-Received: by 2002:a05:620a:5e5:: with SMTP id z5mr5546916qkg.20.1633019828155;
        Thu, 30 Sep 2021 09:37:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8Cj4L0tVoT5swM/p7VjMb60lYXxrqZDBXFWjg2LMhIjIKY2qjh2+LjoCvlkkENP99F4nnBg==
X-Received: by 2002:a05:620a:5e5:: with SMTP id z5mr5546881qkg.20.1633019827820;
        Thu, 30 Sep 2021 09:37:07 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.255.190])
        by smtp.gmail.com with ESMTPSA id f34sm563175qtb.10.2021.09.30.09.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 09:37:07 -0700 (PDT)
Message-ID: <7e24d80d-56b2-68af-5351-ad42dc4d0a18@redhat.com>
Date:   Thu, 30 Sep 2021 12:37:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     NFSv4 IETF <nfsv4@ietf.org>
From:   Steve Dickson <steved@redhat.com>
Subject: Virtual Bakeathon: Reminder
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

Just a quick reminder the VBAT coming up next week
The details are here [1].

We are again going to be using an IPv6
based VPN as the testing network. Details on
how to set it up are at [2]. Any question
reach out to Ben Coddington <bcodding@redhat.com>

Here at Red Hat we have been using vm
in the Digital Ocean cloud [3]...
I have found them to be really easy to
work with and relatively inexpensive.

We will again use discord [4] to communicate.
Look for the VBaT channel. The contact for that is
Alice Mitchell <ajmitchell@redhat.com>

Finally I would like to propose that every day at
2:00pm (EST) we get together on the discord voice
channel 'General Chat' and talk about the topics
of the day:

* TLS (user vs kernel)
* FS-cache (Trond's favorite subject)
* QUIC (Chuck's favorite subject ;-) )
* Allowing hung mount to reboot
* re-export
* Session-Truncking
* ???

Basically anything we wan to talk about relative
to what is going on in the community...
or not... :-)

Ideally, as Rick suggested, reaching out to people
like Google and MS.. people who  might have a better
insight of these networking technologies... would
be good... Just let them where we will be.

If I have forgotten anything... I'm sure you will
let me know! :-) See you Monday!

steved

[1] http://www.nfsv4bat.org/Events/2021/Oct/BAT/index.html
[2] https://vpn.nfsv4.dev/
[3] https://www.digitalocean.com/
[4] https://discord.com

