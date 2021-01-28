Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01ABF307E8A
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jan 2021 20:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhA1S4J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 13:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhA1Sv0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jan 2021 13:51:26 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED38FC06178B;
        Thu, 28 Jan 2021 10:50:43 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id A2A634163; Thu, 28 Jan 2021 13:50:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A2A634163
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611859842;
        bh=O2QhWKxUiDcf6x2ujs95u3iWaIVVJV2+uNn4cjNsIZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnFtCSnGXeQSWFAGogu4NtdJQorx/JwnTjo8DDlJKGQvtjpjEJdmOvO2mruqjuCmR
         9WMMvdojVUSY4nWRQitFuNyo43M6acrmGb0bS459az3mLRiRvR567hgROU+8kmCdhJ
         xKW9op6vkSZWaKLswRknRbf5LIezAf098S8+kOu4=
Date:   Thu, 28 Jan 2021 13:50:42 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] nfsd: fix check of statid returned from call to
 find_stateid_by_type
Message-ID: <20210128185042.GB29887@fieldses.org>
References: <20210128144935.640026-1-colin.king@canonical.com>
 <793C88A3-B117-4138-B74A-845E0BD383C9@oracle.com>
 <20210128153456.GI2696@kadam>
 <80ACEDFA-B496-44E0-AABB-BD4A7826516B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ACEDFA-B496-44E0-AABB-BD4A7826516B@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 28, 2021 at 03:53:36PM +0000, Chuck Lever wrote:
> > On Jan 28, 2021, at 10:34 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > Fixes tags are used for a lot of different things:
> > 1)  If there is a fixes tag, then you can tell it does *NOT* have to
> >    be back ported because the original commit is not in the stable
> >    tree.  It saves time for the stable maintainers.
> > 2)  Metrics to figure out how quickly we are fixing bugs.
> > 3)  Sometimes the Fixes tag helps because we want to review the original
> >    patch to see what the intent was.
> > 
> > All sorts of stuff.  Etc.
> 
> Yep, I'm a fan of all that. I just want to avoid poking the stable
> automation bear when it's unnecessary.

I've routinely had patches with Fixes: lines referencing other queued-up
patches, and I didn't get any stable mail about it.

100% not something to worry about.

--b.
