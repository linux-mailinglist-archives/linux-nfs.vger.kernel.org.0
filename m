Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C931C1DD0
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgEATW2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 15:22:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29642 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726702AbgEATW1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 15:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588360947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uvr7NE+VoOzpD9fS1fNpWQ3alb4De94rrwIJLuJTDvI=;
        b=IlAU2fgFr/xFimsCTaIdPg8RMBVh/eD164bGUwoVPBKugfH1SgEX/E1VHyzOylyPmufSrP
        gDzUHyYWN+7OT2/PwXBGuCgOWDR04iG4Zfd1QCMARpYMHF/xD+eP7r5yMs5XUMOZGL7KVz
        vZaeSbQKlS57MWs6MDwYQDDdXqDc7Ds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-0yGqluTzMCaj3-bbGH5WfA-1; Fri, 01 May 2020 15:22:25 -0400
X-MC-Unique: 0yGqluTzMCaj3-bbGH5WfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E407D8014D9;
        Fri,  1 May 2020 19:22:23 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-161.phx2.redhat.com [10.3.114.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4D542B4CB;
        Fri,  1 May 2020 19:22:20 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 04C461202A6; Fri,  1 May 2020 15:22:19 -0400 (EDT)
Date:   Fri, 1 May 2020 15:22:19 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "tj@kernel.org" <tj@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jlayton@redhat.com" <jlayton@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "shli@fb.com" <shli@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "oleg@redhat.com" <oleg@redhat.com>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
Message-ID: <20200501192219.GG9191@pick.fieldses.org>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
 <20200501182154.GG5462@mtj.thefacebook.com>
 <20200501184935.GD9191@pick.fieldses.org>
 <d937c9956c0edb0d6fefb9f7dc826367015db4aa.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d937c9956c0edb0d6fefb9f7dc826367015db4aa.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 01, 2020 at 07:05:46PM +0000, Trond Myklebust wrote:
> On Fri, 2020-05-01 at 14:49 -0400, J. Bruce Fields wrote:
> > On Fri, May 01, 2020 at 02:21:54PM -0400, Tejun Heo wrote:
> > > Hello,
> > > 
> > > On Fri, May 01, 2020 at 10:59:24AM -0700, Linus Torvalds wrote:
> > > > Which kind of makes me want to point a finger at Tejun. But it's
> > > > been
> > > > mostly PeterZ touching this file lately..
> > > 
> > > Looks fine to me too. I don't quite understand the usecase tho. It
> > > looks
> > > like all it's being used for is to tag some kthreads as belonging
> > > to the
> > > same group.
> > 
> > Pretty much.
> 
> Wen running an instance of knfsd from inside a container, you want to
> be able to have the knfsd kthreads be parented to the container init
> process so that they get killed off when the container is killed.
> 
> Right now, we can easily leak those kernel threads simply by killing
> the container.

Oh, got it.

Currently knfsd supports nfs service in containers, but it uses a single
set of threads to serve requests from any container.  It should shut the
server threads down when the last container using them goes away.

--b.

