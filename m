Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BF23A8561
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jun 2021 17:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhFOPzK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 11:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhFOPxH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 11:53:07 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03CEC061149
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 08:50:08 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 58ED56210; Tue, 15 Jun 2021 11:50:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 58ED56210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1623772207;
        bh=MUKQWqA9OMR8veuTiMlJeo1ol+afe5Ti0C22ouRUF+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AhBM/OSQlJVMzF70bW7SETpOZTf9Wbj/4KExzT0o/bQmTpt0g7wh27/QcLJ1gG7n0
         luvn9uE377LzhuCQQbuUDKKfeN0RyXLBe7dNDkxto2zn1ipDjz9rnM7fC+xPzWcWVS
         KCtK6vtqdkPoopwlcIK85Bv56YQr9EjoM0Fk/Hik=
Date:   Tue, 15 Jun 2021 11:50:07 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Calum Mackay <calum.mackay@oracle.com>
Cc:     "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH] pynfs: courtesy: send RECLAIM_COMPLETE before session2
 opening the file
Message-ID: <20210615155007.GD11877@fieldses.org>
References: <TY2PR01MB2124D8FDDDCA29F5691F3DD089359@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <91f1d7df-b63c-4aa3-cc03-a8e1cbb2ecb1@oracle.com>
 <20210615144724.GB11877@fieldses.org>
 <3f7ee699-bbd6-9025-82b5-40c37cbb6d9c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f7ee699-bbd6-9025-82b5-40c37cbb6d9c@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 15, 2021 at 04:38:15PM +0100, Calum Mackay wrote:
> I wasn't quite sure on the semantics of those calls.
> 
> We want what appears to the server to be a new client c2, not a new
> session from an existing client c1. I wasn't sure whether
> new_client_session() would give us that?

Yes, it gets you both a new client and a new session for that client.
It does all the stuff you need to get a new client that you can actually
use for normal operations, so it should be the default unless you need
finer control.

(Also, *eventually*, I want to port all the 4.0 tests to the 4.1 code
and eliminate the separate 4.0/4.1 directories.  new_client_session will
then do either exchange_id+create_session+reclaim_complete or
setclientid+setclient_confirm depending on minor version.)

Anyway, so the names are totally unhelpful.  Maybe we should reanme
new_client to exchange_id and new_client_session to just new_client.

--b.
