Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F23DD21F3
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 09:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbfJJHka (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 03:40:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45050 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733123AbfJJHk3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 03:40:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id u12so3098505pgb.11
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 00:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=5OVQOx3YFrsPZETZ/HkYq1TF0QoarhZBNLL46hJ3Uz4=;
        b=OMUtWmH9Wo96Vvsrtml3shykqDRuWJvlhmfrWcjKPh9oyo/PE3/i87rWB4W5zXyZ9F
         yWUYjTdsw3iJR/HEAjH5e1kFps/G1vRhf09nUu4R93Xr5Gd6Dz+7FyGaQ0nlCXNTuol/
         ik3hU1zMmf4FGQH9moMPye+zhgKUVvp1TmsDrfATrddCt9suRzl/g3JevHQWU1R7/OSo
         fUvXN3UO1EwqN08GS+/tBFpddJ89SvEWRF1/Uc8nGwpVUfi+O608IA8J5WLwVgu9DnUS
         aiRRR3Rdo8+e93Y3drMv75LT10eYitjuP9qIl76Xkdb/IDcqMaqpwELeREViII/WjoOx
         cLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=5OVQOx3YFrsPZETZ/HkYq1TF0QoarhZBNLL46hJ3Uz4=;
        b=Q+x0bysFwLwerm9u6Eok0BqGdnEAk7m/GiIxNYLUr4X1a4NY8ArO5X+gcKmWw1FmQJ
         CnuEQtObrDP3Q8yce70534KpazZ8PQvjtHPNbtab47yiveyqbBxm7hdUkXdJ97xK+fDm
         GvaMIsmSDKULARyTo6J1Hku5SUdAQTzBJqGNPNXK2gv6q+XCD5X33c/XWASpyoVnVwOq
         gwKCs7eAHPF1/bVSyN3qCaQ5EBwYubnG/E4J2te4gT3bPzV0srynPNVFE3vdHgo4szRM
         GxxsNCKHslL4f+8VXOqNuAyxif2r+dlUa9MWwHyvoc0uPOWPH+BDSzt/Zma/Fo+MwcmS
         Pfkg==
X-Gm-Message-State: APjAAAWKqlKImNoG5nuOkazd0SblzEvBllCa4BDDoAotZjIAEdGDFQm+
        qk2T4YD3nZQPRe6fGathsh428m2BZgs=
X-Google-Smtp-Source: APXvYqyLoeB/f44CdXBY15kJ+HwHTtWgv7MK7HZwY6uGHgnwMOguHdPX3IcdNhqGKHgdARJzsIKIBQ==
X-Received: by 2002:a17:90a:8048:: with SMTP id e8mr10053083pjw.0.1570693228783;
        Thu, 10 Oct 2019 00:40:28 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a21sm5639099pfi.0.2019.10.10.00.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 00:40:28 -0700 (PDT)
Date:   Thu, 10 Oct 2019 15:40:20 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@gmail.com>
Subject: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with OPEN
Message-ID: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit:
  [0e0cb35] NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE

xfstests generic/168 on v4.2 starts to fail because reflink call gets:
  +XFS_IOC_CLONE_RANGE: Resource temporarily unavailable

In tshark output, NFS4ERR_OLD_STATEID stands out when comparing with
good ones:

 5210   NFS 406 V4 Reply (Call In 5209) OPEN StateID: 0xadb5
 5211   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
 5212   NFS 250 V4 Reply (Call In 5211) GETATTR
 5213   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
 5214   NFS 250 V4 Reply (Call In 5213) GETATTR
 5216   NFS 422 V4 Call WRITE StateID: 0xa818 Offset: 851968 Len: 65536
 5218   NFS 266 V4 Reply (Call In 5216) WRITE
 5219   NFS 382 V4 Call OPEN DH: 0x8d44a6b1/
 5220   NFS 338 V4 Call CLOSE StateID: 0xadb5
 5222   NFS 406 V4 Reply (Call In 5219) OPEN StateID: 0xa342
 5223   NFS 250 V4 Reply (Call In 5220) CLOSE Status: NFS4ERR_OLD_STATEID
 5225   NFS 338 V4 Call CLOSE StateID: 0xa342
 5226   NFS 314 V4 Call GETATTR FH: 0x8d44a6b1
 5227   NFS 266 V4 Reply (Call In 5225) CLOSE
 5228   NFS 250 V4 Reply (Call In 5226) GETATTR

It's easy to reproduce. By printing some logs, found that we are making
CLOSE seqid larger then OPEN seqid when racing.

Fix this by not bumping seqid when it's equal to OPEN seqid. Also
put the whole changing process into seqlock read protection in case
really bad luck, and this is the same locking behavior with the
old deleted function.

Fixes: 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE")
Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 fs/nfs/nfs4proc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 11eafcf..6db5a09 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3334,12 +3334,13 @@ static void nfs4_sync_open_stateid(nfs4_stateid *dst,
 			break;
 		}
 		seqid_open = state->open_stateid.seqid;
-		if (read_seqretry(&state->seqlock, seq))
-			continue;
 
 		dst_seqid = be32_to_cpu(dst->seqid);
 		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) < 0)
 			dst->seqid = seqid_open;
+
+		if (read_seqretry(&state->seqlock, seq))
+			continue;
 		break;
 	}
 }
@@ -3367,14 +3368,16 @@ static bool nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
 			break;
 		}
 		seqid_open = state->open_stateid.seqid;
-		if (read_seqretry(&state->seqlock, seq))
-			continue;
 
 		dst_seqid = be32_to_cpu(dst->seqid);
-		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) >= 0)
+		if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) > 0)
 			dst->seqid = cpu_to_be32(dst_seqid + 1);
 		else
 			dst->seqid = seqid_open;
+
+		if (read_seqretry(&state->seqlock, seq))
+			continue;
+
 		ret = true;
 		break;
 	}
-- 
1.8.3.1

