Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CD11DD00E
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgEUOgD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgEUOgC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:36:02 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B837DC061A0E;
        Thu, 21 May 2020 07:36:02 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k18so7715810ion.0;
        Thu, 21 May 2020 07:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zaUDXjk9mBdHC+oryUxIbw4VHsQenH4+TiMtOkvnFQs=;
        b=Km7OtlxTr9wXJSDCTUYGYQsGMpMCL6T0A+xV1OiHp2xcDOsd72IgdCrDlzjs8nWA0V
         I7uDiqaqdsuWySp7lUPlW2+IyR1YAYij9Uc9aJ4q9OoUs+0OQOW6vAcub+dv2/24mp0z
         pYSaTxcnrb1nmZh2zhb5Z4YSfkt7PdtgEDfH4m+lyc2gyFe6PDg59QOFkq2lks4gpA71
         1tiUeAEJ97ML/bAnWKIDyZxAi2slcOna2xSPeens71OB99lKxEKZvQ0gVom7HP9XjMdY
         rmrf8/jG8hI4TW/QOysL7xwr7AHwo1lJd4n7fPa/0TWhryZmmkqV/PO1rxHxeJLKL8Bl
         gftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zaUDXjk9mBdHC+oryUxIbw4VHsQenH4+TiMtOkvnFQs=;
        b=BuyU9PsUcBOjDTI0a3CoXmt5IpHt4Kcl0T9A2GprYr7V3tnmifksA46JufQgiBMvaw
         zKqs0VQuL3tum1X/ABENxZbTIYclMbJ1/9z6AMU+k8OeIDx4SvJoankI0eOwcqrjL4X0
         65V/LDCF3cwPk2D5LtF+N8i8yWZH7bwip3yzPBC51EsGHnwGPP675rNv2tPfMpXDuClD
         uUSTKfdbUETtLtgflN/bVaEYagwN14EU6qq0MN4pkyP2mTh7mXmCaigo3IgGw4JEUZCu
         r21w27VhjlhBQN8ghk/yMWiCTNdbLp8EKFv3ifClciesy6j0pb6VAt3n31qh+ASz9eJC
         nD8A==
X-Gm-Message-State: AOAM531iD077todV+tZ/EQS1QvhA43ovyhFyuNKJMqHJbzAZAsrvq1Bz
        tySlrOqVFSBiHfRxofMeZqwT33Sw
X-Google-Smtp-Source: ABdhPJwm/oGGFT2Yye8BD6ctgjfYRepAdfGIoTNsQ3GRU8DC2jHZV1+HljDrWdZW0rZCqwXJp2iT3g==
X-Received: by 2002:a5e:8914:: with SMTP id k20mr8018422ioj.108.1590071761950;
        Thu, 21 May 2020 07:36:01 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s5sm2494569iop.4.2020.05.21.07.36.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:36:01 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEa0C9000917;
        Thu, 21 May 2020 14:36:00 GMT
Subject: [PATCH v3 26/32] SUNRPC: svc_show_status() macro should have enum
 definitions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:36:00 -0400
Message-ID: <20200521143600.3557.26850.stgit@klimt.1015granger.net>
In-Reply-To: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
References: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Add missing TRACE_DEFINE_ENUMs in
include/trace/events/sunrpc.h

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 08c7d618ceb4..2a7f6f83341f 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1057,6 +1057,17 @@ TRACE_EVENT(svc_recv,
 			show_rqstp_flags(__entry->flags))
 );
 
+TRACE_DEFINE_ENUM(SVC_GARBAGE);
+TRACE_DEFINE_ENUM(SVC_SYSERR);
+TRACE_DEFINE_ENUM(SVC_VALID);
+TRACE_DEFINE_ENUM(SVC_NEGATIVE);
+TRACE_DEFINE_ENUM(SVC_OK);
+TRACE_DEFINE_ENUM(SVC_DROP);
+TRACE_DEFINE_ENUM(SVC_CLOSE);
+TRACE_DEFINE_ENUM(SVC_DENIED);
+TRACE_DEFINE_ENUM(SVC_PENDING);
+TRACE_DEFINE_ENUM(SVC_COMPLETE);
+
 #define svc_show_status(status)				\
 	__print_symbolic(status,			\
 		{ SVC_GARBAGE,	"SVC_GARBAGE" },	\

