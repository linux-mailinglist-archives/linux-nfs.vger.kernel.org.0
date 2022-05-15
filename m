Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDA75274E2
	for <lists+linux-nfs@lfdr.de>; Sun, 15 May 2022 03:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiEOB7t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 21:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiEOB7s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 21:59:48 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428672B1B1
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 18:59:47 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 3AA347159; Sat, 14 May 2022 21:59:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 3AA347159
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1652579986;
        bh=GMYdsCBCj3TGW3DG1ozLxaC75Un7iB+CKMvrAMqrF5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrMFby3BsS/B9s2G+NrJEEb0OpRjOrAYYUkn1qydVE1Nd48DSzX/v+GGPewFsVpwr
         ZtDw9HFNufInrWv0OBhkuxTb7tp9o2523DNlhAb1BouxnlVnqdDriEA7biodqDypMN
         QSW0uamWaV2B31ePxLy/+oBBGXOwCEdQKROQQT5g=
Date:   Sat, 14 May 2022 21:59:46 -0400
From:   "J.Bruce Fields" <bfields@fieldses.org>
To:     trondmy@kernel.org
Cc:     Steve Dickson <SteveD@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/6] Allow nfs4-acl-tools to access 'dacl' and 'sacl'
Message-ID: <20220515015946.GB30004@fieldses.org>
References: <20220514144436.4298-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514144436.4298-1-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, May 14, 2022 at 10:44:30AM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The following patch set matches the kernel patches to allow access to
> the NFSv4.1 'dacl' and 'sacl' attributes. The current patches are very
> basic, adding support for encoding/decoding the new attributes only when
> the user specifies the '--dacl' or '--sacl' flags on the command line.

Seems like a reasonable thing to do.

I'd rather not be responsible for nfs4-acl-tools any longer, though.

--b.

> 
> Trond Myklebust (6):
>   libnfs4acl: Add helpers to set the dacl and sacl
>   libnfs4acl: Add support for the NFS4.1 ACE_INHERITED_ACE flag
>   The NFSv41 DACL and SACL prepend an extra field to the acl
>   nfs4_getacl: Add support for the --dacl and --sacl options
>   nfs4_setacl: Add support for the --dacl and --sacl options
>   Edit manpages to document the new --dacl, --sacl and inheritance
>     features
> 
>  include/libacl_nfs4.h             | 18 +++++++
>  include/nfs4.h                    |  6 +++
>  libnfs4acl/Makefile               |  2 +
>  libnfs4acl/acl_nfs4_copy_acl.c    |  2 +
>  libnfs4acl/acl_nfs4_xattr_load.c  | 14 +++++-
>  libnfs4acl/acl_nfs4_xattr_pack.c  | 22 ++++++--
>  libnfs4acl/nfs4_ace_from_string.c |  3 ++
>  libnfs4acl/nfs4_get_ace_flags.c   |  2 +
>  libnfs4acl/nfs4_getacl.c          | 84 +++++++++++++++++++++++++++++++
>  libnfs4acl/nfs4_new_acl.c         |  1 +
>  libnfs4acl/nfs4_setacl.c          | 49 ++++++++++++++++++
>  man/man1/nfs4_getfacl.1           | 14 ++++++
>  man/man1/nfs4_setfacl.1           |  8 +++
>  man/man5/nfs4_acl.5               | 10 ++++
>  nfs4_getfacl/nfs4_getfacl.c       | 73 ++++++++++++++++++++++++---
>  nfs4_setfacl/nfs4_setfacl.c       | 67 ++++++++++++++++++++++--
>  16 files changed, 359 insertions(+), 16 deletions(-)
>  create mode 100644 libnfs4acl/nfs4_getacl.c
>  create mode 100644 libnfs4acl/nfs4_setacl.c
> 
> -- 
> 2.36.1
