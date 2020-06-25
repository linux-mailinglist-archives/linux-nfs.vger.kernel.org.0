Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6C720A65A
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2020 22:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbgFYUHU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jun 2020 16:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388615AbgFYUHU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Jun 2020 16:07:20 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10855C08C5C1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2020 13:07:20 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 381C1BD0; Thu, 25 Jun 2020 16:07:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 381C1BD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1593115639;
        bh=ToNVmCsavYQcR+1vX03cWIfZbL2FhrOBS1OV0sY+CNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3Q8yvyo4Fboqu7hae/qNpRQJxl2c+/m/P4UijZwX+qVXV55k+C/v5K7+Cz1/rT6d
         zJiJi3F8M0bybTBZ1eIAlRSi33OghC5dZf/JR3fxxu9zWRxzkHgmgpeq8MU7Nt7kA5
         ZS1iM9/YEQDcUmWJ12/u8a/a1HZzye7XIDfvCtDg=
Date:   Thu, 25 Jun 2020 16:07:19 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 00/10] server side user xattr support (RFC 8276)
Message-ID: <20200625200719.GB6605@fieldses.org>
References: <20200623223927.31795-1-fllinden@amazon.com>
 <20200625165347.GB30655@fieldses.org>
 <20200625173916.GB29600@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625173916.GB29600@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 25, 2020 at 05:39:16PM +0000, Frank van der Linden wrote:
> On Thu, Jun 25, 2020 at 12:53:47PM -0400, J. Bruce Fields wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > By the way, I can't remember if I asked this before: is there a
> > particular use case that motivates this xattr work?
> 
> There's one use case that I can't really talk about publicly at this point
> (and it's not my code either, so I wouldn't have all the details). Nothing
> super secret or anything - it's just something that is not mine,
> so I won't try to speak for anyone. We wanted to get this upstreamed first,
> as that's the right thing to do.
> 
> Since I posted my first RFC, I did get contacted off-list by several
> readers of linux-nfs who wanted to use the feature in practice, too, so
> there's definitely interest out there.

Yeah, I always hear a lot of interest but then have trouble sorting
through it for the cases that are actually *user* xattr cases, where the
server has to just act as a dumb store of the values.

There are some.  But unfortunately xattrs are best known for enabling
selinux and posix acls, and to a lesser extent accessing random other
filesystem features, so that tends to be what comes to people's minds
first, though it's not what we're doing.

--b.
