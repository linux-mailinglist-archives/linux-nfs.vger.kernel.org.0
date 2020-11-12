Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E8E2B0806
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 16:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgKLPBR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 10:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbgKLPBQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 10:01:16 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8603FC0613D1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 07:01:16 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id p12so4127063qtp.7
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 07:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lMzgQJOuhO0sJpRrzKaMiSsWi3enjCadO/klRPD0X1w=;
        b=drkzMM6IS/zO9a/mrmNa8sf7/hjg5FUPWTmkxszRxGCy1BfP2LgaRg5SLOWk2bM19Q
         zPnIZUmxCP0OHFikmWnN1NeIiUO4XkMkVSa/O0Aib0/M4KtV4vRIUSaxmx26iPKoH2Vz
         LnM62WLstGEY86a7cNTvnBEbAq19npyfCY0yrkRka21HUBKKIT4V3qh6smE5uWSybSHD
         VHz3B9lKxUwiHgbq4vN2k1mprHSLa0GTfcu17kuu66rZZ0zXSP7qsRCmsvOv+G3Dcm2S
         Y5H3Kh1fqMASTvKBDkhInAvFtmwjgU95K3jwIkUFC5L8pTnH2YSayZc/d4NtBcL5GYE5
         TX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lMzgQJOuhO0sJpRrzKaMiSsWi3enjCadO/klRPD0X1w=;
        b=VmdRAHkm5guRmwiNqmcniX7bWR9Dkvi5q7DwPUgxcD3So/xjNxCx6fZb9kk5KZNgqb
         sTTispfEvBAGY3PG2ODskwezLcw1Mp+njisP5I/UbGwFt+7NBWJO6mKBZDY8WhC9rhhc
         rR7KzCeCV7FENIzh/7B4bzM6Vn/UkVSSm7ReDQ20rj/aE+p1x8ojyTEHOgJBi1oqeHwT
         0If92GmUi1/soHyk3sbImFDs6R7ygJjhHRusdGhUkHUblPuk9TZD/Aq5mL0thJzpqr58
         9xR+1XsUoFzJIWBHCh58tYP5RboeqjQz9Kp1SXykiYLRTfOM3dG9Z8xsJQq+s4f+Iast
         jjIQ==
X-Gm-Message-State: AOAM533113+oB+YPH9is1DOxQTHzsVzPWXmDdyg0QSXApQhcFlyXJlUm
        CIzxTAhV0Bp0UMA4QDmKvArfiMctgrw=
X-Google-Smtp-Source: ABdhPJx984SdvatqW3TgRDSUQ5Uy5h8RbBQyoSD03K1eUT6UAWfHriX5ohsf4NMPBSym8S8IZ1BRXQ==
X-Received: by 2002:ac8:41d7:: with SMTP id o23mr24840047qtm.368.1605193275473;
        Thu, 12 Nov 2020 07:01:15 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r55sm5295928qte.8.2020.11.12.07.01.12
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 07:01:12 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ACF1Btc029805
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 15:01:11 GMT
Subject: [PATCH v1 3/4] NFSD: Remove extra "0x" in tracepoint format specifier
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 12 Nov 2020 10:01:11 -0500
Message-ID: <160519327188.1658.15388296411388277031.stgit@klimt.1015granger.net>
In-Reply-To: <160519319763.1658.12613346131541001302.stgit@klimt.1015granger.net>
References: <160519319763.1658.12613346131541001302.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
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
index 532b66a4b7f1..33facf9f518a 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -473,7 +473,7 @@ DECLARE_EVENT_CLASS(nfsd_file_class,
 		__entry->nf_may = nf->nf_may;
 		__entry->nf_file = nf->nf_file;
 	),
-	TP_printk("hash=0x%x inode=0x%p ref=%d flags=%s may=%s file=%p",
+	TP_printk("hash=0x%x inode=%p ref=%d flags=%s may=%s file=%p",
 		__entry->nf_hashval,
 		__entry->nf_inode,
 		__entry->nf_ref,
@@ -524,7 +524,7 @@ TRACE_EVENT(nfsd_file_acquire,
 		__entry->status = be32_to_cpu(status);
 	),
 
-	TP_printk("xid=0x%x hash=0x%x inode=0x%p may_flags=%s ref=%d nf_flags=%s nf_may=%s nf_file=0x%p status=%u",
+	TP_printk("xid=0x%x hash=0x%x inode=%p may_flags=%s ref=%d nf_flags=%s nf_may=%s nf_file=%p status=%u",
 			__entry->xid, __entry->hash, __entry->inode,
 			show_nfsd_may_flags(__entry->may_flags),
 			__entry->nf_ref, show_nf_flags(__entry->nf_flags),
@@ -545,7 +545,7 @@ DECLARE_EVENT_CLASS(nfsd_file_search_class,
 		__entry->hash = hash;
 		__entry->found = found;
 	),
-	TP_printk("hash=0x%x inode=0x%p found=%d", __entry->hash,
+	TP_printk("hash=0x%x inode=%p found=%d", __entry->hash,
 			__entry->inode, __entry->found)
 );
 
@@ -573,7 +573,7 @@ TRACE_EVENT(nfsd_file_fsnotify_handle_event,
 		__entry->mode = inode->i_mode;
 		__entry->mask = mask;
 	),
-	TP_printk("inode=0x%p nlink=%u mode=0%ho mask=0x%x", __entry->inode,
+	TP_printk("inode=%p nlink=%u mode=0%ho mask=0x%x", __entry->inode,
 			__entry->nlink, __entry->mode, __entry->mask)
 );
 


