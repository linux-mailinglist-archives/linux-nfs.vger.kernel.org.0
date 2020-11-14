Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6112B2FCE
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Nov 2020 19:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKNSpS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 Nov 2020 13:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKNSpS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 Nov 2020 13:45:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E154C0613D1
        for <linux-nfs@vger.kernel.org>; Sat, 14 Nov 2020 10:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jaYq8LXveuvJ9ecjqyTE5is8WQelt4xCaWbOG7qAa84=; b=GfA9B71U5hXZ4Kq5+B83fTNMfh
        43J5lDb5YciXCD+Um1IfBJK29shChZ55tpdNXRBG/jqjU09P7WdiR/l95Q3zX9ZRqO8rd7+fUDiCX
        nZnmmJ8IFzV6PFr6Z9she1FIF2RgBJzCul+NT9rHFEvzU3YLzdEIkP/UB6lgp2ov9ANICtpRRngDa
        HCYc/Bu5fJc+k6JBqLcnG/jSv5ZH+1jvKMisIAwwE7X37QOPiTi+sseJuPuKw/fOrw8X9KqFn3SPU
        cCgQnphbwQTmsAJKL3PunYMl/bnhqXcTg8mtQfx/l9ZUy+XtSEinxwCDnq9MiMVAQKuz9fPRVjFSj
        TzZHSRAg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ke0Y0-0003Xm-9G; Sat, 14 Nov 2020 18:45:16 +0000
Date:   Sat, 14 Nov 2020 18:45:16 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 06/61] NFSD: Replace READ* macros in
 nfsd4_decode_access()
Message-ID: <20201114184516.GA12185@infradead.org>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
 <160527977531.6186.18215866313473241680.stgit@klimt.1015granger.net>
 <20201114092846.GA29362@infradead.org>
 <E38DF8DB-D9C8-4139-AB5F-5905FCFB44E5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E38DF8DB-D9C8-4139-AB5F-5905FCFB44E5@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Nov 14, 2020 at 01:26:43PM -0500, Chuck Lever wrote:
> 
> 
> > On Nov 14, 2020, at 4:28 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> >> +static __be32
> >> +nfsd4_decode_access(struct nfsd4_compoundargs *argp, struct nfsd4_access *access)
> > 
> > Please fix up a bunch of overly long lines here and in the other
> > patches.
> 
> Not saying no, but...
> 
> Kernel coding style and scripts/checkpatch.pl were recently
> updated to permit 100 character long lines. What reason is
> there to shorten these?

The coding style only allows it as an exception if it significantly
improves readabily.  and modern checkpatch.pl unfortunately is wrong
more often than not.
