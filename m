Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB75B3B37F1
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 22:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhFXUi5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Jun 2021 16:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhFXUi5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Jun 2021 16:38:57 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B90C061574
        for <linux-nfs@vger.kernel.org>; Thu, 24 Jun 2021 13:36:38 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8AE43478E; Thu, 24 Jun 2021 16:36:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8AE43478E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1624566996;
        bh=tls3jzc9oYaj4+qpSOk3GKfzx0BwpIPYcLpKpDcbTng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8NOhxEG0RI7SBE1DsUbUlncjNNbtKk88BT0UmQnhXSRu9nVcBInlYBzhxokDt0AQ
         MallUg++BELlLGL4NncWDE37K4rTPBkcORZlvCQfdfKIwE/PrImlNoHbI55GOvRpkZ
         7FMvq0Eiqj1y7IcziIK9HlmgKrPKqrLOBCJI0Q7M=
Date:   Thu, 24 Jun 2021 16:36:36 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
Message-ID: <20210624203636.GA4671@fieldses.org>
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210624140216.GB30394@fieldses.org>
 <c983218b-d270-bbae-71c5-b591bfbce473@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c983218b-d270-bbae-71c5-b591bfbce473@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 24, 2021 at 12:50:25PM -0700, dai.ngo@oracle.com wrote:
> On 6/24/21 7:02 AM, J. Bruce Fields wrote:
> >I'm not sure how to deal with this.  I don't think there's an efficient
> >way to determine which expired client is responsible for an ENOSPC.  So,
> >maybe you'd check for ENOSPC and when you see it, remove all expired
> >clients and retry if there were any?
> 
> I did a quick check on fs/nfsd and did not see anywhere the server returns
> ENOSPC/nfserr_nospc so I'm not sure where to check? Currently we plan to
> destroy the courtesy client after 24hr if it has not reconnect but that's
> a long time.

The error normally originates from the filesystem.  Anything that might
need to allocate space could hit it, and it could happen to a non-nfsd
process.

I'm not seeing an easy way to do this; we might need ideas from other
filesystem developers.

--b.
