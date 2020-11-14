Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D7B2B2FCF
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Nov 2020 19:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgKNSrj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 Nov 2020 13:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgKNSrh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 Nov 2020 13:47:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93503C0613D1
        for <linux-nfs@vger.kernel.org>; Sat, 14 Nov 2020 10:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Za6wz24vYNKXEqQM2XqbPv1cI1pqGQsEn2Iuw297Oco=; b=M4kM6FQsDvMQGwrZibOXBoYsDV
        lbfZgeeNStcXmHcGuhwfyGf4tih5NopD7Nubd1LmIcCA3JPikHRrUITtk5h/VBp555+mQ9AxwArXD
        7ZWZKksxgwUkXSSNwITZC5dAgz2GCrCrIAnpCrfo251vC306D3wIIcDAF8c6lm+xed03I8ZbQTGV6
        ebZFAmjbSedSJXcDqRLyPsxqs5tKmjT8I8LqitkKWD3dcz5Mys1SM9DQby6iaFgjQID3LklwaB5tG
        lRmyf/klwZv9xTeSKksX0ogGvvGWMspu5/Plww/+ApbAvIb+0Xk/xWPx88gqBcCZRzYHKG9I5BFJD
        Wpi/vH3g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ke0aF-0003bx-5J; Sat, 14 Nov 2020 18:47:35 +0000
Date:   Sat, 14 Nov 2020 18:47:35 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 07/61] NFSD: Replace READ* macros in
 nfsd4_decode_close()
Message-ID: <20201114184735.GA13691@infradead.org>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
 <160527978038.6186.4530707404283867683.stgit@klimt.1015granger.net>
 <20201114092954.GB29362@infradead.org>
 <1932EF5C-BC27-4275-B52D-1EB82859149E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1932EF5C-BC27-4275-B52D-1EB82859149E@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Nov 14, 2020 at 01:30:33PM -0500, Chuck Lever wrote:
> Question of coding style. Some people prefer having a single
> point of exit at the tail of a function.

While I've heard the argument of a single exit a few times, it was
usually from people that also frown upon goto labels and produces
strange deeply nested code..

> I suppose I could simplify these smaller decoders, but it's
> subjective. Anyone else have an opinion? Christoph, as an
> example, how would you express this particular function?

static __be32
nfsd4_decode_stateid4(struct nfsd4_compoundargs *argp, stateid_t *sid)
{
	__be32 *p;

	p = xdr_inline_decode(argp->xdr, NFS4_STATEID_SIZE);
	if (!p)
		return nfserr_bad_xdr;
	sid->si_generation = be32_to_cpup(p++);
	memcpy(&sid->si_opaque, p, sizeof(sid->si_opaque));
	return nfs_ok;
}
