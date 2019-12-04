Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C30A113638
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 21:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfLDUOB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 15:14:01 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33370 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfLDUOB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 15:14:01 -0500
Received: by mail-yw1-f68.google.com with SMTP id 192so265986ywy.0
        for <linux-nfs@vger.kernel.org>; Wed, 04 Dec 2019 12:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Mpgs98QEWEfBR0zDtL1zQxUobXF+5kk2R/iSUk7+KU=;
        b=CGHtzPh6vroJ7cYO9k+jY22pCngjZyw+owcv8idd7weey0DAsiKms0ahomBpEHZF6t
         jWzfBsl6c+JBDlX0wnbmUFoJEfTU3Ri4ZBGjuwdxajhnPLEU3mFWknN4JYVx0ow3jo71
         eNdiXq76slh3y5S9BTNrjp+t4oRRmBRojFQRV13b1koibkoDpaHtCdOf56erOMIL9iRc
         A2EO17QJowjZ/v12BJSVXGPrxlTvcXG5CBGNXgl5Z6tkUVS1U0VyAFYsJxEOxESXuQZh
         b8knRAEqIUmHTwh0k1JF23CWt+Nx3So0+SH7VSc/SizuFK+yMRaDSdixXaKNIn5K+64y
         v7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Mpgs98QEWEfBR0zDtL1zQxUobXF+5kk2R/iSUk7+KU=;
        b=dfuVexd8j43GBlOcEaTkyhb83c85DVzO4VfFd1RJoPtfA21irHIaVad9qVlkpP6ziV
         y732CQXgAqwErE2JIdehPoOPpRKCruWXbGU2JLa7tlDtQecBmgIsTlIPfk6lHWENR3HQ
         uyEOSG3TWNJHhsOhsc57Fa/yGnozU/puN3PQb7o+XsGU+vyGR//zVeMNzA/9amEc9kUC
         4aUW9rAfL9bi3ba9IZLDcw0hxAnkWDXtnTs2PNuFF+qg+ODP438LMGarhrpE8sZ0HyZ3
         EzQ7kbgqEV9dMVtXIs4X7grGInDiLd63pkpGtD8/m9lRTS/CoyyUs8n8NTf/figkwgp3
         /THg==
X-Gm-Message-State: APjAAAXE4Ah1XLsqSudFZyFTF9zLntTaXGOZnY0JDngYexreJtItCkzn
        IeyMtr4DDC+d+DUdY0XYFCs=
X-Google-Smtp-Source: APXvYqyV3MkUNNW8/IeN6rW6CfIdqiRYjtpS26Fuf3NvJ/QUfCApeAsz9+8lFCfx2/Ls1I5sYt77Jw==
X-Received: by 2002:a81:18c5:: with SMTP id 188mr3275228ywy.258.1575490440107;
        Wed, 04 Dec 2019 12:14:00 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id o69sm3496446ywd.38.2019.12.04.12.13.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 12:13:59 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSD fix nfserro errno mismatch
Date:   Wed,  4 Dec 2019 15:13:53 -0500
Message-Id: <20191204201354.17557-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191204201354.17557-1-olga.kornievskaia@gmail.com>
References: <20191204201354.17557-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There is mismatch between __be32 and u32 in nfserr and errno.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: d5e54eeb0e3d ("NFSD add nfs4 inter ssc to nfsd4_copy")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4proc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ec4f79c8..187cef6 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1169,7 +1169,8 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
 	size_t tmp_addrlen, match_netid_len = 3;
 	char *startsep = "", *endsep = "", *match_netid = "tcp";
 	char *ipaddr, *dev_name, *raw_data;
-	int len, raw_len, status = -EINVAL;
+	int len, raw_len;
+	__be32 status = nfserr_inval;
 
 	naddr = &nss->u.nl4_addr;
 	tmp_addrlen = rpc_uaddr2sockaddr(SVC_NET(rqstp), naddr->addr,
@@ -1207,7 +1208,7 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
 
 	snprintf(raw_data, raw_len, NFSD42_INTERSSC_MOUNTOPS, ipaddr);
 
-	status = -ENODEV;
+	status = nfserr_nodev;
 	type = get_fs_type("nfs");
 	if (!type)
 		goto out_free_rawdata;
@@ -1253,8 +1254,6 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
  * Called with COPY cstate:
  *    SAVED_FH: source filehandle
  *    CURRENT_FH: destination filehandle
- *
- * Returns errno (not nfserrxxx)
  */
 static __be32
 nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
@@ -1263,7 +1262,7 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
 {
 	struct svc_fh *s_fh = NULL;
 	stateid_t *s_stid = &copy->cp_src_stateid;
-	__be32 status = -EINVAL;
+	__be32 status = nfserr_inval;
 
 	/* Verify the destination stateid and set dst struct file*/
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
@@ -1280,7 +1279,7 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
 
 	copy->c_fh.size = s_fh->fh_handle.fh_size;
 	memcpy(copy->c_fh.data, &s_fh->fh_handle.fh_base, copy->c_fh.size);
-	copy->stateid.seqid = s_stid->si_generation;
+	copy->stateid.seqid = cpu_to_be32(s_stid->si_generation);
 	memcpy(copy->stateid.other, (void *)&s_stid->si_opaque,
 	       sizeof(stateid_opaque_t));
 
@@ -1308,7 +1307,7 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
 		      struct vfsmount **mount)
 {
 	*mount = NULL;
-	return -EINVAL;
+	return nfserr_inval;
 }
 
 static void
-- 
1.8.3.1

