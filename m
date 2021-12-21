Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9500547C185
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 15:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbhLUObZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 09:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbhLUObZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 09:31:25 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2C5C061574
        for <linux-nfs@vger.kernel.org>; Tue, 21 Dec 2021 06:31:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id f5so29665982edq.6
        for <linux-nfs@vger.kernel.org>; Tue, 21 Dec 2021 06:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZvzFzs2S3EtpQxyfAOjbGJTvYwtj2QXLzUvSMpu9Rqc=;
        b=q4aoa5BUHgoTMUtuOg1yi2DWG1r/jm3agz2hMI5da49/OlIKWyfUrGp34l2h8C/RdT
         dgIZM/+Bl994uW61RdNeYLlZRnK1Y26HR4p5VcsmeF9x40ef1El6clzcPVLFxDkIJa75
         wyhj3Vs6vkW3d1znk4rWNJ09skbocdy59Yf7PXteQud7cNTEXKHTMS/aeVxihwyjyAo5
         //tIjYRzKYfx//HKgE4dpgY7J7My2Nud8siXiZXM4SVHs58mm2L+k+6L9J+p6tAAGoTV
         TtUq7RtW9Z2ABd4OzKk6UVpuGW5FyCR0c8bu86VisLWa82e70UnVWHBt3S3ji70A7Xw8
         fRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvzFzs2S3EtpQxyfAOjbGJTvYwtj2QXLzUvSMpu9Rqc=;
        b=YNYwIqPC9phV5NdwoiujS3EU2qyxjXdOXM/XqTTMEdyUGdKjM5qmK4MqYKDg+g7Gqc
         qqV0yJMub7RGxzbXGIUykck8dp9dcxjt/vVls9WbLpgkmt0PbzxSRKe7ZwsxXj8p/+0i
         vNXbUhRCxvw5fvPZrWFMZaEUfzxBVvuCQUZp1LPh/h/xX7dJPSenVdKtOwwLEg7Z4ShA
         kj1O15mfZJPo9uZOywRhkedOJyYcqfyQJG2ennWNj0URtw6eQ0iU2aN2nwi6aeePFy8h
         sv26q6mY2BDTdKHAoLV4yydc9v4DA7B0pEPzaE4v5HwOE8n7aZ2paIbGJgF4XlN0CMs/
         z/xg==
X-Gm-Message-State: AOAM533JOAj4nSkH2Z8hcJYVN5LL3y93WNNIrV4OcEpzfRa6NRLl+1c9
        fCFGrXHQ9pe6bsSzPegP1tRO/y4wL2LEjmw4+fDOqA==
X-Google-Smtp-Source: ABdhPJx7I8Nph44M9EO5/p50bEeh4GyO2Z//8rqMpi645GuJr1n5HmmwdWycKORS5Xvpkb6lRHMXDb9Jp+zpHxca71E=
X-Received: by 2002:a17:906:2697:: with SMTP id t23mr2978319ejc.647.1640097081442;
 Tue, 21 Dec 2021 06:31:21 -0800 (PST)
MIME-Version: 1.0
References: <1576494286.153679.1639083948872.JavaMail.zimbra@nod.at>
 <20211209214139.GA23483@fieldses.org> <763412597.153709.1639087404752.JavaMail.zimbra@nod.at>
In-Reply-To: <763412597.153709.1639087404752.JavaMail.zimbra@nod.at>
From:   Daire Byrne <daire@dneg.com>
Date:   Tue, 21 Dec 2021 14:30:45 +0000
Message-ID: <CAPt2mGM5jJNu_O=pjvU4UEYZ7L9pcunGedVmFP1h+J4QoMLPUg@mail.gmail.com>
Subject: Re: Improving NFS re-export
To:     Richard Weinberger <richard@nod.at>
Cc:     bfields <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david <david@sigma-star.at>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 9 Dec 2021 at 22:03, Richard Weinberger <richard@nod.at> wrote:
>
> I see. That way we could get rid of file handle wrapping but loose the
> NFS clinet inode cache on the re-exporting server, I think.

As an avid user of re-exporting over the WAN, we do like to be able to
selectively cache as much of the metadata lookups as possible
(actimeo=3600, vfs_cache_pressure=1).

I'm not sure if losing the re-export server's client inode cache would
effect that ability?

And on the subject of the "proxy" server and a server per export; if
like us, you have 30 servers or mountpoints to re-export but you might
only actively use 5-10 of those at any one time, so it is more
resource efficient (CPU, RAM, fscache storage) to use a single
re-export server for more than one mountpoint re-export. But in the
proxy case, maybe the same thing could be achieved with a
containerised knfsd with all the proxy servers running on the same
server?

I'm not sure if you could have shared storage and have multiple
fs-cache/cachefilesd in containers though.

Either way, I'm interested to see what you come up with. Always happy
to test new variations on re-exporting.

Daire
