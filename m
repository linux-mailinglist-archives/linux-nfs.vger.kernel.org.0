Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3200277BBB2
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Aug 2023 16:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjHNOcX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjHNOcT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 10:32:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16938E4;
        Mon, 14 Aug 2023 07:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A98BA61791;
        Mon, 14 Aug 2023 14:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10BEC433C9;
        Mon, 14 Aug 2023 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692023538;
        bh=90QNq6jUBs43bpm8ggLivszh1cU+3BB9qLpGVoSmrEo=;
        h=From:Date:Subject:To:Cc:From;
        b=YtAh5nNsuYkFuxI4zL8RsiEspCmnoEwuiAm5cQ/bZ7kU7MhWtQwiZn5DujppZvYin
         PcM0ayv2HA0o7Wv1u82wm7W9X8lPp0LW42ZyVMks0E7m07VI6cS4lX+yWZInrjkGHO
         y+qizDhSg9pIaGjCZ0cAQQzNMdGzAvXw9VSi3i5r0xhGliex+f0j7/sbB9dtnMRZ7Z
         abSls76wUWKXw5dAJve1cyMsrgR0m9zXvGvTweROgiispVVGZNMl5rEoJImS3/Ujp4
         gY2ov9sC3Nsn4GwD64E+GGW+d9UgvUAzDTQX2/vij7C1s87H6APGwjznKYcK76FbAi
         jbJDKpCWpl1jA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 14 Aug 2023 10:32:08 -0400
Subject: [PATCH] sunrpc: account for xdr->page_base in xdr_alloc_bvec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-sendpage-v1-1-d551b0d7f870@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOc62mQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDC0MT3eLUvJSCRKB4koGJhblJamqKkYmlElB5QVFqWmYF2Kjo2NpaAIk
 6mylaAAAA
To:     David Howells <dhowells@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1876; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=90QNq6jUBs43bpm8ggLivszh1cU+3BB9qLpGVoSmrEo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk2jrwoUKjYoT7AqXvTuTJcLJ8Gy0jY9C6foHJg
 6Dc79Ikx1eJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNo68AAKCRAADmhBGVaC
 Fbh1EAC9EaYqlhjwxIGjMyt+X9y98zc44/cp0SVY2HEbsQqc9nQ8EXyrEujni37UZq4E9tBNsUH
 8n+DfAIjNC5OXciefDqQAz+atvdY8jlQXXXQvLU9i7ubP7IrlFxEe1VATHUwEorvnONGBoKuPDq
 /B27fufj2RU4RGeY88I78MqiCd9Yj1Sk4Dc8nuU1w5fqatsekhY6qS9fWKTMEDKeKlWe9JNT6mH
 Yl4F25ymwWdvAV50c6kRIMEy92Wk0yJ31cU0BS16vXleOb7gmy/pWMP8UQDkf71BpKM6sW32e4h
 Nu5/kxCMnY4N5GYTTkEZy3XRBhpvuIIzdhcug/HCCQjdR0X1DAMCVtGm1hUquJfxgOQtUK8YgrU
 QwXapfRPyOLrH5JCZHe6Es+Mi/Z6LyO7S8f71Dafv1NIRXdI34rrdR9mc3xRsaWvzIDSSoCeDHR
 xBGalvQ7YYZIonjSUZX3AotKv/Ta0+UwDhEJ7c5OFz4WtyvbUr3i0E7Kt6g55xMX6HzLik2UbMU
 +Rp0v/c2u9vMydZ1kaFCLgiOqB8sFpxUCLIIvm8DYd/oe8rTlkXOGcRhWomNNas3OZ9IRlU8jp9
 LmK5yziEtuxi+Dmo31dh15HJChFZ9DdaCR5Njy3O0rsc0r7aMtrAZFUkDOaRJiaK+J0neAbZYxz
 Rs71yi3RW2TpIKw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've been seeing a regression in mainline (v6.5-rc) kernels where
unaligned reads were returning corrupt data.

9d96acbc7f37 added a routine to allocate and populate a bvec array that
can be used to back an iov_iter. When it does this, it always sets the
offset in the first bvec to zero, even when the xdr->page_base is
non-zero.

The old code in svc_tcp_sendmsg used to account for this, as it was
sending the pages one at a time anyway, but now that we just hand the
iov to the network layer, we need to ensure that the bvecs are properly
initialized.

Fix xdr_alloc_bvec to set the offset in the first bvec to the offset
indicated by xdr->page_base, and then 0 in all subsequent bvecs.

Fixes: 9d96acbc7f37 ("SUNRPC: Add a bvec array to struct xdr_buf for use with iovec_iter()")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
NB: This is only lightly tested so far, but it seems to fix the pynfs
regressions I've been seeing.
---
 net/sunrpc/xdr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 2a22e78af116..d0f5fc8605b8 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -144,6 +144,7 @@ int
 xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp)
 {
 	size_t i, n = xdr_buf_pagecount(buf);
+	unsigned int offset = offset_in_page(buf->page_base);
 
 	if (n != 0 && buf->bvec == NULL) {
 		buf->bvec = kmalloc_array(n, sizeof(buf->bvec[0]), gfp);
@@ -151,7 +152,8 @@ xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp)
 			return -ENOMEM;
 		for (i = 0; i < n; i++) {
 			bvec_set_page(&buf->bvec[i], buf->pages[i], PAGE_SIZE,
-				      0);
+				      offset);
+			offset = 0;
 		}
 	}
 	return 0;

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230814-sendpage-b04874eed249

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

