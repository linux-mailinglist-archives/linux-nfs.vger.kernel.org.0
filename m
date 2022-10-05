Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969B95F5726
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 17:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiJEPLQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Oct 2022 11:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJEPLP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Oct 2022 11:11:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CC86E2F2
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 08:11:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 909ACB81E05
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 15:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B641C433D6
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 15:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664982671;
        bh=B09a7ubzy3DhzhaYajzC+cAox8rCD5F+Kxw5Ktf+QoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C/mS2DZijl4PjpkYoWHpI8YzeBG8fLB9/L942vWXSrkXbltwFDh2BpbTqxPShHSLi
         0NNG3c4SeISwEy+SE+BidBAYntOTO9hQ8jlRJm+MjnArsSfiYKi6NdPeSW/kC7sOX8
         4jNFw3DQrwjozeeUxnz2wWrYmOigd4navoMxKAhVIrd+x/KmTrSQXdzWBBAMKtC4PO
         lHrY8h/TZxco0m/NXx6dKAeEdwe/7ga9PdUTGm3hbuA1EzRqx9lZhTeXyUa72QOpM0
         WfM9Q5xhKvoMEvx97GFt33XTzrXgcrBiInTAY5PgoxkYF+6WKB7rL7gmhpLOrZ88Mm
         +H3M381UBjAQg==
Received: by mail-vs1-f49.google.com with SMTP id h4so1686034vsr.11
        for <linux-nfs@vger.kernel.org>; Wed, 05 Oct 2022 08:11:11 -0700 (PDT)
X-Gm-Message-State: ACrzQf1haRrvWEgelqMrX2g9oymFyTq/gYi3fwuyBr84YR8ToAXFC5QI
        z4SRCqAlzGqf/R5XMdZ2VIeiAtKqFozYdNRfrhA=
X-Google-Smtp-Source: AMsMyM4XNP3Geb/EQZH4IbY2754SXPV4+L0IiQ0NZFneO/c5YOXQi8/NYSWYJF/cS43ND1u1/eBoiU9hU7uz2lbNT80=
X-Received: by 2002:a67:ef83:0:b0:3a6:c810:95b8 with SMTP id
 r3-20020a67ef83000000b003a6c81095b8mr75105vsp.79.1664982670059; Wed, 05 Oct
 2022 08:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220913180151.1928363-1-anna@kernel.org> <E45EC764-E698-45E9-8489-FF63A2A0FC5C@oracle.com>
 <CAFX2JfkDPzVL26KNxKnvHDLBgc0X2xdCJtBD1H+H10uRkwttug@mail.gmail.com>
