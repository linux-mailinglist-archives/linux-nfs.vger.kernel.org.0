Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A44A4420DF
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 20:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhKATgV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 15:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhKATgV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 15:36:21 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72159C061714
        for <linux-nfs@vger.kernel.org>; Mon,  1 Nov 2021 12:33:47 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id DB0A263E; Mon,  1 Nov 2021 15:33:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DB0A263E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1635795226;
        bh=60Hvy9M2gFE2tqEKeEz5x70/jKD3PKpy6ZyqDyNN9QY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHKIp/enpMixWNkpLCM68lTiHjEnwvEMnmN7i8TxFiYqQBuFvsT16bzZdRM+8AM0s
         wgWzPTZ6Hiw91KHn4LaLE7WGaVXp3xT391p/6MgBcXf4tQlzVGM0yfvRqGR7BmkgHD
         QDEEourEnmMMfLpgCqCVZVNQKFJo2rIFtG9lUlFY=
Date:   Mon, 1 Nov 2021 15:33:46 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: server-to-server copy by default
Message-ID: <20211101193346.GD14427@fieldses.org>
References: <20211020155421.GC597@fieldses.org>
 <18E32DF5-3F1D-4C23-8C2F-A7963103CF8C@oracle.com>
 <CAN-5tyEL4L2GH=-MDGS4qNTcCLRPFCQzfDQjFAVbG7wMKvHxOg@mail.gmail.com>
 <8b1eb564-974d-00b6-397a-d92f301df7d8@oracle.com>
 <20211020202907.GF597@fieldses.org>
 <a009cbf3-cb83-b7c8-aa86-2eee06962b68@oracle.com>
 <20211021140243.GB25711@fieldses.org>
 <78839450-8095-01ae-53e8-f0ebf941b5a5@oracle.com>
 <1500403d-6aa1-3909-d44f-b33c1c1f3ce2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1500403d-6aa1-3909-d44f-b33c1c1f3ce2@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 01, 2021 at 10:37:11AM -0700, dai.ngo@oracle.com wrote:
> 
> On 10/21/21 11:34 PM, dai.ngo@oracle.com wrote:
> >On 10/21/21 7:02 AM, Bruce Fields wrote:
> >>On Wed, Oct 20, 2021 at 10:00:41PM -0700, dai.ngo@oracle.com wrote:
> >>>The attack can come from the replies of the source server or requests
> >>>from the source server to the destination server via the back channel.
> >>>One of possible attack in the reply is BAD_STATEID which was handled
> >>>by the client code as mentioned by Olga.
> >>>
> >>>Here is the list of NFS requests made from the destination to the
> >>>source server:
> >>>
> >>>         EXCHANGE_ID
> >>>         CREATE_SESSION
> >>>         RECLAIM_COMLETE
> >>>         SEQUENCE
> >>>         PUTROOTFH
> >>>         PUTHF
> >>>         GETFH
> >>>         GETATTR
> >>>         READ/READ_PLUS
> >>>         DESTROY_SESSION
> >>>         DESTROY_CLIENTID
> >>>
> >>>Do you think we should review all replies from these requests to make
> >>>sure error replies do not cause problems for the destination server?
> >>That's the exactly the sort of analysis I was curious to see, yes.
> >
> >I will go through these requests to see if is there is anything that
> >we need to do to ensure the destination does not react negatively
> >on the replies.
> 
> still need to be done.
> 
> >
> >>
> >>(I doubt the PUTROOTFH, PUTFH, GETFH, and GETATTR are really necessary,
> >>I wonder if there's any way we could just bypass them in our case.  I
> >>don't know, maybe that's more trouble than it's worth.)
> >
> >I'll take a look but I think we should avoid modifying the client
> >code if possible.
> >
> >>
> >>>same for the back channel ops:
> >>>
> >>>         OP_CB_GETATTR
> >>>         OP_CB_RECALL
> >>>         OP_CB_LAYOUTRECALL
> >>>         OP_CB_NOTIFY
> >>>         OP_CB_PUSH_DELEG
> >>>         OP_CB_RECALL_ANY
> >>>         OP_CB_RECALLABLE_OBJ_AVAIL
> >>>         OP_CB_RECALL_SLOT
> >>>         OP_CB_SEQUENCE
> >>>         OP_CB_WANTS_CANCELLED
> >>>         OP_CB_NOTIFY_LOCK
> >>>         OP_CB_NOTIFY_DEVICEID
> >>>         OP_CB_OFFLOAD
> >>There shouldn't be any need for callbacks at all.  We might be able to
> >>get away without even setting up a backchannel.  But, yes, if the server
> >>tries to send one anyway, it'd be good to know we do something
> >>reasonable.
> >
> >or do not specify the back channel when creating the session somehow.
> >I will report back.
> 
> We can not disable the back channel of the SSC v4.2 mount since it might
> share the same connection with a regular NFSv4.2 mount from the destination
> to the source server.

Hm.

Well, now that I think of it, a backchannel is probably required for the
SSC case anyway.  (I think CB_RECALL_SLOT is mandatory to support?)

--b.
