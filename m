Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C8C404082
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Sep 2021 23:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349865AbhIHV1O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Sep 2021 17:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhIHV1O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Sep 2021 17:27:14 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C205C061575
        for <linux-nfs@vger.kernel.org>; Wed,  8 Sep 2021 14:26:06 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 88DEB6CD0; Wed,  8 Sep 2021 17:26:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 88DEB6CD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1631136365;
        bh=lwLbs160re0AuNnzwL9YajBsZwg0P/fJ7LxV8NwO//o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dr3jKJUyGUPG2dPSrEBcjOVk4Y3/QKRNtLKWqqlXt0l2EhcWhi1hX90JGEPV9Qxyb
         5AwlQU8KR3EXWgrGeJuGMiSYF5bUfPixnNqTR2MBSlxQ5tpdod7fM78uQTJXEFX93V
         TgggJmkmyt961RAQcASGZW00x4/5RWE3Tk6rkC4A=
Date:   Wed, 8 Sep 2021 17:26:05 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
Message-ID: <20210908212605.GF23978@fieldses.org>
References: <20210907080732.GA20341@kili>
 <deba812574c9b898f99fc08f0c3fa23e85fc36ca.camel@kernel.org>
 <622EC724-ECBF-424D-A003-46A6B8E8C215@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <622EC724-ECBF-424D-A003-46A6B8E8C215@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 07, 2021 at 03:00:23PM +0000, Chuck Lever III wrote:
> We have IPV6_SCOPE_ID_LEN as a maximum size of the scope ID,
> and it's not a big value. As long as boundary checking is made
> to be sufficient, then a stack residency for the device name
> should be safe.

Something like this?  (Or are you making a patch?  I'm not even sure how
to test.)

--b.

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
