Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6004D5EDC43
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Sep 2022 14:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiI1MEy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Sep 2022 08:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiI1ME0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Sep 2022 08:04:26 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB036E893
        for <linux-nfs@vger.kernel.org>; Wed, 28 Sep 2022 05:04:17 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id r193so3547347vke.13
        for <linux-nfs@vger.kernel.org>; Wed, 28 Sep 2022 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=SPgQwPPbtQOIcBcxaOQpTlU4nq+DfssibEaF51QyOEU=;
        b=CsnOgj9mZ/gOQGf3Hoq8LKZEbZRRiSwRTRFHnE/mi8myX+GG1m1fpPDLUdSVyQ3IaC
         6Luqg+A+0IiKwv/BHI2pjN4pnx1HmqfLcROCrC8ORm5NSisHo88SnI6U3Rc1AZvYg9+/
         jE3MaJ1mOJi/r3ZhUz+vju8U5qn9H34RYJtAyCUDuduOlZvCzz/zelwGinP0li/wtZ5N
         2LlMiEwOqXH5QW3yRylNX2mF54bMBJtXlMk4ETKAuPD5wqFsGEreHtAHVp68HBdkDl21
         V+RrIoLMXPyuBz3FL7xT7OMX7r1HRKPEzATNcO6LfZ4JgcPMNT8HAxcgHix8m68qxflr
         kPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=SPgQwPPbtQOIcBcxaOQpTlU4nq+DfssibEaF51QyOEU=;
        b=iKIAksihME0uLm+GTomnT2iPfSiacCj/DUa864XseF0seZ3kyYJuRwJYXpNCNv2ifP
         KkiEdxpoK7UppyNopeoW7zzJdTuGB6weYcKVgIn+8K/V5Jc+qE3Y2JaohkBFBIUVkanv
         ohTMXhsVN/fJI8jUxIuBGXAs+hrUQRG2uzXmFAjYQ/Lzcx9hs/wZnuLcZP8WMQkeA8nk
         5Nr27BuieHJ7rdyi2vKnkZ2HKyyXsiGF39/jBaOhDYazI/8riUuS5tcF3cSYu3S7kanf
         9CYzger3aXmLLLAiDZbriQbeP+Ncupqq1gH+prUTldkOzey2/TOr7g7tj37+HLPrSojL
         NWUA==
X-Gm-Message-State: ACrzQf1APY7knox/dAaMCiXnoE55OuN5P2yaAp6aJM7DUdhaqwoFerZ4
        vfL6OCz7z+OJ9DOK0TohEVtLtoEMIbv1tSH2eH+mpQqWp5s=
X-Google-Smtp-Source: AMsMyM7lFEJ0vZrCjs/IjjfMs4HRMjjPf9vimRTqQYy2/r5bGC7cWbvL9AN3rbHt61mma50VDJJ4i8kpr48T9/Vd5jI=
X-Received: by 2002:a1f:1704:0:b0:3a3:7b3b:a5d1 with SMTP id
 4-20020a1f1704000000b003a37b3ba5d1mr14458893vkx.3.1664366655671; Wed, 28 Sep
 2022 05:04:15 -0700 (PDT)
MIME-Version: 1.0
From:   jaganmohan kanakala <jaganmohan.kanakala@gmail.com>
Date:   Wed, 28 Sep 2022 17:34:04 +0530
Message-ID: <CAK6vGwma1mALwE1zDUqXhGP+YHjtXdPipykui3Tt0a6NL_KOqw@mail.gmail.com>
Subject: LINUX NFS support for SHA256 hash types
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linux-NFS team,

I'm trying to set up the Kerberos5 setup with MIT as the KDC on my
RHEL 8 machines.
I'm able to get the setup working with Kerberos encryption types where
the hash type is SHA1 (aes128-cts-hmac-sha1-96 and
aes256-cts-hmac-sha1-96).

As SHA1 is kind of obsolete, my goal is to get my setup working for
SHA256 hash types (aes128-cts-hmac-sha256-128,
aes256-cts-hmac-sha384-192).

I tried that. The communication between the Linux client and MIT KDC
is aes128-cts-hmac-sha256-128, but the communication between the Linux
client and Linux NFS server is only aes256-cts-hmac-sha1-96.

When I checked the Linux upstream code I see that there is no support
for SHA256 (and above) hash types.

https://github.com/torvalds/linux/blob/5bfc75d92efd494db37f5c4c173d3639d4772966/net/sunrpc/auth_gss/gss_krb5_mech.c

Have I looked at the right source code?
Does the latest Linux NFS server has support for kerberos encryption
types aes128-cts-hmac-sha256-128, aes256-cts-hmac-sha384-192 ?

Can anyone confirm?

BR,
Jaganmohan K
