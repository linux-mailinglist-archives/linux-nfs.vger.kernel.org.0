Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E6B19218B
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 08:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgCYHE7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 03:04:59 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:47645 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgCYHE7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 03:04:59 -0400
Received: from localhost.localdomain ([93.22.148.147])
        by mwinf5d03 with ME
        id JX4r2200J3B2lW503X4s9d; Wed, 25 Mar 2020 08:04:56 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 25 Mar 2020 08:04:56 +0100
X-ME-IP: 93.22.148.147
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@fieldses.org, chuck.lever@oracle.com, davem@davemloft.net,
        kuba@kernel.org, gnb@sgi.com, neilb@suse.de,
        tom@opengridcomputing.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] SUNRPC: Fix a potential buffer overflow in 'svc_print_xprts()'
Date:   Wed, 25 Mar 2020 08:04:40 +0100
Message-Id: <20200325070440.21988-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

'maxlen' is the total size of the destination buffer. There is only one
caller and this value is 256.

When we compute the size already used and what we would like to add in
the buffer, the trailling NULL character is not taken into account.
However, this trailling character will be added by the 'strcat' once we
have checked that we have enough place.

So, there is a off-by-one issue and 1 byte of the stack could be
erroneously overwridden.

Take into account the trailling NULL, when checking if there is enough
place in the destination buffer.

Fixes: dc9a16e49dbba ("svc: Add /proc/sys/sunrpc/transport files")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/sunrpc/svc_xprt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index d53259346235..df39e7b8b06c 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -120,7 +120,7 @@ int svc_print_xprts(char *buf, int maxlen)
 
 		sprintf(tmpstr, "%s %d\n", xcl->xcl_name, xcl->xcl_max_payload);
 		slen = strlen(tmpstr);
-		if (len + slen > maxlen)
+		if (len + slen >= maxlen)
 			break;
 		len += slen;
 		strcat(buf, tmpstr);
-- 
2.20.1

