Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AE53CA19F
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 17:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbhGOPsa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 11:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbhGOPsa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jul 2021 11:48:30 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31629C06175F;
        Thu, 15 Jul 2021 08:45:37 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 033DF69D6; Thu, 15 Jul 2021 11:45:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 033DF69D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1626363935;
        bh=um4FevvC0GtfFwF+FGlJuSPjool50OiKU6H5RtnTrj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cq6Lk/d7wbZIHoGu+OoGye3oJ6Xznfft79zYQYSSSG5phg6puHj0kc4NiV4Sih7m9
         X/60woOWJiB9I4y5dm5YfuzFM8nntYI5827nVBgv7LDrwxb8c90x+LN7xONxbIW7Ts
         72FXCcHiTqOddWmTZfB7VZDaLo2UQ2ZFhgVQR0lw=
Date:   Thu, 15 Jul 2021 11:45:34 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
Message-ID: <20210715154534.GA24492@fieldses.org>
References: <20210613115313.BC59.409509F4@e16-tech.com>
 <20210310074620.GA2158@tik.uni-stuttgart.de>
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162632387205.13764.6196748476850020429@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 15, 2021 at 02:37:52PM +1000, NeilBrown wrote:
> To fix this, we need to report a different fsid for each subvolume, but
> need to use the same fsid that we currently use for the top-level
> volume.  Changing this (by rebooting a server to new code), might
> confuse the client.  I don't think it would be a major problem (stale
> filehandles shouldn't happen), but it is best avoided.
...
> Again, we really want an API to get this from the filesystem.  Changing
> it later has no cost, so we don't need any commitment from the btrfs team
> that this is what they will provide if/when we do get such an API.

"No cost" makes me a little nervous, are we sure nobody will notice the
mountd-on-fileid changing?

Fileid and fsid changes I'd worry about more, though I wouldn't rule it
out if that'd stand in the way of a bug fix.

Thanks for looking into this.

--b.
