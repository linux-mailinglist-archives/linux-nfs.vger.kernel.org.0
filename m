Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4611F43E864
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 20:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhJ1Sh6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 14:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhJ1Sh5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 14:37:57 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200CDC061570
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:30 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id x123so6783073qke.7
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNF21b7o9pVNnDZqS+hsA6oGp6Q443tS/9+eQ33iVAg=;
        b=H7Ynb4vyBnPCPnciZXnf5C5iEd9GCVhF6LvGwUHGM00if6IMoz/KPOQinC4W24FwDA
         TCBwE8K5URDkxBtn53WQLHRNJbISgZ+1iBF2Lg2VYN3f0WP95dpfEZ7Td/LxSpfWXhLc
         6TDtCBNek4NxDGRRyw4UYpv2125SypiLbx21g/OHTR2Qe9qfBPXaWmYr4xUJjaR4DQXR
         IK47afifxFtX9Fk4vy2us7LnCIKac4TSr6Islc4xxaP0CtTMK+Pt4Bcxj5rZsGUtzfce
         l7I1Si/V8nTPnS0JySCPQNFGuOy1DfJ24mprqXaP5Lnsegdp2oGX0Ge0bp8wOzXbv5p1
         2hCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BNF21b7o9pVNnDZqS+hsA6oGp6Q443tS/9+eQ33iVAg=;
        b=MXI8qH6hi5HNCRzJlSvFXFd8WkaUM3due24lsqVDmv0LdP7fAyoaAhgUL52r/4SUsy
         eTiYSUbiyJAGGp/+29fysm93h+id+k71TnvpDJ+CtuK9e8iKI6kbDHDF92Caz/O3lPlp
         SI7qRef4eGh1LfpU2y8IZH3wRlyXCnYkH3DXi4P4uGmz2NOCOsaTCHEYVbuTkqAABG2r
         P+HjMP8Hsna/2En4u8bv9jWNAZ4o7RBx5DI2JPvN2VVZZ4QI7SunXyRMw7FztTfcevDo
         nhx/H6vvV451WV1D9z/NIq/34TMk4xGVbpSCpTAvp9QR4j+WILKkbMSchz6fawy6mOBG
         lxKQ==
X-Gm-Message-State: AOAM533pw7Ta+2I1sul6I+o1Sy9H3yp0zjAhpWWhN/QRrjCM07Q/C3k2
        7E7DVGLs891ZweU+lKuAQGAFDlcTc0Y=
X-Google-Smtp-Source: ABdhPJyb6g/7pnmvhzhC+kyZJ2bJjNfGLNSsto73AOg73bbQsNS0vNKd6DU+Vw1zFDE5RVRcm5jk8A==
X-Received: by 2002:a37:9a88:: with SMTP id c130mr5205606qke.494.1635446129050;
        Thu, 28 Oct 2021 11:35:29 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id q13sm2556476qkl.7.2021.10.28.11.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:35:28 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 8/9] rpcctl: Add a man page
Date:   Thu, 28 Oct 2021 14:35:18 -0400
Message-Id: <20211028183519.160772-9-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
References: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/rpcctl/rpcctl.man | 88 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 tools/rpcctl/rpcctl.man

diff --git a/tools/rpcctl/rpcctl.man b/tools/rpcctl/rpcctl.man
new file mode 100644
index 000000000000..5da608aa1907
--- /dev/null
+++ b/tools/rpcctl/rpcctl.man
@@ -0,0 +1,88 @@
+.\"
+.\" rpcctl(8)
+.\"
+.TH rpcctl 8 "22 Oct 2021"
+.SH NAME
+rpcctl \- Displays SunRPC connection information
+.SH SYNOPSIS
+.B rpcctl
+.RB [ \-h | \-\-help ]
+.P
+.B rpcctl client
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.P
+.B rpcctl switch
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.P
+.B rpcctl switch set
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.RB [ \--dstaddr
+.IR dstaddr]
+.P
+.B rpcctl xprt
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.P
+.B rpcctl xprt set
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.RB [ \--dstaddr
+.IR dstaddr]
+.RB [ --offline ]
+.RB [ --online ]
+.RB [ --remove ]
+.P
+.SH DESCRIPTION
+.RB "The " rpcctl " command displays information collected in the SunRPC sysfs files about the system's SunRPC objects.
+.P
+.SS Objects
+Valid
+.BR rpcctl (8)
+objects are:
+.IP "\fBclient\fP"
+Display information about this system's RPC clients.
+.IP "\fBswitch\fP"
+Display information about groups of transports.
+.IP "\fBxprt\fP"
+Display detailed information about each transport that exists on the system.
+.SH OPTIONS
+.SS Options valid for all objects
+.TP
+.B \-h, \-\-help
+Show the help message and exit
+.TP
+.B \-\-id \fIID
+Set or display properties for the object with the given
+.IR ID.
+This option is mandatory for setting properties.
+.SS Options specific to the `switch set` sub-command
+.TP
+.B \-\-dstaddr \fIdstaddr
+Change the destination address of all transports in the switch to
+.IR dstaddr
+.SS Options specific to the `xprt set` sub-command
+.TP
+.B \-\-dstaddr \fIdstaddr
+Change the destination address of this specific transport to
+.TP
+.B \-\-offline
+Change the transport state from online to offline
+.TP
+.B \-\-online
+Change the transport state from offline to online
+.TP
+.B \-\-remove
+Removes the transport from the switch. Note that "main" transports cannot be removed.
+.SH DIRECTORY
+.TP
+.B /sys/kernel/sunrpc/
+.SH AUTHOR
+Anna Schumaker <Anna.Schumaker@Netapp.com>
-- 
2.33.1

