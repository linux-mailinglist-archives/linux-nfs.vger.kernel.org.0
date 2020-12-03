Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8352CDB63
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 17:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgLCQgs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 11:36:48 -0500
Received: from smtp-o-3.desy.de ([131.169.56.156]:38810 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgLCQgs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Dec 2020 11:36:48 -0500
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 47A6060A9E
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 17:36:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 47A6060A9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1607013367; bh=w64YgXlxqOjnAC5dnoSgIg3zEJyEazFDSMdh8/sZMoU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pvHOEc0VVcEeREqLL6jQjkFpxT+P7xM3evdksT6gjMWOCFcwpAmxcgaOSb/gBMKcC
         q7FLLZGsqZY1RkA9OJ94jwfvKoQxnXLUugq4iN3tarW2LzP/BF2A65dmH3mBuFt++1
         bC0qeQ4fpdZ9QbBH/1nRuEwd1XwBOaDwHBRmFLGI=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [IPv6:2001:638:700:1038::1:83])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 42127A0586;
        Thu,  3 Dec 2020 17:36:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 1B64CC0177;
        Thu,  3 Dec 2020 17:36:07 +0100 (CET)
Date:   Thu, 3 Dec 2020 17:36:07 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        trondmy <trondmy@hammerspace.com>
Message-ID: <1111804280.2055084.1607013367020.JavaMail.zimbra@desy.de>
In-Reply-To: <20201203161858.GA27349@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <2137763922.1852883.1606983653611.JavaMail.zimbra@desy.de> <CAN-5tyEWYqXiqLdJE-DLH2b+LrVfPkviJDGQY=MyitS5aW4bJw@mail.gmail.com> <1296195278.2032485.1607010192169.JavaMail.zimbra@desy.de> <20201203161858.GA27349@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Subject: Re: Kernel OPS when using xattr
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Mac)/8.8.15_GA_3980)
Thread-Topic: Kernel OPS when using xattr
Thread-Index: bDBSD7BRH6vvGSbCIoRzSwp4vkO7Zw==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The patch from Frank works.
( you can attribute with Tested-by if needed)

Tigran.

----- Original Message -----
> From: "Frank van der Linden" <fllinden@amazon.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "Olga Kornievskaia" <aglo@umich.edu>, "linux-nfs" <linux-nfs@vger.kernel.org>, "trondmy" <trondmy@hammerspace.com>
> Sent: Thursday, 3 December, 2020 17:18:58
> Subject: Re: Kernel OPS when using xattr

> On Thu, Dec 03, 2020 at 04:43:12PM +0100, Mkrtchyan, Tigran wrote:
>> 
>> Hi Olga,
>> 
>> Franks patches are not applied. I will check with Trond's patch and
>> then will try those as well.
>> 
>> Regards,
>>    Tigran.
> 
> Since my change no longer uses SPARSE_PAGES, it'll probably avoid the
> oops, so give it a try.
> 
> Having said that, fixing SPARSE_PAGES seems like a better option.. My
> ideal outcome would be to have a working SPARSE_PAGES for all transports.
> That would allow GETXATTR and LISTXATTRS to just always specify a max
> size array of pages, giving it maximum flexibility to cache the received
> result no matter what, and avoiding allocations that are too large.
> 
> For now, though, I'm happy with the v2 patch I sent in.
> 
> - Frank
