Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BB96038AD
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 05:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJSDk5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 23:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJSDk4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 23:40:56 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F05B5FED
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 20:40:54 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id k3so19309932ybk.9
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 20:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hXJVQ9DB0FUahll8Z2RciffExZh0UY5x1qs6+dvw9Kc=;
        b=T6GEF58sgIohRTWy1SsU2I6pU82h2j5CSXZbQmp9X5sjAkANo/yfs0VaZZuakkAlVy
         f/QCH1waCL6pYpuTEGd0TCn3QHCmfePRiTqgftjDO9YUUqqxjfc6d8ZgnuSi/NDxhbJL
         umfFaDrfCkzj6Bl9XCn20FnD2tgU6z+agZGns11j4slTD3WWXZvVKYraUK83T0ji6pE2
         WJrt6Tn3Mk2WgavQeCbYxZOqRw7SiE3mbXdoA3IL4Gto4jz6ktQ36mTytBeUQad+NH0u
         bDKYhd/UY9PdhrQ2T5TRpxwB4Q5trOAMcsXEFl8OTU57MyJEBQslMhe+d1v+kg/p5tnF
         0GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXJVQ9DB0FUahll8Z2RciffExZh0UY5x1qs6+dvw9Kc=;
        b=XmM1j4fituQo7UVeYwFPg6cuynmiIYLfSR3HIP9H+H63AOsPDGlakcKFPyDHTjY21g
         5u8kS3wQ0xa6ByuEkFztEehC4S7q7RSQeVkzQ/tQMDMUlozd7Zn/Pk5k7UuX/Lp1hYEZ
         QpQn0+3EDV+ZrYg+ZEs6JmyRcEL0qDPy9ib/szwd5I5LrC3XSd73UlBRn0QWy5T3IVsc
         WjLUKZVYV6WR2lEeNzJuyB7l8QAhQR96ASWQ1NkFT5ffEhA8+AV9ABzlhFIdJBJbZEo3
         LjfEY8mssoAlHifHksuLpSruv/UWBUzksHH34oRek/1tsNHz9flLl0l1ZT66wSqIY7q0
         lneQ==
X-Gm-Message-State: ACrzQf2IYsxBYEwuBt9c3K00TozrfqmJJ4ZnvP64hElyHynXxXlVTjbo
        HfdyqBEQ6AulGrNKbcGTLaxi8mQ7oZcv/aFlvqV1/Egz
X-Google-Smtp-Source: AMsMyM4M38sEOglD7aoIqcT1VzBDLeXqHcGwg2l6irYxcE4XHLF6/oku/qu2SMNLa4zvBdRG8eYIcBFxMJtHico23Bw=
X-Received: by 2002:a05:6902:1542:b0:6be:e3c:96c3 with SMTP id
 r2-20020a056902154200b006be0e3c96c3mr5304528ybu.2.1666150854201; Tue, 18 Oct
 2022 20:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <CADJHv_tkpQi4F930dS6qadHHR+d5JenfeDzbvAW0okKCMndKkQ@mail.gmail.com>
 <EC03148E-4DF6-4D9C-AA02-046AAA1D512A@oracle.com>
In-Reply-To: <EC03148E-4DF6-4D9C-AA02-046AAA1D512A@oracle.com>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Wed, 19 Oct 2022 11:40:42 +0800
Message-ID: <CADJHv_vnWB3S5umacs3ft=FaaokkBbhUoXq0EQn0048MSXMKyQ@mail.gmail.com>
Subject: Re: mainline kernel fails fstests generic/130 over nfsv4.2
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Sep 4, 2022 at 12:52 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Aug 31, 2022, at 8:57 AM, Murphy Zhou <jencce.kernel@gmail.com> wrote:
> >
> > Hi,
> >
> > It's pretty reproducible for me.
> >
> > Could anyone look into it? Thanks!
>
> I'm not volunteering to look into this, but can you also
> provide more information about your configuration? The two
> most interesting items would be:
>
> - What filesystem underlies the test export and the scratch
> filesystem?
It was xfs.
>
> - is READ_PLUS support enabled on your test client? Look
> for the CONFIG_NFS_V4_2_READ_PLUS setting in your client's
> kernel configuration.

Test pass with this config enabled. Thanks very much for your time!

Regards~

>
>
> > FSTYP         -- nfs
> > PLATFORM      -- Linux/x86_64 ibm-x3250m2-4 6.0.0-rc1 #1 SMP
> > PREEMPT_DYNAMIC Sat Aug 20 19:03:47 UTC 2022
> > MKFS_OPTIONS  -- localhost:/export/scratch
> > MOUNT_OPTIONS -- -o vers=4.2 -o context=system_u:object_r:nfs_t:s0
> > localhost:/export/scratch /mnt/xfstests/mnt2
> >
> > generic/130       - output mismatch (see
> > /var/lib/xfstests/results//generic/130.out.bad)
> >    --- tests/generic/130.out 2022-08-23 07:38:25.769217560 -0400
> >    +++ /var/lib/xfstests/results//generic/130.out.bad 2022-08-23
> > 08:09:10.121494654 -0400
> >    @@ -7,6 +7,520 @@
> >     00000000:  63 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > c...............
> >     00000010:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ................
> >     *
> >    +0000a000:  1c 1d 1e 1f 20 21 22 23 24 25 26 27 28 29 2a 2b
> > ................
> >    +0000a010:  2c 2d 2e 2f 30 31 32 33 34 35 36 37 38 39 3a 3b
> > ....0123456789..
> >    +0000a020:  3c 3d 3e 3f 40 41 42 43 44 45 46 47 48 49 4a 4b
> > .....ABCDEFGHIJK
> >    +0000a030:  4c 4d 4e 4f 50 51 52 53 54 55 56 57 58 59 5a 5b
> > LMNOPQRSTUVWXYZ.
> >    ...
> >    (Run 'diff -u /var/lib/xfstests/tests/generic/130.out
> > /var/lib/xfstests/results//generic/130.out.bad'  to see the entire
> > diff)
>
> --
> Chuck Lever
>
>
>
