Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC73380B62
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 16:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhENOQs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhENOQa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 10:16:30 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FD7C0613ED
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:15:14 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E89EA4183; Fri, 14 May 2021 10:15:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E89EA4183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1621001712;
        bh=1NLcXjtfgwgV56CEQmRbMkvbafcYpkKEluRBkVN4fG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQGnhBWnQiZ+a2sat9W9uQa6J1SOeQATNQnoI7h4/TeuHokKj4tEu+FuVfQmpX0U8
         ufRBuT7NbNtpnJyW5ukXHnIBNRsYOwCTW1RCW7LNgawg9UlPxl2iC+FjU07y5N75G2
         OeUBINn0msP4N82tzP9sFRovVp4HIIbMm2W1uoVA=
Date:   Fri, 14 May 2021 10:15:12 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/1] Add callback address and state to nfsd client info
Message-ID: <20210514141512.GA9256@fieldses.org>
References: <1620999041-9341-1-git-send-email-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620999041-9341-1-git-send-email-dwysocha@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 14, 2021 at 09:30:40AM -0400, Dave Wysochanski wrote:
> For troubleshooting, it is useful to show the callback address and state,
> even though we do have this equivalent info inside Chuck's ftrace patches.

Good idea.

> Note there is a show_cb_state() inside fs/nfsd/trace.h and this code
> has a similar function.  It may be better to consolidate these two
> if these additions are ok for nfsd client info, but not sure where
> a good header is to place it - do we need a new file, maybe
> fs/nfsd/nfs4callback.h?

nfs4state.c already includes trace.h, do we need anything more?

I'll admit I've just been adding things wherever seems expedient for a
while, so there may be some more logical way to organize nfsd headers.

--b.

> 
> Dave Wysochanski (1):
>   nfsd4: Expose the callback address and state of each NFS4 client
> 
>  fs/nfsd/nfs4state.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> -- 
> 1.8.3.1
