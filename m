Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4EE5A39E
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2019 20:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfF1Sbk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jun 2019 14:31:40 -0400
Received: from mail.prgmr.com ([71.19.149.6]:47734 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfF1Sbk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 28 Jun 2019 14:31:40 -0400
Received: from turtle.mx (96-92-68-116-static.hfc.comcastbusiness.net [96.92.68.116])
        (Authenticated sender: adp)
        by mail.prgmr.com (Postfix) with ESMTPSA id 64B6E28C007
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jun 2019 19:28:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com 64B6E28C007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1561764525;
        bh=w0ip7wjhbUow6f/NfcJqJpaBAZiZ4zdDciovMgaIaNg=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=n6kNImwjvoYjQAu6R0kGo9vVs3w6OCHDK827fwzg6/C8LDpB8Mc36LlC3PcXD8Xl/
         Yk51wY898CVFglYlI6yU9V6rBNGx5GQFRgeGzJxAM3S7ZnEVmDhjwX6sCr56NjWMxA
         3EJgGxl6yKOjl4fz0hsBMTG9XRlIqc0b0EGc4Lic=
Received: (qmail 22099 invoked by uid 1353); 28 Jun 2019 18:33:24 -0000
Date:   Fri, 28 Jun 2019 12:33:24 -0600
From:   Alan Post <adp@prgmr.com>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: User process NFS write hang in wait_on_commit with kworker
Message-ID: <20190628183324.GJ4158@turtle.email>
References: <20190618000613.GR4158@turtle.email>
 <6DE07E49-D450-4BF7-BC61-0973A14CD81B@redhat.com>
 <20190619000746.GT4158@turtle.email>
 <25608EB2-87F0-4196-BEF9-8AB8FC72270B@redhat.com>
 <20190621204723.GU4158@turtle.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621204723.GU4158@turtle.email>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 21, 2019 at 02:47:23PM -0600, Alan Post wrote:
> > Verifying this is the problem could be done by setting up some rolling
> > network captures.. but sometimes it can be hard to not have the capture
> > fill up with continuing traffic from other processes.
> > 
> 
> I did go ahead and set up a rolling capture between this NFS
> server and one rack of clients--I hope I can catch the event as
> it happens.  Time will tell.
> 

I've run this rolling capture and did catch four candidate events.
I haven't confirmed any of them are real--I don't really know
what it is I'm looking for, so I've been approaching the problem
by incrementally/recursively throwing stuff out and manually
working through what's left.

As far as I understand it, for a particular xid, there should be a
call and a reply.  The approach I took then was to pull out these
fields from my capture and ignore RPC calls where both are present
in my capture.  It seems this is simplistic, as the number of RPC
calls I have without an attendant reply isn't lining up with my
incident window.

In one example, I have a series of READ calls which cease
generating RPC reply messages as the offset for the file continues
to increases.  After a couple/few dozen messages, the RPC replies
continue as they were.  Is there a normal or routine explanation
for this?

RFC 5531 and the NetworkTracing page on wiki.linux-nfs.org have
been quite helpful bringing me up to speed.  If any of you have
advice or guidance or can clarify my understanding of how the
call/reply RPC mechanism works I appreciate it.

-A
-- 
Alan Post | Xen VPS hosting for the technically adept
PO Box 61688 | Sunnyvale, CA 94088-1681 | https://prgmr.com/
email: adp@prgmr.com
