Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65A92C1834
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 23:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgKWWIc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 17:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbgKWWIb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 17:08:31 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA70AC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 14:08:31 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 673D96EA1; Mon, 23 Nov 2020 17:08:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 673D96EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606169310;
        bh=W55AoYxNJ/CpsoafMyWVI1TlFciTZ4/fAvic4cXPmLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=om899cufEnuxXgcRhu9UlwiftaF+u6JP6NfQ96u9tcexT2BkvNgSrBoBKQqyMXqf4
         1vhTMd2VrQ2gFKpd90C1NBvrrS2mzVjD9bYDe1t0oD9RyHqyynyUNJT8uhhHLO0K/T
         eNU3VNJflKtAGb/IxOkKIKEi6XUa+MPjJWbKB2kc=
Date:   Mon, 23 Nov 2020 17:08:30 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] NFSv4.2: Fix NFS4ERR_STALE error when doing inter
 server copy
Message-ID: <20201123220830.GJ32599@fieldses.org>
References: <7a18452a-3120-ea5b-f676-9d7e18a65446@oracle.com>
 <470b690f-c919-2c48-95b7-18cc75f71f70@oracle.com>
 <20201110201239.GA17755@fieldses.org>
 <CAN-5tyHEj_nNhN=wM3xkzsAp2RUqQw4pVau+DruFPXGT8j+kuw@mail.gmail.com>
 <20201110215157.GB17755@fieldses.org>
 <CAN-5tyEPvpQQVL+j=4vbfdcKmr96ZpYq3fsCQTZHyS5qWGJsvw@mail.gmail.com>
 <20201110222155.GC17755@fieldses.org>
 <5b395908-8cd4-f93d-421e-68608235b863@oracle.com>
 <20201123162514.GF32599@fieldses.org>
 <05c6adaa-c998-36d3-c66d-da2968941fb8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05c6adaa-c998-36d3-c66d-da2968941fb8@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 23, 2020 at 10:14:51AM -0800, Dai Ngo wrote:
> On 11/23/20 8:25 AM, J. Bruce Fields wrote:
> >I've lost track of what's left to apply.
> 
> I think we're good with this issue.
> There is still one inter server copy related patch waiting for
> your review:
> 
> PATCH] NFSD: Fix 5 seconds delay when doing inter server copy

Looking...  Could you break that up into two fixes, one fof the client,
one for the server?

Also note the RFC is 7862, not 7682.

--b.
