Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940F5474870
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Dec 2021 17:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhLNQpI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Dec 2021 11:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhLNQpI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Dec 2021 11:45:08 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3154AC061574
        for <linux-nfs@vger.kernel.org>; Tue, 14 Dec 2021 08:45:08 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 49A3B7044; Tue, 14 Dec 2021 11:45:07 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 49A3B7044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1639500307;
        bh=xMJXLUNrHahHP6npUH9TYCrZE4zTP8DhFEYS/FJRScw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9bLrh9A0tcXgZlIRF7EQUm3aHLrIj51khCHOtD5db2h0VhoikAbvs9MV4rY8eJjn
         955kSHKnYZ4uJo5AfItC63pJW7U/w05iWsC8ZC+x4oYb/yS0M92M8UIasbhxSYXAnj
         pHooQp4WSPSWtTgR9tABEVV76wmPu91DJ1V4v6+Q=
Date:   Tue, 14 Dec 2021 11:45:07 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [bug report] nfs clients fail to get read delegations after file
 open with O_RDWR
Message-ID: <20211214164507.GC12078@fieldses.org>
References: <OS3PR01MB7705959736BA3A5BDF9C0AFD89749@OS3PR01MB7705.jpnprd01.prod.outlook.com>
 <20211213215550.GA2230@fieldses.org>
 <OS3PR01MB770504D572DE88FD1E51BD3689759@OS3PR01MB7705.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB770504D572DE88FD1E51BD3689759@OS3PR01MB7705.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 14, 2021 at 12:50:53AM +0000, suy.fnst@fujitsu.com wrote:
> Thanks for your quick reply!
> 
> >>Without looking at this case in detail:
> 
> >>Delegations are granted at the server's discretion, so this certainly
> >>isn't a bug.
> 
> Got it.
> 
> >>It might be suboptimal behavior.  If there's evidence that this causes
> >>significant regressions on some important workload, then we'd want to
> >>look into fixing it.
> 
> If I understand the case correctly, the most common workload it influences like:
> 
> One nfs client opens a file with flag O_WRONLY/O_RDWR, close it.
> Then some nfs clients open the file with O_RDONLY right now then it will prevent
> server to give any delegation to other clients.  It may cause many unnecessary
> requests from clients because lack of delegations.

Right.

For the moment, this is something I'd accept patches for, but I'm not
actively working on.

I think it's been suggested that we could even turn off the file cache
completely in the v4 case, since in that case we don't have to re-open
on every IO.

--b.
