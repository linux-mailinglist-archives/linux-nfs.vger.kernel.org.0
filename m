Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A466635F587
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349056AbhDNNuC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351787AbhDNNt7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 09:49:59 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A65C061574
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 06:49:37 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CAB726D1D; Wed, 14 Apr 2021 09:49:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CAB726D1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1618408175;
        bh=9b5IHYu3hyGan4zEgnK5XEVTCV2JloHR8pbU8fsXx8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zFGFEhPG1SglDFw5jItAX8rNBkrpNDwJ4CcvaLub+Z41T6CCY7k/CIADHueCVYxv5
         20o2A4sW4ubkKvywRzCNMJn6pi8XZ69xams+vZ05G5Xjqh3T4N6rmVZRaviKV7aa2k
         cNr7DHZ1s0oLke5h5zI8tjtMevIN5WXQo2UYfp6Y=
Date:   Wed, 14 Apr 2021 09:49:35 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: generic/430 COPY/delegation caching regression
Message-ID: <20210414134935.GA16800@fieldses.org>
References: <20210413231958.GB31058@fieldses.org>
 <0A9B34DB-56CF-4F22-8A8E-F6CA3176144D@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0A9B34DB-56CF-4F22-8A8E-F6CA3176144D@netapp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 14, 2021 at 03:30:19AM +0000, Kornievskaia, Olga wrote:
> ﻿On 4/13/21, 7:20 PM, "J. Bruce Fields" <bfields@fieldses.org> wrote:
>     generic/430 started failing in 4.12-rc3, as of 7c1d1dcc24b3 "nfsd: grant
>     read delegations to clients holding writes".
> 
>     Looks like that reintroduced the problem fixed by 16abd2a0c124 "NFSv4.2:
>     fix client's attribute cache management for copy_file_range": the client
>     needs to invalidate its cache of the destination of a copy even when it
>     holds a delegation.
> 
> [olga] I'm confused what client version are you testing and against what server? I haven't seen generic/430 failing while testing upstream versions against upstream server verions. What should I try (as in what client version against what server version) to reproduce the failure?

You can reproduce it with client and server both on rc3.

(In more detail: you need a client with 7c1d1dcc24b3, but a server that
doesn't yet have 6ee65a773096 "Revert "nfsd4: a client's own opens
needn't prevent delegation"".

I have a patch that will restore the server's ability to grant
delegations to clients with write opens, but this regression was one of
the problems I ran across in testing....)

--b.
