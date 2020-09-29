Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF2F27D081
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Sep 2020 16:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbgI2OEd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Sep 2020 10:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgI2OEc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Sep 2020 10:04:32 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24A5C061755
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:32 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e5so2052575ils.10
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2jKSRTMxd06k1G9+9t6OYvlXy+Ku3xUPQeob4IfuY88=;
        b=pNeHIaqvOnET4wlRVTqqC6MIJHPjRMWIHwexdp35Y9QEH7sCLPfKIFs3qqs2Rk/EI/
         MZuZBaiv3cy1btUif0+2lZxxUlwb+dcEpB5F8oag3qyK4b5a0Ie5QZl8VQAv9nkjcYWn
         GULOD7+HlxxmYGB8lG04GBv41wecn4cJAqLmoCPAZgKOf2MnLC0vgIQlFRPGu4aj0gWd
         OsrJTbN02W4jx2WfhyXLk2uq1qkFW/Xww5i7+CwM6PXZvN8C/6I6gCAYygOhcQpEhqbX
         xj+t1COiPyXsXPYxMSW8tf/BF01NQwNuwsHSl4PgiiPQWFBoF27w9APFhyLwxhvlEqb0
         Ep0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2jKSRTMxd06k1G9+9t6OYvlXy+Ku3xUPQeob4IfuY88=;
        b=KjiWX+6d1O/Rth46/IeelpDerUInyOXWfcYylJyPUAW1CJEvozUP0cOG4Mr8uzZZ6b
         2HGPobdrwY3GEgCNKX9IvjwFPcN/3IweylW6EWy+KfHt8pbRri4SpXyUZ9roR4bx/QHM
         agdZhrExjkC6meBi2X3lnsc0fzAle+X+arrrX/+i6cXRNQZkl1MOFLXGBQzpNlpWRmtQ
         r3NGoAnX5T/6XhNDwNzVdY6kCTQv3fQ3FoK+50tM6uvLQ9/fN72qBAPM4D0kaWhsp8FX
         iAGjw/pGN4DPw9WaE5JBx9UaiydE+xbN0PX1xzp7YwWk2JSi9cHu1rimlmHBukW4X3qM
         ze2g==
X-Gm-Message-State: AOAM5339oazlxCo+MPq5+74v1N7IJ7D7a0hdHQ6TS0v2I2BkOVwhurmx
        XKseiqw6Itz1Vs3uia8r9W5/nAMWx3odpQ==
X-Google-Smtp-Source: ABdhPJyhx8MP9OF1KbLyODHXvaGpHbWJ8t3SYWII197nTDcePbt5fsrv8WGi0dJvUapei+42FdTouw==
X-Received: by 2002:a05:6e02:c74:: with SMTP id f20mr3096663ilj.57.1601388271980;
        Tue, 29 Sep 2020 07:04:31 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y10sm1799136ioy.25.2020.09.29.07.04.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:04:31 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08TE4Tq6026442;
        Tue, 29 Sep 2020 14:04:29 GMT
Subject: [PATCH v2 10/11] NFSD: Fix .pc_release method for NFSv2
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 29 Sep 2020 10:04:29 -0400
Message-ID: <160138826992.2558.5806906591247144060.stgit@klimt.1015granger.net>
In-Reply-To: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
References: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd_release_fhandle() assumes that rqstp->rq_resp always points to
an nfsd_fhandle struct. In fact, no NFSv2 procedure uses struct
nfsd_fhandle as its response structure.

So far that has been "safe" to do because the res structs put the
resp->fh field at that same offset as struct nfsd_fhandle. I don't
think that's a guarantee, though, and there is certainly nothing
preventing a developer from altering the fields in those structures.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |   14 +++++++-------
 fs/nfsd/nfsxdr.c  |   19 ++++++++++++++++---
 fs/nfsd/xdr.h     |    4 +++-
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6e0b066480c5..33204d83709c 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -600,7 +600,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_func = nfsd_proc_getattr,
 		.pc_decode = nfssvc_decode_fhandle,
 		.pc_encode = nfssvc_encode_attrstat,