In-Reply-To: <CAFX2JfkDPzVL26KNxKnvHDLBgc0X2xdCJtBD1H+H10uRkwttug@mail.gmail.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Wed, 5 Oct 2022 11:10:52 -0400
X-Gmail-Original-Message-ID: <CAFX2JfkS7m+wnYH0ZqdeH=42nfhRXTank_WN=ZjKOz8zdMQxuA@mail.gmail.com>
Message-ID: <CAFX2JfkS7m+wnYH0ZqdeH=42nfhRXTank_WN=ZjKOz8zdMQxuA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] NFSD: Simplify READ_PLUS
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Tue, Sep 13, 2022 at 4:45 PM Anna Schumaker <anna@kernel.org> wrote:
>
> On Tue, Sep 13, 2022 at 2:45 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >
> >
> >
> > > On Sep 13, 2022, at 11:01 AM, Anna Schumaker <anna@kernel.org> wrote:
> > >
> > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >
> > > When we left off with READ_PLUS, Chuck had suggested reverting the
> > > server to reply with a single NFS4_CONTENT_DATA segment essentially
> > > mimicing how the READ operation behaves. Then, a future sparse read
> > > function can be added and the server modified to support it without
> > > needing to rip out the old READ_PLUS code at the same time.
> > >
> > > This patch takes that first step. I was even able to re-use the
> > > nfsd4_encode_readv() and nfsd4_encode_splice_read() functions to
> > > remove some duuplicate code.
> > >
> > > Below is some performance data comparing the READ and READ_PLUS
> > > operations with v4.2. I tested reading 2G files with various hole
> > > lengths including 100% data, 100% hole, and a handful of mixed hole and
> > > data files. For the mixed files, a notation like "1d" means
> > > every-other-page is data, and the first page is data. "4h" would mean
> > > alternating 4 pages data and 4 pages hole, beginning with hole.
> > >
> > > I also used the 'vmtouch' utility to make sure the file is either
> > > evicted from the server's pagecache ("Uncached on server") or present in
> > > the server's page cache ("Cached on server").
> > >
> > >   2048M-data
> > >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.555 s, 712 MB/s, 0.74 s kern, 24% cpu
> > >   :    :........................... Cached on server .....  1.346 s, 1.6 GB/s, 0.69 s kern, 52% cpu
> > >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.596 s, 690 MB/s, 0.72 s kern, 23% cpu
> > >        :........................... Cached on server .....  1.394 s, 1.6 GB/s, 0.67 s kern, 48% cpu
> > >   2048M-hole
> > >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  4.934 s, 762 MB/s, 1.86 s kern, 29% cpu
> > >   :    :........................... Cached on server .....  1.328 s, 1.6 GB/s, 0.72 s kern, 54% cpu
> > >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  4.823 s, 739 MB/s, 1.88 s kern, 28% cpu
> > >        :........................... Cached on server .....  1.399 s, 1.5 GB/s, 0.70 s kern, 50% cpu
> > >   2048M-mixed-1d
> > >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  4.480 s, 598 MB/s, 0.76 s kern, 21% cpu
> > >   :    :........................... Cached on server .....  1.445 s, 1.5 GB/s, 0.71 s kern, 50% cpu
> > >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  4.774 s, 559 MB/s, 0.75 s kern, 19% cpu
> > >        :........................... Cached on server .....  1.514 s, 1.4 GB/s, 0.67 s kern, 44% cpu
> > >   2048M-mixed-1h
> > >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.568 s, 633 MB/s, 0.78 s kern, 23% cpu
> > >   :    :........................... Cached on server .....  1.357 s, 1.6 GB/s, 0.71 s kern, 53% cpu
> > >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.580 s, 641 MB/s, 0.74 s kern, 22% cpu
> > >        :........................... Cached on server .....  1.396 s, 1.5 GB/s, 0.67 s kern, 48% cpu
> > >   2048M-mixed-2d
> > >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.159 s, 708 MB/s, 0.78 s kern, 26% cpu
> > >   :    :........................... Cached on server .....  1.410 s, 1.5 GB/s, 0.70 s kern, 50% cpu
> > >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.093 s, 712 MB/s, 0.74 s kern, 25% cpu
> > >        :........................... Cached on server .....  1.474 s, 1.4 GB/s, 0.67 s kern, 46% cpu
> > >   2048M-mixed-2h
> > >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.043 s, 722 MB/s, 0.78 s kern, 26% cpu
> > >   :    :........................... Cached on server .....  1.374 s, 1.6 GB/s, 0.72 s kern, 53% cpu
> > >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.913 s, 756 MB/s, 0.74 s kern, 26% cpu
> > >        :........................... Cached on server .....  1.349 s, 1.6 GB/s, 0.67 s kern, 50% cpu
> > >   2048M-mixed-4d
> > >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.275 s, 680 MB/s, 0.75 s kern, 24% cpu
> > >   :    :........................... Cached on server .....  1.391 s, 1.5 GB/s, 0.71 s kern, 52% cpu
> > >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.470 s, 626 MB/s, 0.72 s kern, 21% cpu
> > >        :........................... Cached on server .....  1.456 s, 1.5 GB/s, 0.67 s kern, 46% cpu
> > >   2048M-mixed-4h
> > >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.035 s, 743 MB/s, 0.74 s kern, 26% cpu
> > >   :    :........................... Cached on server .....  1.345 s, 1.6 GB/s, 0.71 s kern, 53% cpu
> > >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.848 s, 779 MB/s, 0.73 s kern, 26% cpu
> > >        :........................... Cached on server .....  1.421 s, 1.5 GB/s, 0.68 s kern, 48% cpu
> > >   2048M-mixed-8d
> > >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.262 s, 687 MB/s, 0.74 s kern, 24% cpu
> > >   :    :........................... Cached on server .....  1.366 s, 1.6 GB/s, 0.69 s kern, 51% cpu
> > >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.195 s, 709 MB/s, 0.72 s kern, 24% cpu
> > >        :........................... Cached on server .....  1.414 s, 1.5 GB/s, 0.67 s kern, 48% cpu
> > >   2048M-mixed-8h
> > >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  2.899 s, 789 MB/s, 0.73 s kern, 27% cpu
> > >   :    :........................... Cached on server .....  1.338 s, 1.6 GB/s, 0.69 s kern, 52% cpu
> > >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.910 s, 772 MB/s, 0.72 s kern, 26% cpu
> > >        :........................... Cached on server .....  1.438 s, 1.5 GB/s, 0.67 s kern, 47% cpu
> > >   2048M-mixed-16d
> > >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.416 s, 661 MB/s, 0.73 s kern, 23% cpu
> > >   :    :........................... Cached on server .....  1.345 s, 1.6 GB/s, 0.70 s kern, 53% cpu
> > >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.177 s, 713 MB/s, 0.70 s kern, 23% cpu
> > >        :........................... Cached on server .....  1.447 s, 1.5 GB/s, 0.68 s kern, 47% cpu
> > >   2048M-mixed-16h
> > >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  2.919 s, 780 MB/s, 0.73 s kern, 26% cpu
> > >   :    :........................... Cached on server .....  1.363 s, 1.6 GB/s, 0.70 s kern, 51% cpu
> > >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.934 s, 773 MB/s, 0.70 s kern, 25% cpu
> > >        :........................... Cached on server .....  1.435 s, 1.5 GB/s, 0.67 s kern, 47% cpu
> >
> > For this particular change, I'm interested only in cases where the
> > whole file is cached on the server. We're focusing on the efficiency
> > and performance of the protocol and transport here, not the underlying
> > filesystem (which is... xfs?).
>
> Sounds good, I can narrow down to just that test.
>
> >
> > Also, 2GB files can be read with just 20 1MB READ requests. That
> > means we don't have a large sample size of READ operations for any
> > single test, assuming the client is using 1MB rsize.
> >
> > Also, are these averages, or single runs? I think running each test
> > 5-10 times (at least) and including some variance data in the results
> > would help build more confidence that the small differences in the
> > timing are not noise.
>
> This is an average across 10 runs.
>
> >
> > All that said, however, I see with some consistency that READ_PLUS
> > takes longer to pull data over the wire, but uses slightly less CPU.
> > Assuming the CPU utilizations are client-side, that matches my
> > expectations of lower CPU utilization results if the throughput is
> > lower.
> >
> > Looking at the 100% data results, READ_PLUS takes 3.5% longer than
> > READ. That to me is a small but significant drop -- I think it will
> > be noticeable for large workloads. Can you explain the difference?
>
> I'll try larger files for my next round of testing. I was assuming the
> difference is just noise, since there are cases like the mixed-2h test
> where READ_PLUS was slightly faster. But more testing will help figure
> that out.
>
> >
> > For subsequent test runs, can you find a server with more memory,
> > test with larger files, and test with a variety of rsize settings?
> > You can reduce your test matrix by leaving out the tests with holey
> > files for the moment.

