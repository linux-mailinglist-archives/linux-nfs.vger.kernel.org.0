Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830AE2731B2
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIUSNP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgIUSNO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:13:14 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D08C061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:13:14 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t13so14678986ile.9
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YS1NROjvG3NyDp9ICcNQxY40HzJkoNZQ4eUMCa2lq14=;
        b=IG3al2I9mxWRGm9wyFQUiYFR6NZzP7axIj1pNa7Z0a0XqdQZ5d9ZZynPdrPkn86qDa
         iH00uRE5vfkG7kolDy37QhCawJElLfZq5XHEoOGa5u2AWeMexQcIunG8DEl5KIZ4GuEI
         ywZHYnoCB3Q63ASEVruJy+YHcg22esTa0hpf73LmXRcONvEWn3IAru6ITrTMbtKg4MKE
         SSvALiF3wLJ6dUCFvjxedcKEOl17SyfG0ZtoM8ahDTPotzcrukRRnQP7L2AqABddRXuk
         h1wjFSOLOlgyXtMVg0jKQFI1rH/xzvqZSCXyRMk7cf5PTyAD6e/3u78KmFQxBJSd+434
         wpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=YS1NROjvG3NyDp9ICcNQxY40HzJkoNZQ4eUMCa2lq14=;
        b=XLXx3/glogVRpBXZyViiMpMzTiiKkHY8YbufX/knNCelGZkb7OSTW/XpJBCR5NNO39
         AVP2PHG2b6F0v9WY4gxkuGlKXRLqrZw05IvpQSmT+qxUKLnR0Wmsco8i0Di/tddl21DK
         2XOaxSEdohj2TVAnAkw1hPLePoLl7e9oSLHxKqxikfw6gr1k3mGVEYTyuIjhZEzyimxD
         zJKHpu2GDuhD4Ufzp3qtIW57ftcSmLb9UX83tiif8cxGGVgtvalIpey+d8aVtrEGjexh
         2OkJtWNYzz6nHdm0EDlqquuMEgDIpozDToqeY1qthJMdGZbKKWPTQjyZfegxy9HzN14M
         OTQw==
X-Gm-Message-State: AOAM532/EWjpr6HLZJ4Q6mJA3aJN+EdpSBqIq3QI3/XFp7teX1PXwmz7
        POCtmk+n0Tio/7Vm9rZnE5U=
X-Google-Smtp-Source: ABdhPJzy7wW/Iax4IVXB03VkgpgorL54Fe9yYeSgWAGR1zCuXygKdrzcXBCbVpIxyfmrBl5ESdllYQ==
X-Received: by 2002:a92:874a:: with SMTP id d10mr1036864ilm.163.1600711994137;
        Mon, 21 Sep 2020 11:13:14 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g6sm6191929iop.24.2020.09.21.11.13.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:13:13 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LIDC1A003923;
        Mon, 21 Sep 2020 18:13:12 GMT
Subject: [PATCH v2 27/27] NFSD: Replace dprintk callsites in fs/nfsd/nfsfh.c
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:13:12 -0400
Message-ID: <160071199247.1468.8000355146555488764.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Report the input and result of fh_verify. The other dprintk
callsites are rather stale and so are removed.

nfsd-1025  [002]   256.807404: nfsd_fh_verify:       xid=0x12147d7a fh_hash=0x6085d6fb type=NONE access=WRITE|SATTR|OWNER_OVERRIDE status=0

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.c |   36 ++----------------------------------
 fs/nfsd/trace.h |   42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c81dbbad8792..dd2d26ddf3f4 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -16,9 +16,6 @@
 #include "auth.h"
 #include "trace.h"
 
-#define NFSDDBG_FACILITY		NFSDDBG_FH
-
-
 /*
  * our acceptability function.
  * if NOSUBTREECHECK, accept anything
@@ -48,8 +45,6 @@ static int nfsd_acceptable(void *expv, struct dentry *dentry)
 		dput(tdentry);
 		tdentry = parent;
 	}
-	if (tdentry != exp->ex_path.dentry)
-		dprintk("nfsd_acceptable failed at %p %pd\n", tdentry, tdentry);
 	rv = (tdentry == exp->ex_path.dentry);
 	dput(tdentry);
 	return rv;
@@ -104,12 +99,8 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 	int flags = nfsexp_flags(rqstp, exp);
 
 	/* Check if the request originated from a secure port. */
