Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2E02B57B7
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Nov 2020 04:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgKQDQD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Nov 2020 22:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgKQDQC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Nov 2020 22:16:02 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81EEC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 16 Nov 2020 19:16:02 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 77B151C29; Mon, 16 Nov 2020 22:16:01 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 77B151C29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1605582961;
        bh=D2jNETWSFuPlafNmnOgOiUVi8uS32omeIyXC3EjwZ4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CGH2P/voMOZqLry8hvHXMdSvfGrO8DRqj9l/duJ4trIwkAOMeU3uDRAIyyovUv/Pn
         s9jp1lA8w4uc7qVE3YQ3G17S1gYVyW2nP+YHjaqLDbz5JHeIMqYUQhCqBQTSDYcvSn
         bNXQ5AeBhoSGMXOqHFsB0P8/a/YwX4uJdYdkStJQ=
Date:   Mon, 16 Nov 2020 22:16:01 -0500
From:   bfields <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201117031601.GB10526@fieldses.org>
References: <883314904.86570901.1605222357023.JavaMail.zimbra@dneg.com>
 <20201113145050.GB1299@fieldses.org>
 <20201113222600.GC1299@fieldses.org>
 <b0d61b4053442ba46fd2c707ee7e0608704c2598.camel@kernel.org>
 <20201116155619.GF898@fieldses.org>
 <83ebb6dc68216ce3f3dfd2a2736b7a301550efc5.camel@kernel.org>
 <20201116161407.GG898@fieldses.org>
 <db55bab87b6fc9dd1594f8c2e853f07b1165ff5d.camel@kernel.org>
 <20201116190336.GH898@fieldses.org>
 <0047077b3bd79a96589626ba154e6d9e95a35478.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0047077b3bd79a96589626ba154e6d9e95a35478.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 16, 2020 at 03:03:15PM -0500, Jeff Layton wrote:
> Another idea might be to add a new fetch_iversion export operation that
> returns a u64. Roll two generic functions -- one to handle the
> xfs/ext4/btrfs case and another for the NFS/AFS/Ceph case (where we just
> fetch it raw). When the op is a NULL pointer, treat it like the
> !IS_I_VERSION case today.

OK, a rough attempt follows, mostly untested.--b.
