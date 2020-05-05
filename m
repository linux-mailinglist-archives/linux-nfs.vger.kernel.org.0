Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057771C5D65
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2020 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgEEQXy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 May 2020 12:23:54 -0400
Received: from fieldses.org ([173.255.197.46]:46768 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbgEEQXy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 May 2020 12:23:54 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id E8E7A5A30; Tue,  5 May 2020 12:23:53 -0400 (EDT)
Date:   Tue, 5 May 2020 12:23:53 -0400
To:     Tejun Heo <tj@kernel.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Shaohua Li <shli@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
Message-ID: <20200505162353.GA27966@fieldses.org>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
 <20200501182154.GG5462@mtj.thefacebook.com>
 <20200505021514.GA43625@pick.fieldses.org>
 <20200505155405.GD12217@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505155405.GD12217@mtj.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 05, 2020 at 11:54:05AM -0400, Tejun Heo wrote:
> Hello, Bruce.
> 
> On Mon, May 04, 2020 at 10:15:14PM -0400, J. Bruce Fields wrote:
> > We're currently using it to pass the struct svc_rqst that a new nfsd
> > thread needs.  But once the new thread has gotten that, I guess it could
> > set kthread->data to some global value that it uses to say "I'm a knfsd
> > thread"?
> > 
> > I suppose that would work.
> > 
> > Though now I'm feeling greedy: it would be nice to have both some kind
> > of global flag, *and* keep kthread->data pointing to svc_rqst (as that
> > would give me a simpler and quicker way to figure out which client is
> > conflicting).  Could I take a flag bit in kthread->flags, maybe?
> 
> Hmm... that'd be solvable if kthread->data can point to a struct which does
> both things, right?

Isn't this some sort of chicken-and-egg problem?

If you don't know whether a given kthread is an nfsd thread or not, then
it's not safe to assume that kthread->data points to some nfsd-specific
structure that might tell you whether it's an nfsd thread.

> Because it doesn't have free() callback, it's a bit
> awkward but the threadfn itself can unlink and RCU-free it before returning.

It's only ever going to be referenced from the thread itself.  This is
just a way to ask "am I running as an nfsd thread?" when we're deep
inside generic filesystem code somewhere.  So I don't think there's any
complicated lifetime issues here.

--b.
