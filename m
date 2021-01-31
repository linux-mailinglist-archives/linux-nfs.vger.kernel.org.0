Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1483C309EDA
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Jan 2021 21:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhAaUZI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 Jan 2021 15:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhAaTcA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 31 Jan 2021 14:32:00 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA67C0611BE
        for <linux-nfs@vger.kernel.org>; Sun, 31 Jan 2021 11:22:31 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b2so19858556lfq.0
        for <linux-nfs@vger.kernel.org>; Sun, 31 Jan 2021 11:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcpZ+zIFTh/+vz3FgyVcp4oMhtiQGE8wtz4bP+gP9JE=;
        b=WJ1gjfyXL9YRRBEf8/+jVE29cSlaY7PGBvbWaUPYLrM8DtvlCN8LOApXCdw4sX5JMq
         4d58rwMEfVkkmpLAB7wxu1BgGMhvddRpjN04hj8ZCyOdeM6XAkTziJp0dd8/HEB6lyT2
         4W63bb30rIjbJEyRw3stRFjNRCsW094Tiq05E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcpZ+zIFTh/+vz3FgyVcp4oMhtiQGE8wtz4bP+gP9JE=;
        b=RIu7xrCUk5Q5y/9nvvxIwZdzR/3ZFtExEQ126DaXjX2Stsq+dzxtBp6/uv/UnlwAvg
         NXeVW8P4Ck/S9AgMtdJUJz+W9pLH502MIwWFXiF5iHnUY7G1RhRAVElyUypQdPEIDXBP
         1vRpmF5Lvj2BJvEfw/Sn7Zp7YhiCZhr0rqthdiH7eKQZ9+BBLs4pY3Xx/ZKm9nq44x5y
         2J2h/acaAHAGYO2BszX5IsEM3Hu7ovTzCcgS5xGPxZ8xVPv/FHg7rw2NEjEEKC7LXJZb
         /ZjqSGkqzgCIY6I+vjYD63Wc8k2TZTuGxYU9v7XVWaL1Pgf0UI/U4smtr4ontXJMT1AO
         dApQ==
X-Gm-Message-State: AOAM531L8LUSiSvO5tuWWDjnOWUhmzskhTsQzXVaAPNxkr6zzgQQEPQ5
        T78sh98mkJ0f3SfJ3t0EyL2Qw1Ns0o43/A==
X-Google-Smtp-Source: ABdhPJxateL8weYTT3RWWzmfDfggNKQbCNwh61WM/o1ppXCIMjniR1Bat3hrDDpiLyXdVtxCkBDWXg==
X-Received: by 2002:ac2:4ac8:: with SMTP id m8mr7516477lfp.115.1612120949744;
        Sun, 31 Jan 2021 11:22:29 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id b28sm3540112ljo.33.2021.01.31.11.22.28
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 11:22:29 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id c18so16914373ljd.9
        for <linux-nfs@vger.kernel.org>; Sun, 31 Jan 2021 11:22:28 -0800 (PST)
X-Received: by 2002:a2e:8116:: with SMTP id d22mr7914619ljg.48.1612120948527;
 Sun, 31 Jan 2021 11:22:28 -0800 (PST)
MIME-Version: 1.0
References: <8eb145f609386c98be1ec6381424cf408804ac7d.camel@hammerspace.com>
In-Reply-To: <8eb145f609386c98be1ec6381424cf408804ac7d.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 11:22:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjtGGxGYT6aVaGOxwSp2YtdVdOOQj2nUiPiQHhWTHmcwA@mail.gmail.com>
Message-ID: <CAHk-=wjtGGxGYT6aVaGOxwSp2YtdVdOOQj2nUiPiQHhWTHmcwA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client bugfixes for 5.11
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jan 31, 2021 at 8:59 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
>   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.11-3

Merged. However, it looks like you won't get a pr-tracker-bot reply
because I'm not seeing this email on lore.

So I'm doing these manual replies for now, it looks like the mailing
list is not doing great.

         Linus
