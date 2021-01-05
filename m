Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDB42EAE5E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbhAEPbY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbhAEPbX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:31:23 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5759AC061793
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:31:08 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id p12so14792068qvj.13
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jCiRhMsV6l4X31uQ1X1AFI8v6fZQhcwaKsC66Yho4ys=;
        b=MBHlU1FIhlRWDfPjelnA7aXaE77OlizxFWINsSaJquhmwc0cuhqewOHuV6YdLSVhCo
         ElKnvnQCbwfFogha5we8Eml1GIg6GxVMi0p8PLzfBg+TH7MaCEO1cIijmuBvz0e0gQJv
         pEb9qo+4USI4MkyO7wAmXIwOvMvSTosAqPdr1Otd7m0J7Hlu7ibvpsXixqh+zfMq1MfJ
         +yEObBUaXJ/tQLagquwX4f7/7OthyhHv29oXznYfqgc9hrSPPiN9B5h0fcfd1GR0ay1c
         BqSMVc2TN4LuftCpRWBfDUhoBpsWXXdwDUZf1x2FM3p68vlSgannO38EkZzpO99xaAKh
         hw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jCiRhMsV6l4X31uQ1X1AFI8v6fZQhcwaKsC66Yho4ys=;
        b=IT0Rv3Zf7vmJDMjFq0u1RSN+SMY8NKmOuxCS4RR1xqUn5ahDhaOrDrJdvZ4ysou2Qh
         TbnPgvOxChZAmqmdtsZEFfZaiNVKPCDqfRlEaJ0RKdKC/dllKijbSqhM6W0hlLnJmbXm
         t9Dd51QdBYWtEXoKDzFopcrx8/nzESA1AwjOZqls04m7cWYyBl0tsp3PrmQVxLSaZ7CX
         swVZV/eMrXp+RGbVr7BxaZFSkGJ6JCYt75tbbT/u5tHfsqSViWUSp99/Td83C48J0CFy
         v4VVBfVpFnJZwD0ke9cHRESfg35w9jsMlzmZU9f+yLnHpsiqRgkn33I9LoFQ06FI1Zuz
         heCA==
X-Gm-Message-State: AOAM532yBzv3XNNF0jsz2XqtVN8y1BHNfC8ih3HtNcEYYmilooMLcPRI
        bbYSs1g9NgMNqJi55RCAN/+u4JkTat8=
X-Google-Smtp-Source: ABdhPJzalMpho+npmPje33CvKELEK/b5Fp1mO/hcbfg8aAAsEoiDQZZ3fMhVNHhauM7x2xG3BGps9w==
X-Received: by 2002:a05:6214:80d:: with SMTP id df13mr83027920qvb.10.1609860667108;
        Tue, 05 Jan 2021 07:31:07 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p13sm144982qkg.80.2021.01.05.07.31.05
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:31:06 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FV5Rp020868
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:31:05 GMT
Subject: [PATCH v1 16/42] NFSD: Update the SETATTR3args decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:31:05 -0500
Message-ID: <160986066509.5532.6754187221390664193.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c         |  138 +++++++++++++++++++++++++++++++++++++++------
 include/uapi/linux/nfs3.h |    6 ++
 2 files changed, 127 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index ba5ec9cdafa1..ef536fb00728 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -39,12 +39,18 @@ encode_time3(__be32 *p, struct timespec64 *time)
 	return p;
 }
 
-static __be32 *
-decode_time3(__be32 *p, struct timespec64 *time)
+static bool
+svcxdr_decode_nfstime3(struct xdr_stream *xdr, struct timespec64 *timep)
 {
-	time->tv_sec = ntohl(*p++);
-	time->tv_nsec = ntohl(*p++);
-	return p;
+	__be32 *p;
+
+	p = xdr_inline_decode(xdr, XDR_UNIT * 2);
+	if (!p)
+		return false;
+	timep->tv_sec = be32_to_cpup(p++);
+	timep->tv_nsec = be32_to_cpup(p);
+
+	return true;
 }
 
 static bool
