Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228242BB726
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgKTUe7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731092AbgKTUe6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:34:58 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3C3C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:58 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id v143so10216577qkb.2
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/lnYU4VjGcsj8jSDBqS0kAjeaM7UWGLQgHgYqESNJcQ=;
        b=pZhtK0wD7q4StSQLLe0yRu6nIbaDwEOE3Q6UukaPmoxS4Q9NfAOvsT02b0pwk2HMaD
         Dw6Wbx2sF/RvYFzN7Xf3wj8uFjna2eReCYChLFnZmn/F9OV3FyPblejyF3eGEUi8Z7EE
         FtNN1PsizbuH+wAXkdRZFSwDZ2jUMWFneKb/9xroKFcP22UmE3uPXlPZqXijV2S5kyOy
         K07gICML4xHbZiD+W5o+aEuw4fXp/4iQgs/Bb27sikYSTCFn1WvuvsAYkfX+ncjJ7+i2
         vOIpY2oy4yCqTA0zQFSdQ3BH+1k9cnuZQmo13nI3VC5WsRf+B1zyRIo4vXwBQ5Dn545n
         ACOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=/lnYU4VjGcsj8jSDBqS0kAjeaM7UWGLQgHgYqESNJcQ=;
        b=ftznLV0fQ/kEkOdewBNHf/sDIP2G/cblxGqprjYKXe8WF24L/t23K8KqLC4cfmw/2w
         aoMXS9zQSXzoeCYSTn/zM7CFSCaWJMpnkSBpPe2BPiwvqsEYpdGT+lQ8+mEb7/UC3Yo3
         jkrshkYIwpZP9xZwcGnn6YA0+XdPPz258+Zhn6CWiEo3N9kh9HwLTpP0lJKvpNrXifLg
         ezIuVY52HsAzb1e1VxF2BguRR0xnm8Ze694oCr2Y24M1NUAsPAsyeD5eY2yxaaw5ELly
         r4N1PMs1SGc1jwpLc2VLoMrKV2aJ7TOtzQS42tHkv4AjjGeXqs6jbRB+JG3m8FzV3gBp
         n7kQ==
X-Gm-Message-State: AOAM532kvJqz+ouIThkZ9JvhRESBtmtVvBxR97A4LAt2UJgiFvak8eMX
        cyrOpxnGkFcafOqnq3V5q/mIqPxTBeg=
X-Google-Smtp-Source: ABdhPJzV+GJq40n6D2qMY/LpuQ/Gn2upBjN4TjOqYKws00nsGE5/tj0HgTi6BG5EXFrmen6siDqcAQ==
X-Received: by 2002:a37:6748:: with SMTP id b69mr17594049qkc.336.1605904497474;
        Fri, 20 Nov 2020 12:34:57 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j13sm3084296qtc.81.2020.11.20.12.34.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:34:56 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKYtvr029241
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:34:55 GMT
Subject: [PATCH v2 013/118] NFSD: Replace READ* macros that decode the fattr4
 mode attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:34:55 -0500
Message-ID: <160590449506.1340.15554962777228664236.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 54c553ef35bf..821a03121d22 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -349,8 +349,11 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 	} else
 		*acl = NULL;
 	if (bmval[1] & FATTR4_WORD1_MODE) {
-		READ_BUF(4);
-		iattr->ia_mode = be32_to_cpup(p++);
+		u32 mode;
+
+		if (xdr_stream_decode_u32(argp->xdr, &mode) < 0)
+			return nfserr_bad_xdr;
+		iattr->ia_mode = mode;
 		iattr->ia_mode &= (S_IFMT | S_IALLUGO);
 		iattr->ia_valid |= ATTR_MODE;
 	}


