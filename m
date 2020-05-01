Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8431C1D63
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 20:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgEASto (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 14:49:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39733 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729721AbgEAStn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 14:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588358982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UWBw6vpYtZb0E4Qraw0yWbVU2/WZXleDlQcMtBsJSWY=;
        b=SB0oRYCk6LQGoFHQ56Z1ZAe7qLw+DHJ8XxLIB7Z+th2LYE+dJsekT3yffvkjyCeEZQzoSe
        78fKbTAqYmNnG6LTrpnYXEt37f2PnpGDaudUGgbbCyZoI/EYOF/IxxAva1UPLvn+mgOksd
        Eg02el6WGj+tXjMSeAf93hoEPRKbNa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-Y0Qb86jFM8G7mChzPLlpow-1; Fri, 01 May 2020 14:49:40 -0400
X-MC-Unique: Y0Qb86jFM8G7mChzPLlpow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7107045F;
        Fri,  1 May 2020 18:49:39 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-161.phx2.redhat.com [10.3.114.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B227B6084A;
        Fri,  1 May 2020 18:49:36 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id BDE851202A6; Fri,  1 May 2020 14:49:35 -0400 (EDT)
Date:   Fri, 1 May 2020 14:49:35 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Shaohua Li <shli@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
Message-ID: <20200501184935.GD9191@pick.fieldses.org>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
 <20200501182154.GG5462@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501182154.GG5462@mtj.thefacebook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
> same group.

Pretty much.

> Can't that be done with kthread_data()?

Huh, maybe so, thanks.

I need to check this from generic file locking code that could be run by
any task--but I assume there's an easy way I can check if I'm a kthread
before calling  kthread_data(current).

I do expect to expose a delegation interface for userspace servers
eventually too.  But we could do the tgid check for them and still use
kthread_data() for nfsd.  That might work.

--b.

