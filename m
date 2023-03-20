Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0624A6C14D4
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Mar 2023 15:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCTOf5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Mar 2023 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjCTOf4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Mar 2023 10:35:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575661A651
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 07:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E72ED6155C
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 14:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB49C433EF;
        Mon, 20 Mar 2023 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679322952;
        bh=8C70LL8FaQsSaB0lwfIzohUglMX4dzUYUFBqWYahp6Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bFIKJvo808GE3yhrDDjAan7hsIHOl24m+LcFGSUw18fYsnBNIpU6w29qGzxEAypdY
         NkarLAVXHfSR7E9JrJR4k3/NDkv1MciFFaG/4LMAAXLGw/8043nvQ6mP6HNndr03yY
         LyY06bHLJ+6VUHtmqLFCQgx8DOjr+K5ezgCzRhnDp332LGOegY0UvwAd4rUoKEd9oc
         tNVdIoVW7JkaOnz55uFtoacoW09CZAG1m3p2Ec0Zigp8iAirmN5lOdVS3AkTHfqt5E
         DGSjdvdGV/p1QYHVSWu+wc2edz8JnCfjzYaoi8/c0sZf62jZ52O+kGG1Tc3/pO+14B
         In4sSucgJp4NQ==
Subject: [PATCH v1 4/4] exports.man: Add description of xprtsec= to exports(5)
From:   Chuck Lever <cel@kernel.org>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 20 Mar 2023 10:35:51 -0400
Message-ID: <167932295124.3437.894267501240103990.stgit@manet.1015granger.net>
In-Reply-To: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 utils/exportfs/exports.man |   45 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index 54b3f8776ea6..cca9bb7b4aeb 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -125,7 +125,49 @@ In that case you may include multiple sec= options, and following options
 will be enforced only for access using flavors listed in the immediately
 preceding sec= option.  The only options that are permitted to vary in
 this way are ro, rw, no_root_squash, root_squash, and all_squash.
+.SS Transport layer security
+The Linux NFS server supports the use of transport layer security to
+protect RPC traffic between itself and its clients.
+This can be in the form of a VPN, an ssh tunnel, or via RPC-with-TLS,
+which uses TLSv1.3.
 .PP
+Administrators may choose to require the use of
+RPC-with-TLS to protect access to individual exports.
+This is particularly useful when using non-cryptographic security
+flavors such as
+.IR sec=sys .
+The
+.I xprtsec=
+option, followed by a colon-delimited list of security policies,
+can restrict access to the export to only clients that have negotiated
+transport-layer security.
+Currently supported transport layer security policies include:
+.TP
+.IR none
+The server permits clients to access the export
+without the use of transport layer security.
+.TP
+.IR tls
+The server permits clients that have negotiated an RPC-with-TLS session
+without peer authentication (confidentiality only) to access the export.
+Clients are not required to offer an x.509 certificate
+when establishing a transport layer security session.
+.TP
+.IR mtls
+The server permits clients that have negotiated an RPC-with-TLS session
+with peer authentication to access the export.
+The server requires clients to offer an x.509 certificate
+when establishing a transport layer security session.
+.PP
+The default setting is
+.IR xprtsec=none:tls:mtls .
+This is also known as "opportunistic mode".
+The server permits clients to use any transport layer security mechanism
+to access the export.
+.PP
+The server administrator must install and configure
+.BR tlshd
+to handle transport layer security handshake requests from the local kernel.
 .SS General Options
 .BR exportfs
 understands the following export options:
@@ -581,7 +623,8 @@ a character class wildcard match.
 .BR netgroup (5),
 .BR mountd (8),
 .BR nfsd (8),
-.BR showmount (8).
+.BR showmount (8),
+.BR tlshd (8).
 .\".SH DIAGNOSTICS
 .\"An error parsing the file is reported using syslogd(8) as level NOTICE from
 .\"a DAEMON whenever


