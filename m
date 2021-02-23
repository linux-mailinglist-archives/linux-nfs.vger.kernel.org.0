Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DEA323415
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 00:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhBWXBy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Feb 2021 18:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhBWXAY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Feb 2021 18:00:24 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D5AC061786
        for <linux-nfs@vger.kernel.org>; Tue, 23 Feb 2021 14:59:18 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 97D642824; Tue, 23 Feb 2021 17:59:18 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 97D642824
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614121158;
        bh=EzOyWJsUUHLB8/jY+JwuMcL9ppreXa21tTxcwwKMCj0=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=vpzzw115zRa466eoY0W9AtSRPBD3iUvpwg+/l4SPh70boDEKE28FurqPXRt2oTSKf
         LS4wdx1rN2tVZFStaDk9HiL09dXwIXR+uZaxb2a52NfPq0dILOsbl4WuyRopH6qraQ
         z1hxNLdmaok0lDLBY2R34bPX3CdQu9KJ0ETPIjBQ=
Date:   Tue, 23 Feb 2021 17:59:18 -0500
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Rue Mohr <sn0297@sunshine.net>, linux-nfs@vger.kernel.org
Subject: Re: nfs kernel server bug
Message-ID: <20210223225918.GE8042@fieldses.org>
References: <602020C9.50705@sunshine.net>
 <5B1E0F4D-F26F-4CB5-858A-E49D0819C864@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B1E0F4D-F26F-4CB5-858A-E49D0819C864@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Feb 08, 2021 at 06:58:38AM -0500, Benjamin Coddington wrote:
> On 7 Feb 2021, at 12:18, Rue Mohr wrote:
> 
> >I'm having an issue where the kernel server is dishing out all
> >zeros for file content being read over NFS. The file byte count is
> >correct.
> >Writing files is fine.
> >With the same client, a different server works just fine.
> >
> >I have been trying to pin this down, so far all I know is that the
> >packets from the server actually contain zeros for the file
> >contents.
> >
> >The troubled server kernel is 5.4.1
> >
> >Has anyone encountered this or is it just me?
> 
> Haven't heard of this before, but sounds like a fascinating problem.
> 
> What version of nfs, and what security?  You're seeing READ
> operations returning
> with rsize-ed blocks of all-zero data in a network capture?

It might also be useful to know what filesystem you're exporting, with
what mount and export options.

--b.
