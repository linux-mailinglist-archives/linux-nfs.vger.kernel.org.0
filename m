Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937897DCD0A
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 13:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbjJaMdr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344273AbjJaMdn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 08:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBEADE
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698755541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=01Cuhkq/fZzHdIhk7dn370LtT6qVzQS52GEFoCa52Y8=;
        b=X+7s8sHB3PrOF3W9zZY5fZv61UkJOXIA7peFfq1cZ+JGF7zHILlaYd/vBXKkd1T3rIYfJ2
        41m57JdkIT+yekFfm6b3apKaENfwTg7WpynSK1jML0CnSFOwkyoIx4qb8zdcn/qr+cW4F/
        FeBgmQol81WF9Vrw6Z9L2/VcYSCYz20=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-_29AEkATNdyIyEDStSQ0bQ-1; Tue, 31 Oct 2023 08:32:12 -0400
X-MC-Unique: _29AEkATNdyIyEDStSQ0bQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77a3fb5b214so104581185a.1
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 05:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698755532; x=1699360332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01Cuhkq/fZzHdIhk7dn370LtT6qVzQS52GEFoCa52Y8=;
        b=mgddwvIRtfTvygJV+Mj10MjNmUInfZOEf/qMUqGK/n5TOMRfdFPKQYP3O0uxjoC8cj
         pziTc6Qy4IzTmApm3/gzgKASYGcFU6mpXazwRMRfkpOcQRaw2JAzmzH3U15Im8WXG68W
         OcwCo5yNL9PBzg61SO6Gxqpk5yOfzMpplsj49rnyDdhLgmQdhzihklsCfEJD20zcshLp
         hY6cEIrr33BUr68AT/vGfXYHlzdAbQlIliKNLq6W3vSDqi87KekQXI8H820Lrt16nDTT
         4g00Os/81DkivPFzts9STbGxmRUeuUzXxrurp+GZUExcHPkEbShsdWnejYDKiWwqwhF/
         /EJQ==
X-Gm-Message-State: AOJu0YxLId88xPo1v0m/zi42YEXrBjPk3Q/CWycSDSElKMITUPD9W3gU
        yCCpC6/6Pc28quEP+6W2ZwFYlqe116qZkvlM/c5l7jun8oKrVoNXPRo+Pn+SgVmx3OfxKORUdg7
        0JaWjTj9AMLvlVFl7/HZo
X-Received: by 2002:a05:620a:4109:b0:775:681d:dc06 with SMTP id j9-20020a05620a410900b00775681ddc06mr15146860qko.63.1698755532030;
        Tue, 31 Oct 2023 05:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtP5GHt2Cr+NcxBoAmMp/ehlVMchXJA7rXREzot7xDH4Twt77eyMwn8XXa3E8PspHWfUt1Kg==
X-Received: by 2002:a05:620a:4109:b0:775:681d:dc06 with SMTP id j9-20020a05620a410900b00775681ddc06mr15146835qko.63.1698755531737;
        Tue, 31 Oct 2023 05:32:11 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g23-20020a05620a13d700b00777063b89casm457697qkl.5.2023.10.31.05.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 05:32:11 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lsm: fix default return value for vm_enough_memory
Date:   Tue, 31 Oct 2023 13:32:06 +0100
Message-ID: <20231031123207.758655-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031123207.758655-1-omosnace@redhat.com>
References: <20231031123207.758655-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

1 is the return value that implements a "no-op" hook, not 0.

Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 99b8176c3738d..4dd55fdfec267 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -48,7 +48,7 @@ LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
 LSM_HOOK(int, 0, syslog, int type)
 LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
-LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
+LSM_HOOK(int, 1, vm_enough_memory, struct mm_struct *mm, long pages)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct file *file)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
-- 
2.41.0

