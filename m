Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE731486A8F
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 20:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243379AbiAFTht (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 14:37:49 -0500
Received: from mta-101b.oxsus-vadesecure.net ([51.81.61.61]:41763 "EHLO
        nmtao101.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243378AbiAFTht (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jan 2022 14:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; bh=bGS9Uj1iA3T/k8Q+aXLvy3u/31nZ+O051gfmqu
 CTXY8=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1641497867;
 x=1642102667; b=dwFosgxSV1PvhHR45iBl+QWnbdLDVT0f1r/BgR7n+uqrN5YvbmR+NpL
 Pbtmc2RfSxR3+xKK48IG3aqKeQDciFiA0WQERrpQUPjqoijgYO00LsmZA3arduK9VgEoAwP
 YLPtd0ScGRrcDTo9w3YJ6IC69crKNQJcYftJJ097UJeW5cSawTiwf3kcJtdb/kSt4zDb+1g
 ng95vwcUpfwxaYRS3T57pJp4ucky8Pmvozd27tYA+GUQE4yhPcKu5U04bpNzgc6VqYDHTIS
 CuIe2SV+Xfe/UNBzfdsl4kDOHf476ko/x1zx9YqA6u14UWOOAReGWiEwFdv1BrCAgbQ+SSk
 eRw==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus1nmtao01p with ngmta
 id 190e8691-16c7c59cd6d212e6; Thu, 06 Jan 2022 19:37:46 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Bruce Fields'" <bfields@fieldses.org>
Cc:     "'Chuck Lever III'" <chuck.lever@oracle.com>,
        "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>
References: <164010014140.6448.18108343631467243001.stgit@klimt.1015granger.net> <20220103210013.GK21514@fieldses.org> <BAA88CD4-C692-4AEE-9A8D-F62F8CBEA2F5@oracle.com> <20220104030708.GC27642@fieldses.org> <058a01d8032b$2992e740$7cb8b5c0$@mindspring.com> <20220106183431.GE7969@fieldses.org>
In-Reply-To: <20220106183431.GE7969@fieldses.org>
Subject: RE: [PATCH RFC] NFSD: Fix zero-length NFSv3 WRITEs
Date:   Thu, 6 Jan 2022 11:37:46 -0800
Message-ID: <059201d80334$e219e440$a64dacc0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQKWYapNrF8jKbD/l/9lE4SZwMJ+uAKapAyhAkiWL54BpUJMPAGX+R7FAqeDKmSqg2ZLYA==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Thu, Jan 06, 2022 at 10:28:10AM -0800, Frank Filz wrote:
> > > On Tue, Jan 04, 2022 at 01:12:40AM +0000, Chuck Lever III wrote:
> > > > > but still may be worth posting
> > > > > somewhere and making it the start of a collection of
> > > > > protocol-level
> > > > > v3 tests.
> > > >
> > > > ... I question whether it's worth posting anything until there is
> > > > a framework for collecting and maintaining such things. I do agree
> > > > that the community should be working up a set of NFSv3 specific
> > > > tests like this. I like Frank's idea of making them a part of pynfs,
fwiw.
> > >
> > > Somebody did actually do a v3 pynfs that I never got around to
> > > merging,
> > it'd be
> > > worth revisiting:
> > >
> > > 	https://github.com/sthaber/pynfs
> >
> > I'm working on that... It requires significant effort, but I have made
> > some
> > progress:
> >
> > https://github.com/ffilz/pynfs/commit/d3a1610815117cb6bdf6567e575baedb
> > 0d8809
> > 5e
> >
> > I need to get back to it, but it's lower on my priority list.
> 
> Oh, good to know, thanks.

Are you going to continue to maintain pynfs? Your repo is the one we use as
our "gold standard".

Frank

