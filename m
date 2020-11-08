Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED842AACC1
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Nov 2020 19:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgKHSPX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Nov 2020 13:15:23 -0500
Received: from smtp-o-2.desy.de ([131.169.56.155]:56164 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgKHSPX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 8 Nov 2020 13:15:23 -0500
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
        by smtp-o-2.desy.de (Postfix) with ESMTP id E19A3160E7B
        for <linux-nfs@vger.kernel.org>; Sun,  8 Nov 2020 19:15:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de E19A3160E7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1604859319; bh=nFU4ELKlkBc8QL6FBOK3qYP664KE90+qnCI6esnICFw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=uGLhDABRZRriuoye/hZAqARruvNz51dW1kYw5QGplvOYesyUpMs8R/rmM6s5tzH4a
         g+AHP8CjQQAd4Oc/xOA9cXS/8Q+pVkx5gu73w44m0kKM3C11iXWsDXzmfcRnnavOFR
         VCHheB3O0FOKgF1eexZRuatGwaoLUzQH1LVCX/d0=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id D8F951A0146;
        Sun,  8 Nov 2020 19:15:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id B1C7480067;
        Sun,  8 Nov 2020 19:15:19 +0100 (CET)
Date:   Sun, 8 Nov 2020 19:15:19 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trondmy@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1298679928.7009739.1604859319295.JavaMail.zimbra@desy.de>
In-Reply-To: <0A45C334-A375-47DC-BA04-F25341F263FA@redhat.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com> <0A45C334-A375-47DC-BA04-F25341F263FA@redhat.com>
Subject: Re: [PATCH v3 00/17] Readdir enhancements
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF82 (Mac)/8.8.15_GA_3953)
Thread-Topic: Readdir enhancements
Thread-Index: RdUhotRmJMZFUsxhmZqftx527MRDvg==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



----- Original Message -----
> From: "Benjamin Coddington" <bcodding@redhat.com>
> To: "Trond Myklebust" <trondmy@gmail.com>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Saturday, 7 November, 2020 13:49:31
> Subject: Re: [PATCH v3 00/17] Readdir enhancements

> On 4 Nov 2020, at 11:16, trondmy@gmail.com wrote:
> 
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>> The following patch series performs a number of cleanups on the readdir
>> code.
>> It also adds support for 1MB readdir RPC calls on-the-wire, and modifies
>> the caching code to ensure that we cache the entire contents of that
>> 1MB call (instead of discarding the data that doesn't fit into a single
>> page).
>>
>> v2: Fix the handling of the NFSv3/v4 directory verifier
>> v3: Optimise searching when the readdir cookies are seen to be ordered
> 
> Hi Trond, thanks for these.
> 
> I did a bit of testing with these on 4-core/4G client listing 1.5M files
> with READDIR.  I compared v5.10-rc2 without/with this set.
> 
> +------+     v5.10.rc-2      +--+ this v3 patch set  +
>| run  |  time   | rpc calls |  |  time  | rpc calls |
> 
> nfsv3 with dtsize 262144:
> +------+---------+-----------+--+--------+-----------+
>| 1    | 81.583  | 14710     |  | 53.568 | 215       |
>| 2    | 81.147  | 14710     |  | 50.781 | 215       |
>| 3    | 81.61   | 14710     |  | 50.514 | 215       |
>| 4    | 82.405  | 14710     |  | 50.746 | 215       |
>| 5    | 82.066  | 14710     |  | 50.397 | 215       |
>| 6    | 82.395  | 14710     |  | 50.892 | 215       |
>| 7    | 81.657  | 14710     |  | 50.882 | 215       |
>| 8    | 81.555  | 14710     |  | 50.981 | 215       |
>| 9    | 81.421  | 14710     |  | 50.558 | 215       |
>| 10   | 81.472  | 14710     |  | 50.588 | 215       |
> 
> nfsv3 with dtsize 1048576:
> +------+---------+-----------+--+--------+-----------+
>| 1    | 81.563  | 14710     |  | 52.692 | 61        |
>| 2    | 82.123  | 14710     |  | 49.934 | 61        |
>| 3    | 81.714  | 14710     |  | 50.158 | 61        |
>| 4    | 81.707  | 14710     |  | 50.083 | 61        |
>| 5    | 81.44   | 14710     |  | 50.045 | 61        |
>| 6    | 81.685  | 14710     |  | 50.021 | 61        |
>| 7    | 81.17   | 14710     |  | 50.131 | 61        |
>| 8    | 81.366  | 14710     |  | 49.928 | 61        |
>| 9    | 81.067  | 14710     |  | 50.081 | 61        |
>| 10   | 81.524  | 14710     |  | 50.442 | 61        |
> 
> nfsv4 with dtsize 32768:
> +------+---------+-----------+--+--------+-----------+
>| 1    | 99.534  | 14712     |  | 79.461 | 331       |
>| 2    | 98.998  | 14712     |  | 79.338 | 331       |
>| 3    | 99.462  | 14712     |  | 81.101 | 331       |
>| 4    | 99.891  | 14712     |  | 78.888 | 331       |
>| 5    | 99.516  | 14712     |  | 81.147 | 331       |
>| 6    | 98.649  | 14712     |  | 83.084 | 331       |
>| 7    | 101.159 | 14712     |  | 80.461 | 331       |
>| 8    | 100.402 | 14712     |  | 79.003 | 331       |
>| 9    | 98.548  | 14712     |  | 80.619 | 331       |
>| 10   | 97.456  | 14712     |  | 81.317 | 331       |
> 
> nfsv4 with 1048576:
> +------+---------+-----------+--+--------+-----------+
>| 1    | 100.357 | 14712     |  | 78.976 | 91        |
>| 2    | 99.61   | 14712     |  | 79.328 | 91        |
>| 3    | 101.095 | 14712     |  | 80.649 | 91        |
>| 4    | 107.904 | 14712     |  | 78.285 | 91        |
>| 5    | 103.665 | 14712     |  | 79.258 | 91        |
>| 6    | 98.877  | 14712     |  | 78.817 | 91        |
>| 7    | 99.567  | 14712     |  | 81.11  | 91        |
>| 8    | 99.096  | 14712     |  | 80.296 | 91        |
>| 9    | 100.124 | 14712     |  | 78.865 | 91        |
>| 10   | 100.603 | 14712     |  | 79.143 | 91        |


Hi Ben, hi Trond,

though number of RPC call between dtsize 1048576 and 32768
is x3 less, the time it takes almost the same. According to
your results, at some point (<= 32K) a bigger dtsize makes
no difference. As the original dtsize is 32K 
(#define NFS_MAX_READDIR_PAGES 8), it looks like that the
performance enhancements mostly contributed by a change
not related to the buffer size.

On another, the number of RPC calls with v3-patch-set drops
by x40. What ever Trond have changed there has a big impact!

Thanks a lot for your efforts,
   Tigran.

> 
> These look great.  Feel free to add either/both of my:
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
> Tested-by: Benjamin Coddington <bcodding@redhat.com>
> 
> Ben
