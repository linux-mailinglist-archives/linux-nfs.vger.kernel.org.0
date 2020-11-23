Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786B42C15A9
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgKWUGO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgKWUGN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:06:13 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7199EC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:13 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id t5so14378064qtp.2
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VeDTefz8milJ3+D/S6QPtfef+my+HTG4hC2pLPcIbw8=;
        b=O7b8SDmBmXcSdF4cxFBv9UhzwMFe9H4cVDC+ja+DbGM5moOM83Fmf+zZBLs6aWsNRA
         CqK+8KkjSrgsthhNs+mIHlu8upTvNkJrrg2BGG8hSbg4RYY3eC6URmbliixfxizOTxOC
         0sDBvvCqXGA5ttHCsgI1CsuePkMNwfeV9kRC8+CW6hvUv3bwbYdqCUgUSmR76yE1CK19
         VCxRph6REPL9rt2fXv8le3d1K2GZLSXgH2FFFQblr4byy0cqGwbSoYpS5s8ONaZybOq+
         eVIT/lA5NTeI8xM4FGwod9Y3/afzPbx8l3T5KDZKTBhtkjSDyai9cwArCBI/vqiUKtlL
         JHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=VeDTefz8milJ3+D/S6QPtfef+my+HTG4hC2pLPcIbw8=;
        b=PICv0qcdeRjH2hE946S7PWmr/K4uE5IECTp4fqo870sIrxaO0pAf5w+8R7/veHQGPi
         hwZvZmuLaQCZHkBYpEZMGjz7/ESTzIuTXYGoirYgRUfWArPtrddKK1uusLcpOyutOeFz
         /IChEfkJSIIrvjmblTGYtQyMrtkd3c59iIatzWbK09w/QkczNg5VtTAGIdPM7Z14+kxT
         pjb/KMoCdiTpKwJcTQrillxA3XBFuDIXpFqQnkncpOxlfmFK954gyG2NMtn5X04IbWLs
         u1IsYvhh5cBCNAn0mQ3qzgnuj3VJziyV9lxj0NJ8SlmnJWvLCS6LrGoQxKvYj74v8514
         /gZg==
X-Gm-Message-State: AOAM530J7Ba4DidmfdRaD3nUXtOsxS9lt+q2FrKq0dmJbqXhHMRC7shO
        bXkbftEXtUShbCz6jdOc/s93d5kuxjY=
X-Google-Smtp-Source: ABdhPJyvBDm+zF0YyDGt0+8pbl+UqCQZ7JP6yzQrIMkRZWFF9uj+BbC3dtAUlLmLqIHBz1L1x2uDtw==
X-Received: by 2002:ac8:7604:: with SMTP id t4mr899649qtq.366.1606161972391;
        Mon, 23 Nov 2020 12:06:12 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t56sm9482233qth.27.2020.11.23.12.06.11
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:06:11 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK6Act010343
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:06:10 GMT
Subject: [PATCH v3 25/85] NFSD: Add helpers to decode a clientid4 and an NFSv4
 state owner
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:06:10 -0500
Message-ID: <160616197068.51996.12752805251670283872.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
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
index a8e0cf30b073..dec383225722 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -609,6 +609,30 @@ nfsd4_decode_stateid4(struct nfsd4_compoundargs *argp, stateid_t *sid)
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
 static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
 {
 	DECODE_HEAD;
@@ -832,12 +856,12 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 		status = nfsd4_decode_stateid(argp, &lock->lk_new_open_stateid);
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
 		status = nfsd4_decode_stateid(argp, &lock->lk_old_lock_stateid);
 		if (status)


