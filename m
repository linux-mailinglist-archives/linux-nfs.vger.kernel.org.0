Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94934860D8
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2019 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfHHL2o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Aug 2019 07:28:44 -0400
Received: from fieldses.org ([173.255.197.46]:53142 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfHHL2o (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 8 Aug 2019 07:28:44 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 16DD22070; Thu,  8 Aug 2019 07:28:44 -0400 (EDT)
Date:   Thu, 8 Aug 2019 07:28:44 -0400
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 08/16] nfsd: escape high characters in binary data
Message-ID: <20190808112844.GB7830@fieldses.org>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
 <1561042275-12723-9-git-send-email-bfields@redhat.com>
 <20190806121931.GA29578@smile.fi.intel.com>
 <20190806185008.GC9456@parsley.fieldses.org>
 <20190807090007.GK30120@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807090007.GK30120@smile.fi.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 07, 2019 at 12:00:07PM +0300, Andy Shevchenko wrote:
> Maybe it requires more thinking about?
> I think it is still possible to extend existing, rather to take workarounds
> like this one.

Yeah, agreed.

> > So, I wrote a patch series that removes the string_escape_mem flags that
> > aren't used
> 
> Have you considered the potential users that can be converted to use
> string_escape_mem()?
> 
> I know about at least one (needs to be reworked a bit, but it is in slow
> progress).
> 
> There are potentially others that would be converted using "unused" flags.

OK, that'd be interesting to know about.

> 
> >, simplifies it a bit, then separates the flags into two
> > different types: those that select which characters to escape
> > (non-printable, non-ascii, whitespace, etc.) and those that choose a
> > style of escaping to use (octal, hex, or \\).  That seems to make the
> > code a little easier to extend while still covering the cases people
> > actually use.  I'll try to get those out this week and you can tell me
> > what you think.
> 
> Will be glad to help!
> 
> In any case regarding to this one, I would like rather to see it's never
> appeared, or now will be gone in favour of string_escape_mem() extension.

To be clear, it's already merged.  Apologies, I actually saw your name
when looking for people to cc, but the last commit was 5 years ago and I
assumed you'd moved on.  The project to extend string_escape_mem()
looked more complicated than I first expected so I decided to merge this
first and then follow up with my attempt at that.

--b.
