Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53872FF7B2
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 23:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbhAUWEt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 17:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbhAUWEn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 17:04:43 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4464BC06174A
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 14:04:03 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 454E868A6; Thu, 21 Jan 2021 17:04:02 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 454E868A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611266642;
        bh=h43W7FTmqyfg2RSyLvT19FxPgsbixDIUEVP3LMIUk7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUfvciCNrSH11VCNOCNNP9eC3QlS7ZcsS+OdUa1HXTo4/ESun8MdfUwYsWejzU9E0
         PPUY8GqD+OlMCowhwkHkLfccxjPACinFYjSDjUN1263ZPN8B1JnHwD6OH1x9sMgZ6X
         gHlAxGhkSweP4EerT7q684pHb5h+yz4kaiju0IAs=
Date:   Thu, 21 Jan 2021 17:04:02 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>,
        "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: nfsd vurlerability submit
Message-ID: <20210121220402.GF20964@fieldses.org>
References: <20210108153237.GB4183@fieldses.org>
 <20210108154230.GB950@1wt.eu>
 <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org>
 <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu>
 <20210112180326.GI9248@fieldses.org>
 <eb09db3a-9b43-cf03-5db4-3af33cb160e6@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb09db3a-9b43-cf03-5db4-3af33cb160e6@math.utexas.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 21, 2021 at 02:01:13PM -0600, Patrick Goetz wrote:
> I didn't respond to this message immediately, but it's been
> bothering me ever since. When I do a bind mount like this in
> /etc/fstab:
> 
>   /data2/xray      /srv/nfs/xray        none    defaults,bind    0
> 
> it's my understanding that the kernel keeps track of the resulting
> /srv/nfs/xray filesystem in it's vfs somehow.  Even when directly on
> the server I can't "break out" of /srv/nfs/xray to get to the other
> directories in /data.  Then how on earth would an NFS client do
> this?

As I said, NFS allows you to look up objects by filehandle (so,
basically by inode number), not just by path.

Also, note, mounting something over a directory doesn't hide what's
under the mountpoint.  And it's unwise to depend on directory
permissions alone to hide contents of anything underneath that
directory.

> I thought the whole point of doing a bind mount like this is to
> solve the problem of exporting leaves of a directory hierarchy. In
> particular,
> 
>   "So in your example, if /data2/xray is on the same filesystem as
>   /data2, then the server will happily allow operations on
>   filehandles anywhere in /data2."
> 
> Yes, sure; but I'm not exporting /data2/xray; I'm exporting
> /srv/nfs/xray, a bind mount to the preceding.  Am I missing
> something, or is NFS too insecure to use in any context requiring
> differentiated security settings on different folders in the same
> directory structure?

Definitely do *not* depend on NFS to enforce different export options on
different subdirectories of the same filesystem.

> It's not practical to making everything you export its own partition;
> although I suppose one could do this with ZFS datasets.

I'd be happy to hear about any use cases where that's not practical.

As Christophe pointed out, xfs/ext4 project ids are another option.

--b.
