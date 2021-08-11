Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399533E9A11
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 22:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhHKUvp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Aug 2021 16:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhHKUvp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Aug 2021 16:51:45 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F822C061765
        for <linux-nfs@vger.kernel.org>; Wed, 11 Aug 2021 13:51:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C1D9A6855; Wed, 11 Aug 2021 16:51:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C1D9A6855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1628715080;
        bh=hpwjJ7hq21OP/wJBbT5aW5xo9ZncPVh8NR0iBeWbvKI=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=c3ar0IyjZjYDbuAZUFwrj55qAD+yfGK99V2H13HQ/Bhauw3AGMmUZV61zQjcMoFlS
         IRAx/Yfzl82D09In34iOncVJ3AuVbsPKfPPVACpwd0k62N0+SevCQ44tmw0YL1Kc0p
         sUs2X7yr/gRHDGnB2INGlCXYHrkWA763zp4Tsv0Q=
Date:   Wed, 11 Aug 2021 16:51:20 -0400
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Bruce Fields <bfields@redhat.com>,
        Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Message-ID: <20210811205120.GA3783@fieldses.org>
References: <64F9A492-44B9-4057-ABA5-C8202828A8DD@oracle.com>
 <1b8a24a9-5dba-3faf-8b0a-16e728a6051c@rothenpieler.org>
 <5DD80ADC-0A4B-4D95-8CF7-29096439DE9D@oracle.com>
 <0444ca5c-e8b6-1d80-d8a5-8469daa74970@rothenpieler.org>
 <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
 <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com>
 <CAN-5tyHNvYWd1M7sfZNV5q3Y_GZA2-DoTd=CxYvniZ1zkB5hyw@mail.gmail.com>
 <95DB2B47-F370-4787-96D9-07CE2F551AFD@oracle.com>
 <CAN-5tyGXycM1MKa=Sydoo4pP85PGLuh8yjJYsoAM3U+M1NVyCw@mail.gmail.com>
 <D417C606-9E27-431E-B80E-EE927E62A316@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D417C606-9E27-431E-B80E-EE927E62A316@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 11, 2021 at 08:01:30PM +0000, Chuck Lever III wrote:
> Perhaps instead of destroying the rpc_clnt, the server should
> retain it and simply recycle the underlying transport data
> structures.

I think there was more trunking supported added to the rpc client since
the callback code was written, so something like that might make sense
now.

--b.
