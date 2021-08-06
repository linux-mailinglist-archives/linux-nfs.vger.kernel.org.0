Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C45B3E3040
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 22:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244856AbhHFUSG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 16:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244866AbhHFUSG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 16:18:06 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1088EC061798
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 13:17:50 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f12so10065681qkh.10
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LfJF5ZM5m1VsjeWH4hRk9GjbL/OhCo3AfC51ULJ1aRk=;
        b=Cd/0n22a2bWDMleFZfAdSbIoJe4qCJMwVNq+HO2PWMKWZiy6cEgcOpRslr56JERmUC
         4jGl2pRlLkFEPB/XptBkwUo0cg7yJr8sS1FY/8x5Zi1p08WhViBL/eDe6LSf+pCvkFbC
         AF/EwtkgBUlGeJUH433OtAkV/LJaBEh1biEcayKsmkrZMnGSbN1XfQmpn92Vo+QWF5Ne
         CgQyPIAoRolEPsTI1R1XWtH8pBz1O7dwePRWz0WXTsy1CWjMDEBeVC+rZVt3SenMl0vX
         vnEMQVXb4LeYvNISEQRhhJgGT3b4hzYKVxGMuI25YE48ku2a0lcTFoAp7KuRdcLm9RsO
         NnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LfJF5ZM5m1VsjeWH4hRk9GjbL/OhCo3AfC51ULJ1aRk=;
        b=YycpcAndH7WVsDcKjTLEdVLoZWuH9Sf5vVMCD22f5GHnFFqeqDJrz0yOS/HC9S8CE9
         PTPibs7KF/6BUN0I5L49Ypcds9iTwMz5phyAN354kx5QVmmhu8KhGRL3t79qNha7tR8R
         Y9qjeoKAz7DfzhXn7KbVoe2QbEXIuHe+POlaMCjeTzF6S3QifuZOjaOKl5ZmGkkcunhV
         bUNVpxd5tuw9wxKRCKeGyn4G4HHGtcXBma9r0DU/nJ9XtKXqiIryho8MkOO5k1FOKuAB
         LVPWS3R9W/xDQxy2P3gVQfSp+Gq8qLZXsLZs/pd2RGJEQvaATKtZB5IdHiLSiXaaXNte
         713A==
X-Gm-Message-State: AOAM533r/zHT+K0d2ahFlN+bXhnVWSlDrtSs0O1zt0leUKewdmu5qWC2
        gwlnIWgHyX3CrTtn1PCU4p8=
X-Google-Smtp-Source: ABdhPJz849f01snWPzJHDbgdJ4sLjUpL8KWB+ypwccXiSVY3kz0Qv9LvUf/Cx9IklHtN+CL86thUeQ==
X-Received: by 2002:a37:688d:: with SMTP id d135mr9183484qkc.112.1628281069159;
        Fri, 06 Aug 2021 13:17:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g11sm3705720qtk.91.2021.08.06.13.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:17:48 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 8/9] nfs-sysfs: Add a man page
Date:   Fri,  6 Aug 2021 16:17:38 -0400
Message-Id: <20210806201739.472806-9-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
References: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/nfs-sysfs/nfs-sysfs.man | 88 +++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 tools/nfs-sysfs/nfs-sysfs.man

diff --git a/tools/nfs-sysfs/nfs-sysfs.man b/tools/nfs-sysfs/nfs-sysfs.man
new file mode 100644
index 000000000000..3ebbeaf93eaa
--- /dev/null
+++ b/tools/nfs-sysfs/nfs-sysfs.man
@@ -0,0 +1,88 @@
+.\"
+.\" nfs-sysfs(8)
+.\"
+.TH nfs-sysfs 8 "05 Aug 2021"
+.SH NAME
+nfs-sysfs \- Displays NFS & SunRPC connection information
+.SH SYNOPSIS
+.B nfs-sysfs
+.RB [ \-h | \-\-help ]
+.P
+.B nfs-sysfs rpc-client
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.P
+.B nfs-sysfs xprt-switch
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.P
+.B nfs-sysfs xprt-switch set
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.RB [ \--dstaddr
+.IR dstaddr]
+.P
+.B nfs-sysfs xprt
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.P
+.B nfs-sysfs xprt set
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
+.RB "The " nfs-sysfs " command displays information collected in the SunRPC sysfs files about the system's SunRPC objects.
+.P
+.SS Objects
+Valid
+.BR nfs-sysfs (8)
+objects are:
+.IP "\fBrpc-client\fP"
+Display information about this system's RPC clients.
+.IP "\fBxprt-switch\fP"
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
+.SS Options specific to the `xprt-switch set` sub-command
+.TP
+.B \-\-dstaddr \fIdstaddr
+Change the destination address of all transports in the xprt-switch to
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
+Removes the transport from the xprt-switch. Note that "main" transports cannot be removed.
+.SH DIRECTORY
+.TP
+.B /sys/kernel/sunrpc/
+.SH AUTHOR
+Anna Schumaker <Anna.Schumaker@Netapp.com>
-- 
2.32.0

