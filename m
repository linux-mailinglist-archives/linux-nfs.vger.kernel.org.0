Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3733F8FEA
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 23:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbhHZUwk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 16:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhHZUwj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 16:52:39 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABDDC061757
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 13:51:52 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B641461D7; Thu, 26 Aug 2021 16:51:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B641461D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1630011106;
        bh=dD17tvDiTgovKf+hr86IWYFEsUP3mvR55y14z6MDK1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pk2uZ/+6E7cDuyhFfNNxXX0KMDFtConODJZdfab8e9icEclNByIQ2Ty8lHzU8bD6O
         YisuUiLxspkjYGlcclVirBl0Y8iid3pDBhnEELQwIjY3Fs5+ogFveq8uDQPvQWStRO
         uGCRdBaFARI8yMt4ryltYvLyj3EEHS40KraaptW8=
Date:   Thu, 26 Aug 2021 16:51:46 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Trond Myklebust <Trond.Myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: Avoid a KASAN slab-out-of-bounds bug in
 xdr_set_page_base()
Message-ID: <20210826205146.GD10730@fieldses.org>
References: <20210609210729.254578-1-Anna.Schumaker@Netapp.com>
 <20210614231440.GD16500@fieldses.org>
 <20210812203248.GA907@fieldses.org>
 <CAFX2Jf=b1JwPRaC35rKbX5bD821h1dsEj6opYW9eZET171Zd6A@mail.gmail.com>
 <20210826204221.GC10730@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826204221.GC10730@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 26, 2021 at 04:42:21PM -0400, J. Bruce Fields wrote:
> On Thu, Aug 26, 2021 at 03:44:32PM -0400, Anna Schumaker wrote:
> > On Thu, Aug 12, 2021 at 4:32 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > On Mon, Jun 14, 2021 at 07:14:40PM -0400, bfields wrote:
> > > > On Wed, Jun 09, 2021 at 05:07:29PM -0400, schumaker.anna@gmail.com wrote:
> > > > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > > >
> > > > > This seems to happen fairly easily during READ_PLUS testing on NFS v4.2.
> > > >
> > > > Yep, I hit a KASAN warning here every time, and this fixes it,
> > > > thanks.--b.
> > >
> > > By the way, config NFS_V4_2_READ_PLUS still says:
> > >
> > >         This is intended for developers only. The READ_PLUS operation
> > >         has been shown to have issues under specific conditions and
> > >         should not be used in production.
> > >
> > > But this warning was the only thing I was seeing.  Is there another
> > > known issue remaining?
> > 
> > I think it was an issue around using lseek to generate the reply. The
> > file contents could change between each call, leading to inconsistent
> > results (and a new failing xfstest that previously passed)
> 
> OK, thanks, I see now that you mentioned in 21e31401fc45 "NFS: Disable
> READ_PLUS by default" that there were generic/091 and generic/263
> failures.
> 
> Looks like they're both testing concurrent direct and buffered IO.  I
> don't know what we try to guarantee in that case.

But I'd assumed generic/263 just wasn't supported on nfs anyway.--b.

generic/263 81s ... [failed, exit status 1]- output mismatch (see /root/xfstests-dev/results//generic/263.out.bad)
    --- tests/generic/263.out	2019-12-20 17:34:10.493343575 -0500
    +++ /root/xfstests-dev/results//generic/263.out.bad	2021-08-26 16:43:40.751891500 -0400
    @@ -1,3 +1,262 @@
     QA output created by 263
     fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
     fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
    +Seed set to 1
    +main: filesystem does not support fallocate mode FALLOC_FL_KEEP_SIZE, disabling!
    +main: filesystem does not support fallocate mode FALLOC_FL_ZERO_RANGE, disabling!
    +main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RANGE, disabling!
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/263.out /root/xfstests-dev/results//generic/263.out.bad'  to see the entire diff)
Ran: generic/263
Failures: generic/263
Failed 1 of 1 tests

