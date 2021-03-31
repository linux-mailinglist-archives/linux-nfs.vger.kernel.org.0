Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC6235075C
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 21:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbhCaT2p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 15:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbhCaT2X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 15:28:23 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CF1C061574
        for <linux-nfs@vger.kernel.org>; Wed, 31 Mar 2021 12:28:23 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d10so36437ils.5
        for <linux-nfs@vger.kernel.org>; Wed, 31 Mar 2021 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bYhqA4Rpac22OeFaCAwacmBq5N6OnV4IyawprAXx9B0=;
        b=t2gFYReGkOxf4HQfVk+uRHX1moV0KxbYA8LOk52AMBOWQ1ZdsIklKdRIzUc7TbOKjl
         7ty8jAGCo8VpSIyIWIuOpVY3WWhbVWSGYvaDxEiFcyGYUaIt0ukRvWChCNAQJMyF/pv6
         lr7Ut4dnQhssvLKbWHW+Fv2EP+jWvncbDSzw4FCq4YKWkFJaBOkQ++embkbFhUA4LLEA
         iTJlE2sffh070rZ1ffnHyrEborNrUtiE/xkjIry4j4w7Fvxeyz0qS06RkG10ZTvOu8Sf
         02c+tFsb/pd5TlwHc59QfbDMJMPrAlDvrMFsT03LBj1tjIQzl3ro6KL8qRXMeKxaOO6i
         jMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bYhqA4Rpac22OeFaCAwacmBq5N6OnV4IyawprAXx9B0=;
        b=sMR9emExjqt6vZjhkO9gPoWYK1uBiFNysUXg3/DanxBwcvbCUU7ANSohV3oaFVlyjr
         hBEMLPxDpK8oy93+TXg6OB3hWbjmROlTLHOyHVUHUDAGwSCX/5niGltgBN/1YzzfyMr2
         FABmpgJVkLcTI+rUtI9wLhDN9SSEZEcJPnuy4qeNFsOHRIZS5vn1f2ZMeoT1m61FxtjV
         ia7j1vIAyiKBTOzgX1bV8QP4N056CPY2r89li+ulbciGicHZU1vIS4hyEeRpRAmCzMfm
         B+Yl31vAmUORsAORiAjxEssQt/EZramC/dZGIMEkzrXPQnI5DNzbWiZZ/L2Sj6OSbOPg
         KEww==
X-Gm-Message-State: AOAM530O6xtNOpuOeO7925P7rgbhEK3H1TMsAEl6uLvt5CQ6QlE7UG73
        4R3Dzj93mmJMcnAK2+gx691dx6v/0gA=
X-Google-Smtp-Source: ABdhPJzW+X/zCDdFmQE/Pnncmrx7zIqnOBZCDOLej8vgLbyyoPGi7oflqyC1y88ytvQxWUpGpGUTFw==
X-Received: by 2002:a05:6e02:929:: with SMTP id o9mr3616933ilt.16.1617218902387;
        Wed, 31 Mar 2021 12:28:22 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:8089:cd0c:2e85:ac75])
        by smtp.gmail.com with ESMTPSA id x20sm1422804ilc.88.2021.03.31.12.28.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Mar 2021 12:28:21 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within the last hole
Date:   Wed, 31 Mar 2021 15:28:19 -0400
Message-Id: <20210331192819.25637-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

According to the RFC 7862, "if the server cannot find a
corresponding sa_what, then the status will still be NFS4_OK,
but sr_eof would be TRUE". If there is a file that ends with
a hole and a SEEK request made for sa_what=SEEK_DATA with
an offset in the middle of the last hole, then the server
has to return OK and set the eof. Currently the linux server
returns ERR_NXIO.

Fixes: 24bab491220fa ("NFSD: Implement SEEK")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4proc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e13c4c81fb89..2e7ceb9f1d5d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1737,9 +1737,13 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 *        should ever file->f_pos.
 	 */
 	seek->seek_pos = vfs_llseek(nf->nf_file, seek->seek_offset, whence);
-	if (seek->seek_pos < 0)
-		status = nfserrno(seek->seek_pos);
-	else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
+	if (seek->seek_pos < 0) {
+		if (whence == SEEK_DATA &&
+		    seek->seek_offset < i_size_read(file_inode(nf->nf_file)))
+			seek->seek_eof = true;
+		else
+			status = nfserrno(seek->seek_pos);
+	} else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
 		seek->seek_eof = true;
 
 out:
-- 
2.18.2

