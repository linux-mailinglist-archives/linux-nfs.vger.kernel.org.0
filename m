Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187D42979D1
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Oct 2020 02:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755237AbgJXAEh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Oct 2020 20:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755236AbgJXAEh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Oct 2020 20:04:37 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C93C0613CE;
        Fri, 23 Oct 2020 17:04:37 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C9971648C; Fri, 23 Oct 2020 20:04:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C9971648C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1603497874;
        bh=hJkl7AU0OJW4JRWttT1ahPP2tUSYaSDr5Ua7PvoS8lM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bftkeSIEVAQ0I3Luu98cIalWlb9RoILTw3hNtfauqpkx8CmG0uORKN+k5prUbJiMi
         6KZREynCZ0h5APxDTFDbK5mN5DsLrw4VqOUzF/ZIc09JHQ0SvxFD4WLGPbMffUcWPb
         GWcSz0pPT9CgL/0vdBvqSoydCwXnrhF1m4uvYpEc=
Date:   Fri, 23 Oct 2020 20:04:34 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Roberto Bergantinos Corpas <rbergant@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: raise kernel RPC channel buffer size
Message-ID: <20201024000434.GA31481@fieldses.org>
References: <20201019093356.7395-1-rbergant@redhat.com>
 <20201019132000.GA32403@fieldses.org>
 <alpine.DEB.2.21.2010231141460.29805@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2010231141460.29805@ramsan.of.borg>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 23, 2020 at 11:44:38AM +0200, Geert Uytterhoeven wrote:
> 	Hi Bruce, Roberto,
> 
> On Mon, 19 Oct 2020, J. Bruce Fields wrote:
> >On Mon, Oct 19, 2020 at 11:33:56AM +0200, Roberto Bergantinos Corpas wrote:
> >>Its possible that using AUTH_SYS and mountd manage-gids option a
> >>user may hit the 8k RPC channel buffer limit. This have been observed
> >>on field, causing unanswered RPCs on clients after mountd fails to
> >>write on channel :
> >>
> >>rpc.mountd[11231]: auth_unix_gid: error writing reply
> >>
> >>Userland nfs-utils uses a buffer size of 32k (RPC_CHAN_BUF_SIZE), so
> >>lets match those two.
> >
> >Thanks, applying.
> >
> >That should allow about 4000 group memberships.  If that doesn't do it
> >then maybe it's time to rethink....
> >
> >--b.
> >
> >>
> >>Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> >>---
> >> net/sunrpc/cache.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> >>index baef5ee43dbb..08df4c599ab3 100644
> >>--- a/net/sunrpc/cache.c
> >>+++ b/net/sunrpc/cache.c
> >>@@ -908,7 +908,7 @@ static ssize_t cache_do_downcall(char *kaddr, const char __user *buf,
> >> static ssize_t cache_slow_downcall(const char __user *buf,
> >> 				   size_t count, struct cache_detail *cd)
> >> {
> >>-	static char write_buf[8192]; /* protected by queue_io_mutex */
> >>+	static char write_buf[32768]; /* protected by queue_io_mutex */
> >> 	ssize_t ret = -EINVAL;
> >>
> >> 	if (count >= sizeof(write_buf))
> 
> This is now commit 27a1e8a0f79e643d ("sunrpc: raise kernel RPC channel
> buffer size") upstream, and increases kernel size by 24 KiB, even if
> RPC is not used.
> 
> Can this buffer allocated dynamically instead? This code path seems to
> be a slow path anyway. If it's critical, perhaps this buffer can be
> allocated on first use?

Sure.  Actually it is using an allocated buffer typically, see
cache_downcall().

Looking back at the history....  That was added by Trond in 2009
(da77005f0d64 "SUNRPC: Remove the global temporary write buffer in
net/sunrpc/cache.c").  

Before that there's a pre-git change from 2004 which replaced a simple
kmalloc(PAGE_SIZE).

So I guess the point was to be careful about higher-order allocations,
but probably it was overkill.

How about making it a kvmalloc?

--b.
