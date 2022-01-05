Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74393485643
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 16:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbiAEPy7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 10:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241736AbiAEPyw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jan 2022 10:54:52 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FA3C061201
        for <linux-nfs@vger.kernel.org>; Wed,  5 Jan 2022 07:54:52 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E5B2D64A6; Wed,  5 Jan 2022 10:54:51 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E5B2D64A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641398091;
        bh=QHEkPmSS1Yk/TbWClXoO9uwnrM/O+PhyUYjwOsQpD3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVi5FjDo6Hh6rVviMPnO41J2F5B0NW3+RC9m8Pi7Qc/hLRfy5f6IHBuaflaBrRPpK
         meUfsXKyHQn6nCJ4WpVbggSTBWBWexbJiMZ1E67mYvr11ss/mTaohVDsdSLQvgPurc
         ygJBTuyUgTfOoBQ0APikBhy/eJ7AU6I/NQN4bDEw=
Date:   Wed, 5 Jan 2022 10:54:51 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Message-ID: <20220105155451.GA25384@fieldses.org>
References: <20211217204854.439578-1-trondmy@kernel.org>
 <20220103205103.GI21514@fieldses.org>
 <2b27da48604aaa34acce22188bfd429037540a89.camel@hammerspace.com>
 <DU2PR10MB5096010E9570E2718198EDD5E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220105151008.GB24685@fieldses.org>
 <DU2PR10MB5096501FB8A162D18CF1F1F2E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR10MB5096501FB8A162D18CF1F1F2E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 05, 2022 at 03:40:19PM +0000, Ondrej Valousek wrote:
> 
> >> - AFAIK support for RFC8276 in NFS (only version 4.2) server is since kernel 5.9, right? NFS client supports these as well?
> >> - The patches below implements the feature in both, nfs client AND server, right?
> 
> > Client only.
> 
> Right, but then it will be only useful if we use non-linux based NFS server right?
> 
> I mean simply:
> 1. $ stat /tmp/foo.txt   --> shows birth date
> 2. # exportfs \*/tmp
> 3. # mount 127.0.0.1:/tmp /mnt
> 4. $ stat /mnt/foo.txt   --> no birth date shown

Right.

Fixing that's likely just a few lines of code added to
fs/nfsd/nfs4xdr.c:nfsd4_encode_fattr().  Patches welcome.

--b.
