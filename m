Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36F4E68AB
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Mar 2022 19:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343658AbiCXS3u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352621AbiCXS3t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 14:29:49 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D1E1102
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 11:28:06 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id D90356217; Thu, 24 Mar 2022 14:28:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D90356217
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1648146485;
        bh=zmgImIrHcr5DBCvR/GakJAG+PUiS0fLuEUZtEIZtt/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vhjfa/yy6ChS0tYT1p5PBwszic5RQv8zIfPxldQ+YQWPswQ77HnROU37IEmI1xnXG
         HR7fH5i7/jB0k8J7/UwT6VyGoSo5dcbDj38lf0cVOfjxdUEy230DgdRWrnfVFlQZ3s
         bP15rY9g0PC4rmOn+IbnEWPI1jNVeEjtD4797ghs=
Date:   Thu, 24 Mar 2022 14:28:05 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Jonathan Woithe <jwoithe@just42.net>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] lockd: fix server crash on reboot of client holding
 lock
Message-ID: <20220324182805.GA28045@fieldses.org>
References: <20220115212336.GB30050@marvin.atrad.com.au>
 <20220116220627.GA19813@marvin.atrad.com.au>
 <1E71316C-9EE8-4C71-ADA1-71E2910CA070@oracle.com>
 <20220117074430.GA22026@marvin.atrad.com.au>
 <20220117220851.GA8494@marvin.atrad.com.au>
 <20220117221156.GB3090@fieldses.org>
 <20220118220016.GB16108@fieldses.org>
 <20220118222050.GB30863@marvin.atrad.com.au>
 <20220118222703.GD16108@fieldses.org>
 <20220323233323.GI2179@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323233323.GI2179@marvin.atrad.com.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 24, 2022 at 10:03:23AM +1030, Jonathan Woithe wrote:
> On Tue, Jan 18, 2022 at 05:27:03PM -0500, Bruce Fields wrote:
> > On Wed, Jan 19, 2022 at 08:50:50AM +1030, Jonathan Woithe wrote:
> > > On Tue, Jan 18, 2022 at 05:00:16PM -0500, Bruce Fields wrote:
> > > > From: "J. Bruce Fields" <bfields@redhat.com>
> > > > 
> > > > I thought I was iterating over the array when actually the iteration is
> > > > over the values contained in the array?
> > > > :
> > > 
> > > Would you like me to apply this against a 5.15.x kernel and test locally? 
> > > Or should I just wait for a 5.15.x stable series update which includes it?
> > 
> > I'm pretty confident I'm reproducing the same problem you saw, so it'd
> > be fine to just wait for an update.
> > 
> > (But if you do test these patches, let us know, one more confirmation
> > never hurts.)
> 
> The shift back to a 5.15.x kernel ended up being delayed for a while for
> various reasons.  The server concerned was eventually upgraded to 5.15.27 on
> 9 March 2022.  In that time, client machines have been turned on and off and
> inevitably the conditions which caused the crash have been exercised many
> times (libreoffice, firefox and thunderbird are used daily on almost all of
> the clients).  The server has not experienced the crash since the upgrade. 
> On the basis of this I think it's fair to consider our problem solved.

Thanks for the confirmation.--b.
