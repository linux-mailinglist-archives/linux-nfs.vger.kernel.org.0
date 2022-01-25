Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDA249B7F2
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 16:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350547AbiAYPtV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 10:49:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33970 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582332AbiAYPq4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 10:46:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E71A0B8189A;
        Tue, 25 Jan 2022 15:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF88C340E0;
        Tue, 25 Jan 2022 15:46:49 +0000 (UTC)
Date:   Tue, 25 Jan 2022 10:46:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: linux-next: runtime warning in next-20220125
Message-ID: <20220125104648.7ecce604@gandalf.local.home>
In-Reply-To: <E23F5174-F706-40FC-9072-143B04905208@oracle.com>
References: <20220125160505.068dbb52@canb.auug.org.au>
        <20220125162146.13872bdb@canb.auug.org.au>
        <20220125100138.0d19c8ca@gandalf.local.home>
        <20220125103607.2dc307e2@gandalf.local.home>
        <E23F5174-F706-40FC-9072-143B04905208@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Jan 2022 15:38:22 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> > This should fix it:
> > 
> > I'll make it a real patch and start running it through my tests.  
> 
> Should this be squashed into the patch that adds __get_sockaddr() ?
> 
> I have an updated version of that patch that applies on kernels
> that have __rel_dynamic_array.

Heh, I thought the patch was already in mainline. I just posted the fix.

Just add it to your queue. No need to squash it.

You can remove the Fixes: tag, as it may not reference the right commit.

-- Steve
