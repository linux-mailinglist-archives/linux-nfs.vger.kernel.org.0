Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96652C1598
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgKWUEp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbgKWUEp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:04:45 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D22AC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:44 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id t5so14373516qtp.2
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4+wQXn4zDGfwNooc/nX4OmYNvKGDHnBDGPd/i4l+RJY=;
        b=cKy2M8i3f9/Wp1aOvBNSRK6XfhmdxgSqCvK+ejpQz60Lm0jkmJ9RGpOnsjtYjQUM2k
         LrakjwdK5o/sfhHYn8Owc/cnV22UdQ9jRJBXMYUow+WicMctUy5Cs5kACpTSqqiEQMPT
         aHWziBY1JILRT41s43ioo2W3kd3rEx6cfehA211jkfbZIkGKzrYBX3Q+jTV7u1AnriPY
         Ys41dRsWcVzRhWGWJNQKjGe/ijoZAe6vBBfa+t3krAdvwELTGblvOBMBm/AYqRcKgRpo
         irfQtdIwAfhVO7JiZSdX4/QdIP7r4mRylolJL2sjTFbNieVLnjOBDeK/U42RngVEtvHA
         alZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=4+wQXn4zDGfwNooc/nX4OmYNvKGDHnBDGPd/i4l+RJY=;
        b=Rg0sJa1w93sl+9mjyjUOTl+2xX/yX/X6fbAWwV1JHeNekcwA4WvmHhdW13TOt1ukrM
         EtCQCk6bQqE3WiLNdwEAWxSOsft4R8r/0w3S5rXAX0CHZtBQszgJfG0YOKk8vAMjP+3G
         K7/TS2g4Nddo3PwZXjLbrmEGfhJJVQ+GkctgqdpvPyq9hTa3BJCEbb/Qae+5H44k3Ya3
         i1uzG3pV1L5Z3DTrvyRXKnxkZJ4ny2cMCtg+fkTf2PHt7Cfmlwag+GKG8lUgH0mFRSg/
         R6utn83lYXaZmf62FIqsHvGpxjrohrpVzJ+ah9fpHPjSf9l6TQEW+tXU6WyZFnKwNQIC
         Z3hg==
X-Gm-Message-State: AOAM531nmg/elKVzhAJ8cEzDcB9WA9m/A789GPzLIsS2GSjjt0X56wqd
        kt++iVU2XvPrf3ajRR3gqhv5S97Z15k=
X-Google-Smtp-Source: ABdhPJwyfWxH1EdNcSYmJTKhbEY0BgCrZdGngJrGQNtVJcGClNzVtj1J1l0UNzqvbPcZVZmRPpps9g==
X-Received: by 2002:ac8:76c7:: with SMTP id q7mr822544qtr.317.1606161883078;
        Mon, 23 Nov 2020 12:04:43 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e126sm820201qkb.90.2020.11.23.12.04.42
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:04:42 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK4fqk010292
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:04:41 GMT
Subject: [PATCH v3 08/85] NFSD: Replace READ* macros in nfsd4_decode_close()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:04:41 -0500
Message-ID: <160616188135.51996.6016156334767656634.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f490832a1a06..fd7447d07009 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -439,6 +439,19 @@ nfsd4_decode_stateid(struct nfsd4_compoundargs *argp, stateid_t *sid)
 	DECODE_TAIL;
 }
 
+static __be32
+nfsd4_decode_stateid4(struct nfsd4_compoundargs *argp, stateid_t *sid)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, NFS4_STATEID_SIZE);
+	if (!p)
+		return nfserr_bad_xdr;
+	sid->si_generation = be32_to_cpup(p++);
+	memcpy(&sid->si_opaque, p, sizeof(sid->si_opaque));
+	return nfs_ok;
+}
+
 static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
 {
 	DECODE_HEAD;
@@ -559,13 +572,9 @@ static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp,
 static __be32
 nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
 {
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	close->cl_seqid = be32_to_cpup(p++);
-	return nfsd4_decode_stateid(argp, &close->cl_stateid);
-
-	DECODE_TAIL;
+	if (xdr_stream_decode_u32(argp->xdr, &close->cl_seqid) < 0)
+		return nfserr_bad_xdr;
+	return nfsd4_decode_stateid4(argp, &close->cl_stateid);
 }
 
 


