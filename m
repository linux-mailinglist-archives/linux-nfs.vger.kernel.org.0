Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94A041F176
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 17:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhJAPuH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 11:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhJAPuH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Oct 2021 11:50:07 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747EEC061775
        for <linux-nfs@vger.kernel.org>; Fri,  1 Oct 2021 08:48:22 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 95F1D7032; Fri,  1 Oct 2021 11:48:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 95F1D7032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633103301;
        bh=9EabvdPsIGIeCFfHBd1HOCnZc4u65s4IBb2oHyWeDKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VY5UjANJ/bC6n52yI9+KcJJc/LNDFGt/Ij4XPjjlvSitmvZAo7dPdvAbx05bSVgEl
         1gaYFFi58z12RNnw6woXvepRVXr+I9GbpwAVjyYDh+pGeqqyT4ZhMgmixwSmF+zonH
         r8aGW8h29ZIsUEY+2u6Pwc0PIWaFN5ziDP+mejII=
Date:   Fri, 1 Oct 2021 11:48:21 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Volodymyr Khomenko <volodymyr@vastdata.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: GSSAPI fix for pynfs nfs4.1 client code
Message-ID: <20211001154821.GE959@fieldses.org>
References: <CANkgwetkTUjj-bMrM4XTvk0vhGiJt3wNKPpRvzgTk-u7ZfrdXg@mail.gmail.com>
 <20210930211123.GA16927@fieldses.org>
 <CANkgweuuo7VctNLNSGyVE2Unjv_RMdG7+zPYr6_QwSZAQTbPRQ@mail.gmail.com>
 <20211001141306.GD959@fieldses.org>
 <CANkgwevJURTVNcs8u3KS_jiZwxQZgGHX=YmU+kvbweQ0PLBHiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANkgwevJURTVNcs8u3KS_jiZwxQZgGHX=YmU+kvbweQ0PLBHiA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 01, 2021 at 05:38:45PM +0300, Volodymyr Khomenko wrote:
> > The seq_num field can start at any value below MAXSEQ
> Yes, that's the statement I haven't found before in RFC...
> Probably we also need to write a test starting the seq_num from a big
> value (more than SEQUENCE_WINDOW)
> to make sure that it is really implemented properly without
> 'is_inited' flag (so what's the initial value?).
> 
> However I still propose to keep the default behaviour of pynfs to be
> the same as for linux NFS4 client.
> I think the caller can change it when needed (to 0 or whatever
> needed), but the default value should be good...

That's what I'd choose if I were writing a "real" client.  Everybody
already tests with the Linux client, so its behavior is a safe bet.

But I'd usually prefer a test client do different things than the client
everyone already tests with.

Like I say, the seqid=0 already caught a bug in my server, so I'm a fan.

(And it's a bug that would also trigger if any of the first 128 rpcs
were out of order.  But that would probably manifest as some user
reporting "once in a blue moon my krb5 mounts hang" and I think it would
take a while to get from that report to this bug as the root cause.  So
I'm glad pynfs hit it....)

--b.
