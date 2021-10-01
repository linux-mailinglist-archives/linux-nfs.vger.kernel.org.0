Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D6641EF03
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 15:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353659AbhJAOBJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 10:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352999AbhJAOBG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Oct 2021 10:01:06 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077B0C061775
        for <linux-nfs@vger.kernel.org>; Fri,  1 Oct 2021 06:59:22 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 69B6525FE; Fri,  1 Oct 2021 09:59:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 69B6525FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633096761;
        bh=J4jr3ea95gdc9JCScyAYNi3fSnm8ymfSMlAesbr25/8=;
        h=Date:To:Cc:Subject:From:From;
        b=phz+VhkBQOo2bFGdYVfB/CCisOdr/zNs9kJ/p7sQpGRX6XemuNInkL5pQfbiTbCSV
         LgJ+9SejrTrGIG3aEFrlYcyQeiSKuCdWuirL8rHasfUgE+yF4WZTkXjHrTnJXgrvwW
         G2+OH/pvZy4srvA1x5t88Mb4nIeTxv9Zs4QBIj1I=
Date:   Fri, 1 Oct 2021 09:59:21 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org,
        Volodymyr Khomenko <volodymyr@vastdata.com>
Subject: [PATCH] SUNRPC: fix sign error causing rpcsec_gss drops
Message-ID: <20211001135921.GC959@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

If sd_max is unsigned, then sd_max - GSS_SEQ_WIN is a very large number
whenever sd_max is less than GSS_SEQ_WIN, and the comparison:

	seq_num <= sd->sd_max - GSS_SEQ_WIN

in gss_check_seq_num is pretty much always true, even when that's
clearly not what was intended.

This was causing pynfs to hang when using krb5, because pynfs uses zero
as the initial gss sequence number.  That's perfectly legal, but this
logic error causes knfsd to drop the rpc in that case.  Out-of-order
sequence IDs in the first GSS_SEQ_WIN (128) calls will also cause this.

Fixes: 10b9d99a3dbb ("SUNRPC: Augment server-side rpcgss tracepoints")
Cc: stable@vger.kernel.org
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 7dba6a9c213a..b87565b64928 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -645,7 +645,7 @@ static bool gss_check_seq_num(const struct svc_rqst *rqstp, struct rsc *rsci,
 		}
 		__set_bit(seq_num % GSS_SEQ_WIN, sd->sd_win);
 		goto ok;
-	} else if (seq_num <= sd->sd_max - GSS_SEQ_WIN) {
+	} else if (seq_num + GSS_SEQ_WIN <= sd->sd_max) {
 		goto toolow;
 	}
 	if (__test_and_set_bit(seq_num % GSS_SEQ_WIN, sd->sd_win))
-- 
2.31.1

