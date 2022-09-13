Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4AE5B7C44
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 22:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIMUpi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 16:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIMUph (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 16:45:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0461F7286A
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 13:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF26BB810BD
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 20:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A81BC433C1
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663101933;
        bh=Tpq5aCI0334I7mdgQq4L+2ZGedcMoH8UVpRvQRU+8m0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EKVx55FO7gxy981r0Bm9c1kbPcAoRC7bfgwIP4Gz0JHybMwZXG6DOPMDSbGrBsgVq
         zs7GtxuWY6Nd0MWJE+T0zVwrzJ950AkHzjju0oZHKAZuhH26WPyA7vQvMxbuiaG3X6
         c0297mZHpON40Vz9QLsBGnbofzYBZblEHZKyOwH50u4++Ow0Pbc0t6IAGdzquh3Hb5
         h5okXkp1mqkgqREdH5zwmBqQb0oquA8vVFDf25E9Kbt0ogNsb/UBA3WosRbRC3v6L5
         aqdK6tfGp8Rn7I6a+DijqgZmB+h6qpc82tSQEf0ICE9t94ui6XAuTykNdAV4FJsWL+
         JrGhC1MJkaqiQ==
Received: by mail-wr1-f54.google.com with SMTP id cc5so12788930wrb.6
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 13:45:33 -0700 (PDT)
X-Gm-Message-State: ACgBeo1e6SDb7f+ZN5XxgEaJA3V8U12aAzhsQo3T+cf0SokVtFjw3JFK
        GAOTJmQemjZHNC5ZJIIQ/zSlPXoWJ6/ckIWzdjA=
X-Google-Smtp-Source: AA6agR4AuE373m5KabJ/wnqA+o4rn5BkQasP5TrW7LUcXHXU8FGXZv1/cFhuR5tjVqKMj1LVkkRNOb3L4mX5Y/vfvuY=
X-Received: by 2002:a05:6000:18aa:b0:22a:b489:badc with SMTP id
 b10-20020a05600018aa00b0022ab489badcmr5160187wri.564.1663101931883; Tue, 13
 Sep 2022 13:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220913180151.1928363-1-anna@kernel.org> <E45EC764-E698-45E9-8489-FF63A2A0FC5C@oracle.com>
In-Reply-To: <E45EC764-E698-45E9-8489-FF63A2A0FC5C@oracle.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Tue, 13 Sep 2022 16:45:15 -0400
X-Gmail-Original-Message-ID: <CAFX2JfkDPzVL26KNxKnvHDLBgc0X2xdCJtBD1H+H10uRkwttug@mail.gmail.com>
Message-ID: <CAFX2JfkDPzVL26KNxKnvHDLBgc0X2xdCJtBD1H+H10uRkwttug@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] NFSD: Simplify READ_PLUS
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 13, 2022 at 2:45 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Sep 13, 2022, at 11:01 AM, Anna Schumaker <anna@kernel.org> wrote:
> >
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > When we left off with READ_PLUS, Chuck had suggested reverting the
> > server to reply with a single NFS4_CONTENT_DATA segment essentially
> > mimicing how the READ operation behaves. Then, a future sparse read
> > function can be added and the server modified to support it without
> > needing to rip out the old READ_PLUS code at the same time.
> >
> > This patch takes that first step. I was even able to re-use the
> > nfsd4_encode_readv() and nfsd4_encode_splice_read() functions to
> > remove some duuplicate code.
> >
> > Below is some performance data comparing the READ and READ_PLUS
> > operations with v4.2. I tested reading 2G files with various hole
> > lengths including 100% data, 100% hole, and a handful of mixed hole and
> > data files. For the mixed files, a notation like "1d" means
> > every-other-page is data, and the first page is data. "4h" would mean
> > alternating 4 pages data and 4 pages hole, beginning with hole.
> >
> > I also used the 'vmtouch' utility to make sure the file is either
> > evicted from the server's pagecache ("Uncached on server") or present in
> > the server's page cache ("Cached on server").
> >
> >   2048M-data
> >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.555 s, 712 MB/s, 0.74 s kern, 24% cpu
> >   :    :........................... Cached on server .....  1.346 s, 1.6 GB/s, 0.69 s kern, 52% cpu
> >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.596 s, 690 MB/s, 0.72 s kern, 23% cpu
> >        :........................... Cached on server .....  1.394 s, 1.6 GB/s, 0.67 s kern, 48% cpu
> >   2048M-hole
> >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  4.934 s, 762 MB/s, 1.86 s kern, 29% cpu
> >   :    :........................... Cached on server .....  1.328 s, 1.6 GB/s, 0.72 s kern, 54% cpu
> >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  4.823 s, 739 MB/s, 1.88 s kern, 28% cpu
> >        :........................... Cached on server .....  1.399 s, 1.5 GB/s, 0.70 s kern, 50% cpu
> >   2048M-mixed-1d
> >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  4.480 s, 598 MB/s, 0.76 s kern, 21% cpu
> >   :    :........................... Cached on server .....  1.445 s, 1.5 GB/s, 0.71 s kern, 50% cpu
> >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  4.774 s, 559 MB/s, 0.75 s kern, 19% cpu
> >        :........................... Cached on server .....  1.514 s, 1.4 GB/s, 0.67 s kern, 44% cpu
> >   2048M-mixed-1h
> >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.568 s, 633 MB/s, 0.78 s kern, 23% cpu
> >   :    :........................... Cached on server .....  1.357 s, 1.6 GB/s, 0.71 s kern, 53% cpu
> >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.580 s, 641 MB/s, 0.74 s kern, 22% cpu
> >        :........................... Cached on server .....  1.396 s, 1.5 GB/s, 0.67 s kern, 48% cpu
> >   2048M-mixed-2d
> >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.159 s, 708 MB/s, 0.78 s kern, 26% cpu
> >   :    :........................... Cached on server .....  1.410 s, 1.5 GB/s, 0.70 s kern, 50% cpu
> >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.093 s, 712 MB/s, 0.74 s kern, 25% cpu
> >        :........................... Cached on server .....  1.474 s, 1.4 GB/s, 0.67 s kern, 46% cpu
> >   2048M-mixed-2h
> >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.043 s, 722 MB/s, 0.78 s kern, 26% cpu
> >   :    :........................... Cached on server .....  1.374 s, 1.6 GB/s, 0.72 s kern, 53% cpu
> >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.913 s, 756 MB/s, 0.74 s kern, 26% cpu
> >        :........................... Cached on server .....  1.349 s, 1.6 GB/s, 0.67 s kern, 50% cpu
> >   2048M-mixed-4d
> >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.275 s, 680 MB/s, 0.75 s kern, 24% cpu
> >   :    :........................... Cached on server .....  1.391 s, 1.5 GB/s, 0.71 s kern, 52% cpu
> >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.470 s, 626 MB/s, 0.72 s kern, 21% cpu
> >        :........................... Cached on server .....  1.456 s, 1.5 GB/s, 0.67 s kern, 46% cpu
> >   2048M-mixed-4h
> >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.035 s, 743 MB/s, 0.74 s kern, 26% cpu
> >   :    :........................... Cached on server .....  1.345 s, 1.6 GB/s, 0.71 s kern, 53% cpu
> >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.848 s, 779 MB/s, 0.73 s kern, 26% cpu
> >        :........................... Cached on server .....  1.421 s, 1.5 GB/s, 0.68 s kern, 48% cpu
> >   2048M-mixed-8d
> >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.262 s, 687 MB/s, 0.74 s kern, 24% cpu
> >   :    :........................... Cached on server .....  1.366 s, 1.6 GB/s, 0.69 s kern, 51% cpu
> >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.195 s, 709 MB/s, 0.72 s kern, 24% cpu
> >        :........................... Cached on server .....  1.414 s, 1.5 GB/s, 0.67 s kern, 48% cpu
> >   2048M-mixed-8h
> >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  2.899 s, 789 MB/s, 0.73 s kern, 27% cpu
> >   :    :........................... Cached on server .....  1.338 s, 1.6 GB/s, 0.69 s kern, 52% cpu
> >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.910 s, 772 MB/s, 0.72 s kern, 26% cpu
> >        :........................... Cached on server .....  1.438 s, 1.5 GB/s, 0.67 s kern, 47% cpu
> >   2048M-mixed-16d
> >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  3.416 s, 661 MB/s, 0.73 s kern, 23% cpu
> >   :    :........................... Cached on server .....  1.345 s, 1.6 GB/s, 0.70 s kern, 53% cpu
> >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  3.177 s, 713 MB/s, 0.70 s kern, 23% cpu
> >        :........................... Cached on server .....  1.447 s, 1.5 GB/s, 0.68 s kern, 47% cpu
> >   2048M-mixed-16h
> >   :... v6.0-rc4 (w/o Read Plus) ... Uncached on server ...  2.919 s, 780 MB/s, 0.73 s kern, 26% cpu
> >   :    :........................... Cached on server .....  1.363 s, 1.6 GB/s, 0.70 s kern, 51% cpu
> >   :... v6.0-rc4 (w/ Read Plus) .... Uncached on server ...  2.934 s, 773 MB/s, 0.70 s kern, 25% cpu
> >        :........................... Cached on server .....  1.435 s, 1.5 GB/s, 0.67 s kern, 47% cpu
>
> For this particular change, I'm interested only in cases where the
> whole file is cached on the server. We're focusing on the efficiency
> and performance of the protocol and transport here, not the underlying
> filesystem (which is... xfs?).

