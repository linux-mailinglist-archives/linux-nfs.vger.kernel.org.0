Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0FA1737DC
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 14:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgB1NFm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Feb 2020 08:05:42 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39471 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgB1NFm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Feb 2020 08:05:42 -0500
Received: by mail-yw1-f67.google.com with SMTP id x184so3190458ywd.6
        for <linux-nfs@vger.kernel.org>; Fri, 28 Feb 2020 05:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hr0LWdvFHWRgEKUvjromwmkN1mjnm2zlJDhDG0GqlLM=;
        b=Cm03edS5qphJ/MNu5NST1isf0c2hnYmqxhurNxMogDkXYkXrk6bXwTh0G/SJ+AOET0
         IHk8hT6xvK7YomgIovDZrEbd5AFuthNrXdv7j8gTK6LXWAkpKJzqZ784PsQSUp3hwAzl
         X6ASPbvF4t9CkH197qK8zNUQeFg2jSXmkFuLeSzOl+aqQOF9s3mJxbVCXkmW2qJsLJmP
         W5DJVKRsSKeobTVIvewTKr1xq3Ca15FGPoOAzyXSJqdlbt6cIwm8PxHV1bxBJpjgj9Mp
         099Ml70NIWbxqBTACz52OtWhltRPSWTLqtP+AF6psEF/dSgjwFvPtS25wJrj9Sz/9qGL
         kdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hr0LWdvFHWRgEKUvjromwmkN1mjnm2zlJDhDG0GqlLM=;
        b=SK5yQUcLz5I+HKp9oPmk+mvO2m9W6bpUBjTGOB17Wp/zeVNWjPFcEtJTHXb/4O1+DR
         IsVXCaBTtj+3kVcx8rgWRF0LBS6yi5radtRgc6p6JH4MteKRMjexXV/DdrfP5oaMKD1U
         +TafK08eLZFZicFIj5quo+JivlCI2+Db4A6vatT8nSHCibQt1zbUlNijAx2uOfNrJa5F
         N/2ynY4LOgERnra4OReX6a1uZQZgSltCRo3yADtoG5MLSymcGJ5vb8cjmxTJir7kj01x
         9Uclyw95XSpcySCFzmUUfXf1p4R5g2nbJ+jf+0zr5Xj4PM9O/E3UrAjLQ9kGpRsui88i
         61tg==
X-Gm-Message-State: APjAAAWuLMmLCuAzshpNkZjGyMdejV0TesYeh98SA4op87m6SYRE5pG/
        Oph+lHMT1jyrZMUfRlxX8X4jqbOrcg==
X-Google-Smtp-Source: APXvYqwH2XQtYYP5XHeb8R4KjxDM/ZfxyQiCeHp6Y/CkpgRFHJE5lXGcESaHIvDhSVYGRfmJ5F3Fwg==
X-Received: by 2002:a5b:383:: with SMTP id k3mr3501502ybp.260.1582895140696;
        Fri, 28 Feb 2020 05:05:40 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id v5sm3735042ywh.23.2020.02.28.05.05.39
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 05:05:40 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4/pnfs: Return valid stateids in nfs_layout_find_inode_by_stateid()
Date:   Fri, 28 Feb 2020 08:03:31 -0500
Message-Id: <20200228130331.1330189-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Make sure to test the stateid for validity so that we catch instances
where the server may have been reusing stateids in
nfs_layout_find_inode_by_stateid().

Fixes: 7b410d9ce460 ("pNFS: Delay getting the layout header in CB_LAYOUTRECALL handlers")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/callback_proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index b6ffac9963c8..eb9d035451a2 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -128,6 +128,8 @@ static struct inode *nfs_layout_find_inode_by_stateid(struct nfs_client *clp,
 
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
 		list_for_each_entry(lo, &server->layouts, plh_layouts) {
+			if (!pnfs_layout_is_valid(lo))
+				continue;
 			if (stateid != NULL &&
 			    !nfs4_stateid_match_other(stateid, &lo->plh_stateid))
 				continue;
-- 
2.24.1

