Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6032A441D80
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 16:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhKAPnW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 11:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhKAPnV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 11:43:21 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ACEC061714
        for <linux-nfs@vger.kernel.org>; Mon,  1 Nov 2021 08:40:48 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8B9857034; Mon,  1 Nov 2021 11:40:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8B9857034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1635781246;
        bh=lUAlj8SmXW1dz5UcaM/K2N5iIHzKayzJiaZzz5OKf70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDszVUfe3YrSwQb6SD3+6+f2gv1Ngv7hwE/nzxJ6jxHeafeoAsYkiz97f9d0+QlCF
         HFylZ2FY+E9Mk6+431gIpg5akOkiHLfKjQacufHd5LZnLvR5dF+vbyMaBUf1hHklNu
         veR+VodumGQUehJH52/LEm/1AeJ5BtfT1knQy+So=
Date:   Mon, 1 Nov 2021 11:40:46 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Message-ID: <20211101154046.GA12965@fieldses.org>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
 <20211029164058.GE19967@fieldses.org>
 <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
 <20211029191435.GI19967@fieldses.org>
 <ce34c1f2-a0ad-fcb0-99fa-a1ccea8abfd7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce34c1f2-a0ad-fcb0-99fa-a1ccea8abfd7@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 01, 2021 at 11:30:48AM -0400, Steve Dickson wrote:
> Hey!
> 
> On 10/29/21 15:14, J. Bruce Fields wrote:
> >On Fri, Oct 29, 2021 at 01:30:36PM -0400, Steve Dickson wrote:
> >>On 10/29/21 12:40, J. Bruce Fields wrote:
> >>>Let's just stick with that for now, and leave it off by default until
> >>>we're sure it's mature enough.  Let's not introduce new configuration to
> >>>work around problems that we haven't really analyzed yet.
> >>How is this going to find problems? At least with the export option
> >>it is documented
> >
> >That sounds fixable.  We need documentation of module parameters anyway.
> Yeah I just took I don't see any documentation of module
> parameters anywhere for any of the modules. But by documentation
> I meant having the feature in the exports(5) manpage.

I think I'd probably create a new page for sysctls (this isn't the only
one needing documentation), and make sure it's listed in the "SEE ALSO"
section of the other man pages.

> >>and it more if a stick you toe in the pool verses
> >>jumping in...
> >
> >If we want more fine-grained control, I'm not yet seeing the argument
> >that an export option on the destination server side is the way to do
> >it.
> >
> >Let's document the module parameter and go with that for now.
> Now that cp will use copy_file_range() when available,
> what are the steps needed to enable these fast copies?

1) Make sure client and both servers support NFSv4.2 and
server-to-server copy.

2) Make sure destination server can access (at least for read) any
exports on the source that you want to be able to copy from.

3) echo 1 >/sys/module/nfsd/parameters/inter_copy_offload_enable on the
destination server.

--b.
