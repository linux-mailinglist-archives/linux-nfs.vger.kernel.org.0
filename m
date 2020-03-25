Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABDE193243
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 22:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgCYVBt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 17:01:49 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33001 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYVBs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 17:01:48 -0400
Received: by mail-qv1-f67.google.com with SMTP id p19so1876782qve.0
        for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2020 14:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cGUbaIECHR15S5puB5tGXUY2NrHe9kFuLB6haXjqSnM=;
        b=nDbpbPsZW1hMn5kS1NRgsazA/Bw9piHeSdhkMJrDYt21ZDvvQZPGPrXkZOf98Ctb5/
         FUHo0v/7aNiebh7nKfGcgX86bLgIVVPbittSCwQGtYGf92UtCwg4h02havbJIEWscJeT
         Z/QHgzgmxU4fLiHfM7JkFqmKBMDAGHhjEZnwCV8IrOtAvNoY1BgNyTaOtHijeMeCszCk
         pPrhsDrvl3M/5eRl2bNi1LYwzdV7O9veu+8SkLlhXlEsjMytvJ4l9rXlGs7eY/afqp6Q
         tBgHABJttij2VAVBulI/0caoqO2CyomnJVU0uxMUn6PLmKBZdy8vY4zYLLGJtUbKJIum
         s7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cGUbaIECHR15S5puB5tGXUY2NrHe9kFuLB6haXjqSnM=;
        b=A1iMFVV2fY7oChMlub2vW4Z4bzhXbvjEbelkxfd4Y1bC0LUnf9kZWqwsaaeSiEMK5e
         hisA1UQBEiqmawM5LVR0Vhqwh/4WR3bA6XWZCpJkkJm6B/tS0HQ2TAkLAgMyMDYAPlog
         cMugULxB9cjLS50D42eIzxx5pPi9gGxPqBkJ3a0EYRUaUFvl3nbxkT3X/8JJi3YIkIAp
         gidV90FedVrao1yF5gM4TjxJZvZTbXnjIaL8kBsiU2r8C6mtCpuuffy99XWWaEikMmei
         6+9vmYe08UBYCh14Zi5a10ozepusRDrcWVCoFqgEM1h9+NSMik+5yEwcKKeg/hlhMrad
         hlng==
X-Gm-Message-State: ANhLgQ1P+Af7Scy/UNmEKYGs5IY7pRc8Zvh7DJVF7F8lys70bH6j7VsU
        88ykeVBhAZs8bEo7eUJqo9lsdU/T
