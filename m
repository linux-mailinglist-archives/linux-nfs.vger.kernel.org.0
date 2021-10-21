Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E174363B6
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 16:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJUOFB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 10:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJUOFB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Oct 2021 10:05:01 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D5C0613B9
        for <linux-nfs@vger.kernel.org>; Thu, 21 Oct 2021 07:02:43 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 57D5E647C; Thu, 21 Oct 2021 10:02:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 57D5E647C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634824963;
        bh=s3dy4Ehxo8S4MO7AqhWht9Cy3DylkZkhu0SEN5aynSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y42Iu/O5T1L4jUd9IHveATzXP7ppE/FksMuGjNLS6ruMN4ag9FIuPrN8YWiLmyxPP
         4lBNsWVZ1DPdnm1wOXTRTSlEEGBoDlJHTVFYDt5C4xcAybwvv0Jq2amF/gZKOI/A9u
         6IMT8nYs93fk1v1ChyMxvcxO/EX9IDuxBLICIKhE=
Date:   Thu, 21 Oct 2021 10:02:43 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: server-to-server copy by default
Message-ID: <20211021140243.GB25711@fieldses.org>
References: <20211020155421.GC597@fieldses.org>
 <18E32DF5-3F1D-4C23-8C2F-A7963103CF8C@oracle.com>
 <CAN-5tyEL4L2GH=-MDGS4qNTcCLRPFCQzfDQjFAVbG7wMKvHxOg@mail.gmail.com>
 <8b1eb564-974d-00b6-397a-d92f301df7d8@oracle.com>
 <20211020202907.GF597@fieldses.org>
 <a009cbf3-cb83-b7c8-aa86-2eee06962b68@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a009cbf3-cb83-b7c8-aa86-2eee06962b68@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for the persistence:

On Wed, Oct 20, 2021 at 10:00:41PM -0700, dai.ngo@oracle.com wrote:
> The attack can come from the replies of the source server or requests
> from the source server to the destination server via the back channel.
> One of possible attack in the reply is BAD_STATEID which was handled
> by the client code as mentioned by Olga.
> 
> Here is the list of NFS requests made from the destination to the
> source server:
> 
>         EXCHANGE_ID
>         CREATE_SESSION
>         RECLAIM_COMLETE
>         SEQUENCE
>         PUTROOTFH
>         PUTHF
>         GETFH
>         GETATTR
>         READ/READ_PLUS
>         DESTROY_SESSION
>         DESTROY_CLIENTID
> 
> Do you think we should review all replies from these requests to make
> sure error replies do not cause problems for the destination server?

That's the exactly the sort of analysis I was curious to see, yes.

(I doubt the PUTROOTFH, PUTFH, GETFH, and GETATTR are really necessary,
I wonder if there's any way we could just bypass them in our case.  I
don't know, maybe that's more trouble than it's worth.)

> same for the back channel ops:
> 
>         OP_CB_GETATTR
>         OP_CB_RECALL
>         OP_CB_LAYOUTRECALL
>         OP_CB_NOTIFY
>         OP_CB_PUSH_DELEG
>         OP_CB_RECALL_ANY
>         OP_CB_RECALLABLE_OBJ_AVAIL
>         OP_CB_RECALL_SLOT
>         OP_CB_SEQUENCE
>         OP_CB_WANTS_CANCELLED
>         OP_CB_NOTIFY_LOCK
>         OP_CB_NOTIFY_DEVICEID
>         OP_CB_OFFLOAD

There shouldn't be any need for callbacks at all.  We might be able to
get away without even setting up a backchannel.  But, yes, if the server
tries to send one anyway, it'd be good to know we do something
reasonable.

--b.
