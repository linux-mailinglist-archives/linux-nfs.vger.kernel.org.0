Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD559314294
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Feb 2021 23:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhBHWJh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Feb 2021 17:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhBHWJg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Feb 2021 17:09:36 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF497C061786
        for <linux-nfs@vger.kernel.org>; Mon,  8 Feb 2021 14:08:56 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 81F1D2403; Mon,  8 Feb 2021 17:08:55 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 81F1D2403
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1612822135;
        bh=MwR0npOfpfskQFJCTTkFNW9bv10M8CufYLLkBMsbz74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QtpK31occnDaDpPRehS0nnLWbU0QNtEEEXs0eEhjhVAB3W5TR2wvy/hXHJfYCnl6U
         cedzbhg9hhVoT/h4OmzYkaPmnNOem0+c88i0r834Xc0/QN6FSwTRHjKo9l2EfxRAYb
         Qd09m5C+hUKoN/SvZSjVye7jxKvUMyRoZTYouPnY=
Date:   Mon, 8 Feb 2021 17:08:55 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "guy@vastdata.com" <guy@vastdata.com>,
        "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: we don't support removing system.nfs4_acl
Message-ID: <20210208220855.GA15116@fieldses.org>
References: <20210128223638.GE29887@fieldses.org>
 <95e5f9e4-76d4-08c4-ece3-35a10c06073b@vastdata.com>
 <cbc7115cc5d5aeb7ffb9e9b3880e453bf54ecbdb.camel@hammerspace.com>
 <20210129023527.GA11864@fieldses.org>
 <20210129025041.GA12151@fieldses.org>
 <7a078b4d22c8d769a42a0c2b47fd501479e47a7b.camel@hammerspace.com>
 <20210131215843.GA9273@fieldses.org>
 <20210203200756.GA30996@fieldses.org>
 <6dc98a594a21b86316bf77000dc620d6cca70be6.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dc98a594a21b86316bf77000dc620d6cca70be6.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Feb 08, 2021 at 07:31:38PM +0000, Trond Myklebust wrote:
> OK. So you're not really saying that the SETATTR has a zero length
> body, but that the ACL attribute in this case has a zero length body,
> whereas in the 'empty acl' case, it is supposed to have a body
> containing a zero-length nfsace4<> array. Fair enough.

Yep!  I'll see if I can think of a helpful concise comment, and resend.

--b.
