Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A6649BE15
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 22:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiAYV7o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 16:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiAYV7n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 16:59:43 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF35C06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 13:59:43 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 995EA7128; Tue, 25 Jan 2022 16:59:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 995EA7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643147982;
        bh=1I9TpqAeBGz0C0Bmwk7PtPTTwdOHWUyjjOzcBx/pkcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdxI2zqp1hF8XD4P1kpLRd6Kvk1bXGWl4Xnq/h10uoy3q5fQEJyWe76uc17eOjTMl
         jlf+JQ2DLy8j9Bx1ZSbH9s4nYnWMlL8Taa2pShntX1BJLjJC9Je/mgvcAzwlDyPDW+
         T6bDmSYw7MBSx83L+OiZaxRu+vQSFu+j7gx6Mr9U=
Date:   Tue, 25 Jan 2022 16:59:42 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Daire Byrne <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: parallel file create rates (+high latency)
Message-ID: <20220125215942.GC17638@fieldses.org>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org>
 <CAPt2mGOCn5OaeZm24+zh92qRcWTF8h-H2WXqScz9RMfo4r_-Qw@mail.gmail.com>
 <20220124205045.GB4975@fieldses.org>
 <CAPt2mGPTGgXztawDJfAKsiYqnm6P_mn1rtquSDKjpnSgvJH1YA@mail.gmail.com>
 <20220125135959.GA15537@fieldses.org>
 <F7C721F7-D906-426F-814F-4D3F34AD6FB1@oracle.com>
 <42867c2c-1ab3-9bb6-0e5a-57d13d667bc6@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42867c2c-1ab3-9bb6-0e5a-57d13d667bc6@math.utexas.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 25, 2022 at 03:50:05PM -0600, Patrick Goetz wrote:
> On 1/25/22 09:30, Chuck Lever III wrote:
> >>On Jan 25, 2022, at 8:59 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> >>On Tue, Jan 25, 2022 at 12:52:46PM +0000, Daire Byrne wrote:
> >>>Yea, it does seem like the server is the ultimate arbitrar and the
> >>>fact that multiple clients can achieve much higher rates of
> >>>parallelism does suggest that the VFS locking per client is somewhat
> >>>redundant and limiting (in this super niche case).
> >>
> >>It doesn't seem *so* weird to have a server with fast storage a long
> >>round-trip time away, in which case the client-side operation could take
> >>several orders of magnitude longer than the server.
> >>
> >>Though even if the client locking wasn't a factor, you might still have
> >>to do some work to take advantage of that.  (E.g. if your workload is
> >>just a single "untar"--it still waits for one create before doing the
> >>next one).
> >
> >Note that this is also an issue for data center area filesystems, where
> >back-end replication of metadata updates makes creates and deletes as
> >slow as if they were being done on storage hundreds of miles away.
> >
> >The solution of choice appears to be to replace tar/rsync and such
> >tools with versions that are smarter about parallelizing file creation
> >and deletion.
> 
> Are these tools available to mere mortals?  If so, what are they
> called.  This is a problem I'm currently dealing with; trying to
> back up hundreds of terabytes of image data.

How many files, though?

Writes of file data *should* be limited mainly just be your network and
disk bandwidth.

Creation of files is limited by network and disk latency, is more
complicated, and is where multiple processes are more likely to help.

--b.
