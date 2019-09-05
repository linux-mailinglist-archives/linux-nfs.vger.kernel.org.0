Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4F6A9779
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2019 02:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfIEAFz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Sep 2019 20:05:55 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:42468 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfIEAFz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Sep 2019 20:05:55 -0400
Received: by mail-vs1-f50.google.com with SMTP id m22so294039vsl.9
        for <linux-nfs@vger.kernel.org>; Wed, 04 Sep 2019 17:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7UhoxhGYQFRIUho2ck0sgr1i5vdo/L1hboF0b73um5Y=;
        b=RySJnSaS/371/6irNfq1iHAq/0Irsq/g+ONajWA2yfwviziEkq0JVRjd3lCFjtlzvT
         94RzDxx7Gu8Xi00y+J+B2GL4De86w3Sm7BSMHGGaDfxbhQsPMauixhsIXcjd6ogQgA3G
         hNthEnc9CfbT9NdENLW0HiQIvlZwGs/QPKA/gm+BLqQHgIvU5e0pF+FuVWNUuyIpx04F
         f2B7XI25ab8hcR0E2PJYtBaovoMunpMOB/ZG+8/ybWYdDv+7k74bWDJ7aHo3NSyLmsFa
         9GFu34v1PQtmW/Alr2B05pIqife4EHwAI5+8AQmBMlaU9Uu7r+pXfpgkMLbJlkxbkeqN
         ciYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UhoxhGYQFRIUho2ck0sgr1i5vdo/L1hboF0b73um5Y=;
        b=VR+jjqJf3btiSGRg6IGi7GIYlVcwOU3jToywsjC0nVgleqHKfnx1ROgZJhs3yJWo5f
         ZFqC4xhII/YjOPvOjrd4TjxLxVOL/JeCCefI/cirLIZ+QS90FcZ7/26vY4AcFrnam736
         oVDzEfyLbRr4Bd17KNPKsJ/VRHyPdlws1NyhygVhSROdSqzJk7QJKkb7JtIizBKlJxmf
         1OGwRQ0R6qAJNeaA+U6T4Ihxyw3Abz0Q2C/BWWQ0TekcCZ0PHAKdepK985+YNSLoBgAB
         mUfpcSOE0WGwhuLjYGRozNJkjiHuorDMYWSyS0zV1FwSU4s6Z0rtzVJpUvG4f1wOhCpD
         cB3Q==
X-Gm-Message-State: APjAAAWN2X1p6K3/YmAAALSeIb33aoxiKQeYvStZXKOod1QS9oGZoTjI
        kEnFNoMNN2ppHHnvH/Wl5lu1P5CCHzhgBLNIuQk=
X-Google-Smtp-Source: APXvYqwl1emc9GyjkT8Ybs07grfg1A/om/udun6PwxE1ZblFxkWE4NGJ63urjwY+1jDuhPIJm4/jCZuSXvP348XhA+g=
X-Received: by 2002:a67:10c6:: with SMTP id 189mr309046vsq.194.1567641953823;
 Wed, 04 Sep 2019 17:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com> <20190904205015.GD14319@fieldses.org>
In-Reply-To: <20190904205015.GD14319@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 4 Sep 2019 20:05:42 -0400
Message-ID: <CAN-5tyGcT6rCpzOB3coj4H19-BuDsBRheD=rsRHZthn7STNq0Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] server-side support for "inter" SSC copy
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 4, 2019 at 4:50 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> What do we know about the status of NFSv4.2 and COPY support on Netapp
> or other servers?  In either the single-server or inter-server cases?

I'm unaware of any other (current/on-going) implementations. Netapp is
interested in having (implementing) this 4.2 feature though (single
server case for sure not sure about the inter-server).

>
> --b.
