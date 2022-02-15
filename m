Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EEB4B77F2
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Feb 2022 21:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbiBOTWK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Feb 2022 14:22:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240165AbiBOTWJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Feb 2022 14:22:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CB477A9B
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 11:21:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 991E2B81C82
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 19:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFED8C340F0;
        Tue, 15 Feb 2022 19:21:55 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v8 8/9] rpcctl: Add a man page
Date:   Tue, 15 Feb 2022 14:21:49 -0500
Message-Id: <20220215192150.53811-9-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215192150.53811-1-Anna.Schumaker@Netapp.com>
References: <20220215192150.53811-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v8: Updates for the new command structure
    Add examples
---
 tools/rpcctl/rpcctl.man | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 tools/rpcctl/rpcctl.man

diff --git a/tools/rpcctl/rpcctl.man b/tools/rpcctl/rpcctl.man
new file mode 100644
index 000000000000..b87ba0df41c0
--- /dev/null
+++ b/tools/rpcctl/rpcctl.man
@@ -0,0 +1,67 @@
+.\"
+.\" rpcctl(8)
+.\"
+.TH rpcctl 8 "15 Feb 2022"
+.SH NAME
+rpcctl \- Displays SunRPC connection information
+.SH SYNOPSIS
+.nf
+.BR rpcctl " [ \fB\-h \fR| \fB\-\-help \fR] { \fBclient \fR| \fBswitch \fR| \fBxprt \fR}"
+.P
+.BR "rpcctl client" " \fR[ \fB\-h \fR| \fB\-\-help \fR] { \fBshow \fR}"
+.BR "rpcctl client show " "\fR[ \fB\-h \f| \fB\-\-help \fR] [ \fIXPRT \fR]"
+.P
+.BR "rpcctl switch" " \fR[ \fB\-h \fR| \fB\-\-help \fR] { \fBset \fR| \fBshow \fR}"
+.BR "rpcctl switch set" " \fR[ \fB\-h \fR| \fB\-\-help \fR] \fISWITCH \fBdstaddr \fINEWADDR"
+.BR "rpcctl switch show" " \fR[ \fB\-h \fR| \fB\-\-help \fR] [ \fISWITCH \fR]"
+.P
+.BR "rpcctl xprt" " \fR[ \fB\-h \fR| \fB\-\-help \fR] { \fBremove \fR| \fBset \fR| \fBshow \fR}"
+.BR "rpcctl xprt remove" " \fR[ \fB\-h \fR| \fB\-\-help \fR] \fIXPRT"
+.BR "rpcctl xprt set" " \fR[ \fB\-h \fR| \fB\-\-help \fR] \fIXPRT \fR{ \fBdstaddr \fINEWADDR \fR| \fBoffline \fR| \fBonline \fR}"
+.BR "rpcctl xprt show" " \fR[ \fB\-h \fR| \fB\-\-help \fR] [ \fIXPRT \fR]"
+.fi
+.SH DESCRIPTION
+.RB "The " rpcctl " command displays information collected in the SunRPC sysfs files about the system's SunRPC objects.
+.P
+.SS rpcctl client \fR- \fBCommands operating on RPC clients
+.IP "\fBshow \fR[ \fICLIENT \fR] \fB(default)"
+Show detailed information about the RPC clients on this system.
+If \fICLIENT \fRwas provided, then only show information about a single RPC client.
+.P
+.SS rpcctl switch \fR- \fBCommands operating on groups of transports
+.IP "\fBset \fISWITCH \fBdstaddr \fINEWADDR"
+Change the destination address of all transports in the \fISWITCH \fRto \fINEWADDR\fR.
+\fINEWADDR \fRcan be an IP address, DNS name, or anything else resolvable by \fBgethostbyname\fR(3).
+.IP "\fBshow \fR[ \fISWITCH \fR] \fB(default)"
+Show detailed information about groups of transports on this system.
+If \fISWITCH \fRwas provided, then only show information about a single transport group.
+.P
+.SS rpcctl xprt \fR- \fBCommands operating on individual transports
+.IP "\fBremove \fIXPRT"
+Removes the specified \fIXPRT \fRfrom the system.
+Note that "main" transports cannot be removed.
+.P
+.IP "\fBset \fIXPRT \fBdstaddr \fINEWADDR"
+Change the destination address of the specified \fIXPRT \fR to \fINEWADDR\fR.
+\fINEWADDR \fRcan be an IP address, DNS name, or anything else resolvable by \fBgethostbyname\fR(3).
+.P
+.IP "\fBset \fIXPRT \fBoffline"
+Sets the specified \fIXPRT\fR's state to offline.
+.P
+.IP "\fBset \fIXPRT \fBonline"
+Sets the specified \fIXPRT\fR's state to online.
+.IP "\fBshow \fR[ \fIXPRT \fR] \fB(default)"
+Show detailed information about this system's transports.
+If \fIXPRT \fRwas provided, then only show information about a single transport.
+.SH EXAMPLES
+.IP "\fBrpcctl switch show switch-2"
+Show details about the RPC switch named "switch-2".
+.IP "\fBrpcctl xprt remove xprt-4"
+Remove the xprt named "xprt-4" from the system.
+.IP "\fBrpcctl xprt set xprt-3 dstaddr https://linux-nfs.org
+Change the dstaddr of the xprt named "xprt-3" to point to linux-nfs.org
+.SH DIRECTORY
+.TP
+.B /sys/kernel/sunrpc/
+.SH AUTHOR
+Anna Schumaker <Anna.Schumaker@Netapp.com>
-- 
2.35.1

