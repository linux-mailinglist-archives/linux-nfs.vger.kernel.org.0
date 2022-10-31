Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F697613CA9
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 18:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiJaRzh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 13:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiJaRzc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 13:55:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51D46399
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 10:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DE5EB819AB
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 17:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C27C433D6
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 17:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667238928;
        bh=ILNhH7XdPpjVkfvYNwUSv5mJTefXQfV6N99vWbWa3Eg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e6yn2dYy8xnKtUiC3FMsVCI107fWIBOG/4+PAKotK4wtnVyvZ7UIWibcZFQuROez0
         2so4XyTG/E/ljgneTn6FZ01gqveND3GmF/myjJ+3Kfrk4ncMdgMTDv6mCZ35N57JB+
         VU3YOWqyK1gHWQiiGNnfRcsDxIQdnv2i80Pbrc3T6BbJMV4YFPVyMeozkE6lYU9Wwr
         oS7ugTQWmyX1JbSrbRez4bwIbVzXwwhccg3MZh56B/E7jD1i5H8GMZC+vUUUXgws5Y
         nrcefdIrpe4OnctLBOFteqkEiVEpYymSVyerPnM8HkbVvpNeNdkik/PP/zpUucQzHm
         4iOuteyms0M0w==
Received: by mail-qt1-f178.google.com with SMTP id c15so937953qtw.8
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 10:55:27 -0700 (PDT)
X-Gm-Message-State: ACrzQf2ZcQpZRdqPpikh+5Z5AyXRLI+ntX40RqAvo7iB+vWLHARg1X+g
        +rQrf0vV80CIwu1x0bpYMDEicDazhww7v1tvm60=
X-Google-Smtp-Source: AMsMyM4Js5mdoyI5+nl8DTecM/AoxYXGOhOgC9efJCARsBrOIA6Nus4lZlztyW2P5w7941/aWyhCz/KQ1M2z+8joz0E=
X-Received: by 2002:ac8:59c7:0:b0:3a5:23bc:2b4f with SMTP id
 f7-20020ac859c7000000b003a523bc2b4fmr5800661qtf.661.1667238926908; Mon, 31
 Oct 2022 10:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220913180151.1928363-1-anna@kernel.org> <E45EC764-E698-45E9-8489-FF63A2A0FC5C@oracle.com>
 <CAFX2JfkDPzVL26KNxKnvHDLBgc0X2xdCJtBD1H+H10uRkwttug@mail.gmail.com>
 <CAFX2JfkS7m+wnYH0ZqdeH=42nfhRXTank_WN=ZjKOz8zdMQxuA@mail.gmail.com> <32166C4B-FD5F-4F81-9CDF-7961BC140A89@oracle.com>
