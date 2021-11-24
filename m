Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B3945CFAD
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Nov 2021 23:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbhKXWJ5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Nov 2021 17:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351804AbhKXWJw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Nov 2021 17:09:52 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3E6C061758
        for <linux-nfs@vger.kernel.org>; Wed, 24 Nov 2021 14:06:42 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 06D776F29; Wed, 24 Nov 2021 17:06:41 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 06D776F29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637791601;
        bh=Y47W5+x+3dAHROFYrFMYz2B0DvM2ObU8gKayzhrG6WM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DkiesdJEtntfWbC4MJhnKJfpOM14/nz8uNwplbC/vb5ZBAvQYdnPOr7jodIJU2V4G
         ycWVqZZxNdIAFErsquxN+143aLwk5qewl1THGzFn5DssGTAGhNHfy3KNoAtjQg2T2Z
         ik4yOL7i2u9waiSG49QKJ51XoH7cYRACndbIIkPE=
Date:   Wed, 24 Nov 2021 17:06:41 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "olivier@bm-services.com" <olivier@bm-services.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "carnil@debian.org" <carnil@debian.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Message-ID: <20211124220640.GE30602@fieldses.org>
References: <20201012154159.GA49819@eldamar.lan>
 <20201012163355.GF26571@fieldses.org>
 <20201018093903.GA364695@eldamar.lan>
 <YV3vDQOPVgxc/J99@eldamar.lan>
 <3899037dd7d44e879d77bba67b3455ee@bm-services.com>
 <DACA385D-5BBF-46D0-890D-71572BD0CB8A@oracle.com>
 <20211124152947.GA30602@fieldses.org>
 <0dbe620703eb27f36c02b4e001e74d67390bce9e.camel@hammerspace.com>
 <20211124161038.GC30602@fieldses.org>
 <e17bbb0a22b154c77c6ec82aad63424f70bfda94.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e17bbb0a22b154c77c6ec82aad63424f70bfda94.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 24, 2021 at 05:14:53PM +0000, Trond Myklebust wrote:
> It is a little nasty that we hide the list_del() calls in several
> levels of function call, so they probably do deserve a comment.
> 
> That said, if, as in the case here, the delegation was unhashed, we
> still end up not calling list_del_init() in unhash_delegation_locked(),
> and since the list_add() is not conditional on it being successful, the
> global list is again corrupted.
> 
> Yes, it is an unlikely race, but it is possible despite your change.

Thanks, good point.

Probably not something anyone's actually hitting, but another sign this
logic need rethinking.

--b.
