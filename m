Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCFE32B757
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Mar 2021 12:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346472AbhCCK7C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 05:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347723AbhCCHOa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 02:14:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AECC061756
        for <linux-nfs@vger.kernel.org>; Tue,  2 Mar 2021 23:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=deBjUIw7o+5FrL5cMAMC5oZOFMRRuWN1/zCIz0A/P5I=; b=bL53yZ+p2+y9M/j7v7JtBh5Cqk
        ZTAflsO4MCaAffr+25sUsXEOLdiwHpH4XQJY+lv0jZDkot4r2puiJACddPSskVpUceUgNd3yt5EK+
        hvWgtLaxESzTAcQolUoJUCqWOzjStgLCJ0lvgFgrWK/uwD6eLhg9EmLUVhhuAc2wYD36lFKqQLpFK
        CPH02xx99TKjPFMMX1n76xzaWcjA8Cy42/oaW5EQye0ulygkII6/0oOhZZR/jDOP/UKAwdyunX3O3
        HovfW6tOLL+0FtbpijStng55BjNPtBMdcyX/my+vz+IVueX+hXCOeZsscLcFvkAXvC8+5Arwb1C+t
        VVdiCtYw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lHLhZ-001eDF-LO; Wed, 03 Mar 2021 07:13:45 +0000
Date:   Wed, 3 Mar 2021 07:13:45 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 14/42] NFSD: Update the NFSv3 PATHCONF3res encoder to
 use struct xdr_stream
Message-ID: <20210303071345.GA388507@infradead.org>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
 <161461180307.8508.9954286154242416300.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161461180307.8508.9954286154242416300.stgit@klimt.1015granger.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 01, 2021 at 10:16:43AM -0500, Chuck Lever wrote:
> +	*p++ = resp->p_no_trunc ? xdr_one : xdr_zero;
> +	*p++ = resp->p_chown_restricted ? xdr_one : xdr_zero;
> +	*p++ = resp->p_case_insensitive ? xdr_one : xdr_zero;
> +	*p = resp->p_case_preserving ? xdr_one : xdr_zero;

Wouldn't a little xdr_encode_bool helper for this common pattern be
nice?
