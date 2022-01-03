Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9714837EA
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 21:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiACUIs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 15:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiACUIs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jan 2022 15:08:48 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E4FC061761
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jan 2022 12:08:48 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8FDB65FFF; Mon,  3 Jan 2022 15:08:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8FDB65FFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641240527;
        bh=s6V2mgqeg0CfbAIgiFRQpcU8/XLlJUfaxzsNRFOzPLs=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=z6BnSYwT998mV+1Pt03bHKrzCxBYV5zVmo7h7VA1ZRI2dP7m4OcYibhxdK29EFkhp
         4BiKOI82sXuMl2OLdVnPTsPEySuyEs66QKO15LKAKC7UVyeGA1NCPgVqrs6LhfoJnA
         bstSvgbxmw0u78KgiC0hI2FJBpTYuZbzlfq16Ii0=
Date:   Mon, 3 Jan 2022 15:08:47 -0500
To:     trondmy@kernel.org
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/5] Support case insensitive filesystems in NFSv4
Message-ID: <20220103200847.GH21514@fieldses.org>
References: <20211217203658.439352-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217203658.439352-1-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 17, 2021 at 03:36:53PM -0500, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Add support for detecting an export of a case insensitive filesystem in
> NFSv4. If that is the case, then we need to adjust the dentry caching
> and invalidation rules to ensure that we don't inadvertently end up
> caching other case folded aliases after an operation that results in a
> directory entry name change.

What server and configuration are you testing this against?

--b.

> 
> Trond Myklebust (5):
>   NFSv4: Add some support for case insensitive filesystems
>   NFSv4: Just don't cache negative dentries on case insensitive servers
>   NFS: Invalidate negative dentries on all case insensitive directory
>     changes
>   NFS: Add a helper to remove case-insensitive aliases
>   NFS: Fix the verifier for case sensitive filesystem in
>     nfs_atomic_open()
> 
>  fs/nfs/dir.c              | 41 +++++++++++++++++++++++++++++++++------
>  fs/nfs/internal.h         |  1 +
>  fs/nfs/nfs4proc.c         | 13 +++++++++++--
>  fs/nfs/nfs4xdr.c          | 40 ++++++++++++++++++++++++++++++++++++++
>  include/linux/nfs_fs_sb.h |  2 ++
>  include/linux/nfs_xdr.h   |  2 ++
>  6 files changed, 91 insertions(+), 8 deletions(-)
> 
> -- 
> 2.33.1
