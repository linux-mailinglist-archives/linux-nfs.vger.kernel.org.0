Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80853F8E9C
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 21:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhHZTRt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 15:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243421AbhHZTRs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 15:17:48 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CADC061757;
        Thu, 26 Aug 2021 12:17:01 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6B02D64B9; Thu, 26 Aug 2021 15:17:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6B02D64B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1630005420;
        bh=O4lrRkOAkCOCiu+xyrLxmjyWeL8QhTEnxGMRZIS8O3Y=;
        h=Date:To:Cc:Subject:From:From;
        b=AXNqWWGX+kQ8d819w58/ee9SjDgYzKaZA7s2JZT8NcWqKeCdOfM0kD2krZqMgCh4c
         xVojfilnoRgFZOtVQeR1sXgWwaqNiqDnoAsNny35j+HfkFiBy4bAr74sMkC2Ppie3g
         CXDt6+fUd4QagrDsuLu4yEpTUCMiEVtYWxCQrs3g=
Date:   Thu, 26 Aug 2021 15:17:00 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] nfsd bugfix for 5.14
Message-ID: <20210826191700.GA10730@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Please pull:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.14-1

for an nfsd change for 5.14.

This is a one-liner fix for a serious bug that can cause the server to
become unresponsive to a client, so I think it's worth the last-minute
inclusion for 5.14.

--b.

Trond Myklebust (1):
      SUNRPC: Fix XPT_BUSY flag leakage in svc_handle_xprt()...

 net/sunrpc/svc_xprt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
