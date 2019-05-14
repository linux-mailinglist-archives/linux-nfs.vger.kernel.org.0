Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603F31CB72
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2019 17:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfENPKS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 May 2019 11:10:18 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35137 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfENPKS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 May 2019 11:10:18 -0400
Received: by mail-io1-f65.google.com with SMTP id p2so13321711iol.2
        for <linux-nfs@vger.kernel.org>; Tue, 14 May 2019 08:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=b7DbgnAqLiZQ72H1GhxMqmJx3QbZ1pmldj5GBluYBM8=;
        b=HsAzFMKhp2uh/nC40KPCTBcgWm5ABdBvEMsmZYl51mN6RHyo5tSjSy/AJZWhtHhV/r
         O6qCjt4pUXs65BDkDuVREg4baEVe4/aV4R8Upvx9x/w5cjytFGbzUyDZFFL/77U1xh8x
         QDR2E2m4jaJkpgD7nk+Gws34oNebNm5VGRWB8vwstCPi2hoLkjajm6iU8qQcsdexGq9t
         fEpOTDk5W0tUbP190CBS/BmjIF4N64OIp68JcsrF0Lgohgs3ALiQE96xRsTbWjCMP+p6
         4JNKPA1VCpR28CCtZ6eHPnj5JGFejyCrwcH+axaLtbYhh0j65BhoGFuL2NpLygFm/V0x
         fhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=b7DbgnAqLiZQ72H1GhxMqmJx3QbZ1pmldj5GBluYBM8=;
        b=QZk8meHOV94uoJWUBX0xuDWhqAT8eqlh0IrLEQcts9JsfdpbjEvrjAv3XIpk/Bb7UC
         6MmK2vlIRTTxxGbOUUz/fCR/GvRzXY4D1wJlngNhFATylpGxbFWtRHjk/Sm7YQQysJmB
         mN7Wwl4puEct/RsCIgKv1BsjQuL9wTV6yTtHDUFSM9iEbaQY0+x3rrZKkUeTGpML4zm+
         JgdZO9LJ90fokuYM6v74ApAmoOV8uOCX9rW3HghEQeEba1pucsFaUoCDCY/31c4m54xP
         vUEo0MIFsr7Wh7Shc1JZMLxHQheSuH0nw8Man5E0BKjAqqEbHW7eBT47zsD7i37MQou4
         uHGA==
X-Gm-Message-State: APjAAAWchxWKkDi84qGUnFgYlO/WfQAsPicBPcsv5i4d1sXZZZ0Ru84T
        2Ivb7hRvabICiMm/deI26LkvONo0
X-Google-Smtp-Source: APXvYqwKwmj9F2jac/mggKrKrpz9xJOq5jamIDNihhtu4SbESkqzoXaS/nXcjfhSi8n6RtI2Y64Piw==
X-Received: by 2002:a5d:8ccf:: with SMTP id k15mr20052663iot.154.1557846617645;
        Tue, 14 May 2019 08:10:17 -0700 (PDT)
Received: from oracle-102.nfsv4bat.org ([172.56.10.94])
        by smtp.gmail.com with ESMTPSA id p20sm5798815ioj.63.2019.05.14.08.10.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 08:10:17 -0700 (PDT)
Subject: [PATCH v2] Fix mountd segfault
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 14 May 2019 11:10:15 -0400
Message-ID: <20190514150755.12543.64896.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After commit 8f459a072f93 ("Remove abuse of ai_canonname") the
ai_canonname field in addrinfo structs returned from
host_reliable_addrinfo() is always NULL. This results in mountd
segfaults when there are netgroups or hostname wildcards in
/etc/exports.

Add an extra DNS query in check_wildcard() and check_netgroup() to
obtain the client's canonical hostname instead of dereferencing
the NULL pointer.

Reported-by: Mark Wagner <mark@lanfear.net>
Fixes: 8f459a072f93 ("Remove abuse of ai_canonname")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---

Changes since v1:
- Added similar fix for check_netgroup
- Restructured exit/error paths in check_wildcard

 support/export/client.c |   32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/support/export/client.c b/support/export/client.c
index a1fba01..ea4f89d 100644
--- a/support/export/client.c
+++ b/support/export/client.c
@@ -608,24 +608,36 @@ check_subnetwork(const nfs_client *clp, const struct addrinfo *ai)
 static int
 check_wildcard(const nfs_client *clp, const struct addrinfo *ai)
 {
-	char *cname = clp->m_hostname;
-	char *hname = ai->ai_canonname;
+	char *hname, *cname = clp->m_hostname;
 	struct hostent *hp;
 	char **ap;
+	int match;
 
-	if (wildmat(hname, cname))
-		return 1;
+	match = 0;
+
+	hname = host_canonname(ai->ai_addr);
+	if (hname == NULL)
+		goto out;
+
+	if (wildmat(hname, cname)) {
+		match = 1;
+		goto out;
+	}
 
 	/* See if hname aliases listed in /etc/hosts or nis[+]
 	 * match the requested wildcard */
 	hp = gethostbyname(hname);
 	if (hp != NULL) {
 		for (ap = hp->h_aliases; *ap; ap++)
-			if (wildmat(*ap, cname))
-				return 1;
+			if (wildmat(*ap, cname)) {
+				match = 1;
+				goto out;
+			}
 	}
 
-	return 0;
+out:
+	free(hname);
+	return match;
 }
 
 /*
@@ -645,11 +657,9 @@ check_netgroup(const nfs_client *clp, const struct addrinfo *ai)
 
 	match = 0;
 
-	hname = strdup(ai->ai_canonname);
-	if (hname == NULL) {
-		xlog(D_GENERAL, "%s: no memory for strdup", __func__);
+	hname = host_canonname(ai->ai_addr);
+	if (hname == NULL)
 		goto out;
-	}
 
 	/* First, try to match the hostname without
 	 * splitting off the domain */

