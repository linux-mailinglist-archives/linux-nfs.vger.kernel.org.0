Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F384B8C1
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 14:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbfFSMiE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 08:38:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbfFSMiE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 19 Jun 2019 08:38:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3674A81F01;
        Wed, 19 Jun 2019 12:38:04 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD1A6183C4;
        Wed, 19 Jun 2019 12:38:03 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Alan Post" <adp@prgmr.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: User process NFS write hang in wait_on_commit with kworker
Date:   Wed, 19 Jun 2019 08:38:02 -0400
Message-ID: <25608EB2-87F0-4196-BEF9-8AB8FC72270B@redhat.com>
In-Reply-To: <20190619000746.GT4158@turtle.email>
References: <20190618000613.GR4158@turtle.email>
 <6DE07E49-D450-4BF7-BC61-0973A14CD81B@redhat.com>
 <20190619000746.GT4158@turtle.email>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 19 Jun 2019 12:38:04 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 18 Jun 2019, at 20:07, Alan Post wrote:

> On Tue, Jun 18, 2019 at 11:29:16AM -0400, Benjamin Coddington wrote:
>> I think that your transport or NFS server is dropping the response to an
>> RPC.  The NFS client will not retransmit on an established connection.
>>
>> What server are you using?  Any middle boxes on the network that could be
>> transparently dropping transmissions (less likely, but I have seen them)?
>>
>
> I've found 8 separate NFS client hangs of the sort I reported here,
> and in all cases the same NFS server was involved: an Ubuntu Trusty
> system running 4.4.0.  I've been upgrading all of these NFS servers,
> haven't done this one yet--the complicity of NFS hangs I've been
> seeing have slowed me down.
>
> Of the 8 NFS clients with a hang to this server, about half are in
> the same computer room where packets only transit rack switches, with
> the other half also going through a computer room router.
>
> I see positive dropped and overrun packet counts on the NFS server
> interface, along with a similar magnitude of pause counts on the
> switch port for the NFS server.  Given the occurences of this issue
> only this rack switch and a redundant pair of top-of-rack switches in
> the rack with the NFS server are in-common between all 8 NFS clients
> with write hangs.

TCP drops or overruns should not be a problem since the TCP layer will
retransmit packets that are not acked.  The issue would be if the NFS
server is perhaps silently dropping a response to an IO RPC.  Or, an
intelligent middle-box that keeps its own stateful transparent TCP handling
between client and server existed (you clearly don't have that here).

So I recall some knfsd issues dropping replies in that era of kernel
versions when the GSS sequencing grew out of a window.  Are you using a
sec=krb5* on these mounts, or is it all sec=sys?  Perhaps that's the problem
you are seeing.  Again, just some guessing.

Verifying this is the problem could be done by setting up some rolling
network captures.. but sometimes it can be hard to not have the capture
fill up with continuing traffic from other processes.

Ben
