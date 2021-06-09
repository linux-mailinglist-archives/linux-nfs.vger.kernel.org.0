Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD63A1E8E
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 23:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFIVJh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 17:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFIVJg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Jun 2021 17:09:36 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6083AC061574
        for <linux-nfs@vger.kernel.org>; Wed,  9 Jun 2021 14:07:32 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id d196so20050696qkg.12
        for <linux-nfs@vger.kernel.org>; Wed, 09 Jun 2021 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8pcsXAvTnoFwx+NGnD5Y4krAjafFp+EXD/903HVtObQ=;
        b=NeRH6p931FGHKsz8zK4XREOF0B1o4ALNvT8kQsxP53vPyAfd96DaZ41pRoqo2tG8QD
         6naT3SEcKk//GkY0IAz+TRXWCcseAsRjwiodWB78DfyAlEnPYp7hSHPo6utfdv4QdPLO
         TzZAJo3rpJJMvNPxTlKbLnKVQ8frmNV8thra04FioQuOtrhUBAThCewzLoBkI30iigXZ
         3jWHywXzZ0rn/2hVvWZXbwoE5T8bPFOmg31cEUQTd3RgC/0fNVocMbcJAV5XZdCR2/uN
         1GS49WfzByFZKyEWR0bUiA9tG+HY4ZLiAr0mnFkjPOfx1w6kC/7aq/f5dmu4itXfdezh
         oy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=8pcsXAvTnoFwx+NGnD5Y4krAjafFp+EXD/903HVtObQ=;
        b=nNKlyUnSWv1U3G/RIep3Z2fOEkmyX3t8taMyr3kyJSqrdXsJM5x6K8DnqLi15uJ/6+
         lQPi+Gv1ZS5faUtgz3OpJEqPQ1FEA4SUCh7XTZAFuGpPhNAGhYZEztneNxG36aYyf+yU
         eD0n0rOlSuA6zL7Q1uJBI2CrdNVBjimi9d9Ey89n7rgcqmBAozSGQ+qWG5Fomv6CrTZn
         gBHJBoo8w0Yrtl/EpXmlQ5WZuddMOolKvLLNye/R2m00yChKApqbkyWfhByoJXGUnenX
         aR5JusFFMnyl4fMCN1xQL+b+gpYa4GYxJ2tM3RwFqVidmRUXrVXdXfzBY4VQf6hM9QAL
         5kQQ==
X-Gm-Message-State: AOAM532yq9kV05b+LrDMRqR8si5kwaB5fLwkUGZsyB+XpzfmADL1unSY
        boe6gKjGJPpxDDpTcNO4TJzFvewY5no=
X-Google-Smtp-Source: ABdhPJwPlFUsL+OPCFqJV7/aKBwOOWld03TaorNIxioUvSeIK3E/ghLumPsLfq9P1r1nMr8aG19yEA==
X-Received: by 2002:a37:a47:: with SMTP id 68mr1593837qkk.432.1623272851454;
        Wed, 09 Jun 2021 14:07:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g19sm871449qto.49.2021.06.09.14.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 14:07:31 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH] sunrpc: Avoid a KASAN slab-out-of-bounds bug in xdr_set_page_base()
Date:   Wed,  9 Jun 2021 17:07:29 -0400
Message-Id: <20210609210729.254578-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This seems to happen fairly easily during READ_PLUS testing on NFS v4.2.
I found that we could end up accessing xdr->buf->pages[pgnr] with a pgnr
greater than the number of pages in the array. So let's just return
early if we're setting base to a point at the end of the page data and
let xdr_set_tail_base() handle setting up the buffer pointers instead.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/xdr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 3964ff74ee51..ca10ba2626f2 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1230,10 +1230,9 @@ static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
 	void *kaddr;
 
 	maxlen = xdr->buf->page_len;
-	if (base >= maxlen) {
-		base = maxlen;
-		maxlen = 0;
-	} else
+	if (base >= maxlen)
+		return 0;
+	else
 		maxlen -= base;
 	if (len > maxlen)
 		len = maxlen;
-- 
2.32.0

