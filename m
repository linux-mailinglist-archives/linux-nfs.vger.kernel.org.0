Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56F98300D8
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 19:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfE3RUe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 13:20:34 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38212 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3RUe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 May 2019 13:20:34 -0400
Received: by mail-ua1-f67.google.com with SMTP id r19so2780164uap.5
        for <linux-nfs@vger.kernel.org>; Thu, 30 May 2019 10:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SRNAe5nZVFzqS2hNrlzK45aRm//CgTikkP457GNe26M=;
        b=YlAr9P1/p/DYs0V6g/78C+4RUDeVgDKhG0bC36mvKebNa1bos401uaKnOIH4FAT6xo
         rcimfV5Bcw3bdgmsp8HaNwZvBQckCvSvW5U9O5ngJgCbz/xmY7wIEGJwYC0pybBOFK5O
         vIjV8S3rHTm154t7wQzLSWlbU8LOGDrb1mZn4luXxu8e2gtrWjVOouoSQz6nih6rymf+
         jz/7nZ6LFV0WQUmyYVeWJ9yKEGjXs5thX3yqknp89JVY98HmkFRu/EqlRoJbiI+KzgDI
         kw8EHCh2hpG59pEuKYDqkAZCN2q6uKfRW2ivdsYsE+UWxgBTMdpvKLb97jBUUq0aBSnF
         QSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SRNAe5nZVFzqS2hNrlzK45aRm//CgTikkP457GNe26M=;
        b=IQKEo33xNd7LHmQu53MZbRcirAAzsIN5NsRPEaa0nI50uUwFE1hYAuHR9/RqXZ9VoO
         21kSBnFCdQC+3nGyBKZhiL5pb3vb4iaoiCytLDizQnGG//tSjmtAOcPC11qzyX1kD0LL
         /5Mruo3VzAhBay8GO6Yorat75xslA54cx3qHgvGBNImECGnghBbbc/7Y/mofS/ipWj4y
         XMDricXm1uQPdTKh0fSLDRyY+soYXDGBVDA/2mCbpGELTP0p3s5LaPM1UQ1F1f2WV2Fs
         LfrE3mSNJepQdveUwHbPQuCMtPOcQPlmt3Fe+0IRah2/tGoxGlGBTnDmUpOWh54Y2/p9
         Bqfw==
X-Gm-Message-State: APjAAAWj2uW1HvsgXIb1Y9iIT1R0OpNhNDU6K5VxIsUra/BEuPVbrwjC
        O0+w0hnpoClDOAWQLRIayJCUbWch7UARqfkx7xk=
X-Google-Smtp-Source: APXvYqwYky8FPHg3Jww2Sw5eGTDYW06u38rOQvq8BGynZpXidzewoZZcaGVjABC400IJIbVt91RYxVD4F+6NcxjALQs=
X-Received: by 2002:ab0:2447:: with SMTP id g7mr2536361uan.65.1559236833510;
 Thu, 30 May 2019 10:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <1df23ebc-ffe5-1a57-c40a-d5e9a45c8498@talpey.com>
In-Reply-To: <1df23ebc-ffe5-1a57-c40a-d5e9a45c8498@talpey.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 30 May 2019 13:20:22 -0400
Message-ID: <CAN-5tyHUah=fAsiSLb=n__q5HxRy3qeS83evf-vB59r4cpYgsw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     Tom Talpey <tom@talpey.com>
Cc:     NeilBrown <neilb@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 30, 2019 at 1:05 PM Tom Talpey <tom@talpey.com> wrote:
>
> On 5/29/2019 8:41 PM, NeilBrown wrote:
> > I've also re-arrange the patches a bit, merged two, and remove the
> > restriction to TCP and NFSV4.x,x>=1.  Discussions seemed to suggest
> > these restrictions were not needed, I can see no need.
>
> I believe the need is for the correctness of retries. Because NFSv2,
> NFSv3 and NFSv4.0 have no exactly-once semantics of their own, server
> duplicate request caches are important (although often imperfect).
> These caches use client XID's, source ports and addresses, sometimes
> in addition to other methods, to detect retry. Existing clients are
> careful to reconnect with the same source port, to ensure this. And
> existing servers won't change.

Retries are already bound to the same connection so there shouldn't be
an issue of a retransmission coming from a different source port.

> Multiple connections will result in multiple source ports, and possibly
> multiple source addresses, meaning retried client requests may be
> accepted as new, rather than having any chance of being recognized as
> retries.
>
> NFSv4.1+ don't have this issue, but removing the restrictions would
> seem to break the downlevel mounts.
>
> Tom.
>
