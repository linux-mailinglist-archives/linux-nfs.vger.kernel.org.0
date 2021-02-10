Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CDD316181
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Feb 2021 09:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBJIx2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Feb 2021 03:53:28 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:37291 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229452AbhBJIwZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Feb 2021 03:52:25 -0500
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Feb 2021 03:52:24 EST
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 5BCA11C3429
        for <linux-nfs@vger.kernel.org>; Wed, 10 Feb 2021 08:42:00 +0000 (GMT)
Received: (qmail 21703 invoked from network); 10 Feb 2021 08:42:00 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Feb 2021 08:42:00 -0000
Date:   Wed, 10 Feb 2021 08:41:55 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: alloc_pages_bulk()
Message-ID: <20210210084155.GA3697@techsingularity.net>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
 <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
 <20210209113108.1ca16cfa@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210209113108.1ca16cfa@carbon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 09, 2021 at 11:31:08AM +0100, Jesper Dangaard Brouer wrote:
> > > Neil Brown pointed me to this old thread:
> > > 
> > > https://lore.kernel.org/lkml/20170109163518.6001-1-mgorman@techsingularity.net/
> > > 
> > > We see that many of the prerequisites are in v5.11-rc, but
> > > alloc_page_bulk() is not. I tried forward-porting 4/4 in that
> > > series, but enough internal APIs have changed since 2017 that
> > > the patch does not come close to applying and compiling.
> 
> I forgot that this was never merged.  It is sad as Mel showed huge
> improvement with his work.
> 
> > > I'm wondering:
> > > 
> > > a) is there a newer version of that work?
> > > 
> 
> Mel, why was this work never merged upstream?
> 

Lack of realistic consumers to drive it forward, finalise the API and
confirm it was working as expected. It eventually died as a result. If it
was reintroduced, it would need to be forward ported and then implement
at least one user on top.

-- 
Mel Gorman
SUSE Labs