Hi Chuck,

The following numbers are for 10G files that I created on Netapp lab
machines. I narrowed down my testing to files already in the server's
cache and read with directio to get the pagecache out of the way as
much as possible.  I did 25 iterations this time around, and included
minimum time, maximum time, and standard deviation in the report.

The following numbers are for XFS:

   10240M-data
   :... v6.0-rc6 (w/o Read Plus) ... 95.804 s, 112 MB/s, 0.42 s kern,  0% cpu
   :    :........................... Min: 108.000, Max: 114.000, StDev:  1.555
   :... v6.0-rc6 (w/ Read Plus) .... 96.683 s, 111 MB/s, 0.42 s kern,  0% cpu
        :........................... Min: 107.000, Max: 113.000, StDev:  1.481
   10240M-hole
   :... v6.0-rc6 (w/o Read Plus) ... 94.807 s, 113 MB/s, 0.42 s kern,  0% cpu
   :    :........................... Min: 113.000, Max: 114.000, StDev:  0.200
   :... v6.0-rc6 (w/ Read Plus) .... 95.388 s, 113 MB/s, 0.42 s kern,  0% cpu
        :........................... Min: 112.000, Max: 113.000, StDev:  0.476
   10240M-mixed-1d
   :... v6.0-rc6 (w/o Read Plus) ... 126.681 s,  89 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 59.000, Max: 114.000, StDev: 17.866
   :... v6.0-rc6 (w/ Read Plus) .... 110.494 s,  98 MB/s, 0.42 s kern,  0% cpu
        :........................... Min: 78.200, Max: 113.000, StDev:  7.353
   10240M-mixed-1h
   :... v6.0-rc6 (w/o Read Plus) ... 117.997 s,  94 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 59.200, Max: 114.000, StDev: 14.759
   :... v6.0-rc6 (w/ Read Plus) .... 115.344 s,  96 MB/s, 0.43 s kern,  0% cpu
        :........................... Min: 57.800, Max: 113.000, StDev: 14.192
   10240M-mixed-2d
   :... v6.0-rc6 (w/o Read Plus) ... 103.242 s, 104 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 96.000, Max: 114.000, StDev:  5.758
   :... v6.0-rc6 (w/ Read Plus) .... 101.552 s, 106 MB/s, 0.42 s kern,  0% cpu
        :........................... Min: 94.100, Max: 113.000, StDev:  4.744
   10240M-mixed-2h
   :... v6.0-rc6 (w/o Read Plus) ... 105.777 s, 102 MB/s, 0.42 s kern,  0% cpu
   :    :........................... Min: 90.000, Max: 112.000, StDev:  7.702
   :... v6.0-rc6 (w/ Read Plus) .... 101.782 s, 106 MB/s, 0.43 s kern,  0% cpu
        :........................... Min: 93.900, Max: 111.000, StDev:  4.059
   10240M-mixed-4d
   :... v6.0-rc6 (w/o Read Plus) ... 106.094 s, 102 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 87.900, Max: 110.000, StDev:  7.503
   :... v6.0-rc6 (w/ Read Plus) .... 103.356 s, 104 MB/s, 0.43 s kern,  0% cpu
        :........................... Min: 89.900, Max: 110.000, StDev:  5.255
   10240M-mixed-4h
   :... v6.0-rc6 (w/o Read Plus) ... 101.561 s, 106 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 98.400, Max: 111.000, StDev:  3.838
   :... v6.0-rc6 (w/ Read Plus) .... 106.004 s, 102 MB/s, 0.43 s kern,  0% cpu
        :........................... Min: 87.800, Max: 110.000, StDev:  6.811
   10240M-mixed-8d
   :... v6.0-rc6 (w/o Read Plus) ... 104.373 s, 103 MB/s, 0.42 s kern,  0% cpu
   :    :........................... Min: 92.200, Max: 111.000, StDev:  5.469
   :... v6.0-rc6 (w/ Read Plus) .... 102.490 s, 105 MB/s, 0.42 s kern,  0% cpu
        :........................... Min: 96.100, Max: 111.000, StDev:  4.708
   10240M-mixed-8h
   :... v6.0-rc6 (w/o Read Plus) ... 101.897 s, 105 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 96.300, Max: 111.000, StDev:  4.926
   :... v6.0-rc6 (w/ Read Plus) .... 100.914 s, 107 MB/s, 0.42 s kern,  0% cpu
        :........................... Min: 95.700, Max: 111.000, StDev:  3.886
   10240M-mixed-16d
   :... v6.0-rc6 (w/o Read Plus) ... 99.315 s, 108 MB/s, 0.42 s kern,  0% cpu
   :    :........................... Min: 102.000, Max: 112.000, StDev:  2.685
   :... v6.0-rc6 (w/ Read Plus) .... 100.228 s, 107 MB/s, 0.43 s kern,  0% cpu
        :........................... Min: 100.000, Max: 112.000, StDev:  3.597
   10240M-mixed-16h
   :... v6.0-rc6 (w/o Read Plus) ... 100.184 s, 107 MB/s, 0.42 s kern,  0% cpu
   :    :........................... Min: 99.500, Max: 112.000, StDev:  3.086
   :... v6.0-rc6 (w/ Read Plus) .... 102.623 s, 105 MB/s, 0.42 s kern,  0% cpu
        :........................... Min: 94.500, Max: 112.000, StDev:  5.330


