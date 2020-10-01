Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134FD280AB2
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 01:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733298AbgJAW76 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 18:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733266AbgJAW7t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:59:49 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEE4C0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 15:59:47 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g3so658251qtq.10
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZSEC38UchGGTLfwauGWF+LDN2hUA0ltwRMRprhIaqh4=;
        b=hdpd6wv4pR5sdZRXCQXSZVQVE/xxo/9nfq0v3DtMIY4P9n/+EP+zLbjR53Muj6wT1O
         +RgTh0H8WrmNq63BS7mPvy9NKQ+aGsBmsMjyKM2R7sUET3Bd8fXwIaduwz0unKLznhS7
         SL6LoJnNFkW3mid03uODI9srDwKcfX2KJfCgjaqw4wmVgJ8EBjiUIeeDFkYFsGOrIjTO
         +dnGy0bWYAqy0kdwO/7tYVneilgvoCPMsigMLxJtH0L4fWZFS0Iy8/lP5ZBGnd5Em59f
         GwNu1sTgAEXjDRSYBJzje0VHnnozKOES7NtEqCeQjUvzZeTFj/aRIPdP+DafobwHP76P
         eR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZSEC38UchGGTLfwauGWF+LDN2hUA0ltwRMRprhIaqh4=;
        b=iT+R+KdQQvya5G2xtnkETVCQvvyKy/qFCt6tb9miTvDgpd2ew+w+FpX5ssUD7f0siR
         wLFt+c/UmyyhV/PGMSZ82SpAtokDIiPLNc9/PF2x4pkV1RxdzZbb10VdXbKdRiKKGleK
         tRYgkuGiNIY5aN8Mb2Zck0edMoluqXNfgPLLN0/VkdS+S1hJUw83s0MTh17PjKabxT1Y
         Dg0X2MYQjQ8IYQewAJyrXgWk/ZxZ2t749N8EuYyGBFmLTFWHZ12ekYjXEkbqycWsh5rm
         joX8GFRWUBWRZv4AfLNj6hsDjp/OrZQ4+u3QM+/Uw5vakwvkrURAPlWe6275zo2a6zmM
         5Ypg==
X-Gm-Message-State: AOAM531qgD9QOM9eTajVdFdmSGw6ayPy04tZrlHqKvdlVujOjIcVmThE
        nw8gt16EjNhyWG09q3dueGjoPaglb5+Akg==
X-Google-Smtp-Source: ABdhPJwWjITSrSbLoUZzmNVWasW+Pttppyu4uwnFwcle4wI3T7N3bzBYvOEg08BewNk+A3Cn99U/5Q==
X-Received: by 2002:ac8:598f:: with SMTP id e15mr3314798qte.304.1601593186162;
        Thu, 01 Oct 2020 15:59:46 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k5sm7243466qkc.45.2020.10.01.15.59.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:59:45 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091MxiBI032595;
        Thu, 1 Oct 2020 22:59:44 GMT
Subject: [PATCH v3 11/15] NFSD: Fix .pc_release method for NFSv2
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 18:59:44 -0400
Message-ID: <160159318423.79253.18433109404164473395.stgit@klimt.1015granger.net>
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
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
index 2a4c4178acf1..c349e1dac3ff 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -611,7 +611,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_func = nfsd_proc_getattr,
 		.pc_decode = nfssvc_decode_fhandle,
 		.pc_encode = nfssvc_encode_attrstat,
-		.pc_release = nfssvc_release_fhandle,
+		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,
@@ -621,7 +621,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_func = nfsd_proc_setattr,
 		.pc_decode = nfssvc_decode_sattrargs,
 		.pc_encode = nfssvc_encode_attrstat,
-		.pc_release = nfssvc_release_fhandle,
+		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_sattrargs),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_REPLBUFF,
@@ -640,7 +640,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_func = nfsd_proc_lookup,
 		.pc_decode = nfssvc_decode_diropargs,
 		.pc_encode = nfssvc_encode_diropres,
-		.pc_release = nfssvc_release_fhandle,
+		.pc_release = nfssvc_release_diropres,
 		.pc_argsize = sizeof(struct nfsd_diropargs),
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_NOCACHE,
@@ -659,7 +659,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_func = nfsd_proc_read,
 		.pc_decode = nfssvc_decode_readargs,
 		.pc_encode = nfssvc_encode_readres,
-		.pc_release = nfssvc_release_fhandle,
+		.pc_release = nfssvc_release_readres,
 		.pc_argsize = sizeof(struct nfsd_readargs),
 		.pc_ressize = sizeof(struct nfsd_readres),
 		.pc_cachetype = RC_NOCACHE,
@@ -678,7 +678,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_func = nfsd_proc_write,
 		.pc_decode = nfssvc_decode_writeargs,
 		.pc_encode = nfssvc_encode_attrstat,
-		.pc_release = nfssvc_release_fhandle,
+		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_writeargs),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_REPLBUFF,
@@ -688,7 +688,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_func = nfsd_proc_create,
 		.pc_decode = nfssvc_decode_createargs,
 		.pc_encode = nfssvc_encode_diropres,
-		.pc_release = nfssvc_release_fhandle,
+		.pc_release = nfssvc_release_diropres,
 		.pc_argsize = sizeof(struct nfsd_createargs),
 		.pc_ressize = sizeof(struct nfsd_diropres),
 		.pc_cachetype = RC_REPLBUFF,
@@ -734,7 +734,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
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


