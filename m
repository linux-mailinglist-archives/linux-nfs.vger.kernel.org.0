Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A4F2DE515
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Dec 2020 15:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgLROqu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Dec 2020 09:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgLROqt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Dec 2020 09:46:49 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A165C06138C
        for <linux-nfs@vger.kernel.org>; Fri, 18 Dec 2020 06:46:09 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6409C6E94; Fri, 18 Dec 2020 09:46:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6409C6E94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1608302765;
        bh=Q+jmmyDlfF/V8OTgLzJ/+0dwA7peN1s16Hdcp75y0Hc=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=cDOjXXXTXQx87vxc77RE812o4F2B/7Nss+FSjVFlnup4u5k4aiveu76vw7ISoEq+8
         kRmSTXvxjIa34c9TLQhe/8WYPq2pLyeVLbL6Mo8/Bmn3l6mKPPehU230emnd22a4qu
         /6MN7qtGBj+4WPT222iCcCB98hCKbYPcFM79La1Y=
Date:   Fri, 18 Dec 2020 09:46:05 -0500
To:     Tom Haynes <loghyr@gmail.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [pynfs 00/10] Misc Fixes, primarily LAYOUTRETURN
Message-ID: <20201218144605.GB1258@fieldses.org>
References: <20201217003516.75438-1-loghyr@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217003516.75438-1-loghyr@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 16, 2020 at 04:35:06PM -0800, Tom Haynes wrote:
> Hi Bruce,
> 
> Here are a series of patches that Hamerspace has applied to the
> flex files testing.

Thanks, applying.

I'm pretty hands-off when it comes to pynfs tests I don't personally
run.  If they work for you then I'm probably fine with them....

--b.

> 
> Thanks,
> Tom
> 
> Jean Spector (2):
>   st_flex.py - Added tests for LAYOUTRETURN with errors
>   st_flex.py - Fixed flag names
> 
> Tom Haynes (7):
>   Close the file for SEQ10b
>   flexfiles: Fix up the layout error handling to reflect the previous
>     error
>   st_flex: Reduce the layoutstats period to make tests finish in a sane
>     time
>   st_flex: Fix up test names
>   st_flex: Only do 100 layoutget/return in loop
>   st_flex: We can't return the layout without a layout stateid
>   st_flex: Fixup check for error in layoutget_return()
> 
> Trond Myklebust (1):
>   Fix testFlexLayoutOldSeqid
> 
>  nfs4.1/server41tests/st_flex.py     | 651 +++++++++++++++++++++++++---
>  nfs4.1/server41tests/st_sequence.py |   5 +
>  2 files changed, 588 insertions(+), 68 deletions(-)
> 
> -- 
> 2.26.2