In-Reply-To: <32166C4B-FD5F-4F81-9CDF-7961BC140A89@oracle.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Mon, 31 Oct 2022 13:55:10 -0400
X-Gmail-Original-Message-ID: <CAFX2JfnGAOGAn2G16xWTH1NUHDg6bcDvBCNZ2B1fpPJ2YAKa-w@mail.gmail.com>
Message-ID: <CAFX2JfnGAOGAn2G16xWTH1NUHDg6bcDvBCNZ2B1fpPJ2YAKa-w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] NFSD: Simplify READ_PLUS
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 5, 2022 at 11:53 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Oct 5, 2022, at 11:10 AM, Anna Schumaker <anna@kernel.org> wrote:
> >
> > Hi Chuck,
> >
> > On Tue, Sep 13, 2022 at 4:45 PM Anna Schumaker <anna@kernel.org> wrote:
> >>
> >> On Tue, Sep 13, 2022 at 2:45 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>>
> >>>
> >>>
> >>>> On Sep 13, 2022, at 11:01 AM, Anna Schumaker <anna@kernel.org> wrote:
> >>>>
> >>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>>>
> >>>> When we left off with READ_PLUS, Chuck had suggested reverting the
> >>>> server to reply with a single NFS4_CONTENT_DATA segment essentially
> >>>> mimicing how the READ operation behaves. Then, a future sparse read
> >>>> function can be added and the server modified to support it without
> >>>> needing to rip out the old READ_PLUS code at the same time.
> >>>>
> >>>> This patch takes that first step. I was even able to re-use the
> >>>> nfsd4_encode_readv() and nfsd4_encode_splice_read() functions to
> >>>> remove some duuplicate code.
> >>>>
> >>>> Below is some performance data comparing the READ and READ_PLUS
> >>>> operations with v4.2. I tested reading 2G files with various hole
> >>>> lengths including 100% data, 100% hole, and a handful of mixed hole and
> >>>> data files. For the mixed files, a notation like "1d" means
> >>>> every-other-page is data, and the first page is data. "4h" would mean
> >>>> alternating 4 pages data and 4 pages hole, beginning with hole.
> >>>>
> >>>> I also used the 'vmtouch' utility to make sure the file is either
> >>>> evicted from the server's pagecache ("Uncached on server") or present in
> >>>> the server's page cache ("Cached on server").
> >>>>
> >>>>  2048M-data
> >>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.555 s, 712 MB/s, 0.74 s kern, 24% cpu
> >>>>  :    :........................... Cached on server .....  1.346 s, 1.6 GB/s, 0.69 s kern, 52% cpu
> >>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.596 s, 690 MB/s, 0.72 s kern, 23% cpu
> >>>>       :........................... Cached on server .....  1.394 s, 1.6 GB/s, 0.67 s kern, 48% cpu
> >>>>  2048M-hole
> >>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  4.934 s, 762 MB/s, 1.86 s kern, 29% cpu
> >>>>  :    :........................... Cached on server .....  1.328 s, 1.6 GB/s, 0.72 s kern, 54% cpu
> >>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  4.823 s, 739 MB/s, 1.88 s kern, 28% cpu
> >>>>       :........................... Cached on server .....  1.399 s, 1.5 GB/s, 0.70 s kern, 50% cpu
> >>>>  2048M-mixed-1d
> >>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  4.480 s, 598 MB/s, 0.76 s kern, 21% cpu
> >>>>  :    :........................... Cached on server .....  1.445 s, 1.5 GB/s, 0.71 s kern, 50% cpu
> >>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  4.774 s, 559 MB/s, 0.75 s kern, 19% cpu
> >>>>       :........................... Cached on server .....  1.514 s, 1.4 GB/s, 0.67 s kern, 44% cpu
> >>>>  2048M-mixed-1h
> >>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.568 s, 633 MB/s, 0.78 s kern, 23% cpu
> >>>>  :    :........................... Cached on server .....  1.357 s, 1.6 GB/s, 0.71 s kern, 53% cpu
> >>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.580 s, 641 MB/s, 0.74 s kern, 22% cpu
> >>>>       :........................... Cached on server .....  1.396 s, 1.5 GB/s, 0.67 s kern, 48% cpu
> >>>>  2048M-mixed-2d
> >>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.159 s, 708 MB/s, 0.78 s kern, 26% cpu
> >>>>  :    :........................... Cached on server .....  1.410 s, 1.5 GB/s, 0.70 s kern, 50% cpu
> >>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.093 s, 712 MB/s, 0.74 s kern, 25% cpu
> >>>>       :........................... Cached on server .....  1.474 s, 1.4 GB/s, 0.67 s kern, 46% cpu
> >>>>  2048M-mixed-2h
> >>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.043 s, 722 MB/s, 0.78 s kern, 26% cpu
> >>>>  :    :........................... Cached on server .....  1.374 s, 1.6 GB/s, 0.72 s kern, 53% cpu
> >>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.913 s, 756 MB/s, 0.74 s kern, 26% cpu
> >>>>       :........................... Cached on server .....  1.349 s, 1.6 GB/s, 0.67 s kern, 50% cpu
> >>>>  2048M-mixed-4d
> >>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.275 s, 680 MB/s, 0.75 s kern, 24% cpu
> >>>>  :    :........................... Cached on server .....  1.391 s, 1.5 GB/s, 0.71 s kern, 52% cpu
> >>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.470 s, 626 MB/s, 0.72 s kern, 21% cpu
> >>>>       :........................... Cached on server .....  1.456 s, 1.5 GB/s, 0.67 s kern, 46% cpu
> >>>>  2048M-mixed-4h
> >>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.035 s, 743 MB/s, 0.74 s kern, 26% cpu
> >>>>  :    :........................... Cached on server .....  1.345 s, 1.6 GB/s, 0.71 s kern, 53% cpu
> >>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.848 s, 779 MB/s, 0.73 s kern, 26% cpu
> >>>>       :........................... Cached on server .....  1.421 s, 1.5 GB/s, 0.68 s kern, 48% cpu
> >>>>  2048M-mixed-8d
> >>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.262 s, 687 MB/s, 0.74 s kern, 24% cpu
> >>>>  :    :........................... Cached on server .....  1.366 s, 1.6 GB/s, 0.69 s kern, 51% cpu
> >>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.195 s, 709 MB/s, 0.72 s kern, 24% cpu
> >>>>       :........................... Cached on server .....  1.414 s, 1.5 GB/s, 0.67 s kern, 48% cpu
> >>>>  2048M-mixed-8h
> >>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  2.899 s, 789 MB/s, 0.73 s kern, 27% cpu
> >>>>  :    :........................... Cached on server .....  1.338 s, 1.6 GB/s, 0.69 s kern, 52% cpu
> >>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.910 s, 772 MB/s, 0.72 s kern, 26% cpu
> >>>>       :........................... Cached on server .....  1.438 s, 1.5 GB/s, 0.67 s kern, 47% cpu
> >>>>  2048M-mixed-16d
> >>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.416 s, 661 MB/s, 0.73 s kern, 23% cpu
> >>>>  :    :........................... Cached on server .....  1.345 s, 1.6 GB/s, 0.70 s kern, 53% cpu
> >>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.177 s, 713 MB/s, 0.70 s kern, 23% cpu
> >>>>       :........................... Cached on server .....  1.447 s, 1.5 GB/s, 0.68 s kern, 47% cpu
> >>>>  2048M-mixed-16h
> >>>>  :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  2.919 s, 780 MB/s, 0.73 s kern, 26% cpu
> >>>>  :    :........................... Cached on server .....  1.363 s, 1.6 GB/s, 0.70 s kern, 51% cpu
> >>>>  :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.934 s, 773 MB/s, 0.70 s kern, 25% cpu
> >>>>       :........................... Cached on server .....  1.435 s, 1.5 GB/s, 0.67 s kern, 47% cpu
> >>>
> >>> For this particular change, I'm interested only in cases where the
> >>> whole file is cached on the server. We're focusing on the efficiency
> >>> and performance of the protocol and transport here, not the underlying
> >>> filesystem (which is... xfs?).
> >>
> >> Sounds good, I can narrow down to just that test.
> >>
> >>>
> >>> Also, 2GB files can be read with just 20 1MB READ requests. That
> >>> means we don't have a large sample size of READ operations for any
> >>> single test, assuming the client is using 1MB rsize.
> >>>
> >>> Also, are these averages, or single runs? I think running each test
> >>> 5-10 times (at least) and including some variance data in the results
> >>> would help build more confidence that the small differences in the
> >>> timing are not noise.
> >>
> >> This is an average across 10 runs.
> >>
> >>>
> >>> All that said, however, I see with some consistency that READ_PLUS
> >>> takes longer to pull data over the wire, but uses slightly less CPU.
> >>> Assuming the CPU utilizations are client-side, that matches my
> >>> expectations of lower CPU utilization results if the throughput is
> >>> lower.
> >>>
> >>> Looking at the 100% data results, READ_PLUS takes 3.5% longer than
> >>> READ. That to me is a small but significant drop -- I think it will
> >>> be noticeable for large workloads. Can you explain the difference?
> >>
> >> I'll try larger files for my next round of testing. I was assuming the
> >> difference is just noise, since there are cases like the mixed-2h test
> >> where READ_PLUS was slightly faster. But more testing will help figure
> >> that out.
> >>
> >>>
> >>> For subsequent test runs, can you find a server with more memory,
> >>> test with larger files, and test with a variety of rsize settings?
> >>> You can reduce your test matrix by leaving out the tests with holey
> >>> files for the moment.
> >
> > Hi Chuck,
> >
> > The following numbers are for 10G files that I created on Netapp lab
> > machines. I narrowed down my testing to files already in the server's
> > cache and read with directio to get the pagecache out of the way as
> > much as possible.  I did 25 iterations this time around, and included
> > minimum time, maximum time, and standard deviation in the report.
> >
> > The following numbers are for XFS:
> >
> >   10240M-data
> >   :... v6.0-rc6 (w/o Read Plus) ... 95.804 s, 112 MB/s, 0.42 s kern,  0% cpu
> >   :    :........................... Min: 108.000, Max: 114.000, StDev:  1.555
> >   :... v6.0-rc6 (w/ Read Plus) .... 96.683 s, 111 MB/s, 0.42 s kern,  0% cpu
> >        :........................... Min: 107.000, Max: 113.000, StDev:  1.481
>
>
> > And here is EXT4:
> >   10240M-data
> >   :... v6.0-rc6 (w/o Read Plus) ... 95.419 s, 113 MB/s, 0.43 s kern,  0% cpu
> >   :    :........................... Min: 111.000, Max: 113.000, StDev:  0.557
> >   :... v6.0-rc6 (w/ Read Plus) .... 95.764 s, 112 MB/s, 0.42 s kern,  0% cpu
> >        :........................... Min: 111.000, Max: 112.000, StDev:  0.200
>
> For this case, only the single data segment results are
> interesting, since that's all the server implementation now
> supports.
>
> The ext4 results show that the difference between the
> average throughput results (112 v. 113) is larger than the
> standard deviation: thus, the slower result is not noise
> (differences in significant figures notwithstanding).
>
> I've tested on 100GbE (TCP) against a tmpfs export using iozone,
> and consistently see 10% lower data and IOPS throughput with
> NFSv4.2 READ_PLUS compared with NFSv4.1 with READ.
>
> Maybe tmpfs is not a real world test case? If you don't see a
> significant difference on a filesystem that stores its data on
> durable media, then maybe my 10% result doesn't matter. But it
> does expose an inefficiency somewhere.
>
>
> > Is there anything else you want me to test?
>
> I was asking not just for more precise test results, but also
> for an explanation/analysis of the differences.
>
> At this point I expect the problem is on the client -- perhaps
> it is not aligning the receive buffer to expect a single data
> segment. Do you think that case should be optimized on the
> client? For typical small files, I would expect that single
> data segment reads would dominate.

