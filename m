Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E422FC34D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jan 2021 23:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbhASWXX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jan 2021 17:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbhASWXN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jan 2021 17:23:13 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9044C061573
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jan 2021 14:22:30 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7D90335BD; Tue, 19 Jan 2021 17:22:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7D90335BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611094949;
        bh=OR9jxnQ0Na61hAs7ATavLwJGoqs6xli+7GK/oKJgE8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BLVhjxN8BNBgmvjAbMLKB/33yUOg41PLMJq9NlfTDobRZGRqbCjDWgnTpKXLz1AuK
         ln3LRnlYDdrtL4yncLsRjagE1EXk6dbmm+WRfmsmhM+n1NQkiqxhwzko1o9KlX0J1f
         Kl5aq8chkfQdPipMGnLvb58ycWnJ97kpWBwgAzFo=
Date:   Tue, 19 Jan 2021 17:22:29 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        Jacob Shivers <jshivers@redhat.com>,
        Frank Sorenson <fsorenso@redhat.com>
Subject: Re: unsharing tcp connections from different NFS mounts
Message-ID: <20210119222229.GA29488@fieldses.org>
References: <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
 <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
 <20201007001814.GA5138@fieldses.org>
 <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
 <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
 <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
 <20201007140502.GC23452@fieldses.org>
 <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
 <20201007160556.GE23452@fieldses.org>
 <e06c31e4211cefda52091c7710d871f44dc9160e.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e06c31e4211cefda52091c7710d871f44dc9160e.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 07, 2020 at 04:50:26PM +0000, Trond Myklebust wrote:
> As far as I can tell, this thread started with a complaint that
> performance suffers when we don't allow setups that hack the client by
> pretending that a multi-homed server is actually multiple different
> servers.
> 
> AFAICS Tom Talpey's question is the relevant one. Why is there a
> performance regression being seen by these setups when they share the
> same connection? Is it really the connection, or is it the fact that
> they all share the same fixed-slot session?
> 
> I did see Igor's claim that there is a QoS issue (which afaics would
> also affect NFSv3), but why do I care about QoS as a per-mountpoint
> feature?

Sorry for being slow to get back to this.

Some more details:

Say an NFS server exports /data1 and /data2.

A client mounts both.  Process 'large' starts creating 10G+ files in
/data1, queuing up a lot of nfs WRITE rpc_tasks.

Process 'small' creates a lot of small files in /data2, which requires a
lot of synchronous rpc_tasks, each of which wait in line with the large
WRITE tasks.

The 'small' process makes painfully slow progress.

The customer previously made things work for them by mounting two
different server IP addresses, so the "small" and "large" processes
effectively end up with their own queues.

Frank Sorenson has a test showing the difference; see

	https://bugzilla.redhat.com/show_bug.cgi?id=1703850#c42
	https://bugzilla.redhat.com/show_bug.cgi?id=1703850#c43

In that test, the "small" process creates files at a rate thousands of
times slower when the "large" process is also running.

Any suggestions?

--b.
