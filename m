Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3622132F5EC
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Mar 2021 23:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCEWcA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Mar 2021 17:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhCEWbm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Mar 2021 17:31:42 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85296C06175F
        for <linux-nfs@vger.kernel.org>; Fri,  5 Mar 2021 14:31:42 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 717D125FE; Fri,  5 Mar 2021 17:31:41 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 717D125FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614983501;
        bh=sH6z8qIu3yEmi//4fiqAw9bIiuJBOXiqL0KEvwTgvPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LR0V4inc0W3QXs4r2KzPL9rXCpJH/UdPLe6JBKE6VLTu1ja1EKnc++i9vQuTpkUQf
         /zRkUXmP1zS8oRU/fNxuh+5diGQkZ+yigUmghVfv6lot3OxDDeDOW/U4HrW7PC+Ypk
         stHu2KwYIyr5smyBny7PdW/H+UdC9erSlj585kjI=
Date:   Fri, 5 Mar 2021 17:31:41 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Timo Rothenpieler <timo@rothenpieler.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSD Regression: client observing a file while other client
 writes to it leads to stale local cache
Message-ID: <20210305223141.GD3813@fieldses.org>
References: <c3efd7e8-dc08-ac1f-9bee-7a7b0d8ac5fb@rothenpieler.org>
 <20210301184633.GA14881@fieldses.org>
 <86ef3b71-bcb4-767c-40a0-461d082f5d44@rothenpieler.org>
 <20210302010629.GB16303@fieldses.org>
 <2d4e7965-903f-2319-d2d2-65116f50400c@rothenpieler.org>
 <20210304144228.GD17512@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304144228.GD17512@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 04, 2021 at 09:42:28AM -0500, J. Bruce Fields wrote:
> On Tue, Mar 02, 2021 at 02:23:05AM +0100, Timo Rothenpieler wrote:
> > Server and reading client disagreeing about the files size and
> > contents is 100% reproducible, even after the writing client has
> > long and definitely closed the file.
> 
> OK, I reproduced this myself and watched the network traffic in
> Wireshark.
> 
> The server is *not* giving out a read delegation to the writer (which is
> what the commit you bisected to should have allowed).  It *is* giving
> out a delegation to the reader.  Which is a truly awful bug.
> Investigating....

Yeah, it's completely failing to provide close-to-open cache consistency
there in most cases.  Arghh.

I have some idea how to fix it, but for now it should just be reverted.
I'll post that pending some testing.

I've also added a pynfs test for this case (4.1 test DELEG9).  We should
probably have some more.

So, thanks for the report.

I'd still be a little cautious about your use--NFS can't give you a lot
of guarantees when you've got a file open for read and write
simultaneously.  The writing client can delay those writes at least
until the writing application closes, and the reading isn't necessarily
going to revalidate its cache until it the reading application closes
and reopens.  And weirder behavior is possible: for exapmle when the
writer does write back, I don't think there's any guarantee it will
write in order, so you could end up temporarily with NULLs in the
middle.

But that particular regression was my fault, thanks again for bisecting
and reporting.

--b.
