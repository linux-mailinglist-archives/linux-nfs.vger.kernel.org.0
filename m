Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CAD2CADD9
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 21:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbgLAUyl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 15:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388142AbgLAUyk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 15:54:40 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A59C0617A7
        for <linux-nfs@vger.kernel.org>; Tue,  1 Dec 2020 12:54:00 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 33CA36F4C; Tue,  1 Dec 2020 15:53:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 33CA36F4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606856039;
        bh=C0M0M1XMvnPyVuXvoznQh2WET8IHYd9p6mpO9O/PujU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LnAbbdGqnAEFlW+9N7DwEyd4Z6HmjqHfoiaSRRx3QoCJMcu9hXLy2oqHnF0xwyHEU
         1eBGQYFAOq+2V2OwJ1LmqxR4V1NXOr+qESBfm1adTDKYemNu50ocyJdF7kzwAfEFK5
         ydLOoWU3it7yovgu2nxfzwsmlm03xuv3t60PQDNI=
Date:   Tue, 1 Dec 2020 15:53:59 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 2/2] nfsd: Record NFSv4 pre/post-op attributes as
 non-atomic
Message-ID: <20201201205359.GC21355@fieldses.org>
References: <20201201041427.756749-1-trondmy@kernel.org>
 <20201201041427.756749-2-trondmy@kernel.org>
 <20201201193521.GA21355@fieldses.org>
 <63eaf3aab8814b2d65998123b6ba2e5b979a48d9.camel@hammerspace.com>
 <7181b1e7290dcfe4f92d9a8b00117a81b30f0cce.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7181b1e7290dcfe4f92d9a8b00117a81b30f0cce.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 01, 2020 at 08:27:38PM +0000, Trond Myklebust wrote:
> As far as I can tell, there is no need for it at all, since both the
> NFSv3 and NFSv4 client can supply atomic struct change_info4 in the
> cases where it is relevant (those cases being recording the changes to
> the parent directory/ies when doing CREATE, OPEN(O_CREAT), LINK, REMOVE
> and RENAME).

I was wondering about that.  We'd need some additional interface to
allow nfs to supply that stuff to nfsd, right?

--b.
