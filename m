Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1383F27B960
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Sep 2020 03:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgI2B3O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 21:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbgI2B3O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 21:29:14 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601342952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M0L+tyM2W7BXTBiEA5kjJg/A3m9nTIeVOGCcAmv++0o=;
        b=h+hhZdmRm5asd/Njzgfsl+pQiKgBAxayatTpNj1/fkl/tjai6dBbXVJ4qClYa2A7plHq5a
        8K2HtMCg0DTEafOqniRM5cAOJBFu4A1HPBS0VyZa6RGQatknNwZq3ZhdKXE7yS4FmR/Gnh
        6ioI7FGw1J90P6rliAeJZBf+txCMXxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-U0D33_aLN-2H_JOcneGGTQ-1; Mon, 28 Sep 2020 21:29:07 -0400
X-MC-Unique: U0D33_aLN-2H_JOcneGGTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F130E10A7AE0;
        Tue, 29 Sep 2020 01:29:05 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-116-211.rdu2.redhat.com [10.10.116.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FF7455779;
        Tue, 29 Sep 2020 01:29:05 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 8E24012099D; Mon, 28 Sep 2020 21:29:04 -0400 (EDT)
Date:   Mon, 28 Sep 2020 21:29:04 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     schumaker.anna@gmail.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Anna.Schumaker@netapp.com
Subject: Re: [PATCH v6 0/5] NFSD: Add support for the v4.2 READ_PLUS operation
Message-ID: <20200929012904.GA521216@pick.fieldses.org>
References: <20200928170901.707554-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928170901.707554-1-Anna.Schumaker@Netapp.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 28, 2020 at 01:08:56PM -0400, schumaker.anna@gmail.com wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> These patches add server support for the READ_PLUS operation, which
> breaks read requests into several "data" and "hole" segments when
> replying to the client.
> 
> - Changes since v5:
>   - Set the right buffer size through svc_reserve()
>   - Fix up nfsd4_read_plus_rsize() to make sure we have enough buffer
>   - Limit maxcount to the amount of buffer space when encoding data
>   - Bail out of unexpected hole values by encoding a data segment
>   - Rebase to v5.9-rc7

I'll give the patches another once over, but I think those were my
remaining concerns.

Except for the btrfs regression.  I guess it's just a btrfs bug.  At
this point I'm willing to go ahead and merge this anyway if nobody
objects.  Might be nice to try giving them a heads up again, though.

--b.

> Here are the results of some performance tests I ran on some lab
> machines. I tested by reading various 2G files from a few different underlying
> filesystems and across several NFS versions. I used the `vmtouch` utility
> to make sure files were only cached when we wanted them to be. In addition
> to 100% data and 100% hole cases, I also tested with files that alternate
> between data and hole segments. These files have either 4K, 8K, 16K, or 32K
> segment sizes and start with either data or hole segments. So the file
> mixed-4d has a 4K segment size beginning with a data segment, but mixed-32h
> has 32K segments beginning with a hole. The units are in seconds, with the
> first number for each NFS version being the uncached read time and the second
> number is for when the file is cached on the server.
> 
> I added some extra data collection (client cpu percentage and sys time),
> but the extra data means I couldn't figure out a way to break this down
> into a concise table. I cut out v3 and v4.0 performance numbers to get
> the size down, but I kept v4.1 for comparison because it uses the same
> code that v4.2 without read plus uses.
> 
> 
> Read Plus Results (ext4):
>   data
>    :... v4.1 ... Uncached ... 20.540 s, 105 MB/s, 0.65 s kern, 3% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 20.605 s, 104 MB/s, 0.65 s kern, 3% cpu
>         :....... Cached ..... 18.253 s, 118 MB/s, 0.67 s kern, 3% cpu
>   hole
>    :... v4.1 ... Uncached ... 18.255 s, 118 MB/s, 0.72 s kern,  3% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern,  3% cpu
>    :... v4.2 ... Uncached ...  0.847 s, 2.5 GB/s, 0.73 s kern, 86% cpu
>         :....... Cached .....  0.845 s, 2.5 GB/s, 0.72 s kern, 85% cpu
>   mixed-4d
>    :... v4.1 ... Uncached ... 54.691 s,  39 MB/s, 0.75 s kern, 1% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 51.587 s,  42 MB/s, 0.75 s kern, 1% cpu
>         :....... Cached .....  9.215 s, 233 MB/s, 0.67 s kern, 7% cpu
>   mixed-8d
>    :... v4.1 ... Uncached ... 37.072 s,  58 MB/s, 0.67 s kern, 1% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 33.259 s,  65 MB/s, 0.68 s kern, 2% cpu
>         :....... Cached .....  9.172 s, 234 MB/s, 0.67 s kern, 7% cpu
>   mixed-16d
>    :... v4.1 ... Uncached ... 27.138 s,  79 MB/s, 0.73 s kern, 2% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 23.042 s,  93 MB/s, 0.73 s kern, 3% cpu
>         :....... Cached .....  9.150 s, 235 MB/s, 0.66 s kern, 7% cpu
>   mixed-32d
>    :... v4.1 ... Uncached ... 25.326 s,  85 MB/s, 0.68 s kern, 2% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 21.125 s, 102 MB/s, 0.69 s kern, 3% cpu
>         :....... Cached .....  9.140 s, 235 MB/s, 0.67 s kern, 7% cpu
>   mixed-4h
>    :... v4.1 ... Uncached ... 58.317 s,  37 MB/s, 0.75 s kern, 1% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 51.878 s,  41 MB/s, 0.74 s kern, 1% cpu
>         :....... Cached .....  9.215 s, 233 MB/s, 0.68 s kern, 7% cpu
>   mixed-8h
>    :... v4.1 ... Uncached ... 36.855 s,  58 MB/s, 0.68 s kern, 1% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 29.457 s,  73 MB/s, 0.68 s kern, 2% cpu
>         :....... Cached .....  9.172 s, 234 MB/s, 0.67 s kern, 7% cpu
>   mixed-16h
>    :... v4.1 ... Uncached ... 26.460 s,  81 MB/s, 0.74 s kern, 2% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 19.587 s, 110 MB/s, 0.74 s kern, 3% cpu
>         :....... Cached .....  9.150 s, 235 MB/s, 0.67 s kern, 7% cpu
>   mixed-32h
>    :... v4.1 ... Uncached ... 25.495 s,  84 MB/s, 0.69 s kern, 2% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.65 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 17.634 s, 122 MB/s, 0.69 s kern, 3% cpu
>         :....... Cached .....  9.140 s, 235 MB/s, 0.68 s kern, 7% cpu
> 
> 
> 
> Read Plus Results (xfs):
>   data
>    :... v4.1 ... Uncached ... 20.230 s, 106 MB/s, 0.65 s kern, 3% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 20.724 s, 104 MB/s, 0.65 s kern, 3% cpu
>         :....... Cached ..... 18.253 s, 118 MB/s, 0.67 s kern, 3% cpu
>   hole
>    :... v4.1 ... Uncached ... 18.255 s, 118 MB/s, 0.68 s kern,  3% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.69 s kern,  3% cpu
>    :... v4.2 ... Uncached ...  0.904 s, 2.4 GB/s, 0.72 s kern, 79% cpu
>         :....... Cached .....  0.908 s, 2.4 GB/s, 0.73 s kern, 80% cpu
>   mixed-4d
>    :... v4.1 ... Uncached ... 57.553 s,  37 MB/s, 0.77 s kern, 1% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 37.162 s,  58 MB/s, 0.73 s kern, 1% cpu
>         :....... Cached .....  9.215 s, 233 MB/s, 0.67 s kern, 7% cpu
>   mixed-8d
>    :... v4.1 ... Uncached ... 36.754 s,  58 MB/s, 0.69 s kern, 1% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 24.454 s,  88 MB/s, 0.69 s kern, 2% cpu
>         :....... Cached .....  9.172 s, 234 MB/s, 0.66 s kern, 7% cpu
>   mixed-16d
>    :... v4.1 ... Uncached ... 27.156 s,  79 MB/s, 0.73 s kern, 2% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 22.934 s,  94 MB/s, 0.72 s kern, 3% cpu
>         :....... Cached .....  9.150 s, 235 MB/s, 0.68 s kern, 7% cpu
>   mixed-32d
>    :... v4.1 ... Uncached ... 27.849 s,  77 MB/s, 0.68 s kern, 2% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 23.670 s,  91 MB/s, 0.67 s kern, 2% cpu
>         :....... Cached .....  9.139 s, 235 MB/s, 0.64 s kern, 7% cpu
>   mixed-4h
>    :... v4.1 ... Uncached ... 57.639 s,  37 MB/s, 0.72 s kern, 1% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.69 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 35.503 s,  61 MB/s, 0.72 s kern, 2% cpu
>         :....... Cached .....  9.215 s, 233 MB/s, 0.66 s kern, 7% cpu
>   mixed-8h
>    :... v4.1 ... Uncached ... 37.044 s,  58 MB/s, 0.71 s kern, 1% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 23.779 s,  90 MB/s, 0.69 s kern, 2% cpu
>         :....... Cached .....  9.172 s, 234 MB/s, 0.65 s kern, 7% cpu
>   mixed-16h
>    :... v4.1 ... Uncached ... 27.167 s,  79 MB/s, 0.73 s kern, 2% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.67 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 19.088 s, 113 MB/s, 0.75 s kern, 3% cpu
>         :....... Cached .....  9.159 s, 234 MB/s, 0.66 s kern, 7% cpu
>   mixed-32h
>    :... v4.1 ... Uncached ... 27.592 s,  78 MB/s, 0.71 s kern, 2% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 19.682 s, 109 MB/s, 0.67 s kern, 3% cpu
>         :....... Cached .....  9.140 s, 235 MB/s, 0.67 s kern, 7% cpu
> 
> 
> 
> Read Plus Results (btrfs):
>   data
>    :... v4.1 ... Uncached ... 21.317 s, 101 MB/s, 0.63 s kern, 2% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.67 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 28.665 s,  75 MB/s, 0.65 s kern, 2% cpu
>         :....... Cached ..... 18.253 s, 118 MB/s, 0.66 s kern, 3% cpu
>   hole
>    :... v4.1 ... Uncached ... 18.256 s, 118 MB/s, 0.70 s kern,  3% cpu
>    :    :....... Cached ..... 18.254 s, 118 MB/s, 0.73 s kern,  4% cpu
>    :... v4.2 ... Uncached ...  0.851 s, 2.5 GB/s, 0.72 s kern, 84% cpu
>         :....... Cached .....  0.847 s, 2.5 GB/s, 0.73 s kern, 86% cpu
>   mixed-4d
>    :... v4.1 ... Uncached ... 56.857 s,  38 MB/s, 0.76 s kern, 1% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 54.455 s,  39 MB/s, 0.73 s kern, 1% cpu
>         :....... Cached .....  9.215 s, 233 MB/s, 0.68 s kern, 7% cpu
>   mixed-8d
>    :... v4.1 ... Uncached ... 36.641 s,  59 MB/s, 0.68 s kern, 1% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 33.205 s,  65 MB/s, 0.67 s kern, 2% cpu
>         :....... Cached .....  9.172 s, 234 MB/s, 0.65 s kern, 7% cpu
>   mixed-16d
>    :... v4.1 ... Uncached ... 28.653 s,  75 MB/s, 0.72 s kern, 2% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 25.748 s,  83 MB/s, 0.71 s kern, 2% cpu
>         :....... Cached .....  9.150 s, 235 MB/s, 0.64 s kern, 7% cpu
>   mixed-32d
>    :... v4.1 ... Uncached ... 28.886 s,  74 MB/s, 0.67 s kern, 2% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 24.724 s,  87 MB/s, 0.74 s kern, 2% cpu
>         :....... Cached .....  9.140 s, 235 MB/s, 0.63 s kern, 6% cpu
>   mixed-4h
>    :... v4.1 ... Uncached ...  52.181 s,  41 MB/s, 0.73 s kern, 1% cpu
>    :    :....... Cached .....  18.252 s, 118 MB/s, 0.66 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 150.341 s,  14 MB/s, 0.72 s kern, 0% cpu
>         :....... Cached .....   9.216 s, 233 MB/s, 0.63 s kern, 6% cpu
>   mixed-8h
>    :... v4.1 ... Uncached ... 36.945 s,  58 MB/s, 0.68 s kern, 1% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.65 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 79.781 s,  27 MB/s, 0.68 s kern, 0% cpu
>         :....... Cached .....  9.172 s, 234 MB/s, 0.66 s kern, 7% cpu
>   mixed-16h
>    :... v4.1 ... Uncached ... 28.651 s,  75 MB/s, 0.73 s kern, 2% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.66 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 47.428 s,  45 MB/s, 0.71 s kern, 1% cpu
>         :....... Cached .....  9.150 s, 235 MB/s, 0.67 s kern, 7% cpu
>   mixed-32h
>    :... v4.1 ... Uncached ... 28.618 s,  75 MB/s, 0.69 s kern, 2% cpu
>    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
>    :... v4.2 ... Uncached ... 38.813 s,  55 MB/s, 0.67 s kern, 1% cpu
>         :....... Cached .....  9.140 s, 235 MB/s, 0.61 s kern, 6% cpu
> 
> 
> Thoughts?
> Anna
> 
> 
> Anna Schumaker (5):
>   SUNRPC/NFSD: Implement xdr_reserve_space_vec()
>   NFSD: Add READ_PLUS data support
>   NFSD: Add READ_PLUS hole segment encoding
>   NFSD: Return both a hole and a data segment
>   NFSD: Encode a full READ_PLUS reply
> 
>  fs/nfsd/nfs4proc.c         |  21 +++++
>  fs/nfsd/nfs4xdr.c          | 177 +++++++++++++++++++++++++++++++------
>  include/linux/sunrpc/xdr.h |   2 +
>  net/sunrpc/xdr.c           |  45 ++++++++++
>  4 files changed, 217 insertions(+), 28 deletions(-)
> 
> -- 
> 2.28.0
> 

