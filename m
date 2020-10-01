Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88402280AA3
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 00:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbgJAW7m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 18:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJAW7l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:59:41 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2326C0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 15:59:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 16so11709qkf.4
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=l146iONYMHrdtDqytSwBI0BQkbYXyTelo+jH+Ftfi0s=;
        b=ZZFGBlFr+opuS7GXtVKyxazcM39UILR1PR9J+tJ8x3ZSLzus1J3ocrWesXigamSBvy
         fniHiUu4ucHPOc9mLANVPUmqE/pmWVmchusUSd5CIsahUnuMzbSJX/2HWYjN1VnBjOrM
         kpvyYvKahyuRRYEXhxHeEAvagg/vOwsBoyqQrRYXSmn2ZP9ZUkoFWtaXGM71/wxntRtF
         TDzSsdSmKr77sMc1gey+p1GVPFiv7664aLDJqykiyhxxbCH6la8V26OCl4VzKXFz4AoA
         bv+6UMtEj8K61sDCd7NQxmnHCEeHlbnRVP5IlZVYJNDDG+xVtW+Ykvyhq81RXztU/nxb
         vrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=l146iONYMHrdtDqytSwBI0BQkbYXyTelo+jH+Ftfi0s=;
        b=CCxYHP1/Ly8f/6m+nN+HwakmLOAhrpEKW/w5zr5qj7yS+K+eU/gpORM7t/LdLJ3Vph
         ZJe9kM23osCW54qUZBDXHryGPO6L1BWQIqx9UlhnvyaQWYJ3tTP2DV3Aq1x3dmK44Chw
         QJU3GiL/mKfUNYAZV1vA0dQCWRDYQ5Y+8oXsUEpKZK0oYu4CyLerHSuoePiy2fukhSBx
         GHn9xp1UzcYlaR6e32D48/ByTACcXkpN92IcFgO/Ses+7agcy5PoiXGyL1us5nq/jjv8
         vIjOs36T6BinOBKNOoRmqV5Vf5lQ0/6m4urKTJqtLp7U0y4/1RHDjWVJyYqMG1ZbczR1
         7p1Q==
X-Gm-Message-State: AOAM530EDMLhMh0eVCC4WpwMSOmiNMpGXJlj74li486xQtcVOHNmtIbz
        wC5Gl1O5mm7nvL1wPDPOu+pHHpj45PRf2w==
X-Google-Smtp-Source: ABdhPJzHDrcZNl9b2Cw5JtTC14YAB90GRA8EWvnvgrsTuewQASCU83nkGX0AAFJEkxhX3kh5xYonfA==
X-Received: by 2002:a37:909:: with SMTP id 9mr10218046qkj.317.1601593180651;
        Thu, 01 Oct 2020 15:59:40 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c1sm8937863qta.86.2020.10.01.15.59.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:59:40 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091MxcKp032592;
        Thu, 1 Oct 2020 22:59:38 GMT
Subject: [PATCH v3 10/15] NFSD: Remove vestigial typedefs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 18:59:38 -0400
Message-ID: <160159317892.79253.5228045892205354762.stgit@klimt.1015granger.net>
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: These are not used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6d1b3af40a4f..2a4c4178acf1 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -11,9 +11,6 @@
 #include "xdr.h"
 #include "vfs.h"
 
-typedef struct svc_rqst	svc_rqst;
-typedef struct svc_buf	svc_buf;
-
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
 


