Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC50C43FE6A
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 16:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhJ2O3I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 10:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhJ2O3I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Oct 2021 10:29:08 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC4BC061570
        for <linux-nfs@vger.kernel.org>; Fri, 29 Oct 2021 07:26:39 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0A9466EC3; Fri, 29 Oct 2021 10:26:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0A9466EC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1635517599;
        bh=7IS5IiHh+KLxByOcdBTqT7IqkY0CK5tRvK+LRZqyqo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUxzS85+9U/olSNX3jLwPCmHf+PyrQ8KxabtBNaFlCZshU5KaQe5HApICbjFQMokl
         T+tWqfxN0GaxmI04UClyXwC3tDDipKDc+nuphSYyJFgku0JPVYMlD6HA+v5D/gUD/b
         f0orlGNQKFvvGXIYKOf6NVo1VQ4/72izVTb8JmV0=
Date:   Fri, 29 Oct 2021 10:26:39 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Message-ID: <20211029142639.GC19967@fieldses.org>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029134534.GA19967@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 29, 2021 at 09:45:34AM -0400, bfields wrote:
> On Thu, Oct 28, 2021 at 10:48:50AM -0400, Steve Dickson wrote:
> > This kernel patch and an upcoming nfs-utils patch
> > adds a new export option 's2sc' which will allow
> > inter server to server copies.
> 
> They're already allowed by a module option.  Why is an export option
> better?  And why should it be set on the destination server and not the
> source server?
> 
> Really, first I think we should try to identify what the problem is that
> we're trying to solve.

I guess we're thinking: we expect server-to-server copy to be a win in
some cases, but not others.

What would those cases look like?

Say you've got a client "C" and two servers, "S" and "T", and C is
copying a file from S to T.

I'd expect bandwidth of the traditional read-write-loop copy to be the
minimum of the network bandwidth between S and C, and the network
bandwidth between C and T.  Are there common cases were the S-to-T
bandwidth would be significantly less than both of those?

My guess would've been that that's relatively unusual.  So as a first
pass, just turning on COPY unconditionally doesn't seem so bad.

I know you're thinking about in cases where S and T are connected by a
high-performance network not necessarily available to C.

In that case, we know we want to use server-to-server copy for copies
between S and T.  But is it necessarily a problem to also use it for
copies between some other server and T?  Also, does knowing the export
containing the destination file on T really tell you whether or not the
copy will be coming from S and not from some other server?

I'd think the bigger issue in that case is figuring out how to configure
S so that it returns the right IP address in the cnr_source_server field
of the COPY_NOTIFY reply.  Currently we return address that the client
sent the COPY_NOTIFY, and I don't know if that's correct for that case.

--b.
