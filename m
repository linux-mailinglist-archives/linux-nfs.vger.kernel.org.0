Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0614F7DF
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2019 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfFVTA7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jun 2019 15:00:59 -0400
Received: from fieldses.org ([173.255.197.46]:46528 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfFVTA7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 22 Jun 2019 15:00:59 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id B4A622010; Sat, 22 Jun 2019 15:00:58 -0400 (EDT)
Date:   Sat, 22 Jun 2019 15:00:58 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/16] nfsd: escape high characters in binary data
Message-ID: <20190622190058.GD5343@fieldses.org>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
 <1561042275-12723-9-git-send-email-bfields@redhat.com>
 <20190621174544.GC25590@fieldses.org>
 <201906211431.E6552108@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906211431.E6552108@keescook>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 21, 2019 at 03:26:00PM -0700, Kees Cook wrote:
> On Fri, Jun 21, 2019 at 01:45:44PM -0400, J. Bruce Fields wrote:
> > I'm not sure who to get review from for this kind of thing.
> > 
> > Kees, you seem to be one of the only people to touch string_helpers.c
> > at all recently, any ideas?
> 
> Hi! Yeah, I'm happy to take a look. Notes below...

Thanks!

> > On Thu, Jun 20, 2019 at 10:51:07AM -0400, J. Bruce Fields wrote:
> > > From: "J. Bruce Fields" <bfields@redhat.com>
> > > 
> > > I'm exposing some information about NFS clients in pseudofiles.  I
> > > expect to eventually have simple tools to help read those pseudofiles.
> > > 
> > > But it's also helpful if the raw files are human-readable to the extent
> > > possible.  It aids debugging and makes them usable on systems that don't
> > > have the latest nfs-utils.
> > > 
> > > A minor challenge there is opaque client-generated protocol objects like
> > > state owners and client identifiers.  Some clients generate those to
> > > include handy information in plain ascii.  But they may also include
> > > arbitrary byte sequences.
> > > 
> > > I think the simplest approach is to limit to isprint(c) && isascii(c)
> > > and escape everything else.
> 
> Can you get the same functionality out of sprintf's %pE (escaped
> string)? If not, maybe we should expand the flags available?

Nothing against it, I just didn't want it to do that for one user,
but...

> 
>  * - 'E[achnops]' For an escaped buffer, where rules are defined by
>  * combination
>  *                of the following flags (see string_escape_mem() for
>  *                the
>  *                details):
>  *                  a - ESCAPE_ANY
>  *                  c - ESCAPE_SPECIAL
>  *                  h - ESCAPE_HEX
>  *                  n - ESCAPE_NULL
>  *                  o - ESCAPE_OCTAL
>  *                  p - ESCAPE_NP
>  *                  s - ESCAPE_SPACE
>  *                By default ESCAPE_ANY_NP is used.
> 
> This doesn't cover escaping >0x7f and " and \
> 
> And perhaps I should rework kstrdup_quotable() to have that flag? It's
> not currently escaping non-ascii and it probably should. Maybe
> "ESCAPE_QUOTABLE" as "q"?

... but if you think there's a lot of existing users that really want
this behavior, then great.

I'll look into that.

The logic around ESCAPE_NP and the "only" string is really confusing.  I
started assuming I could just add an ESCAPE_NONASCII flag and stick "
and \ into the "only" string, but it doesn't work that way.

---b.
