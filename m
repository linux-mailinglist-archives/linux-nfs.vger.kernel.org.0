Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B489113635
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 21:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfLDUN7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 15:13:59 -0500
Received: from mail-yw1-f48.google.com ([209.85.161.48]:34429 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfLDUN6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 15:13:58 -0500
Received: by mail-yw1-f48.google.com with SMTP id l14so261487ywh.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Dec 2019 12:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Mk3q3KUyyiwL9JayrorzBaIltib7583L5FTAGPzj/gk=;
        b=o5UvfpDA3Hq9n3jvONc9a4RcI2bcBYj+fBO2K6vRGsea9o9TzBmsUsMvXPcLVOYpqH
         61QbI0gPPlNPJeheHeL2vh2diX8i71TKrdqjPwkC+O1438tO6H8NnSKzEUN/kUyrDSBI
         81HwsVXQeQ7623etEKLp4cBvGX4Vtp1jcNKqW+11V3ZSLP5uu9i3ZdQEt9i0QuArk+51
         CHpObdcHgRqPUH/oHY1GmOVAu0shylWbwrO1BDkKEr6+oI79tw93jrd8cczipsWKPvWA
         RdCyCI6VksNS3+nM72UXIhuxwrA/LZ8xrPIdG1LXUQSl0pdjfzgfl6itI2/WLMzdBjpF
         /DUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mk3q3KUyyiwL9JayrorzBaIltib7583L5FTAGPzj/gk=;
        b=CXteWVm2jEK7JbqpE70/wEnRGZbzSxCDNag2cta3HeX8a8VHbIScrBeiINtW3HOcET
         20BsduBLRY1aBtd6BacQ8xGvqQjTdghKD8eta+2qVNIpU5zcbgm7RTTPbSaeQ9WuxS83
         YgGLe7KnkTYaTRh+9jx++syO8olsBiLiQinlEwlFJo+sT+9Xuk2gBf0hbs/ZK6QlDI0I
         vgPTncAckk+fiewRnwttqUQxq56oD6wWL7KnoIxtWy8hPj5oYsCEfi3eFqMTzWNkEfWc
         xh4V4Wrzj4In9xJj9/zkosQG4MxrE9/4qV2VeL1Cbl69TOTFsAaZZxffrhZp+ClfGtXV
         yUDg==
X-Gm-Message-State: APjAAAWnN7QgjlLxzP9MFbyAhsDs4yGOtaxoFr+taz/gAUZ5o7Eb/HCA
        tZf7hP0iGkWOdZ4Vyi5ZOP8=
X-Google-Smtp-Source: APXvYqwN8EFV2c6eYBLsJFROxj4gTa1Li6WTAELgL0KX33xu10cvC1uE/TIvAN3VGR2kRTEOWr0iMw==
X-Received: by 2002:a81:9a09:: with SMTP id r9mr3275163ywg.244.1575490437722;
        Wed, 04 Dec 2019 12:13:57 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id o69sm3496446ywd.38.2019.12.04.12.13.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 12:13:57 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] NFSD copy offload fixes
Date:   Wed,  4 Dec 2019 15:13:51 -0500
Message-Id: <20191204201354.17557-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A few fixes that were found with kbuild and static checked.
Mismatch of __be32 u32 assignments
Fix error path leading to null pointer dereferences

Olga Kornievskaia (3):
  NFSD fix mismatching type in nfsd4_set_netaddr
  NFSD fix nfserro errno mismatch
  NFSD fixing possible null pointer derefering in copy offload

 fs/nfsd/nfs4proc.c | 19 ++++++++++---------
 fs/nfsd/nfsd.h     |  2 +-
 2 files changed, 11 insertions(+), 10 deletions(-)

-- 
1.8.3.1

