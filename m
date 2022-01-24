Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A630B498171
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiAXNwp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 08:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbiAXNwp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 08:52:45 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BFDC06173B
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jan 2022 05:52:44 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id k25so21448681ejp.5
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jan 2022 05:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BQrTJr6+YyJTwahreaixuktW2Hqfiz2UjA5Hk5/nzs0=;
        b=htexKrAkOIM2WoMJ7XUI49j2nYIS437FOoGcZqD8YDZd4c4LplIaMjFxmoqQ4mVUJN
         c5a0r+uBjw5FUW1HNZajw6Fv5dY23PfswafomMnr4DZ7HW8mwazF24C7rL7fqJdph35N
         pEO/JfrzbpMPTZ1J9uo6k/Dg/z1YfbYAf/Ezg5ta0lQftjTUGdxKeyihpXwAMQSRLCaT
         8JrwQaW0FgexTCzvFqqP4t2Can6d1dxjC0zTV/xUmnYdmJSGOoju5ib5vLzLDaG6IBmW
         DEf8pOjhmSSoHpIvbABmdtQ1dJsKraNZr6t3B/E/PmAhgDarEnRdK8dZPK8MmTGtLP24
         l6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BQrTJr6+YyJTwahreaixuktW2Hqfiz2UjA5Hk5/nzs0=;
        b=igF8ZvoyKtqv755TP4EXbJivd18bBxJwZTgV5HSwwuribKgmnNlXO0Qan1tCl72c+X
         O2hQkzfi0TnjLRzwgwu5jSqXQb6QUR+QOsh9EOFDTPjPdhIYUvBvlMDh4avrE2CE6v2/
         RRZg2KoDU8cnsivpKpwp5zpJdlz9OvwL3bGz7mt2QcpbhdeCizG2d3jkxCFntHp3805B
         HHnaCENKuKGe3sEeytN/YvaEWgPedpjFcqUTcSBjr6gXvIQFjsrQ/NavzLJQlp4aYwwL
         BzSgDSF6nteSFJJO2QMxzq/1isGb2uiF1AMDFgq0Gbw2BnaYT5WqxMWfO/SwuXTbiZ4y
         rGqw==
X-Gm-Message-State: AOAM532/epGGD6ucm0KV08FBCZvce1xfHTMF5+NTwqfednBA4Z8duqM/
        PADJ8nF+jdaAJs4SyGiNmuy5G6WZBvQ1oip3xCXzOQE46+xVrYb1
X-Google-Smtp-Source: ABdhPJwKESgm1WTyYBJhQG9Xnelh1JDiU4n1zVX5RqEZg5ZQeR7ggzbrtjJ/EKvrkiCCMhWmZMYi+A/0l0JJaEbfBmw=
X-Received: by 2002:a17:906:3819:: with SMTP id v25mr12234568ejc.539.1643032362753;
 Mon, 24 Jan 2022 05:52:42 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
In-Reply-To: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 24 Jan 2022 13:52:07 +0000
Message-ID: <CAPt2mGMyYPqjDrY_WPfJMtY9EFRYzfAXK9kdh6SzbGHJgqHuXw@mail.gmail.com>
Subject: Re: parallel file create rates (+high latency)
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

This seemed like a good test case for Neil Brown's "namespaces" patch:

https://lore.kernel.org/linux-nfs/162458475606.28671.1835069742861755259@noble.neil.brown.name

The interesting thing about this is that we get independent slot
tables for the same remote server (and directory).

So we can test like this:

# mount server 10 times with a different namespace
for x in {0..9}; do
    sudo mkdir -p /srv/data-$x
    sudo mount -o vers=4.2,namespace=server${x},actimeo=3600,nocto,
server:/data /srv/data-${x}
done

# create files across the namespace mounts but in same remote directory
for x in {1..2000}; do
    echo /srv/data-$((RANDOM %10))/dir1/touch.$x
done | xargs -n1 -P 100 -iX -t touch X 2>&1 | pv -l -a >|/dev/null

Doing this we get the same file create rate (32/s) as if we had used
10 individual clients.

I can only assume this is because of the independent slot table rpc queues?

But I have no idea why that also seems to effect the rate depending on
whether you use multiple remote directories or a single shared
directory.

So in summary:
* concurrent processes creating files in a single remote directory = slow
* concurrent processes creating files across many directories = fast
* concurrent clients creating files in a shared remote directory = fast
* concurrent namespaces creating files in a shared remote directory = fast

There is probably also some overlap with my previous queries around
parallel io/metadata performance:

https://marc.info/?t=160199739400001&r=2&w=4

Daire

On Sun, 23 Jan 2022 at 23:53, Daire Byrne <daire@dneg.com> wrote:
>
> Hi,
>
> I've been experimenting a bit more with high latency NFSv4.2 (200ms).
> I've noticed a difference between the file creation rates when you
> have parallel processes running against a single client mount creating
> files in multiple directories compared to in one shared directory.
>
> If I start 100 processes on the same client creating unique files in a
> single shared directory (with 200ms latency), the rate of new file
> creates is limited to around 3 files per second. Something like this:
>
> # add latency to the client
> sudo tc qdisc replace dev eth0 root netem delay 200ms
>
> sudo mount -o vers=4.2,nocto,actimeo=3600 server:/data /tmp/data
> for x in {1..10000}; do
>     echo /tmp/data/dir1/touch.$x
> done | xargs -n1 -P 100 -iX -t touch X 2>&1 | pv -l -a > /dev/null
>
> It's a similar (slow) result for NFSv3. If we run it again just to
> update the existing files, it's a lot faster because of the
> nocto,actimeo and open file caching (32 files/s).
>
> Then if I switch it so that each process on the client creates
> hundreds of files in a unique directory per process, the aggregate
> file create rate increases to 32 per second. For NFSv3 it's 162
> aggregate new files per second. So much better parallelism is possible
> when the creates are spread across multiple remote directories on the
> same client.
>
> If I then take the slow 3 creates per second example again and instead
> use 10 client hosts (all with 200ms latency) and set them all creating
> in the same remote server directory, then we get 3 x 10 = 30 creates
> per second.
>
> So we can achieve some parallel file create performance in the same
> remote directory but just not from a single client running multiple
> processes. Which makes me think it's more of a client limitation
> rather than a server locking issue?
>
> My interest in this (as always) is because while having hundreds of
> processes creating files in the same directory might not be a common
> workload, it is if you are re-exporting a filesystem and multiple
> clients are creating new files for writing. For example a batch job
> creating files in a common output directory.
>
> Re-exporting is a useful way of caching mostly read heavy workloads
> but then performance suffers for these metadata heavy or writing
> workloads. The parallel performance (nfsd threads) with a single
> client mountpoint just can't compete with directly connected clients
> to the originating server.
>
> Does anyone have any idea what the specific bottlenecks are here for
> parallel file creates from a single client to a single directory?
>
> Cheers,
>
> Daire
