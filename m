Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FA65634F8
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Jul 2022 16:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiGAORz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Jul 2022 10:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGAORy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Jul 2022 10:17:54 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C1939170
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 07:17:53 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id EB3DB608A; Fri,  1 Jul 2022 10:17:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EB3DB608A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1656685072;
        bh=B9MZnGRTwYde4QoxzDBsp5SPVzYCVCm/rGuCLK4COtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZkavusZuG0enUMdo/1koe/Ca094GzlxkGyq5I7yfyb5OX/+w15gql9qTZ+zHSVjE/
         lwxsShmUJwsucGX0EniHASZabaTGIe0RfXScPVuKgDN5DCwabhsEZvnShEEkieyqF5
         8S3yZRFqEQXxjic6DRvPr0O7ZltpZpgEFatdc+ag=
Date:   Fri, 1 Jul 2022 10:17:52 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, anna.schumaker@netapp.com,
        zlang@redhat.com
Subject: Re: [PATCH v2] SUNRPC: Fix READ_PLUS crasher
Message-ID: <20220701141752.GA13890@fieldses.org>
References: <165662209842.1459.4593520026847863736.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165662209842.1459.4593520026847863736.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This also gets through my tests without a crash.--b.

On Thu, Jun 30, 2022 at 04:48:18PM -0400, Chuck Lever wrote:
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
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index f87a2d8f23a7..5d2b3e6979fb 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -984,7 +984,7 @@ static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
>  	p = page_address(*xdr->page_ptr);
>  	xdr->p = p + frag2bytes;
>  	space_left = xdr->buf->buflen - xdr->buf->len;
> -	if (space_left - nbytes >= PAGE_SIZE)
> +	if (space_left - frag1bytes >= PAGE_SIZE)
>  		xdr->end = p + PAGE_SIZE;
>  	else
>  		xdr->end = p + space_left - frag1bytes;
> 
