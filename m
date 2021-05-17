Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD2383CCA
	for <lists+linux-nfs@lfdr.de>; Mon, 17 May 2021 20:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhEQS6S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 May 2021 14:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbhEQS6R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 May 2021 14:58:17 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4BCC061573
        for <linux-nfs@vger.kernel.org>; Mon, 17 May 2021 11:57:01 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id D118364E8; Mon, 17 May 2021 14:56:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D118364E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1621277819;
        bh=uPegtIapBfiJzsx/1uZbNuaJcpLQ70CzfBaKW7tl9HE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJYQKI6uF0vuhesXHhofsnGAI5guKdmfTxIf9rlEk3Qj46e5ojCFCXsSnx77PAP3r
         G6xdCgr+z/fzlxB8px71U/9bVLdyFu8PKRjPXmiYCNpkwtYBO9ixiDmbfyxViVoPpm
         65mqBYyNLDRYM5bVj2eAV13knPckOK3rm9RAZmwY=
Date:   Mon, 17 May 2021 14:56:59 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "nickhuang@synology.com" <nickhuang@synology.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "robbieko@synology.com" <robbieko@synology.com>,
        "bingjingc@synology.com" <bingjingc@synology.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Prevent truncation of an unlinked inode from
 blocking access to its directory
Message-ID: <20210517185659.GA4216@fieldses.org>
References: <20210514035829.5230-1-nickhuang@synology.com>
 <00195ec8bf1752306f549540eed74c3938c5e312.camel@hammerspace.com>
 <YJ9yD1S6Yl2m0gOO@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ9yD1S6Yl2m0gOO@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, May 15, 2021 at 08:02:39AM +0100, Christoph Hellwig wrote:
> On Fri, May 14, 2021 at 03:46:57PM +0000, Trond Myklebust wrote:
> > Why leave the commit_metadata() call under the lock? If you're
> > concerned about latency, then it makes more sense to call fh_unlock()
> > before flushing those metadata updates to disk.
> 
> Also I'm not sure why the extra inode reference is needed.  What speaks
> against just moving the dput out of the locked section?

I don't know.  Do you know why do_unlinkat() is doing the same thing?

--b.
