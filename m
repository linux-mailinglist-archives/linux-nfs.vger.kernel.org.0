Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17561C1D85
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 21:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbgEATCd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 15:02:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47151 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729766AbgEATCd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 15:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588359752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jek6f1FrZy1FOjnEBD+3htgOWCPMzgLS9uHoe5URBjs=;
        b=hL1KTYBVPAK7yBBqk6ZJYKqytNYGAmsmJROy6ndg9C5mp9esANedmz0cj8Mr4Bzbh4kBwa
        dofabrozqC4FYxENVHru7MQstVNZLuQRWA1nctmcDSWwoKanlR1eGwR/IJnB7qZae37yTW
        NqS5ff8fvSiTrq0LLO/duU0RefvNoN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-PJVo74boNAOibribiK5KtQ-1; Fri, 01 May 2020 15:02:28 -0400
X-MC-Unique: PJVo74boNAOibribiK5KtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83029107ACF4;
        Fri,  1 May 2020 19:02:27 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-161.phx2.redhat.com [10.3.114.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6F0438A;
        Fri,  1 May 2020 19:02:24 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id B9B2A1202A6; Fri,  1 May 2020 15:02:23 -0400 (EDT)
Date:   Fri, 1 May 2020 15:02:23 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Shaohua Li <shli@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
Message-ID: <20200501190223.GF9191@pick.fieldses.org>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
 <20200501182154.GG5462@mtj.thefacebook.com>
 <CAHk-=wgB=PDdMX=uwsSrcERgSyyNW83Hj=WTWWjKp9dyriEzVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgB=PDdMX=uwsSrcERgSyyNW83Hj=WTWWjKp9dyriEzVQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 01, 2020 at 11:30:38AM -0700, Linus Torvalds wrote:
> On Fri, May 1, 2020 at 11:22 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > Looks fine to me too. I don't quite understand the usecase tho. It looks
> > like all it's being used for is to tag some kthreads as belonging to the
> > same group. Can't that be done with kthread_data()?
> 
> I _think_ Bruce wants the signal handling unification too, because
> nfsd wants to react to being shut down with signals.

No, maybe kthread_data() might do the job.

(I don't see how this would help with signal handling.  But, I'm kind of
ignorant of how signalling works.)

--b.

