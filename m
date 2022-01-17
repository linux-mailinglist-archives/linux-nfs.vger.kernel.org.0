Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811664911D0
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jan 2022 23:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbiAQWh7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jan 2022 17:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiAQWh6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jan 2022 17:37:58 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C53C061574
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jan 2022 14:37:58 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8510D6214; Mon, 17 Jan 2022 17:37:57 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8510D6214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642459077;
        bh=HWXOySzTesOCkNmgc0zsrIXi2KkHFJTM8RONB7hMfdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gs1CrRkQgG5aFqASU6pRgEEdjZJbIXpvuqCcm0K5bpQhLCCPbdTQtpB27P7EdZwCn
         AgL1jsX23Em+EP7TDboFyHb2qwfOzP63PxeDiAMEE/6ZF/zYwKAsPX0U+FM4tdV6oI
         tps798sS3OOUDgvgA4TUj53CAf6eBs1OvZ2KDvpg=
Date:   Mon, 17 Jan 2022 17:37:57 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chris Chilvers <chilversc@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [bug report] Resolving symlinks ignores rootdir setting
Message-ID: <20220117223757.GC3090@fieldses.org>
References: <CAAmbk-f7B4jfmhe-aH26E0eRQnOxGGFPr3yHZMv0F4KQc6FVdg@mail.gmail.com>
 <20220114151022.GA17563@fieldses.org>
 <CAAmbk-e1Pd0JaAVM8PFbeepj=tdL8qcyS-DaSA1u42=S_EySSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAmbk-e1Pd0JaAVM8PFbeepj=tdL8qcyS-DaSA1u42=S_EySSQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 14, 2022 at 03:57:03PM +0000, Chris Chilvers wrote:
> > I'm probably just reading too quickly, but I'm not seeing how this
> > explains the problems with your original configuration.
> >
> > Is it that /sr/nfs/bin on you system is a symlink?  (And what exactly is
> > the content of that symlink?)
> 
> No, all the directories under /srv/nfs are ordinary directories. The symlinks
> are in the root of the real file system.

Oh, got it, thanks for the explanation.

> So I have:
>   /bin -> /usr/bin
>   /software -> /usr/lib (created to test the hypothesis)
>   /srv/nfs/
>   /srv/nfs/assets
>   /srv/nfs/bin
>   /srv/nfs/software
> 
> Because exportfs is not taking into account the rootdir setting, when it tries
> to resolve the path from /etc/exports, it sees the path /bin, and matches that
> with the real /bin, and resolves it to /usr/bin.
> 
> Later exportfs errors when trying to resolve the real path (e_realpath) in the
> exportent_mkrealpath function, as this function does prepend the rootdir. This
> causes exportfs to look for /srv/nfs/usr/bin instead of the expected
> /srv/nfs/bin.
> 
> At best this causes an error, but if that does happen to match an existing path
> under /srv/nfs then it would export the wrong directory.
> 
> This will happen for any export that happens to match an existing symlink.
> 
> There are two issues though that I'm not sure how best to handle:
> * Should the symlink be considered relative to the local system or relative to
>   the rootdir?
> * What happens if the symlink points to a directory outside the rootdir?

Yes, I'm not sure off hand what the right behavior is, but the existing
behavior certainly seems to violate the principal of least surprise.

--b.

> 
> In my case I think the symlink would need to be resolved relative to the
> rootdir. This is because we're re-exporting an existing NFS server, so if the
> existing NFS server is exporting some kind of symlink tree, the symlinks would
> be relative to the existing mounts.
> 
> One option that would be valid for my case would be an setting to disable
> symlink resolution and just consider it an error if an export is a symlink.
> Since I'm re-exporting an existing NFS server, they can't be symlinks anyway.
> 
> -- Chris
