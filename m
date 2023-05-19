Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29D87096D8
	for <lists+linux-nfs@lfdr.de>; Fri, 19 May 2023 13:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjESLzL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 May 2023 07:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjESLzK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 May 2023 07:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD66318F
        for <linux-nfs@vger.kernel.org>; Fri, 19 May 2023 04:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684497261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RBx0CIh0/kePn2QF9ragLu/RfwxGJvqVO0V04dbl1dE=;
        b=HwKhB+qNzPM6l+C4mBT/0V/7w4WMUVICsXA7A5AkNaoa1YzaUxWO9n2Q/hI7XzhwZNL5TA
        CJuW1KdLOFb0S79w60Bxxb53aFefXjc4hbrD/fFLjqDWxAq08Rmptl1mU0no7ka4ysZzRQ
        6Z+eV5YtqQsZE1KSAtxdU6XMMZi/zQc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-kCv7ktZWNouOuuAohBbhLw-1; Fri, 19 May 2023 07:54:19 -0400
X-MC-Unique: kCv7ktZWNouOuuAohBbhLw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1ae46de6333so20759675ad.0
        for <linux-nfs@vger.kernel.org>; Fri, 19 May 2023 04:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684497258; x=1687089258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBx0CIh0/kePn2QF9ragLu/RfwxGJvqVO0V04dbl1dE=;
        b=QavwzmzdwQ32cletnn/S8FhufqoluvtEtZreKHrw8fyzCbTrTNzADIZIyJg8YoW3sE
         /NAoU+oPO7X0+7W/nOMPHu1I/K7zut9emF21wHOgoskhq8kFhEfDxHEDNQ/b4Cy0q0I1
         l9iaGax3+ifrTXsXlOBkNNaw/Ijo8J1V4aI0oO16IrkcuobXMrOqSJOLAqCi2wCkGNxN
         PSRs8KlzMMAdOauY9UBvBdyB/MMdG7y14Qp6eUDfyRR3pFkX5HsMQ57gI3Vn/+1HjUx9
         ckG0Qom63ftTD5qyibEalZW7DbNmfIoWhdtzxD8yHU0cqykZX4LXMhROB8CqWp2NirQq
         rRuA==
X-Gm-Message-State: AC+VfDwpOi8h4KJwymB8c33kwAfe717s/Dha1y7D/vB23N9+bwN06Auf
        1a7d58KgxEPZ/2uIkiKwFecyFsR3ip/w+lYNKmO2jInr2eTRfLzeHYMWtsq0C+Yg5ZKfSTiMoTk
        zi2Vg4j6adipD6sLjyya0lqkPUvMz/k/VUqnbNgP+3PUI
X-Received: by 2002:a17:903:1c5:b0:1ae:8a22:d0dd with SMTP id e5-20020a17090301c500b001ae8a22d0ddmr818840plh.58.1684497258308;
        Fri, 19 May 2023 04:54:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79N0vlW/qV83ffVIcIqSM2B8isohuWoPAGdZvEq/o2vzWih+3ZQHmxa5F7RVG0E/bPDqtZ6ziJ1EvSK9Q0X70=
X-Received: by 2002:a17:903:1c5:b0:1ae:8a22:d0dd with SMTP id
 e5-20020a17090301c500b001ae8a22d0ddmr818826plh.58.1684497258028; Fri, 19 May
 2023 04:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAAmbk-f_U8CPcTQM866L572uUHdK4p5iWKnUQs4r8fkW=6RW9g@mail.gmail.com>
 <CALF+zO=1oASFeb5WOezeZm_fbCuw=L8AL-n-mbCt8A==ZMAy3Q@mail.gmail.com> <CAAmbk-cgTR+FxLY2C=upuPBwNaBYff=GHedXyQiFf=Hr5i3G0A@mail.gmail.com>
