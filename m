Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8397442404D
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Oct 2021 16:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhJFOpL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Oct 2021 10:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238226AbhJFOpL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Oct 2021 10:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633531398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+flmyMG69kDZzoGkK8lW60xzTf6UFtNygjOnQClfyJA=;
        b=U4+WzSYAl7NEoyEharZgfoAeS6ZADIeFyNsYfQwCFhzyMEd2asyj+7NkIidcxUrlXPDce9
        GN08f4yzcIncB5UHDgQ+FHX4gu4/rCxHE31izJ7bsNGDJNjDBFPOwhVhb+tgy0NUIkbr3J
        jv+tDaEG3GLJkEiigYN8i1DZ2EeEIBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-_O_ndyfuNEeYrHgSN69CoA-1; Wed, 06 Oct 2021 10:43:17 -0400
X-MC-Unique: _O_ndyfuNEeYrHgSN69CoA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A56B8010ED;
        Wed,  6 Oct 2021 14:43:16 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00A6060877;
        Wed,  6 Oct 2021 14:43:15 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: Keep existing listners on portlist error
Date:   Wed, 06 Oct 2021 10:43:14 -0400
Message-ID: <053E93B5-0DFB-4A20-9742-F3894E2BE224@redhat.com>
In-Reply-To: <20211006143335.GA15343@fieldses.org>
References: <45b916f1aa3fb7c059a574f61188a8f2f615410e.1633529847.git.bcodding@redhat.com>
 <20211006143335.GA15343@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6 Oct 2021, at 10:33, J. Bruce Fields wrote:

> On Wed, Oct 06, 2021 at 10:18:05AM -0400, Benjamin Coddington wrote:
>> If nfsd has existing listening sockets without any processes, then an 
>> error
>> returned from svc_create_xprt() for an additional transport will 
>> remove
>> those existing listeners.  We're seeing this in practice when 
>> userspace
>> attempts to create rpcrdma transports without having the rpcrdma 
>> modules
>> present before creating nfsd kernel processes.  Fix this by checking 
>> for
>> existing sockets before callingn nfsd_destroy().
>
> That seems like an improvement.
>
> I'm curious, though, what the rpc.nfsd behavior is on partial failure.
> And what do we want it to be?
>
> If a user runs rpc.nfsd expecting it to start up tcp and rdma, but 
> rdma
> fails, do we want rpc.nfsd to succeed or fail?  Should it exit with 
> nfsd
> running or not?

I lean toward having it fail - but I think that's a different patch for
rpc.nfsd.  Right now rpc.nfsd exists without error, but you end up 
without
any listeners at all.

Do you want a patch for rpc.nfsd instead?

Ben