@@ -150,6 +156,112 @@ svcxdr_decode_diropargs3(struct xdr_stream *xdr, struct svc_fh *fhp,
 		svcxdr_decode_filename3(xdr, name, len);
 }
 
+static bool
+svcxdr_decode_sattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+		     struct iattr *iap)
+{
+	u32 set_it;
+
+	iap->ia_valid = 0;
+
+	if (xdr_stream_decode_bool(xdr, &set_it) < 0)
+		return false;
+	if (set_it) {
+		u32 mode;
+
+		if (xdr_stream_decode_u32(xdr, &mode) < 0)
+			return false;
+		iap->ia_valid |= ATTR_MODE;
+		iap->ia_mode = mode;
+	}
+	if (xdr_stream_decode_bool(xdr, &set_it) < 0)
+		return false;
+	if (set_it) {
+		u32 uid;
+
+		if (xdr_stream_decode_u32(xdr, &uid) < 0)
+			return false;
+		iap->ia_uid = make_kuid(nfsd_user_namespace(rqstp), uid);
+		if (uid_valid(iap->ia_uid))
+			iap->ia_valid |= ATTR_UID;
+	}
+	if (xdr_stream_decode_bool(xdr, &set_it) < 0)
+		return false;
+	if (set_it) {
+		u32 gid;
+
+		if (xdr_stream_decode_u32(xdr, &gid) < 0)
+			return false;
+		iap->ia_gid = make_kgid(nfsd_user_namespace(rqstp), gid);
+		if (gid_valid(iap->ia_gid))
+			iap->ia_valid |= ATTR_GID;
+	}
+	if (xdr_stream_decode_bool(xdr, &set_it) < 0)
+		return false;
+	if (set_it) {
+		u64 newsize;
+
+		if (xdr_stream_decode_u64(xdr, &newsize) < 0)
+			return false;
+		iap->ia_valid |= ATTR_SIZE;
+		iap->ia_size = min_t(u64, newsize, NFS_OFFSET_MAX);
+	}
+	if (xdr_stream_decode_u32(xdr, &set_it) < 0)
+		return false;
+	switch (set_it) {
+	case DONT_CHANGE:
+		break;
+	case SET_TO_SERVER_TIME:
+		iap->ia_valid |= ATTR_ATIME;
+		break;
+	case SET_TO_CLIENT_TIME:
+		if (!svcxdr_decode_nfstime3(xdr, &iap->ia_atime))
+			return false;
+		iap->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
+		break;
+	default:
+		return false;
+	}
+	if (xdr_stream_decode_u32(xdr, &set_it) < 0)
+		return false;
+	switch (set_it) {
+	case DONT_CHANGE:
+		break;
+	case SET_TO_SERVER_TIME:
+		iap->ia_valid |= ATTR_MTIME;
+		break;
+	case SET_TO_CLIENT_TIME:
+		if (!svcxdr_decode_nfstime3(xdr, &iap->ia_mtime))
+			return false;
+		iap->ia_valid |= ATTR_MTIME | ATTR_MTIME_SET;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static bool
+svcxdr_decode_sattrguard3(struct xdr_stream *xdr, struct nfsd3_sattrargs *args)
+{
+	__be32 *p;
+	u32 check;
+
+	if (xdr_stream_decode_bool(xdr, &check) < 0)
+		return false;
+	if (check) {
+		p = xdr_inline_decode(xdr, XDR_UNIT * 2);
+		if (!p)
+			return false;
+		args->check_guard = 1;
+		args->guardtime = be32_to_cpup(p);
+	} else
+		args->check_guard = 0;
+
+	return true;
+}
+
 static __be32 *
 decode_sattr3(__be32 *p, struct iattr *iap, struct user_namespace *userns)
 {
@@ -377,20 +489,12 @@ nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
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
+	return svcxdr_decode_nfs_fh3(xdr, &args->fh) &&
+		svcxdr_decode_sattr3(rqstp, xdr, &args->attrs) &&
+		svcxdr_decode_sattrguard3(xdr, args);
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


