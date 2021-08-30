Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68243FB984
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 17:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbhH3P6H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 11:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237715AbhH3P6A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 11:58:00 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5780C0617AD
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:57:04 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id p17so4221056qvo.8
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=khaGAdaqkWaatpF0Kr1qGQR60qUuZJKnbxVAZoCcDPU=;
        b=DRWBk6KrNAGd3miemOOusADfRSBa+0qqOoEBegfCwQy3CadxFwEyRKXBf6gg2mkIWJ
         onJzfwD6h4UiwvDbarXWbuu5x0IUPVpbmLerP9GC8+qyYx/uTdkPn4N+sSlgN+0qs9Pu
         qx5hQWk8XWts5CpVG+PgercUYSuq3IY2yn/8vSuYng0bUnXuqJJfoh5oAhgnyUP1O1ia
         9tdq1mt4XmmRdW8QkMTuAgLd2hjshRPpTedLFpqPz/qrFLZUiS7voL5GGE9o+OaY/Ndp
         Z1sXTwtNeVheIvagW6F5Biz6lRac+EPOLsVRofQyEFPxLB6pAkWE4HSnaWjY1ze82zkM
         K53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=khaGAdaqkWaatpF0Kr1qGQR60qUuZJKnbxVAZoCcDPU=;
        b=Og99n9svDlSuA+0qFzNNCLK2dHDnpkB7xNCZnufRxp9sNmGI1Y0EDlYWk0la27MVgc
         GqOtFUdJ7VdCVyZNHEAHVbLVk0BamM9TTtbD3XUksljzOfKN8Mf6+Isnz3giEs1esbEZ
         a4nsZHaZ4naxzPeTl4Qr3GPnlTOdnEAV5iNqilOFyL05xn1YU4nV2AZsqlUtk64ShYrT
         LO+RseiDAQRg/u0CygnYvpL8O5HQzVRnU+3eeJnNyU/4ZsO25kW49AnYvGL4Xss3QtuE
         kFT/d9PFw8SEwKPxB6DfSmu7P23vn8gkWB8Kq8Rq9uiIj7aEodX8ogyuJEzKYr6bEjcO
         imNQ==
X-Gm-Message-State: AOAM5335AESznsk5mXPMCvT0Dn/kpVm0M9U0sM3KhizT9qXYVtrQf1O4
        eBbBfY01Bm5mxW6Ds8LiwRS1W2ZPA4eItQ==
X-Google-Smtp-Source: ABdhPJw6kLJHmn1TdA4zfvfUkE+1oxnqMQo7ADYQwxA0Rv3XSpBohuYaL4IHQvymmc56O/CEn8AQBQ==
X-Received: by 2002:a0c:ee43:: with SMTP id m3mr23941081qvs.34.1630339023818;
        Mon, 30 Aug 2021 08:57:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id 12sm8585217qtt.16.2021.08.30.08.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:57:03 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 8/9] nfssysfs: Add a man page
Date:   Mon, 30 Aug 2021 11:56:52 -0400
Message-Id: <20210830155653.1386161-9-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
References: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/nfssysfs/nfssysfs.man | 88 +++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 tools/nfssysfs/nfssysfs.man

diff --git a/tools/nfssysfs/nfssysfs.man b/tools/nfssysfs/nfssysfs.man
new file mode 100644
index 000000000000..7b00c1a81106
--- /dev/null
+++ b/tools/nfssysfs/nfssysfs.man
@@ -0,0 +1,88 @@
+.\"
+.\" nfssysfs(8)
+.\"
+.TH nfssysfs 8 "05 Aug 2021"
+.SH NAME
+nfssysfs \- Displays NFS & SunRPC connection information
+.SH SYNOPSIS
+.B nfssysfs
+.RB [ \-h | \-\-help ]
+.P
+.B nfssysfs rpc-client
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.P
+.B nfssysfs xprt-switch
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.P
+.B nfssysfs xprt-switch set
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.RB [ \--dstaddr
+.IR dstaddr]
+.P
+.B nfssysfs xprt
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.P
+.B nfssysfs xprt set
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
+.RB "The " nfssysfs " command displays information collected in the SunRPC sysfs files about the system's SunRPC objects.
+.P
+.SS Objects
+Valid
+.BR nfssysfs (8)
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
2.33.0

