Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC333B86C1
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 18:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhF3QIN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 12:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbhF3QIM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 12:08:12 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1094CC061756
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jun 2021 09:05:43 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 962A56482; Wed, 30 Jun 2021 12:05:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 962A56482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1625069142;
        bh=hFux6baM8u5np5HchDB/AtLhHlH6fHd6OrElJ/shkAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSu253jmVxX4DIZ1dsQcGFtLl9YXK5bOtI5oraagDwo246dhXuAg1yRTq2l0htzqd
         JwZSnOe8KWDd2c7yQBkdo49YthLAaoUiinjJG1w9XHM/fymvZPaD4UBCMNpUc4wsup
         EYdsR3+k3kYWr/UyAvaW6iw2dCilsxD2DvZW5RPs=
Date:   Wed, 30 Jun 2021 12:05:42 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: 5.13 NFSD: completely broken?
Message-ID: <20210630160542.GD20229@fieldses.org>
References: <20210630155325.GD22278@shell.armlinux.org.uk>
 <1BF34FA4-EC1A-405D-AA8B-217BF94DA219@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1BF34FA4-EC1A-405D-AA8B-217BF94DA219@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 30, 2021 at 03:55:16PM +0000, Chuck Lever III wrote:
> > On Jun 30, 2021, at 11:53 AM, Russell King (Oracle) <linux@armlinux.org.uk> wrote:
> > Has 5.13 been tested with nfsv3 ?
> > 
> > Any ideas what's going on?
> 
> Yes, fortunately!
> 
> Have a look at commit 66d9282523b for a one-liner fix, it should apply
> cleanly to v5.13.

So was this a freak event or do we need some process change?

Looks like the problem commit went in 3 days before 5.13.  It was an mm
commit so they're probably not set up to do nfsd testing, but nfsd is
the only user of that function, right?

It says it fixed a bug that could result in writing past the end of an
array, so made sense that it was urgent.

Sorry, just catching up!

--b.
