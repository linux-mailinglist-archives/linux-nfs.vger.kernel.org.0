Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 956604C2E9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 23:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfFSVYU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 17:24:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35043 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSVYU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 17:24:20 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so20552ioo.2
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2019 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQ3ipTqqP9Kg98OOd+l79X0kp4VIRF0YAVLEok6YWYk=;
        b=MyV2CLtz3r1/1OXvdYIA7WHYXTesWpHHsDi4baIbwqRpfSYFLdF/KkCwBeAGsQF1Z1
         64axoG9cGbL5TDmYrG/7ToU9xWX9UVHQwxwNBfq71SDFltFNJp+cSeWgMHNLKURbDbi4
         f9vq4+99ReosAIHlejo4ZXgVUsWsLa23lDrfPr319sVH5Cxor41AVrrMrr2lzeKYeJb0
         kOH/66PnV9vKzn63cUWFLQXyREAcl34xpCFrYS6ghuPo55M1f1RXLGFeMlnEvhqngEkM
         Ik2j6csks1hBhj0518XmrxfVLwKdR1l2pyLIUWpMKP/rXJzF2dgvX1lRyJtAoVQ06KEF
         FO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=RQ3ipTqqP9Kg98OOd+l79X0kp4VIRF0YAVLEok6YWYk=;
        b=SQQ+2daTBh+JjJKBavBF3ooRJX2MBMuW3jwgfZiUf8OB2LWuytTVZnzfEMc0655RoB
         T7F0dDu4DcGsO6yQ8t4JoDcxhM9NSdJhX6JYoocsIxHlNGUYHDMTNmaX8fVkoorXimkR
         mK+q3IyGrYx6ExBw36WDoFrNIlWgH6LqG4rAMz59lM/MYJ4WpqzNRH8P30HNLKUDj9f5
         HxUHVZ1GFW+w2MT/EgNG/RjVbtzP1ryLbEFnW3NAK2Hl/88MM3btUVhCDz5cILwtP6O7
         qBiiIpoqGLEzYHaNaNpZcMiHCDGhXgH5lUR9QehjeswYU+qgD70YgQZcSM+FbG3oUIjB
         qXbQ==
X-Gm-Message-State: APjAAAVhfqMGUSRi1sQCq4+XB26CwlX8U/TebSiolPyqRRVcNLVFSdnp
        Z/eaJ9K/5YBNIBUaAl8G6Qs2Kf0jlEc=
X-Google-Smtp-Source: APXvYqz/iI5T1UT9H9/SLfjFIHtJ1jvnKwnkutOh3r+AecKwnT1bYAZ49/Vj4VKMYSecX9mYPnTWqQ==
X-Received: by 2002:a6b:4e08:: with SMTP id c8mr6497821iob.217.1560979459548;
        Wed, 19 Jun 2019 14:24:19 -0700 (PDT)
Received: from gouda.nowheycreamery.com (d28-23-121-75.dim.wideopenwest.com. [23.28.75.121])
        by smtp.gmail.com with ESMTPSA id e188sm21695155ioa.3.2019.06.19.14.24.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 14:24:19 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH] SUNRPC: Drop redundant CONFIG_ from CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES
Date:   Wed, 19 Jun 2019 17:24:10 -0400
Message-Id: <20190619212410.12584-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

The "CONFIG_" portion is added automatically, so this was being expanded
into "CONFIG_CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES"

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index aa307505ca54..3bcf985507be 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -35,7 +35,7 @@ config RPCSEC_GSS_KRB5
 
 	  If unsure, say Y.
 
-config CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES
+config SUNRPC_DISABLE_INSECURE_ENCTYPES
 	bool "Secure RPC: Disable insecure Kerberos encryption types"
 	depends on RPCSEC_GSS_KRB5
 	default n
-- 
2.22.0

