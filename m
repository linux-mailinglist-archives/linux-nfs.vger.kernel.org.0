Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C1F6F4976
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjEBSIE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 14:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjEBSID (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 14:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A699EE
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 11:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683050840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=N6mCYnN9DA30kBXb3G+hAjObknC+PiKLk5wLjv+kTMk=;
        b=DkhZpXjifUHWN5zwM4AMiTSbAVJS4xfqvZn8PRzQMS2iHtHCE4v+nw9t3GLqy9LNHCmcWy
        NSC1RyXgRXPL+W3JuMG7BpP7acUEze9aTz4jzzo1+SVBCxARhLi0LzrU/uof8MAfdG9jgx
        DdpjAfWMwzMKPEoni+g4A15HkRRq7j8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-CX8nDsSjMK6wORbK--Z3Cw-1; Tue, 02 May 2023 14:07:18 -0400
X-MC-Unique: CX8nDsSjMK6wORbK--Z3Cw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-61b71c9a253so1147076d6.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 May 2023 11:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683050838; x=1685642838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6mCYnN9DA30kBXb3G+hAjObknC+PiKLk5wLjv+kTMk=;
        b=M4s2nZtBS4TLUPcfgD1Anee1OsXlKhWoWSwZf2UresgQpdY0TMMwe0UDoMHX+dN8lx
         KNW/t1iEL9P00Z0Z6m7ByTd1tVVhHT8K1fR6KTBSCzeuS1jVMIM8TurYyQf5wbsEWuwn
         jW5lMIkdL1RdnuNNSeBzFuO8/eBo4sRGA4iTt5MF2d/+msBU0AIiNtc0BzzmnmKG31+S
         9ALL56JHkTOiu0hBKpBg16LbWiY+xCGb9rJHEFFfxlQfJGVI+/+JE6F9C3oh6Rjavzra
         0uLxik/FcQB0Xgw2q48Rdi9yfnZs9jAjfOPNhXigTAQED9MhTk21kgeJtYkJxFLhsTev
         xWcw==
X-Gm-Message-State: AC+VfDw0Z0HsXkvL3BbnNIw8ouyJ8jtbuvluEbNW7Kp0dlM8m28j6mMV
        GUTKRhDkycJ7SS1QDGWac8FUHDvbExZK9jToY6ms19Q55Qw66GwhIfUZfXfX9CMMn8xbg+JLIOH
        mhgU5tgNmW6IZhtg2YA7v
X-Received: by 2002:a05:6214:c4c:b0:5cc:e059:efa3 with SMTP id r12-20020a0562140c4c00b005cce059efa3mr7170296qvj.23.1683050838388;
        Tue, 02 May 2023 11:07:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60IbjRgAV7pfKjXBYm8E1s/ey98/EL5Ltf5kTf0FlgrhKbA+fTrMRqMeiGCtcFDaLjSZ8dkg==
X-Received: by 2002:a05:6214:c4c:b0:5cc:e059:efa3 with SMTP id r12-20020a0562140c4c00b005cce059efa3mr7170265qvj.23.1683050838119;
        Tue, 02 May 2023 11:07:18 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y15-20020a0c8ecf000000b005e7648f9b78sm9626671qvb.109.2023.05.02.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:07:17 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] lockd: define nlm_port_min,max with CONFIG_SYSCTL
Date:   Tue,  2 May 2023 14:07:13 -0400
Message-Id: <20230502180713.2930022-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

gcc with W=1 and ! CONFIG_SYSCTL
fs/lockd/svc.c:80:51: error: ‘nlm_port_max’ defined but not used [-Werror=unused-const-variable=]
   80 | static const int                nlm_port_min = 0, nlm_port_max = 65535;
      |                                                   ^~~~~~~~~~~~
fs/lockd/svc.c:80:33: error: ‘nlm_port_min’ defined but not used [-Werror=unused-const-variable=]
   80 | static const int                nlm_port_min = 0, nlm_port_max = 65535;
      |                                 ^~~~~~~~~~~~

The only use of these variables is when CONFIG_SYSCTL
is defined, so their definition should be likewise conditional.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/lockd/svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index bb94949bc223..04ba95b83d16 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -77,9 +77,9 @@ static const unsigned long	nlm_grace_period_min = 0;
 static const unsigned long	nlm_grace_period_max = 240;
 static const unsigned long	nlm_timeout_min = 3;
 static const unsigned long	nlm_timeout_max = 20;
-static const int		nlm_port_min = 0, nlm_port_max = 65535;
 
 #ifdef CONFIG_SYSCTL
+static const int		nlm_port_min = 0, nlm_port_max = 65535;
 static struct ctl_table_header * nlm_sysctl_table;
 #endif
 
-- 
2.27.0

