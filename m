Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916193B2F67
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhFXMyS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Jun 2021 08:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhFXMyR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Jun 2021 08:54:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93BEC061574;
        Thu, 24 Jun 2021 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JjqzPDjGNDhHumqGJMc0l3thrqr4HCxhcR5q9gXHRVI=; b=ZHXFAOScAfgMoquJF+eOmfyt/0
        u4lfdzcsYHoMIAVufKj0U1kRaUkZlD0/SEeeGgG1WIgHqH3tfofg9Co8DWV7+R6be80c+s8WJNklt
        TjiY0fQ4/m0tD6E3RT7YWEk6izmllQH7H/mLczr89FTJTSV+99T8L2r0Q53JsILuQ2n8tkeSLqcsn
        upkNqijoUF0LNd3ZagzBydpkgR9mrJ4d9PzTqvDk+fAkx2CVZC1KorUA4MU+68xsz7s16smj9seis
        1B0oOcb5FekbmeNawc/jlqVtIg4dGOZQRLSMX9KCguiao0RXE0J3sGc03+iP+UKwFNaNHBHcyJFzb
        mcoEUyEw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwOpH-00GaLw-B1; Thu, 24 Jun 2021 12:51:27 +0000
Date:   Thu, 24 Jun 2021 13:51:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] nfs: fix acl memory leak of posix_acl_create()
Message-ID: <YNR/y/kAHHQKqv7B@infradead.org>
References: <1624430335-10322-1-git-send-email-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624430335-10322-1-git-send-email-hsiangkao@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 23, 2021 at 02:38:54PM +0800, Gao Xiang wrote:
> When looking into another nfs xfstests report, I found acl and
> default_acl in nfs3_proc_create() and nfs3_proc_mknod() error
> paths are possibly leaked. Fix them in advance.

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
