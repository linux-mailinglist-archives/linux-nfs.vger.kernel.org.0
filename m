Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D1D194E9A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2020 02:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgC0BuX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 21:50:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22184 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgC0BuW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Mar 2020 21:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585273821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lHsUR9XT1E/Q6hzKRYTJISM9Xe7WluzoyIo6Kd8o0QY=;
        b=icQA4gCW4+LoclDOLz6bhVTrfRUOMl67I4xjriZj3QkJMMT3Erml4ITYwd33SmlRmp/dKe
        kthQGtUrFn1/J+sBLVmWSbKQgvw1+eLUD5KA1S6S6YaLLXbqHvISP/Cpqk0AdEjkX8zizV
        mf4idRWy232B1acLws0tg+tL36CxmRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-Unu6JB2EMF2Xxgoc2gPI4Q-1; Thu, 26 Mar 2020 21:50:15 -0400
X-MC-Unique: Unu6JB2EMF2Xxgoc2gPI4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FDE1800D50;
        Fri, 27 Mar 2020 01:50:14 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-118-194.rdu2.redhat.com [10.10.118.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C30A060BF3;
        Fri, 27 Mar 2020 01:50:13 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 78C8B120513; Thu, 26 Mar 2020 21:50:12 -0400 (EDT)
Date:   Thu, 26 Mar 2020 21:50:12 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "kinglongmee@gmail.com" <kinglongmee@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC/cache: Allow garbage collection of invalid cache
 entries
Message-ID: <20200327015012.GA107036@pick.fieldses.org>
References: <20200114165738.922961-1-trond.myklebust@hammerspace.com>
 <20200206163322.GB2244@fieldses.org>
 <8dc1ed17de98e4b59fb9e408692c152456863a20.camel@hammerspace.com>
 <20200207181817.GC17036@fieldses.org>
 <20200326204001.GA25053@fieldses.org>
 <1a0ce8bb1150835f7a25126df2524e8a8fb0e112.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a0ce8bb1150835f7a25126df2524e8a8fb0e112.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 26, 2020 at 09:42:19PM +0000, Trond Myklebust wrote:
> On Thu, 2020-03-26 at 16:40 -0400, bfields@fieldses.org wrote:
> > Maybe the cache_is_expired() logic should be something more like:
> > 
> > 	if (h->expiry_time < seconds_since_boot())
> > 		return true;
> > 	if (!test_bit(CACHE_VALID, &h->flags))
> > 		return false;
> > 	return h->expiry_time < seconds_since_boot();
> > 
> > So invalid cache entries (which are waiting for a reply from mountd)
> > can
> > expire, but they can't be flushed.  If that makes sense.
> > 
> > As a stopgap we may want to revert or drop the "Allow garbage
> > collection" patch, as the (preexisting) memory leak seems lower
> > impact
> > than the server hang.
> 
> I believe you were probably seeing the effect of the
> cache_listeners_exist() test, which is just wrong for all cache upcall
> users except idmapper and svcauth_gss. We should not be creating
> negative cache entries just because the rpc.mountd daemon happens to be
> slow to connect to the upcall pipes when starting up, or because it
> crashes and fails to restart correctly.
> 
> That's why, when I resubmitted this patch, I included 
> https://git.linux-nfs.org/?p=cel/cel-2.6.git;a=commitdiff;h=b840228cd6096bebe16b3e4eb5d93597d0e02c6d
> 
> which turns off that particular test for all the upcalls to rpc.mountd.

The hangs persist with that patch, but go away with the change to the
cache_is_expired() logic above.

--b.

