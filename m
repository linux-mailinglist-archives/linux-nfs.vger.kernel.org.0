Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084933266B1
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Feb 2021 19:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhBZSHl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Feb 2021 13:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBZSHl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Feb 2021 13:07:41 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1E3C061574
        for <linux-nfs@vger.kernel.org>; Fri, 26 Feb 2021 10:07:01 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w21so12072923edc.7
        for <linux-nfs@vger.kernel.org>; Fri, 26 Feb 2021 10:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGi1eLuYic5m4rcYZqNh8mgkAlwEDiN0QXT/nR+gYhM=;
        b=j4nHZM4rmYMAKi97XFVuSkMvILjYb0WTCznfeUC1mODwmV8CeX7apvC+a/dAL1Qxfq
         FCRiqE+4lvkq/Q/zA9O8j1WpBFSJ3R3CvlIMI91RTrF11a6BOGbLGSdVWPSfQkQae1Qr
         edeSfWkZ5STK7SQ1zKgP7WUDJ2fMJH22f05GzsWplwC/Fi6wCLWcqAvm/UO1wcaWWE3f
         Y7Pmlbl4hNe+vC413vn6SuMtjJbHsIA4H28rUBC81Teo3RX58WiqP4DL1W/PL5f+79oz
         zwff8mDbSyqqCc9CIClC7ubEQelTnlIDvjTYaIszlIwY0zbVJrS9GhK4on3QnR0/0UHx
         rXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGi1eLuYic5m4rcYZqNh8mgkAlwEDiN0QXT/nR+gYhM=;
        b=JQtjvEWRI8QT3niNmNviUo/rhSGEfMU6QoV2U0RKmK41+Zdnk3mcZO+mZCuU/hLeqw
         6OO+74iwOJJgojI2CYD0nD6+TQwTZpjS9z3PJITPYCfxLtY2/Twy5WtrI2RiGn7iMW/B
         vS188Kc9dM/7u1BAAAEmGvxhMNCqCBpEPBWAdWK66RhradtbkEfgiP6HfKq4hbkt1d+k
         RUNqGHiEJ/voS/r8KJHtYz3c3tH+47UPRZu5Ylc8A60LpPb4r2HtR8G1nlTq5Zg9ajFP
         cRwddZai+qYe/7Lug1qUrRUGBw48vh5hkblB1HT62QjeL+EEYttvsfMljYwJt7c4ewS5
         i5dw==
X-Gm-Message-State: AOAM532hifZMDbDBf06w4Gr5J+R+gARUnwz9rvxS9EPyFR+vRtUbX6+o
        /Xtk1kzVCl7JVtT3EPMrP/rkHRqdUWB83iA4ms4aIiWCnug=
X-Google-Smtp-Source: ABdhPJz5AJ77utsh8ESVtu+7SdB/ldhXaMC+5l0XBUy7aMnAQ4U1ir9mcJ2x283x4w3si40M/VyOuSv2H0Mu0PjqdsQ=
X-Received: by 2002:a05:6402:26d5:: with SMTP id x21mr4837615edd.50.1614362819845;
 Fri, 26 Feb 2021 10:06:59 -0800 (PST)
MIME-Version: 1.0
References: <CAFX2JfnuPuE7Bd5nAwgwrVQQ84vAMVwpPf0SFZFTwpX0rib+Hg@mail.gmail.com>
 <CAFX2Jf=SXFy4PbWBGJeFUq5TQbVXpYMNZL8B=kckN_tFX-j01w@mail.gmail.com> <CAHk-=wi8guJetYqTaypq44Et49d3ABEJiOqdNwXU=ztZ=JwBng@mail.gmail.com>
In-Reply-To: <CAHk-=wi8guJetYqTaypq44Et49d3ABEJiOqdNwXU=ztZ=JwBng@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Fri, 26 Feb 2021 13:06:43 -0500
Message-ID: <CAFX2Jf=Kf18mdUkmVe4XM-Qh3WfDGz63hPhnGgc-o9apz33Sdg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS Client Updates for Linux 5.12
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 26, 2021 at 12:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Feb 25, 2021 at 2:17 PM Anna Schumaker <schumaker.anna@gmail.com> wrote:
> >
> > Sorry to bother you since I know you're busy. I haven't seen this get
> > pulled yet, and I'm worried it's slipped through the cracks since
> > we're getting close to the end of the merge window.
>
> Hmm. I don't have this original email AT ALL in my mailbox.
>
> Maybe it was marked as spam and I never noticed it. Or maybe there was
> some other issue with it  getting delivered.
>
> Anyway, re-sending was the right thing to do. Will pull asap.

Weird. Thanks for pulling!

Anna

>
> Thanks,
>
>      Linus
