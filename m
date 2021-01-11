Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82622F2158
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 22:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbhAKVCO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 16:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbhAKVCK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jan 2021 16:02:10 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A231C061786
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:01:30 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 29E206F32; Mon, 11 Jan 2021 16:01:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 29E206F32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1610398889;
        bh=mt0fPOyyciegWxIp8IGOQG0zh7e6QFxUYU2Dl3js/CM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HybagwogAn2F0cchwB7Q249R804oxPROcysvCD6edOuXvaGSksvlADRBPi/+Barkk
         6BTz+8qzX0GbijPUbmg+JpnNs1+nDQxr44b4GmG4od33dW5FNlwUvcnn0gxdA9WA7B
         Oe5CU96Jy/xZC7xvpttf+eqseoDctLM+6iM2/EEQ=
Date:   Mon, 11 Jan 2021 16:01:29 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     =?utf-8?B?5ZC05byC?= <wangzhibei1999@gmail.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd4: readdirplus shouldn't return parent of export
Message-ID: <20210111210129.GA11652@fieldses.org>
References: <20210105165633.GC14893@fieldses.org>
 <X/hEB8awvGyMKi6x@kroah.com>
 <20210108152017.GA4183@fieldses.org>
 <CAHxDmpSp1LHzKD5uqbfi+jcnb+nFaAZbc5++E0oOvLsYvyYDpw@mail.gmail.com>
 <20210108164433.GB8699@fieldses.org>
 <CAHxDmpSjwrcr_fqLJa5=Zo=xmbt2Eo9dcy6TQuoU8+F3yVVNhw@mail.gmail.com>
 <20210110201740.GA8789@fieldses.org>
 <20210110202815.GB8789@fieldses.org>
 <CAHxDmpR8S7NR8OU2nWJmWBdFU9a7wDuDnxviQ2E9RDOeW9fExg@mail.gmail.com>
 <20210111192507.GB2600@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111192507.GB2600@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

If you export a subdirectory of a filesystem, a READDIRPLUS on the root
of that export will return the filehandle of the parent with the ".."
entry.

The filehandle is optional, so let's just not return the filehandle for
".." if we're at the root of an export.

Note that once the client learns one filehandle outside of the export,
they can trivially access the rest of the export using further lookups.

However, it is also not very difficult to guess filehandles outside of
the export.  So exporting a subdirectory of a filesystem should
considered equivalent to providing access to the entire filesystem.  To
avoid confusion, we recommend only exporting entire filesystems.

Reported-by: 吴异 <wangzhibei1999@gmail.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs3xdr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 821db21ba072..34b880211e5e 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -865,9 +865,14 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
 	if (isdotent(name, namlen)) {
 		if (namlen == 2) {
 			dchild = dget_parent(dparent);
-			/* filesystem root - cannot return filehandle for ".." */
+			/*
+			 * Don't return filehandle for ".." if we're at
OA+			 * the filesystem or export root:
+			 */
 			if (dchild == dparent)
 				goto out;
+			if (dparent == exp->ex_path.dentry)
+				goto out;
 		} else
 			dchild = dget(dparent);
 	} else
-- 
2.29.2

