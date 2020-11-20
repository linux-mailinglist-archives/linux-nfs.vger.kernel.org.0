Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539372BB795
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbgKTUl7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbgKTUl7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:41:59 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D9CC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:58 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id i12so8147734qtj.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gGiw+UR6Z/5VTbMbviEGWFSrf8RziiC1VvarOhwsGD0=;
        b=D6edd4mQjo3dX6Wsm1lCobCwid3gN6L6/RG6rS8Rk2VfmjrAiXl3QF/PCK3/OrQfxZ
         ZwpueeJDw8Hme8Ac85HvgH6xL/vPmuVK412+7fC1wjGhALsM0IWRJoM4WpX88V1SrN/r
         lTZCzxCSSLuDqI+9g+CbavjyUJBBAZzl0iOazvc6mpMnchb0fzQm0hHkq+lX+PnsMdMW
         VzpeMtYWNCT1GE3QZjcf+rKNpqyLt00q9aHEKUaR8auAE6wsRg/+q245eClF6gJ/MOdw
         woMDn15AsgBBtbKTQyiluSipd0xCosGNDW7HYZSnPtdFZ4n0mZho73M/P2i+sZY39CoY
         l04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=gGiw+UR6Z/5VTbMbviEGWFSrf8RziiC1VvarOhwsGD0=;
        b=ma2N8Ewq374fWfY5K9IPYLdrRAmTcXSDBRy6S5ywevjCkVsbBZQsXJ2bwp1f2MwzOc
         5KkymL1j7AI3WOyL7h8BpCSdgxRiNdJ1wJU6kwzZ/w7khl52pS+OfNKa9qT9fWWz2Zme
         TMrM3PSZ+F+GdtKP8lPuNCRxJmejKF0yBLDNG8EfJcj6JexSFhAaaYYCZKYFuIflXZy4
         6QyZPSP7xMBhkfa4QE2Ewj4BeR7yPs4me+dxnbBUCNCdOYKz4WuAiaw31npkOS09dtLk
         I+djtnOfhMSA4Eb9R8ngLfD3yTMqlzIKo5EETL0RF7C4znqycNflhCxqsfgeHmhqQ4Im
         CBJw==
X-Gm-Message-State: AOAM5334CbIwxVXgIyawqTPhcLBWKuSN6wjf1TFsWCpyTJlBZPGD5BwL
        c77n3jGGskAWJbrg/dZsoQblKaaq8q4=
X-Google-Smtp-Source: ABdhPJx0UeV0pwogLOOPNq3eXxU1s0jwJLAeKcM4n98Y/M2qHQPk81Z5GIhfYry7Jv7h6w2kuvZ0Pw==
X-Received: by 2002:ac8:7a7b:: with SMTP id w27mr17455961qtt.76.1605904917481;
        Fri, 20 Nov 2020 12:41:57 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i9sm2692316qtp.72.2020.11.20.12.41.56
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:41:56 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKftO0029489
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:41:55 GMT
Subject: [PATCH v2 092/118] NFSD: Update the SETATTR3args decoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:41:55 -0500
Message-ID: <160590491578.1340.12778361933126858693.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c         |  150 ++++++++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/nfs3.h |    6 ++
 2 files changed, 139 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index b27c04c642b7..5c46ab972a23 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -39,12 +39,18 @@ encode_time3(__be32 *p, struct timespec64 *time)
 	return p;
 }
 
-static __be32 *
-decode_time3(__be32 *p, struct timespec64 *time)
+static enum xdr_decode_result
+svcxdr_decode_nfstime3(struct xdr_stream *xdr, struct timespec64 *timep)
 {
-	time->tv_sec = ntohl(*p++);
-	time->tv_nsec = ntohl(*p++);
-	return p;
+	__be32 *p;
+
+	p = xdr_inline_decode(xdr, sizeof(__be32) * 2);
+	if (!p)
+		return XDR_DECODE_FAILED;
+	timep->tv_sec = be32_to_cpup(p++);
+	timep->tv_nsec = be32_to_cpup(p);
+
+	return XDR_DECODE_DONE;
 }
 
 static enum xdr_decode_result
@@ -151,6 +157,122 @@ svcxdr_decode_diropargs3(struct xdr_stream *xdr, struct svc_fh *fhp,
 	return svcxdr_decode_filename3(xdr, name, len);
 }
 
