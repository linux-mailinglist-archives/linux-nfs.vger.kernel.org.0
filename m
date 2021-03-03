Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A5932C69E
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbhCDA3k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhCCQxs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 11:53:48 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D96C061756
        for <linux-nfs@vger.kernel.org>; Wed,  3 Mar 2021 08:52:53 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id EB2EF2824; Wed,  3 Mar 2021 11:52:51 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EB2EF2824
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614790371;
        bh=sebNE8oW8U1+wNON6aw++Y35r2Lo2vmfwv/ETOUEoZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vkiANGfq6kn9x9PEqq1DkFvPhTQYI+dlf5npAeVWA1raa+w+QgcTQehiYGtqzw+8M
         7IlFATvFgRVHsKIVNiyKDsSegLI5h0u0RXIlbvFVNl8MzrQwiVnSTr6oadoe6sIvof
         g0kPA5ruotwAxJLmbeIK4tsfKB7PwvOj6ReAQCA4=
Date:   Wed, 3 Mar 2021 11:52:51 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 19/42] SUNRPC: Fix xdr_get_next_encode_buffer() page
 boundary handling
Message-ID: <20210303165251.GB1282@fieldses.org>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
 <161461183307.8508.17196295994390119297.stgit@klimt.1015granger.net>
 <20210302221130.GG3400@fieldses.org>
 <592A34CB-C178-4272-8905-F3BA95BCE299@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <592A34CB-C178-4272-8905-F3BA95BCE299@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 03, 2021 at 03:43:28PM +0000, Chuck Lever wrote:
> Hi Bruce-
> 
> Thanks for your careful review of this series!
> 
> 
> > On Mar 2, 2021, at 5:11 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Mon, Mar 01, 2021 at 10:17:13AM -0500, Chuck Lever wrote:
> >> The description of commit 2825a7f90753 ("nfsd4: allow encoding
> >> across page boundaries") states:
> >> 
> >>> Also we can't handle a new operation starting close to the end of
> >>> a page.
> >> 
> >> But does not detail why this is the case.
> > 
> > That wasn't every helpful of me, sorry.
> > 
> >> Subtracting the scratch buffer's "shift" value from the remaining
> >> stream space seems to make reserving space close to the end of the
> >> buf->pages array reliable.
> > 
> > So, why is that?
> > 
> > Thinking this through:
> > 
> > When somebody asks for a buffer that would straddle a page boundary,
> > with frag1bytes at the end of this page and frag2bytes at the start of
> > the next page, we instead give them a buffer starting at start of the
> > next page.  That gives them a nice contiguous buffer to write into.
> > When they're done using it, we fix things up by copying what they wrote
> > back to where it should be.
> > 
> > That means we're temporarily wasting frag1bytes of space.  So, I don't
> > know, maybe that's the logic behind subtracing frag1bytes from
> > space_left.
> > 
> > It means you may end up with xdr->end frag1bytes short of the next page.

Wait, let me try that again:

	p = page_address(*xdr->page_ptr);
	xdr->p = (void *)p + frag2bytes;
	space_left = xdr->buf->buflen - xdr->buf->len - frag1bytes;
        xdr->end = (void *)p + min_t(int, space_left, PAGE_SIZE);

If you've still got a lot of buffer space left, then that'll put
xdr->end frag2bytes past the end of a page, won't it?

> > I'm not sure that's right.
> 
> Why would that not be OK? the next call to xdr_get_next_encode_buffer()
> should do the right thing and bounce the new encoded data from the
> next page into this one again.
> 
> So far I have not encountered any problems. Would such a problem show
> up with some frequency under normal use, or would it be especially
> subtle?

I mainly just want to make sure we've got a coherent idea what this code
is doing....

For testing: large replies that aren't just read data are readdir and
getacl.  So reading large directories with lots of variably-named files
might be good. Also pynfs could easily send a single compound with lots
of variable-sized reads, that might be interesting.

Constructing a compound that will result in xdr_reserve_space calls that
exactly hit the various corner cases may be hard.  But maybe if we just
send a bunch of compounds that vary over some range we can still
guarantee hitting those cases.

--b.
