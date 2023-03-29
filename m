Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377ED6CDB9E
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Mar 2023 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjC2OKb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Mar 2023 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjC2OKa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Mar 2023 10:10:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091E7558E
        for <linux-nfs@vger.kernel.org>; Wed, 29 Mar 2023 07:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E91761D14
        for <linux-nfs@vger.kernel.org>; Wed, 29 Mar 2023 14:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F16BC4339B;
        Wed, 29 Mar 2023 14:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680098906;
        bh=1Qdhg7zDnhDkQZ2AI5pqIT98OGUbEhzHGMs0Fr/TNZs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Hes5yzeSDQgXJo4jDv52u9/fqRYcg+dgcR0TUiHphUW5znrOHNcygs9veHb4OKIDx
         xNm1BGO3eWukNE71KxPTNYRXRyKvgLwqdxqwSYyvOdM5gkx8aNy65EYtmdMgNiuuO/
         X9C9ozS1nWtt1bJHw9qnH9jqVCRUYAWRUXmMLp6B3oi32HsMYNsH89JcbshpMhSISj
         YkGYXVV53SgSlbWKP/r9n6tX+WkmRdso6gWpye/NPFddljDmO1jzGhR3Y8OvSh42IG
         LfvBwjwMlsI86gsy/RaBooigdqymYVo238qUOHJVOs2ZUVsjJAItSbc3TdRazBbQYV
         YoKRVTm61YDRg==
Subject: [PATCH v2 3/4] exports(5): Describe the xprtsec= export option
From:   Chuck Lever <cel@kernel.org>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org, rick.macklem@gmail.com,
        kernel-tls-handshake@lists.linux.dev
Date:   Wed, 29 Mar 2023 10:08:25 -0400
Message-ID: <168009890542.2522.10109556599153238262.stgit@manet.1015granger.net>
In-Reply-To: <168009806320.2522.10415374334827613451.stgit@manet.1015granger.net>
References: <168009806320.2522.10415374334827613451.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Cc: Rick Macklem <rick.macklem@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 utils/exportfs/exports.man |   51 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index 54b3f8776ea6..83dd6807c570 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -125,7 +125,55 @@ In that case you may include multiple sec= options, and following options
 will be enforced only for access using flavors listed in the immediately
 preceding sec= option.  The only options that are permitted to vary in
 this way are ro, rw, no_root_squash, root_squash, and all_squash.
+.SS Transport layer security
+The Linux NFS server allows the use of RPC-with-TLS (RFC 9289) to
+protect RPC traffic between itself and its clients.
+Alternately, administrators can secure NFS traffic using a VPN,
+or an ssh tunnel or similar mechanism, in a way that is transparent
+to the server.
 .PP
+To enable the use of RPC-with-TLS, the server's administrator must
+install and configure
+.BR tlshd
+to handle transport layer security handshake requests from the local
+kernel.
+Clients can then choose to use RPC-with-TLS or they may continue
+operating without it.
+.PP
+Administrators may require the use of RPC-with-TLS to protect access
+to individual exports.
+This is particularly useful when using non-cryptographic security
+flavors such as
+.IR sec=sys .
+The
+.I xprtsec=
+option, followed by an unordered colon-delimited list of security policies,
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
+If RPC-with-TLS is configured and enabled and the
+.I xprtsec=
+option is not specified, the default setting for an export is
+.IR xprtsec=none:tls:mtls .
+With this setting, the server permits clients to use any transport
+layer security mechanism or none at all to access the export.
 .SS General Options
 .BR exportfs
 understands the following export options:
@@ -581,7 +629,8 @@ a character class wildcard match.
 .BR netgroup (5),
 .BR mountd (8),
 .BR nfsd (8),
-.BR showmount (8).
+.BR showmount (8),
+.BR tlshd (8).
 .\".SH DIAGNOSTICS
 .\"An error parsing the file is reported using syslogd(8) as level NOTICE from
 .\"a DAEMON whenever


