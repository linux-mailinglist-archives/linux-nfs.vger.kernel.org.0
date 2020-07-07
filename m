Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDD2217300
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2020 17:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgGGPvY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jul 2020 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGPvX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jul 2020 11:51:23 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F754C061755
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2020 08:51:23 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 269ECBC3; Tue,  7 Jul 2020 11:51:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 269ECBC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1594137082;
        bh=ZvW99hgpx56GKJebFXQam1QFHaUXySvlP2av/TdA6Ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkbIFnJQ3dw8kHGI401m++OO9TdqymQYnkyvg3zGJHHgWS7Sf4FZ7MvZrTVoDU9OB
         MWLgLYyqBV2Fcu5CkcziGZT/VZL2Hz1bwymqMI3W5ppdVkTE2h5zZPTOTP9Zm+65jf
         mHb1tJmXnuopbhbvHLux/+VPVU62zFxONuANwN+s=
Date:   Tue, 7 Jul 2020 11:51:22 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: kerberized NFSv4 client reporting operation not permitted when
 mounting with sec=sys
Message-ID: <20200707155122.GA26678@fieldses.org>
References: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
 <9e25861022acb796c35d3adb392bf4c4@kngnt.org>
 <c058f370-9f7c-146d-e7e6-a3f88b62cbc4@oracle.com>
 <4097833.BOCuNxM56l@polaris>
 <20200706171804.GA31789@fieldses.org>
 <4fe2af1f-917e-c1e4-f5e6-05eb0c121511@math.utexas.edu>
 <20200706202712.GA32161@fieldses.org>
 <b96b9bdd-3fbd-2e54-c036-fb8813287ca2@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b96b9bdd-3fbd-2e54-c036-fb8813287ca2@math.utexas.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 07, 2020 at 10:10:07AM -0500, Patrick Goetz wrote:
> 
> 
> On 7/6/20 3:27 PM, J. Bruce Fields wrote:
> >On Mon, Jul 06, 2020 at 02:57:52PM -0500, Patrick Goetz wrote:
> >>On 7/6/20 12:18 PM, J. Bruce Fields wrote:
> >>>
> >>>Note, by the way, that fsid=0 thing was required for nfsv4 exports years
> >>>ago, but no longer is.  It's usually better not to bother with that.
> >>
> >>Are we ever going to get some solid up-to-date NFSv4/pNFS
> >>documentation?  I'm sufficiently frustrated to write it myself, but
> >>am not 100% sure where to start.
> >
> >I guess the places I'd start would be the man pages (original source is
> >nfs-utils, git://linux-nfs.org/~steved/nfs-utils) or wiki.linux-nfs.org.
> >
> >But, I don't know, you may be in a better place to position to know what
> >gaps you want filled--where are you looking for documentation, and what
> >are you not finding?
> >
> >--b.
> >
> 
> Well, a good example is the fsid=0 thing. Where is it documented
> that this is no longer needed?  I'm 100% certain I've read through
> all the man pages I could find several times.

For man pages, this belongs in exports(5).  Looks like the description
of the "fsid" option in exports(5) is out of date.

Might also be worth googling around to see if there are some HOWTO's out
there that could be updated.

You can find out when the change was made by grepping for
"NFSEXP_V4ROOT" in kernel and nfs-utils source.  Looks like it was 2009,
kernel and nfs-utils versions 2.6.33 and 1.2.2 respectively.

--b.