Sounds good, I can narrow down to just that test.

>
> Also, 2GB files can be read with just 20 1MB READ requests. That
> means we don't have a large sample size of READ operations for any
> single test, assuming the client is using 1MB rsize.
>
> Also, are these averages, or single runs? I think running each test
> 5-10 times (at least) and including some variance data in the results
> would help build more confidence that the small differences in the
> timing are not noise.

This is an average across 10 runs.

>
> All that said, however, I see with some consistency that READ_PLUS
> takes longer to pull data over the wire, but uses slightly less CPU.
> Assuming the CPU utilizations are client-side, that matches my
> expectations of lower CPU utilization results if the throughput is
> lower.
>
> Looking at the 100% data results, READ_PLUS takes 3.5% longer than
> READ. That to me is a small but significant drop -- I think it will
> be noticeable for large workloads. Can you explain the difference?

I'll try larger files for my next round of testing. I was assuming the
difference is just noise, since there are cases like the mixed-2h test
where READ_PLUS was slightly faster. But more testing will help figure
that out.

>
> For subsequent test runs, can you find a server with more memory,
> test with larger files, and test with a variety of rsize settings?
> You can reduce your test matrix by leaving out the tests with holey
> files for the moment.

Sure thing!

Anna

>
>
> > - v4:
> >  - Change READ and READ_PLUS to return nfserr_serverfault if the splice
> >    splice check fails.
>
> At this point, the code looks fine, but I'd like to understand why
> the performance is not the same.
>
>
> > Thanks,
> > Anna
> >
> >
> > Anna Schumaker (2):
> >  NFSD: Return nfserr_serverfault if splice_ok but buf->pages have data
> >  NFSD: Simplify READ_PLUS
> >
> > fs/nfsd/nfs4xdr.c | 141 +++++++++++-----------------------------------
> > 1 file changed, 33 insertions(+), 108 deletions(-)
> >
> > --
> > 2.37.3
> >
>
> --
> Chuck Lever
>
>
>
