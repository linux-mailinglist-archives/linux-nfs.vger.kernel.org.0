Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D79034070E
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Mar 2021 14:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCRNn6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 09:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhCRNnv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Mar 2021 09:43:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE16CC06174A;
        Thu, 18 Mar 2021 06:43:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w3so4023187ejc.4;
        Thu, 18 Mar 2021 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93auU8TC5nOFNXfwOL5PMfmDNd9eNbc5Moule/KTGLE=;
        b=QkYfkMuUl/hSor9sLtBtOZ+FL3IzHHESNNWbWrxdLr6oeDOIyN2W/UYfoiaaWdfWYZ
         uWNK+3we4yV7chpL6jYxDj6emZKNVRMUeMwBQz0ljTY//2c8zDT/CnhV2iCo+QP5qfvB
         bXinR7eQ8vbMR3pwbtAdBUA6bWD0LIIYAzaKo7ANVQLPUWD1+LvhrNVSeUmDTZine2zA
         b7YfiWKhTUVFJSfxj3TJ7Ti2Jlo4N1EQ0hCcX/LyOmsXNQIseOAqkT9l+Q0SYd4vUGGF
         yFdrjZZdSoKjKkfqSRbsAzh0qEaIqjZNq9mmut83oEG6AfXrJGIEAANnAiW+TvE40SwP
         wlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93auU8TC5nOFNXfwOL5PMfmDNd9eNbc5Moule/KTGLE=;
        b=ackdBcouc9RVhmvAR0+cTbZuNvhhNxaSndoHsgcTiFIzEe4NfiNl7AP2dUsRIAxHdn
         gf6SHR9TM3GynCap1g3h25Tky0hvysYo+nB/TsjvQXhYP+x2/Ad/+Zw9Sdzl0aoZ4dur
         56kHvNUthRBSAPjVYur+R5Jo8sOnt3Nltq9ilD86Ry6OsouwribtR5wwUPNiSen3Hxc4
         Bp7Yln+vYE2eT2182DnKQVc8pnOe6uWpK9yjXQAqeXhxbtchG9wnKF6DK9eazd+X+k9J
         chiCdNNlYPOqOviZC4g/ni5zchzL97AP42Ci0ahmpkhXgFJ4PdGPFy7IKXBW0bi3xxhx
         Y39w==
X-Gm-Message-State: AOAM533ZC0EyWYkJ8Ov3IpCDO3OkqYbjREq/2KR5rANOlQN08p/UH51j
        lcESBUYsvGpz57WUi5T9TO/Xuo2ayPDSAHrXk8O91la1
X-Google-Smtp-Source: ABdhPJzYMz81RcPg72Q1p6ElKEfmz0fzTW5K41yvsRleBdMao03nwLaqdsRqvSOIcDqFmBMC9L8KYSVBHZ92jNhkMDQ=
X-Received: by 2002:a17:906:a0d4:: with SMTP id bh20mr9388293ejb.348.1616075029226;
 Thu, 18 Mar 2021 06:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNvotgdUEvLBfbUNsU1ZNLYvrjO3N8ygyLo45-336u4=ZA@mail.gmail.com>
In-Reply-To: <CAFqZXNvotgdUEvLBfbUNsU1ZNLYvrjO3N8ygyLo45-336u4=ZA@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 18 Mar 2021 09:43:38 -0400
Message-ID: <CAN-5tyGz2HRq9Y7OcBDLQ4K+=d_oPe4nOQ+VM7QGU27ksJi6EQ@mail.gmail.com>
Subject: Re: Weird bug in NFS/SELinux
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 18, 2021 at 5:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Hello,
>
> While trying to figure out why the NFS tests in the selinux-testsuite
> [1] are failing, I ran into this strange bug: When I mount an NFS
> filesystem on some directory, and then immediately attempt to create
> exactly the same mount on the same directory (fails with -EBUSY as
> expected per mount(2)), then all the entries inside the mount (but not
> the root node) show up as unlabeled
> (system_u:object_r:unlabeled_t:s0). For some reason this doesn't
> happen if I list the directory contents between the two mounts.
>
> It happens at least with kernels 5.12-rc2 and 5.8.6, so it's likely an old bug.
>
> Minimal reproducer (assumes an SELinux-enabled system and that nothing
> is mounted at /etc):
> ```
> # set up a trivial NFS export
> systemctl start nfs-server
> exportfs -o rw,no_root_squash,security_label localhost:/
>
> #
> # reference scenario - single mount
> #
> mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
>
> ls -lZ /mnt    # labels are correct
> ls -lZd /mnt   # label is correct
>
> #
> # double mount - BUG
> #
> mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
>
> ls -lZ /mnt    # all labels are system_u:object_r:unlabeled_t:s0
> ls -lZd /mnt   # label is correct
>
> #
> # double mount with ls in between - OK
> #
> mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> ls -lZ /mnt    # labels are correct
> ls -lZd /mnt   # label is correct
> mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
>
> ls -lZ /mnt    # labels are correct
> ls -lZd /mnt   # label is correct

Hi Ondrej, a couple of questions about the reproducer. (1) are you
saying that only "mount, mount, ls" sequence is problematic as you
write "mount, ls, mount, ls" is correct? (2) what is your selinux
configuration. I can't reproduce it on my setup. I get the same labels
regardless of how many times I mount.


> ```
>
> I haven't had time to dig deeper. Hopefully someone who knows the
> internals of NFS will be able to find the root cause easier than me...
>
> [1] https://github.com/SELinuxProject/selinux-testsuite/
>
> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
