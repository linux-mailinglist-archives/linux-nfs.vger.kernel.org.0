Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AF02C1599
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgKWUEw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbgKWUEw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:04:52 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864C6C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:49 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d9so18216896qke.8
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GQDCey4LXxpSI4KVkEqiWJdxjzTi2/ZRohD25cPmZI0=;
        b=ICPFBv++LtP1ME9TZpcNWx7YVOhK27KKLscw2Tslt2zdNx3J3uqn92q45GkbTEsWap
         xNKV/tQhbne6uDmBa2V0CDqZrKFdgZyhn/bzH2wZziGggj7QdId5zcdzu3LBZXMPEs39
         PQnDurqFrZgBSrYm+B1O1aJgNE4qG+1rCdbpkNBrmRxkpq8/NgzxqvhfCF+f8jamuu6q
         1QCOyffNpxISXWigvGZfL9LtbWwW+y/VL9ZLcGAUHXfCQ5Bez5M2yTl+HTqk4CTxIG8U
         DxBLFW6Yy2ppOEaA4wOlQ4Hi09fyi13gVeOCrTK9CseLuxJf7nwryLevwQHOr2QUiQ94
         KLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=GQDCey4LXxpSI4KVkEqiWJdxjzTi2/ZRohD25cPmZI0=;
        b=iHr0y08XpooTNC4uUBbCGGDOJlCULXv5Me6S5MxTysAaZRoDkEFie8ouFvPNJY6XVo
         CzkDGlo9E7pp2Y9mzDVOx+jQkJ/GCO+jUjNSNCcw37DLC0mX5TqUHbR/nwzuB8Tfimjh
         BqBfV38bCcALORTv2nEJxCkAZxwn9Memq5bl17vyRIjqxETQRX+5blCTbCus/JdrXNJ9
         95A+hYI+oWr8JGlDQoIp3YdwE58IlKsoNG4a+68Ac2gbV/NsHoXLuXqxY1kQ4uWPbEX8
         TeRCg586Mo9mRDCJ/Izlk0mwvg0AsbRZxe/ACIuwVI2k+EMOgdqbyH57hh7UC2XBYUJm
         7LAw==
X-Gm-Message-State: AOAM531bwfd58hcwqEjrcKlrl2n6vXwsf1V8ImaWVfmPK9+FwHogDDZl
        Bav3oLUUTSKZTIVT+AtIL8GA9G4jxj8=
X-Google-Smtp-Source: ABdhPJxGBkTrJzNRhOftXgM3W8vKHTmNpfvIPhvs0U4QOQTBUIKbpjnOG+sh3jEgTEHPEhL0uHwgvg==
X-Received: by 2002:a05:620a:401:: with SMTP id 1mr1219983qkp.257.1606161888398;
        Mon, 23 Nov 2020 12:04:48 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a13sm6442299qtj.69.2020.11.23.12.04.47
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:04:47 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK4kAD010295
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:04:46 GMT
Subject: [PATCH v3 09/85] NFSD: Replace READ* macros in nfsd4_decode_commit()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:04:46 -0500
Message-ID: <160616188664.51996.938229739001960697.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c          |   12 +++++-------
 include/linux/sunrpc/xdr.h |   21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index fd7447d07009..de7408adb7c6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -581,13 +581,11 @@ nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
 static __be32
 nfsd4_decode_commit(struct nfsd4_compoundargs *argp, struct nfsd4_commit *commit)
 {
-	DECODE_HEAD;
-
-	READ_BUF(12);
-	p = xdr_decode_hyper(p, &commit->co_offset);
-	commit->co_count = be32_to_cpup(p++);
-
-	DECODE_TAIL;
+	if (xdr_stream_decode_u64(argp->xdr, &commit->co_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &commit->co_count) < 0)
+		return nfserr_bad_xdr;
+	return nfs_ok;
 }
 
 static __be32
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index cc64cd0891f1..cc669d95c484 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -571,6 +571,27 @@ xdr_stream_decode_u32(struct xdr_stream *xdr, __u32 *ptr)
 	return 0;
 }
 
+/**
+ * xdr_stream_decode_u64 - Decode a 64-bit integer
+ * @xdr: pointer to xdr_stream
+ * @ptr: location to store 64-bit integer
+ *
+ * Return values:
+ *   %0 on success
+ *   %-EBADMSG on XDR buffer overflow
+ */
+static inline ssize_t
+xdr_stream_decode_u64(struct xdr_stream *xdr, __u64 *ptr)
+{
+	const size_t count = sizeof(*ptr);
+	__be32 *p = xdr_inline_decode(xdr, count);
+
+	if (unlikely(!p))
+		return -EBADMSG;
+	xdr_decode_hyper(p, ptr);
+	return 0;
+}
+
 /**
  * xdr_stream_decode_opaque_fixed - Decode fixed length opaque xdr data
  * @xdr: pointer to xdr_stream


