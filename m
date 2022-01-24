Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3980497A98
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 09:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbiAXIsZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 03:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242234AbiAXIsY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 03:48:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB37C06173B;
        Mon, 24 Jan 2022 00:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=VZbyWcIRUzokvqgNgSVwmMAL96
        U+car1lMPlLEYJNySRz/NOk4rcD7FtOJkkU6hwlVgppF05qVN1QiRsXJVgVFgHEUDkDBOJDJP9PKC
        HtBfYTu0mlzOeSwc2S7frisatyDsADkFgpSPjw4d4J86U0i4F65/u4KESuzOujkmf63ccM3SVf1hd
        Wv0qGV9OfatCZJksyVh5tu26rXp7NQVjwpoGdwkSeutreWPnu2ZPZ4pnoJj2bhjU+tE1GO6+3QLLT
        Cma8bA1NKNhZZuRhzGOdl9/49GNPk73wWDET7zh6FZ/2IB3IunqsKcHFhn6xL+Xw6ctkcrjspdrfL
        BDsu1zqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBv1L-002dmD-Ep; Mon, 24 Jan 2022 08:48:15 +0000
Date:   Mon, 24 Jan 2022 00:48:15 -0800
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
Subject: Re: [PATCH 06/23] MM: introduce ->swap_rw and use it for reads from
 SWP_FS_OPS swap-space
Message-ID: <Ye5nz0e54s1I19T7@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
 <164299611276.26253.13667789323141516970.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164299611276.26253.13667789323141516970.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