Hi Chuck, I added a patch to my client to hack in decoding
single-segment READ_PLUS calls the same way we decode READ, and I'm
not seeing a huge difference in transfer speed before and after the
patch:

With EXT4:
   10240M-data
   :... v6.0-rc6 (w/o Read Plus) ... 94.648 s, 113 MB/s, 0.44 s kern,  0% cpu
   :    :........................... Min: 94.500, Max: 95.141, StDev:  0.107
   :... v6.0-rc6 (w/ Read Plus) .... 95.831 s, 112 MB/s, 0.44 s kern,  0% cpu
   :    :........................... Min: 95.731, Max: 96.261, StDev:  0.089
   :... w/ Client Patch ............ 95.799 s, 112 MB/s, 0.44 s kern,  0% cpu
        :........................... Min: 95.690, Max: 96.229, StDev:  0.089

And with XFS:
   10240M-data
   :... v6.0-rc6 (w/o Read Plus) ... 94.443 s, 114 MB/s, 0.43 s kern,  0% cpu
   :    :........................... Min: 94.217, Max: 94.653, StDev:  0.095
   :... v6.0-rc6 (w/ Read Plus) .... 95.725 s, 112 MB/s, 0.44 s kern,  0% cpu
   :    :........................... Min: 95.612, Max: 95.843, StDev:  0.067
   :... w/ Client Patch ............ 95.721 s, 112 MB/s, 0.44 s kern,  0% cpu
        :........................... Min: 95.602, Max: 95.805, StDev:  0.052


>
> Do you have a way of assessing whether the client has to
> re-align READ_PLUS data segments when it receives just one
> of them per Reply? There might be a SunRPC tracepoint that
> fires when re-alignment is needed, for instance.

For the READ case, the client always calls xdr_realign_pages() during
decoding to align the data so it is always doing some shifting around
to get the read reply positioned right.

Anna

>
> I'll add "Simplify READ_PLUS" to the NFSD v6.2 pile, but IMO
> understanding (and hopefully addressing) the performance
> difference here is key to the success of the Linux READ_PLUS
> implementation.
>
> --
> Chuck Lever
>
>
>
