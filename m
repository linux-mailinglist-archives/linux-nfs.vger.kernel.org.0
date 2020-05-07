Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AE01C9A26
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2020 20:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgEGS56 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 May 2020 14:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgEGS55 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 May 2020 14:57:57 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AB8620575;
        Thu,  7 May 2020 18:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877877;
        bh=v54+jJXI55ev/ljByJU0bELFAb0LTCoWQZNBXlPcq6M=;
        h=Date:From:To:Cc:Subject:From;
        b=jNUUPCbHLXL+RGEmVjXV4LexFXr2GtNKv+s2Fi35Ni/57M7Xa2vVfUsuYHNYHLOao
         ARkd0WBSfasJhdIAz1BUfP6UdO/swEaHn1/TJHozcEZrf70tNiIYfflYm8KOstj7A9
         UQnSrNgiG+0Ms7UVehDBfqh/EnYUmasRl3Jdoeag=
Date:   Thu, 7 May 2020 14:02:23 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: Replace zero-length array with flexible-array
Message-ID: <20200507190223.GA15428@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/nfs4.h    |    2 +-
 include/linux/nfs_xdr.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 82d8fb422092..7c4b63561035 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -38,7 +38,7 @@ struct nfs4_ace {
 
 struct nfs4_acl {
 	uint32_t	naces;
-	struct nfs4_ace	aces[0];
+	struct nfs4_ace	aces[];
 };
 
 #define NFS4_MAXLABELLEN	2048
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 440230488025..6aad9b0a5062 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1227,7 +1227,7 @@ struct nfs4_secinfo4 {
 
 struct nfs4_secinfo_flavors {
 	unsigned int		num_flavors;
-	struct nfs4_secinfo4	flavors[0];
+	struct nfs4_secinfo4	flavors[];
 };
 
 struct nfs4_secinfo_arg {

