Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F542E015E
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Dec 2020 21:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgLUUAw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Dec 2020 15:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgLUUAw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Dec 2020 15:00:52 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B682C0613D3
        for <linux-nfs@vger.kernel.org>; Mon, 21 Dec 2020 12:00:11 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 16CB76EB8; Mon, 21 Dec 2020 15:00:11 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 16CB76EB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1608580811;
        bh=/K1YichYRuhtFKjlXX0BOpzl5RPSJw643400eiyqhuc=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=WpdUjJY7h6IQFK6vv06GG+sdqtGwUJhfyeTtXFDKX99LhXOI48y0ya+cFH2AqCbSi
         dBsFFu2k+jdXidfJPzMZk1E8RymWPVwJFzL5SQORyTG95kkFgu4OoQd5Cuu90/SBsw
         Dk7Yp1b2c9IAuZCNIrn6mrvsG6nP4+6ml7c2fQlU=
Date:   Mon, 21 Dec 2020 15:00:11 -0500
To:     Tom Haynes <loghyr@gmail.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [pynfs python3 0/7] Python3 patches for st_flex.py
Message-ID: <20201221200011.GB27606@fieldses.org>
References: <20201219182948.83000-1-loghyr@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201219182948.83000-1-loghyr@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Dec 19, 2020 at 10:29:41AM -0800, Tom Haynes wrote:
> From: Tom Haynes <loghyr@excfb.com>
> 
> Hey Bruce,
> 
> This applies on top of the previous patch set.
> 
> This passes on my RHEL 8.2 client running python3 against a Hammerspace
> server.

Thanks, and thanks to Tigran for testing; applied.--b.

> 
> Thanks,
> Tom
> 
> fwiw - In some of the error paths, the system would complain that the
> exception StandardError was not defined.
> 
> I found this:
> https://portingguide.readthedocs.io/en/latest/exceptions.html#the-removed-standarderror
> 
> Tom Haynes (7):
>   CB_LAYOUTRECALL: Make string a byte array
>   st_flex: Use NFS4_MAXFILELEN in layout calls
>   st_flex: Provide an empty ff_layoutreturn4 by default for LAYOUTRETURN
>   st_flex: Use range instead of xrange for python3
>   st_flex: Test is now redundant
>   st_flex: Return the layout before closing the file
>   st_flex: testFlexLayoutStatsSmall needed loving to pass python3
> 
>  nfs4.1/nfs4client.py            |   2 +-
>  nfs4.1/server41tests/st_flex.py | 124 +++++++++++++++++---------------
>  2 files changed, 68 insertions(+), 58 deletions(-)
> 
> -- 
> 2.26.2
