Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82F91DC58C
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 05:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgEUDWy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 23:22:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:58918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgEUDWy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 20 May 2020 23:22:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D577CB132;
        Thu, 21 May 2020 03:22:55 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, kircherlike@outlook.com,
        Stephen Hemminger <stephen@networkplumber.org>
Date:   Thu, 21 May 2020 13:21:41 +1000
Subject: [PATCH 0/3] SUNRPC/svc: fix gss flavour registration problems.
Cc:     linux-nfs@vger.kernel.org
Message-ID: <159003086409.24897.4659128962844846611.stgit@noble>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As reported in
 https://bugzilla.kernel.org/show_bug.cgi?id=206651
there are problems with sunrpc/svc flavour registration.

This can be demonstrated as a memory-leak if you load the
rpcsec_gss_krb5 module, then unload the sunrpc module and all
dependents.  This action leaks 3 kmalloc-64 slab entires, and some
strings.

The possible consequences are worse.  If only unload rpcsec_gss_krb5
and reload just that, it will allow the old registered flavour handlers
to be used, and they will include pointers into memory which has since
been freed and possibly reused.  This can result in undesired
behaviour.

The first patch makes the leak apparent with a WARNing, the second
prevents it but also prevents module reload, the third removes the
incorrect behaviour so the module can be safely unloaded and reloaded.

I think all are suitable for -stable, but I haven't determined
appropriate 'Fixes:' tags.

NeilBrown

---

NeilBrown (3):
      sunrpc: check that domain table is empty at module unload.
      sunrpc: svcauth_gss_register_pseudoflavor must reject duplicate registrations.
      sunrpc: clean up properly in gss_mech_unregister()


 include/linux/sunrpc/gss_api.h        |    1 +
 include/linux/sunrpc/svcauth_gss.h    |    3 ++-
 net/sunrpc/auth_gss/gss_mech_switch.c |   12 +++++++++---
 net/sunrpc/auth_gss/svcauth_gss.c     |   17 ++++++++++-------
 net/sunrpc/sunrpc.h                   |    1 +
 net/sunrpc/sunrpc_syms.c              |    2 ++
 net/sunrpc/svcauth.c                  |   18 ++++++++++++++++++
 7 files changed, 43 insertions(+), 11 deletions(-)

--
Signature

