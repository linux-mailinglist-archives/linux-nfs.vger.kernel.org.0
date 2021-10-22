Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE520437FB2
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 22:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhJVU6c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 16:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbhJVU6b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 16:58:31 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6992C061766
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:13 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id g20so5952000qka.1
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hVO7REIp76+2qFpicM+1QVQpZOFHk4LHxdLNe0xZGvE=;
        b=dmedx2CbN2rD5Y+ntf92J01tP1uAfUznPVnqWCVIOdo4YQJ3NaRyOmwqESkomPWrlQ
         AxvvqXJErsNRnOp7/0dn0cQ8d0I9w86vZ2TCEXlOiLcfgXSazZUAqV1iBBsgRuEE40B9
         Qh1OcBR+4GTTO06BaHeoHKgAkGdjaGPlMd2yXTLKu8vu3DqjtuVMRaMe56vISK5RZa6D
         /TCmxWjBO68/EFnnFfGeNpmOApt6Sq+l3elNQaarXEk6w2AFHGCdyRUwT+FRS0Odrd6z
         damYMf7MFMAqkxZVREM9+ATJMp9zsv3rfyyeWNygRjcBe1+VjZyhFRDO6JAHe8+2kPwY
         gVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=hVO7REIp76+2qFpicM+1QVQpZOFHk4LHxdLNe0xZGvE=;
        b=mvLFIJI77PJ5oS8i5BTRTXMCbAlkitJo+QWGy0Kcrp1i3lLljf5liproEXufD4ofOq
         fhaukMbOjOM+T+WeYNacp+HcH+MfowiNJTAMlT1WQjDJB3dMGmb7ehDL2JGSvLNYBe62
         bYAtUOHWujubHTPQZDyrCrdRnr1zHV8GGBQHEqQnmP2MHQa7RMCE+68XahOSHF1EgHyW
         wmv2hVjsyXMyXt7cOe/khPKsI03oBTk2LfP69ayo9YN8GBXR+IA5P1FX5F11AMqlxcGF
         7Qd8YGGPbyCY6Kq28UXDsjvVIRovfFREwZWd5QJ5Na/hXpOBzVZ14mfDtHLYTWW7kAmT
         118g==
X-Gm-Message-State: AOAM530bhROMWQ7V+dn8wEjy45NLwqdnGwIaTQdOnKysj8WkVj77RbUo
        T+OcpDKGg/x+CrK/QTgUF4E=
X-Google-Smtp-Source: ABdhPJwfRQFYwVpKT6W7nOeRq4sYsmi0bi2Ev32sVcFVtvIZiom6STXSN4Kn1H2Y5ot6IDWaxm8tjQ==
X-Received: by 2002:a37:6309:: with SMTP id x9mr2013606qkb.414.1634936172924;
        Fri, 22 Oct 2021 13:56:12 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id p9sm4576279qki.51.2021.10.22.13.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:56:12 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 8/9] rpcsys: Add a man page
Date:   Fri, 22 Oct 2021 16:56:05 -0400
Message-Id: <20211022205606.66392-9-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
References: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/rpcsys/rpcsys.man | 88 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 tools/rpcsys/rpcsys.man

diff --git a/tools/rpcsys/rpcsys.man b/tools/rpcsys/rpcsys.man
new file mode 100644
index 000000000000..ce58d290f9ff
--- /dev/null
+++ b/tools/rpcsys/rpcsys.man
@@ -0,0 +1,88 @@
+.\"
+.\" rpcsys(8)
+.\"
+.TH rpcsys 8 "22 Oct 2021"
+.SH NAME
+rpcsys \- Displays SunRPC connection information
+.SH SYNOPSIS
+.B rpcsys
+.RB [ \-h | \-\-help ]
+.P
+.B rpcsys rpc-client
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.P
+.B rpcsys xprt-switch
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.P
+.B rpcsys xprt-switch set
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.RB [ \--dstaddr
+.IR dstaddr]
+.P
+.B rpcsys xprt
+.RB [ \-h | \-\-help ]
+.RB [ \--id
+.IR ID ]
+.P
+.B rpcsys xprt set
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
+.RB "The " rpcsys " command displays information collected in the SunRPC sysfs files about the system's SunRPC objects.
+.P
+.SS Objects
+Valid
+.BR rpcsys (8)
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
2.33.1

