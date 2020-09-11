Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8472663BD
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Sep 2020 18:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgIKQWb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Sep 2020 12:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgIKP2F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Sep 2020 11:28:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C13C06134C
        for <linux-nfs@vger.kernel.org>; Fri, 11 Sep 2020 07:22:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l126so7462769pfd.5
        for <linux-nfs@vger.kernel.org>; Fri, 11 Sep 2020 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VifusxB0z2FBdukbKoauPP3oFHy9njJc8lzss3NuhW0=;
        b=un9H8KCq3X42dAtcRlHU8IVGVKjfzD5DvYou0B/7IK0rRvVCaT7ILZvF6LBNnsdZ72
         2NRRfWSAVLj3qY6DGPceO5iSAn0v9Fe6OMgpCFJ7Kjtis3V+cjiMp6BEJLtVemUiWLYF
         atInnfn9xJton8d/HOv1iF4Qevh1TtYjqVECY1ZydIybkrSFtTZpuRr0JiVb1R7wiF6d
         T7XivX9kZQ7D+oDSsab7MiHCwIMQYg0fXo1p9Zr10ysa8JGx0lTIRgCm6vWC6n8y69+i
         +R1gCRr8trw6tx5wROl7ZeGoHSw3Jf/Wmw47FDS4S8eMnU1If4kEzodjZ40JAkK12mk8
         2BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VifusxB0z2FBdukbKoauPP3oFHy9njJc8lzss3NuhW0=;
        b=dStBmGBFFCRM/bhbSi/H21XxzAQ/MmSeNtcdbQqSBEln1LHEob20ygmfLBC5lYYPoC
         BAf1DRDlfYlYHqnHgZ/p7e69mbhx5xLTSMgYNcES4eJfeOyXjmqMYz8Bq9kyrAEwpEr/
         yGaa5a/RStNDJyPCox9/Sa4zKLa3u8AY2e0BLchcGlyFGVlxRma8mytcE1c8XyDByVAN
         mHnXmgKhkMMS/3/vJD3wOIQBFRjvji893xvRJnj+5X9g/EXIs9fjT1dVR8sSr52tcQCV
         rR9J+2cTwW1ix34UZVAaf1Iw+1Uxu95YiQ/ZTyKIg/95iqQ4IMXnmgfw8D0WW9QF/5uw
         XQdw==
X-Gm-Message-State: AOAM531R9E8P03TGv+KORdqCTcLRS7dCMytbEMYgZei0u3vzT3vQJ/Ck
        LijGyyVlV0mKvsW1JAgB1sGkBVswLc5g3Q==
X-Google-Smtp-Source: ABdhPJxNsIzE2OFYqcwbcR5Y3V3bWxdIjolIyIfLJKP+Ec5jTLuRkKmJtETI9sImmTwaY6JcZNvf+g==
X-Received: by 2002:a63:b47:: with SMTP id a7mr1829977pgl.57.1599834134407;
        Fri, 11 Sep 2020 07:22:14 -0700 (PDT)
Received: from localhost.localdomain ([192.146.154.242])
        by smtp.gmail.com with ESMTPSA id z23sm2015356pgv.57.2020.09.11.07.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 07:22:13 -0700 (PDT)
From:   Srikrishan Malik <srikrishanmalik@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Srikrishan Malik <srikrishanmalik@gmail.com>
Subject: [PATCH] nfsidmap:umich_ldap return success only if attributes are found in ldap resp.
Date:   Fri, 11 Sep 2020 07:22:02 -0700
Message-Id: <20200911142202.84696-1-srikrishanmalik@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Return ENOENT if the UID/GID attributes are not found in ldap response.

Signed-off-by: Srikrishan Malik <srikrishanmalik@gmail.com>
---
 support/nfsidmap/umich_ldap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/support/nfsidmap/umich_ldap.c b/support/nfsidmap/umich_ldap.c
index c475d379..1aa2af49 100644
--- a/support/nfsidmap/umich_ldap.c
+++ b/support/nfsidmap/umich_ldap.c
@@ -643,6 +643,7 @@ umich_name_to_ids(char *name, int idtype, uid_t *uid, gid_t *gid,
 				goto out_memfree;
 			}
 			*uid = tmp_uid;
+			err = 0;
 		} else if (strcasecmp(attr_res, ldap_map.NFSv4_gid_attr) == 0) {
 			tmp_g = strtoul(*idstr, (char **)NULL, 10);
 			tmp_gid = tmp_g;
@@ -656,6 +657,7 @@ umich_name_to_ids(char *name, int idtype, uid_t *uid, gid_t *gid,
 				goto out_memfree;
 			}
 			*gid = tmp_gid;
+			err = 0;
 		} else {
 			IDMAP_LOG(0, ("umich_name_to_ids: received attr "
 				"'%s' ???", attr_res));
@@ -667,7 +669,6 @@ umich_name_to_ids(char *name, int idtype, uid_t *uid, gid_t *gid,
 		ldap_value_free(idstr);
 	}
 
-	err = 0;
 out_memfree:
 	ber_free(ber, 0);
 out_unbind:
-- 
2.26.2

