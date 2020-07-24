Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA7E22BB4A
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jul 2020 03:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgGXBRV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jul 2020 21:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgGXBRV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jul 2020 21:17:21 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CCDC0619D3
        for <linux-nfs@vger.kernel.org>; Thu, 23 Jul 2020 18:17:20 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 28F093EB; Thu, 23 Jul 2020 21:17:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 28F093EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1595553440;
        bh=vIR6OxcmRZc1RTvSbn8ZcweSgFBqmmB8mX1iHAqiLBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTTcERKbfNpHfFioinIggjtvGbGYYZVfOBBTVpzXM/1aO8HHqkkCMW/NA/+iJ1tZx
         dWhtdDFbqbgEq+Xf4CqiShW3kECTxY0KNPwqbcbvzaxJSQDwTuCydHJZRG6tOHyBWW
         /JPm7mzG4s+VMROTTgBfwZRaiHQVfIl4SZRUmTQk=
Date:   Thu, 23 Jul 2020 21:17:20 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: fix_priv_head
Message-ID: <20200724011720.GH31487@fieldses.org>
References: <3799C9E0-DFF3-450C-A815-14BAFAC97EA8@oracle.com>
 <20200723193811.GG31487@fieldses.org>
 <94381D74-3563-4071-A0CF-4EC016744FEC@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94381D74-3563-4071-A0CF-4EC016744FEC@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 23, 2020 at 04:23:05PM -0400, Chuck Lever wrote:
> 
> 
> > On Jul 23, 2020, at 3:38 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Thu, Jul 23, 2020 at 01:46:19PM -0400, Chuck Lever wrote:
> >> Hi Bruce-
> >> 
> >> I'm trying to figure out if fix_priv_head is still necessary. This
> >> was introduced by 7c9fdcfb1b64 ("[PATCH] knfsd: svcrpc: gss:
> >> server-side implementation of rpcsec_gss privacy").
> >> 
> >> static void
> >> fix_priv_head(struct xdr_buf *buf, int pad)
> >> {
> >>        if (buf->page_len == 0) {
> >>                /* We need to adjust head and buf->len in tandem in this
> >>                 * case to make svc_defer() work--it finds the original
> >>                 * buffer start using buf->len - buf->head[0].iov_len. */
> >>                buf->head[0].iov_len -= pad;
> >>        }
> >> }
> >> 
> >> It doesn't seem like unwrapping can ever result in a buffer length that
> >> is not quad-aligned. Is that simply a characteristic of modern enctypes?
> 
> And: how is it correct to subtract "pad" ? if the length of the content
> is not aligned, this truncates it. Instead, shouldn't the length be
> extended to the next quad-boundary?
>
> > This code is before any unwrapping.  We're looking at the length of the
> > encrypted (wrapped) object here, not the unwrapped buffer.
> 
> fix_priv_head() is called twice: once before and once after gss_unwrap.

OK, sorry, I missed that.

> There is also this adjustment, just after the gss_unwrap() call:
> 
>         maj_stat = gss_unwrap(ctx, 0, priv_len, buf);
>         pad = priv_len - buf->len;
>         buf->len -= pad;
> 
> This is actually a bug, now that gss_unwrap adjusts buf->len: subtracting
> "pad" can make buf->len go negative.

OK.  Looking at the code now....  I'm not sure I follow it, but I'll
believe you.

(But if we've been leaving buf->len too short, why hasn't that been
causing really obvious test failures?)

> I'd like to remove this code, but
> I'd first like to understand how it will effect the code that follows
> immediately after:
> 
>         offset = xdr_pad_size(buf->head[0].iov_len);
>         if (offset) {
>                 buf->buflen = RPCSVC_MAXPAYLOAD;
>                 xdr_shift_buf(buf, offset);
>                 fix_priv_head(buf, pad);
>         }
> 
> > When using privacy, the body of an rpcsec_gss request is a single opaque
> > object consisting of the wrapped data.  So the question is whether
> > there's any case where the length of that object can be less than the
> > length remaining in the received buffer.
> > 
> > I think the only reason for bytes at the end is, yes, that that opaque
> > object is not a multiple of 4 and so rpc requires padding at the end.
> 
> Newer enctypes seem to put something substantial beyond the end of
> the opaque. That's why gss_unwrap_kerberos_v2() finishes with a
> call to xdr_buf_trim().
> 
> But I'm not sure why the receiver should care about a misaligned size
> of the opaque.
> 
> The GSS mechanism's unwrap method should set buf->len to the size
> of the unencrypted payload message, and for RPC, that size should
> always be a multiple of four, and will exclude any of those extra
> bytes.

Honestly, I wrote this code 10 or 15 years ago and haven't thought hard
about it in about that long.  And at the time I didn't feel like I
understood it as well as I should either, there was too much fixing
things up to make them work and not enough work organizing it correctly.
I'm sure there must be a way to make it simpler....

--b.
