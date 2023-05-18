Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AED70895B
	for <lists+linux-nfs@lfdr.de>; Thu, 18 May 2023 22:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjERUVD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 May 2023 16:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjERUVC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 May 2023 16:21:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE5A10E5
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 13:20:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96adcb66f37so483919966b.1
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684441256; x=1687033256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IYfdWrhTM0vY/FXglu2FZMvY3juyMMZCYRjkGLrO6E=;
        b=AtVJImrAct/STCz5ITh2s2IGvooAj5lY2dmK+hICGXx69+xdSUSzDQMz5Y/yG/E9J2
         QLA8lE5zqNl3KAQbStZt8kX1Hvg7A5MZGR6KNtGpU8YYJ7Ch7Zxk/wp/21Hng4oQUwLB
         WgbRk7F1UnSvpqD2M/Wddb8fGpjac9SwcJIcvTuSInQ059IQjEvPGKX4tZviC05GNiiu
         REVpCiv58zXMZ4/VSBWFY2CleWPeUKGGvSXb2d7SoaMYDhWAUZwr1Uh8sw7X9QjeJr8m
         Za6XwYjGVNMB20c5FE1u5tVghSzUQZ7q2ZrknbmpzXCDu82VtC8LES8pzi4MI5iIkODT
         n73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684441256; x=1687033256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IYfdWrhTM0vY/FXglu2FZMvY3juyMMZCYRjkGLrO6E=;
        b=gauL5SkZ4/wL/Kh17MW1iIepZVNN+28AEbHg54OTZvDyiba6pg+JaKV0C8NkThhMdh
         vyEYFLsr0P2pOB1b5MibUSwKKMlx1P9OOKtlk73H1AC/E66bB93nkV8G8oAJ79/QYgPk
         HvpWGlQxJHTrad7k+AXgnM7FKoqOUU22wR+O9mMgCrYUJ3Aa5Rc924tgkyqK3Wh06rRJ
         /zM1Kr8Pt2/ZI/HBdYQTmn4N8K5W6jnCGP+82K09RollAmjUoKPIK26CvALf+2x4pOuL
         Ft5odvmRpN/nZLO78kDYKyk+0jmqNYDkgDlqkuDL67NIU+iQZ2ZUp8fQrSo037FOmy9Y
         dmLg==
X-Gm-Message-State: AC+VfDxlodk36+vBu+QUVVDTZ5a7dC3uLfhDEuwxD1YI5dlVzWRRV+a4
        zl4bV9TGc6rdOsWFSQuzwMJJw4nMBilFMaCd93XJ/x9QFbU=
X-Google-Smtp-Source: ACHHUZ4ghTodBcVeI1oP4kCrp5FKpyHiQ64DZdsmBqNTzTyEcziTJo5yHXI52J11VBtW6C+EDFm6TqoT7AZsivc8Eb8=
X-Received: by 2002:a17:907:2cc2:b0:96f:5cb3:df66 with SMTP id
 hg2-20020a1709072cc200b0096f5cb3df66mr362187ejc.18.1684441256107; Thu, 18 May
 2023 13:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAAmbk-f_U8CPcTQM866L572uUHdK4p5iWKnUQs4r8fkW=6RW9g@mail.gmail.com>
 <CALF+zO=1oASFeb5WOezeZm_fbCuw=L8AL-n-mbCt8A==ZMAy3Q@mail.gmail.com>
In-Reply-To: <CALF+zO=1oASFeb5WOezeZm_fbCuw=L8AL-n-mbCt8A==ZMAy3Q@mail.gmail.com>
From:   Chris Chilvers <chilversc@gmail.com>
Date:   Thu, 18 May 2023 21:20:46 +0100
Message-ID: <CAAmbk-cgTR+FxLY2C=upuPBwNaBYff=GHedXyQiFf=Hr5i3G0A@mail.gmail.com>
Subject: Re: [Linux-cachefs] [BUG] fscache writing but not reading
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        brennandoyle@google.com, Benjamin Maynard <benmaynard@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 16 May 2023 at 20:28, David Wysochanski <dwysocha@redhat.com> wrote=
:
>
> On Tue, May 16, 2023 at 11:42=E2=80=AFAM Chris Chilvers <chilversc@gmail.=
com> wrote:
> >
> > While testing the fscache performance fixes [1] that were merged into 6=
.4-rc1
> > it appears that the caching no longer works. The client will write to t=
he cache
> > but never reads.
> >
> Thanks for the report.
>
> If you reboot do you see reads from the cache?

On the first read after a reboot it uses the cache, but subsequent
reads do not use the cache.

> You can check if the cache is being read from by looking in
> /proc/fs/fscache/stats
> at the "IO" line:
> # grep IO /proc/fs/fscache/stats
> IO     : rd=3D80030 wr=3D0

Running the tests 4 times (twice before reboot, and twice after) give
the following metrics:
FS-Cache I/O (delta)
Run       rd        wr
 1         0    39,250
 2       130    38,894
 3    39,000         0
 4        72    38,991

> Can you share:
> 1. NFS server you're using (is it localhost or something else)
> 2. NFS version

The NFS server and client are separate VMs on the same network.
Server NFS version: Ubuntu 22.04 jammy, kernel 5.15.0-1021-gcp
Client NFS version: Ubuntu 22.04 jammy, kernel 6.4.0-060400rc1-generic
(https://kernel.ubuntu.com/~kernel-ppa/mainline/v6.4-rc1/)
Client nfs-utils: 2.6.3-rc6
Client cachefilesd: 0.10.10-0.2ubuntu1

> In addition to checking the above for the reads from the cache, you can a=
lso
> see whether NFS reads are going over the wire pretty easily with a simila=
r
> technique.
>
> Copy /proc/self/mounstats to a file before your test, then make a second =
copy
> after the test, then run mountstats as follows:
> mountstats -S /tmp/mountstats.1 -f /tmp/mountstats.2

app read    =3D applications read bytes via read(2)
client read =3D client read bytes via NFS READ

Run           app read        client read
 1     322,122,547,200    322,122,547,200
 2     322,122,547,200    321,048,805,376
 3     322,122,547,200                  0
 4     322,122,547,200    321,593,053,184

I've put the full data in a GitHub gist, along with a graph collected
from a metrics agent:
https://gist.github.com/chilversc/54eb76155ad37b66cb85186e7449beaa
https://gist.githubusercontent.com/chilversc/54eb76155ad37b66cb85186e7449be=
aa/raw/09828c596d0cfc44bc0eb67f40e4033db202326e/metrics.png
