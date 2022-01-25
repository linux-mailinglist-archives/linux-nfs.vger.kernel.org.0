Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6D49BBD0
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiAYTJ5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiAYTJ4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:09:56 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB824C06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:55 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id g145so10311413qke.3
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cE4Nr/LA8O+LrDW/9Np3xTZgPYwdOkjrZK8wbRpHm68=;
        b=Wgy6Jd2bKj5pXUI+jF3aoPETdx65ZePhYS5ulN3RbOUnIJrgcXkYiG8qB3WjxLzhl1
         MP67GUyWtANG8RJKoc6y84PLkkY6ZFW9FanPXQZiTSYl2koeh/ohnjSnJpSLAo0dsKXF
         iiX6JZ2/V274rRNF9w29EF/zPxMvfvKH5cN7Re0FsY2xcizejSShEFAXkX9G6CJWR357
         4Nup8CrzaTt5xccuRs/TxgpgfK2vX0MYdRgKm1BYuXicCH4N5eIw9ysTRjOR+bIJ/SPl
         eJf8Mxg8npXNfytikxADbALIBlyqQxQ0NMbe6yQo0/KzFQVu7HSCzeeBMaE3gW9m9d4c
         JqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cE4Nr/LA8O+LrDW/9Np3xTZgPYwdOkjrZK8wbRpHm68=;
        b=bf9O7L1l3uVFCLrpoQIC7iKwd6ZGr0erSR/ILp6pz60DJbfDH780+pVl7Q1lBic+fL
         UrLcgmUHCOtxgkkaJSCtuMO2lXAMeTnO+n/ZJuhUPk97HNgryZIytF2kH63A7Ro5UKNM
         oxxg3pYYaZKPOPMEc6KEcwsqgCrPhzvpD8XhYEzbaC9tz/x2SniIpG89ArFl0Zb26m/v
         FdGbbDSSYasN27mIHn+oXszHJLABlvYLjZCwHb4PfJHkLIvZ0D2J154WEoGSCNB66I3w
         VGjE0HCUbtnzNN2Q3OI4W7GIfoAfQ8ScRkDF4UvF9HvNRUYoQAsM5TssrXqwOSW0lPMW
         6KBw==
X-Gm-Message-State: AOAM530qkNNKR97Ai7XnrK+Z5PsJp8CGkqN8YCqGnYZtQn+WHJgXL58S
        pvg7fAZE1FALWXerI1OYEqE=
X-Google-Smtp-Source: ABdhPJy3D3NsVrTV2IfaQ9uAahUxVMhqjfiOQjKHsieAKv9sHt7G7GzesKbwi5EWdCCS+1HjPfEppw==
X-Received: by 2002:a05:620a:25ca:: with SMTP id y10mr15426356qko.526.1643137794844;
        Tue, 25 Jan 2022 11:09:54 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id n6sm34802qtx.23.2022.01.25.11.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:09:54 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 8/9] rpcctl: Add a man page
Date:   Tue, 25 Jan 2022 14:09:45 -0500
Message-Id: <20220125190946.23586-9-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
References: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
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
2.34.1