X-Google-Smtp-Source: ADFU+vv4M4SS4AQzEDHjciDOy9RN61k7J1OhhvgPyU6dEvh2ecRc+zGFJ5BMs3LXBo63K6EZ/sjHrg==
X-Received: by 2002:a05:6214:11e1:: with SMTP id e1mr5181530qvu.176.1585170106702;
        Wed, 25 Mar 2020 14:01:46 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s36sm130595qtb.28.2020.03.25.14.01.45
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Mar 2020 14:01:45 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC: fix krb5p mount to provide large enough buffer in rq_rcvsize
Date:   Wed, 25 Mar 2020 17:01:36 -0400
Message-Id: <20200325210136.2826-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Ever since commit 2c94b8eca1a2 ("SUNRPC: Use au_rslack when computing
reply buffer size"). It changed how "req->rq_rcvsize" is calculated. It
used to use au_cslack value which was nice and large and changed it to
au_rslack value which turns out to be too small.

Since 5.1, v3 mount with sec=krb5p fails against an Ontap server
because client's receive buffer it too small.

For gss krb5p, we need to account for the mic token in the verifier,
and the wrap token in the wrap token.

RFC 4121 defines:
mic token
Octet no   Name        Description
         --------------------------------------------------------------
         0..1     TOK_ID     Identification field.  Tokens emitted by
                             GSS_GetMIC() contain the hex value 04 04
                             expressed in big-endian order in this
                             field.
         2        Flags      Attributes field, as described in section
                             4.2.2.
         3..7     Filler     Contains five octets of hex value FF.
         8..15    SND_SEQ    Sequence number field in clear text,
                             expressed in big-endian order.
         16..last SGN_CKSUM  Checksum of the "to-be-signed" data and
                             octet 0..15, as described in section 4.2.4.

that's 16bytes (GSS_KRB5_TOK_HDR_LEN) + chksum

wrap token
Octet no   Name        Description
         --------------------------------------------------------------
          0..1     TOK_ID    Identification field.  Tokens emitted by
                             GSS_Wrap() contain the hex value 05 04
                             expressed in big-endian order in this
                             field.
          2        Flags     Attributes field, as described in section
                             4.2.2.
          3        Filler    Contains the hex value FF.
          4..5     EC        Contains the "extra count" field, in big-
                             endian order as described in section 4.2.3.
          6..7     RRC       Contains the "right rotation count" in big-
                             endian order, as described in section
                             4.2.5.
          8..15    SND_SEQ   Sequence number field in clear text,
                             expressed in big-endian order.
          16..last Data      Encrypted data for Wrap tokens with
                             confidentiality, or plaintext data followed
                             by the checksum for Wrap tokens without
                             confidentiality, as described in section
                             4.2.4.

Also 16bytes of header (GSS_KRB5_TOK_HDR_LEN), encrypted data, and cksum
(other things like padding)

RFC 3961 defines known cksum sizes:
Checksum type              sumtype        checksum         section or
                                value            size         reference
   ---------------------------------------------------------------------
   CRC32                            1               4           6.1.3
   rsa-md4                          2              16           6.1.2
   rsa-md4-des                      3              24           6.2.5
   des-mac                          4              16           6.2.7
   des-mac-k                        5               8           6.2.8
   rsa-md4-des-k                    6              16           6.2.6
   rsa-md5                          7              16           6.1.1
   rsa-md5-des                      8              24           6.2.4
   rsa-md5-des3                     9              24             ??
   sha1 (unkeyed)                  10              20             ??
   hmac-sha1-des3-kd               12              20            6.3
   hmac-sha1-des3                  13              20             ??
   sha1 (unkeyed)                  14              20             ??
   hmac-sha1-96-aes128             15              20         [KRB5-AES]
   hmac-sha1-96-aes256             16              20         [KRB5-AES]
   [reserved]                  0x8003               ?         [GSS-KRB5]

Linux kernel now mainly supports type 15,16 so max cksum size is 20bytes.
(GSS_KRB5_MAX_CKSUM_LEN)

Re-use already existing define of GSS_KRB5_MAX_SLACK_NEEDED that's used
for encoding the gss_wrap tokens (same tokens are used in reply).

Fixes: 2c94b8eca1a2 ("SUNRPC: Use au_rslack when computing reply buffer size")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/auth_gss/auth_gss.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 24ca861..5a733a6 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -20,6 +20,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/auth_gss.h>
+#include <linux/sunrpc/gss_krb5.h>
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/gss_err.h>
 #include <linux/workqueue.h>
@@ -51,6 +52,8 @@
 /* length of a krb5 verifier (48), plus data added before arguments when
  * using integrity (two 4-byte integers): */
 #define GSS_VERF_SLACK		100
+/* covers lengths of gss_unwrap() extra kerberos mic and wrap token */
+#define GSS_RESP_SLACK		(GSS_KRB5_MAX_SLACK_NEEDED << 2)
 
 static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
 static DEFINE_SPINLOCK(gss_auth_hash_lock);
@@ -1050,7 +1053,7 @@ static void gss_pipe_free(struct gss_pipe *p)
 		goto err_put_mech;
 	auth = &gss_auth->rpc_auth;
 	auth->au_cslack = GSS_CRED_SLACK >> 2;
-	auth->au_rslack = GSS_VERF_SLACK >> 2;
+	auth->au_rslack = GSS_RESP_SLACK >> 2;
 	auth->au_verfsize = GSS_VERF_SLACK >> 2;
 	auth->au_ralign = GSS_VERF_SLACK >> 2;
 	auth->au_flags = 0;
-- 
1.8.3.1

