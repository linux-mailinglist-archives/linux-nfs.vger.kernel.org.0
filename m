Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA2F15C0EB
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2020 16:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgBMPDv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Feb 2020 10:03:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46772 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbgBMPDv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Feb 2020 10:03:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id k29so3190454pfp.13;
        Thu, 13 Feb 2020 07:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G1URVlj7Itamof72U88sCTyKrE2tsgoZIU1g2MQTLT4=;
        b=eEunzPMSbxFG4bweZ0Ndj/87P833Ic9MFPnCSzj55NPcR0ymQ82wsiZqYSb1nk4y8n
         vnpDpP/RPoawFH2lKT+fH4LIqVcY3vw+XZ6VCFYWIxChO/zfnraDY1s+K2Vu8WxYmGaf
         p6kt/jZUcpj6P7ZpJdtxdBMtpgOT126Vr4mY5DboJ08lKnkcs7yEah2L6qRnLy2HAFmn
         pSdCkkgmCIlMOHbVYd62VqCTkmnmn1rTPlIW36YpxbBZMLjgQ2Wqpvfx1S8tGhno5wx4
         UsaeR6bH6DWuuSJJfZxvFgJ53tyZO1tbQs3rnpCGEKCKyJ36BSJBdlZtxA4O0oLBVawd
         /bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G1URVlj7Itamof72U88sCTyKrE2tsgoZIU1g2MQTLT4=;
        b=mqQ96r49+noN21pbjWWxswiEzHKtRJyhb0y7WXcriuIhDlDQjPGP7l8KXLnxqWsuX/
         hTG6nJpiHwTMPYFBrRtLzj8GfdLef+d2H4UzxqrSGQs9aa6jFb7RCIkPCmaVVsJEfVwc
         +V36GJRr55qvX7DXMKLpW6F5Pf0kVFO5wz1Yiu0nBKi0eI6gl76oeukixY3cN1z9RIor
         JUCOK7PcrHzXXJ01Rmkmk4Z9z/T744D5zV4U09xCNWpU1EAiIM5Hvb8cL6LGSSvNX2GU
         kgHVyIBU6bAIjOZW+jKECNLF2j5mrkNx16QDjYfteFK1kCh4dxOnWKzuOi4Ah5tTJfKb
         +uUA==
X-Gm-Message-State: APjAAAWOOzcYTNx/pSAG64x9PtcsrNUp9sV52Aa4dgD88Yg6LgztmmrL
        PoKZJbsvpJ1AQpnV1wGD/w==
X-Google-Smtp-Source: APXvYqy80BcDGxTwmn1WGkdzrAgompUbMy/tI6GtsozghL2Dy+wTbFwgE9Ja9AVRnkewKVx01aOEMQ==
X-Received: by 2002:a65:4c82:: with SMTP id m2mr17868613pgt.432.1581606229256;
        Thu, 13 Feb 2020 07:03:49 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee8:f65a:fc5b:5bfd:1ab4:4848])
        by smtp.gmail.com with ESMTPSA id 11sm3625726pfz.25.2020.02.13.07.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:03:48 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] fs: nfsd: nfs4state.c: Use built-in RCU list checking
Date:   Thu, 13 Feb 2020 20:33:31 +0530
Message-Id: <20200213150331.5727-1-madhuparnabhowmik10@gmail.com>
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
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 369e574c5092..3a80721fe53d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4295,7 +4295,8 @@ find_file_locked(struct knfsd_fh *fh, unsigned int hashval)
 {
 	struct nfs4_file *fp;
 
-	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash) {
+	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
+				lockdep_is_held(&state_lock)) {
 		if (fh_match(&fp->fi_fhandle, fh)) {
 			if (refcount_inc_not_zero(&fp->fi_ref))
 				return fp;
-- 
2.17.1

