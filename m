Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406F039AF08
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 02:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFDAYd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 20:24:33 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:43596 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDAYd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 20:24:33 -0400
Received: by mail-ed1-f42.google.com with SMTP id s6so9106856edu.10
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 17:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mc/bilJW6jef3HDeoMNGD9EwGUQ8PwFvDx+T4I897DU=;
        b=MdM7GWHIy/RZ5GWfH0+yWjYQ9VXv4a/rlnRPc88tUMb9xZxWDg/w6on3lZg2WE0mZc
         e6SjiktGN4VIU3mZXrj6ESo2pWBjGMFzNsPqVhhofjkwev8xKXM4b0n6Lhr8tOMcgFAX
         wkIdmXY88Eb3E6d9ea03cVhRPjvWBSXqBqjVmUwLsvW/xkQBdVHs4XaeYeaqbZgLmCuN
         wFi2F1Zg66RTn8H0fAMtQSefBjBAOW8QqftQuw3u9ysiZmQw4ps6RN0qMBmuE2ZoAk8S
         USlsAGVTGniTG1CGoS4MJLTbRsgH9asp3T6wF0ISeiYccsnahonDdthAq3sFdkx1XVL3
         iHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mc/bilJW6jef3HDeoMNGD9EwGUQ8PwFvDx+T4I897DU=;
        b=Oi4zwwjr7ok2KZrCkYbpieCnnIytRdu4p4ySoZDH80yEQFEWktiklk9dxFOYgdHMHG
         pDw2K1Az0fhngfIg/8m2aYY/+V3uZLTLPy5/oMHlzrg0lb50TI1OxbpShB0HZk6gvKyo
         Vh65BK4RfUqXtZXbwrqmN74sbaDDalKBcRpDmhZfTaqfZLbELkp8m/1JPDB/9lNp0VG2
         jVsK8tmUrmuVUs8L5LNmT10Eh1gGWI6HIFS+imNOdw2wPQPAlq2CXaN6DizIcjfvSDOc
         3/LmMRK43WELAEfPSluJPygDClPfq0TzLjRRwlFUBySyrXakeEKVg1Aiobykr59W5xeI
         y0sg==
X-Gm-Message-State: AOAM531eb+niangEYlavmwKNtyfMsHFjttWn36Fd8R91GeDqwwQR5loS
        OEPgPXZRRyyMMDNIHRTh9RkZ+Gc1KZ05/a467e0=
X-Google-Smtp-Source: ABdhPJwRYLblJsP25SwMd6KYSc73eAs+eijMKhM6127RkaK/M6RerYR7SMGSUFE2YZK0FvJNuXpjFcYAVeESCZL8BhY=
X-Received: by 2002:a05:6402:170e:: with SMTP id y14mr1920613edu.367.1622766096080;
 Thu, 03 Jun 2021 17:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210603225907.19981-1-olga.kornievskaia@gmail.com> <162276461931.16225.7591153378472996760@noble.neil.brown.name>
In-Reply-To: <162276461931.16225.7591153378472996760@noble.neil.brown.name>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 3 Jun 2021 20:21:24 -0400
Message-ID: <CAN-5tyGAMvqjxxs6jYCFvBnjCAhVVXKHXToJ6OXKAUgNSdE2mQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] modify xprt state using sysfs
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 3, 2021 at 7:57 PM NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 04 Jun 2021, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > When a transport gets stuck, it is desired to be able to move the tasks
> > that have been stuck/queued on that transport to another.
>
> This is interesting.....
> A long-standing problem with NFS is that it is tricky to reliably
> unmount a filesystem if the network is not responding.  It is possible,
> but you need to identify all the processes blocked on the filesystem and
> SIGKILL them.
> My most recent exposure to this was when shutdown hung for someone
> because NetworkManager shutdown the wifi before NFS filesystems were
> unmounted.   This is arguably a config error, but the same problem could
> happen with a power-outage instead of networkmanage breaking the wifi.
>
> It would be nice to be able to forcibly unmount filesystems.  e.g.  mark
> the transport as dead in such a way that all requests report EIO (or
> similar).
> This is obviously a big hammer, probably bigger than justified for use
> with "umount -f", but sometimes it is a necessary hammer.
>
> Could your work lead to being able to do this?  Could I write a shutdown
> script that runs when there is no more network and no expectation of any
> network ever again, and which marks all transports as dead - and then
> wakes up all pending rpc tasks?

I thought that was something that Ben was looking into in parallel to
my efforts. In this patch series I'm only addressing the issue where
some transport is unresponsive and it's not the "main" transport. I
don't allow main transport to be put offline or removed. As you said
in that case, the tasks need to be errored out to the application. But
yes, I think in the next step we can allow for the main transport to
be removed and erroring the tasks and allowing for unmounting when the
server isn't responding.

>
> Thanks,
> NeilBrown
