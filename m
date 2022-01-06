Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4146E486A99
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 20:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbiAFTnX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 14:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243373AbiAFTnW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jan 2022 14:43:22 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9240FC061245
        for <linux-nfs@vger.kernel.org>; Thu,  6 Jan 2022 11:43:22 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id EAF1644D2; Thu,  6 Jan 2022 14:43:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EAF1644D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641498201;
        bh=Rjo0VfX2LWm6CNhy5U8jPkbpaChmXlg29M9K2zjYo3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TqOCt+lxdlXtHOyZn+agx9qCEsdvZfi+IzFAK+XeyHYFAk3yOsBiFn4AgPzCReFiY
         nSgp7Mhby6kWpc6d5vi53WJ/J841V1IgQ3Q5zddrtB80PFW5Yk9TX9pXvwClFOFmr2
         qnnFF5dMWMCG1DtvMBpPWLrVTisPWSW6h7/jxvpI=
Date:   Thu, 6 Jan 2022 14:43:21 -0500
From:   'Bruce Fields' <bfields@fieldses.org>
To:     Frank Filz <ffilzlnx@mindspring.com>
Cc:     'Chuck Lever III' <chuck.lever@oracle.com>,
        'Linux NFS Mailing List' <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix zero-length NFSv3 WRITEs
Message-ID: <20220106194321.GF7969@fieldses.org>
References: <164010014140.6448.18108343631467243001.stgit@klimt.1015granger.net>
 <20220103210013.GK21514@fieldses.org>
 <BAA88CD4-C692-4AEE-9A8D-F62F8CBEA2F5@oracle.com>
 <20220104030708.GC27642@fieldses.org>
 <058a01d8032b$2992e740$7cb8b5c0$@mindspring.com>
 <20220106183431.GE7969@fieldses.org>
 <059201d80334$e219e440$a64dacc0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <059201d80334$e219e440$a64dacc0$@mindspring.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 06, 2022 at 11:37:46AM -0800, Frank Filz wrote:
> > On Thu, Jan 06, 2022 at 10:28:10AM -0800, Frank Filz wrote:
> > > > On Tue, Jan 04, 2022 at 01:12:40AM +0000, Chuck Lever III wrote:
> > > > > > but still may be worth posting
> > > > > > somewhere and making it the start of a collection of
> > > > > > protocol-level
> > > > > > v3 tests.
> > > > >
> > > > > ... I question whether it's worth posting anything until there is
> > > > > a framework for collecting and maintaining such things. I do agree
> > > > > that the community should be working up a set of NFSv3 specific
> > > > > tests like this. I like Frank's idea of making them a part of pynfs,
> fwiw.
> > > >
> > > > Somebody did actually do a v3 pynfs that I never got around to
> > > > merging,
> > > it'd be
> > > > worth revisiting:
> > > >
> > > > 	https://github.com/sthaber/pynfs
> > >
> > > I'm working on that... It requires significant effort, but I have made
> > > some
> > > progress:
> > >
> > > https://github.com/ffilz/pynfs/commit/d3a1610815117cb6bdf6567e575baedb
> > > 0d8809
> > > 5e
> > >
> > > I need to get back to it, but it's lower on my priority list.
> > 
> > Oh, good to know, thanks.
> 
> Are you going to continue to maintain pynfs? Your repo is the one we use as
> our "gold standard".

For now, yeah.

--b.
