Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5901292D5D
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Oct 2020 20:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgJSSOK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Oct 2020 14:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgJSSOK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Oct 2020 14:14:10 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7993FC0613CE
        for <linux-nfs@vger.kernel.org>; Mon, 19 Oct 2020 11:14:10 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C3FC51C81; Mon, 19 Oct 2020 14:14:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C3FC51C81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1603131249;
        bh=J2Pg4v3YujRV0+vcUFsbBn6pmz8QBx7YSQ0y+qBWPN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpudqVKg5iSYgcrppXf4NZOTx5ppoBG/oUDz9uM4K5A7A6XuQ3vzw2Ai35NCDWhKQ
         9bJG63i/VTvpZPd+bag4aeSnSwlyQStuLr46FhEsWicKWWUX581cKChVO1TRN7Ew9E
         3+2ZrbltvC/ceR53fhCle3voYKX/vDf+OhuqJi44=
Date:   Mon, 19 Oct 2020 14:14:09 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Guy Keren <guy@vastdata.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: questions about the linux NFS 4.1 client and persistent sessions
Message-ID: <20201019181409.GB6692@fieldses.org>
References: <02b2121f-42d1-2587-6705-ca2aadb521bc@vastdata.com>
 <20201014192659.GA23262@fieldses.org>
 <CAENext5RMsQXJtV-H63Ons5rovKfk0-oXW-MgBCkZi+DvRDJcQ@mail.gmail.com>
 <20201017211403.GC8644@fieldses.org>
 <CAENext6Roxg6aOh8hWC8+SK8jKpZ55AGiTSx0W5maRd5QHLxLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAENext6Roxg6aOh8hWC8+SK8jKpZ55AGiTSx0W5maRd5QHLxLg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Oct 18, 2020 at 02:18:55PM +0300, Guy Keren wrote:
> so suppose that the client sent two 'Open' requests in one compound.
> the server finished processing the first, but then had a delegation on
> the 2nd one, so it is supposed to return an NFS4_OK to the first Open
> and a NFSERR_DELAY for the 2nd open (and this is also the compound
> response that the server will store in its Duplicate Request Cache).
> if the server had a temporary network disconnection, or had a server
> restart, then when the client re-connects and re-sends this compound
> request, it receives the response from the server's Duplicate Request
> Cache (with OK for the first open and DELA?Y For the 2nd). than, i
> presume that the client needs to accept that the first Open already
> succeeded, and when creating a new session, re-send only the 2nd Open
> request. does this make sense?

Sounds right.

> > I don't know of any client that actually does that, for what it's worth.
> > The Linux client, for example, doesn't send any compounds that I can
> > think of that have more than one nonidempotent op.
> 
> does it mean that the linux NFS 4.1 client will also never send two
> Write requests in the same compound? and never send an Open request
> which might create a file, with a Write request in the same compound?

"Will never" might be a little strong--maybe there'll be a reason to do
it some day.  A server should be prepared to handle it.  But the client
doesn't currently do either of those things.

--b.
