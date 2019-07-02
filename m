Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5D05CD50
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2019 12:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfGBKHQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Jul 2019 06:07:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16751 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfGBKHQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Jul 2019 06:07:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0138F3092647;
        Tue,  2 Jul 2019 10:07:16 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADE6553CF5;
        Tue,  2 Jul 2019 10:07:15 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Alan Post" <adp@prgmr.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: User process NFS write hang in wait_on_commit with kworker
Date:   Tue, 02 Jul 2019 05:55:10 -0400
Message-ID: <35045385-2C77-4BA0-8641-2AE4E73E04A4@redhat.com>
In-Reply-To: <20190628183324.GJ4158@turtle.email>
References: <20190618000613.GR4158@turtle.email>
 <6DE07E49-D450-4BF7-BC61-0973A14CD81B@redhat.com>
 <20190619000746.GT4158@turtle.email>
 <25608EB2-87F0-4196-BEF9-8AB8FC72270B@redhat.com>
 <20190621204723.GU4158@turtle.email> <20190628183324.GJ4158@turtle.email>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 02 Jul 2019 10:07:16 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 28 Jun 2019, at 14:33, Alan Post wrote:

> On Fri, Jun 21, 2019 at 02:47:23PM -0600, Alan Post wrote:
>>> Verifying this is the problem could be done by setting up some rolling
>>> network captures.. but sometimes it can be hard to not have the capture
>>> fill up with continuing traffic from other processes.
>>>
>>
>> I did go ahead and set up a rolling capture between this NFS
>> server and one rack of clients--I hope I can catch the event as
>> it happens.  Time will tell.
>>
>
> I've run this rolling capture and did catch four candidate events.
> I haven't confirmed any of them are real--I don't really know
> what it is I'm looking for, so I've been approaching the problem
> by incrementally/recursively throwing stuff out and manually
> working through what's left.
>
> As far as I understand it, for a particular xid, there should be a
> call and a reply.  The approach I took then was to pull out these
> fields from my capture and ignore RPC calls where both are present
> in my capture.  It seems this is simplistic, as the number of RPC
> calls I have without an attendant reply isn't lining up with my
> incident window.

Does your capture report dropped packets?  If so, maybe you need to increase
the capture buffer.

There are the sunrpc:xprt_transmit and sunrpc:xprt_complete_rqst tracepoints
as well that should show the xids.

> In one example, I have a series of READ calls which cease
> generating RPC reply messages as the offset for the file continues
> to increases.  After a couple/few dozen messages, the RPC replies
> continue as they were.  Is there a normal or routine explanation
> for this?
>
> RFC 5531 and the NetworkTracing page on wiki.linux-nfs.org have
> been quite helpful bringing me up to speed.  If any of you have
> advice or guidance or can clarify my understanding of how the
> call/reply RPC mechanism works I appreciate it.

Seems like you understand it.  Do you have specific questions?

Ben
