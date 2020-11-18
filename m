Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94292B8031
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Nov 2020 16:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgKRPPO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Nov 2020 10:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgKRPPO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Nov 2020 10:15:14 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406A5C0613D4;
        Wed, 18 Nov 2020 07:15:14 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1BCB720A8; Wed, 18 Nov 2020 10:15:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1BCB720A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1605712513;
        bh=mSxGFZ77x4zkqvjZTkBj8s+vuNZp2OuVj35/dlAfrCQ=;
        h=Date:To:Cc:Subject:From:From;
        b=KpmpzR1jOiLZydUe8HdKYUTyiOb9HYznc+vXGaiEUu8xCMI/FbP7/VuXvYJSjo55K
         c3JK/EAgF9y7z7DT2A2rYxcEKD8mcr38zE2NlP3pfgCosHGr9lrgSNKdS/wf05ya2+
         l14fn3ACHhrtyqtKInZebstVhDRw5VjF1nB/FTFk=
Date:   Wed, 18 Nov 2020 10:15:13 -0500
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [GIT PULL] nfsd bugfix for 5.10
Message-ID: <20201118151513.GC7320@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Please pull

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.10-2

Just one quick fix for a tracing oops.

--b.

----------------------------------------------------------------
Scott Mayhew (1):
      SUNRPC: Fix oops in the rpc_xdr_buf event class

 include/trace/events/sunrpc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