In-Reply-To: <CAAmbk-cgTR+FxLY2C=upuPBwNaBYff=GHedXyQiFf=Hr5i3G0A@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 19 May 2023 07:53:41 -0400
Message-ID: <CALF+zO=vjPjs8QevssUmGHA_bZaTaF3HcqQa+OQgxegqB5yzmw@mail.gmail.com>
Subject: Re: [Linux-cachefs] [BUG] fscache writing but not reading
To:     Chris Chilvers <chilversc@gmail.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        brennandoyle@google.com, Benjamin Maynard <benmaynard@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 18, 2023 at 4:21=E2=80=AFPM Chris Chilvers <chilversc@gmail.com=
> wrote:
>
> On Tue, 16 May 2023 at 20:28, David Wysochanski <dwysocha@redhat.com> wro=
te:
> >
> > On Tue, May 16, 2023 at 11:42=E2=80=AFAM Chris Chilvers <chilversc@gmai=
l.com> wrote:
> > >
> > > While testing the fscache performance fixes [1] that were merged into=
 6.4-rc1
> > > it appears that the caching no longer works. The client will write to=
 the cache
> > > but never reads.
> > >
> > Thanks for the report.
> >
> > If you reboot do you see reads from the cache?
>
> On the first read after a reboot it uses the cache, but subsequent
> reads do not use the cache.
>
> > You can check if the cache is being read from by looking in
> > /proc/fs/fscache/stats
> > at the "IO" line:
> > # grep IO /proc/fs/fscache/stats
> > IO     : rd=3D80030 wr=3D0
>
> Running the tests 4 times (twice before reboot, and twice after) give
> the following metrics:
> FS-Cache I/O (delta)
> Run       rd        wr
>  1         0    39,250
>  2       130    38,894
>  3    39,000         0
>  4        72    38,991
>
> > Can you share:
> > 1. NFS server you're using (is it localhost or something else)
> > 2. NFS version
>
> The NFS server and client are separate VMs on the same network.
> Server NFS version: Ubuntu 22.04 jammy, kernel 5.15.0-1021-gcp
> Client NFS version: Ubuntu 22.04 jammy, kernel 6.4.0-060400rc1-generic
> (https://kernel.ubuntu.com/~kernel-ppa/mainline/v6.4-rc1/)
> Client nfs-utils: 2.6.3-rc6
> Client cachefilesd: 0.10.10-0.2ubuntu1
>
> > In addition to checking the above for the reads from the cache, you can=
 also
> > see whether NFS reads are going over the wire pretty easily with a simi=
lar
> > technique.
> >
> > Copy /proc/self/mounstats to a file before your test, then make a secon=
d copy
> > after the test, then run mountstats as follows:
> > mountstats -S /tmp/mountstats.1 -f /tmp/mountstats.2
>
> app read    =3D applications read bytes via read(2)
> client read =3D client read bytes via NFS READ
>
> Run           app read        client read
>  1     322,122,547,200    322,122,547,200
>  2     322,122,547,200    321,048,805,376
>  3     322,122,547,200                  0
>  4     322,122,547,200    321,593,053,184
>
> I've put the full data in a GitHub gist, along with a graph collected
> from a metrics agent:
> https://gist.github.com/chilversc/54eb76155ad37b66cb85186e7449beaa
> https://gist.githubusercontent.com/chilversc/54eb76155ad37b66cb85186e7449=
beaa/raw/09828c596d0cfc44bc0eb67f40e4033db202326e/metrics.png
>

Thanks Chris for all this info.  I see you're using NFSv3 so I'll
focus on that, and review all this info for clues.
I also have been working on some updated test cases and see some very
unusual behavior like you're reporting.

I also confirmed that adding the two patches for "Issue #1"  onto
6.4-rc1 resolve _most_ of the caching issues.
However, even after those patches, in some limited instances, there
are still NFS reads over the wire when there should only be reads from
the cache.
There may be multiple bugs here.

