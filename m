Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE6258127
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Aug 2020 20:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgHaSdv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Aug 2020 14:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbgHaSdt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Aug 2020 14:33:49 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DF4C061573
        for <linux-nfs@vger.kernel.org>; Mon, 31 Aug 2020 11:33:47 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p9so4100541ejf.6
        for <linux-nfs@vger.kernel.org>; Mon, 31 Aug 2020 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7qTLGRfk0xIjB2AWK51ZN/7aRKfqQDQWLHBftMAjvU=;
        b=f19Ts0+VH1a8V5v4ny5yEfgL/PhG3PBvvV4WbZ59g8Zz15tOK1ZpTCIk5SUXNO+wEU
         1DB1Rhi3JUde1AaU6Mo5hmnA+SxVaRBmOHssz3cl5A8JtZOcevW4sIT7VuFsHFxVdlpn
         x2GS2seOk5wQ+nDIg5QQjIOi13iy4myTAfTF1/oVeU44sn8wx4H+Mm2wXc0uor8hlhtC
         ORUOeOBRdjkmtXPFRsUnuxJrplsbZ7qEPVgleVg4tQAcBHL8Oc1MvFNVzwnYZutCiGKj
         0G4XJwbxCTF7Ws94aAfb46eTFDSjyJe+yzHAzjtW3mrKhpkYL1d0Ii4g7p6+NVkpffYm
         10VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7qTLGRfk0xIjB2AWK51ZN/7aRKfqQDQWLHBftMAjvU=;
        b=Ys/zHzmXgxWEClEsMPsyL5xhEgoDZfWS6mpCQCKPhaIlkWb3gsSq/vgSe99WlvgsO5
         du/xDVRjQSBmd14zaQc4ZNtQpqbxtsdLFuWpZypeA88xq2IJ3AQmcoek5rkgKoS+L2eR
         RkURpG9y4AVlx3Z0pvZs95tSinBwCxEB5/fY+T9mukrAvq7DlFpNqcra4RrPr3lKaWeJ
         m+wZ7qoVXAEttMAfzM2aimwfKmh1yJjNiOhA6DID9fUr3ky9zUkLWPunkpFUZo5Zt0xg
         Q7Kf5g5+auGR5MRFyOnUQgts0COhuV3M0RHUL8B3Apcr15Xd2D4mSX9gHEwCanva9L6b
         C8uQ==
X-Gm-Message-State: AOAM530/n1PZtIHg7pGS5KDHuKbcHCQnxoH+CZ+pW0mJg4wE+Ku7H/r6
        a025E24IU9ABjl+Gce9PJj8YmZDzjoLhGdi1wLuzz3vt
X-Google-Smtp-Source: ABdhPJyE/TL4/OP6iahYU7fenVmrQDWZ81DuTWQL8xBP37PWg1phb4SpjEMPKcyWPE3T30qVilFMAzCCPkehvkT0sck=
X-Received: by 2002:a17:906:255b:: with SMTP id j27mr2201577ejb.46.1598898825893;
 Mon, 31 Aug 2020 11:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com> <20200826215437.GD62682@pick.fieldses.org>
In-Reply-To: <20200826215437.GD62682@pick.fieldses.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 31 Aug 2020 14:33:30 -0400
Message-ID: <CAFX2JfnEhgr4_CP4rJVsm37+Zo2uFs+zePAENtmPWx-Fmm-HfA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] NFSD: Add support for the v4.2 READ_PLUS operation
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 26, 2020 at 5:54 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Mon, Aug 17, 2020 at 12:53:05PM -0400, schumaker.anna@gmail.com wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > These patches add server support for the READ_PLUS operation, which
> > breaks read requests into several "data" and "hole" segments when
> > replying to the client.
> >
> > - Changes since v3:
> >   - Combine first two patches related to xdr_reserve_space_vec()
> >   - Remove unnecessary call to svc_encode_read_payload()
> >
> > Here are the results of some performance tests I ran on some lab
> > machines.
>
> What's the hardware setup (do you know network and disk bandwidth?).

I used iperf to benchmark the network, and it said it transferred 1.10
GBytes with a bandwidth of 941 Mbits/sec

I ran hdparm -tT to benchmark reads on the disk and it said this:
Timing cached reads:   13394 MB in  2.00 seconds = 6713.72 MB/sec
Timing buffered disk reads: 362 MB in 3.00 seconds = 120.60 MB/sec

>
> > I tested by reading various 2G files from a few different underlying
> > filesystems and across several NFS versions. I used the `vmtouch` utility
> > to make sure files were only cached when we wanted them to be. In addition
> > to 100% data and 100% hole cases, I also tested with files that alternate
> > between data and hole segments. These files have either 4K, 8K, 16K, or 32K
> > segment sizes and start with either data or hole segments. So the file
> > mixed-4d has a 4K segment size beginning with a data segment, but mixed-32h
> > has 32K segments beginning with a hole. The units are in seconds, with the
> > first number for each NFS version being the uncached read time and the second
> > number is for when the file is cached on the server.
>
> The only numbers that look really strange are in the btrfs uncached
> case, in the data-only case and the mixed case that start with a hole.
> Do we have any idea what's up there?

