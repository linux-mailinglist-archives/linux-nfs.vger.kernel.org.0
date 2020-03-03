Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88455177A04
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Mar 2020 16:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgCCPIe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Mar 2020 10:08:34 -0500
Received: from fieldses.org ([173.255.197.46]:37180 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbgCCPIe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Mar 2020 10:08:34 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 62F7D378; Tue,  3 Mar 2020 10:08:33 -0500 (EST)
Date:   Tue, 3 Mar 2020 10:08:33 -0500
To:     schumaker.anna@gmail.com
Cc:     bfields@redhat.com, linux-nfs@vger.kernel.org,
        Anna.Schumaker@Netapp.com, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 0/4] NFSD: Add support for the v4.2 READ_PLUS operation
Message-ID: <20200303150833.GB17257@fieldses.org>
References: <20200214211206.407725-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214211206.407725-1-Anna.Schumaker@Netapp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sorry for the delay, looking at this a little more carefully now....

Previously I remember you found a problem with very slow
SEEK_HOLE/SEEK_DATA on some filesystems--has that been fixed?

On Fri, Feb 14, 2020 at 04:12:02PM -0500, schumaker.anna@gmail.com wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> These patches add server support for the READ_PLUS operation, which
> breaks read requests into several "data" and "hole" segments when
> replying to the client.
> 
> Here are the results of some performance tests I ran on Netapp lab
> machines.

Any details?  Ideally we'd have enough detail about the hardware and
software used that someone else could reproduce your results if
necessary.

At a minimum I think it would be helpful to know your network latency
and round trip time.  RPC statistics (e.g. number of round trips) might
also be interesting.

Is this a single run for each number?

> I tested by reading various 2G files from a few different
> undelying filesystems and across several NFS versions. I used the
> `vmtouch` utility to make sure files were only cached when we wanted
> them to be. In addition to 100% data and 100% hole cases, I also tested
> with files that alternate between data and hole segments. These files
> have either 4K, 8K, 16K, or 32K segment sizes and start with either data
> or hole segments. So the file mixed-4d has a 4K segment size beginning
> with a data segment, but mixed-32h hase 32K segments beginning with a
> hole. The units are in seconds, with the first number for each NFS
> version being the uncached read time and the second number is for when
> the file is cached on the server.

OK, READ_PLUS is in 4.2, so it's the last column that's the most
interesting one:

> 
> ext4      |        v3       |       v4.0      |       v4.1      |       v4.2      |
> ----------|-----------------|-----------------|-----------------|-----------------|
> data      | 22.909 : 18.253 | 22.934 : 18.252 | 22.902 : 18.253 | 23.485 : 18.253 |

So, the 4.2 case may be taking a couple percent longer in the case there
are no holes.

> hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.253 |  0.708 :  0.709 |

And as expected READ_PLUS is a big advantage when the file is one big
hole.  And there's no difference between cached and uncached reads in
this case since the server's got no data to read off its disk.

> mixed-4d  | 28.261 : 18.253 | 29.616 : 18.252 | 28.341 : 18.252 | 24.508 :  9.150 |
> mixed-8d  | 27.956 : 18.253 | 28.404 : 18.252 | 28.320 : 18.252 | 23.967 :  9.140 |
> mixed-16d | 28.172 : 18.253 | 27.946 : 18.252 | 27.627 : 18.252 | 23.043 :  9.134 |
> mixed-32d | 25.350 : 18.253 | 24.406 : 18.252 | 24.384 : 18.253 | 20.698 :  9.132 |
> mixed-4h  | 28.913 : 18.253 | 28.564 : 18.252 | 27.996 : 18.252 | 21.837 :  9.150 |
> mixed-8h  | 28.625 : 18.253 | 27.833 : 18.252 | 27.798 : 18.253 | 21.710 :  9.140 |
> mixed-16h | 27.975 : 18.253 | 27.662 : 18.252 | 27.795 : 18.253 | 20.585 :  9.134 |
> mixed-32h | 25.958 : 18.253 | 25.491 : 18.252 | 24.856 : 18.252 | 21.018 :  9.132 |

So looks like READ_PLUS helps in every case and there's a slight
improvement with larger hole/data segments, so the seeking does have
some overhead.  (Either that or it's just the extra rpc round trips--I
seem to recall this READ_PLUS implementation only handles at most one
hole and one data segment.  But the fact that the times are so similar
in the uncached case suggests rpc latency isn't a factor--what's your
network?)

I wonder why the hole-first cases are faster than the data-first?

