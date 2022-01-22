Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88956496DAD
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jan 2022 20:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiAVTpv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jan 2022 14:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiAVTpv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jan 2022 14:45:51 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6F0C06173B
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jan 2022 11:45:50 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id p27so41145962lfa.1
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jan 2022 11:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BaGR9E0S4QUxDkKd0HyGtMFDajebqzjJNjySgQ+VB/w=;
        b=T5H60OySewAzxjqPWoGnHTkVW8QhGUtO01Irg7dR91rFoUNFRw1mU3WRI+1hBVwn9E
         2/SNpDqOdY/vLcua7LN+noem96riJEaHCaR5qTFxbDxqi4mrHKwmBe7jQeGTL9fllYCC
         q7nHStl3BxBtlQ/1O2pFpkU9yBFaMzSPPghv+FS6jsfMV57CkKYpvyA+K13s3WpMExeG
         4fNnGcVE34ompGbmlwN6DjI8BEXpL1LDtXojh3xxFZZPDo9vEbTrs2KSWmLFTdkVpVqX
         nf7Aew1e/4Cnc4IprIiydrb2lws8NsHyYVOhx36f12pEd5+F0QWOpP6A0+sCvDOyP2nQ
         Mmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=BaGR9E0S4QUxDkKd0HyGtMFDajebqzjJNjySgQ+VB/w=;
        b=Rj6sgR4SmmaOGUFpcM+PP2ufIboo6SlD4c0V0XCnzzPfawU94QmcYOyPCtJAKm4pvK
         i7HLWcS1uFPWYI+iYTcQT2Tjp3uEBwg57b18wfDJgGA86BlIjRZsf9AheSpLYpg/v/zi
         fuPmrBxQnxKJ0fb/3oF7+bk7uHkV6Mm8ttp6JFzQHWx78GsxXBFzJi1UicKBb/FFZy+h
         mtnOGjy/kGYeOEzPshKtl7zQ7vTo2voMfVaA898RByXeZkfGyJcM6SM0MlxCnCHglueY
         kXkNqsYeSNUvoL2BskBa7yVcFcuT6YYQYeUveHIhLliFCEArglDyf//ep4WtgZm5VFSg
         u3XA==
X-Gm-Message-State: AOAM533F1OSk0IfPIiKodqinbU4BkO7VzRm9kvkSkPt4WODo/Q+v3Ln7
        gilGpUtDN2D96QvO4QQAwis=
X-Google-Smtp-Source: ABdhPJywIzzqtFVzwBSx8iyS9Fi1Cp5RjNhpAWeQePaj1A3EhkSjPPN9VlulD8HVb5GkCd8gISobYw==
X-Received: by 2002:a05:6512:3a8c:: with SMTP id q12mr7536706lfu.487.1642880748940;
        Sat, 22 Jan 2022 11:45:48 -0800 (PST)
Received: from elende (elende.valinor.li. [2a01:4f9:6a:1c47::2])
        by smtp.gmail.com with ESMTPSA id g16sm648760lfj.60.2022.01.22.11.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 11:45:48 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Stefan Walter <walteste@inf.ethz.ch>,
        Ben Hutchings <benh@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] nfs-utils: Fix man page syntax errors
Date:   Sat, 22 Jan 2022 20:45:37 +0100
Message-Id: <20220122194537.118609-1-carnil@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Ben Hutchings <benh@debian.org>

In idmapd.conf.5, there is a line of what should be literal text
beginning with ".", which makes it an (invalid) command.  It can be
escaped, but then there will be a space before it.  Instead, Move it
to the previous line and use the .BR macro so there's no space.

In idmapd.man, the .I (italic) macro is used.  However, this manual
page uses the mdoc macro package that does not include it.  Use the
.Em (emphasis) macro instead.

In nfsmount.conf.man, the first line should be a comment but it is
actually an invalid command.  Fix it to be a comment.

Signed-off-by: Ben Hutchings <benh@debian.org>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 support/nfsidmap/idmapd.conf.5 | 4 ++--
 utils/idmapd/idmapd.man        | 4 ++--
 utils/mount/nfsmount.conf.man  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/support/nfsidmap/idmapd.conf.5 b/support/nfsidmap/idmapd.conf.5
index f5b181670ddb..87e39bb41ab1 100644
--- a/support/nfsidmap/idmapd.conf.5
+++ b/support/nfsidmap/idmapd.conf.5
@@ -198,8 +198,8 @@ With this group names of a central directory can be shortened for an isolated or
 .TP
 .B Group-Name-No-Prefix-Regex
 Case-insensitive regular expression to exclude groups from adding and removing the prefix set by
-.B Group-Name-Prefix
-. The regular expression must match both the remote and local group names. Multiple expressions may be concatenated with '|'.
+.BR Group-Name-Prefix .
+The regular expression must match both the remote and local group names. Multiple expressions may be concatenated with '|'.
 (Default: none)
 .\"
 .\" -------------------------------------------------------------------
diff --git a/utils/idmapd/idmapd.man b/utils/idmapd/idmapd.man
index 5f34d2bff860..8215d2594bfa 100644
--- a/utils/idmapd/idmapd.man
+++ b/utils/idmapd/idmapd.man
@@ -24,13 +24,13 @@ the NFSv4 kernel client and server, to which it communicates via
 upcalls, by translating user and group IDs to names, and vice versa.
 .Pp
 The system derives the
-.I user
+.Em user
 part of the string by performing a password or group lookup.
 The lookup mechanism is configured in
 .Pa /etc/idmapd.conf
 .Pp
 By default, the
-.I domain
+.Em domain
 part of the string is the system's DNS domain name.
 It can also be specified in
 .Pa /etc/idmapd.conf
diff --git a/utils/mount/nfsmount.conf.man b/utils/mount/nfsmount.conf.man
index 73c3e1188541..34879c8d63c7 100644
--- a/utils/mount/nfsmount.conf.man
+++ b/utils/mount/nfsmount.conf.man
@@ -1,4 +1,4 @@
-."@(#)nfsmount.conf.5"
+.\" @(#)nfsmount.conf.5"
 .TH NFSMOUNT.CONF 5 "16 December 2020"
 .SH NAME
 nfsmount.conf - Configuration file for NFS mounts
-- 
2.34.1

