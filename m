Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1AB328C95
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 19:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbhCASyY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 13:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbhCASvS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 13:51:18 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EE7C061756
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 10:50:37 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4FDCE35DC; Mon,  1 Mar 2021 13:50:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4FDCE35DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614624637;
        bh=wOJJT/sl35x8OpqOSh0EQgJMKhFjWDyyGlhLk+IMYtI=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=zuZt6+gd4YkPUm4h5TGzxgN5UtcCYd2hVtsIwVVFqTzF38PNrecj9T0PLXNGWf/4c
         G3rc09D0PIjJ0l6JAk0mu6zLA+X2Cke+a3Tz+NNi6mHFlAYgaGZv6uo9zis51YMLjk
         KzNC0PMbU+2HTbd+Anqv/CfOfLQdk56iDuJEStDs=
Date:   Mon, 1 Mar 2021 13:50:37 -0500
To:     NeilBrown <neilb@suse.de>
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
Message-ID: <20210301185037.GB14881@fieldses.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161456493684.22801.323431390819102360.stgit@noble>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've gotten requests for similar functionality, and intended to
implement it using directory notifications on /proc/fs/nfsd/clients.

But this is another way to do it that I hadn't thought of.  That's
interesting.  I haven't thought about the relative advantages or
disadvantages.

--b.

On Mon, Mar 01, 2021 at 01:17:15PM +1100, NeilBrown wrote:
> V1 of this series didn't update the usage() message for mountd,
> and omited the required ':' after the 'T' sort-option.  This 
> series fixes those two omissions.
> 
> Original series comment:
> 
> When NFSv3 is used mountd provides logs of successful and failed mount
> attempts which can be used for auditing.
> When NFSv4 is used there are no such logs as NFSv4 does not have a
> distinct "mount" request.
> 
> However mountd still knows about which filesysytems are being accessed
> from which clients, and can actually provide more reliable logs than it
> currently does, though they must be more verbose - with periodic "is
> being accessed" message replacing a single "was mounted" message.
> 
> This series adds support for that logging, and adds some related
> improvements to make the logs as useful as possible.
> 
> NeilBrown
> 
> ---
> 
> NeilBrown (5):
>       mountd: reject unknown client IP when !use_ipaddr.
>       mountd: Don't proactively add export info when fh info is requested.
>       mountd: add logging for authentication results for accesses.
>       mountd: add --cache-use-ipaddr option to force use_ipaddr
>       mountd: make default ttl settable by option
> 
> 
>  support/export/auth.c      |  4 +++
>  support/export/cache.c     | 32 +++++++++++------
>  support/export/v4root.c    |  3 +-
>  support/include/exportfs.h |  3 +-
>  support/nfs/exports.c      |  4 ++-
>  utils/mountd/mountd.c      | 30 +++++++++++++++-
>  utils/mountd/mountd.man    | 70 ++++++++++++++++++++++++++++++++++++++
>  7 files changed, 131 insertions(+), 15 deletions(-)
> 
> --
> Signature