+static enum xdr_decode_result
+svcxdr_decode_sattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+		     struct iattr *iap)
+{
+	u32 set_it;
+	__be32 *p;
+
+	iap->ia_valid = 0;
+
+	p = xdr_inline_decode(xdr, sizeof(__be32));
+	if (!p)
+		return XDR_DECODE_FAILED;
+	if (xdr_item_is_present(p)) {
+		u32 mode;
+
+		if (xdr_stream_decode_u32(xdr, &mode) < 0)
+			return XDR_DECODE_FAILED;
+		iap->ia_valid |= ATTR_MODE;
+		iap->ia_mode = mode;
+	}
+
+	p = xdr_inline_decode(xdr, sizeof(__be32));
+	if (!p)
+		return XDR_DECODE_FAILED;
+	if (xdr_item_is_present(p)) {
+		u32 uid;
+
+		if (xdr_stream_decode_u32(xdr, &uid) < 0)
+			return XDR_DECODE_FAILED;
+		iap->ia_uid = make_kuid(nfsd_user_namespace(rqstp), uid);
+		if (uid_valid(iap->ia_uid))
+			iap->ia_valid |= ATTR_UID;
+	}
+
+	p = xdr_inline_decode(xdr, sizeof(__be32));
+	if (!p)
+		return XDR_DECODE_FAILED;
+	if (xdr_item_is_present(p)) {
+		u32 gid;
+
+		if (xdr_stream_decode_u32(xdr, &gid) < 0)
+			return XDR_DECODE_FAILED;
+		iap->ia_gid = make_kgid(nfsd_user_namespace(rqstp), gid);
+		if (gid_valid(iap->ia_gid))
+			iap->ia_valid |= ATTR_GID;
+	}
+
+	p = xdr_inline_decode(xdr, sizeof(__be32));
+	if (!p)
+		return XDR_DECODE_FAILED;
+	if (xdr_item_is_present(p)) {
+		u64 newsize;
+
+		if (xdr_stream_decode_u64(xdr, &newsize) < 0)
+			return XDR_DECODE_FAILED;
+		iap->ia_valid |= ATTR_SIZE;
+		iap->ia_size = min_t(u64, newsize, NFS_OFFSET_MAX);
+	}
+
+	if (xdr_stream_decode_u32(xdr, &set_it) < 0)
+		return XDR_DECODE_FAILED;
+	switch (set_it) {
+	case DONT_CHANGE:
+		break;
+	case SET_TO_SERVER_TIME:
+		iap->ia_valid |= ATTR_ATIME;
+		break;
+	case SET_TO_CLIENT_TIME:
+		if (!svcxdr_decode_nfstime3(xdr, &iap->ia_atime))
+			return XDR_DECODE_FAILED;
+		iap->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
+		break;
+	default:
+		return XDR_DECODE_FAILED;
+	}
+
+	if (xdr_stream_decode_u32(xdr, &set_it) < 0)
+		return XDR_DECODE_FAILED;
+	switch (set_it) {
+	case DONT_CHANGE:
+		break;
+	case SET_TO_SERVER_TIME:
+		iap->ia_valid |= ATTR_MTIME;
+		break;
+	case SET_TO_CLIENT_TIME:
+		if (!svcxdr_decode_nfstime3(xdr, &iap->ia_mtime))
+			return XDR_DECODE_FAILED;
+		iap->ia_valid |= ATTR_MTIME | ATTR_MTIME_SET;
+		break;
+	default:
+		return XDR_DECODE_FAILED;
+	}
+
+	return XDR_DECODE_DONE;
+}
+
+static enum xdr_decode_result
+svcxdr_decode_sattrguard3(struct xdr_stream *xdr, struct nfsd3_sattrargs *args)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(xdr, sizeof(__be32));
+	if (!p)
+		return XDR_DECODE_FAILED;
+	if (xdr_item_is_present(p)) {
+		p = xdr_inline_decode(xdr, sizeof(__be32) * 2);
+		if (!p)
+			return XDR_DECODE_FAILED;
+		args->check_guard = 1;
+		args->guardtime = be32_to_cpup(p);
+	} else
+		args->check_guard = 0;
+
+	return XDR_DECODE_DONE;
+}
+
 static __be32 *
 decode_sattr3(__be32 *p, struct iattr *iap, struct user_namespace *userns)
 {
@@ -372,20 +494,14 @@ nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_sattrargs *args = rqstp->rq_argp;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-	p = decode_sattr3(p, &args->attrs, nfsd_user_namespace(rqstp));
-
-	if ((args->check_guard = ntohl(*p++)) != 0) { 
-		struct timespec64 time;
-		p = decode_time3(p, &time);
-		args->guardtime = time.tv_sec;
-	}
-
-	return xdr_argsize_check(rqstp, p);
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return XDR_DECODE_FAILED;
+	if (!svcxdr_decode_sattr3(rqstp, xdr, &args->attrs))
+		return XDR_DECODE_FAILED;
+	return svcxdr_decode_sattrguard3(xdr, args);
 }
 
 int
diff --git a/include/uapi/linux/nfs3.h b/include/uapi/linux/nfs3.h
index 37e4b34e6b43..c22ab77713bd 100644
--- a/include/uapi/linux/nfs3.h
+++ b/include/uapi/linux/nfs3.h
@@ -63,6 +63,12 @@ enum nfs3_ftype {
 	NF3BAD  = 8
 };
 
+enum nfs3_time_how {
+	DONT_CHANGE		= 0,
+	SET_TO_SERVER_TIME	= 1,
+	SET_TO_CLIENT_TIME	= 2,
+};
+
 struct nfs3_fh {
 	unsigned short size;
 	unsigned char  data[NFS3_FHSIZE];


