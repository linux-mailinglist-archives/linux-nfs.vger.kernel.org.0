Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F582C1462
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 20:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbgKWTSl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 14:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbgKWTSk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 14:18:40 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B60C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 11:18:40 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 136896E9E; Mon, 23 Nov 2020 14:18:40 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 136896E9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606159120;
        bh=zRTd0JW2WYfrCxNiuuBaQoEJkhlTooZf+VHyw2Vetfw=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=ETHKjR/ZqqgwSRZ/+izFiCGhc5CTjB92QIScT3p0b1xsGXNaYtBnyRgZD5/Phg5/z
         RxJ7iOyC4zd3B0jILnP/rhpJIjd1dAx7IY0hprUcdPEW4hweObGK0oewXc8sALwvOO
         KOYoNtzFmdWjr0vOtooZYPjFJrv3kF2/2boQbZd4=
Date:   Mon, 23 Nov 2020 14:18:40 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 005/118] NFSD: Replace the internals of the READ_BUF()
 macro
Message-ID: <20201123191840.GH32599@fieldses.org>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
 <160590445271.1340.9408337302317384948.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160590445271.1340.9408337302317384948.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 20, 2020 at 03:34:12PM -0500, Chuck Lever wrote:
> @@ -396,7 +281,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
>  		READ_BUF(4); len += 4;
>  		nace = be32_to_cpup(p++);
>  
> -		if (nace > compoundargs_bytes_left(argp)/20)
> +		if (nace > xdr_stream_remaining(argp->xdr) / sizeof(struct nfs4_ace))

Picky C question: is the compiler guaranteed to pack that struct in the
obvious way?

That aside, I'm not comfortable assuming the struct could never change
to, say, include something that's useful during processing but doesn't
appear on the wire.

Also, that change isn't actually logically related to the rest of the
patch, so it's the sort of thing I'd expect separated out.

--b.
