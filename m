Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008E66FE6FE
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 00:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbjEJWIM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 May 2023 18:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbjEJWIH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 May 2023 18:08:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E206189
        for <linux-nfs@vger.kernel.org>; Wed, 10 May 2023 15:08:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C04A71FD6B;
        Wed, 10 May 2023 22:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683756483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/e3rIshzrYg4pAK0dSAEbWV4SJAQMPKkivuMAu6Qxw=;
        b=qd7DU+NkPZ7J0U5viyzukzL2hC95usTnLeAG0+ETe3b5oufZitnUYY+MYciEnjDm7YxoRV
        04wjmuoi6hN6Nn5s4WDV2obJoCxj71tRXV8qOnnRSKAIYbQ9QHK4mWpLhv9pSeDV8hiKfd
        UdJ2tIeBWnMhRaPQqnaa6dj9kx7RHoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683756483;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/e3rIshzrYg4pAK0dSAEbWV4SJAQMPKkivuMAu6Qxw=;
        b=Zo8Xls5LwZs+tjJ5IJgBndJArwcLDBJxE1kLvc/biBV0k7XTyXHGM3hJ5t5YvauAVjQl/Q
        nzCRJH4UndQ9l3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A51C213519;
        Wed, 10 May 2023 22:08:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aG6TFsEVXGTqBAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 10 May 2023 22:08:01 +0000
Subject: [PATCH 1/2] SUNRPC: support abstract unix socket addresses
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Steve Dickson <steved@redhat.com>
Date:   Thu, 11 May 2023 08:06:24 +1000
Message-ID: <168375638439.26246.18054236712842151913.stgit@noble.brown>
In-Reply-To: <168375610447.26246.3237443941479930060.stgit@noble.brown>
References: <168375610447.26246.3237443941479930060.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

An "abtract" address for an AF_UNIX socket start with a nul and can
contain any bytes for the given length, but traditionally doesn't
contain other nuls.  When reported, the leading nul is replaced by '@'.

sunrpc currently rejects connections to these addresses and reports them
as an empty string.  To provide support for future use of these
addresses, allow them for outgoing connections and report them more
usefully.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/clnt.c     |    8 ++++++--
 net/sunrpc/xprtsock.c |    9 +++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d2ee56634308..18f70854f528 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -565,8 +565,12 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 		servername[0] = '\0';
 		switch (args->address->sa_family) {
 		case AF_LOCAL:
-			snprintf(servername, sizeof(servername), "%s",
-				 sun->sun_path);
+			if (sun->sun_path[0])
+				snprintf(servername, sizeof(servername), "%s",
+					 sun->sun_path);
+			else
+				snprintf(servername, sizeof(servername), "@%s",
+					 sun->sun_path+1);
 			break;
 		case AF_INET:
 			snprintf(servername, sizeof(servername), "%pI4",
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 5f9030b81c9e..515328a8dafe 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -253,7 +253,12 @@ static void xs_format_common_peer_addresses(struct rpc_xprt *xprt)
 	switch (sap->sa_family) {
 	case AF_LOCAL:
 		sun = xs_addr_un(xprt);
-		strscpy(buf, sun->sun_path, sizeof(buf));
+		if (sun->sun_path[0]) {
+			strscpy(buf, sun->sun_path, sizeof(buf));
+		} else {
+			buf[0] = '@';
+			strscpy(buf+1, sun->sun_path+1, sizeof(buf)-1);
+		}
 		xprt->address_strings[RPC_DISPLAY_ADDR] =
 						kstrdup(buf, GFP_KERNEL);
 		break;
@@ -2858,7 +2863,7 @@ static struct rpc_xprt *xs_setup_local(struct xprt_create *args)
 
 	switch (sun->sun_family) {
 	case AF_LOCAL:
-		if (sun->sun_path[0] != '/') {
+		if (sun->sun_path[0] != '/' && sun->sun_path[0] != '\0') {
 			dprintk("RPC:       bad AF_LOCAL address: %s\n",
 					sun->sun_path);
 			ret = ERR_PTR(-EINVAL);


