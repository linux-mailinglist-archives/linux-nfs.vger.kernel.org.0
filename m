Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D040649FAEF
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jan 2022 14:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349025AbiA1Nip (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jan 2022 08:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349026AbiA1Nio (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jan 2022 08:38:44 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5F9C061714
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jan 2022 05:38:44 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E2E60720F; Fri, 28 Jan 2022 08:38:43 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E2E60720F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643377123;
        bh=h00YH2ugt8Cjr6AewcT6I/6sa/r6OaBvbKvFnoUvMUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbVs4e67BzmVgTegHQA2iLDhpCXBOQQlHcFPeWE2D9dneT5wXzt+WeT92pG+rpfUS
         Lg7itpnXPNsGEhv1YB5RuCutxVIW7ou8AN3UjBI3/q4vlWRwEZUxWffYP44wQSPeXz
         4o9f1Y32LM9dRZlU0804VwWFgAm2emytR++Er2Y8=
Date:   Fri, 28 Jan 2022 08:38:43 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
Message-ID: <20220128133843.GA14908@fieldses.org>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>
 <7B388FE8-1109-4EDD-B716-661870B446C7@oracle.com>
 <164332328424.5493.16812905543405189867@noble.neil.brown.name>
 <20220128025152.GA7473@fieldses.org>
 <164334329191.5493.6897436011766354666@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164334329191.5493.6897436011766354666@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 28, 2022 at 03:14:51PM +1100, NeilBrown wrote:
> On Fri, 28 Jan 2022, J. Bruce Fields wrote:
> > I don't see how it's going to work.  You've got clients that hold locks
> > an opens on the unexported filesystem.  So maybe you can use an NFSv4
> > referral to point them to the new server.  Are they going to try to
> > issue reclaims to the new server?  There's more to do before this works.
> 
> As I hope I implied, I'm not at all sure that the specific problem that
> the customer raised (cannot unmount a filesystem) directly related to
> the general solution that the customer is trying to create.  Some
> customers like us to hold their hand the whole way, others like to (feel
> that they) have more control.  In general I like to encourage
> independence (but I have to consciously avoid trusting the results).
> 
> We have an "unlock_filesystem" interface.  I want it to work for NFSv4. 
> The HA config was background, not a complete motivation.

I think people do occasionally need to just rip a filesystem out even if
it means IO errors to applications.  And we already do this for NFSv3.
So, I'm inclined to support the idea.

(I also wonder whether some of the code could be a useful step towards
other functionality.)

> > > However I don't think we have good admin infrastructure for that do
> > > we?
> > > 
> > > I'd like to be able to say "set up these 2 or 3 config files and run
> > > systemctl start nfs-server@foo and the 'foo' network namespace will be
> > > created, configured, and have an nfs server running".  Do we have
> > > anything approaching that?  Even a HOWTO ??
> > 
> > But I don't think we've got anything that simple yet?
> 
> I guess I have some work to do....

RHEL HA does support NFS failover using containers.  I think it's a bit
more complicated than you're looking for.  Let me go dig that up....

With a KVM VM and shared backend storage I think it's pretty easy: just
shut down the VM on one machine and bring it up on another.

--b.
