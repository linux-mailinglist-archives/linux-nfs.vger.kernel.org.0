Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD40A11E543
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 15:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfLMOLC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 09:11:02 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:45377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfLMOLC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 09:11:02 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MAwPZ-1iYuxC2l69-00BMTf; Fri, 13 Dec 2019 15:10:55 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 02/12] nfsd: print 64-bit timestamps in client_info_show
Date:   Fri, 13 Dec 2019 15:10:36 +0100
Message-Id: <20191213141046.1770441-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213141046.1770441-1-arnd@arndb.de>
References: <20191213141046.1770441-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9SKRS2jmAK5+hO6gAt+vF42FOBN1KpKLDxwzePH1lowj6foByry
 CIqvaRNhyDSGJgY3FraE0vEHhTpHpKrfa5lHsX29Shlb19GnvHhdffNyJS9o65dK9xFXSJr
 VKgO8AZg+Kqw+0tZkdVajeAJdnfFut49Q4DZ37HCEbXLwKg+6rqPXt1x3sWo/ARw4hOVUmd
 faFRZtD73I0oGQl1pWE5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HeR70z0Cop8=:StWF7PVMsAoCw2qyISGuhu
 dNC8WNZENQ17lNI7XUyUGADy6d+lWRK155FM3ImDhMxQFl2nBjLZaz162IzL9C5BHKUDjw0/T
 rUKeBzoUb7w37fiK+9Sm74zlZUb6BZEQGrUha0fBw0DuIwvOrnyVcrfQSpfaleBw31MANU0pn
 q31FBoAyCfPDL3VLNgX1L9n2ERQEUtEFOUy4B2eaWoMPOtPChMM6rL5nrJ9pKKR8uq4/7xaaS
 Y8MZJ6f8xP3ZVvkVHlv1Obvoc8gzGGIH2NAlEkcCQigu4TCOcjl04VrcUYY9mgx6tzZ77oOf1
 xTLEw+Uq2f2r2woveSUrNj4rin5VeKQecXorR/RlsaPUI4bl6VDdu9dO2K/+Id5ysiMg0Q6+p
 2Goyo6sSRBYmz42XtoQEQeHdgZa+vQtmkX+lpDIW4hXMfsIM74RkoArDBZc27A90Vpmk9VlB8
 QyPec46dZyYO0jecL26YhuYIfr24WZIMwCm2Hjb2RdDtNqVqUuAhxgGqC4pK7IzyU/0rrbiNU
 rcFAA1nfLt8KSt3rllpNwcaMLkX4eu0hcr673dbNv1X5KUVeeHshvdxxD78G8ikyD3rEk7qI7
 eKgj+gbm1dDXQmCVAUy+75xpatHG5DGjd6nl/vcA8eIoesPToBAiM6WfP4lTTccKeZ5aSsVvp
 yI3P1RG9uKU332bbRHWfNgR6YOr8DD+N8p2Y+j+6V6HS4z8yES0d5oh/cfXJQ95762peAnpAe
 YLZqgjREekQECvmx1HBR+8BYfFf8gdFCBC5HX55pMG0efBAiFQ6u+qFiht8/ETmkoEF3GYkB4
 azWS5rk+p1lYbE33IxJxVgH4p/A9A8oOSiSmJA5mjJqW2kHaOEOS8n909p20y6/tArVaFkqDm
 +D+kjTJ0zwlmcGvnIzxg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nii_time field gets truncated to 'time_t' on 32-bit architectures
before printing.

Remove the use of 'struct timespec' to product the correct output
beyond 2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs4state.c | 5 ++---
 fs/nfsd/state.h     | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index bfdb3366239c..27a629cc5a46 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2292,7 +2292,7 @@ static int client_info_show(struct seq_file *m, void *v)
 					clp->cl_nii_domain.len);
 		seq_printf(m, "\nImplementation name: ");
 		seq_quote_mem(m, clp->cl_nii_name.data, clp->cl_nii_name.len);
-		seq_printf(m, "\nImplementation time: [%ld, %ld]\n",
+		seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
 			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
 	}
 	drop_client(clp);
@@ -2946,8 +2946,7 @@ static __be32 copy_impl_id(struct nfs4_client *clp,
 	xdr_netobj_dup(&clp->cl_nii_name, &exid->nii_name, GFP_KERNEL);
 	if (!clp->cl_nii_name.data)
 		return nfserr_jukebox;
-	clp->cl_nii_time.tv_sec = exid->nii_time.tv_sec;
-	clp->cl_nii_time.tv_nsec = exid->nii_time.tv_nsec;
+	clp->cl_nii_time = exid->nii_time;
 	return 0;
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index d61b83b9654c..2b4165cd1d3e 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -320,7 +320,7 @@ struct nfs4_client {
 	/* NFSv4.1 client implementation id: */
 	struct xdr_netobj	cl_nii_domain;
 	struct xdr_netobj	cl_nii_name;
-	struct timespec		cl_nii_time;
+	struct timespec64	cl_nii_time;
 
 	/* for v4.0 and v4.1 callbacks: */
 	struct nfs4_cb_conn	cl_cb_conn;
-- 
2.20.0

