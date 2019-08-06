Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E8838F7
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 20:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfHFSuK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 14:50:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHFSuK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 6 Aug 2019 14:50:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48D2C315C01E;
        Tue,  6 Aug 2019 18:50:10 +0000 (UTC)
Received: from parsley.fieldses.org (ovpn-116-185.phx2.redhat.com [10.3.116.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FC425C559;
        Tue,  6 Aug 2019 18:50:10 +0000 (UTC)
Received: by parsley.fieldses.org (Postfix, from userid 2815)
        id CA2E61804A0; Tue,  6 Aug 2019 14:50:08 -0400 (EDT)
Date:   Tue, 6 Aug 2019 14:50:08 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 08/16] nfsd: escape high characters in binary data
Message-ID: <20190806185008.GC9456@parsley.fieldses.org>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
 <1561042275-12723-9-git-send-email-bfields@redhat.com>
 <20190806121931.GA29578@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806121931.GA29578@smile.fi.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 06 Aug 2019 18:50:10 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 06, 2019 at 03:19:31PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 20, 2019 at 10:51:07AM -0400, J. Bruce Fields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > I'm exposing some information about NFS clients in pseudofiles.  I
> > expect to eventually have simple tools to help read those pseudofiles.
> > 
> > But it's also helpful if the raw files are human-readable to the extent
> > possible.  It aids debugging and makes them usable on systems that don't
> > have the latest nfs-utils.
> > 
> > A minor challenge there is opaque client-generated protocol objects like
> > state owners and client identifiers.  Some clients generate those to
> > include handy information in plain ascii.  But they may also include
> > arbitrary byte sequences.
> > 
> > I think the simplest approach is to limit to isprint(c) && isascii(c)
> > and escape everything else.
> > 
> > That means you can just cat the file and get something that looks OK.
> > Also, I'm trying to keep these files legal YAML, which requires them to
> > UTF-8, and this is a simple way to guarantee that.
> 
> Two questions:
> - why can't be original function extended to cover this case
>   (using additional flags, maybe)?

I found the ESCAPE_NP/"only" logic made it a little difficult to extend
string_escape_mem().

So, I wrote a patch series that removes the string_escape_mem flags that
aren't used, simplifies it a bit, then separates the flags into two
different types: those that select which characters to escape
(non-printable, non-ascii, whitespace, etc.) and those that choose a
style of escaping to use (octal, hex, or \\).  That seems to make the
code a little easier to extend while still covering the cases people
actually use.  I'll try to get those out this week and you can tell me
what you think.

> - where are the test cases?

I didn't write a test case.  I agree that it would be a good idea--I'll
work on it.

--b.