-		.pc_release = nfssvc_release_fhandle,
+		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
@@ -610,7 +610,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_func = nfsd_proc_setattr,
 		.pc_decode = nfssvc_decode_sattrargs,
 		.pc_encode = nfssvc_encode_attrstat,
-		.pc_release = nfssvc_release_fhandle,
+		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_sattrargs),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_REPLBUFF,
@@ -628,7 +628,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_func = nfsd_proc_lookup,
 		.pc_decode = nfssvc_decode_diropargs,
 		.pc_encode = nfssvc_encode_diropres,
-		.pc_release = nfssvc_release_fhandle,
+		.pc_release = nfssvc_release_diropres,
 		.pc_argsize = sizeof(struct nfsd_diropargs),
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_NOCACHE,
@@ -647,7 +647,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_func = nfsd_proc_read,
 		.pc_decode = nfssvc_decode_readargs,
 		.pc_encode = nfssvc_encode_readres,
-		.pc_release = nfssvc_release_fhandle,
+		.pc_release = nfssvc_release_readres,
 		.pc_argsize = sizeof(struct nfsd_readargs),
 		.pc_ressize = sizeof(struct nfsd_readres),
 		.pc_cachetype = RC_NOCACHE,
@@ -665,7 +665,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_func = nfsd_proc_write,
 		.pc_decode = nfssvc_decode_writeargs,
 		.pc_encode = nfssvc_encode_attrstat,
-		.pc_release = nfssvc_release_fhandle,
+		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_writeargs),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_REPLBUFF,
@@ -675,7 +675,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_func = nfsd_proc_create,
 		.pc_decode = nfssvc_decode_createargs,
 		.pc_encode = nfssvc_encode_diropres,
-		.pc_release = nfssvc_release_fhandle,
+		.pc_release = nfssvc_release_diropres,
 		.pc_argsize = sizeof(struct nfsd_createargs),
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_REPLBUFF,
@@ -721,7 +721,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_func = nfsd_proc_mkdir,
 		.pc_decode = nfssvc_decode_createargs,
 		.pc_encode = nfssvc_encode_diropres,
-		.pc_release = nfssvc_release_fhandle,
+		.pc_release = nfssvc_release_diropres,
 		.pc_argsize = sizeof(struct nfsd_createargs),
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_REPLBUFF,
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index b51fe515f06f..39c004ec7d85 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -561,10 +561,23 @@ nfssvc_encode_entry(void *ccdv, const char *name,
 /*
  * XDR release functions
  */
-void
-nfssvc_release_fhandle(struct svc_rqst *rqstp)
+void nfssvc_release_attrstat(struct svc_rqst *rqstp)
 {
-	struct nfsd_fhandle *resp = rqstp->rq_resp;
+	struct nfsd_attrstat *resp = rqstp->rq_resp;
+
+	fh_put(&resp->fh);
+}
+
+void nfssvc_release_diropres(struct svc_rqst *rqstp)
+{
+	struct nfsd_diropres *resp = rqstp->rq_resp;
+
+	fh_put(&resp->fh);
+}
+
+void nfssvc_release_readres(struct svc_rqst *rqstp)
+{
+	struct nfsd_readres *resp = rqstp->rq_resp;
 
 	fh_put(&resp->fh);
 }
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index ea7cca3a64b7..3d3e16d48268 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -156,7 +156,9 @@ int nfssvc_encode_readdirres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_entry(void *, const char *name,
 			int namlen, loff_t offset, u64 ino, unsigned int);
 
-void nfssvc_release_fhandle(struct svc_rqst *);
+void nfssvc_release_attrstat(struct svc_rqst *rqstp);
+void nfssvc_release_diropres(struct svc_rqst *rqstp);
+void nfssvc_release_readres(struct svc_rqst *rqstp);
 
 /* Helper functions for NFSv2 ACL code */
 __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp, struct kstat *stat);


