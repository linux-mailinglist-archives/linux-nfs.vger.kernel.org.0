Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC803353094
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Apr 2021 23:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhDBVB7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Apr 2021 17:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhDBVB7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Apr 2021 17:01:59 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B71DC0613E6
        for <linux-nfs@vger.kernel.org>; Fri,  2 Apr 2021 14:01:57 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1F20A6D18; Fri,  2 Apr 2021 17:01:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1F20A6D18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1617397317;
        bh=d/6+d8HxagUFpp9zzz8c7tCG2YWkT2ICiCAOlw+roG8=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=ptXNxZufnAErXUWRikXxUVKtmyYi1iiZLlpaPA4MKxNpE5QzYgJ2b1D7N/UvpMB2K
         JNaqNOwcIxvihZSFFCzf1QYGpc8yjtTf9YxXgs9oQ6NqQOpr2KjfdCKa8nwBxs2+yg
         H+m3o0SCe+B0pjjhZ6DQ4NmdpO7HPY3tLB4brNI4=
Date:   Fri, 2 Apr 2021 17:01:57 -0400
To:     Rick Macklem <rmacklem@uoguelph.ca>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>, nfsv4@ietf.org
Subject: Re: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within
 the last hole
Message-ID: <20210402210157.GC16427@fieldses.org>
References: <20210331192819.25637-1-olga.kornievskaia@gmail.com>
 <YGUm7/HE3HqVJik2@pick.fieldses.org>
 <CAN-5tyETvKvUq_X7+2E0o=9GjJ628DC=QJW5xKA2-X7UHc_DOw@mail.gmail.com>
 <YQXPR0101MB0968C9AB372DC12408F496D8DD7B9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQXPR0101MB0968C9AB372DC12408F496D8DD7B9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Adding nfsv4@ietf.org:

On Thu, Apr 01, 2021 at 09:32:05PM +0000, Rick Macklem wrote:
> I discussed this on nfsv4@ietf.org some time ago.
> The problem with "fixing" the server is that it breaks
> the unpatched Linux client.
> 
> If the client is careful, it can work correctly for both a Linux
> and RFC5661 conformant server. That's what the FreeBSD
> client tries to do.
> --> I'd suggest that be your main goal.
> 
> The FreeBSD server ships "Linux compatible", but there is
> a switch to make it RFC5661 compatible.
> --> I wouldn't make it default the RFC compatible for
>       quite a while after the client that handles RFC compatible
>       ships.
> 
> I tried to convince folks to "errata" the RFC to Linux
> compatible (since Linux was the only shipping 4.2 at
> the time, but they did not consider it an "errata").

Previous discussion here:

	https://mailarchive.ietf.org/arch/msg/nfsv4/bPLFnywt1wZ4kolMkzeSYca0qIM/

There's no rejection on that thread, was it elsewhere?

--b.
