Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A0A36627C
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Apr 2021 01:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhDTX3Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Apr 2021 19:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhDTX3X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Apr 2021 19:29:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925D4C06174A
        for <linux-nfs@vger.kernel.org>; Tue, 20 Apr 2021 16:28:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g5so54049056ejx.0
        for <linux-nfs@vger.kernel.org>; Tue, 20 Apr 2021 16:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHaZYcs7Gm9MngUxno7iElIDd60EFBb9wWN1Cmro95U=;
        b=lO47tAdZzM78sIQhVafmAsxQFDTWzh/a7VKuBV51PEVLI4ekvlN8Tzr4hm87Umpc5c
         lYLDT/5nn3NMaQUR8zJ1rV4gMaj9RQGCo87GpfxXuV1r5JVskEALFvv6Tj8hzNWnWX3W
         sR9PJI11qOzPFp4mGY0u/1C2RqyzNsgfosubWGR5GbL8WWDRSBjettKha114NLFyw47x
         gMKi25IRFcvRqovd9M/mRCM0yhThqmLqrNrJk8O8oMpNjbHf6MFAFbbKt9koiwAc3sjj
         23eYOV2eUqyuR57JjJO3wUEC2gXvvHEOCZgZkKLYonKXlLYBAVcukBv9hjDfbqi0HwNt
         xbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHaZYcs7Gm9MngUxno7iElIDd60EFBb9wWN1Cmro95U=;
        b=SzQNB/3yzSFVgd92y83P1gPINIbAIG2xMt2DoXfgdx788JE823iw8KqUvO4U3eVoo2
         UJnH5HpzcBMbzOZxzJkSS1wCabM+Rw7eJqIrtn8kFUJ1sYL8zobFQsNV48qjYqY7RA5j
         sGgn+ygW1d22mZPmSTsB4zzWCG/UIToRA/4boQnbybzJq3AWGCVqDcayufwwRatnjyR8
         NuebB/045Ufw4RsKLvCdIjRNBnPgmBzzWqcaLtsBrqI2nlSJVt3KDzNXsCHDnJaTLumh
         oEP+M8fsfWC7Yj7JC89LLNPpnrnqIaxT/lFgOnMY9J8Kg4isarTv8weN4JRHlWyhfQF+
         YpnA==
X-Gm-Message-State: AOAM530KHo7p+kld7ymx188mOMU5AKSzAN1Upc5v+PvT3Od4unmayjU+
        mygUAw7LZFFdSHghS5tHK2vZvkcLmzTc0xT4O3FhL8mg
X-Google-Smtp-Source: ABdhPJzUkO/cWjhFdv261WBHd0SDjzBVjYeVrpssthBfDKJxY80YPXbofpWzGl9un9MUIJUC3stI9hy2yMTslOw6Kmc=
X-Received: by 2002:a17:906:804b:: with SMTP id x11mr30836211ejw.388.1618961328077;
 Tue, 20 Apr 2021 16:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <061a976c-2082-bb86-91ec-f0f97a73e1ac@vastdata.com>
In-Reply-To: <061a976c-2082-bb86-91ec-f0f97a73e1ac@vastdata.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 20 Apr 2021 19:28:36 -0400
Message-ID: <CAN-5tyHb8CXVTnZuODJAKs+0QZy53dSJk0nKZPNeAhJ-CVQYZg@mail.gmail.com>
Subject: Re: Linux NFS4.1 client's "server trunking" seems to do the opposite
 of what the name implies
To:     guy keren <guy@vastdata.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 20, 2021 at 4:59 PM guy keren <guy@vastdata.com> wrote:
>
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

Hi Guy,

Current implementation of the linux client does not support session
trunking to the MDS (nor does it support client id trunking). I'm
hoping session trunking support comes in the near future. Clientid
trunking might not be something that's supported unless we'll have a
clustered NFS server out there that can utilize that behaviour.

Btw you can do multipath NFS flows by using the combination of
nconnect and the newly proposed sysfs interface (still in review) that
can manipulate server endpoints.


>
> thanks,
>
> --guy keren
>
> Vast Data.
>
