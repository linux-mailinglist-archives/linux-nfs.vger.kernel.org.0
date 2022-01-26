Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3778C49C17D
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 03:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiAZC5Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 21:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbiAZC5X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 21:57:23 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8B1C06161C
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 18:57:23 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 78FACAA2; Tue, 25 Jan 2022 21:57:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 78FACAA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643165842;
        bh=yQxykpIcn5lXlPsOCORKn9GHNSVKsEdV/Eh4gIJFXhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eO0C1pkVUuE0dkE+jFHInMXf9T2792sRj843RNm/0yH1f/sqt1vrHEAD6wI3BtAnS
         gT4CqXnu3UemV8PzvGCDfdDoanPBAa9xg+jv7R9Uj7YqMC3PtLmk4Lh8WwNtJUdClm
         6R2LlLBb2FqOUy4mU5w46L3VytYDfZ0GmhwtFX30=
Date:   Tue, 25 Jan 2022 21:57:22 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Patrick Goetz <pgoetz@math.utexas.edu>,
        Daire Byrne <daire@dneg.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: parallel file create rates (+high latency)
Message-ID: <20220126025722.GD17638@fieldses.org>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org>
 <adce2b72-ed5c-3056-313c-caea9bad4e15@math.utexas.edu>
 <20220125212055.GB17638@fieldses.org>
 <164315533676.5493.13243313269022942124@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164315533676.5493.13243313269022942124@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 26, 2022 at 11:02:16AM +1100, NeilBrown wrote:
> On Wed, 26 Jan 2022, J. Bruce Fields wrote:
> > On Tue, Jan 25, 2022 at 03:15:42PM -0600, Patrick Goetz wrote:
> > > So the directory is locked while the inode is created, or something
> > > like this, which makes sense.
> > 
> > It accomplishes a number of things, details in
> > https://www.kernel.org/doc/html/latest/filesystems/directory-locking.html
> 
> Just in case anyone is interested, I wrote this a while back:
> 
> http://lists.lustre.org/pipermail/lustre-devel-lustre.org/2018-November/008177.html
> 
> it includes a patch to allow parallel creates/deletes over NFS (and any
> other filesystem which adds support).
> I doubt it still applies, but it wouldn't be hard to make it work if
> anyone was willing to make a strong case that we would benefit from
> this.

Neato.

Removing the need to hold an exclusive lock on the directory across
server round trips seems compelling to me....

I also wonder: why couldn't you fire off the RPC without any locks, then
wait till you get a reply to take locks and update your local cache?

OK, for one thing, calls and replies and server processing could all get
reordered.  We'd need to know what order the server processed operations
in, so we could process replies in the same order.

--b.
