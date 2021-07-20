Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091003CF5AD
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jul 2021 10:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhGTHX2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Jul 2021 03:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhGTHWq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Jul 2021 03:22:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B0EC061762;
        Tue, 20 Jul 2021 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ExmrGbrdIUQSeY7e8dXMjoWIxviUFIUiz6y8MEQJj8w=; b=X22RTxG/2SWNuDrL8UUVekBqpP
        slcqfv+jIuqDbmJ7DSwfs8Tunkg/f+0vAg3hGD+Tf1Lpw8KloNYpnwZbZGUkSSYA4LHJ5bJdbrsiE
        t5K4kjDeOTH0bhVeRaMnr78MrnlIS9NJq5dxXNa6TNYeRlLIAr8JY1WU5gAS7Q9TqMmsKbFpXfc+b
        5IT85XAPChHfZdsFFaCx2jBPeTHHk26Fgg8JE9msUq5qosVUwrvwl/jo8IVNjfSs9pDqDyUpJgfD+
        Twfonm9JaREnj29QkLIHv7Md/h7uZ3YLyneaYRjyIlUjt+V+lumPOVVy192h23FtjqGTi8WHRhbSf
        wybvr/Yg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5kgS-007tLP-QZ; Tue, 20 Jul 2021 08:01:05 +0000
Date:   Tue, 20 Jul 2021 09:00:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
Message-ID: <YPaCuGm+3RX6vzjp@infradead.org>
References: <162632387205.13764.6196748476850020429@noble.neil.brown.name>
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>
 <YPBmGknHpFb06fnD@infradead.org>
 <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>
 <YPBvUfCNmv0ElBpo@infradead.org>
 <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>
 <YPVC/w4kw3y/14oF@infradead.org>
 <162673888433.4136.7451392112850411713@noble.neil.brown.name>
 <YPZr9woK584Oc61H@infradead.org>
 <162676543271.12554.10226255548215795177@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162676543271.12554.10226255548215795177@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 20, 2021 at 05:17:12PM +1000, NeilBrown wrote:
> Does anything there seem unreasonable to you?

This is what I've been asking for for years.
