Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09686C14A4
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Mar 2023 15:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjCTOYr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Mar 2023 10:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjCTOYp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Mar 2023 10:24:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A32116318
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 07:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6148B80E9C
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 14:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF0EC43324;
        Mon, 20 Mar 2023 14:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679322281;
        bh=1dMJjs205rPD2DbxEjjMh9fteSy15W4p/t73aPbsyNg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dXAvSx/Iwl3jUWmC+75Un0BFT+KFrtOSb5A5auonjF2ZKnlOGNNdGBXmZ4+LBI/q1
         HfLficvCyXZWlgpLEbXOOpS9ylLbB5KCz6TXIVemSH6+PXv2BmntyTTFObSQU4u4qw
         s9v25llLNf+YXxbijPQJBch+tPHAc7fGnRXzKHLvHsJbghprte+0flBaT3vBS8DXuu
         QwH1F/HkgM48XyXq5YNaYUlNJ49qdEZLrhch8M+vaR5YFLDBHSa4G/9U7qKf8ANUf1
         WqTYHmmbYqK9vomPsp863ZUKL1R7ytr49aqirFtLeUiQS/iy2Dq8g+FRiMBaA9WLOM
         hgC9o9vw9gM7Q==
Subject: [PATCH RFC 3/5] SUNRPC: Ensure server-side sockets have a sock->file
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     kernel-tls-handshake@lists.linux.dev
Date:   Mon, 20 Mar 2023 10:24:40 -0400
Message-ID: <167932228041.3131.16156633568630561580.stgit@manet.1015granger.net>
In-Reply-To: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
References: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The TLS handshake upcall mechanism requires a non-NULL sock->file on
the socket it hands to user space. svc_sock_free() already releases
sock->file properly if one exists.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 91a62bea6999..b6df73cb706a 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1340,26 +1340,37 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 						struct socket *sock,
 						int flags)
 {
+	struct file	*filp = NULL;
 	struct svc_sock	*svsk;
 	struct sock	*inet;
 	int		pmap_register = !(flags & SVC_SOCK_ANONYMOUS);
-	int		err = 0;
 
 	svsk = kzalloc(sizeof(*svsk), GFP_KERNEL);
 	if (!svsk)
 		return ERR_PTR(-ENOMEM);
 
+	if (!sock->file) {
+		filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
+		if (IS_ERR(filp)) {
+			kfree(svsk);
+			return ERR_CAST(filp);
+		}
+	}
+
 	inet = sock->sk;
 
-	/* Register socket with portmapper */
-	if (pmap_register)
+	if (pmap_register) {
+		int err;
+
 		err = svc_register(serv, sock_net(sock->sk), inet->sk_family,
 				     inet->sk_protocol,
 				     ntohs(inet_sk(inet)->inet_sport));
-
-	if (err < 0) {
-		kfree(svsk);
-		return ERR_PTR(err);
+		if (err < 0) {
+			if (filp)
+				fput(filp);
+			kfree(svsk);
+			return ERR_PTR(err);
+		}
 	}
 
 	svsk->sk_sock = sock;


