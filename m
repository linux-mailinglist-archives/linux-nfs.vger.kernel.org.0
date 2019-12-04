Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFC1113637
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 21:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfLDUOC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 15:14:02 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34839 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfLDUOC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 15:14:02 -0500
Received: by mail-yw1-f68.google.com with SMTP id i190so258504ywc.2
        for <linux-nfs@vger.kernel.org>; Wed, 04 Dec 2019 12:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mEvf+peCGVw75eQ2JbDVrUErRePsnis5N3Fg/DZCN7A=;
        b=O6wRL5TVgKQEYbF95MvAIDCu2s6OmxHTLzfKfvqi4ZrWeuKF/1Lqk1drczZFqADVLP
         kEPQxcHpB3mb8OzULlIW1557lpS7L2WRL++v+pPxCBGB/CgrdHBbZUWyjNYWZwERCTKd
         /9CcO3kfDZ4CeaKiDbwpqOIm/pqnRQU6mYILASWV5fu0hlBKsMV3pPt+ahchGfRmshFJ
         j9BC0JqeEDb2ZXiPPOIqlNqCrRL3cWdXywIsO+GrABztvXz3IJT7ne0s44tEyO9PfSfp
         uRlI74r/TKA2Fl6IoDvzGtGBqT+xkspMARSZ209L+OPBHLotHHxgYgIsfq6V20rcQub0
         /2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mEvf+peCGVw75eQ2JbDVrUErRePsnis5N3Fg/DZCN7A=;
        b=lp/DFHZfRnW7ECNg+nMd/TdQ9GsxzjANkDd7x/wderfU9zQhxkiNQ2qer/0dPmMoLy
         q9Qxbnv/V7CYwfF2DyddrcXqY+SRkY53dSWzUdEX7E2jUQV52tkfaThalUub1ocpL702
         z93Ec0mrziKSaSghxmtUD3oT9pcTbrkSe2HuyWqqQJ/WzUQa2Os5vGlJh4Znl+FUepFW
         fWfDKK9duccgduwui0jMR4tOEsYmUcMgRpGvabXeY/pjyhdslTwZgz15ZQzpMTfSkT97
         ZqbInXZZ7vWtsYSD/orWRCeGxtQwowjCX3D1mNSkd9qEAouekRsMq0VCsyu2jdfdZtvv
         7F/Q==
X-Gm-Message-State: APjAAAVUMoV+tXYhecwjbZ/4WyWBNXri1tgfKzbL7a/ZwojlRUUdT2h2
        gvjVDj/jjEIs3VZNUUu/2ykzGqqm
X-Google-Smtp-Source: APXvYqxQ0LhbD+ttdHVCwb2hOP9wSGAVSACZX+Z2/ZKWTLaAWvgE+ytUbiOFgD8cVszLIfkvLXHiGA==
X-Received: by 2002:a0d:d516:: with SMTP id x22mr3477924ywd.257.1575490441371;
        Wed, 04 Dec 2019 12:14:01 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id o69sm3496446ywd.38.2019.12.04.12.14.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 12:14:00 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSD fixing possible null pointer derefering in copy offload
Date:   Wed,  4 Dec 2019 15:13:54 -0500
Message-Id: <20191204201354.17557-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191204201354.17557-1-olga.kornievskaia@gmail.com>
References: <20191204201354.17557-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Static checker revealed possible error path leading to possible
NULL pointer dereferencing.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: e0639dc5805a: ("NFSD introduce async copy feature")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4proc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 187cef6..d33c39c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1446,7 +1446,8 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 {
 	nfs4_free_copy_state(copy);
 	nfsd_file_put(copy->nf_dst);
-	nfsd_file_put(copy->nf_src);
+	if (copy->cp_intra)
+		nfsd_file_put(copy->nf_src);
 	spin_lock(&copy->cp_clp->async_lock);
 	list_del(&copy->copies);
 	spin_unlock(&copy->cp_clp->async_lock);
@@ -1551,7 +1552,8 @@ static int nfsd4_do_async_copy(void *data)
 out:
 	return status;
 out_err:
-	cleanup_async_copy(async_copy);
+	if (async_copy)
+		cleanup_async_copy(async_copy);
 	status = nfserrno(-ENOMEM);
 	if (!copy->cp_intra)
 		nfsd4_interssc_disconnect(copy->ss_mnt);
-- 
1.8.3.1

