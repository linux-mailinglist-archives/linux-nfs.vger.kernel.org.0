Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2BC07574C
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jul 2019 20:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfGYSyW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jul 2019 14:54:22 -0400
Received: from fieldses.org ([173.255.197.46]:36312 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfGYSyV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 25 Jul 2019 14:54:21 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 7575D6D9; Thu, 25 Jul 2019 14:54:21 -0400 (EDT)
Date:   Thu, 25 Jul 2019 14:54:21 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     NeilBrown <neilb@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RFC: Fixing net/sunrpc/cache.c: cache_listeners_exist() function
 for rogue process reading a 'channel' file
Message-ID: <20190725185421.GA15073@fieldses.org>
References: <22770aa2024c1dab1b7eaded1eed9957963413fb.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22770aa2024c1dab1b7eaded1eed9957963413fb.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 25, 2019 at 12:48:31PM -0400, Dave Wysochanski wrote:
> Neil, Bruce, and others,
> 
> I want to see if we can improve cache_listeners_exist() to not be
> fooled at all by a random process reading a 'channel' file.  Prior
> attempts have been made and Neil your most recent commit mitigated the
> effects however doesn't really solve it completely:
> 9d69338c8c5f "sunrpc/cache: handle missing listeners better"
> 
> Here are a couple approaches, based on my understanding of the
> interface and what any legitimate "user of the channel files" (aka
> daemons or userspace programs, most if not all live in nfs-utils) do in
> practice:
> 1) rather than tracking opens for read, track opens for write on the
> channel file (i.e. the 'readers' member in cache_detail)

Assuming we've checked that none of those random processes are opening
for write, that sounds reasonable to me.

> 2) in addition to or in place of #1, track calls to cache_poll()

I'm not sure how this would work.  What exactly would be the rule, and
how would we document the required behavior for somebody working on the
userland (rpc.mountd) side?

> Because this keeps coming up in one shape or form and is hard to
> troubleshoot when it occurs, I think we should fix this once and for
> all so I'm looking for feedback on approaches.  I thought of going down
> the road of a more elaborate daemon / kernel registration but that
> would require carefully making sure we have backward compatibility when
> variants of nfs-utils and kernel are installed.

It might be worth at least sketching out a design to get an idea how
complicated it would be.  Agreed that backwards compatibility would be
the annoying part.

--b.
