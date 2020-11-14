Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5627D2B2C6C
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Nov 2020 10:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgKNJ2w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 Nov 2020 04:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgKNJ2s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 Nov 2020 04:28:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92251C0613D1
        for <linux-nfs@vger.kernel.org>; Sat, 14 Nov 2020 01:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v6ll+zxcw1XxkFANkfUBh5f3ugU5xLDXCFaFkU1O8ug=; b=WuaGXv+odpUY4pHhS4epclYRjG
        iON8UiCNCBBNecQelkce7kTxd+uK18mTWvNBcvjEycez6pF/mC6U1YVncVhUSkXjOtERy1GXClU6E
        KRLV9OyIE6A+36G7kmoOI4KCzzx+w4TWHinrs4NuZAk7WU/c2oosbTQg+/EI7KY/DdZVJXv0AGf7o
        MvM1GuiV74LsU/ohBCYU8e9wnKM3JChFP1cigrgpwPfI9RtQRExSHyh/AMR7eIanSSw6yK4SBb9d2
        ZSBTq0PbV20qR2UJ3+qYIUerBlobc/mI19HtcST2dxrtaQUHk6LmDn2GbY0Jm2mDcESPAPs/dzJUW
        X0nvbHDg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdrrS-0007ig-MQ; Sat, 14 Nov 2020 09:28:46 +0000
Date:   Sat, 14 Nov 2020 09:28:46 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 06/61] NFSD: Replace READ* macros in
 nfsd4_decode_access()
Message-ID: <20201114092846.GA29362@infradead.org>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
 <160527977531.6186.18215866313473241680.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160527977531.6186.18215866313473241680.stgit@klimt.1015granger.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> +static __be32
> +nfsd4_decode_access(struct nfsd4_compoundargs *argp, struct nfsd4_access *access)

Please fix up a bunch of overly long lines here and in the other
patches.
