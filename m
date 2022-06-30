Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BDC5624E8
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jun 2022 23:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiF3VM6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jun 2022 17:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbiF3VM4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jun 2022 17:12:56 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A634220C6
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jun 2022 14:12:55 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7A74A70B8; Thu, 30 Jun 2022 17:12:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7A74A70B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1656623574;
        bh=xRnLLlKNVuBfVx2ieGrRQaN4c41JZ9Se/aqIRLstukA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpBFmczljIDKC8DkHX9e0dNS0X561vcSsZFD/8uCOm6H978ltPJO7xbizG0HpeCHY
         omlsE7HbBcbcksBqClj99UkD8TzN0DNbZzlL556vKk8WFosC1un9N81i22KJeEUFn+
         DziM93C3A44XGH2kaT45kMfLg15270BOCN6mbCLA=
Date:   Thu, 30 Jun 2022 17:12:54 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, anna.schumaker@netapp.com,
        zlang@redhat.com
Subject: Re: [PATCH v1] SUNRPC: Fix READ_PLUS crasher
Message-ID: <20220630211254.GD22291@fieldses.org>
References: <165660978413.2453.15153844664543877314.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165660978413.2453.15153844664543877314.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Looks like the crash I saw no longer reproduces after that, fwiw.

--b.

On Thu, Jun 30, 2022 at 01:24:20PM -0400, Chuck Lever wrote:
> Looks like there are still cases when "space_left - frag1bytes" can
> legitimately exceed PAGE_SIZE. Ensure that xdr->end always remains
> within the current encode buffer.
> 
> Reported-by: Bruce Fields <bfields@fieldses.org>
> Reported-by: Zorro Lang <zlang@redhat.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216151
> Fixes: 6c254bf3b637 ("SUNRPC: Fix the calculation of xdr->end in xdr_get_next_encode_buffer()")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xdr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi-
> 
> I had a few minutes yesterday afternoon to look into this one. The
> following one-liner seems to address the issue and passes my smoke
> tests with NFSv4.1/TCP and NFSv3/RDMA. Any thoughts?
> 
> 
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index f87a2d8f23a7..916659be2774 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -987,7 +987,7 @@ static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
>  	if (space_left - nbytes >= PAGE_SIZE)
>  		xdr->end = p + PAGE_SIZE;
>  	else
> -		xdr->end = p + space_left - frag1bytes;
> +		xdr->end = p + min_t(int, space_left - frag1bytes, PAGE_SIZE);
>  
>  	xdr->buf->page_len += frag2bytes;
>  	xdr->buf->len += nbytes;
> 
