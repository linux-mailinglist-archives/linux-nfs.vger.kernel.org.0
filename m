Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9D1899AE
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2020 11:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgCRKky (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Mar 2020 06:40:54 -0400
Received: from smtp-o-3.desy.de ([131.169.56.156]:38678 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbgCRKkx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Mar 2020 06:40:53 -0400
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 92C46604B3
        for <linux-nfs@vger.kernel.org>; Wed, 18 Mar 2020 11:40:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 92C46604B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1584528051; bh=5qup0rhEXKfBkGzugBVdBeIARtxxtgHt3OZlySyVO48=;
        h=From:To:Cc:Subject:Date:From;
        b=Yaf+an/7uK2jBuxmyKL0trC6/Qu+RIE6rwauwgwDNABL6nzop/JMSvF0f+LpSta5X
         ibpSVasXYQks8y4ZYMcbWIcnotxhIMLRA4fyJY0/Zp/YWVFjl86jVghqkwC2hTvS9o
         NpFuFLlUmQOyiZU1eg6nMDTsYFIkW/El/X5R7GZU=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [131.169.56.131])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 8EDD6A00B3;
        Wed, 18 Mar 2020 11:40:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from ani.desy.de (zitpcx21033.desy.de [131.169.185.213])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 62417C00A2;
        Wed, 18 Mar 2020 11:40:51 +0100 (CET)
From:   Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] rpc: fix str to bytes conversion
Date:   Wed, 18 Mar 2020 11:40:31 +0100
Message-Id: <20200318104031.289921-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

fix back channel ping from server
---
 rpc/rpc.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/rpc/rpc.py b/rpc/rpc.py
index c536384..d15cf06 100644
--- a/rpc/rpc.py
+++ b/rpc/rpc.py
@@ -693,8 +693,11 @@ class ConnectionHandler(object):
                 status, result, notify = tuple
             if result is None:
                 result = b''
+            if isinstance(result, str):
+                result = bytes(result, encoding='UTF-8')
+
             if not isinstance(result, bytes):
-                raise TypeError("Expected string")
+                raise TypeError("Expected bytes, got %s" % type(result))
             # status, result = method(msg_data, call_info)
             log_t.debug("Called method, got %r, %r" % (status, result))
         except rpclib.RPCDrop:
-- 
2.25.1

