Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5D84930AD
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jan 2022 23:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349930AbiARW1E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 17:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349928AbiARW1E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jan 2022 17:27:04 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC9C06161C
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jan 2022 14:27:04 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8BE8C1C25; Tue, 18 Jan 2022 17:27:03 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8BE8C1C25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642544823;
        bh=aCSF97NkiZ1bft6aTnScqCgL6vxjGWtYbKRM7iFoSxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbuFiZSd6JoLcfyURBotgzgNy9AUkJvHxuc/7DlkvFLF9wtB0xmNPu5JBYH272URN
         PUBWrmLerowUQq0/GhLatsi6uVOppDTYnbVSaIfTa1DsLfybzwUN6Yb8ketCEs3oya
         lruY7Dy/9+a1i1O1BvfXaZKWhW70sZoR/eXSX82I=
Date:   Tue, 18 Jan 2022 17:27:03 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Jonathan Woithe <jwoithe@just42.net>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] lockd: fix server crash on reboot of client holding
 lock
Message-ID: <20220118222703.GD16108@fieldses.org>
References: <20220115081420.GB8808@marvin.atrad.com.au>
 <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
 <20220115212336.GB30050@marvin.atrad.com.au>
 <20220116220627.GA19813@marvin.atrad.com.au>
 <1E71316C-9EE8-4C71-ADA1-71E2910CA070@oracle.com>
 <20220117074430.GA22026@marvin.atrad.com.au>
 <20220117220851.GA8494@marvin.atrad.com.au>
 <20220117221156.GB3090@fieldses.org>
 <20220118220016.GB16108@fieldses.org>
 <20220118222050.GB30863@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118222050.GB30863@marvin.atrad.com.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 19, 2022 at 08:50:50AM +1030, Jonathan Woithe wrote:
> On Tue, Jan 18, 2022 at 05:00:16PM -0500, Bruce Fields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > I thought I was iterating over the array when actually the iteration is
> > over the values contained in the array?
> > :
> 
> Would you like me to apply this against a 5.15.x kernel and test locally? 
> Or should I just wait for a 5.15.x stable series update which includes it?

I'm pretty confident I'm reproducing the same problem you saw, so it'd
be fine to just wait for an update.

(But if you do test these patches, let us know, one more confirmation
never hurts.)

--b.
