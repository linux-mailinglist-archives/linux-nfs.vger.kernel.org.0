Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94602A2FB2
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 17:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgKBQYu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 11:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgKBQYu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 11:24:50 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64182C0617A6;
        Mon,  2 Nov 2020 08:24:50 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id o129so11548374pfb.1;
        Mon, 02 Nov 2020 08:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbYuk3CFrZjfWmAdyIesfSiAPltELPpRtemMqyLejp8=;
        b=usBp8stHGPH6s9gkn2rRSBeC4qNtRqYLiEgZRUNkZUCFL1T/BqBg00AqApfyRUnh30
         aNdBkiEIbfqTcs5s9pORQa+St3UmYma98yDqEc4678JN8B//Nygw6v28L6hXhDmxHeIN
         sLlzZsnd/wAfMbGTdbzHdiT7HqHbRNlPllNBHrDGVel5k74fc/FczQ/2zrvClFqQpcKb
         RH6n52h1dB+dp9UivGoto443pgq1IvBRBDTmcYIYK1Pkwt0zw86nty3+UgyVg+cweQFB
         ++Uq8lljywMJiVQ1Xd3OfcmOGIo2mEjqUrtqfIXnmd2mrMnFTgVvKw6i0LKyRapdY5J5
         t+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbYuk3CFrZjfWmAdyIesfSiAPltELPpRtemMqyLejp8=;
        b=cji+1+4CbbnhTQhpBVu1d3cpvNCmcqyrwFJ6xagJPSh7ELgdHdOpkH7Qtti58Sxqi9
         ClUOi85fyxgEEkpx2hIbthiGupjEmn3Hlz5NRKF+427t6tID1hl7/63DpEWsD+sb5OCi
         O06hzw/1EVbl4sGa2SVvU/lzHUafTo57qSG6+5oICqkN2WPzxUUKnC7vP0zrKVEcgUds
         AZWhrYOaPkVvKAT7Pl9GylgB6CBv/mn9nvWOj2jzE6vkYvklyHdf2goWqRanxufHRmcc
         sd1Lk85DGjiPMTB0n4R/i8cigT+gvDThHxaVTT8WBomc+2A8MbX53wrUVkZOOaTljrs9
         t6ZA==
X-Gm-Message-State: AOAM531lWK3V/nRZwGsf5D0kdB8q8lOOSUyyYbWJXAENzI9ubN3TghE2
        JDoW6Bz5R1TsvYxhXJWP7Z4=
X-Google-Smtp-Source: ABdhPJwHK69A9xyTdHXmOjmZiqhhDtr0uRU/cMCvn3eSStSAGo9NtyJHA+Acs1u71CxW8jXDaEc2JA==
X-Received: by 2002:a17:90a:de94:: with SMTP id n20mr6374552pjv.217.1604334290044;
        Mon, 02 Nov 2020 08:24:50 -0800 (PST)
Received: from opensuse.lan (173.28.92.34.bc.googleusercontent.com. [34.92.28.173])
        by smtp.googlemail.com with ESMTPSA id b29sm8379575pff.194.2020.11.02.08.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 08:24:49 -0800 (PST)
From:   Wenle Chen <solomonchenclever@gmail.com>
X-Google-Original-From: Wenle Chen <chenwenle@huawei.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenwenle@huawei.com, solachenclever@hotmail.com,
        nixiaoming@huawei.com, solachenclever@gmail.com
Subject: [PATCH 0/2] NFS: Delay Retry Proposed Changes
Date:   Tue,  3 Nov 2020 00:24:36 +0800
Message-Id: <20201102162438.14034-1-chenwenle@huawei.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Little modify for nfs4_lock_delegation_recall delay retry 

Wenle Chen (2):
  NFS: Reduce redundant comparison
  NFS: Limit the number of retries

 fs/nfs/nfs4proc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.29.1

