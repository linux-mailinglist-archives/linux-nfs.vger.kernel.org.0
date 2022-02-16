Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3C14B9119
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Feb 2022 20:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiBPTWd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Feb 2022 14:22:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiBPTWa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Feb 2022 14:22:30 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82CE24F1A
        for <linux-nfs@vger.kernel.org>; Wed, 16 Feb 2022 11:22:16 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id BD8CE6CD5; Wed, 16 Feb 2022 14:22:15 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BD8CE6CD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1645039335;
        bh=+84qCiDFIAKwdzWF/m9U2KjRUazhunK359ZX+y8pQwU=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=aJ6R0daAr3D/z0NfNtEmhxusRUKvaJLTMxfzVDI0Zz+KfMna3QW+oCs4Sp743WzT7
         Fiux3QpstNxuFYNEimIg1DaASk2M4+b346R9DtIZ6UJoi+2/PvMiPxT8hOsRLcJTKl
         QX6X45TmvloOBRYKq9B+39sq9tUN9Jk3pgMEHRd0=
Date:   Wed, 16 Feb 2022 14:22:15 -0500
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: How are client requests load balanced across multiple nfsd
 processes?
Message-ID: <20220216192215.GB29074@fieldses.org>
References: <19e14932-ed88-60a1-844a-0e17deee269d@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e14932-ed88-60a1-844a-0e17deee269d@math.utexas.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 15, 2022 at 04:13:25PM -0600, Patrick Goetz wrote:
> When I set
> 
>   RPCNFSDCOUNT=16
> 
> what I thought this did was spin up an nfsd thread master with 15
> threads and the thread master would pass out client requests to the
> threads, but looking at /proc/$PID/status -> TGID clearly indicates
> these are all entirely separate processes. (I wasn't sure if ps
> showed threads as separate processes; apparently it doesn't.)

They're all kernel tasks, which makes the distinction between "thread"
and "process" a little vague.

> So the question is how do different client requests get farmed out
> to different nfsd daemons for service? Who's actually listening on
> port 2049?

There's no user process that calls "listen"; knfsd's normal rpc handling
is all in-kernel.  Incoming rpc's may be handed to any of those 16 tasks
for processing.  A single task just runs a loop where it receives an
rpc, handles it, and sends a response back.

> This was all prompted by some vendor trying to sell me an EC
> (Erasure Coding) n+m system who commented "NFS isn't multi-threaded,
> NFS can only communicate with one server, for a shared/mounted
> filesystem, so it will always be limited to the speed of that NFS
> Server. POSIX/Multi-threaded means the filesystem is parallel and
> can be reading/writing to multiple nodes at once in a storage
> cluster/setup. The opposite of NFS."

That explanation is a little muddled.  NFS clients and servers both
typically have lots of parallelism.  Whether it's sufficient for your
purposes depends on exactly what you need.

But, yes, they're mostly correct to say that, in the absence of pNFS,
"NFS can only communicate with one server, for a shared/mounted
filesystem, so it will always be limited to the speed of that NFS
Server".

> I think pNFS addresses this, but then how does one implement pNFS?

So, right, pNFS can let you perform IO to multiple servers
simultaneously, if that's what you need.

The Linux NFS client has support for pNFS, but the kernel server
doesn't, so you'd need to look elsewhere for a pNFS server.

Whether any of this is useful to you depends on exactly what problem
you're trying to solve.

--b.
