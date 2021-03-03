Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9680132C6A5
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451061AbhCDA3q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbhCCSgY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 13:36:24 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7C6C061756
        for <linux-nfs@vger.kernel.org>; Wed,  3 Mar 2021 10:25:47 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id D53CD2824; Wed,  3 Mar 2021 13:25:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D53CD2824
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614795946;
        bh=7IhF2BYesVk2KW6XtVk/eDN1B7giCPKp7Si2xNtiHcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zOFu8fewutlfpoys2aLtsW45UBSl2kipZzV57ir7ZQBNToznljbhPVWHTpJI1+yTg
         GIjO54rq+zwj4UZm2pPqp3Xf9hjHIbOUSinGGR/zJqOe+jVWUvzzpKhO0RM3zj8MZ2
         C9tczMmA2OXxz6Klu72rfqsY2HwBdJ0tuXLo+nwU=
Date:   Wed, 3 Mar 2021 13:25:46 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 19/42] SUNRPC: Fix xdr_get_next_encode_buffer() page
 boundary handling
Message-ID: <20210303182546.GC1282@fieldses.org>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
 <161461183307.8508.17196295994390119297.stgit@klimt.1015granger.net>
 <20210302221130.GG3400@fieldses.org>
 <592A34CB-C178-4272-8905-F3BA95BCE299@oracle.com>
 <20210303165251.GB1282@fieldses.org>
 <D8625219-C758-44C0-A74E-272019E12C2E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8625219-C758-44C0-A74E-272019E12C2E@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 03, 2021 at 06:19:33PM +0000, Chuck Lever wrote:
> 
> 
> > On Mar 3, 2021, at 11:52 AM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Wed, Mar 03, 2021 at 03:43:28PM +0000, Chuck Lever wrote:
> >> Why would that not be OK? the next call to xdr_get_next_encode_buffer()
> >> should do the right thing and bounce the new encoded data from the
> >> next page into this one again.
> >> 
> >> So far I have not encountered any problems. Would such a problem show
> >> up with some frequency under normal use, or would it be especially
> >> subtle?
> > 
> > I mainly just want to make sure we've got a coherent idea what this code
> > is doing....
> 
> Agreed, that's a good thing.

I'm also a little vague on what exactly the problem is you're running
into.  (Probably because I haven't really looked at the v3 readdir
encoding.)

Is it approaching the end of a page, or is it running out of buflen?
How exactly does it fail?

--b.

> 
> 
> > For testing: large replies that aren't just read data are readdir and
> > getacl.  So reading large directories with lots of variably-named files
> > might be good. Also pynfs could easily send a single compound with lots
> > of variable-sized reads, that might be interesting.
> 
> I've run the full git regression suite over NFSv3 many many times with
> this patch applied. That includes unpacking via tar, a full build from
> scratch, and then running thousands of individual tests.
> 
> So that doesn't exercise a particular corner case, but it does reflect
> a broad variety of directory operations.
> 
> 
> > Constructing a compound that will result in xdr_reserve_space calls that
> > exactly hit the various corner cases may be hard.  But maybe if we just
> > send a bunch of compounds that vary over some range we can still
> > guarantee hitting those cases.
> > 
> > --b.
> 
> --
> Chuck Lever
> 
> 
