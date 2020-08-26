Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117B32539F5
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Aug 2020 23:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHZVyz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Aug 2020 17:54:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54450 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726753AbgHZVyy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Aug 2020 17:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598478892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hxtvXSJdj5QSt1FET4nzgXb0n++oVbcGrPbXPBtksoo=;
        b=GClq+XyQgHiIo4YerkWjyNoy9IjqROFEWAXlG6gQvtfSA2yW6ikQ+Cb1AMK7Ie9U5Xs7wu
        Znd5G1S1nhyyNla3W9E0hHxzqYPlSMJ0E12oW6GFFvpRf+kKlug8Ekcqj3y/ATgtAMPpvY
        4E4g9aHOWNNCeJuczaGVIXV3OkjUxUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-XlgP5UaWMt6TQD8P2i1_3Q-1; Wed, 26 Aug 2020 17:54:48 -0400
X-MC-Unique: XlgP5UaWMt6TQD8P2i1_3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 413101005E73;
        Wed, 26 Aug 2020 21:54:47 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-119-12.rdu2.redhat.com [10.10.119.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 914A67A41C;
        Wed, 26 Aug 2020 21:54:46 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 578B212037E; Wed, 26 Aug 2020 17:54:37 -0400 (EDT)
Date:   Wed, 26 Aug 2020 17:54:37 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     schumaker.anna@gmail.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Anna.Schumaker@netapp.com
Subject: Re: [PATCH v4 0/5] NFSD: Add support for the v4.2 READ_PLUS operation
Message-ID: <20200826215437.GD62682@pick.fieldses.org>
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 17, 2020 at 12:53:05PM -0400, schumaker.anna@gmail.com wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> These patches add server support for the READ_PLUS operation, which
> breaks read requests into several "data" and "hole" segments when
> replying to the client.
> 
> - Changes since v3:
>   - Combine first two patches related to xdr_reserve_space_vec()
>   - Remove unnecessary call to svc_encode_read_payload()
> 
> Here are the results of some performance tests I ran on some lab
> machines.

What's the hardware setup (do you know network and disk bandwidth?).

> I tested by reading various 2G files from a few different underlying
> filesystems and across several NFS versions. I used the `vmtouch` utility
> to make sure files were only cached when we wanted them to be. In addition
> to 100% data and 100% hole cases, I also tested with files that alternate
> between data and hole segments. These files have either 4K, 8K, 16K, or 32K
> segment sizes and start with either data or hole segments. So the file
> mixed-4d has a 4K segment size beginning with a data segment, but mixed-32h
> has 32K segments beginning with a hole. The units are in seconds, with the
> first number for each NFS version being the uncached read time and the second
> number is for when the file is cached on the server.

The only numbers that look really strange are in the btrfs uncached
case, in the data-only case and the mixed case that start with a hole.
Do we have any idea what's up there?

--b.

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