> 
> xfs       |        v3       |       v4.0      |       v4.1      |       v4.2      |
> ----------|-----------------|-----------------|-----------------|-----------------|
> data      | 22.041 : 18.253 | 22.618 : 18.252 | 23.067 : 18.253 | 23.496 : 18.253 |
> hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.253 |  0.723 :  0.708 |
> mixed-4d  | 29.417 : 18.253 | 28.503 : 18.252 | 28.671 : 18.253 | 24.957 :  9.150 |
> mixed-8d  | 29.080 : 18.253 | 29.401 : 18.252 | 29.251 : 18.252 | 24.625 :  9.140 |
> mixed-16d | 27.638 : 18.253 | 28.606 : 18.252 | 27.871 : 18.253 | 25.511 :  9.135 |
> mixed-32d | 24.967 : 18.253 | 25.239 : 18.252 | 25.434 : 18.252 | 21.728 :  9.132 |
> mixed-4h  | 34.816 : 18.253 | 36.243 : 18.252 | 35.837 : 18.252 | 32.332 :  9.150 |
> mixed-8h  | 43.469 : 18.253 | 44.009 : 18.252 | 43.810 : 18.253 | 37.962 :  9.140 |
> mixed-16h | 29.280 : 18.253 | 28.563 : 18.252 | 28.241 : 18.252 | 22.116 :  9.134 |
> mixed-32h | 29.428 : 18.253 | 29.378 : 18.252 | 28.808 : 18.253 | 27.378 :  9.134 |
>
> btrfs     |        v3       |       v4.0      |       v4.1      |       v4.2      |
> ----------|-----------------|-----------------|-----------------|-----------------|
> data      | 25.547 : 18.253 | 25.053 : 18.252 | 24.209 : 18.253 | 32.121 : 18.253 |
> hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.252 |  0.702 :  0.724 |
> mixed-4d  | 19.016 : 18.253 | 18.822 : 18.252 | 18.955 : 18.253 | 18.697 :  9.150 |
> mixed-8d  | 19.186 : 18.253 | 19.444 : 18.252 | 18.841 : 18.253 | 18.452 :  9.140 |
> mixed-16d | 18.480 : 18.253 | 19.010 : 18.252 | 19.167 : 18.252 | 16.000 :  9.134 |
> mixed-32d | 18.635 : 18.253 | 18.565 : 18.252 | 18.550 : 18.252 | 15.930 :  9.132 |
> mixed-4h  | 19.079 : 18.253 | 18.990 : 18.252 | 19.157 : 18.253 | 27.834 :  9.150 |
> mixed-8h  | 18.613 : 18.253 | 19.234 : 18.252 | 18.616 : 18.253 | 20.177 :  9.140 |
> mixed-16h | 18.590 : 18.253 | 19.221 : 18.252 | 19.654 : 18.253 | 17.273 :  9.135 |
> mixed-32h | 18.768 : 18.253 | 19.122 : 18.252 | 18.535 : 18.252 | 15.791 :  9.132 |
> 
> ext3      |        v3       |       v4.0      |       v4.1      |       v4.2      |
> ----------|-----------------|-----------------|-----------------|-----------------|
> data      | 34.292 : 18.253 | 33.810 : 18.252 | 33.450 : 18.253 | 33.390 : 18.254 |
> hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.253 |  0.718 :  0.728 |
> mixed-4d  | 46.818 : 18.253 | 47.140 : 18.252 | 48.385 : 18.253 | 42.887 :  9.150 |
> mixed-8d  | 58.554 : 18.253 | 59.277 : 18.252 | 59.673 : 18.253 | 56.760 :  9.140 |
> mixed-16d | 44.631 : 18.253 | 44.291 : 18.252 | 44.729 : 18.253 | 40.237 :  9.135 |
> mixed-32d | 39.110 : 18.253 | 38.735 : 18.252 | 38.902 : 18.252 | 35.270 :  9.132 |
> mixed-4h  | 56.396 : 18.253 | 56.387 : 18.252 | 56.573 : 18.253 | 67.661 :  9.150 |
> mixed-8h  | 58.483 : 18.253 | 58.484 : 18.252 | 59.099 : 18.253 | 77.958 :  9.140 |
> mixed-16h | 42.511 : 18.253 | 42.338 : 18.252 | 42.356 : 18.252 | 51.805 :  9.135 |
> mixed-32h | 38.419 : 18.253 | 38.504 : 18.252 | 38.643 : 18.252 | 40.411 :  9.132 |
> 
> Any questions?

I'm surprised at the big differences between filesystems in the mixed
cases.  Time for the uncached mixed-4h NFSv4.1 read is (19s, 28s, 36s,
57s) respectively for (btrfs, ext4, xfs, ext3).

READ_PLUS means giving up zero-copy on the client since the offset of
read data in the reply is no longer predictable, I wonder what sort of
test would show that.

--b.
