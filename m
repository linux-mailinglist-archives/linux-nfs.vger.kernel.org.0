Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC88B7DCD0B
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 13:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344246AbjJaMde (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 08:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344044AbjJaMde (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 08:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7295E6
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 05:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698755542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3DnaCdie6hqZryBnxfeM3IpTCv2hUsxvT+f5bpebJE4=;
        b=HgD3EUrL/pAg6OLadMT8bwsO8UL1mJXA/ai/aa7UmBTp1B2BUZbZ43V3chTyXMRQv+eM4T
        E/e5jZOrBqNuAXhOmzcpBep563aH63aOGzMOQzuyUptTMLYZ1ypIvom0tFbgA4SGWJXEpO
        bpZMH8muq9WednsNmQ92FqiQvsD4hpU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-8zwiqXe8NVS8IUmCraT4yQ-1; Tue, 31 Oct 2023 08:32:10 -0400
X-MC-Unique: 8zwiqXe8NVS8IUmCraT4yQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7789577b4e0so696267585a.2
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 05:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698755530; x=1699360330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DnaCdie6hqZryBnxfeM3IpTCv2hUsxvT+f5bpebJE4=;
        b=JdiVCtzY75N/v5k+oMHOX6LgG0jjNnkP97Wv5M1RGGLsh2RB6nEciA3EStublmk6rB
         kQ04QTyGR0N/8YGc8FJQ8rAtDpbs6SSWxgTFYoGrk7ZgE5Kmox6hUNViLXv0b3E0GttK
         rewN3MnvQ++OjsUvj2hCab6qQj1Kwbja0yCD6Dpq5xqn/q3Xvlh9ILTQ6mH/UO//1OXR
         9yUkHe9fq0mq5hbt0I+1lTV5VxZu5sJaAsPJOvJp0q1PeuRLRnajzH0iqyuM0hW894Bn
         I62VbNobqPvn9/nLZ0132uay0fDoG7jmiaEB+lkRaJzhCdRtvZ4PLWbvPIYLDfQVkiB6
         o6aQ==
X-Gm-Message-State: AOJu0YwnuXgg5pIGDlzSGHqhJM2YUSJ0J3ttskVKJv53DVKAvvnrj9W4
        dNcTlc+IVl2+rhnXIQ7KC5up7NysjYk1lJ4NILx/0gv9v61ux/E1FQS6/pp9ip3NySPjYHTFEjE
        6nj5JjTiVFW5El1got6D7
X-Received: by 2002:a05:620a:371a:b0:774:11c4:45cb with SMTP id de26-20020a05620a371a00b0077411c445cbmr15316848qkb.53.1698755530349;
        Tue, 31 Oct 2023 05:32:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRF2hQntJG+GwSak9Gg0Fe+r97U8evGxvH+rsbr7bRKRAzBo2stdiR75AFPLvChPFBieDyLw==
X-Received: by 2002:a05:620a:371a:b0:774:11c4:45cb with SMTP id de26-20020a05620a371a00b0077411c445cbmr15316823qkb.53.1698755530070;
        Tue, 31 Oct 2023 05:32:10 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g23-20020a05620a13d700b00777063b89casm457697qkl.5.2023.10.31.05.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 05:32:09 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] lsm: fix default return values for some hooks
Date:   Tue, 31 Oct 2023 13:32:05 +0100
Message-ID: <20231031123207.758655-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Some of the default return values listed in <linux/lsm_hook_defs.h>
don't match the actual no-op value and can be trivially fixed.

Ondrej Mosnacek (2):
  lsm: fix default return value for vm_enough_memory
  lsm: fix default return value for inode_getsecctx

 include/linux/lsm_hook_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.41.0

