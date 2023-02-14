Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC07C696E91
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 21:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBNUaP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 14 Feb 2023 15:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBNUaO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 15:30:14 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643E82703
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 12:30:13 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id f10so19153600qtv.1
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 12:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcjf1HdWcudrB7Hfz2Ogf/Q/6C632d5KwJ0kfH5WX4A=;
        b=PSVqKP3Nuk5zplvmS1eOetu+66IOoFWaN88PSSZBAT5gPy+XgL5q+7aLJgTj2qr52U
         I2nm5euD3bLjmCxF4SlVnF2RM/S1928FL3sOrlbRuMI3tr8ZQis5sj2dBT8IW5lt/RJn
         ih00JaR2nqpPQQmfbNe7pxA93q3rItffx2UodK7lIOr0WXbNIVxE3GrQgthe/pW89pM7
         6HTmjCRQ30Ti0A8wqfDM7+PQp+TBEwglHSj0RH9LhBTUrqy965oObuIGtOE8Uz5f7DVj
         dv1BRee77qW8DEIHMrlWmsYCLOfYpF+z8caFldpXgx25Bax5Hvp5B6S4ZhjNZJG9QOVu
         1oQA==
X-Gm-Message-State: AO0yUKVlIl+wrHk2E4tnWf6Ngas0GBG71Lji7g2y06QoFifKxhBY8ezs
        2+/FEv61C4urdzUuQ7K1Xw==
X-Google-Smtp-Source: AK7set8LAg1/yUNuIpXbAqGNQONQgIYElVJQ/AAcua35hCcruCGv5MtDApdE4fkNmo78RStdZHmqfg==
X-Received: by 2002:a05:622a:11ca:b0:3a9:8842:5860 with SMTP id n10-20020a05622a11ca00b003a988425860mr6491166qtk.45.1676406612352;
        Tue, 14 Feb 2023 12:30:12 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id a21-20020ac84355000000b003bb764fe4ffsm12023050qtn.3.2023.02.14.12.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 12:30:11 -0800 (PST)
Message-ID: <a44dfa9367526593f1be28dad281e2b6d50aaa2e.camel@kernel.org>
Subject: Re: [PATCH] NFSv4: Ensure we revalidate data after OPEN expired
From:   Trond Myklebust <trondmy@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 14 Feb 2023 15:30:10 -0500
In-Reply-To: <7e97897a29878a56236ef8e15bce7a295d5e8a41.1676403514.git.bcodding@redhat.com>
References: <7e97897a29878a56236ef8e15bce7a295d5e8a41.1676403514.git.bcodding@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-02-14 at 14:39 -0500, Benjamin Coddington wrote:
> We've observed that if the NFS client experiences a network partition
> and
> the server revokes the client's state, the client may not revalidate
> cached
> data for an open file during recovery.  If the file is extended by a
> second
> client during this network partition, the first client will correctly
> update the file's size and attributes during recovery, but another
> extending write will discard the second client's data.

I'm having trouble fully understanding your problem description. Is the
issue that both clients are opening the same file with something like
O_WRONLY|O_DSYNC|O_APPEND?

If so, what if the network partition happens during the write() system
call of client 1, so that the page cache is updated but the flush of
the write data ends up being delayed by the partition?
In that case, client 2 doesn't know that client 1 has writes
outstanding so it may write its data to where the server thinks the eof
offset is. However once client 1 is able to recover its open state, it
will still have dirty page cache data that is going to overwrite that
same offset.

> 
> In the case where another client opened the file during the network
> partition and the server revoked the first client's state, the
> recovery can
> forego optimizations and instead attempt to avoid corruption.
> 
> It's a little tricky to solve this in a per-file way during recovery
> without plumbing arguments or introducing new flags.  This patch
> side-steps
> the per-file complexity by simply checking if the client is within a
> NOGRACE recovery window, and if so, invalidates data during the open
> recovery.
> 

I don't see how this scenario can ever be made fully safe. If people
care, then we should probably have the open recovery of client 1 fail
altogether in this case (subject to some switch similar to the existing
'recover_lost_locks' kernel option).



-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


