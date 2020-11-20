Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94482BB735
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbgKTUf5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731165AbgKTUf5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:35:57 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6CBC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:56 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id n132so10240552qke.1
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BKz2uoAeik9FYygQlJXv8WpiY102Wc09x2r6FKBfoHs=;
        b=TQDvz5Pg6JxhG5YRoQiFh1c3Yq9fy5531AsTRqoKDt7SzoZ2nlHo382gZZ57UbBu3g
         gcobCGBe1rkcW+gzlZdIQmOn7aFtPudzd+7/H0rTyUAe6ONoyhtNPCN+e1O+0vhFqiA4
         Gb5hbv3YU3uVZJUPF+rJDrIQodaTIfWWfDkavYAhMkg2CVP0ZNCn7VINLwgmwMnTxC+z
         g+v8258M+Gh4axezZA2a7Cv/6MuxmvpdmWXNouoWcxy/objB6C60aIrzzRBMAn2woo37
         8wy0cHlSsihkhguPtEVxzeS3qj59IaO3KAO/Kn1F3j8ZnpIscB5UlaUobZD4bQJnpraI
         o/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=BKz2uoAeik9FYygQlJXv8WpiY102Wc09x2r6FKBfoHs=;
        b=taIVBDynT/AoUhcrOgewSWGOHMwaHyl9yoU2oAuQh6+1dNDF2AHafd1C8TuvPCJGnm
         zvtdfdbNwVCKaa0PyYdM9npVHZY5FGv3tomTcfH6liQyx7H8ACLUgqbQRKz6mdu6d6AT
         no1BwSuWAYzDhNZSkA4u2CSo+//wiWrA1tCctfvRsv8ha0FTnk/tiNpT6b80T5vjNDxC
         EdUZsmZoRtdpYYqJ9l5G1iCtUQWFJWPJwULJjliQqTDocEScmNnBvnxwI8PGFfdeWhgD
         0I3d7hFXPNxj41WH7eJh9TsPkn6Ts4FTL27lbqQuHuYBga0rsD+YADTUrqY/X98ja1sc
         zGqw==
X-Gm-Message-State: AOAM533bI+TZwSK8lKNYwr+puDqVhjS0TVPxCKTKHPuQC784UbnM4nU9
        bxsUc+FHgQ8qkB9wVOnfDbQd8BOkj5M=
X-Google-Smtp-Source: ABdhPJy/JYBR4/v1CQJyOPtlAk+SQqa+WX5i2RfQxQcqfv68UyaPDQovD0srhbQFlm2RwS2cct+Bwg==
X-Received: by 2002:a37:9ec4:: with SMTP id h187mr18046994qke.154.1605904555782;
        Fri, 20 Nov 2020 12:35:55 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 7sm2835532qko.106.2020.11.20.12.35.54
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:35:55 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKZsch029274
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:35:54 GMT
Subject: [PATCH v2 024/118] NFSD: Add helpers to decode a clientid4 and an
 NFSv4 state owner
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:35:54 -0500
Message-ID: <160590455400.1340.7050724078445373205.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These helpers will also be used to simplify decoders in subsequent
patches.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ec2cad8477e0..a7c9a0368951 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -541,6 +541,30 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_clientid4(struct nfsd4_compoundargs *argp, clientid_t *clientid)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, sizeof(__be64));
+	if (!p)
+		return nfserr_bad_xdr;
+	memcpy(clientid, p, sizeof(*clientid));
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_decode_state_owner4(struct nfsd4_compoundargs *argp,
+			  clientid_t *clientid, struct xdr_netobj *owner)
+{
+	__be32 status;
+
+	status = nfsd4_decode_clientid4(argp, clientid);
+	if (status)
+		return status;
+	return nfsd4_decode_opaque(argp, owner);
+}
+
 static __be32
 nfsd4_decode_stateid4(struct nfsd4_compoundargs *argp, stateid_t *sid)
 {
@@ -779,12 +803,12 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 		status = nfsd4_decode_stateid4(argp, &lock->lk_new_open_stateid);
 		if (status)
 			return status;
-		READ_BUF(8 + sizeof(clientid_t));
+		READ_BUF(4);
 		lock->lk_new_lock_seqid = be32_to_cpup(p++);
-		COPYMEM(&lock->lk_new_clientid, sizeof(clientid_t));
-		lock->lk_new_owner.len = be32_to_cpup(p++);
-		READ_BUF(lock->lk_new_owner.len);
-		READMEM(lock->lk_new_owner.data, lock->lk_new_owner.len);
+		status = nfsd4_decode_state_owner4(argp, &lock->lk_new_clientid,
+						   &lock->lk_new_owner);
+		if (status)
+			return status;
 	} else {
 		status = nfsd4_decode_stateid4(argp, &lock->lk_old_lock_stateid);
 		if (status)


