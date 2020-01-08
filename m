Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31A84134F18
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2020 22:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgAHVse (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jan 2020 16:48:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35824 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgAHVsd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jan 2020 16:48:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so5101167wro.2;
        Wed, 08 Jan 2020 13:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=IFg/S/cLX8hJr8mgKoLrR3Rfke0W5bVXk1Q6TVYd+AE=;
        b=n3v/AC3wT4iwuAPq2YsQ5z/WgSTJWZ+d9O4D+ncqJC4Hp5eYDDK1L1FX8E3fzzuLXE
         1diFXiR38tJZ+SdvBHGrQ8WHDgMMNrv6seNgLy+cRqmRyicgcq6n0h3Zflu6UBFbblSP
         +9a3IEnBO/MDsPLMs02f4wpHcf8SFnrqoJ7kcm+LqsHDMq+txs8yMejzQcmTSaDHs8PS
         /gM9vEQz7F3KzAL6+XQ724lQ6K4WDSt9pgj5ojKKdI89iXbpoCfmW814ZE51auucU3su
         d1u9/9iCYt1sz3CWZt4sdTAFLyNSqU+oz08JyY3lU9CuMDAfmk6js5f8rkzj/K/gbl8l
         impQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=IFg/S/cLX8hJr8mgKoLrR3Rfke0W5bVXk1Q6TVYd+AE=;
        b=WAoSQuzNE6QMitFFre7A6ECApxSkmSTO6GknfFPj4OxW6XWh949cBIIDKYHQ+mJBo6
         7Mi++U/NJ/e38G66lG5bYxzypESc5H0ASRQHSFGGIvpTQvTAlbjU1UwbuF4vdbZyDoQ8
         kf+MNgH2BCvK8S14fiW6kATZLHrH6QzlwqJXMsunoQry0PjHc60/uIGwQFDoqgJ8myAs
         aYoplBVzCE1/FgUSUDqUS1WkABAUfFuMOm4P5f8t53mkrd9VWwGh7gHRwj4J8vN6ICkK
         ux7/tIAig4A2NvnD59aFKTEDpX9lQS9BWMMpFJYwH562n24/2jR+xL/y8Ud+oPRXWDxY
         W2Og==
X-Gm-Message-State: APjAAAUHVOhwp4TdWGRR61CXoDPNipuFP9d40KPOXmJ61ygr16xXhNwk
        vLJKzCoA8QqE1xXSkLnz0Sw=
X-Google-Smtp-Source: APXvYqxzzFTXIwo+2zjEOtcKOIHDR3bMLz4Ky0ixGYJygQu212qrpPOx7dU9JT2JqvZugO90zOnMcA==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr6886782wrx.145.1578520111735;
        Wed, 08 Jan 2020 13:48:31 -0800 (PST)
Received: from WINDOWSSS5SP16 ([82.31.89.128])
        by smtp.gmail.com with ESMTPSA id f1sm504895wmc.45.2020.01.08.13.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 13:48:31 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     <linux-nfs@vger.kernel.org>
Cc:     "'Trond Myklebust'" <trondmy@hammerspace.com>,
        "'Chuck Lever'" <chuck.lever@oracle.com>,
        "'Anna Schumaker'" <anna.schumaker@netapp.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] NFSv4: try lease recovery on NFS4ERR_EXPIRED
Date:   Wed, 8 Jan 2020 21:48:29 -0000
Message-ID: <115c01d5c66d$5dcd7ae0$196870a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdXGbKgtqm1QJU8yQtKfQBn7K7s7ZQ==
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Robert Milkowski <rmilkowski@gmail.com>

Currently, if an nfs server returns NFS4ERR_EXPIRED to open(), etc.
we return EIO to applications without even trying to recover.

Fixes: 272289a3df72 ("NFSv4: nfs4_do_handle_exception() handle revoke/expiry
of a single stateid")
Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
---
 fs/nfs/nfs4proc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d3716..2478405 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -481,6 +481,10 @@ static int nfs4_do_handle_exception(struct nfs_server
*server,
 						stateid);
 				goto wait_on_recovery;
 			}
+			if (state == NULL) {
+				nfs4_schedule_lease_recovery(clp);
+				goto wait_on_recovery;
+			}
 			/* Fall through */
 		case -NFS4ERR_OPENMODE:
 			if (inode) {
-- 
1.8.3.1

