Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C855844F598
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Nov 2021 22:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhKMWAB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Nov 2021 17:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhKMWAB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 Nov 2021 17:00:01 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4A2C061766
        for <linux-nfs@vger.kernel.org>; Sat, 13 Nov 2021 13:57:08 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 06BE76EC3; Sat, 13 Nov 2021 16:57:07 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 06BE76EC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1636840627;
        bh=eBF+mGrrMS8nOirZV57Lc5SibhLR7Rna/kEPBD1tz1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vhmHDW0+D446Ai2WZPKSZ72YZssxunr/jUJeIe+Q4hq7fmMzD1KNcP+jnaBQVFl5p
         yBmTQqkRgkqeqsIV5n0ww4pRqwcVfYGvffnPuh+R33tR9pGYRpikl65ktFHTnUYQm2
         i9xDHNpsm8pgAcFXaf4MJD7CSJpJHSo7zroxmoSU=
Date:   Sat, 13 Nov 2021 16:57:07 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "rtm@csail.mit.edu" <rtm@csail.mit.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS client can crash server due to overrun in
 nfsd4_decode_bitmap4()
Message-ID: <20211113215707.GE27601@fieldses.org>
References: <97860.1636837122@crash.local>
 <11B4530A-C0A0-4779-A9BA-F0E19B62C5A6@oracle.com>
 <20211113212544.GA27601@fieldses.org>
 <9A3E5D78-AE3C-4F45-8CB1-10F2EDA1D911@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9A3E5D78-AE3C-4F45-8CB1-10F2EDA1D911@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Nov 13, 2021 at 09:31:40PM +0000, Chuck Lever III wrote:
> This allows the client to send bitmaps larger than bmval[],
> as the old decoder did,

Oh, thanks, right, I guess rejecting too-large bitmaps outright might
cause compatibility problems with future implementations.

(Hm, ideally, shouldn't we be checking whether bits are set beyond where
we expect so that e.g. we can return NFS4ERR_ATTRNOTSUPP on operations
that set attributes?  Perhaps that's more than is necessary; it's a
separate issue, anyway.)

--b.

> and ensures that decode_bitmap()
> cannot write farther than @bmlen into the bmval array.
> 
> 
> > 		return nfserr_bad_xdr;
> > 	p = xdr_inline_decode(argp->xdr, count << 2);
> > 	if (!p)
> 
> --
> Chuck Lever
> 
> 
