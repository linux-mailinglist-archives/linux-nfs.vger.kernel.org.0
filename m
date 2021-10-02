Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BFE41FE0F
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Oct 2021 22:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhJBUkK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 2 Oct 2021 16:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJBUkK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 2 Oct 2021 16:40:10 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2078AC061714
        for <linux-nfs@vger.kernel.org>; Sat,  2 Oct 2021 13:38:24 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 16CE86C0C; Sat,  2 Oct 2021 16:38:23 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 16CE86C0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633207103;
        bh=Ct+gvNc5NZbmIUU7egKb4KZT1aW4wHdRL8SdU4Csdhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ouCgJ1VhvxzXpoqFPRqPPy53Q8fdv+5MLHCK4R+hdpyu+f4pwqIm/P2Y/NM/yueQ8
         tCJV7wun6a2R0oXl+OKsYiXm7b8NhVaitWQ2wF/J0B1JZuTe2WuZsBhReUcOJA6HH4
         4+n5aRVKPPCHwUfywH5yTshzqkMxUFg4/mBv6+2k=
Date:   Sat, 2 Oct 2021 16:38:23 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Volodymyr Khomenko <volodymyr@vastdata.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: GSSAPI fix for pynfs nfs4.1 client code
Message-ID: <20211002203823.GC26608@fieldses.org>
References: <CANkgwetkTUjj-bMrM4XTvk0vhGiJt3wNKPpRvzgTk-u7ZfrdXg@mail.gmail.com>
 <20210930211123.GA16927@fieldses.org>
 <CANkgweuuo7VctNLNSGyVE2Unjv_RMdG7+zPYr6_QwSZAQTbPRQ@mail.gmail.com>
 <20211001141306.GD959@fieldses.org>
 <CANkgwevJURTVNcs8u3KS_jiZwxQZgGHX=YmU+kvbweQ0PLBHiA@mail.gmail.com>
 <20211001154821.GE959@fieldses.org>
 <CANkgwetH1jzxYcUp5+7AnhE_S8iQBnrG76hrKsUsXUAsUqYNJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANkgwetH1jzxYcUp5+7AnhE_S8iQBnrG76hrKsUsXUAsUqYNJA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Oct 02, 2021 at 09:12:25AM +0300, Volodymyr Khomenko wrote:
> P.S. Since the very 1st operation after NFS4 NULL is EXCHANGE_ID - it
> should be only single operation
> (client can't send few ECHANGE_ID because clientowner is only one per
> mount) and next CREATE_SESSION can't be sent
> until EXCHANGE_ID is replied from the server.
> So the use-case of 'any of the first 128 rpcs were out of order' is
> just a theoretical one and probably not possible in practice.

So our server uses a fixed-size gss sequence number window of 128.  We
keep track of sd_max, the largest sequence number we've seen so far.
Given an incoming rpc with sequence number seqno, we check:

	is seqno > sd_max?
		This is the normal case for in-order sequence numbers;
		update sd_max and our other sequence number data and
		continue normal processing.
	else is seqno < sd_max - 128?
		Oops, this is definitely too old; drop the request.
	else check our data about sequence numbers seen so far.

But our specific bug was we were doing the second check using unsigned
arithmetic, so if we hit the second check before sd_max hits 128, then
(sd_max - 128) is something very large, and we drop the request.

--b.
