Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05914422C49
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 17:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhJEPYQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbhJEPYP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Oct 2021 11:24:15 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C05C061749
        for <linux-nfs@vger.kernel.org>; Tue,  5 Oct 2021 08:22:25 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8A8EA3F53; Tue,  5 Oct 2021 11:22:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8A8EA3F53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633447344;
        bh=xj+QUcgK10iaOv9G1rSXMHiNc9xsEmXGHVd1fVyysc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WuC76q3nfHqtqkvrIVfJ+h2U2FzHZEnFAdN+/dOV2iKF/6HlPnp7X7Jhjrsf/7Y9/
         iXk7tvh5cpMVz0P3iFzD20hKRnQCsAgQca61loSapxLtQonz4LpDuKfYKXw/IBErK2
         Gp4jgqgkP43KQRkEwW4DJ6zQGRDVcZH5W2VeIAdk=
Date:   Tue, 5 Oct 2021 11:22:24 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] st_courtesy.py: add more tests for Courteous Server
Message-ID: <20211005152224.GA23210@fieldses.org>
References: <20211004225320.25368-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004225320.25368-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 04, 2021 at 06:53:20PM -0400, Dai Ngo wrote:
> COUR3: Test OPEN file with OPEN4_SHARE_DENY_WRITE
> COUR4: Test Share Reservation. Test 2 clients with same deny mode
> COUR5: Test Share Reservation. Test Courtesy client's file access mode
>        conflicts with deny mode
> COUR6: Test Share Reservation. Test Courtesy client's deny mode conflicts
>        with file access mode

Thanks!

> @@ -73,6 +76,8 @@ def testLockSleepLock(t, env):
>  
>      c2 = env.c1.new_client(b"%s_2" % env.testname(t))
>      sess2 = c2.create_session()
> +    res = sess2.compound([op.reclaim_complete(FALSE)])
> +    check(res)

Nit: this is a separate bugfix, right?  I'd rather have that kind of
thing in a separate patch.

Also, you could just use new_client_session().

--b.
