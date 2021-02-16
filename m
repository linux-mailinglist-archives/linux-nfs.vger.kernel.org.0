Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B1731D2D4
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Feb 2021 23:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhBPWsq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Feb 2021 17:48:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231280AbhBPWsp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Feb 2021 17:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613515639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uXp5UMOouYnIdmSeJ/6TdGsSmJa3ZXTZQTkrYiYlCOo=;
        b=RkoK/f3kk26Su60RdIMrfiqfROkX5Auj/+UICWlIW4g/9wAujZBwGXp/eF4Qo6X85CgpDf
        c70I1e3etQ0YAg9S90qkp9tsggJ+TPT/mHLd5SGA/HnBMDAIpgfC+Ap2HSGyMSBtNThp9j
        ATAFXYl5tdL9NrAzn+5rO3INztaLvCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-0BNyfCG7O0euhXAUYX7t5g-1; Tue, 16 Feb 2021 17:47:17 -0500
X-MC-Unique: 0BNyfCG7O0euhXAUYX7t5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45EEE108C303;
        Tue, 16 Feb 2021 22:47:16 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-117-197.rdu2.redhat.com [10.10.117.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01C1E5C1B4;
        Tue, 16 Feb 2021 22:47:15 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 026EE1203A4; Tue, 16 Feb 2021 17:47:14 -0500 (EST)
Date:   Tue, 16 Feb 2021 17:47:14 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Calum Mackay <calum.mackay@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [RFC] pynfs: add courteous server tests
Message-ID: <YCxLcm8FFFWzZELr@pick.fieldses.org>
References: <47d31c15-7467-6abb-9e62-96ffca1c6ec0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47d31c15-7467-6abb-9e62-96ffca1c6ec0@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 16, 2021 at 10:04:05PM +0000, Calum Mackay wrote:
> hi Bruce,
> 
> At Chuck's suggestion, I've added an initial PyNFS test to aid work on a
> courteous server. A simple test, along the lines you indicated, that locks a
> file, waits twice the lease period, and tries to unlock:
> 
> OK -> PASS (courteous server)
> BADSESSION -> WARNING (discourteous server)
> 
> 
> Before sending my patch, Chuck asked me to add the second test you
> suggested:
> 
> 	- A second test creates a new client, acquires a file lock, and
> 	  waits two lease periods.  Then creates a second client, which
> 	  attempts to acquire the lock.  The second client should
> 	  succeed.
> 
> 
> 
> This doesn't seem to differentiate between these three cases:
> 
> 1. a discourteous server, which invalidates the client 1 state, and frees
> all client 1's locks, upon lease expiry, then allows client 2 to lock the
> file. The above test spec would result in a PASS for a discourteous server,
> which doesn't seem right.

Apologies for the confusing suggestion.  I think all I really wanted to
verify was that the server will grant the lock to a second client after
a lease period has gone by.

That's a simple test that *any* server (courteous or discourteous)
should pass.  (We probably do have a test for that at least in the 4.0
case.  It'd be nice to have one in the 4.1 case.  Maybe just look into
porting some 4.0 tests over to 4.1.)

Anyway, it seems like a simple thing that would be useful to verify
while doing courteous server implementation.  I mean, we want to make
sure we don't accidentally implement a "courteous" server that works by
just never dropping any client's state ever.

> 2. a broad-grained courteous server, which invalidates the client 1 state,
> and frees all client 1's locks, because of conflicting access from client 2
> (after client 1's lease expiry), who is then granted the lock. A PASS here
> would be correct.
> 
> 3. a fine-grained courteous server, which persists the session, but revokes
> that particular client 1 lock, because of conflicting access from client 2
> (after client 1's lease expiry), who is granted the lock. A PASS here would
> be correct.

> If I've read it right, the test could differentiate between cases 2) and 3),
> by having client 1 try to unlock, after client 2 successfully locks, where
> client 1 will see either BADSESSION (case 2) or SOME_STATE_REVOKED / EXPIRED
> (case 3).

Sounds like a good idea to test those two cases.

> But we don't need to differentiate cases 2) and 3), since a PASS
> would be correct in either case.

But, yes, they're both "courteous" cases.

I do wish sometimes that we had states other than "PASS/FAIL/WARN";
sometimes you want to know stuff about a server that isn't just whether
it's "right" or not.

Bit it's not really a big deal.  Note if you leave the "all" flag off a
test, it won't be run by default.  And if a test flagged "courteous" but
not "all" fails on a correct but uncourteous server, that's probably
fine.

I think it'd also be fine to WARN about anything short of the
finest-grained possible behavior.  You can give more details in the
wording of the warning.

> However that won't differentiate between cases 1) and 2), where client 1
> will see BADSESSION in each case. Yet case 1) ought to result in a WARNING,
> and case 2) in a PASS?

We could also do something like:

	client 1 acquires two different locks.
	wait a lease period or two
	client 2 attempts to acquire one of the locks.
	client 1 attempts to unlock the other one.

And that'd be another way to test whether we have a coarse- or fine-
grained courteous server.

My test suggestions were very off-the-cuff, if you have ideas then go
for it.

--b.

