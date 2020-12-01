Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7132C959D
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 04:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgLADMM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 22:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgLADML (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 22:12:11 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE15C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 19:11:31 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 3FAE86F4A; Mon, 30 Nov 2020 22:11:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 3FAE86F4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606792290;
        bh=KjdfVVQGHz1pqiDdxN52V4QbZ29aTlUAGPf2WdluaoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IqPun1Z4EqPD7FyQF1itBMQOvNC9IkoD+S4wVPGk7/gNHQE/TuO9+ygB4z6TzjkEu
         7w9ODCq+YTqW8PjaKHQWgVZKPYPZjCmiV0WcZqRjQITvzv2Tdzq6+EDXYji+pbwWHG
         X7MRtYGCG4gdi+1IqPvRKuebmvtlbckhLEmymJdw=
Date:   Mon, 30 Nov 2020 22:11:30 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@redhat.com" <bfields@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Message-ID: <20201201031130.GD22446@fieldses.org>
References: <20201130212455.254469-1-trondmy@kernel.org>
 <20201130212455.254469-2-trondmy@kernel.org>
 <20201130225842.GA22446@fieldses.org>
 <1b525278a9a7541529290588a83852a0754cee3e.camel@hammerspace.com>
 <20201201022834.GA241188@pick.fieldses.org>
 <66f93208c6edf2dad70ee41c349c5130b30b8ed4.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f93208c6edf2dad70ee41c349c5130b30b8ed4.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 01, 2020 at 03:06:46AM +0000, Trond Myklebust wrote:
> A local filesystem might choose to set the 'non-atomic' flag without
> wanting to turn off NFSv3 WCC attributes. Yes, the latter are assumed
> to be atomic, but a number of commercial servers do abuse that
> assumption in practice.

What do you mean by abusing that assumption?

I thought that leaving off the post-op attrs was the v3 protocol's way
of saying that it couldn't give you atomic wcc information.

--b.
