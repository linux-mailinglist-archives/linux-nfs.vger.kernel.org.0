Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F0F285271
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 21:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgJFTap (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 15:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgJFTap (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 15:30:45 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE6AC061755
        for <linux-nfs@vger.kernel.org>; Tue,  6 Oct 2020 12:30:45 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5819D69C3; Tue,  6 Oct 2020 15:30:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5819D69C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602012644;
        bh=Le0ZSpkW43lwupOkoL3VYytnF99fpVA9Sp/y0Ld+Aqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pl8r81DeDSIrgUsKUo6G6+gNDeFgyv5L3a4kDo30j4y+2G+yICIOduPmwPRafTxbs
         z1reax+yoxSLT+nVoPn/u+LpEaB9bTMHPUVTf0tHWeeocR3L+9ZwqCxckInSmGcfvk
         kGXhy6D4LM7c60VYHeamKCt9jSTEACy7hpa1nnCs=
Date:   Tue, 6 Oct 2020 15:30:44 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Tom Talpey <tom@talpey.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: unsharing tcp connections from different NFS mounts
Message-ID: <20201006193044.GC32640@fieldses.org>
References: <20201006151335.GB28306@fieldses.org>
 <43CA4047-F058-4339-AD64-29453AE215D6@oracle.com>
 <20201006152223.GD28306@fieldses.org>
 <bb58e43a-f23d-d5f5-ac53-9230267f7faa@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb58e43a-f23d-d5f5-ac53-9230267f7faa@talpey.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 06, 2020 at 01:07:11PM -0400, Tom Talpey wrote:
> On 10/6/2020 11:22 AM, Bruce Fields wrote:
> >On Tue, Oct 06, 2020 at 11:20:41AM -0400, Chuck Lever wrote:
> >>
> >>
> >>>On Oct 6, 2020, at 11:13 AM, bfields@fieldses.org wrote:
> >>>
> >>>NFSv4.1+ differs from earlier versions in that it always performs
> >>>trunking discovery that results in mounts to the same server sharing a
> >>>TCP connection.
> >>>
> >>>It turns out this results in performance regressions for some users;
> >>>apparently the workload on one mount interferes with performance of
> >>>another mount, and they were previously able to work around the problem
> >>>by using different server IP addresses for the different mounts.
> >>>
> >>>Am I overlooking some hack that would reenable the previous behavior?
> >>>Or would people be averse to an "-o noshareconn" option?
> >>
> >>I thought this was what the nconnect mount option was for.
> >
> >I've suggested that.  It doesn't isolate the two mounts from each other
> >in the same way, but I can imagine it might make it less likely that a
> >user on one mount will block a user on another?  I don't know, it might
> >depend on the details of their workload and a certain amount of luck.
> 
> Wouldn't it be better to fully understand the reason for the
> performance difference, before changing the mount API? If it's
> a guess, it'll come back to haunt the code for years.
> 
> For example, maybe it's lock contention in the xprt transport code,
> or in the socket stack.

Yeah, I wonder too, and I don't have the details.

--b.
