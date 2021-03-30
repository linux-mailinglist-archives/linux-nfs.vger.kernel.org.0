Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624C034E66A
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 13:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhC3Lij (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Mar 2021 07:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhC3LiR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Mar 2021 07:38:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A9C061574
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 04:38:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o126so23332144lfa.0
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuWdb2UU0HBDVPn1gEB3JZL+EjyIlGueAvnwArWe1k0=;
        b=KAfP1K14PeDihNvXZZ4kmtKfsape70nl/uEP89GNInObS++OQuu29sV9tBdpeGEJYH
         smy4f32nac6t3vD/b48Rbir+freCT6rciqdDXEjSFppcdspM3/JBzsw8wCnohDQ8LfSc
         zel9xMP9HW5smJevf0lmYPyv8tuhyYFJ80ljMCLb74eX4h8j6g54QXNmDLyfNX+xo23D
         1qvYauYLivknN5waKWP7TTZ/LW4eDg/Jhzy6kcBXjXf5eRRWaNUee8iAOkMyQrWkFMVz
         bNCHtXEFruW0wP7IpL1+zFuaOGS2rvyZOsD9GMdAugO4ZNDzfjna9zNouDHSX4Rq0lD9
         WLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuWdb2UU0HBDVPn1gEB3JZL+EjyIlGueAvnwArWe1k0=;
        b=ibB2j2ncIsOWtS6NLMLy2a17k3I1ZnBMN/DJMXIPK+w7RyJpL4w9USjTIk8JZbkFSB
         0dk9LOauWXKJSfXfCE/UVRqJmapabHGpW7pgTTjkbpRym0RZT7ILTvtsCm6l+oN1juqv
         FKcEMKQIJzwDjtBnhe7hwzosv8dFa0xEdcRGoAEG/12wML1Ag0B5hjrdpQBjpFGksYhV
         rZccxpZIkmPagPGFRsBjMPY5SCRmufK/Me/U7qZVRyUDoo6eWQkoEgqOO2EAN1rV7yIR
         3WYIyzOVZy4V9jezzr03DuxemLha3twrpa46W6TrrQ5TKyTS3Aouwqx/PYq9EVDb5n4P
         37iQ==
X-Gm-Message-State: AOAM530OAgIqFHSx/pIbHjOS5H7huAOVFZJI8M8KFlwkEJzg/Uc1n1fH
        SlZ1SK3sSq1vliR6B/CNc60t9qpZaWelWo+WCX2HaVQKzcHSdg==
X-Google-Smtp-Source: ABdhPJx2j8UaYRQgf8ocXwg3M8noAtgzvRlzwE43+zbRGgDnpCJfV2ngu7xi7i6Uxu3R0NyEZYlRi111q1GoCUA/pV0=
X-Received: by 2002:a05:6512:1108:: with SMTP id l8mr20407561lfg.592.1617104295371;
 Tue, 30 Mar 2021 04:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QRt4vr+CUgP-4xkVQwLWNZMHo-w6TwU8bFwzuZcUc1RPi-RA@mail.gmail.com>
 <20210325213421.GC18351@fieldses.org>
In-Reply-To: <20210325213421.GC18351@fieldses.org>
From:   Benjamin Maynard <benmaynard@google.com>
Date:   Tue, 30 Mar 2021 12:37:39 +0100
Message-ID: <CA+QRt4srUGGgqYPs6bufihOrC8wUZ0-B5yzXjN7rrh=EdTatAA@mail.gmail.com>
Subject: Re: Input/output errors when mounting re-exported directories that
 use crossmounts
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for the insight. That looks to be the case.

With debugging turned on the following log entry appears on the
re-exporting server: "Cannot export /files/disk2, possibly unsupported
filesystem or fsid= required".

Understood that there are no plans for a fix in the near future, just
wanted to put it on the radar. Will figure out a workaround in the
meantime.
