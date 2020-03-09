Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6161417E652
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2020 19:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCISEp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Mar 2020 14:04:45 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42459 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgCISEo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Mar 2020 14:04:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id 66so10472243otd.9;
        Mon, 09 Mar 2020 11:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgs8oWpZQnH5qRObxG0wmFLSg6UwmwwZ+TH8F8blMGY=;
        b=V0AAX2JEPmWjiBIj6+GqL4IfltS75Sodc8a3O0FKTKmqMsncMtb/iTxvF2Wvne73+r
         tB1BI/uD017aqDR3b6upC27TDpLI1iD2C1KuTl5pm6YeiwpWq3kR2Vewv9X6FYesa/k5
         DG+wsc6ugMwdaPf9Esocze28A7kIrKVp32Umzwu96q1Wj80+KXqT2qU/wd7h/TeAL6tT
         8JK4rd9cRzx/oq5BeOysgZBVCywOGWMk+cBzgHzthlLy8NSWTD2PCbGB0Ftn5WSUTJz9
         O7aql6nxnx+y/Tb2GqLW8A+w8cYc3Obt3eVediPRTI4qbwOKmQ4F/JJUjovJLZO107De
         8Jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgs8oWpZQnH5qRObxG0wmFLSg6UwmwwZ+TH8F8blMGY=;
        b=Xs409BdSLtS8AFG9defLwUWpAkj2cHFAk/kTjGZKsbBnoJDDjSebiGf4Np5gtUy3XF
         o85bnuUofMGyUB3XneuLa9bb12waVvu43gqTNtDaNcX5G8beTMjnzkA6XQbGJOZa6tqF
         BI/zJNS5gpb2AhqSJLrMMlBBlGIntpxJpvTYYJwJy25EQHhs1HkP0FkMqIymopPHX5XX
         SYXo20PrpbsRWsQoX4l9329gfNO2iZpFyQi5enrFXorbZE5ZNUNICsegkrO10uhaLEr+
         vAFCEVR1yXG+b2+MA7hCAirezp7Zd7b7TpSgs0K6aho5SKBonQ7Jqs5SD/ZjV6APog36
         YQTA==
X-Gm-Message-State: ANhLgQ2rybNtILeuTVPbttFvNJQ+78qsW3kp5+Zq6aR7nARMKO9lBnyh
        PVxIuk6TQgjVi7q5wPMMBx0YT8kG3Cxw4zBilYs=
X-Google-Smtp-Source: ADFU+vvuCym1VqUJJQ1j/4xBlxkOHwytSA3QSAMv8CtyXx3hlu33pGs1cvaltYOHCdm0WkkoxN64R59gTOAUoyeeqH4=
X-Received: by 2002:a9d:67c3:: with SMTP id c3mr5584575otn.340.1583777083488;
 Mon, 09 Mar 2020 11:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200303225837.1557210-1-smayhew@redhat.com> <6bb287d1687dc87fe9abc11d475b3b9df061f775.camel@btinternet.com>
 <20200304143701.GB3175@aion.usersys.redhat.com> <CAEjxPJ7A1KRJ3+o0-edW3byYBSjGa7=KnU5QaYCiVt6Lq6ZfpA@mail.gmail.com>
 <20200306220132.GD3175@aion.usersys.redhat.com> <dc704637496883ac7c21c196aeae4e1ab37f76fa.camel@btinternet.com>
 <CAEjxPJ6pLLGQ2ywfjkanDNZc1isVV8=6sJmoYFy8shaSGr972A@mail.gmail.com> <41dadf5423aa1b9c0910ac3d805e6caf785dec8f.camel@btinternet.com>
In-Reply-To: <41dadf5423aa1b9c0910ac3d805e6caf785dec8f.camel@btinternet.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 9 Mar 2020 14:05:34 -0400
Message-ID: <CAEjxPJ7p2=ajPT2c8qJKwAtv6uwtNAKRwVcg5rzck5B6KNsHUw@mail.gmail.com>
Subject: Re: [PATCH] NFS: Ensure security label is set for root inode
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Scott Mayhew <smayhew@redhat.com>, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, bfields@fieldses.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, linux-nfs@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 9, 2020 at 12:41 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> On Mon, 2020-03-09 at 09:35 -0400, Stephen Smalley wrote:
> > 1. Mount the same filesystem twice with two different sets of context
> > mount options, check that mount(2) fails with errno EINVAL.
>
> I've tests for the first part already, however with NFS it returns
> EBUSY (using mount(2) or the fixed fsconfig(2)). On ext4, xfs & vfat it
> does return EINVAL. I guess another NFS bug. Also mount(8) ignores the
> error and just carries on. Here is a test using the testsuite mount(2):

Looks like selinux_cmp_sb_context() returns -EBUSY on error instead of -EINVAL.
This goes back to 094f7b69ea738d7d619cba449d2af97159949459 ("selinux:
make security_sb_clone_mnt_opts return an error on context mismatch").
I guess you can just make the test accept either -EINVAL or -EBUSY for
the time being and we'll have to consider
whether we want to change it and what would break if we did.
