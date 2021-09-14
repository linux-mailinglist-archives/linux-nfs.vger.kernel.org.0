Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1E40B50B
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 18:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhINQjJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 12:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhINQjJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 12:39:09 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886AFC061574
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 09:37:51 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 724F828E5; Tue, 14 Sep 2021 12:37:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 724F828E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1631637470;
        bh=enCgZpYt6FX7J0pI+1xzEGtOUBSd7yOAWgJlnEngYZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aC3kjRbUV+J9P0rxNKB4ml4JSIHGm17avsPCFT8eauNheROSAh346cUmvZSOa0niD
         diEnhDIg8x5e2iE7UbHbYOmYe6huHtDTyzZy4IjR3XKc6g+Ri+clypeTOzLe62xsrU
         7wnGatLFsfcWfKvQJ6/YEbbxJDJwXWSa9vXzQLRg=
Date:   Tue, 14 Sep 2021 12:37:50 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
Message-ID: <20210914163750.GB8134@fieldses.org>
References: <20210907080732.GA20341@kili>
 <deba812574c9b898f99fc08f0c3fa23e85fc36ca.camel@kernel.org>
 <622EC724-ECBF-424D-A003-46A6B8E8C215@oracle.com>
 <20210908212605.GF23978@fieldses.org>
 <23A4CB30-F551-472F-9F2F-022C40AE1D70@oracle.com>
 <b63e52660e39cc7688921f85eadf1958ced6a869.camel@kernel.org>
 <57B147B6-FC8F-4E70-A3E1-D449615B8355@oracle.com>
 <c72e78075bcdc174e5786aa6678655fdae73eaaf.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c72e78075bcdc174e5786aa6678655fdae73eaaf.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH] nfsd: don't alloc under spinlock in rpc_parse_scope_id

Dan Carpenter says:

  The patch d20c11d86d8f: "nfsd: Protect session creation and client
  confirm using client_lock" from Jul 30, 2014, leads to the following
  Smatch static checker warning:

        net/sunrpc/addr.c:178 rpc_parse_scope_id()
        warn: sleeping in atomic context

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: d20c11d86d8f ("nfsd: Protect session creation and client...")
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---

 net/sunrpc/addr.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

On Thu, Sep 09, 2021 at 10:56:33AM -0400, Jeff Layton wrote:
> Hmm, it sounds line in the second email he suggests using memcpy():
> 
> "Your "memcpy()" example implies that the source is always a fixed-size
> thing. In that case, maybe that's the rigth thing to do, and you
> should just create a real function for it."
> 
> Maybe I'm missing the context though.
> 
> In any case, when you're certain about the length of the source and
> destination buffers, there's no real benefit to avoiding memcpy in favor
> of strcpy and the like. It's just as correct.

OK, queueing this up as is for 5.16 unless someone objects.  (But, could
really use testing, I'm not currently testing over ipv6.)--b.

diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
index 6e4dbd577a39..d435bffc6199 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -162,8 +162,10 @@ static int rpc_parse_scope_id(struct net *net, const char *buf,
 			      const size_t buflen, const char *delim,
 			      struct sockaddr_in6 *sin6)
 {
-	char *p;
+	char p[IPV6_SCOPE_ID_LEN + 1];
 	size_t len;
+	u32 scope_id = 0;
+	struct net_device *dev;
 
 	if ((buf + buflen) == delim)
 		return 1;
@@ -175,29 +177,23 @@ static int rpc_parse_scope_id(struct net *net, const char *buf,
 		return 0;
 
 	len = (buf + buflen) - delim - 1;
-	p = kmemdup_nul(delim + 1, len, GFP_KERNEL);
-	if (p) {
-		u32 scope_id = 0;
-		struct net_device *dev;
-
-		dev = dev_get_by_name(net, p);
-		if (dev != NULL) {
-			scope_id = dev->ifindex;
-			dev_put(dev);
-		} else {
-			if (kstrtou32(p, 10, &scope_id) != 0) {
-				kfree(p);
-				return 0;
-			}
-		}
-
-		kfree(p);
-
-		sin6->sin6_scope_id = scope_id;
-		return 1;
+	if (len > IPV6_SCOPE_ID_LEN)
+		return 0;
+
+	memcpy(p, delim + 1, len);
+	p[len] = 0;
+
+	dev = dev_get_by_name(net, p);
+	if (dev != NULL) {
+		scope_id = dev->ifindex;
+		dev_put(dev);
+	} else {
+		if (kstrtou32(p, 10, &scope_id) != 0)
+			return 0;
 	}
 
-	return 0;
+	sin6->sin6_scope_id = scope_id;
+	return 1;
 }
 
 static size_t rpc_pton6(struct net *net, const char *buf, const size_t buflen,
-- 
2.31.1

