Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DCA2C8E68
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 20:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgK3Tsh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 14:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgK3Tsh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 14:48:37 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ED9C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 11:47:57 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 91EFB6F4A; Mon, 30 Nov 2020 14:47:56 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 91EFB6F4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606765676;
        bh=28EWZQerZy7S367NTQTHb+dEg7kOPUISXk7z+eyq2uE=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=ZOOf4OYaDPvBwRplTwR8JWAhRKBk4xin2bfMz7p/QoMUitfywMB3lD6iWYEkShEM9
         ABGJ1YUrOQ2IxNIJM724A9c71qkWCQyWBFc2qvLrsCY2MO1KCenlwFG5dGLpzUZzfS
         IWpBc3GfWFWLbxZYhbRkfQOpKDrUiu71fkGqToGE=
Date:   Mon, 30 Nov 2020 14:47:56 -0500
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSD merge candidate for v5.11
Message-ID: <20201130194756.GB17322@fieldses.org>
References: <48FA73BE-2D86-4A3F-91D5-C1086E228938@oracle.com>
 <0cbeed0a0fa2352961966efdd7e62247b5cd7a7b.camel@redhat.com>
 <5A43C026-0746-4F62-8298-2501EF1EF692@oracle.com>
 <20201125145617.GA77389@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125145617.GA77389@pick.fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 25, 2020 at 09:56:17AM -0500, J. Bruce Fields wrote:
> On Tue, Nov 24, 2020 at 07:36:21PM -0500, Chuck Lever wrote:
> > Declarations for most other generic_* functions are in fs.h.
> > But OK, moved, and the series pushed.
> > 
> > So I think the btrfs/ext4/xfs-specific changes might need
> > sign-off by those maintainers.
> 
> And nfs, I think that's the one I'm mostly likely to have messed up,
> actually....
> 
> > Should I post this series to linux-fsdevel? Or, Bruce, do you want to?
> 
> I think I should do it.

I resent, and just left out the patches that touch btrfs, ext4, xfs, and
nfs.  Those can go in later.

--b.
