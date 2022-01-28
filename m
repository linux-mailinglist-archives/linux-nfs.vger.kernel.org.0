Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBD049F14C
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jan 2022 03:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241932AbiA1Cvy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 21:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241793AbiA1Cvx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 21:51:53 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F2DC061714
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 18:51:53 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id EDBDA5BD0; Thu, 27 Jan 2022 21:51:52 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EDBDA5BD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643338312;
        bh=odXSBSzeHZNbsTY6h4fv2j22HYjGCJ5oRAkr7P5P9f0=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=ErX5aSUmdC852nUeZGnnvXYKemUoxpLZ+PzYyUtw9xblrH19IKg45UtwTgyjBFfyj
         CgQK1KVU07DMxtq4hpmQBmfH9DVCqVuoCLtR98ycLCEFBrxu77hhTV6O6t29DVuG6s
         2H3tAKaVURgc5Tl1UOKMOcxKhQgauDOJiiL4Nh3I=
Date:   Thu, 27 Jan 2022 21:51:52 -0500
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
Message-ID: <20220128025152.GA7473@fieldses.org>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>
 <7B388FE8-1109-4EDD-B716-661870B446C7@oracle.com>
 <164332328424.5493.16812905543405189867@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164332328424.5493.16812905543405189867@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 28, 2022 at 09:41:24AM +1100, NeilBrown wrote:
> It's complicated....
> 
> The customer has an HA config with multiple filesystem resource which
> they want to be able to migrate independently.  I don't think we really
> support that, but they seem to want to see if they can make it work (and
> it should be noted that I talk to an L2 support technician who talks to
> the customer representative, so I might be getting the full story).
> 
> Customer reported that even after unexporting a filesystem, they cannot
> then unmount it.  Whether or not we think that independent filesystem
> resources is supportable, I do think that the customer should have a
> clear path for unmounting a filesystem without interfering with service
> provided from other filesystems.  Stopping nfsd would interfere with
> that service by forcing a grace-period on all filesystems.
> The RFC explicitly supports admin-revocation of state, and that would
> address this specific need, so it seemed completely appropriate to
> provide it.

I was little worried that might be the use-case.

I don't see how it's going to work.  You've got clients that hold locks
an opens on the unexported filesystem.  So maybe you can use an NFSv4
referral to point them to the new server.  Are they going to try to
issue reclaims to the new server?  There's more to do before this works.

> As an aside ...  I'd like to be able to suggest that the customer use
> network namespaces for the different filesystem resources.  Each could
> be in its own namespace and managed independently.

Yeah.  Then you're basically migrating the whole server, not just the
one export, and that's more of a solved problem.

> However I don't think we have good admin infrastructure for that do
> we?
> 
> I'd like to be able to say "set up these 2 or 3 config files and run
> systemctl start nfs-server@foo and the 'foo' network namespace will be
> created, configured, and have an nfs server running".  Do we have
> anything approaching that?  Even a HOWTO ??

But I don't think we've got anything that simple yet?

--b.
