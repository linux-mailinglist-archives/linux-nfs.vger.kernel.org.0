Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6745613812
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 14:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiJaNbI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 09:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJaNbH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 09:31:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D175FADD
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i0VwRDMba6n2H8O2duV27vNwHEF8oACbLjxbNO45Bgw=; b=dJbnc/u+Lf2fQGFxzck17KVO47
        gavmRcvSi+s3qntOF2oOotjkNxoZUvOeqAxx9Lju7DGML5AePlIgjlYSTJ7v+sZQ7940OPFi3y23I
        y0RyQjLlEptzh748JOj0nPKJpcPTYz7qa/z/+rNR1nAwMLecCjQO+9f/vgcRH5iUEN+bj2uigqI1A
        udsbGWMN47xvNv6hGrfljuDkhEFQWc3SmsYIrYTenhV0S/sRBUlxpD8C+cc7iDv0C9m1Xl0FktsxY
        3J8Eaa45k/YUuH8k5D8yAW5DN81GnErTk84eCt7lygKJnpzrbfekXxtdYUIXEA/VpKcwcwtKDJL89
        iBnO3JMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opUsX-00C4dU-1p; Mon, 31 Oct 2022 13:31:01 +0000
Date:   Mon, 31 Oct 2022 06:31:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix licensing header in filecache.c
Message-ID: <Y1/OFbwh8WtbjKH0@infradead.org>
References: <20221026143518.250122-1-jlayton@kernel.org>
 <Y1+A7XzxKbRCCH4z@infradead.org>
 <3C6909FD-6079-48AC-93E2-BD7937E31F86@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6909FD-6079-48AC-93E2-BD7937E31F86@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 31, 2022 at 01:21:45PM +0000, Chuck Lever III wrote:
> I know you are Not A Lawyer (tm), but:
> 
> The e-mail address in the copyright notice is stale. Is the convention
> to leave stale e-mail addresses in place?
> 
> So I would expect copyright ownership of this code to go to Primary Data,
> Jeff's employer at the time. But they don't exist now either; it might
> be difficult to get permission from them to alter this notice.

I'm not a copyright lawyer, but I've talked to a few, so:

 - first, does Jeff own the copyright for this code, or his employer at
   the time?
 - if he owns it, can cna do pretty much whatever he wants
 - if he doesn't, I would not touch it without approval from the
   copyright holder, which gets a little complicated for a company
   that doesn't exist in that form any more.