I'm not really sure. BTRFS does some work to make sure the page cache
is synced up with their internal extent representation as part of
llseek, so my guess is something related to that (But it's been a
while since I looked into that code, so I'm not sure if that's still
how it works)

Anna

>
> --b.
>
> > Read Plus Results (btrfs):
> >   data
> >    :... v4.1 ... Uncached ... 21.317 s, 101 MB/s, 0.63 s kern, 2% cpu
> >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.67 s kern, 3% cpu
> >    :... v4.2 ... Uncached ... 28.665 s,  75 MB/s, 0.65 s kern, 2% cpu
> >         :....... Cached ..... 18.253 s, 118 MB/s, 0.66 s kern, 3% cpu
> >   hole
> >    :... v4.1 ... Uncached ... 18.256 s, 118 MB/s, 0.70 s kern,  3% cpu
> >    :    :....... Cached ..... 18.254 s, 118 MB/s, 0.73 s kern,  4% cpu
> >    :... v4.2 ... Uncached ...  0.851 s, 2.5 GB/s, 0.72 s kern, 84% cpu
> >         :....... Cached .....  0.847 s, 2.5 GB/s, 0.73 s kern, 86% cpu
> >   mixed-4d
> >    :... v4.1 ... Uncached ... 56.857 s,  38 MB/s, 0.76 s kern, 1% cpu
> >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern, 3% cpu
> >    :... v4.2 ... Uncached ... 54.455 s,  39 MB/s, 0.73 s kern, 1% cpu
> >         :....... Cached .....  9.215 s, 233 MB/s, 0.68 s kern, 7% cpu
> >   mixed-8d
> >    :... v4.1 ... Uncached ... 36.641 s,  59 MB/s, 0.68 s kern, 1% cpu
> >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
> >    :... v4.2 ... Uncached ... 33.205 s,  65 MB/s, 0.67 s kern, 2% cpu
> >         :....... Cached .....  9.172 s, 234 MB/s, 0.65 s kern, 7% cpu
> >   mixed-16d
> >    :... v4.1 ... Uncached ... 28.653 s,  75 MB/s, 0.72 s kern, 2% cpu
> >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
> >    :... v4.2 ... Uncached ... 25.748 s,  83 MB/s, 0.71 s kern, 2% cpu
> >         :....... Cached .....  9.150 s, 235 MB/s, 0.64 s kern, 7% cpu
> >   mixed-32d
> >    :... v4.1 ... Uncached ... 28.886 s,  74 MB/s, 0.67 s kern, 2% cpu
> >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
> >    :... v4.2 ... Uncached ... 24.724 s,  87 MB/s, 0.74 s kern, 2% cpu
> >         :....... Cached .....  9.140 s, 235 MB/s, 0.63 s kern, 6% cpu
> >   mixed-4h
> >    :... v4.1 ... Uncached ...  52.181 s,  41 MB/s, 0.73 s kern, 1% cpu
> >    :    :....... Cached .....  18.252 s, 118 MB/s, 0.66 s kern, 3% cpu
> >    :... v4.2 ... Uncached ... 150.341 s,  14 MB/s, 0.72 s kern, 0% cpu
> >         :....... Cached .....   9.216 s, 233 MB/s, 0.63 s kern, 6% cpu
> >   mixed-8h
> >    :... v4.1 ... Uncached ... 36.945 s,  58 MB/s, 0.68 s kern, 1% cpu
> >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.65 s kern, 3% cpu
> >    :... v4.2 ... Uncached ... 79.781 s,  27 MB/s, 0.68 s kern, 0% cpu
> >         :....... Cached .....  9.172 s, 234 MB/s, 0.66 s kern, 7% cpu
> >   mixed-16h
> >    :... v4.1 ... Uncached ... 28.651 s,  75 MB/s, 0.73 s kern, 2% cpu
> >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.66 s kern, 3% cpu
> >    :... v4.2 ... Uncached ... 47.428 s,  45 MB/s, 0.71 s kern, 1% cpu
> >         :....... Cached .....  9.150 s, 235 MB/s, 0.67 s kern, 7% cpu
> >   mixed-32h
> >    :... v4.1 ... Uncached ... 28.618 s,  75 MB/s, 0.69 s kern, 2% cpu
> >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
> >    :... v4.2 ... Uncached ... 38.813 s,  55 MB/s, 0.67 s kern, 1% cpu
> >         :....... Cached .....  9.140 s, 235 MB/s, 0.61 s kern, 6% cpu
>
