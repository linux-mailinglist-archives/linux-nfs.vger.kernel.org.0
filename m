Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD9C614B0FC
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2020 09:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgA1Ihi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jan 2020 03:37:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37343 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgA1Ihi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Jan 2020 03:37:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so1529094wmf.2;
        Tue, 28 Jan 2020 00:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=/vUdKDhZSRY/UX+VRyOW826eNHk7nxM2Wg/skywcxoM=;
        b=lEC55NoZfcBco9gkCKx9wq6xyDjud7Fv5F+wTOH/qxIvC3/nWVYq6qluFTaZx3Aydg
         htnOIuXNCqPksfDPijgue8RzGkn6AwD1xSnZCwpzMBFJDEmdKi4htAFmsbMDOaS8huDP
         GBmv1UXVRganOrijeu0oOw61JSP9+JV8F12zamQy3z7XvRZfIIdZ5LijihcZwe5FaHvF
         hidAbBblBul/CpWHUCM6ZDUBT8LMV0NOJZ5o4Rw55f8LdB77VwaEK+qL4aP/QKnTlCPJ
         Cusyt4wvmvPNQ1hriHLZWoOFrIn0UjK1fJqxcxtdFehJfXjLJ7SiO/AvgU24M6U5qEl/
         8DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=/vUdKDhZSRY/UX+VRyOW826eNHk7nxM2Wg/skywcxoM=;
        b=H4c/ThXcfeuq4sNoaTxl33ldssvlJAhv85KKeHddkTavHMMbToXZlDPWJYxMNZG1v7
         Q9dHsoUvEh65jWbt2BXIsskCF/J2YSt//J4lbyjvLinb+b2fzMcqj6z69VNnBKpELgMW
         EGS0G8OzKIcgMb6DS8/zeFyKT4dCzpLvB2uWHg6CQzj8Uq0DyeI6nafaX3u2VK/2tlud
         drlSMSqIduzkg8mGRsNx8zZjuh60LlK1llXwC0y3wLKze2PXQKRABdJBhJjJ3xVkN1og
         VG6xEW4BGSAdkoVOoa8A+2AnrlwlkRVEq2Qto3RSy174dGAvlJltrxile4SvTlr1OO+n
         5DWA==
X-Gm-Message-State: APjAAAVGUP3z9LMfrAYTyVevgzGm5iPFHmjZobJgFxHm28rAmWTArZ9x
        UH0N893cT3q15fTW4rOXsbaLmJThfKY=
X-Google-Smtp-Source: APXvYqwVBs4AOejmU9P7vielmKkhFW1daLUZrJZ2sePoawnjBbf01RD6w1UJWec7tr0TcLJTqqPLXw==
X-Received: by 2002:a1c:6408:: with SMTP id y8mr3560022wmb.130.1580200656136;
        Tue, 28 Jan 2020 00:37:36 -0800 (PST)
Received: from loulrmilkow1 ([213.52.196.70])
        by smtp.gmail.com with ESMTPSA id z11sm24999782wrt.82.2020.01.28.00.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 00:37:35 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     <linux-nfs@vger.kernel.org>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>
Cc:     "'Anna Schumaker'" <anna.schumaker@netapp.com>,
        "'Chuck Lever'" <chuck.lever@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] NFSv4: try lease recovery on NFS4ERR_EXPIRED
Date:   Tue, 28 Jan 2020 08:37:47 -0000
Message-ID: <000601d5d5b6$39065c60$ab131520$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdXVs9KkXsilGD6+RnONAb8nbCW6uA==
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Robert Milkowski <rmilkowski@gmail.com>

Currently, if an nfs server returns NFS4ERR_EXPIRED to open(),
we return EIO to applications without even trying to recover.

Fixes: 272289a3df72 ("NFSv4: nfs4_do_handle_exception() handle revoke/expiry of a single stateid")
Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
---
 fs/nfs/nfs4proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d3716..b7c4044 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3187,6 +3187,11 @@ static struct nfs4_state *nfs4_do_open(struct inode *dir,
 			exception.retry = 1;
 			continue;
 		}
+		if (status == -NFS4ERR_EXPIRED) {
+			nfs4_schedule_lease_recovery(server->nfs_client);
+			exception.retry = 1;
+			continue;
+		}
 		if (status == -EAGAIN) {
 			/* We must have found a delegation */
 			exception.retry = 1;
-- 
1.8.3.1


