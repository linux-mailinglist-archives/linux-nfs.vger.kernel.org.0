Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 121C7A07E2
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 18:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfH1Qya (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 12:54:30 -0400
Received: from fieldses.org ([173.255.197.46]:49170 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfH1Qy3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 12:54:29 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 56D14BD8; Wed, 28 Aug 2019 12:54:29 -0400 (EDT)
Date:   Wed, 28 Aug 2019 12:54:29 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Alex Lyakas <alex@zadara.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Shyam Kaushik <shyam@zadara.com>
Subject: Re: [RFC-PATCH] nfsd: when unhashing openowners, increment
 openowner's refcount
Message-ID: <20190828165429.GC26284@fieldses.org>
References: <1566406146-7887-1-git-send-email-alex@zadara.com>
 <CAOcd+r0bXefi79dnwrwsDN1OecScfTjc8DYS5_9A8D5XKrh7QQ@mail.gmail.com>
 <20190826133951.GC22759@fieldses.org>
 <CAOcd+r059fh7J8T=6MdjPSCP39K5fpOZTsXZDUKq5TrPv_RcVQ@mail.gmail.com>
 <20190827205158.GB13198@fieldses.org>
 <CAOcd+r0Ybfr1WszjYc1K19Cf7JmKowy=Go6nc8Fexf5KxNyf=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOcd+r0Ybfr1WszjYc1K19Cf7JmKowy=Go6nc8Fexf5KxNyf=A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 28, 2019 at 06:20:22PM +0300, Alex Lyakas wrote:
> On Tue, Aug 27, 2019 at 11:51 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Tue, Aug 27, 2019 at 12:05:28PM +0300, Alex Lyakas wrote:
> > > Is the described issue familiar to you?
> >
> > Yep, got it, but I haven't seen anyone try to solve it using the fault
> > injection code, that's interesting!
> >
> > There's also fs/nfsd/unlock_filesystem.  It only unlocks NLM (NFSv3)
> > locks.  But it'd probably be reasonable to teach it to get NFSv4 state
> > too (locks, opens, delegations, and layouts).
> >
> > But my feeling's always been that the cleanest way to do it is to create
> > two containers with separate net namespaces and run nfsd in both of
> > them.  You can start and stop the servers in the different containers
> > independently.
> 
> I am looking at the code, and currently nfsd creates a single
> namespace subsystem in init_nfsd. All nfs4_clients run in this
> subsystem.
> 
> So the proposal is to use register_pernet_subsys() for every
> filesystem that is exported?

No, I'm proposing any krenel changes.  Just create separate net
namespaces from userspace and start nfsd from within them.  And you'll
also need to arrange for them different nfsd's to get different exports.

In practice, the best way to do this may be using some container
management service, I'm not sure.

> I presume that current nfsd code cannot
> do this, and some rework is required to move away from a single
> subsystem to per-export subsystem. Also, grepping through kernel code,
> I see that namespace subsystems are created by different modules as
> part of module initialization, rather than doing that dynamically.
> Furthermore, in our case the same nfsd machine S can export tens or
> even hundreds of local filesystems.Is this fine to have hundreds of
> subsystems?

I haven't done it myself, but I suspect hundreds of containers should be
OK.  It may depend on available resources, of course.

> Otherwise, I understand that the current behavior is a "won't fix",
> and it is expected for the client machine to unmount the export before
> un-exporting the file system at nfsd machine. Is this correct?

You're definitely not the only ones to request this, so I'd like to have
a working solution.

My preference would be to try the namespace/container approach first.
And if that turns out no to work well for some reason, to update
fs/nfsd/unlock_filesystem to handle NFSv4 stuff.

The fault injection code isn't the right interface for this.  Even if we
did decide it was worth fixing up and maintaining--it's really only
designed for testing clients.  I'd expect distros not to build it in
their default kernels.

--b.
