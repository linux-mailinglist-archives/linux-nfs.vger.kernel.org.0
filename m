Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F65F1C93F
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2019 15:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfENNPH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 May 2019 09:15:07 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38027 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENNPH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 May 2019 09:15:07 -0400
Received: by mail-it1-f195.google.com with SMTP id i63so4561000ita.3
        for <linux-nfs@vger.kernel.org>; Tue, 14 May 2019 06:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eAkYkv1fn+vYeDXAqqKK+g8rel7m28C7FOc61oROyXo=;
        b=LwYByY+bn7TR76fa6bpURAJeAx+WgLikDtX0/8W2TSTnT/94BA94Kr2UAJ9ZV+oCBx
         EWeSnmeAgxbqGtlMaQzYv4KBQDsXo2RrynBe6Aojj57gFSyiC1nrpOrSNQ220dGVm9se
         xPVgQaKvUoTNrFnaMUZnnNTnnc37i8jmfBdRJb2fOF5ggVVSWTvTLSNG2sXhit3B5MQW
         1r8Vb1VYeh5q/Taj15Vk7mOZ2R3WYzX1dVD0BZdyg9y9KtPXqySEabRGAq0d9kFySlf/
         qHbbz18F8Hj44yTAOQ9743J2hA0N6A+sirG8xoKukAI4d7E7hFWQJJ18ShtzhtGpPzto
         888w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eAkYkv1fn+vYeDXAqqKK+g8rel7m28C7FOc61oROyXo=;
        b=cgnZBOqxe2Sr8iwy8hmfIt1C3bW6nhOrjtuuODENnWnK5nz3tnJyHHe5PyXWANFapo
         W54gGOpTy2Qfj87OxZwdEUbRjNUJ5QaU8lGG5KV7XAkSASbNwkFkWrVn3msN0AekVKNh
         a5DfW7kEAQF/6QytIsrwXVxANEmezdphyr0ZldhylAVFSJwraRfEAsStrOWWy9U+aqLC
         p5VUvjH5SEBNtoUMMaWDlNso+BV2VcXGrPUtfpiGSZJDWMjYSI6dx8Apd/+YYmRtdsnQ
         Hzw2w0OTguQv+G6e6WkoWP7XRl+Tl9Vz0R1LZ0eQWzGPUohV44WGOiek+LFtnwWqTwmf
         EdbQ==
X-Gm-Message-State: APjAAAWugT+mVG+/O3T4DNbatoBp0cjra9FFi4oIuikjIDj0Q7uIwu2e
        1kFEkytFHj3LljRHPOis9c9uYZo+
X-Google-Smtp-Source: APXvYqzAbTE3MoklqfRCHeOxf5TQ6dojUYsOpkgisuZ6iybNWqf9Zh7vR7NngSIYvm6Ug5i3q7CQeQ==
X-Received: by 2002:a05:660c:f8e:: with SMTP id x14mr3035866itl.156.1557839706555;
        Tue, 14 May 2019 06:15:06 -0700 (PDT)
Received: from oracle-102.nfsv4bat.org ([172.56.10.94])
        by smtp.gmail.com with ESMTPSA id s69sm6282743ios.30.2019.05.14.06.15.05
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 06:15:05 -0700 (PDT)
Subject: [PATCH RFC] mountd: Fix check_wildcard
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 14 May 2019 09:14:58 -0400
Message-ID: <20190514131458.29602.22688.stgit@oracle-102.nfsv4bat.org>
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
host_reliable_addrinfo() is always NULL. This causes a segfault in
check_wildcard(), breaking wildcarded client names in
/etc/exports.

The proposed solution is to add a DNS query in check_wildcard() to
obtain the client's canonical hostname on which to perform the
wildcard match.

Note that check_netgroup() probably has the same issue.

Reported-by: Mark Wagner <mark@lanfear.net>
Fixes: 8f459a072f93 ("Remove abuse of ai_canonname")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 support/export/client.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/support/export/client.c b/support/export/client.c
index a1fba01..05260ed 100644
--- a/support/export/client.c
+++ b/support/export/client.c
@@ -608,17 +608,23 @@ check_subnetwork(const nfs_client *clp, const struct addrinfo *ai)
 static int
 check_wildcard(const nfs_client *clp, const struct addrinfo *ai)
 {
-	char *cname = clp->m_hostname;
-	char *hname = ai->ai_canonname;
+	char *hname, *cname = clp->m_hostname;
 	struct hostent *hp;
 	char **ap;
 
-	if (wildmat(hname, cname))
+	hname = host_canonname(ai->ai_addr);
+	if (hname == NULL)
+		return 0;
+
+	if (wildmat(hname, cname)) {
+		free(hname);
 		return 1;
+	}
 
 	/* See if hname aliases listed in /etc/hosts or nis[+]
 	 * match the requested wildcard */
 	hp = gethostbyname(hname);
+	free(hname);
 	if (hp != NULL) {
 		for (ap = hp->h_aliases; *ap; ap++)
 			if (wildmat(*ap, cname))

