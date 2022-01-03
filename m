Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BA94834A8
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 17:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiACQUo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 11:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbiACQUn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jan 2022 11:20:43 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBBC061785
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jan 2022 08:20:42 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 475966F28; Mon,  3 Jan 2022 11:20:41 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 475966F28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641226841;
        bh=ivo81QI34NNkJxXRi5IUsqBdmX2xxttsJVGr9uMmoMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O1UzPlZi24cVl2+mMatwh9cQksVX2meJDCHX4kZvCFq12mVFUH5wVEK/wAX6L8qdM
         +4YN8e/QptTNB5TjxPemKn+Qznp92gRfP96l6hpYPp5ZfIcAGojbyXyb+1uojCACW/
         HeO9Vw2lOLl2CiA7M0SIY4imM22Aci6e37u8C3jw=
Date:   Mon, 3 Jan 2022 11:20:41 -0500
From:   "'bfields@fieldses.org'" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>,
        'Matt Benjamin' <mbenjami@redhat.com>,
        'Trond Myklebust' <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: Re: client caching and locks
Message-ID: <20220103162041.GC21514@fieldses.org>
References: <20200608211945.GB30639@fieldses.org>
 <22b841f7a8979f19009c96f31a7be88dd177a47a.camel@hammerspace.com>
 <20200618200905.GA10313@fieldses.org>
 <20200622135222.GA6075@fieldses.org>
 <20201001214749.GK1496@fieldses.org>
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>
 <20201006172607.GA32640@fieldses.org>
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164066831190.25899.16641224253864656420@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 28, 2021 at 04:11:51PM +1100, NeilBrown wrote:
> This is due to an (arguable) weakness in the NFSv4 protocol.
> In NFSv3 the reply to the WRITE request had "wcc" data which would
> report change information before and after the write and, if present, it
> was required to be atomic.  So, providing timestamps had a high
> resolution, the client0 would see change information from *before* the
> write from client1 completed.  So it would know it needed to refresh
> after that write became visible.
> 
> With NFSv4 there is no atomicity guarantees relating to writes and
> changeid.
> There is provision for atomicity around directory operations, but not
> around data operations.
> 
> This means that if different clients access a file concurrently, then
> their cache can become incorrect.  The only way to ensure uncorrupted
> data is to use locking for ALL reads and writes.  The above 'od -i' does
> not perform a locked read, so can give incorrect data.
> If you got a whole-file lock before reading, then you should get correct
> data. 

You'd also have to get a whole-file write lock on every write, wouldn't
you, to prevent your own write from obscuring the change-attribute
update caused by a concurrent writer?

> You could argue that this requirement (always lock if there is any risk)
> is by design, and so this aspect of the protocl is not a weakness.

The spec discussion of byte-range locking and caching is here:
https://datatracker.ietf.org/doc/html/rfc7530#section-10.3.2

The nfs man page, under ac/noac, says "Using the noac option provides
greater  cache  coherence among  NFS  clients accessing the same files,
but it extracts a significant performance penalty.  As such,  judicious
use of file locking is encouraged instead.  The DATA AND METADATA
COHERENCE section contains a detailed discussion of these trade-offs."

That section does have a "Using file locks with NFS" subsection, but
that subsection doesn't actually discuss the interaction of file locks
with client caching.

It's a confusing and under-documented area.

--b.
