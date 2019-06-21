Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D33B4F0A0
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2019 00:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFUWIO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jun 2019 18:08:14 -0400
Received: from fieldses.org ([173.255.197.46]:45532 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfFUWIO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 Jun 2019 18:08:14 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 0E22A1BE2; Fri, 21 Jun 2019 18:08:14 -0400 (EDT)
Date:   Fri, 21 Jun 2019 18:08:14 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 00/16] exposing knfsd client state to userspace
Message-ID: <20190621220814.GD26043@fieldses.org>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
 <20190621181309.GD25590@fieldses.org>
 <760712b7d0b965974f18efcc47e73561621f9c4c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <760712b7d0b965974f18efcc47e73561621f9c4c.camel@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 21, 2019 at 03:25:04PM -0400, Anna Schumaker wrote:
> On Fri, 2019-06-21 at 14:13 -0400, J. Bruce Fields wrote:
> > On Thu, Jun 20, 2019 at 10:50:59AM -0400, J. Bruce Fields wrote:
> > > 	- this duplicates some functionality of the little-used fault
> > > 	  injection code; could we replace it entirely?
> > 
> > I'd be really curious to hear from any users of that code, by the
> > way.
> > Anna, any ideas?
> 
> I'm not sure who else has used it besides me, and it's been a while
> since I have too.

Do you remember which ones were most useful? They are:

	- forget_clients
	- forget_locks
	- forget_openowners
	- forget_delegations
	- recall_delegations

We've got a functional replacement for forget_clients, but I haven't
looked into the others yet.

--b.

> 
> > 
> > The idea was that it could be used to test client handling of
> > exceptional conditions like recalled delegations and partially lost
> > state.  Is anyone regularly running such tests?
> > 
> > I don't hate the code, and I'm not on a crusade to tear it all out
> > Right
> > Now, but it does create a few odd corner cases, so I'm wondering
> > whether
> > I could get away with replacing it eventually or whether that risks
> > breaking someone's scripts.
> 
> I'm cool with replacing it if there is a better way to do things.
> 
> Anna
> 
> > 
> > --b.
