Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8801122CF94
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jul 2020 22:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGXUjB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jul 2020 16:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgGXUjB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Jul 2020 16:39:01 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCACC0619D3
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jul 2020 13:39:01 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 86A785F98; Fri, 24 Jul 2020 16:39:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 86A785F98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1595623140;
        bh=+/UOVsO8I30Zb22xxlvgtgrgYIoBxbkSqN85I8Xs1mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQSgoBcLG858p/LcYDn3tRtUg1KLpjkkdCMjRmjnDemV8BpfEMHHiPwkxR6a9brRI
         ioRlgadazUGQ+UXA9Z/vvJn3XwUclk10C66DKckcagQBaPkSR/u0ifmp+j2iblvp9j
         i0ujWk07rbEN2G3z+0gAQx9jPdMD777ZXLj9scmU=
Date:   Fri, 24 Jul 2020 16:39:00 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: fix_priv_head
Message-ID: <20200724203900.GB9244@fieldses.org>
References: <3799C9E0-DFF3-450C-A815-14BAFAC97EA8@oracle.com>
 <20200723193811.GG31487@fieldses.org>
 <94381D74-3563-4071-A0CF-4EC016744FEC@oracle.com>
 <20200724011720.GH31487@fieldses.org>
 <7557A354-8396-448D-BFC5-CA5512A4516B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7557A354-8396-448D-BFC5-CA5512A4516B@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 24, 2020 at 10:10:08AM -0400, Chuck Lever wrote:
> >> I'd like to remove this code, but
> >> I'd first like to understand how it will effect the code that follows
> >> immediately after:
> >> 
> >>        offset = xdr_pad_size(buf->head[0].iov_len);
> >>        if (offset) {
> >>                buf->buflen = RPCSVC_MAXPAYLOAD;
> >>                xdr_shift_buf(buf, offset);
> >>                fix_priv_head(buf, pad);
> >>        }
> 
> So if one of those patches removes "pad = priv_len - buf->len;"
> then the above code will break.
> 
> But I'm trying to see when it is possible for gss_unwrap to
> return a head buffer that is not quad-aligned. Not coming up
> with any such scenario.

Thinking about it more, even if there was some gss mechanism returning
misaligned data, the best place to fix that would likely be in the
mechanism-specific code (partly for reasons noted in the comment right
here--it'll be more efficient to put the data in the right spot as you
encrypt it.)

--b.
