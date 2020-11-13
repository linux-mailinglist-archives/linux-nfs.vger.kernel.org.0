Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523BA2B1E11
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKMPEs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKMPEs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:04:48 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4B4C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:38 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id v143so9049355qkb.2
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BOA3/gpC8KoOI5zEgZWXsL21bRgeDHSYxxkjC7xgdtI=;
        b=Gxgp+IR7YDPf9q7xmU0PeWVJ1fby+mghyKRCyvAI5+q/WKbuLae8KGKuX34Rz6G3w3
         2kAfXuJgrPc8PRp2niRJqgWSwurk9MflJxl+WkRw82nYuDOUOYjfBznM3Amy4cLdNpks
         2tQHRS+7F/xVIZ7OiGVvs97y1AuSYKse796G9uMfKWVFLUsyr/HUqctaA9MkxyhIeE92
         YrGpzadpRUQf1w45MxeD/xa+0mScmLGzoLbCw9SfRgB8/vKVOupatwSfLRtYehuRPpEl
         FKmqjT7kyQI8M+qKEaDqbhubaQmrWY+0QNsu4LPAPcrkaOs6HFI32GqBWA70nnaMjDSu
         bsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=BOA3/gpC8KoOI5zEgZWXsL21bRgeDHSYxxkjC7xgdtI=;
        b=lIIA2yWBKVA/bLSRNtnejFIkjKuE0rP3D4WQdzbjA1KIX4jbNnG3oa/FcFYWqd99rv
         vuxdR7d1+wJHsKZAVDEgBptrjwjizNp24RoCvMoOLm4STlJ8m9WP0NF0HK3vdr2oRVDu
         YVao+MwJ8/7u+0uaNt1DRxRnRNdDxcoLLp2XxpFx4NVi0tRL0z73gg48OKsuHy/k/S07
         n5tMlvtc3isMhjZVnpLKsgaxlu7a3Tx3aIbY0ETWOggCemL6HfEf7ccknAGivtIeavyM
         4qse38KdVAFI5OHYPd2rtVWGpTCjN3VwKmonV2UHysyKJwZbTRb6sp2Hs7DxyYRsFhcg
         bCqQ==
X-Gm-Message-State: AOAM532cVFTDVXXMkgrZHQQd3tso6bLx/5GAQQd1QRf1N3s3v4HmZbgS
        yRN52N5EPuwF+xPEt94aJObf8WF91f0=
X-Google-Smtp-Source: ABdhPJwpXcpV2ha7z4sLaCrdpZfdoGMbw/6Fb4js+FNMjNwxwIXIb0mZ7EQG87Zy+mwZdkDYmp/fHg==
X-Received: by 2002:a05:620a:41c:: with SMTP id 28mr2423837qkp.270.1605279876079;
        Fri, 13 Nov 2020 07:04:36 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l22sm7323317qke.118.2020.11.13.07.04.35
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:04:35 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF4Yve032712
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:04:34 GMT
Subject: [PATCH v1 25/61] NFSD: Replace READ* macros in nfsd4_decode_remove()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:04:34 -0500
Message-ID: <160527987445.6186.4502201022745601534.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2e163c23d013..58342971fd6b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1223,16 +1223,7 @@ nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *read
 static __be32
 nfsd4_decode_remove(struct nfsd4_compoundargs *argp, struct nfsd4_remove *remove)
 {
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	remove->rm_namelen = be32_to_cpup(p++);
-	READ_BUF(remove->rm_namelen);
-	SAVEMEM(remove->rm_name, remove->rm_namelen);
-	if ((status = check_filename(remove->rm_name, remove->rm_namelen)))
-		return status;
-
-	DECODE_TAIL;
+	return nfsd4_decode_component4(argp, &remove->rm_name, &remove->rm_namelen);
 }
 
 static __be32


