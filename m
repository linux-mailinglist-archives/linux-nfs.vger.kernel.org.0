Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7033249EB58
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 20:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245753AbiA0TuB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 14:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245709AbiA0TuB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 14:50:01 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73927C061714
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:50:00 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id k14so3404317qtq.10
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AhOG6e9nTOmpjTzbQRMgirrPw1Wc7JqJ+RcYK7lemrE=;
        b=eTA0EbtYSGu959RixikKvVdYhBJ7puEioirnBrK7lO0NTIpsDU3D+UM8KU9rHEUWSc
         Jhm2+FMYzwdBop0eSBxOo/FWTsYH0wvEU93ag8xPDM8hbDOPwoVpwCPB1CFLNplWLKzL
         mbGo+lB/tZGB45LOKtCE+0/m83JzXKPvHfdgzv1JFrmB9R7q2hzl60jKIOWBDSOqjc66
         Fyb0F3Ph+U+USr1lOs4spvGaPmjKUuj+PF0ke5EeTRgyCfR9V6ClB4wPPGCbjUpKwb5x
         7jkOOR0WPTKkFuxTcDgBKXyWCAswoAEUOSvfHKY+NF7GZYtvSUgwT8yEn8CgpMawAo6+
         B22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AhOG6e9nTOmpjTzbQRMgirrPw1Wc7JqJ+RcYK7lemrE=;
        b=TWh74aKvlfkF9hzUO9zpG7QYOYrnDSVKSakHMbNXyBn2bmzxEvheimXrJXgtltIWHf
         Kyfs+remMMNrLHzv5hGhTsvIwE81Wkofv0EeLmQudGZNXOtv4Us/7+B4ezk0A2DXlphx
         af2PZPXqs7rAGDPVoL7Lh8fbHdEEep2TjnbEta/SshgjR4eKkjCkvKI3PZWA5X17DGOR
         /rOn7mgK5XH4wpgcqcyyWXbHGURgIQWWkUZlSB7Yg0yYJEb1U6nWXNJNyiBU/DZVNz1y
         CN5crqm9XMj8IPijbkWR54naoQVaavGuGjehfXaTCWIaGPUUNsL7TqbT188Ue9XPV7C5
         mg7A==
X-Gm-Message-State: AOAM533M+r8l00+s2dwAncqKWliWSh4u1Pm0IZ/P2szUuuIm0Kxm6Kj/
        QiFCjmHUz8Hv/AeZddtQLCQ=
X-Google-Smtp-Source: ABdhPJxGecJ3xhru6GOqHGC2Kx7eeox/IWvCGmG5AllcIqE5AnITMHU/4VtnI2THQKXIB3mvqS8n7A==
X-Received: by 2002:ac8:5f89:: with SMTP id j9mr4037334qta.326.1643312999617;
        Thu, 27 Jan 2022 11:49:59 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g7sm1836483qkc.104.2022.01.27.11.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:49:59 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 8/9] rpcctl: Add a man page
Date:   Thu, 27 Jan 2022 14:49:51 -0500
Message-Id: <20220127194952.63033-9-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
References: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
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
index 000000000000..e4dd53ac8531
--- /dev/null
+++ b/tools/rpcctl/rpcctl.man
@@ -0,0 +1,88 @@
+.\"
+.\" rpcctl(8)
+.\"
+.TH rpcctl 8 "25 Jan 2022"
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
2.35.0

