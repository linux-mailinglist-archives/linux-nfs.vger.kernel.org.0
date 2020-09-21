Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBE527319F
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgIUSLp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgIUSLp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:11:45 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB65C061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:45 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id f82so14669230ilh.8
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eSvVKyosHRV+Br87fyyqZwO0P0fXfteskPGR0M1m5Hs=;
        b=vSQ4RtDt9yl3XQXynk2h9Erwlt8O14FMxW7ScqJtJP0mHEoUW2B+nbvwyc4lfGuW5D
         rVIcASLOlejg74cykw19px5Nxf/fff8Y6pQAb+pTF6j/ZsjXD9U+wYCgZlVmY03eSL+u
         YO7ETXe2vcSRvJIA5iVywUUSMmj35CWKduheRCLRLfwIqVviYKCjUiLNYpC6DypQoGvX
         oVQcEe4jxla0x1dW7SrED0oxZVjFradQy8M6Xj8WR+L1sLBIatCk1kbrbWJS2mII8H5y
         v1/S41FG2vJKObdcyPkKOghTVdu9od+BQF5H8a6c8ma+cKQg54F/uAO4zArciGEH54kP
         SAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=eSvVKyosHRV+Br87fyyqZwO0P0fXfteskPGR0M1m5Hs=;
        b=YaamhzT4ia/M1+CguGmcNQoXgxnzXsp2rHWvAeTXOqrtQNm4dRPCVBJid8fy4JURaC
         QCuug6qxv43o5W0GI2byirSiJewjXN0VFjdS1vkAfDE04PsiJixn+cytk4Gy/p9z/ejT
         bVLHi/hMzT/L3s0dSn66EzM6w6Y4++mun1OHpp8WFzZf92VmiD5yz8si4ya0o5SVdld+
         ZIsbYb/mkJHjYKENMFbfTzFIX9rjt6S+y/ptuXia5qKxXjKaFnVXiOxz63YrlUeNsWHL
         e3hb4jTpJrKGwm/31Cldjx956QjTLsW4Aw3z2ZjUV7UTi9gBB3e/dgvZqsZNORrhqkgv
         Uxkg==
X-Gm-Message-State: AOAM531UP4KHLu2DSM0YLHedZfOTlc2cnrBxu7d+k6hHfNG/P7Q+bQIQ
        1taQgohzQ6LWAYgaJIAg+pE=
X-Google-Smtp-Source: ABdhPJwZ2ickE5i3z8ezxGnBcwmawqZAgZTuqwylHIk2XF+HJ6+Gvwdt204RlADo4+l18/aMCha8aQ==
X-Received: by 2002:a92:2411:: with SMTP id k17mr1036733ilk.55.1600711904264;
        Mon, 21 Sep 2020 11:11:44 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y10sm7565173ilq.39.2020.09.21.11.11.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:11:43 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LIBgb3003872;
        Mon, 21 Sep 2020 18:11:42 GMT
Subject: [PATCH v2 10/27] NFSD: Remove extra "0x" in tracepoint format
 specifier
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:11:42 -0400
Message-ID: <160071190266.1468.2338772497526165386.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: %p adds its own 0x already.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 8d72829f15ac..62bf57a8d03c 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -474,7 +474,7 @@ DECLARE_EVENT_CLASS(nfsd_file_class,
 		__entry->nf_may = nf->nf_may;
 		__entry->nf_file = nf->nf_file;
 	),
-	TP_printk("hash=0x%x inode=0x%p ref=%d flags=%s may=%s file=%p",
+	TP_printk("hash=0x%x inode=%p ref=%d flags=%s may=%s file=%p",
 		__entry->nf_hashval,
 		__entry->nf_inode,
 		__entry->nf_ref,
@@ -525,7 +525,7 @@ TRACE_EVENT(nfsd_file_acquire,
 		__entry->status = be32_to_cpu(status);
 	),
 
-	TP_printk("xid=0x%x hash=0x%x inode=0x%p may_flags=%s ref=%d nf_flags=%s nf_may=%s nf_file=0x%p status=%u",
+	TP_printk("xid=0x%x hash=0x%x inode=%p may_flags=%s ref=%d nf_flags=%s nf_may=%s nf_file=%p status=%u",
 			__entry->xid, __entry->hash, __entry->inode,
 			show_nfsd_may_flags(__entry->may_flags),
 			__entry->nf_ref, show_nf_flags(__entry->nf_flags),
@@ -546,7 +546,7 @@ DECLARE_EVENT_CLASS(nfsd_file_search_class,
 		__entry->hash = hash;
 		__entry->found = found;
 	),
-	TP_printk("hash=0x%x inode=0x%p found=%d", __entry->hash,
+	TP_printk("hash=0x%x inode=%p found=%d", __entry->hash,
 			__entry->inode, __entry->found)
 );
 
@@ -574,7 +574,7 @@ TRACE_EVENT(nfsd_file_fsnotify_handle_event,
 		__entry->mode = inode->i_mode;
 		__entry->mask = mask;
 	),
-	TP_printk("inode=0x%p nlink=%u mode=0%ho mask=0x%x", __entry->inode,
+	TP_printk("inode=%p nlink=%u mode=0%ho mask=0x%x", __entry->inode,
 			__entry->nlink, __entry->mode, __entry->mask)
 );
 


