Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D7180785
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2020 19:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgCJS6o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Mar 2020 14:58:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44912 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJS6o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Mar 2020 14:58:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id l18so7195092wru.11
        for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2020 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3hwl/h5VDiPhnDsFrKC4AonlOsivBj+KLX3j2uZTWpU=;
        b=q9x3KkW7ngD8D5uLOKKXm6+8IYG2jrhYAwFzn8RqLDdwQvMaeiGZAsdLVIrpLIBR0c
         zssPAcD69Z3Zxiq8qBphEMBeGMYM5n72/zvWxFV2LUmUnO0tvZqyq7C+Dp24q1QtMDmw
         fLEd2uM09cs0oolRaQuTmNvoSrvBeO3ZDy1NPKtfxfBy8HBhMEED7zpjZO18cim2d1E9
         Tr8oCOvx4svPwQ2V0ozsTCYMT1WlM8/U4wbFKyK/r3eYnUQcez8ugl3+BTN/1bsyg/xB
         0j71ReqT9FavhmrvgtvdADEGck1qgYODGRf+C3omh7jQFLfog1AOPm7ug8JNZTPu8FTO
         F8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3hwl/h5VDiPhnDsFrKC4AonlOsivBj+KLX3j2uZTWpU=;
        b=W/1+2BwcIdKATWqtPXDAuwJyAMhzohijaYepJyGoHI0IOdKJzRY6OCrNCx/MOfbalL
         6VyQrwss+A0TRDl4kjZWeEcLiX04WtKobGKHeabw9feE3hyWRBvH16jm44B/AdOZabXg
         cugT2f1+eMvSjufxv73p6wqyIwV3DitkHH/P654w8GfbJM/xJdk1MphOclRnPjy8lDwN
         OjespFHinMlGzr8qoqYURk9oW5CVemhVRx1Wb1klERfD74kXEzBTjB/CQFC1K/qaEDCs
         2VAjzk3oz+QfG4wrW1NwOFhHw2ERlIY0lKd7SoOKimSba4s25IwZQxpH9m5sRm/B18xe
         8QXQ==
X-Gm-Message-State: ANhLgQ0CNQEp1XE996/h+eqIF0C/WEGTFTXbVZc5JQtoG0/wkjNrc7qV
        5uibS7LJgLTcF5SErXvAybg96o/86cD3IyE98pQ=
X-Google-Smtp-Source: ADFU+vtvxTG6+ggvs7tB7pds0kooBNLOyZnbYXfSxTBJOKyltsdrI3TebqKK4V1cFx7YZt6XZkqVHa9Gkh4oaVT6+Gk=
X-Received: by 2002:adf:f087:: with SMTP id n7mr27623782wro.328.1583866722705;
 Tue, 10 Mar 2020 11:58:42 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 10 Mar 2020 14:58:31 -0400
Message-ID: <CAN-5tyHegg96s7mr1YeoPbVd0UA7_cd2GEPYNWx98uUcx-0ARw@mail.gmail.com>
Subject: [RFC PATCH] fix krb5p mount not providing large enough buffer in rq_rcvsize
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ever since commit 2c94b8eca1a26 "SUNRPC: Use au_rslack when computing
reply buffer size". It changed how "req->rq_rcvsize" is calculated. It
used to use au_cslack value which was nice and large and changed it to
au_rslack value which turns out to be too small.

Since 5.1, v3 mount with sec=krb5p fails against an Ontap server
because client's receive buffer it too small.

For GSS, au_rslack is calculated from GSS_VERF_SLACK value which is
currently 100. And it's not enough. Changing it to 104 works and then
au_rslack is recalculated based on actual received mic.len and not
just the default buffer size.

I would like to propose to change it to something a little larger than
104, like 120 to give room if some other server might reply with
something even larger.

Thoughts? Will send an actual patch if no objections to this one.

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 24ca861..44ae6bc 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -50,7 +50,7 @@
 #define GSS_CRED_SLACK         (RPC_MAX_AUTH_SIZE * 2)
 /* length of a krb5 verifier (48), plus data added before arguments when
  * using integrity (two 4-byte integers): */
-#define GSS_VERF_SLACK         100
+#define GSS_VERF_SLACK         120

 static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
 static DEFINE_SPINLOCK(gss_auth_hash_lock);
