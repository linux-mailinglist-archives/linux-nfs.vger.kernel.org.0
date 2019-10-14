Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45F4ED6BB5
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2019 00:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbfJNWdv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Oct 2019 18:33:51 -0400
Received: from fieldses.org ([173.255.197.46]:34314 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730121AbfJNWdv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 14 Oct 2019 18:33:51 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 84B19BDB; Mon, 14 Oct 2019 18:33:50 -0400 (EDT)
Date:   Mon, 14 Oct 2019 18:33:50 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Subject: Re: SUNRPC: Checking a kmemdup() call in xdr_netobj_dup()
Message-ID: <20191014223350.GA19883@fieldses.org>
References: <9b5a5e63-2a24-ad79-20e2-4c01331ee041@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b5a5e63-2a24-ad79-20e2-4c01331ee041@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Oct 12, 2019 at 08:20:04PM +0200, Markus Elfring wrote:
> I tried another script for the semantic patch language out.
> This source code analysis approach points out that the implementation
> of the function “xdr_netobj_dup” contains still an unchecked call
> of the function “kmemdup”.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/sunrpc/xdr.h?id=1c0cc5f1ae5ee5a6913704c0d75a6e99604ee30a#n167
> https://elixir.bootlin.com/linux/v5.4-rc2/source/include/linux/sunrpc/xdr.h#L167
> 
> How do you think about to improve it?

On a quick check--I see five xdr_netobj_dup callers, and all of them
check whether dst->data is NULL.

Sounds like a false positive for your tool?

--b.