And here is EXT4:
   10240M-data
   :... v6.0-rc6 (w/o Read Plus) ... 95.419 s, 113 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 111.000, Max: 113.000, StDev:  0.557
   :... v6.0-rc6 (w/ Read Plus) .... 95.764 s, 112 MB/s, 0.42 s kern,  0% cpu
        :........................... Min: 111.000, Max: 112.000, StDev:  0.200
   10240M-hole
   :... v6.0-rc6 (w/o Read Plus) ... 95.170 s, 113 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 113.000, Max: 113.000, StDev:  0.000
   :... v6.0-rc6 (w/ Read Plus) .... 95.446 s, 113 MB/s, 0.42 s kern,  0% cpu
        :........................... Min: 112.000, Max: 113.000, StDev:  0.507
   10240M-mixed-1d
   :... v6.0-rc6 (w/o Read Plus) ... 101.329 s, 106 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 102.000, Max: 113.000, StDev:  2.217
   :... v6.0-rc6 (w/ Read Plus) .... 101.708 s, 106 MB/s, 0.42 s kern,  0% cpu
        :........................... Min: 86.200, Max: 109.000, StDev:  4.494
   10240M-mixed-1h
   :... v6.0-rc6 (w/o Read Plus) ... 103.570 s, 104 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 101.000, Max: 113.000, StDev:  2.337
   :... v6.0-rc6 (w/ Read Plus) .... 104.246 s, 103 MB/s, 0.43 s kern,  0% cpu
        :........................... Min: 98.400, Max: 108.000, StDev:  2.622
   10240M-mixed-2d
   :... v6.0-rc6 (w/o Read Plus) ... 101.004 s, 106 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 103.000, Max: 108.000, StDev:  1.332
   :... v6.0-rc6 (w/ Read Plus) .... 102.730 s, 105 MB/s, 0.42 s kern,  0% cpu
        :........................... Min: 97.200, Max: 109.000, StDev:  2.630
   10240M-mixed-2h
   :... v6.0-rc6 (w/o Read Plus) ... 101.532 s, 106 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 100.000, Max: 110.000, StDev:  2.132
   :... v6.0-rc6 (w/ Read Plus) .... 102.048 s, 105 MB/s, 0.43 s kern,  0% cpu
        :........................... Min: 96.800, Max: 108.000, StDev:  2.501
   10240M-mixed-4d
   :... v6.0-rc6 (w/o Read Plus) ... 101.672 s, 106 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 101.000, Max: 110.000, StDev:  2.241
   :... v6.0-rc6 (w/ Read Plus) .... 103.032 s, 104 MB/s, 0.43 s kern,  0% cpu
        :........................... Min: 93.900, Max: 109.000, StDev:  3.028
   10240M-mixed-4h
   :... v6.0-rc6 (w/o Read Plus) ... 101.248 s, 106 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 103.000, Max: 110.000, StDev:  1.818
   :... v6.0-rc6 (w/ Read Plus) .... 103.324 s, 104 MB/s, 0.43 s kern,  0% cpu
        :........................... Min: 91.900, Max: 109.000, StDev:  3.395
   10240M-mixed-8d
   :... v6.0-rc6 (w/o Read Plus) ... 100.295 s, 107 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 104.000, Max: 110.000, StDev:  1.864
   :... v6.0-rc6 (w/ Read Plus) .... 101.728 s, 106 MB/s, 0.42 s kern,  0% cpu
        :........................... Min: 95.100, Max: 108.000, StDev:  2.565
   10240M-mixed-8h
   :... v6.0-rc6 (w/o Read Plus) ... 98.927 s, 109 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 106.000, Max: 111.000, StDev:  1.414
   :... v6.0-rc6 (w/ Read Plus) .... 101.399 s, 106 MB/s, 0.42 s kern,  0% cpu
        :........................... Min: 94.900, Max: 109.000, StDev:  2.725
   10240M-mixed-16d
   :... v6.0-rc6 (w/o Read Plus) ... 98.060 s, 109 MB/s, 0.42 s kern,  0% cpu
   :    :........................... Min: 107.000, Max: 112.000, StDev:  1.447
   :... v6.0-rc6 (w/ Read Plus) .... 98.994 s, 109 MB/s, 0.43 s kern,  0% cpu
        :........................... Min: 99.400, Max: 111.000, StDev:  2.168
   10240M-mixed-16h
   :... v6.0-rc6 (w/o Read Plus) ... 97.599 s, 110 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 106.000, Max: 112.000, StDev:  1.541
   :... v6.0-rc6 (w/ Read Plus) .... 98.895 s, 109 MB/s, 0.42 s kern,  0% cpu
        :........................... Min: 93.600, Max: 111.000, StDev:  3.532

Is there anything else you want me to test?

Anna

>
> Sure thing!
>
> Anna
>
> >
> >
> > > - v4:
> > >  - Change READ and READ_PLUS to return nfserr_serverfault if the splice
> > >    splice check fails.
> >
> > At this point, the code looks fine, but I'd like to understand why
> > the performance is not the same.
> >
> >
> > > Thanks,
> > > Anna
> > >
> > >
> > > Anna Schumaker (2):
> > >  NFSD: Return nfserr_serverfault if splice_ok but buf->pages have data
> > >  NFSD: Simplify READ_PLUS
> > >
> > > fs/nfsd/nfs4xdr.c | 141 +++++++++++-----------------------------------
> > > 1 file changed, 33 insertions(+), 108 deletions(-)
> > >
> > > --
> > > 2.37.3
> > >
> >
> > --
> > Chuck Lever
> >
> >
> >
