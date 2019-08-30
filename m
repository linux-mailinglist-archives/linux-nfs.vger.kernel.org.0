Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50038A3E23
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2019 21:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfH3TIF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Aug 2019 15:08:05 -0400
Received: from fieldses.org ([173.255.197.46]:51272 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfH3TIF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 30 Aug 2019 15:08:05 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id CEFA81CB4; Fri, 30 Aug 2019 15:08:04 -0400 (EDT)
Date:   Fri, 30 Aug 2019 15:08:04 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Alex Lyakas <alex@zadara.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Shyam Kaushik <shyam@zadara.com>
Subject: Re: [RFC-PATCH] nfsd: when unhashing openowners, increment
 openowner's refcount
Message-ID: <20190830190804.GB5053@fieldses.org>
References: <1566406146-7887-1-git-send-email-alex@zadara.com>
 <CAOcd+r0bXefi79dnwrwsDN1OecScfTjc8DYS5_9A8D5XKrh7QQ@mail.gmail.com>
 <20190826133951.GC22759@fieldses.org>
 <CAOcd+r059fh7J8T=6MdjPSCP39K5fpOZTsXZDUKq5TrPv_RcVQ@mail.gmail.com>
 <20190827205158.GB13198@fieldses.org>
 <CAOcd+r0Ybfr1WszjYc1K19Cf7JmKowy=Go6nc8Fexf5KxNyf=A@mail.gmail.com>
 <20190828165429.GC26284@fieldses.org>
 <CAOcd+r3e52q_ds3zjya98whYarqoXf5C2umNEX-AGp4-R6=Cuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOcd+r3e52q_ds3zjya98whYarqoXf5C2umNEX-AGp4-R6=Cuw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 29, 2019 at 09:12:49PM +0300, Alex Lyakas wrote:
> We evaluated the network namespaces approach. But, unfortunately, it
> doesn't fit easily into how our system is currently structured. We
> would have to create and configure interfaces for every namespace, and
> have a separate IP address (presumably) for every namespace.

Yes.

> All this
> seems a bit of an overkill, to just have several local filesystems
> exported to the same client (which is when we hit the issue). I would
> assume that some other users would argue as well that creating a
> separate network namespace for every local filesystem is not the way
> to go from the administration point of view.

OK, makes sense.

And I take it you don't want to go around to each client and shut things
down cleanly.  And you're fine with the client applications erroring out
when you yank their filesystem out from underneath them.

(I wonder what happens these days when that happens on a linux client
when there are dirty pages.  I think you may just end up with a useless
mount that you can't get rid of till you power down the client.)

> Regarding the failure injection code, we did not actually enable and
> use it. We instead wrote some custom code that is highly modeled after
> the failure injection code.

Sounds interesting....  I'll try to understand it and give some comments
later.
...
> Currently this code is invoked from a custom procfs entry, by
> user-space application, before unmounting the local file system.
> 
> Would moving this code into the "unlock_filesystem" infrastructure be
> acceptable?

Yes.  I'd be interested in patches.

> Since the "share_id" approach is very custom for our
> usage, what criteria would you suggest for selecting the openowners to
> be "forgotten"?

The share_id shouldn't be necessary.  I'll think about it.

--b.
