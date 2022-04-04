Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8BA4F1808
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Apr 2022 17:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378470AbiDDPOv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Apr 2022 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352482AbiDDPOu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Apr 2022 11:14:50 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FFF3B542
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 08:12:54 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 481D91510; Mon,  4 Apr 2022 11:12:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 481D91510
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1649085174;
        bh=kMkouydRK6AUHaUqpWIrjJ6ZdmRUtNSwaFAN6MFBA8k=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=cC/0QdJS03OZfmLjClHF01VRCWpXF/qDs8EI/Q9V1ZbC/sqzdlALSQB2r0K/Oa2wA
         2H9A5c6Ie8VKYaILdjANonqlcyRxmWKjuwV01lEZDAugFdGQI1tAm3Svzurl2Ub462
         nPQiBjkxQ66tR6IElPg/4z4CQk4Q0DkLOrE65rv4=
Date:   Mon, 4 Apr 2022 11:12:54 -0400
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question about RDMA server...
Message-ID: <20220404151254.GA17195@fieldses.org>
References: <82662b7190f26fb304eb0ab1bb04279072439d4e.camel@hammerspace.com>
 <1114899D-BBF5-4CB1-9126-E4E652ACAAB6@oracle.com>
 <5DCBD9EB-7721-48FC-9EBD-58B7DF05A704@oracle.com>
 <8af942181abb39cd7ce8fe91be9c4c2f8c9f2c56.camel@hammerspace.com>
 <2E4807E4-5086-4F15-B790-8D952B394FE5@oracle.com>
 <974fa169124661c2ce5ed549d499837435cc7b4c.camel@hammerspace.com>
 <E7FD566B-0570-4D14-9936-5C737B619E0B@oracle.com>
 <b9b98ad9b21f228566a5ebd643198c669c9f3408.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b98ad9b21f228566a5ebd643198c669c9f3408.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 31, 2022 at 08:08:59PM +0000, Trond Myklebust wrote:
> On Thu, 2022-03-31 at 18:53 +0000, Chuck Lever III wrote:
> > It's plausible that a deferred request could be replayed, but I don't
> > understand the deferral mechanism enough to know whether the rctxt
> > would be released before the deferred request could be handled. It
> > doesn't look like it would, but I could misunderstand something.
> > 
> > There's a longstanding testing gap here: None of my test workloads
> > appear to force a request deferral. I don't recall Bruce having
> > such a test either.
> > 
> > It would be nice if we had something that could force the use of the
> > deferral path, like a command line option for mountd that would cause
> > it to sleep for several seconds before responding to an upcall. It
> > might also be done with the kernel's fault injector.
> > 
> 
> You just need some mechanism that causes svc_get_next_xprt() to set
> rqstp->rq_chandle.thread_wait to the value '0'.

Yeah, no idea what's going on here, but a way to force the deferral case
sounds like a great idea that'd come in handy some day if not this time.

(Can you hack it by, say, killing mountd, flushing the caches (exportfs
-f), then waiting a few seconds to restart mountd?)

--b.
