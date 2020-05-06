Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FEF1C756C
	for <lists+linux-nfs@lfdr.de>; Wed,  6 May 2020 17:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgEFPyl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 May 2020 11:54:41 -0400
Received: from fieldses.org ([173.255.197.46]:47730 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbgEFPyl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 6 May 2020 11:54:41 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 8876B1507; Wed,  6 May 2020 11:54:40 -0400 (EDT)
Date:   Wed, 6 May 2020 11:54:40 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Shaohua Li <shli@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
Message-ID: <20200506155440.GB21307@fieldses.org>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
 <20200501182154.GG5462@mtj.thefacebook.com>
 <20200505021514.GA43625@pick.fieldses.org>
 <20200505210118.GC27966@fieldses.org>
 <20200505210956.GA3350@mtj.thefacebook.com>
 <20200505212527.GA1265@fieldses.org>
 <20200506153658.GA21307@fieldses.org>
 <20200506153920.GB3350@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506153920.GB3350@mtj.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 06, 2020 at 11:39:20AM -0400, Tejun Heo wrote:
> Hello, Bruce.
> 
> On Wed, May 06, 2020 at 11:36:58AM -0400, J. Bruce Fields wrote:
> > On Tue, May 05, 2020 at 05:25:27PM -0400, J. Bruce Fields wrote:
> > > On Tue, May 05, 2020 at 05:09:56PM -0400, Tejun Heo wrote:
> > > > It's not the end of the world but a bit hacky. I wonder whether something
> > > > like the following would work better for identifying worker type so that you
> > > > can do sth like
> > > > 
> > > >  if (kthread_fn(current) == nfsd)
> > > >         return kthread_data(current);
> > > >  else
> > > >         return NULL;     
> > > 
> > > Yes, definitely more generic, looks good to me.
> > 
> > This is what I'm testing with.
> > 
> > If it's OK with you, could I add your Signed-off-by and take it through
> > the nfsd tree? I'll have some other patches that will depend on it.
> 
> Please feel free to use the code however you see fit. Given that it'll be
> originating from you, my signed-off-by might not be the right tag. Something
> like Original-patch-by should be good (nothing is fine too).

OK, I'll do that, thanks!

--b.
