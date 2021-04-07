Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABC3357542
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Apr 2021 21:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355783AbhDGTzs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Apr 2021 15:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355787AbhDGTzo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Apr 2021 15:55:44 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6B1C06175F
        for <linux-nfs@vger.kernel.org>; Wed,  7 Apr 2021 12:55:34 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B6A4E6191; Wed,  7 Apr 2021 15:55:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B6A4E6191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1617825333;
        bh=UBy3jsAQpHRcVRqL7uDWz1r1LW3o05ljvE8KQsiZeZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qGozcNFhfyD2EN6Ra+u3q7MtKiGODLJJn8rcOfs351eRMLYimDBkO7sT+hd5e+LVM
         GArZG6u2OU1tzQ0SSvghfhVXZK0+X2zyLs1HahmLscs3cTIpY5J7D61up5Prp4VjDh
         yj8MnjStgTzdT94tiwKrq6KH0fJZ0xNRvLRcB1Yk=
Date:   Wed, 7 Apr 2021 15:55:33 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <SteveD@RedHat.com>
Cc:     NeilBrown <neilb@suse.de>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
Message-ID: <20210407195533.GB3663@fieldses.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
 <20210319132820.GA31533@fieldses.org>
 <87lfaieuoj.fsf@notabene.neil.brown.name>
 <20210319210922.GD31533@fieldses.org>
 <20210407191451.GA3663@fieldses.org>
 <f62bdd53-eb2c-604e-8168-3ef9e9076253@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f62bdd53-eb2c-604e-8168-3ef9e9076253@RedHat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 07, 2021 at 03:33:41PM -0400, Steve Dickson wrote:
> 
> 
> On 4/7/21 3:14 PM, J. Bruce Fields wrote:
> > On Fri, Mar 19, 2021 at 05:09:22PM -0400, J. Bruce Fields wrote:
> >> On Sat, Mar 20, 2021 at 07:48:44AM +1100, NeilBrown wrote:
> >>> For NFSv4.1, only the EXCHANGE_ID is duplicate.  There is only one
> >>> CREATE_SESSION, and that is where the client is confirmed.  So only one
> >>> confirmed client.
> >>>
> >>> For NFSv4.0 bother SETCLIENTID and SETCLIENDID_CONFIRM are duplicate.
> >>> So maybe both clients get confirmed.  I should check that.
> >>
> >> Drifting off topic, but I don't see how this client behavior makes
> >> sense.  Mount is chatty enough without the unnecessary duplication.
> >> Looking at the code....
> > 
> > I never sorted this out, by the way.  I think there must be a bug,
> > though.
> My bad... I didn't realize you had concern with the patch... 
> What needs to happen... to figure this out?

Sorry, it wasn't a concern with Neil's patches.

The thing I don't understand is why the client is sending these calls
twice.  Anyway, that's more-or-less harmless behavior, and in kernel
code, nothing to do with nfs-utils.

--b.
