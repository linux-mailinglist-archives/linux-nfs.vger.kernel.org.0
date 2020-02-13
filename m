Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF97915C0F0
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2020 16:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgBMPE2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Feb 2020 10:04:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43492 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMPE2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Feb 2020 10:04:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id u12so2883820pgb.10;
        Thu, 13 Feb 2020 07:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=209hGhsnE9x9qKc202eXW57WdD7JIQizlKdhyY0UjA0=;
        b=ODlproShyC/M6a05PXd19rSQLHcql1H8dRTbm7J0GTaEZCymOQUbRoJ+Q93B5D9I46
         VcnA07psfzQ2oIeynABvdyTZ55/RIsM8yI0PRrhfwc2BZl62TWjzRF1kl68EEmUNLm9N
         QjuV43txho0gIpSpq5I7AwyG+CIcv34DrhEHnp+aVtJom4aKkejku1ZLUzjb3/zBZH1q
         Ua3H8EW0aID9Xj2bM3fw2Tj56hI9+QFvJQcFbFnweNzNSgmun5cyzPzGF0fVDICPdNB8
         L0pmEbxHAf4GTxgKUpjrO0ZWltm6y0AyuQgpUlLBP6IS2y3H5JQN1vQVZ9xq640orEuT
         uzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=209hGhsnE9x9qKc202eXW57WdD7JIQizlKdhyY0UjA0=;
        b=tQ4bSitJuc1CpmXkzOQb+slwgNt/Tz+rxIslTsfcwiCn9+WLPbFZH3RF0Y6CIDQgaq
         8/WgdQxRcWYM4U7LFhSoPA1NAcmhrxbtVCKHaZjkuZgn19xYHc8y5wg8lNKz5R8wgh+z
         O2psLXMSTAjaE2VbaV/pWHFDhkPxJPZCSC4+HELUgM6RcYs0VE/VQArJtotpNcxt6vlD
         EzEJUdGmKy/4vygO6joOtMOnMd0O2nvnXFiUEWBUBiQTBMPBywwWOgYXz1c+0JekhI5q
         M2GZMr761ynxHV0o8Ymho91OrVVnM8Ro3aGToICUOQpHLGnpv34n1ADJD2+RUUNLS26K
         xskg==
X-Gm-Message-State: APjAAAU7/PBKOdIQRYl1R5Of3InUcdkvAgjJ5KFBsM4LavLUojfFlqQi
        LwlKvFL1QaT7HekM2gj95A==
X-Google-Smtp-Source: APXvYqwrUANlCfD4RfrLjtwgDFGOeXuOddD/S75LdBV2kR+2vCHyqnPjHTSiSZfwItNX0LglISdObg==
X-Received: by 2002:a62:c541:: with SMTP id j62mr14599798pfg.237.1581606267342;
        Thu, 13 Feb 2020 07:04:27 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee8:f65a:fc5b:5bfd:1ab4:4848])
        by smtp.gmail.com with ESMTPSA id x28sm3516038pgc.83.2020.02.13.07.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:04:26 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] fs: nfsd: fileache.c: Use built-in RCU list checking
Date:   Thu, 13 Feb 2020 20:33:59 +0530
Message-Id: <20200213150359.5819-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

list_for_each_entry_rcu() has built-in RCU and lock checking.

Pass cond argument to list_for_each_entry_rcu() to silence
false lockdep warning when  CONFIG_PROVE_RCU_LIST is enabled
by default.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 fs/nfsd/filecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 32a9bf22ac08..547d2d8bde62 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -736,7 +736,7 @@ nfsd_file_find_locked(struct inode *inode, unsigned int may_flags,
 	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
 
 	hlist_for_each_entry_rcu(nf, &nfsd_file_hashtbl[hashval].nfb_head,
-				 nf_node) {
+				 nf_node, lockdep_is_held(&nfsd_file_hashtbl[hashval].nfb_lock)) {
 		if ((need & nf->nf_may) != need)
 			continue;
 		if (nf->nf_inode != inode)
-- 
2.17.1

