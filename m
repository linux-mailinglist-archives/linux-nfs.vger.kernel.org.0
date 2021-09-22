Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AA4414D4F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 17:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhIVPrV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 11:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhIVPrV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Sep 2021 11:47:21 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0BEC061574
        for <linux-nfs@vger.kernel.org>; Wed, 22 Sep 2021 08:45:51 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 997E77027; Wed, 22 Sep 2021 11:45:49 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 997E77027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632325549;
        bh=LFTo6NPpYxw6/I3pnfZQGuPQrfymygTY8Jrs7pPLph4=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=m9nSojEXJRcmSXk+6yAZbNl/uhXB9Nsbbq6BR3mq2aIAeQf+9OBPi03R1k7XLBiFe
         7uYovKPZUrSMC2bAath6Az/XJonSM+O2azlQnvLlGMaI6EpkeNHYUgKgUAU9WqkMS6
         8fViBosi243u7feNnF4kPWJgId5OJLixWWarFb48=
Date:   Wed, 22 Sep 2021 11:45:49 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     dai.ngo@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NLM: Remove svcxdr_encode_owner()
Message-ID: <20210922154549.GB22937@fieldses.org>
References: <163181894199.1110.356714948732645250.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163181894199.1110.356714948732645250.stgit@bazille.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 16, 2021 at 03:03:32PM -0400, Chuck Lever wrote:
> Dai Ngo reports that, since the XDR overhaul, the NLM server crashes
> when the TEST procedure wants to return NLM_DENIED. There is a bug
> in svcxdr_encode_owner() that none of our standard test cases found.
> 
> Replace the open-coded function with a call to an appropriate
> pre-fabricated XDR helper.

Makes sense to me.  I assume you're taking this for 5.15.--b.

> 
> Reported-by: Dai Ngo <Dai.Ngo@oracle.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/lockd/svcxdr.h |   13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> This might be a little better for the long term. Comments?
> 
> diff --git a/fs/lockd/svcxdr.h b/fs/lockd/svcxdr.h
> index c69a0bb76c94..805fb19144d7 100644
> --- a/fs/lockd/svcxdr.h
> +++ b/fs/lockd/svcxdr.h
> @@ -134,18 +134,9 @@ svcxdr_decode_owner(struct xdr_stream *xdr, struct xdr_netobj *obj)
>  static inline bool
>  svcxdr_encode_owner(struct xdr_stream *xdr, const struct xdr_netobj *obj)
>  {
> -	unsigned int quadlen = XDR_QUADLEN(obj->len);
> -	__be32 *p;
> -
> -	if (xdr_stream_encode_u32(xdr, obj->len) < 0)
> -		return false;
> -	p = xdr_reserve_space(xdr, obj->len);
> -	if (!p)
> +	if (unlikely(obj->len > XDR_MAX_NETOBJ))
>  		return false;
> -	p[quadlen - 1] = 0;	/* XDR pad */
> -	memcpy(p, obj->data, obj->len);
> -
> -	return true;
> +	return xdr_stream_encode_opaque(xdr, obj->data, obj->len) > 0;
>  }
>  
>  #endif /* _LOCKD_SVCXDR_H_ */
> 
