Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D30D26D37C
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 08:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIQGNY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Sep 2020 02:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQGNX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Sep 2020 02:13:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0C8C06174A
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 23:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X9s2zoOnf9eH4HyQdnv8XgIzfYS5l5/tGszcKQwmTs4=; b=mVQTm/a/K90G1gktABDszQzrHD
        rZD+hSRSL0AIK/Gf+qXHtHwjGmEKHmIPxMQSN8znD9Kfl+agwUz0Nhvg1Vi3A1wJ+1Nzee7hQkG0f
        wsG6YnNcLmmkajHUOnBDfFrnu0g3AfC/BfneHLt4g6qZI1f7hRnWLkBnUD7ERLCjK4j3ZucKIRTBC
        41S2G8QFGupLE/3MOHRl/2AlvF+E4oBT1ch+JILFIX+SCcIZ4rTQi46k08EyrmFlDnf4MYbQMpzRC
        4yNep+wGalMaJH9ZdBToG5czBl0fS6A4CKJhI+2mrfPln9CHcnIis6ocPRRGvDf5JeqwdMkA6LrA3
        twiic4Ug==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kInAR-0000yd-64; Thu, 17 Sep 2020 06:13:15 +0000
Date:   Thu, 17 Sep 2020 07:13:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     bfields@fieldses.org, Bill.Baker@oracle.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 01/21] NFSD: Add SPDK header for fs/nfsd/trace.c
Message-ID: <20200917061315.GA625@infradead.org>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
 <160029253817.29208.3156039915028547893.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160029253817.29208.3156039915028547893.stgit@klimt.1015granger.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 16, 2020 at 05:42:18PM -0400, Chuck Lever wrote:
> Clean up.
> 
> The file was contributed in 2014 by Christoph Helwig in commit
> 31ef83dc0538 ("nfsd: add trace events").

s/SPDK/SPDX/
