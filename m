Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A689547370F
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 22:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243407AbhLMVzw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 16:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243393AbhLMVzv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Dec 2021 16:55:51 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA025C061574
        for <linux-nfs@vger.kernel.org>; Mon, 13 Dec 2021 13:55:51 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id A51B36CDC; Mon, 13 Dec 2021 16:55:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A51B36CDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1639432550;
        bh=0mkISAsOLdQz6Pl18tGKngoJYMdMXtN//aOO9EeQHeU=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=PnGg1aSwBuCBYsUyNIf0R8YWSUAZZTnuFXeWMcq0WOOcnKc1QARwaOo9RyYZ9Dom9
         R26NQnj2Ez2RMom3JC7UrpMfPkbxBtHlhTx91N8qp1YUmIRsB9g832XV3zU4A9c63E
         Zjt9v8i0razr5V3oXgcRsMjJHudMlGP3uoyLfzqo=
Date:   Mon, 13 Dec 2021 16:55:50 -0500
To:     "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [bug report] nfs clients fail to get read delegations after file
 open with O_RDWR
Message-ID: <20211213215550.GA2230@fieldses.org>
References: <OS3PR01MB7705959736BA3A5BDF9C0AFD89749@OS3PR01MB7705.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB7705959736BA3A5BDF9C0AFD89749@OS3PR01MB7705.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 13, 2021 at 03:39:26AM +0000, suy.fnst@fujitsu.com wrote:
> So I wonder if it's a real regression/bug or an expected "cost" of speedup on 
> nfsd file caches? 

Without looking at this case in detail:

Delegations are granted at the server's discretion, so this certainly
isn't a bug.

It might be suboptimal behavior.  If there's evidence that this causes
significant regressions on some important workload, then we'd want to
look into fixing it.

--b.
