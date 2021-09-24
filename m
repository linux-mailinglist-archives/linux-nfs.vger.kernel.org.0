Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89A9417A2B
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Sep 2021 19:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344909AbhIXR4P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Sep 2021 13:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344581AbhIXR4P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Sep 2021 13:56:15 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8C0C061571
        for <linux-nfs@vger.kernel.org>; Fri, 24 Sep 2021 10:54:42 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id x2so11345348ilm.2
        for <linux-nfs@vger.kernel.org>; Fri, 24 Sep 2021 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=srf-ext-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kz774dzTcHXHz+bMQBLNa+UKnPuLtSljkfaiawFd+EE=;
        b=ALY51r0rYAFSb7zxKB5Xvizh3booKpd0keIOzNriLqT+5nQv/OuEKDI7V/GUerVVzA
         h6ilBQ/DU71E0SM61pBwVuDPfzgJTkeB6k4MDOAoK+tDH/FNFpaIh/hhZa+yfGVeHLY9
         VN9ma+ZffVpJ7HX5KCWY6xu57Cm2pGRsWwDScnXwu1/cLQ1BmrRWlt7ucsQkgfDM5YBH
         iLhhYm20fuLIj+1J1/JEndBFoP7Bl1hKCziIQcYWbo6GjAFYLuoVlYLw0HnAYfsFvHeF
         /JQPcNo9AKbIZL73Wp6DZv/i/uvCRM0hlMHIg0ZPdwoU5zupj7scpiEeOUWiGH9nnSgv
         wNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kz774dzTcHXHz+bMQBLNa+UKnPuLtSljkfaiawFd+EE=;
        b=BmZqkku6ATn+jzfKzY5Zylyl32JP/Y+4d5HS/PPJ2CrynD5XRNQtJegsRMPSFhsbJX
         vKYKqVu+QheSaXWN2Hp1uKlXOHLgrZ8ULwtYYq2tqe+w62VoqqrIV8t4acrkT1cN0VVo
         fd/aac/VNu7lYbTzI6VYmMB7UV3KUQldQDWxo6iRuS8+VwWPtdUqP1rEMgOEQ81QAUPJ
         Z43gH4I6+BQikljEt9Z8P6TvEJH+y0f7ZUReE0J409vkTQgbL97R40T+sfBIs3Vj/uYB
         i8gkTA7wKj6RLq0ff36ZEVWq6GK4zxRDeMQTS18O8xkMbt8He48lvU8k7EmCpj5+Rfo1
         xRgw==
X-Gm-Message-State: AOAM531dyj70teIbGoHIfS/rtHu8mP4V5lWQbu3+XxPGiiHmT9fyEylg
        J2U4CG06TptvBPlj6QC6bkXy0OOWIHAkZm10pzzH6D6CNEAbGQ==
X-Google-Smtp-Source: ABdhPJxdy8oaC/aoc/RT9aWUo/RVl1NxFnKU9zyvnFTD8VtHVH6T/ea9b6kxi15YNupxOMkTmBgkO1AFYtAXYYCFtew=
X-Received: by 2002:a92:d90b:: with SMTP id s11mr9034956iln.206.1632506081494;
 Fri, 24 Sep 2021 10:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAGw7ksJxiKkOf2F9FUDCa_mSAkoU6U=vCXFcupsu+izKuEE1WA@mail.gmail.com>
 <20210924163948.GB13115@fieldses.org>
In-Reply-To: <20210924163948.GB13115@fieldses.org>
From:   Kazi Anwar <kazia@srf-ext.com>
Date:   Fri, 24 Sep 2021 12:54:30 -0500
Message-ID: <CAGw7ksJGjG0PUZqr+U+ssq_6YHgJ4cga40MCdpm8b_rYn1a5OA@mail.gmail.com>
Subject: Re: nfs4err_delay
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Yes, both clients and server are centos 7.6. And the NFS4ERR_DELAY is
a response to a REMOVE.
I will need to check on the locks the next time it happens. Can you
share what you are thinking?

thanks,
Kazi

On Fri, Sep 24, 2021 at 11:39 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Wed, Sep 22, 2021 at 03:56:23PM -0500, Kazi Anwar wrote:
> > We are running nfs v 4.1 on centos 7.6.
> > We are seeing an NFS issue where when files/dirs are deleted from a
> > client they are occasionally stuck at unlinkat system call(according
> > to strace its stuck for 100.5 secs every time). Can anyone explain
> > this behavior?
> > Running tcp dump shows nfs4err_delay status sent from the server to
> > the stuck client.
>
> Client and server are both centos 7.6?
>
> Is the NFS4ERR_DELAY a reponse to a REMOVE?
>
> Does /proc/locks show a delegation held on the file the client's trying
> to remove?
>
> --b.
