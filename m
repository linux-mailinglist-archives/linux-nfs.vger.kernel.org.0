Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 983211211DC
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2019 18:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfLPRiH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Dec 2019 12:38:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41344 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfLPRiH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Dec 2019 12:38:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so8343193wrw.8;
        Mon, 16 Dec 2019 09:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=YvwLWoXK+n4PBW3H7wU0kExV6V4+NJ7KeyyLrWDeEGo=;
        b=CMxXZ1NtTTIx6YqNzhPhEugHnuxKG56T7KZImLeaVY633que16ESIFstZ5I5qOYHhL
         mJ7S7DANV3z2+N8aIcPkPIQB46EqTfDUL9ZXVXqMez4Ru7ocJDdqHz9GrjGF3izni233
         QgAUjsd7HbFMKooEmkVXlSt5/bVBHDfqzna1pD9H2EVB/XhFRRJcjH69ZuLYs99AbaAa
         1ue9SOV0Mp8dDSU2cPZP2B8PKt0jKPRktpKDvrNq1QuJKsNBajFlxYfzekAjDbr6M0YT
         RGF6cSZM0VWcXYij016AKa7TtCpqjW03VbTZs7TCx59aF+BZcdP+rMavzeZWolx6oXXG
         Prhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=YvwLWoXK+n4PBW3H7wU0kExV6V4+NJ7KeyyLrWDeEGo=;
        b=g47nUDj9YOO32CzDLyneYl6LmMJ/CHn2bwSuCfKMrLEn5lKvtE5T8OZT3NmPc/W23f
         36FcOYfdjuGZVE0gryy7MpNqfB2/8ZefhsVk/F1cGbdm+Pla2abKIO1N1JpHcJCHFfG2
         6w/UPG8LjINISsR104CPrsK2QQGfAmw4dv7/aLhuHX01zUrowPZbnR2VnhKUyKUhu6qF
         8BCFJ37pCHaqu4XDdgMG53yfJ6gYfIKFm42OGKgzXbTpD2sFTsgUYZAv+3Xu4RaibGWg
         6NoDmJzgyT2wj+Eaq6du4Fzk4PPhSp4k6xcNUW3iCz//OaI+X9tFPcH4Hix9dEDD3IW0
         Gvqw==
X-Gm-Message-State: APjAAAW4UYbTCuiqU+gsYkykhTpT6jHRat4wXhYw0jTQ9Qu//b0c4fCD
        6nvUR/QoaMBGhM1LW1rl/26Np6FRLdk=
X-Google-Smtp-Source: APXvYqyiSjvep2p8o7WWZtUnyRyUhcxLDzNoUHzUhtMm9Jj/4aJftF26uKd+u5BhlkfcXe7OHM7feg==
X-Received: by 2002:a5d:494f:: with SMTP id r15mr33137175wrs.143.1576517884942;
        Mon, 16 Dec 2019 09:38:04 -0800 (PST)
Received: from WINDOWSSS5SP16 (cpc96954-walt26-2-0-cust383.13-2.cable.virginm.net. [82.31.89.128])
        by smtp.gmail.com with ESMTPSA id v8sm22059274wrw.2.2019.12.16.09.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 09:38:04 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     <linux-nfs@vger.kernel.org>
Cc:     "'Trond Myklebust'" <trond.myklebust@hammerspace.com>,
        "'Anna Schumaker'" <anna.schumaker@netapp.com>,
        <linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFSv4: nfs4_do_fsinfo() should not do implicit lease renewals
Date:   Mon, 16 Dec 2019 17:38:03 -0000
Message-ID: <056501d5b437$91f1c6c0$b5d55440$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdW0MytZJzbanD9yTZ+e0zLvCdtxJA==
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Robert Milkowski <rmilkowski@gmail.com>

Currently, each time nfs4_do_fsinfo() is called it will do an implicit
NFS4 lease renewal, which is not compliant with the NFS4 specification.
This can result in a lease being expired by NFS server which will then
return NFS4ERR_EXPIRED or NFS4ERR_STALE_CLIENTID.

Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
---
 fs/nfs/nfs4proc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d3716..aad65dd 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5019,16 +5019,19 @@ static int nfs4_do_fsinfo(struct nfs_server *server,
struct nfs_fh *fhandle, str
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
-	unsigned long now = jiffies;
+	unsigned long last_renewal = jiffies;
 	int err;
 
 	do {
 		err = _nfs4_do_fsinfo(server, fhandle, fsinfo);
 		trace_nfs4_fsinfo(server, fhandle, fsinfo->fattr, err);
 		if (err == 0) {
+			/* no implicit lease renewal allowed here */
+			if (server->nfs_client->cl_last_renewal != 0)
+				last_renewal =
server->nfs_client->cl_last_renewal;
 			nfs4_set_lease_period(server->nfs_client,
 					fsinfo->lease_time * HZ,
-					now);
+					last_renewal);
 			break;
 		}
 		err = nfs4_handle_exception(server, err, &exception);
-- 
1.8.3.1