-	if (!nfsd_originating_port_ok(rqstp, flags)) {
-		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
-		dprintk("nfsd: request from insecure port %s!\n",
-		        svc_print_addr(rqstp, buf, sizeof(buf)));
+	if (!nfsd_originating_port_ok(rqstp, flags))
 		return nfserr_perm;
-	}
 
 	/* Set user creds for this exportpoint */
 	return nfserrno(nfsd_setuser(rqstp, exp));
@@ -331,8 +322,6 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	struct dentry	*dentry;
 	__be32		error;
 
-	dprintk("nfsd: fh_verify(%s)\n", SVCFH_fmt(fhp));
-
 	if (!fhp->fh_dentry) {
 		error = nfsd_set_fh_dentry(rqstp, fhp);
 		if (error)
@@ -391,16 +380,10 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 skip_pseudoflavor_check:
 	/* Finally, check access permissions. */
 	error = nfsd_permission(rqstp, exp, dentry, access);
-
-	if (error) {
-		dprintk("fh_verify: %pd2 permission failure, "
-			"acc=%x, error=%d\n",
-			dentry,
-			access, ntohl(error));
-	}
 out:
 	if (error == nfserr_stale)
 		nfsdstats.fh_stale++;
+	trace_nfsd_fh_verify(rqstp, fhp, type, access, error);
 	return error;
 }
 
@@ -547,12 +530,6 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 	struct inode * inode = d_inode(dentry);
 	dev_t ex_dev = exp_sb(exp)->s_dev;
 
-	dprintk("nfsd: fh_compose(exp %02x:%02x/%ld %pd2, ino=%ld)\n",
-		MAJOR(ex_dev), MINOR(ex_dev),
-		(long) d_inode(exp->ex_path.dentry)->i_ino,
-		dentry,
-		(inode ? inode->i_ino : 0));
-
 	/* Choose filehandle version and fsid type based on
 	 * the reference filehandle (if it is in the same export)
 	 * or the export options.
@@ -562,15 +539,6 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 	if (ref_fh == fhp)
 		fh_put(ref_fh);
 
-	if (fhp->fh_locked || fhp->fh_dentry) {
-		printk(KERN_ERR "fh_compose: fh %pd2 not initialized!\n",
-		       dentry);
-	}
-	if (fhp->fh_maxsize < NFS_FHSIZE)
-		printk(KERN_ERR "fh_compose: called with maxsize %d! %pd2\n",
-		       fhp->fh_maxsize,
-		       dentry);
-
 	fhp->fh_dentry = dget(dentry); /* our internal copy */
 	fhp->fh_export = exp_get(exp);
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 50ab4a84c25f..47d0fea70f34 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -181,6 +181,48 @@ TRACE_EVENT(nfsd_setattr_args,
 	)
 );
 
+TRACE_EVENT(nfsd_fh_verify,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp,
+		umode_t type,
+		int access,
+		__be32 status
+	),
+	TP_ARGS(rqstp, fhp, type, access, status),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, fh_hash)
+		__field(unsigned long, type)
+		__field(unsigned long, access)
+		__field(unsigned long, status)
+		__dynamic_array(unsigned char, name,
+				fhp->fh_dentry->d_name.len + 1)
+	),
+	TP_fast_assign(
+		const struct dentry *dentry = fhp->fh_dentry;
+
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->type = type & S_IFMT;
+		__entry->access = access;
+		__entry->status = be32_to_cpu(status);
+		if (dentry) {
+			memcpy(__get_str(name), dentry->d_name.name,
+			       dentry->d_name.len);
+			__get_str(name)[dentry->d_name.len] = '\0';
+		} else {
+			__get_str(name)[0] = '\0';
+		}
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x type=%s access=%s name=%s status=%s",
+		__entry->xid, __entry->fh_hash,
+		show_inode_type(__entry->type),
+		show_nfsd_may_flags(__entry->access),
+		__get_str(name), show_nfs4_status(__entry->status)
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_fh_err_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,


