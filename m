Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED172B2C6D
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Nov 2020 10:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKNJ35 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 Nov 2020 04:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgKNJ34 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 Nov 2020 04:29:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD20C0613D1
        for <linux-nfs@vger.kernel.org>; Sat, 14 Nov 2020 01:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ur/lyaGyAQJfjDKYozxLeCJL67VJspiVDJE1bf6uljg=; b=E1G4YFJONc1Do7Z8fE98yGQFNH
        sjR7vs9xDm+wWxEl4YGfwcj4ztAbrxrdIadgMt8GIlhwe+DOOqV0yTRWQV1smikHmzzU13wMkjo9R
        z78Y4S/Q6F0EAfZ9MacnmGSSEVDobTa/ZxuB4DwqgcNOxwHr68XyfHLp/neZWBA0V9mwQCEVN/AHT
        HsboUaq83U/c0x4A6PqGl6sdAH4HHKdWcD05miITQf4x/lYHySrVPmssIc9wAfDEoCA2I04HsTgC1
        qRX3UCUT3bhUzHLm9/chcDXjDJAPRCzMOj+oDns9eiGoXPRp7nxVbEc4HKgoJGjqgT1irzI+pjF44
        vFq9iruQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdrsZ-0007m6-1C; Sat, 14 Nov 2020 09:29:55 +0000
Date:   Sat, 14 Nov 2020 09:29:54 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 07/61] NFSD: Replace READ* macros in
 nfsd4_decode_close()
Message-ID: <20201114092954.GB29362@infradead.org>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
 <160527978038.6186.4530707404283867683.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160527978038.6186.4530707404283867683.stgit@klimt.1015granger.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

>  {
> +	__be32 *p;
>  
> +	p = xdr_inline_decode(argp->xdr, NFS4_STATEID_SIZE);
> +	if (!p)
> +		goto xdr_error;
>  	sid->si_generation = be32_to_cpup(p++);
> +	memcpy(&sid->si_opaque, p, sizeof(sid->si_opaque));
> +	return nfs_ok;
> +xdr_error:
> +	return nfserr_bad_xdr;

Using a goto for a trivial direct error return looks pretty strange
and makes the code harder to follow.  This seems to happen quite a bit
in this and the following patches.
