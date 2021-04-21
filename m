Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BE5366CB6
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Apr 2021 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbhDUNZU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Apr 2021 09:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242225AbhDUNXl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Apr 2021 09:23:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E868DC06134B
        for <linux-nfs@vger.kernel.org>; Wed, 21 Apr 2021 06:21:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u21so63508642ejo.13
        for <linux-nfs@vger.kernel.org>; Wed, 21 Apr 2021 06:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kn2XNLw03foYr2odvIZOoau0/B6Wl4jSakj8XYK+lMc=;
        b=asVUn/wZ8VmMEFkuadq4OSIPvvmQdwrTHC6+E94p8YUmHkKClFtxxqz0b7i5V+m9hv
         wxMssoEAQP5L1QIJDE/fDpykk7PyGc89UgoVR4N8DQbQVhJovYlrENgG5PAZ1P3nA3oA
         NJd+wX4mpEY08l/ODzVEdls5XbpByhqQbthHQJz1fLtGpPa9Wxzt8HJGrYgp+VlTGqvV
         9YFADtVHl1aOadOHY6ba74uEOUVIcennj7qU13dJPa5t8Wl+uyGGA/ts6yOnd/zsqaV8
         42jbtY4tCxSlL1Bq6w/nywFLWsjBE+Vm+VF4UmI9/RyWSrjsaZ9x51uydh21LxGQvjgm
         qK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kn2XNLw03foYr2odvIZOoau0/B6Wl4jSakj8XYK+lMc=;
        b=S4DGwtsFjKIVmzn/uuHNtbzpJ+lqVpbW4X6/aSECSM85/D62YQgt8mL+SJ1PrBSer/
         qeWLAkosUpZBu9ZZc5ie96KDeiXHz+2NwQVDSACARKeUmyVy4jyiNdyNcHegHsWXebOj
         EeF65e26EHwQC+q6QG46aVGKoZXjEYLtzKNmGJcK7xc/JMdllleXAY7zkVRxq8fl141A
         8Ty7ZMhNBbTd1q60lpEyNcnQGF8irXFv2ihkx39f3pU3CI6M3ev78pgTV5ukcHvpPoIC
         jcdavIbhXa0MOXLzCBZow609rbJ5FSTMywvm/djaiZMKi2QOBwe9douP8O83LbmgzOEE
         3BHQ==
X-Gm-Message-State: AOAM530A2v++g9dLv34PgZqhVcEW6WLZ9HFfT+cnrTlu/ctVussKYhot
        Hi3OQ4BUSa2m1hYA2xaTLF2PAWDLEwjobW7zyb5SA88l
X-Google-Smtp-Source: ABdhPJwVKgPca07w1ZhXa9+JUjFvZ8bgx11cy9VjuoCldk6P5ZFNe/nSLwSN/eolRVVB+GR7Tgb2/VpBqcFJxozvvCU=
X-Received: by 2002:a17:906:a0d4:: with SMTP id bh20mr32816972ejb.348.1619011305552;
 Wed, 21 Apr 2021 06:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <061a976c-2082-bb86-91ec-f0f97a73e1ac@vastdata.com>
 <CAN-5tyHb8CXVTnZuODJAKs+0QZy53dSJk0nKZPNeAhJ-CVQYZg@mail.gmail.com> <4999b214-db58-a5ab-3097-523cf9a51c75@vastdata.com>
In-Reply-To: <4999b214-db58-a5ab-3097-523cf9a51c75@vastdata.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 21 Apr 2021 09:21:34 -0400
Message-ID: <CAN-5tyE5oZdBYaQ=S6+7Rm4_XMEt0iuF7TtG+Ysfjd-Y+oL+2w@mail.gmail.com>
Subject: Re: Linux NFS4.1 client's "server trunking" seems to do the opposite
 of what the name implies
To:     guy keren <guy@vastdata.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 21, 2021 at 3:28 AM guy keren <guy@vastdata.com> wrote:
>
>
> hi Olga, thanks for the response. more comments/questions below:
>
> On 4/21/21 2:28 AM, Olga Kornievskaia wrote:
>
> On Tue, Apr 20, 2021 at 4:59 PM guy keren <guy@vastdata.com> wrote:
>
> Hi,
>
> when attempting to make two NFS 4.1 mounts from a linux NFS client, to
> two IP addresses belonging to two different hosts in the same cluster
> (i.e. the server major id in the EXCHANGE_ID response is the same) - the
> linux NFS4.1 client discards the new TCP connection (to the 2nd IP) and
> instead decides to use the first client connection for both mounts. this
> seems to be handled in a hard-coded inside the function named
> "nfs41_discover_server_trunking", and leads to reduced performance,
> relative to using NFS3 (which will use two different TCP connections to
> the two different hosts in the storage cluster).
>
> i was under the impression that (client_id) trunking is supposed to
> allow to multiplex commands over multiple TCP connections - not to
> consolidate different workloads onto the same TCP connection.
>
> is there a way to avoid this behaviour, other then faking that the
> "server major id" is different on each node in the cluster? (this is
> what appears to be done by NetApp, for instance).
>
> Hi Guy,
>
> Current implementation of the linux client does not support session
> trunking to the MDS (nor does it support client id trunking). I'm
> hoping session trunking support comes in the near future. Clientid
> trunking might not be something that's supported unless we'll have a
> clustered NFS server out there that can utilize that behaviour.
>
>
> i see.
>
>
> Btw you can do multipath NFS flows by using the combination of
> nconnect and the newly proposed sysfs interface (still in review) that
> can manipulate server endpoints.
>
>
> the problem with nconnect is that although we will have multiple TCP conn=
ections, they will all utilize the same session, which limits the requests =
parallelism that can be achieved (since the slot table size is the limiting=
 factor for the number of in-flight commands).
>
>
> the same problem will also exist with session trunking - while when doing=
 only client-id trunking (with a separate NFS4.1 session per TCP connection=
) - the number of in-flight commands can be increased linearly to the numbe=
r of TCP connections.
>
>
> is there any way to work around that?
>
>
>
> p.s. is there anyone actively working on session trunking support, or is =
it just a "future roadmap item: with no concrete plans?

It has been on my todo list but I've been having a hard time finding
enough time to focus on this.  I do believe that having a proper
session trunking implementation (where the client discovers server's
session trunking abilities via FS_LOCATIONS) to achieve multipathing
is the way to go and sysfs was never the intention to provide
multipathing (at least not in my goals) but rather a way to manager
transports in situations we don't have a good way of dealing with
otherwise.

I think the current maximum number of concurrent v4.1+ requests in
1024, is that a too low of a number? Btw, I'm not aware of any servers
that can do more than that (but my server implementations knowledge is
limited). If that is so, then perhaps the focus should be on allowing
for a larger slot table?

>
>
> thanks,
>
> --guy keren
>
> Vast Data.
