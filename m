Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06B52CDBA4
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 17:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgLCQ5y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 11:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgLCQ5y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 11:57:54 -0500
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [IPv6:2001:638:700:1038::1:9a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE1EC061A4E
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 08:57:13 -0800 (PST)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
        by smtp-o-1.desy.de (Postfix) with ESMTP id BB200E081A
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 17:57:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de BB200E081A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1607014631; bh=dLsIMGXjGkujVehXCe2sAu28GBpcRQsviPnyqFuZnz8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=nhOpOT35XW11pP1o1t0PB5D+kaFjDopcR12hj99IlsALAK6cPGfpuLSCg0gjIdT8x
         DniDJQJNBqgQqkxUHONhlPxP4IDw94AHLJQqKIE2Q7N4IgLFu9tw5jiahBdg5TLnPq
         J2mUWq/O/9MaqMkGjDP+sB5bZdlY/3Bw8sx9lnPA=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id B16881208A0;
        Thu,  3 Dec 2020 17:57:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 896ADC0177;
        Thu,  3 Dec 2020 17:57:11 +0100 (CET)
Date:   Thu, 3 Dec 2020 17:57:11 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        trondmy <trondmy@hammerspace.com>
Message-ID: <1525949722.2059532.1607014631422.JavaMail.zimbra@desy.de>
In-Reply-To: <1661972531.2055379.1607013492207.JavaMail.zimbra@desy.de>
References: <2137763922.1852883.1606983653611.JavaMail.zimbra@desy.de> <CAN-5tyEWYqXiqLdJE-DLH2b+LrVfPkviJDGQY=MyitS5aW4bJw@mail.gmail.com> <1296195278.2032485.1607010192169.JavaMail.zimbra@desy.de> <20201203161858.GA27349@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com> <1111804280.2055084.1607013367020.JavaMail.zimbra@desy.de> <1661972531.2055379.1607013492207.JavaMail.zimbra@desy.de>
Subject: Re: Kernel OPS when using xattr
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Mac)/8.8.15_GA_3980)
Thread-Topic: Kernel OPS when using xattr
Thread-Index: bDBSD7BRH6vvGSbCIoRzSwp4vkO7Z07vhu9kRlUQhOs=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Frank's v2 works as well. 

Tigran.

----- Original Message -----
> From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> To: "Frank van der Linden" <fllinden@amazon.com>
> Cc: "Olga Kornievskaia" <aglo@umich.edu>, "linux-nfs" <linux-nfs@vger.kernel.org>, "trondmy" <trondmy@hammerspace.com>
> Sent: Thursday, 3 December, 2020 17:38:12
> Subject: Re: Kernel OPS when using xattr

> Oh. I tested V1.... Let me check v2 as well.
> 
> Tigran.
> 
> ----- Original Message -----
>> From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
>> To: "Frank van der Linden" <fllinden@amazon.com>
>> Cc: "Olga Kornievskaia" <aglo@umich.edu>, "linux-nfs"
>> <linux-nfs@vger.kernel.org>, "trondmy" <trondmy@hammerspace.com>
>> Sent: Thursday, 3 December, 2020 17:36:07
>> Subject: Re: Kernel OPS when using xattr
> 
>> The patch from Frank works.
>> ( you can attribute with Tested-by if needed)
>> 
>> Tigran.
>> 
>> ----- Original Message -----
>>> From: "Frank van der Linden" <fllinden@amazon.com>
>>> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
>>> Cc: "Olga Kornievskaia" <aglo@umich.edu>, "linux-nfs"
>>> <linux-nfs@vger.kernel.org>, "trondmy" <trondmy@hammerspace.com>
>>> Sent: Thursday, 3 December, 2020 17:18:58
>>> Subject: Re: Kernel OPS when using xattr
>> 
>>> On Thu, Dec 03, 2020 at 04:43:12PM +0100, Mkrtchyan, Tigran wrote:
>>>> 
>>>> Hi Olga,
>>>> 
>>>> Franks patches are not applied. I will check with Trond's patch and
>>>> then will try those as well.
>>>> 
>>>> Regards,
>>>>    Tigran.
>>> 
>>> Since my change no longer uses SPARSE_PAGES, it'll probably avoid the
>>> oops, so give it a try.
>>> 
>>> Having said that, fixing SPARSE_PAGES seems like a better option.. My
>>> ideal outcome would be to have a working SPARSE_PAGES for all transports.
>>> That would allow GETXATTR and LISTXATTRS to just always specify a max
>>> size array of pages, giving it maximum flexibility to cache the received
>>> result no matter what, and avoiding allocations that are too large.
>>> 
>>> For now, though, I'm happy with the v2 patch I sent in.
>>> 
> > > - Frank
