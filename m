Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF45497AD9
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 09:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbiAXI6r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 03:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiAXI6q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 03:58:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01208C06173D;
        Mon, 24 Jan 2022 00:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+ySTjNm9z9t3kgl+0pVCQkj5RywfpxKfoIQtaXpG9uc=; b=IWAffQclXiKQ04DBXVF0j1T5xN
        +csiZpbA/hI5XtfeIkdyeRe068vzkV5I0KXb4I9apUSQL+tLnUbxzqJj3dM0JIC5TfcS80IHokACg
        0TlgFYEzb3j3WaLcyJ/lHFO9GRxBWaA1s/qXFrVuuKgUk8TjEOvHcqUjev4hiSvEw4HHbw+rdDxAQ
        Ujc9HqfCiHtrmfxflUUHouP5t/3On+6N0uhigSS/zCEumW0HqzouCies/msMy8n7Wuuo6tf2i7NhZ
        Y1uAhwUgiaURKCCBu91P0gX0R074yks9L2FE4KErZlhM6NPJUUQY2BsoDYnJFYCxGre8RnlEZgHCe
        T0C/jG+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvBQ-002hvV-Cz; Mon, 24 Jan 2022 08:58:40 +0000
Date:   Mon, 24 Jan 2022 00:58:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/23] NFS: swap IO handling is slightly different for
 O_DIRECT IO
Message-ID: <Ye5qQIVJ1wDX7ogv@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
 <164299611281.26253.15560926531007295753.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164299611281.26253.15560926531007295753.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Same comment on the externs as for the previous one, but otherwise looks
good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
