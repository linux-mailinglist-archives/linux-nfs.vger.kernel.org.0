Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E0A2DD9DE
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Dec 2020 21:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgLQU0m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Dec 2020 15:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQU0m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Dec 2020 15:26:42 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3C4C0617A7
        for <linux-nfs@vger.kernel.org>; Thu, 17 Dec 2020 12:26:01 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id y19so60888623lfa.13
        for <linux-nfs@vger.kernel.org>; Thu, 17 Dec 2020 12:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CikbSbNMtOT1DkJUvzo0sBjOQ+qtDs9BHGAn5VvobJU=;
        b=ezhj7zQbSkXgdYHrDhrfOgNHKRUEiPlxnmymIeQuNKzeqbH0fooXfYbJyHgqpX9nGX
         /EG4n8UUZVskOIGZjgwk8TfMVIq3xKlBWjqzggGGMiCDQ2TuuV0sEB4yZoSWnCrgtEJ9
         asTjuWuE4GO4tcoOS5l8wfbGu1w6tUTvGFLiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CikbSbNMtOT1DkJUvzo0sBjOQ+qtDs9BHGAn5VvobJU=;
        b=SpPSYSl0CID+fHG7hKlKZdH6mNdjoLt4uzcbJEQcsIsANaBTqagDjFbkHs/xuzl4+V
         C/0pvQVM7+bs6n4nheEN3E05RbrGWChPG5oPaTBkXFaUYEKm/8qWaNGZAydUD3w/R5o7
         SsOVRN4OjcNfk5OuU960y6hF023KxfsjK1/OU1t+BuUVJbekKqhVAfyjCn4MnG8TylTb
         IKRqTUN2A+Y/8BLzIJqWgbNa2J6VMolDKjpvniqySZrbVAfoBjkef/YFSK1XWu+UCPYR
         OWQrb4gM8hCzWYAGgHjks9KFTTOflaerNSB0ACkuSEDM9ewcaKc79PMsW3CN89JYeBiS
         Gwig==
X-Gm-Message-State: AOAM531L5DmPX8V0SZlAX073ipyJ8uZk0CjrVuFw/3WbB6mELqozp8UW
        yyvvtV/opAmj2ZHPlnYFz6i7ZEiz6ZP8Dw==
X-Google-Smtp-Source: ABdhPJxWEfpWMF56kCtm0fSoh+vfMr4UNe6FXTFKO0jVPaX3ot28/dAbfBF/1AJ+kyo4jJAELDzoDA==
X-Received: by 2002:a19:7906:: with SMTP id u6mr183918lfc.632.1608236759899;
        Thu, 17 Dec 2020 12:25:59 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id z23sm688205lfi.1.2020.12.17.12.25.58
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 12:25:58 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id l11so61018851lfg.0
        for <linux-nfs@vger.kernel.org>; Thu, 17 Dec 2020 12:25:58 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr190413lfc.253.1608236758308;
 Thu, 17 Dec 2020 12:25:58 -0800 (PST)
MIME-Version: 1.0
References: <a47c68f255f9fd9361f0c17ccf1273d905fd0bd1.camel@hammerspace.com>
In-Reply-To: <a47c68f255f9fd9361f0c17ccf1273d905fd0bd1.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Dec 2020 12:25:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi74uq4CGeWtSYfMcdgWdpkiwbM5u7ULryCOPM1ZAdFXw@mail.gmail.com>
Message-ID: <CAHk-=wi74uq4CGeWtSYfMcdgWdpkiwbM5u7ULryCOPM1ZAdFXw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client changes for 5.11
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 17, 2020 at 10:05 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
>   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-
> 5.11-1
>
> for you to fetch changes up to
> 52104f274e2d7f134d34bab11cada8913d4544e2:

pr-tracker-bot doesn't seem to have reacted to this email.

I suspect it's because of the odd and unfortunate line breaks in it,
but who knows. Maybe it's just delayed (but the other filesystem pulls
seem to have been tracked).

Anyway, it's pulled, even if the automation seems to not have noticed.

            Linus
