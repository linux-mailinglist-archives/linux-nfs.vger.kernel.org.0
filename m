Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7060DCCE1
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2019 19:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfJRRdr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Oct 2019 13:33:47 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36198 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502519AbfJRRdr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Oct 2019 13:33:47 -0400
Received: by mail-il1-f194.google.com with SMTP id z2so6269009ilb.3;
        Fri, 18 Oct 2019 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTeypUmUMaVTBUGyoYlEEodN2b8ojCnTKiuwMniqi7E=;
        b=Z0XeyDyHgaQW858x0IvQ3TDySYSZ8uDxyrlPI9loOY762om8YIBcPySzgHmI8CRhFU
         71UY/BFPp34Rw6IJU9DltJnAQOYxG+KpMDZgDxx3na92CBtnpZm2PZ9iI6fJK+ado2SM
         0veiRmCXt8k6bTlZ2Te/TNth1iZj8foqBNzy81ABFY4dYOEk8aNbI5xqzkzbc8i0raip
         27UiyET431yblW0aZ7TIxLDxzjg8tNuREeViNoiB8SBwZJ9caIOu5m8gkxJl7yIV7eat
         rvu7QPJxO8lKLZRJeDcOjN0Li87CYWkB2Fp8EKCieTrOaZ24VZ5GeDL6c4Q3bR/KtRDX
         nbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NTeypUmUMaVTBUGyoYlEEodN2b8ojCnTKiuwMniqi7E=;
        b=Ncc62gbUrVCPoNmbPFLo2O6W7jagOem42G8Y97UNT1ZY9Xx27HRcHaIay7l+jNmQC2
         fTyq3jHRW2ptF6YrYXSo738G3km3DRX6KFFne2xUkrLalIJAXPLexaIwVXu1oyynSIcN
         ignM5TX9vPY1KJLOqvyDpxKgtgwbofNaH4X2QRPrsSvKd7WDu0ilgE5IaklRL1DcM3+G
         AD1Z16ySV1FIzW/qEZyCaH8QLgQQaUlq0OlYU2geuqD1RHJvQkCurkH3Y4ZGFQbNsOJZ
         /CM+jnerYUVwlb3Fhl2QfhfW06278Y6KfDluuHSKuu5C2cIWVtkilkO3KxdWfDrZqlEj
         9fSQ==
X-Gm-Message-State: APjAAAUJrSJBIS0B2IVkkvYi35Kg22MsadBNxocA4ysb5mKSKPwr9USu
        Ftax9xD3b4vo1PDryQu3USAP/Xn+
X-Google-Smtp-Source: APXvYqyh3frDndCit25hcOILnK3wZIDQN5QCPhP8oJta8daeCqK/CEDMXpsiw0xtwxOYruiY2CwvvA==
X-Received: by 2002:a92:475a:: with SMTP id u87mr11800289ila.26.1571420026361;
        Fri, 18 Oct 2019 10:33:46 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id m14sm2416871ild.3.2019.10.18.10.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 10:33:45 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 2/2] generic: 448 shouldn't delete $BASE_TEST_FILE if it isn't set yet
Date:   Fri, 18 Oct 2019 13:33:43 -0400
Message-Id: <20191018173343.303032-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018173343.303032-1-Anna.Schumaker@Netapp.com>
References: <20191018173343.303032-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

NFS v4.2 supports SEEK_DATA and SEEK_HOLE, but earlier versions do not.
As a result, the test exits and runs the cleanup function without the
$BASE_TEST_FILE variable set and the shell expands it to "rm -f .*",
deleting all hidden files in the current directory.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tests/generic/448 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/448 b/tests/generic/448
index dada499b..d6cdebbf 100755
--- a/tests/generic/448
+++ b/tests/generic/448
@@ -17,7 +17,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-	rm -f $tmp.* $BASE_TEST_FILE.*
+	rm -f $tmp.*
+	[ ! -z $BASE_TEST_FILE ] && rm -f $BASE_TEST_FILE.*
 }
 
 # get standard environment, filters and checks
-- 
2.23.0

