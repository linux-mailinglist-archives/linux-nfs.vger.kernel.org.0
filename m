Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A15319295
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Feb 2021 19:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhBKSzc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Feb 2021 13:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhBKSz0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Feb 2021 13:55:26 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CC5C061574
        for <linux-nfs@vger.kernel.org>; Thu, 11 Feb 2021 10:54:46 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E14072012; Thu, 11 Feb 2021 13:54:44 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E14072012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1613069684;
        bh=FiFGmePmZ1+k/3xUOjdu1oWM3NzXqfUtvtFEKvw1TZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jyr6x+xDU1MsW9ax6DDksGU7NtZu6YtCbf7h64QRbP+dnUKHWGFm/DRxZjkGPU1iU
         Jh1cA7ofXpzpE6fyLBzvLhuIaJ5V3yifek6RrnVcJfKjlCqjydmXXA2MCAnC3VrIxs
         X6zNveA+SHOnIP482Ob7h+NyOnJofHvNQCSLxTcs=
Date:   Thu, 11 Feb 2021 13:54:44 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "guy@vastdata.com" <guy@vastdata.com>,
        "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfs: we don't support removing system.nfs4_acl
Message-ID: <20210211185444.GA6048@fieldses.org>
References: <20210128223638.GE29887@fieldses.org>
 <95e5f9e4-76d4-08c4-ece3-35a10c06073b@vastdata.com>
 <cbc7115cc5d5aeb7ffb9e9b3880e453bf54ecbdb.camel@hammerspace.com>
 <20210129023527.GA11864@fieldses.org>
 <20210129025041.GA12151@fieldses.org>
 <7a078b4d22c8d769a42a0c2b47fd501479e47a7b.camel@hammerspace.com>
 <20210131215843.GA9273@fieldses.org>
 <20210203200756.GA30996@fieldses.org>
 <6dc98a594a21b86316bf77000dc620d6cca70be6.camel@hammerspace.com>
 <20210208220855.GA15116@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208220855.GA15116@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

The contents of the system.nfs4_acl xattr are literally just the
xdr-encoded ACL attribute.  That attribute starts with a 4-byte integer
representing the number of ACEs in the ACL.  So even a zero-ACE ACL will
be at least 4 bytes.

We've never actually bothered to sanity-check the ACL encoding that
userspace gives us.  The only problem that causes is that we return an
error that's probably wrong.  (The server will return BADXDR, which
we'll translate to EIO, when EINVAL would make more sense.)

It's not much a problem in practice since the standard utilities give us
well-formed XDR.  The one case we're likely to see from userspace in
practice is a set of a zero-length xattr since that's how

	removexattr(path, "system.nfs4_acl")

is implemented.  It's worth trying to give a better error for that case.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfs/nfs4proc.c | 6 ++++++
 1 file changed, 6 insertions(+)

On Mon, Feb 08, 2021 at 05:08:55PM -0500, bfields@fieldses.org wrote:
> On Mon, Feb 08, 2021 at 07:31:38PM +0000, Trond Myklebust wrote:
> > OK. So you're not really saying that the SETATTR has a zero length
> > body, but that the ACL attribute in this case has a zero length body,
> > whereas in the 'empty acl' case, it is supposed to have a body
> > containing a zero-length nfsace4<> array. Fair enough.
> 
> Yep!  I'll see if I can think of a helpful concise comment, and resend.

Oops, forgot about this, here you go.--b.

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2f4679a62712..86e87f7d7686 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5895,6 +5895,12 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t bufl
 	unsigned int npages = DIV_ROUND_UP(buflen, PAGE_SIZE);
 	int ret, i;
 
+	/*
+	 * We don't support removing system.nfs4_acl, and even a
+	 * 0-length ACL needs at least 4 bytes for the number of ACEs:
+	 */
+	if (buflen < 4)
+		return -EINVAL;
 	if (!nfs4_server_supports_acls(server))
 		return -EOPNOTSUPP;
 	if (npages > ARRAY_SIZE(pages))
-- 
2.29.2

