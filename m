Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 068F915ACE5
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 17:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgBLQM3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Feb 2020 11:12:29 -0500
Received: from mail-yw1-f49.google.com ([209.85.161.49]:37750 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLQM2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Feb 2020 11:12:28 -0500
Received: by mail-yw1-f49.google.com with SMTP id l5so1103687ywd.4;
        Wed, 12 Feb 2020 08:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=VH2vWFyxx44pdYOEqkVt+7Zxk68Shz+R71/Y5B5VC/s=;
        b=XZWKpomxB/dcF4WdZ6MulcrvhIAlQSW3RSSwBM4ssE7gP5H4xADLmhAWzygboyoac5
         Fz7Sfs6DCit5cCVz0T7Gf1uZmBja0fwEKLic3izDoI4t6dP0VFJT7SQDEUgG8nD4OOO3
         HO2KmiVsRmH0zk60H6gmJ/nDCdPDxhuOnuL8xd3frQHtj2Hx/4wqntzyGGCxCQdXv5pf
         E/OSzcXraHxX1fqBAb/Bqp4wSpHpsm95+QpZuA2G56bg0Sh4mNiA2XCoepQ6+rcuPD7D
         B+7rA7DBdgoidWOqbVp0ukeJ8Oyn2odEx/XuJsctSrp7EvI4enLVktDgqqDtNYvXF+o0
         qOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VH2vWFyxx44pdYOEqkVt+7Zxk68Shz+R71/Y5B5VC/s=;
        b=hScmYIbiyAFL1IK2fVPKVX92JxlFPPSt+FzXHny1DmDw8xF98dR7ZAp7ihgg5LCPB/
         /hGNJnzv1DMnVDEX021dbhx9pVp9kXwQdt2s72t1VH9ruXNRmET94Py57hJBxCWyAYyz
         xguUWMgtXEsGXDW4blVVIISpKVj4Q1bx1mK6YDAXhXob5wilJ3R9q5tOJ29RYJjkYzaX
         07Mw9t1ANqimMpZFo4W4egGIg48eiWkSOsJ40aiY4g+aa/R4Hgt87bXRRMvYl2IuMPGl
         L4ZTAVPgYJUX1uW0Uov3PujOtEjAmcFz8N0EccAw3coB1ptBOUFyPJrdCAJM74d9tH8q
         EALA==
X-Gm-Message-State: APjAAAWZfag6+VUvN+hkMEmRc357eM7fNbO2K51RrRCTYN5iqtI67Cpm
        qK8NVnYJ1fuI+cEjnFRevro=
X-Google-Smtp-Source: APXvYqzqP2f6VU1s4hsDyzL8Ziimj46UE2fOxDObm2AYKZ47pt5x2QWf4BjO/NdIkhe/rKZWdBTbwA==
X-Received: by 2002:a0d:d84b:: with SMTP id a72mr10559335ywe.33.1581523947935;
        Wed, 12 Feb 2020 08:12:27 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d199sm350139ywh.83.2020.02.12.08.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 08:12:26 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01CGCOIv022123;
        Wed, 12 Feb 2020 16:12:24 GMT
Subject: [PATCH v3 0/2] Fix NFS/RDMA operation with Ryzen IOMMU
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 12 Feb 2020 11:12:24 -0500
Message-ID: <158152363458.433502.7428050218198466755.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

Here's a fix for the bug reported yesterday morning, plus an
observability enhancement to help diagnose future similar bugs. The
fix needs to go into 5.6-rc and 5.5-stable as soon as you can. The
observability change can go in wherever you see fit. Thanks!


Changes since v2:
- Fix now passes the usual gamut of static checks
- Improve MR trace points even further
- Split out the trace point change; it does not need to be
  backported

Changes since v1:
- Ensure the correct nents value is passed to ib_map_mr_sg
- Record the mr_nents value in the MR trace points

---

Chuck Lever (2):
      xprtrdma: Fix DMA scatter-gather list mapping imbalance
      xprtrdma: Enhance MR-related trace points


 include/trace/events/rpcrdma.h |   56 +++++++++++++++++++++-------------------
 net/sunrpc/xprtrdma/frwr_ops.c |   15 ++++++-----
 2 files changed, 38 insertions(+), 33 deletions(-)

--
Chuck Lever

