Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B284977F6
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 04:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbiAXDzh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 22:55:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57064 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiAXDzg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 22:55:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 378CC21997;
        Mon, 24 Jan 2022 03:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642996535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFyjPabVahDB+vrXElKQ+UDq/fcSAdM6+RjOQdJJ+zQ=;
        b=VgQrwpIxLgoCjPnFeLQ6BZXyoET8QaMuJj5dg3XrTQjG/Dyt8rnQo5H2GJQtXWKNEPjzw0
        3LVlkZnGEErfLJ5EZGcO/nb+tBz6PyIHowNAMuCegClQg5ZrMhmmIZTDjms6NXFeLDRqPQ
        zG8uip/oHc07Wt3VH1lEmYNs8wJB0uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642996535;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFyjPabVahDB+vrXElKQ+UDq/fcSAdM6+RjOQdJJ+zQ=;
        b=JvFFvxy7hIQZ1+xEKNkM/EQRldT0iSe3V12OSgUpU+cHWb6H8JoYwh8OdaLk3As3Rgau0m
        WMhtltZp6u4HM8Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEB8813305;
        Mon, 24 Jan 2022 03:55:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eiDtKjMj7mFfRgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 03:55:31 +0000
Subject: [PATCH 23/23] SUNRPC: lock against ->sock changing during sysfs read
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jan 2022 14:48:32 +1100
Message-ID: <164299611287.26253.6282866540933339893.stgit@noble.brown>
In-Reply-To: <164299573337.26253.7538614611220034049.stgit@noble.brown>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

->sock can be set to NULL asynchronously unless ->recv_mutex is held.
So it is important to hold that mutex.  Otherwise a sysfs read can
trigger an oops.
Commit 17f09d3f619a ("SUNRPC: Check if the xprt is connected before
handling sysfs reads") appears to attempt to fix this problem, but it
only narrows the race window.

Fixes: 17f09d3f619a ("SUNRPC: Check if the xprt is connected before handling sysfs reads")
Fixes: a8482488a7d6 ("SUNRPC query transport's source port")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/sysfs.c    |    5 ++++-
 net/sunrpc/xprtsock.c |    7 ++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 2766dd21935b..baaf65ea9e38 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -115,11 +115,14 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
 	}
 
 	sock = container_of(xprt, struct sock_xprt, xprt);
-	if (kernel_getsockname(sock->sock, (struct sockaddr *)&saddr) < 0)
+	mutex_lock(&sock->recv_mutex);
+	if (sock->sock == NULL ||
+	    kernel_getsockname(sock->sock, (struct sockaddr *)&saddr) < 0)
 		goto out;
 
 	ret = sprintf(buf, "%pISc\n", &saddr);
 out:
+	mutex_unlock(&sock->recv_mutex);
 	xprt_put(xprt);
 	return ret + 1;
 }
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 9d34c71004fa..3f2b766e9f82 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1641,7 +1641,12 @@ static int xs_get_srcport(struct sock_xprt *transport)
 unsigned short get_srcport(struct rpc_xprt *xprt)
 {
 	struct sock_xprt *sock = container_of(xprt, struct sock_xprt, xprt);
-	return xs_sock_getport(sock->sock);
+	unsigned short ret = 0;
+	mutex_lock(&sock->recv_mutex);
+	if (sock->sock)
+		ret = xs_sock_getport(sock->sock);
+	mutex_unlock(&sock->recv_mutex);
+	return ret;
 }
 EXPORT_SYMBOL(get_srcport);
 


