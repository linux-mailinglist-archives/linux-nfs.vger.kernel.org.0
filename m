Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE6D4844A3
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jan 2022 16:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiADPcH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jan 2022 10:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiADPcG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jan 2022 10:32:06 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D860C061761
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jan 2022 07:32:06 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5DF99248F; Tue,  4 Jan 2022 10:32:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5DF99248F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641310325;
        bh=Fw7C+E643q01/w+pwjT6PakP+FjEPqOmMFVekP0qRDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lNIGqr/l5/WJOctrmxc7H5rJG99zKf6GO66kyGGS9eHb+yYcQOoIiIWxJ1DyWELAD
         g9QQVcMNxUSGC04mK6CVWcWiZqRc03HKHb1XBgRaQ3zgwKNkECXMQQrB0s/ecRFZi1
         fRa0ll5GM56anwkXc/xD7+WFXaIorhFcs40Y0+6w=
Date:   Tue, 4 Jan 2022 10:32:05 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "mbenjami@redhat.com" <mbenjami@redhat.com>
Subject: Re: client caching and locks
Message-ID: <20220104153205.GA7815@fieldses.org>
References: <22b841f7a8979f19009c96f31a7be88dd177a47a.camel@hammerspace.com>
 <20200618200905.GA10313@fieldses.org>
 <20200622135222.GA6075@fieldses.org>
 <20201001214749.GK1496@fieldses.org>
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>
 <20201006172607.GA32640@fieldses.org>
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>
 <20220103162041.GC21514@fieldses.org>
 <OSZPR01MB7050F9737016E8E3F0FD5255EF4A9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
 <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 04, 2022 at 12:36:14PM +0000, Trond Myklebust wrote:
> On Tue, 2022-01-04 at 09:24 +0000, inoguchi.yuki@fujitsu.com wrote:
> > Hi Neil and Bruce,
> > 
> > Thank you for your comments.
> > Now I have understood that this behavior is by design.
> > 
> > > > With NFSv4 there is no atomicity guarantees relating to writes
> > > > and
> > > > changeid.
> > > > There is provision for atomicity around directory operations, but
> > > > not
> > > > around data operations.
> > 
> > So I feel like clients cannot always trust changeid in NFSv4. 
> > Should it be described in the spec?
> > 
> > For example, the following section refers about the usage of
> > changeid:
> > https://datatracker.ietf.org/doc/html/draft-dnoveck-nfsv4-rfc5661bis#section-14.3.1
> > 
> > It says clients use change attribute " to ensure that the data for
> > the OPENed file is still 
> > correctly reflected in the client's cache." But in fact, it could be
> > wrong.
> 
> The existence of buggy servers is not a problem for the client to deal
> with. It's a problem for the server vendors to fix.

I agree that, in the absence of bugs, there's no problem with using the
change attribute to provide close-to-open cache consistency.

The interesting question to me is how you use locks to provide cache
consistency.

Language like that in
https://datatracker.ietf.org/doc/html/rfc7530#section-10.3.2 implies
that you can get something like local cache consistency by write-locking
the ranges you write, read-locking the ranges you read, flushing before
write unlocks, and checking change attributes before read locks.

In fact, that doesn't guarantee that readers see previous writes.

--b.
