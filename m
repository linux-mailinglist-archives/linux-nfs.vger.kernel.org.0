Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF722C15B7
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgKWUH1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgKWUH1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:07:27 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D47C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:27 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y197so18232570qkb.7
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=g6rdx9vnEwrtoKkJfxVy0nAKUPNObAz6vDgZBwi55mA=;
        b=O10YyuWEORmLwXSsfI4bqxs7DnZXc/UIca+fgQoeLiLdYoILgXFj56Ob9L2OzcLOEz
         CvThOy/O9rppIgezuRuaGTUf3WevvenGzRicTwrPbOeclThreCAqs6DKutZw6gDnNIwG
         ZbgTt3tm2iSTKL1NzfCIQF9cmiEiHR4dVhdA/Gvia9MdtZ2g/F+fLn4EoIFGs3obTpWM
         lQScEnqcRQX8uBVPTz2SIbh+UXXL0wOAr3AqK74I0bdPsNeO2CSI+1UuFI6BbyH1sD4m
         0Cf1yUs7DjqnqnbuY9Wp8FIzFP3FSPG0zFnmidq8RPkhhEfsGqpkHVE77GC0cL2EtHX4
         UkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=g6rdx9vnEwrtoKkJfxVy0nAKUPNObAz6vDgZBwi55mA=;
        b=PjjrNwvfKSs135MRhEftcAhBMumvN/1P4TahlXYy2p7/hbsFLky6ePTlY+ljVHOWla
         zI+lXwIVDyjrMABSB8dS4I18B5jsLibL965vXh7DL7/w+S4+u8rUesYdr9xNiWeh4WEN
         R1dwTYbsudzpsBWIZGwyVV76ZaC83JOzCKfB1Haa1Q0lfaLgcwQb20uSI4wmYylZf0RU
         ZNhbWd2lNA5nhvPyB6B4hN3Gl+9dmeC4mAyRxNlYxebHFHlMRhXssq627I8no5e2tOeY
         B53gEegXyBNaHLwVbPU/kVOssYhl8P9aj2ezqcE5LUUULkHTZ5pWoFVgL1QFnpMaSOMG
         yM/A==
X-Gm-Message-State: AOAM531qBXG0ZaonxvKpiheRGD9JtVKh6XAaVVu2hIkbwMPQFOVuwe5L
        Tf0XLm9zcIQkDWA5yofNbLGiRHCS7ho=
X-Google-Smtp-Source: ABdhPJyRlyYMWMi9ssaHHt1qh0/yr+32lnmUHvbnoUk8CNJI1b++tXw0Vymp3N/Xdqg4wv3z3OB/AQ==
X-Received: by 2002:a37:9e16:: with SMTP id h22mr1166981qke.481.1606162046132;
        Mon, 23 Nov 2020 12:07:26 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n21sm10738192qke.21.2020.11.23.12.07.25
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:07:25 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK7OTB010385
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:07:24 GMT
Subject: [PATCH v3 39/85] NFSD: Replace READ* macros in
 nfsd4_decode_open_downgrade()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:07:24 -0500
Message-ID: <160616204472.51996.10477496304909146320.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f0484d9c7b78..54bde3ac92f1 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1172,21 +1172,19 @@ nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_con
 static __be32
 nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_downgrade *open_down)
 {
-	DECODE_HEAD;
-		    
-	status = nfsd4_decode_stateid(argp, &open_down->od_stateid);
+	__be32 status;
+
+	status = nfsd4_decode_stateid4(argp, &open_down->od_stateid);
 	if (status)
 		return status;
-	READ_BUF(4);
-	open_down->od_seqid = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &open_down->od_seqid) < 0)
+		return nfserr_bad_xdr;
+	/* deleg_want is ignored */
 	status = nfsd4_decode_share_access(argp, &open_down->od_share_access,
 					   &open_down->od_deleg_want, NULL);
 	if (status)
 		return status;
-	status = nfsd4_decode_share_deny(argp, &open_down->od_share_deny);
-	if (status)
-		return status;
-	DECODE_TAIL;
+	return nfsd4_decode_share_deny(argp, &open_down->od_share_deny);
 }
 
 static __be32


