Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3639F32B750
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Mar 2021 12:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbhCCK5h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 05:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835983AbhCBWMq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 17:12:46 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE7C06178A
        for <linux-nfs@vger.kernel.org>; Tue,  2 Mar 2021 14:11:31 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 54D661C81; Tue,  2 Mar 2021 17:11:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 54D661C81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614723090;
        bh=hBcskT1LkvlWxCE2U9pifU2ayZeLoxkveE6/dSa0o3c=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=o7ANXYBa+AJ/v3kZxc/hA3ZTW4bdjzuQNpWFvZI0tLvhBXt+NIwONnHs/QKiMyN4b
         rTsbP247OBDf8Zf05P0yfD+dsgRAdN4s7TY0lvVWKDs73of8ERvpQf7eFQ0JyvA/q3
         KniZvVowDHiHEWTab2UBZoXjdBnJN6sR5xmAemLs=
Date:   Tue, 2 Mar 2021 17:11:30 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 19/42] SUNRPC: Fix xdr_get_next_encode_buffer() page
 boundary handling
Message-ID: <20210302221130.GG3400@fieldses.org>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
 <161461183307.8508.17196295994390119297.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161461183307.8508.17196295994390119297.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 01, 2021 at 10:17:13AM -0500, Chuck Lever wrote:
> The description of commit 2825a7f90753 ("nfsd4: allow encoding
> across page boundaries") states:
> 
> > Also we can't handle a new operation starting close to the end of
> > a page.
> 
> But does not detail why this is the case.

That wasn't every helpful of me, sorry.

> Subtracting the scratch buffer's "shift" value from the remaining
> stream space seems to make reserving space close to the end of the
> buf->pages array reliable.

So, why is that?

Thinking this through:

When somebody asks for a buffer that would straddle a page boundary,
with frag1bytes at the end of this page and frag2bytes at the start of
the next page, we instead give them a buffer starting at start of the
next page.  That gives them a nice contiguous buffer to write into.
When they're done using it, we fix things up by copying what they wrote
back to where it should be.

That means we're temporarily wasting frag1bytes of space.  So, I don't
know, maybe that's the logic behind subtracing frag1bytes from
space_left.

It means you may end up with xdr->end frag1bytes short of the next page.
I'm not sure that's right.

--b.


> 
> This change is needed to make entry encoding with struct xdr_stream,
> introduced in a subsequent patch, work correctly when it approaches
> the end of the dirlist buffer.
> 
> Fixes: 2825a7f90753 ("nfsd4: allow encoding across page boundaries")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xdr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 3964ff74ee51..043b67229792 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -978,7 +978,7 @@ static __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
>  	 * shifted this one back:
>  	 */
>  	xdr->p = (void *)p + frag2bytes;
> -	space_left = xdr->buf->buflen - xdr->buf->len;
> +	space_left = xdr->buf->buflen - xdr->buf->len - frag1bytes;
>  	xdr->end = (void *)p + min_t(int, space_left, PAGE_SIZE);
>  	xdr->buf->page_len += frag2bytes;
>  	xdr->buf->len += nbytes;
> 
