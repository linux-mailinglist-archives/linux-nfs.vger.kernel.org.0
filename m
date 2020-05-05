Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B271C4BD9
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2020 04:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEECPW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 May 2020 22:15:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51553 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726531AbgEECPW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 May 2020 22:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588644921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IZpts8zZ2x1XkemD/qL9WE6F/kUo3fXqTbXETpC992E=;
        b=LKDcUD81keIcYwcTDtWz/q2tn12Od63HNv2GmUG1MhWO6GnjQMpBEC3ovpiHhrugAae9/F
        69Gooe7Vtw4Bpdm8+ySX1ulX1vpLyvjcZRLy0ZwT0ZMdCVmFdFSTEk1a6fLzjQYgVBsP5v
        qtDGLAgkwhUVg/T0kHtp3tL19HQvPfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-aEKb66HkNFiW6VI3IyLpBA-1; Mon, 04 May 2020 22:15:19 -0400
X-MC-Unique: aEKb66HkNFiW6VI3IyLpBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A9F0460;
        Tue,  5 May 2020 02:15:18 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-118-132.rdu2.redhat.com [10.10.118.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80F6E63F94;
        Tue,  5 May 2020 02:15:15 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 6DB6F1202C0; Mon,  4 May 2020 22:15:14 -0400 (EDT)
Date:   Mon, 4 May 2020 22:15:14 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Shaohua Li <shli@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
Message-ID: <20200505021514.GA43625@pick.fieldses.org>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
 <20200501182154.GG5462@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501182154.GG5462@mtj.thefacebook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 01, 2020 at 02:21:54PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Fri, May 01, 2020 at 10:59:24AM -0700, Linus Torvalds wrote:
> > Which kind of makes me want to point a finger at Tejun. But it's been
> > mostly PeterZ touching this file lately..
> 
> Looks fine to me too. I don't quite understand the usecase tho. It looks
> like all it's being used for is to tag some kthreads as belonging to the
> same group. Can't that be done with kthread_data()?

Yeah, so I'd forgotten about kthread->data.

We're currently using it to pass the struct svc_rqst that a new nfsd
thread needs.  But once the new thread has gotten that, I guess it could
set kthread->data to some global value that it uses to say "I'm a knfsd
thread"?

I suppose that would work.

Though now I'm feeling greedy: it would be nice to have both some kind
of global flag, *and* keep kthread->data pointing to svc_rqst (as that
would give me a simpler and quicker way to figure out which client is
conflicting).  Could I take a flag bit in kthread->flags, maybe?

--b.

