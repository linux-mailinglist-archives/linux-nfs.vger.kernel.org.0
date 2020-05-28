Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAD51E6EDD
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2020 00:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437078AbgE1W1D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 May 2020 18:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437116AbgE1W0v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 May 2020 18:26:51 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6B0C08C5C6
        for <linux-nfs@vger.kernel.org>; Thu, 28 May 2020 15:26:50 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5F72A3B0; Thu, 28 May 2020 18:26:50 -0400 (EDT)
Date:   Thu, 28 May 2020 18:26:50 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>, kircherlike@outlook.com,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/3 - V2] SUNRPC/svc: fix gss flavour registration
 problems.
Message-ID: <20200528222650.GE20602@fieldses.org>
References: <159011265914.29107.13764997801950546826.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159011265914.29107.13764997801950546826.stgit@noble>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Applying for 5.8, thanks!

--b.

On Fri, May 22, 2020 at 12:01:32PM +1000, NeilBrown wrote:
> In this second version:
>  - #include added in first patch so new function is declare both where 
>    it is defined and where it is used
>  - doxy comment added for auth_domain_cleanup()
>  - pr_warn() used instead of printk
>  - 'svc:' used as message prefix
>  - EADDRINUSE returned instead of EALREADY - I think it is slightly more
>    accurate.
>  - 'cc: stable' dropped for first patch.  Bug goes back before 'git' so
>    no 'Fixes:'
>  - minor code revision
> 
> Thanks,
> NeilBrown
> ---
> 
> NeilBrown (3):
>       sunrpc: check that domain table is empty at module unload.
>       sunrpc: svcauth_gss_register_pseudoflavor must reject duplicate registrations.
>       sunrpc: clean up properly in gss_mech_unregister()
> 
> 
>  include/linux/sunrpc/gss_api.h        |    1 +
>  include/linux/sunrpc/svcauth_gss.h    |    3 ++-
>  net/sunrpc/auth_gss/gss_mech_switch.c |   12 +++++++++---
>  net/sunrpc/auth_gss/svcauth_gss.c     |   18 ++++++++++--------
>  net/sunrpc/sunrpc.h                   |    1 +
>  net/sunrpc/sunrpc_syms.c              |    2 ++
>  net/sunrpc/svcauth.c                  |   25 +++++++++++++++++++++++++
>  7 files changed, 50 insertions(+), 12 deletions(-)
> 
> --
> Signature
