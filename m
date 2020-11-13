Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4652B1E13
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgKMPE6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPE6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:04:58 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAECC0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:42 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id z3so3248944qtw.9
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Rez87ol9zstK3tdV5FRQ1lKZUrtn5RDRvFnEn9c16A0=;
        b=V2g7zN87jZ06oABhXM2p8n/9N9n4OAZZtdA/l+Ji13hPtzBnshd5cxX2By8Z3c6dQ6
         yTztoFKreigtILqEn7+77Sq0TP9+GcmHp/4Hl/oXI8nYAFQksedyFo8SuCC4AWQ1anvf
         UEfAqQ16jxcP0V9FmjWUsXlS2Co0B6tWNZFmzGqI+3zPPVp8P4UnO6cBGlipj4AFYp2N
         V2Rqsv7LO4Gm3KN7d/ObfiA0iMIdhX842s30TKegek+Hb1KIAE1KPUSEk5m57DcF+0yO
         gcWCTwcsJBWcAAn8mQjgBJu4/vs1wQzojXn+PACbfVvq5UgsoWCmysstIJswZULYkZuT
         5mbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Rez87ol9zstK3tdV5FRQ1lKZUrtn5RDRvFnEn9c16A0=;
        b=bDaFVygzi5rbktDa5VjtL4YtqBg147ckeHCc7c1cvw3FxvZNGVVN3SRqjiE0PTEMlw
         6MbO4oHO0au0trV3Z1yuYc/U/oRGAjFxjD+euo4q73yC2tBqQ+iEo5lXixgRBNr0cV6v
         acFEiNyvM7vYNPudT/u4Vwcvq3KeaAKvEzZEXKn6t52u4D2IdSuuJAo8hqLwKAs3u5yM
         TfKHKnigTyrGvVucqy0SNR8i03C+EiY5/zSmFesqkfEedKVg+xdXIFdVs6sZmpt94hrg
         ttcp0sM33w3OvfmcwrKwbyyuba4ESRw2Zj0Nunb06f4g7jyT463zMydS3n1IYEMVR4Ui
         6Hhw==
X-Gm-Message-State: AOAM533xCjDqOA+2ZQEoaD30BoQdysmoPErQ2XMjAXbIW2Auh+gp+eSO
        xrGe/XnBxkA2i+NKpLUk8IIovsriP14=
X-Google-Smtp-Source: ABdhPJy8Wkfx9+mjraKBcbcNzVLD83p6v22JBw50yC2IZ7FX6dbnLpplbDcWzKfIxKE3h6j9eJbtdA==
X-Received: by 2002:aed:26a7:: with SMTP id q36mr2375913qtd.134.1605279881554;
        Fri, 13 Nov 2020 07:04:41 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u16sm7417098qth.42.2020.11.13.07.04.40
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:04:40 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF4dLZ032715
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:04:39 GMT
Subject: [PATCH v1 26/61] NFSD: Replace READ* macros in nfsd4_decode_rename()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:04:39 -0500
Message-ID: <160527987975.6186.4294661038410917726.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 58342971fd6b..aa71baacabba 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1229,22 +1229,18 @@ nfsd4_decode_remove(struct nfsd4_compoundargs *argp, struct nfsd4_remove *remove
 static __be32
 nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename *rename)
 {
-	DECODE_HEAD;
+	__be32 status;
 
-	READ_BUF(4);
-	rename->rn_snamelen = be32_to_cpup(p++);
-	READ_BUF(rename->rn_snamelen);
-	SAVEMEM(rename->rn_sname, rename->rn_snamelen);
-	READ_BUF(4);
-	rename->rn_tnamelen = be32_to_cpup(p++);
-	READ_BUF(rename->rn_tnamelen);
-	SAVEMEM(rename->rn_tname, rename->rn_tnamelen);
-	if ((status = check_filename(rename->rn_sname, rename->rn_snamelen)))
-		return status;
-	if ((status = check_filename(rename->rn_tname, rename->rn_tnamelen)))
-		return status;
+	status = nfsd4_decode_component4(argp, &rename->rn_sname, &rename->rn_snamelen);
+	if (status)
+		goto out;
+	status = nfsd4_decode_component4(argp, &rename->rn_tname, &rename->rn_tnamelen);
+	if (status)
+		goto out;
 
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
 }
 
 static __be32


