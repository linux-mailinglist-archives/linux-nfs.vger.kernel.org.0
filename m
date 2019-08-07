Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E258484E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Aug 2019 11:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfHGJAL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Aug 2019 05:00:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:3024 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfHGJAL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Aug 2019 05:00:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 02:00:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="185927601"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga002.jf.intel.com with ESMTP; 07 Aug 2019 02:00:09 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hvHnj-0005sm-Rd; Wed, 07 Aug 2019 12:00:07 +0300
Date:   Wed, 7 Aug 2019 12:00:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 08/16] nfsd: escape high characters in binary data
Message-ID: <20190807090007.GK30120@smile.fi.intel.com>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
 <1561042275-12723-9-git-send-email-bfields@redhat.com>
 <20190806121931.GA29578@smile.fi.intel.com>
 <20190806185008.GC9456@parsley.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806185008.GC9456@parsley.fieldses.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 06, 2019 at 02:50:08PM -0400, J. Bruce Fields wrote:
> On Tue, Aug 06, 2019 at 03:19:31PM +0300, Andy Shevchenko wrote:
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
> > > 
> > > That means you can just cat the file and get something that looks OK.
> > > Also, I'm trying to keep these files legal YAML, which requires them to
> > > UTF-8, and this is a simple way to guarantee that.
> > 
> > Two questions:
> > - why can't be original function extended to cover this case
> >   (using additional flags, maybe)?
> 
> I found the ESCAPE_NP/"only" logic made it a little difficult to extend
> string_escape_mem().

Maybe it requires more thinking about?
I think it is still possible to extend existing, rather to take workarounds
like this one.

> So, I wrote a patch series that removes the string_escape_mem flags that
> aren't used

Have you considered the potential users that can be converted to use
string_escape_mem()?

I know about at least one (needs to be reworked a bit, but it is in slow
progress).

There are potentially others that would be converted using "unused" flags.

>, simplifies it a bit, then separates the flags into two
> different types: those that select which characters to escape
> (non-printable, non-ascii, whitespace, etc.) and those that choose a
> style of escaping to use (octal, hex, or \\).  That seems to make the
> code a little easier to extend while still covering the cases people
> actually use.  I'll try to get those out this week and you can tell me
> what you think.

Will be glad to help!

In any case regarding to this one, I would like rather to see it's never
appeared, or now will be gone in favour of string_escape_mem() extension.

-- 
With Best Regards,
Andy Shevchenko


