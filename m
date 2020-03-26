Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1BA19413A
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 15:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgCZOY4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 10:24:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40014 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgCZOY4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Mar 2020 10:24:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id c9so5374206qtw.7
        for <linux-nfs@vger.kernel.org>; Thu, 26 Mar 2020 07:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J9ddb+Nm8FfP0Posgr0sGBR0H0LW/0mehUuOo7haSlM=;
        b=cBTcwb+GIldtm8Cm06sG06ZLcHyOYaLfkB5szgYgokmDrJUuugRaeSfhpIb7WfqwAc
         YZHHVWpLTm8FjTV7/FrWUui7dScw0ZH3Hn+5GUiUUHK3p7R5zvaCMLmVAOBKedlsqIe/
         JNn7+Cbox/MLPPErJ7R6VvCSDG0QL1i3zhowL46E5d3EkQSVZs8+anbPooA/9l+56b8J
         LGvtdZh8SDMtlnywU6ayRi6+cnpqLK6f4xKb0Bxgb6FxEEIaNlxZJuqVW0xXu7lLhB02
         MZ4yTynRSmDGxvp+4N079rrDbzGIbHQ2QicUeB7zE0ukp31J3HPQ/2LQByV+q4CA2kfu
         /eFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J9ddb+Nm8FfP0Posgr0sGBR0H0LW/0mehUuOo7haSlM=;
        b=PZH5smi8MKHJePrEmLG/yrMSPFLlmew6QhcA32ODvkQa5VVhEvNhhp6+VDiyp01N4c
         GE7GUKCvwgSKDB3YS1IufScbCt56a+WcXTDzNPzJbjs+CUwi1hyMgOSaincl3iiOU2eO
         Bx3KZK8rKhgA+5urCn2RBIKODLziWQw7NVToqxSGY4/yJxAMIJFGP+G1YKQi89FQVse6
         CEbu/48GN81SKQnXMWPL6THblBIdrrppIvTwQ/RwXEEpB0x/7hMie7XkxFwxvYpug9Cg
         LUwUNpDBsXACt+2T9Ua5r1n6AnmMzl4jP9QkMvryh3M7dF1QOOps88IWwo7j+PCEEsHf
         hV6g==
X-Gm-Message-State: ANhLgQ013oc38c504Sqql/WTut9CkhrpPQg7xuceC4ClgfqcroiTkxka
        s4ai/5OHVtCpwaCcxJYD6nQ79uJX
X-Google-Smtp-Source: ADFU+vvrEpeDjYggB2Pixf/NrEjC5jW9gMzuEDWujHfVq/IyfHayaetocRUXRrhDhQgqEciUPCUFHQ==
X-Received: by 2002:ac8:5486:: with SMTP id h6mr8309483qtq.256.1585232694270;
        Thu, 26 Mar 2020 07:24:54 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id w28sm1700475qtc.27.2020.03.26.07.24.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 07:24:53 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] SUNRPC: fix krb5p mount to provide large enough buffer in rq_rcvsize
Date:   Thu, 26 Mar 2020 10:24:51 -0400
Message-Id: <20200326142451.3666-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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
 net/sunrpc/auth_gss/auth_gss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 24ca861..d6cd2a5 100644
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
@@ -1050,7 +1051,7 @@ static void gss_pipe_free(struct gss_pipe *p)
 		goto err_put_mech;
 	auth = &gss_auth->rpc_auth;
 	auth->au_cslack = GSS_CRED_SLACK >> 2;
-	auth->au_rslack = GSS_VERF_SLACK >> 2;
+	auth->au_rslack = GSS_KRB5_MAX_SLACK_NEEDED >> 2;
 	auth->au_verfsize = GSS_VERF_SLACK >> 2;
 	auth->au_ralign = GSS_VERF_SLACK >> 2;
 	auth->au_flags = 0;
-- 
1.8.3.1

