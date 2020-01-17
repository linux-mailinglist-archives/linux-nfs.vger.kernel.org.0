Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C3C140EB3
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 17:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAQQMV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 11:12:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54738 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgAQQMV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 11:12:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so7955506wmj.4;
        Fri, 17 Jan 2020 08:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=87Y8vkRNzKb0ASfAWCTOo+g4i0PTErziTAjnA81V/50=;
        b=mfrQZlcQcxWm461vn7Pt8/vwp1SAQ7XomvOWfq6a5tj0XZOlNBTD1IjGSxDD/zUh4I
         hSZFNq5Nadxj3vVH80OUvRM7G14nnSIJ7kdoQTNad1MJYrPDZ5mJxi6ZXVZKve4UzmcN
         ytQlgakS/nmzKPZZUuQbb3mbQupzySL2IxkuBaqmQTLqJDP8fhtKY2undDFl8S69VveB
         u809iNgTl4+ynCRU0aDUajZjvKdaAUYwol0YMctQ6OvBWI/Lap9XxGYjjNpt93I1eQWJ
         WVCoFiDYJpS2m/8TEI+7Io0jpctcv+vUt+K8We8OYl4P3b3cQimjWGggG/ff2wZ+NiyH
         d2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=87Y8vkRNzKb0ASfAWCTOo+g4i0PTErziTAjnA81V/50=;
        b=Pr99DE1xo7S5Kp+w88cX0PkTr1W0wzMv0W3AGoOaNiB1BkainrJ2Ei+7HIUjVGH/VT
         NoQaMHSkjzYyeuJUohshMGz+7lmztwsDj8osFrUTYg57ReFNGcXEBxddDYIjTvzlGBrE
         7vIy3VbeDza54TBkaaHxSNTKzDaXLUjKENk6JSnQX02+pXJF7W26KE+QHO+ms1dqr+ID
         Mlx239anFtxeoh55nk8cWQuykmFBoUuJnBVjRVkN+pG7V25gPvbX6eYAE52+TBx4kI70
         uDjamu9o6fM/nMcvL1/I7on+1z30h6WSfFGhHgYhDZ8iFzLyJ/PTvI7yt66/IJ5bK2rp
         XAaQ==
X-Gm-Message-State: APjAAAXjDOOordRDNCKEveLzhHNJByC6/g0C+WQxRNho5kmbq45MZ7KT
        PjzbuP2m+j93ePUrv6cf+YumADL3zKQ=
X-Google-Smtp-Source: APXvYqwKmQzUUW2YmhGe897OEvvoDWB7pzekwfxNYJd91bNINrY8kSfJYyN5wNtB8Gn+zLxpsrqOBw==
X-Received: by 2002:a1c:a9c6:: with SMTP id s189mr5423712wme.151.1579277538784;
        Fri, 17 Jan 2020 08:12:18 -0800 (PST)
Received: from WINDOWSSS5SP16 ([82.31.89.128])
        by smtp.gmail.com with ESMTPSA id i5sm10267480wml.31.2020.01.17.08.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 08:12:17 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     <linux-nfs@vger.kernel.org>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>
Cc:     "'Chuck Lever'" <chuck.lever@oracle.com>,
        "'Anna Schumaker'" <anna.schumaker@netapp.com>,
        <linux-kernel@vger.kernel.org>
References: <115c01d5c66d$5dcd7ae0$196870a0$@gmail.com>
In-Reply-To: <115c01d5c66d$5dcd7ae0$196870a0$@gmail.com>
Subject: RE: [PATCH v2] NFSv4: try lease recovery on NFS4ERR_EXPIRED
Date:   Fri, 17 Jan 2020 16:12:16 -0000
Message-ID: <041101d5cd50$e398d720$aaca8560$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLAInB1/y2S+pDlHaM8/Hn+WlDXpKYaXLNw
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Anyone please?


-----Original Message-----
From: Robert Milkowski <rmilkowski@gmail.com> 
Sent: 08 January 2020 21:48
To: linux-nfs@vger.kernel.org
Cc: 'Trond Myklebust' <trondmy@hammerspace.com>; 'Chuck Lever'
<chuck.lever@oracle.com>; 'Anna Schumaker' <anna.schumaker@netapp.com>;
linux-kernel@vger.kernel.org
Subject: [PATCH v2] NFSv4: try lease recovery on NFS4ERR_EXPIRED

From: Robert Milkowski <rmilkowski@gmail.com>

Currently, if an nfs server returns NFS4ERR_EXPIRED to open(), etc.
we return EIO to applications without even trying to recover.

Fixes: 272289a3df72 ("NFSv4: nfs4_do_handle_exception() handle revoke/expiry
of a single stateid")
Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
---
 fs/nfs/nfs4proc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c index 76d3716..2478405
100644
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


