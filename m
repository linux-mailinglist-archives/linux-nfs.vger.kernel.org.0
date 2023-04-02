Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599786D3AE7
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Apr 2023 01:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjDBXOc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Apr 2023 19:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBXOc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Apr 2023 19:14:32 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEFA76A2
        for <linux-nfs@vger.kernel.org>; Sun,  2 Apr 2023 16:14:31 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so28698481pjz.1
        for <linux-nfs@vger.kernel.org>; Sun, 02 Apr 2023 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680477271;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IxEMlewZ0SEDmaUsOcKQmMF44vZ/wYuZT7cF48+Vco0=;
        b=TfS79IJgdKGgytbI4mpGNYczF9GhCwfbkMKYXzjnFolunDOr1c3VzhCmw+Ef2pkBM4
         C2iDxfi8i6ubwlymlHPr8t+gM+kp+d7UosU1N/Ej4ZS/nJ3/1wvI86NookSDv/r+22ye
         j4uCH/KDEbSNA84CKfwlYEgVIIH4Vb17Mvb0BP9s4iyyovir0HnkdY8QNgMyCO+aOtxx
         TwTf3yasOb0j8X1VSMETE+5MhzosA1HyQYyPiAmDW5M4tQIoNOWAZDnKhsH+aZDyf/t/
         qi8ym3JNfNylN3QOLPPAd1qC2lE32J/qdOrd2Q7aTQtvC5I2R5OE8HmkrEJnbMe2HVcn
         Ishg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680477271;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxEMlewZ0SEDmaUsOcKQmMF44vZ/wYuZT7cF48+Vco0=;
        b=isdVueMfNitcmRoK9LwdM2g50qSAg3L6NOm+bgodTDQLn0VKf4Xi5zS+yO3A7uPxCa
         6BFqZbVeRCGPqOB/cLGKc/3U2PTCcypHc0wUqQ8C8dNa5DYYOslD9c4rcJoDMbbMdC8H
         AFlB6xyogxaQFpcUjwgcM4SNVpUS4nVVNJ1lkFDkF8mBkQNrUu0HfJu7FR29W4pGhNE9
         nZCBj6coFjKjXbQYxQPLO9ON2LechDWLJPjUCBJ+0RkXAAQ/kz37RtA3t627ACS7GdMB
         TA4xQ1mbbw6XHp8sTjhh3LhzeWa2e5VJPcROvITIhCQdBs7h+z+VBNSo1zxjOcG1VSNK
         b1fw==
X-Gm-Message-State: AAQBX9e+Wn9XHhD3rWtQo1OlMciqkp311F/S+WoE25rvGCnK2KeqKjIe
        jO+Vtq2xVGvW4YOIcL5SZ3FEWCoQR5jYkS/0nOLrB3XP+A==
X-Google-Smtp-Source: AKy350Z4FnHTa+4YrfUFUlLSOQKZerGn8YBKdJGWTahEIIhtaCrHdTFBjPdT4hsaNHuRaToSyvtTH+PvopEtP2sIpnY=
X-Received: by 2002:a17:902:9b87:b0:1a1:ffc0:8b9e with SMTP id
 y7-20020a1709029b8700b001a1ffc08b9emr12480961plp.4.1680477270768; Sun, 02 Apr
 2023 16:14:30 -0700 (PDT)
MIME-Version: 1.0
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Sun, 2 Apr 2023 16:14:20 -0700
Message-ID: <CAM5tNy5T1-K3oH7TLeUG=F3V8u_aRhcvMEJkkaV7wj+5vqqq_w@mail.gmail.com>
Subject: sec=krb5 feature or bug??
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I've been testing a Linxu 5.15 NFSv4.2 client against a
FreeBSD server to test recently added SP4_MACH_CRED
support in the FreeBSD server.

I noticed the following oddity, which I thought I'd report
in case it is considered a bug and not a feature.
I do a mount like:
# mount -t nfs -o nfsvers=4,sec=krb5 nfsv4-server:/ /mnt
#
- When looking at the packet capture during the mount,
  the ExchangeID, CreateSession and ReclaimComplete
  are done with integrity (ie. krb5i) and ExchangeID uses
  SP4_MACH_CRED.
- Then, subsequent RPCs do not use integrity, as I would
  have assumed, given the "sec=krb5" argument.
However, some subsequent RPCs in the must_allow ops
list for SP4_MACH_CRED choose to use the "machine
principal" and do krb5i.

It just seems weird that it mixes krb5 and krb5i. I had
not expected it to use SP4_MACH_CRED when
"sec=krb5" was specified.

However, it seems to work fine this way, so I can see
the argument that this is a "feature" and not a bug.

Just fyi, rick
