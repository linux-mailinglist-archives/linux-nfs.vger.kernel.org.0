Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA78F26CE8C
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgIPWSS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgIPWR5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:17:57 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A041DC061A2B
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:41 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r25so10071162ioj.0
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HDeNnwztZp9r/rjnWz7OXENZ8taHfYg/t80rlob2uME=;
        b=co7CwOLvYFnTADyxJtt00pymDpStyTFlksYlMVSI0gBdXcHKBHuetezOciWUJo5vQc
         iB0PfnRCjdiDLQTXlrHF+MKApCFf4dfZ9eYLCU69OhFdJw1Uw5VxMCRXwRwC2vOdNh1c
         rn7jreE+G0fsaFUKKuYJ4N/RQr21j6K8aIRjlgPlRyAI8SzL6GJRuYK0JdQE15IHQGf7
         MiQK/yMZGQPx7q4esT6MrrLElzEfIxU4YcT1HUKK4EmJf5VlwNljMJV+sKc6kP0aweTw
         +epGpSnA6PkYWCBLWENHARCi2sBZtpMxgni6Ad7T31b16gUX9Wmsa/Egg/P4NeCeWvPz
         dnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=HDeNnwztZp9r/rjnWz7OXENZ8taHfYg/t80rlob2uME=;
        b=pKLCRjd4xFBjI+3JkvZvYszpZREiMz5opS2kXwvu3cmpiba7/O4kt916UhylnEGyNo
         GusH3Vh4wFAm5ffj333yhE/D2b+kePCbY0WAHX/+riPAIezy+dsQgEp1KqL6Vi9ymuWA
         U91Efcp8O0tTDcPlhI4h/7aoc5jv3FZnoipGG36AFpNPoZuLJMEUXacVGTGOEplT+QCN
         RRv3FJs6ZyZUjCWcQLRSoEqoUEtui3gDUsk4VOaA+3PVRCQof4kVumusj2pA0YaCAOgs
         vKCMWfUR7xeMjRRup05LoviDXlQ108U+cNVspdAsL1nOh9z6Ne+UpfcOF1DC7CqmMaxa
         HXPQ==
X-Gm-Message-State: AOAM531KU6K0d2oPw+xLvAToLZDcsE2OXA4y8tR9CD1W1/XAidaYPMzJ
        FdNiZQutIsWKR7SvQQ5iohw=
X-Google-Smtp-Source: ABdhPJzCY4TTyA+nbS4jQS2SCwhodi76lxamatUAWUljfpCi7eq4nGlVMvhytyhYNLugdmQx82CndQ==
X-Received: by 2002:a5e:881a:: with SMTP id l26mr20459887ioj.51.1600292561003;
        Wed, 16 Sep 2020 14:42:41 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z72sm9817121iof.29.2020.09.16.14.42.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:42:40 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLgdqj022993;
        Wed, 16 Sep 2020 21:42:39 GMT
Subject: [PATCH RFC 05/21] NFSD: Remove extra "0x" in tracepoint format
 specifier
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:42:39 -0400
Message-ID: <160029255940.29208.17173639745971967172.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
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
index a8013338f4d5..2ed632d36640 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -489,7 +489,7 @@ DECLARE_EVENT_CLASS(nfsd_file_class,
 		__entry->nf_may = nf->nf_may;
 		__entry->nf_file = nf->nf_file;
 	),
-	TP_printk("hash=0x%x inode=0x%p ref=%d flags=%s may=%s file=%p",
+	TP_printk("hash=0x%x inode=%p ref=%d flags=%s may=%s file=%p",
 		__entry->nf_hashval,
 		__entry->nf_inode,
 		__entry->nf_ref,
@@ -540,7 +540,7 @@ TRACE_EVENT(nfsd_file_acquire,
 		__entry->status = be32_to_cpu(status);
 	),
 
-	TP_printk("xid=0x%x hash=0x%x inode=0x%p may_flags=%s ref=%d nf_flags=%s nf_may=%s nf_file=0x%p status=%u",
+	TP_printk("xid=0x%x hash=0x%x inode=%p may_flags=%s ref=%d nf_flags=%s nf_may=%s nf_file=%p status=%u",
 			__entry->xid, __entry->hash, __entry->inode,
 			show_perm_flags(__entry->may_flags), __entry->nf_ref,
 			show_nf_flags(__entry->nf_flags),
@@ -561,7 +561,7 @@ DECLARE_EVENT_CLASS(nfsd_file_search_class,
 		__entry->hash = hash;
 		__entry->found = found;
 	),
-	TP_printk("hash=0x%x inode=0x%p found=%d", __entry->hash,
+	TP_printk("hash=0x%x inode=%p found=%d", __entry->hash,
 			__entry->inode, __entry->found)
 );
 
@@ -589,7 +589,7 @@ TRACE_EVENT(nfsd_file_fsnotify_handle_event,
 		__entry->mode = inode->i_mode;
 		__entry->mask = mask;
 	),
-	TP_printk("inode=0x%p nlink=%u mode=0%ho mask=0x%x", __entry->inode,
+	TP_printk("inode=%p nlink=%u mode=0%ho mask=0x%x", __entry->inode,
 			__entry->nlink, __entry->mode, __entry->mask)
 );
 


