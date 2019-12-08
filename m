Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102F6116004
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2019 01:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfLHA6L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Dec 2019 19:58:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43863 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfLHA6L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Dec 2019 19:58:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so11619841ljm.10
        for <linux-nfs@vger.kernel.org>; Sat, 07 Dec 2019 16:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjInLVbNXJAcoeCkZ2UVa8n0Yvnc+/klAZS5TAwHv4s=;
        b=h6ddV75ipxBKXFOA9CDG/DsvE2JTK3HbVomfQE6untuDafGb0uM3UTD+kBuTeURAJr
         YaLxU9OJ6BU0yKYe4O/Q1IYMqIaS6oyUAb7OTpsABdji+FCn80FeRKA9nWv9YeQerxr2
         Ixb3YlsXil8s4tHITSEfWE+Fn1dKsFgLFg/0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjInLVbNXJAcoeCkZ2UVa8n0Yvnc+/klAZS5TAwHv4s=;
        b=YwywrzDQSfvK6cBl/sccNadVJ1AAVBH/RL4aQol5BuEeR3oxWEAX4SwqEmFlC/1NzV
         gzi/8jF720UOlXkt3acr4BRSxJ+y3/4b5KqmjNH6V7FjAU7fSx3pCw96aOZSLdPbVlqy
         ipf+GU5+acpPy293YL+WTdnq+O72wDVwZ+V9cUzBj7FoQatHPZ0ansygXtncECLAXkom
         iWu2zzZFAaDDQJM3pl6WBEVRwrCKcbeyYKdgyzE77ixRhv5IGmfcOFRe3xf8eQ3Rd9s0
         LbMgBWNbHpMc6xf34Qph/haSaYcBQoJKsd7NuEaB8hf2HYjp2lpJ5Im50xM9SszU3H/J
         PuMA==
X-Gm-Message-State: APjAAAXTgAWjTvqig3eJ0+fC7PV1VUpWMU9yPBoFqu2a2CYxar66PGaN
        215X2FzscATZJIKsoh3uksQsrlHLsXo=
X-Google-Smtp-Source: APXvYqw4ftLjEi05dyypMW/ZfsEjicMTH2FRUUjT2Rk1uCkAzuNwTe+GygwHA2enNMHAK0HiD8VGjQ==
X-Received: by 2002:a2e:898f:: with SMTP id c15mr2931069lji.41.1575766688959;
        Sat, 07 Dec 2019 16:58:08 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id c8sm8644897lfm.65.2019.12.07.16.58.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 16:58:08 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id s22so11642675ljs.7
        for <linux-nfs@vger.kernel.org>; Sat, 07 Dec 2019 16:58:07 -0800 (PST)
X-Received: by 2002:a2e:241a:: with SMTP id k26mr12682848ljk.26.1575766687450;
 Sat, 07 Dec 2019 16:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20191207171402.GA24017@fieldses.org> <20191207171832.GB24017@fieldses.org>
In-Reply-To: <20191207171832.GB24017@fieldses.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Dec 2019 16:57:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgiQO7PCgQ5YKbJ86TLEs8G_M6k2OtFBY5m2AcNOCcJ0g@mail.gmail.com>
Message-ID: <CAHk-=wgiQO7PCgQ5YKbJ86TLEs8G_M6k2OtFBY5m2AcNOCcJ0g@mail.gmail.com>
Subject: Re: [GIT PULL] nfsd change for 5.5
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Dec 7, 2019 at 9:18 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> Oh, also, not included: server-to-server copy offload.  I think it's
> more or less ready, but due to some miscommunication (at least partly my
> fault), I didn't get them in my nfsd-next branch till this week.  And
> the client side (which it builds on) isn't merged yet last I checked.
> So, it seemed more prudent to back them out and wait till next time.

The cline side part should have just got merged (Trond and you both
waited until the end of the merge window for your pull requests), but
it's just as well to have the server side be done next release..

               Linus
