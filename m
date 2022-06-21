Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01723553414
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jun 2022 15:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiFUN6K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jun 2022 09:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiFUN6J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jun 2022 09:58:09 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA5DCA
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 06:58:03 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id EDEA57158; Tue, 21 Jun 2022 09:58:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EDEA57158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1655819881;
        bh=R9ItDMeRXcJE46wrGY2Q8a6yTiBq5zM0UziH7WxCYfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjEhhvA8LyfjiupzJUgXKeBvJ2LRuyTPHQ2xpICTNey3e9hEtQLK4nWsvihgTwmzH
         lqC8DlZHAaYQKeoO/r5EroEIO3DIKjSwa1wthkXVoTEvVunOOQDBksr6DgK5UZ02ns
         2Rw/PtCWFA4+y3fItakAl8NPFE8MEc47l4hNkdds=
Date:   Tue, 21 Jun 2022 09:58:01 -0400
From:   "J.Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     trondmy@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/6] Allow nfs4-acl-tools to access 'dacl' and 'sacl'
Message-ID: <20220621135801.GB18065@fieldses.org>
References: <20220514144436.4298-1-trondmy@kernel.org>
 <b070ad50-08d7-a967-21f5-ecfbbd7105d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b070ad50-08d7-a967-21f5-ecfbbd7105d9@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks!--b.

On Tue, Jun 21, 2022 at 09:43:44AM -0400, Steve Dickson wrote:
> 
> 
> On 5/14/22 10:44 AM, trondmy@kernel.org wrote:
> >From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >
> >The following patch set matches the kernel patches to allow access to
> >the NFSv4.1 'dacl' and 'sacl' attributes. The current patches are very
> >basic, adding support for encoding/decoding the new attributes only when
> >the user specifies the '--dacl' or '--sacl' flags on the command line.
> >
> >Trond Myklebust (6):
> >   libnfs4acl: Add helpers to set the dacl and sacl
> >   libnfs4acl: Add support for the NFS4.1 ACE_INHERITED_ACE flag
> >   The NFSv41 DACL and SACL prepend an extra field to the acl
> >   nfs4_getacl: Add support for the --dacl and --sacl options
> >   nfs4_setacl: Add support for the --dacl and --sacl options
> >   Edit manpages to document the new --dacl, --sacl and inheritance
> >     features
> >
> >  include/libacl_nfs4.h             | 18 +++++++
> >  include/nfs4.h                    |  6 +++
> >  libnfs4acl/Makefile               |  2 +
> >  libnfs4acl/acl_nfs4_copy_acl.c    |  2 +
> >  libnfs4acl/acl_nfs4_xattr_load.c  | 14 +++++-
> >  libnfs4acl/acl_nfs4_xattr_pack.c  | 22 ++++++--
> >  libnfs4acl/nfs4_ace_from_string.c |  3 ++
> >  libnfs4acl/nfs4_get_ace_flags.c   |  2 +
> >  libnfs4acl/nfs4_getacl.c          | 84 +++++++++++++++++++++++++++++++
> >  libnfs4acl/nfs4_new_acl.c         |  1 +
> >  libnfs4acl/nfs4_setacl.c          | 49 ++++++++++++++++++
> >  man/man1/nfs4_getfacl.1           | 14 ++++++
> >  man/man1/nfs4_setfacl.1           |  8 +++
> >  man/man5/nfs4_acl.5               | 10 ++++
> >  nfs4_getfacl/nfs4_getfacl.c       | 73 ++++++++++++++++++++++++---
> >  nfs4_setfacl/nfs4_setfacl.c       | 67 ++++++++++++++++++++++--
> >  16 files changed, 359 insertions(+), 16 deletions(-)
> >  create mode 100644 libnfs4acl/nfs4_getacl.c
> >  create mode 100644 libnfs4acl/nfs4_setacl.c
> >
> My apologies this took so long....
> 
> Committed (tag: nfs4-acl-tools-0.4.1-rc)
> 
> steved.
