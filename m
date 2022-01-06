Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76347486A02
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 19:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242739AbiAFSed (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 13:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbiAFSec (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jan 2022 13:34:32 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA10C061245
        for <linux-nfs@vger.kernel.org>; Thu,  6 Jan 2022 10:34:32 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6A2AF72FB; Thu,  6 Jan 2022 13:34:31 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6A2AF72FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641494071;
        bh=sTsRF2vv5a8TXJMgRBZ7WXDm3BZxtd9ww7BA43xB4mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DHlxd6KM78miY6La7xaP0H7E+RyyaUqeGA7qjTo98mw4YRqY2kVt0zF8wjGCVBt7z
         StB2tBCcxGZAObwe7HV4OF3b2WcybtuSbLAeZcLdeQApQUzVsmM6RAuS7jmQi1P0Uw
         KEjGEhvZf/0M4t2+6sbjdYxHLB0oYtRN3QAfwt0g=
Date:   Thu, 6 Jan 2022 13:34:31 -0500
From:   'Bruce Fields' <bfields@fieldses.org>
To:     Frank Filz <ffilzlnx@mindspring.com>
Cc:     'Chuck Lever III' <chuck.lever@oracle.com>,
        'Linux NFS Mailing List' <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix zero-length NFSv3 WRITEs
Message-ID: <20220106183431.GE7969@fieldses.org>
References: <164010014140.6448.18108343631467243001.stgit@klimt.1015granger.net>
 <20220103210013.GK21514@fieldses.org>
 <BAA88CD4-C692-4AEE-9A8D-F62F8CBEA2F5@oracle.com>
 <20220104030708.GC27642@fieldses.org>
 <058a01d8032b$2992e740$7cb8b5c0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <058a01d8032b$2992e740$7cb8b5c0$@mindspring.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 06, 2022 at 10:28:10AM -0800, Frank Filz wrote:
> > On Tue, Jan 04, 2022 at 01:12:40AM +0000, Chuck Lever III wrote:
> > > > but still may be worth posting
> > > > somewhere and making it the start of a collection of protocol-level
> > > > v3 tests.
> > >
> > > ... I question whether it's worth posting anything until there is a
> > > framework for collecting and maintaining such things. I do agree that
> > > the community should be working up a set of NFSv3 specific tests like
> > > this. I like Frank's idea of making them a part of pynfs, fwiw.
> > 
> > Somebody did actually do a v3 pynfs that I never got around to merging,
> it'd be
> > worth revisiting:
> > 
> > 	https://github.com/sthaber/pynfs
> 
> I'm working on that... It requires significant effort, but I have made some
> progress:
> 
> https://github.com/ffilz/pynfs/commit/d3a1610815117cb6bdf6567e575baedb0d8809
> 5e
> 
> I need to get back to it, but it's lower on my priority list.

Oh, good to know, thanks.

--b.
