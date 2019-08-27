Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 596C49F487
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 22:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfH0Uv6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Aug 2019 16:51:58 -0400
Received: from fieldses.org ([173.255.197.46]:48176 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfH0Uv6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Aug 2019 16:51:58 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 60EA01C84; Tue, 27 Aug 2019 16:51:58 -0400 (EDT)
Date:   Tue, 27 Aug 2019 16:51:58 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Alex Lyakas <alex@zadara.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Shyam Kaushik <shyam@zadara.com>
Subject: Re: [RFC-PATCH] nfsd: when unhashing openowners, increment
 openowner's refcount
Message-ID: <20190827205158.GB13198@fieldses.org>
References: <1566406146-7887-1-git-send-email-alex@zadara.com>
 <CAOcd+r0bXefi79dnwrwsDN1OecScfTjc8DYS5_9A8D5XKrh7QQ@mail.gmail.com>
 <20190826133951.GC22759@fieldses.org>
 <CAOcd+r059fh7J8T=6MdjPSCP39K5fpOZTsXZDUKq5TrPv_RcVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOcd+r059fh7J8T=6MdjPSCP39K5fpOZTsXZDUKq5TrPv_RcVQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 27, 2019 at 12:05:28PM +0300, Alex Lyakas wrote:
> Is the described issue familiar to you?

Yep, got it, but I haven't seen anyone try to solve it using the fault
injection code, that's interesting!

There's also fs/nfsd/unlock_filesystem.  It only unlocks NLM (NFSv3)
locks.  But it'd probably be reasonable to teach it to get NFSv4 state
too (locks, opens, delegations, and layouts).

But my feeling's always been that the cleanest way to do it is to create
two containers with separate net namespaces and run nfsd in both of
them.  You can start and stop the servers in the different containers
independently.

> It is very easily reproducible. What is the way to solve it? To our
> understanding, if we un-export a FS from nfsd, we should be able to
> unmount it.

Unexporting has never removed locks or opens or other state, for what
it's worth.

--b.
