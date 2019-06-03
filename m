Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869443364B
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfFCRP4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 13:15:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40022 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbfFCRP4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jun 2019 13:15:56 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so14946964ioc.7
        for <linux-nfs@vger.kernel.org>; Mon, 03 Jun 2019 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcZ5yl1HJczSvlUQPeLHZE4rdRSX1XxQJSe9mqKqWLE=;
        b=aR/0LNtqCUwyef/wukHEFC2gbPU6GLzFWnMlum6TLCndbP1egR3oB9NCyCShLCvU98
         n9rnYiUPv/O6TJJRpJohD6KtBrC4aWJR3mrqMB6IeWLd/1+jsDq6g+L9A8KaAPXyBd+F
         YDjqcDjUHDG0JHot4Pv8xoAgt64isFjjpfN5Q8F3LU2AxrNH1+gmZmPFtSrY6eAMLwyl
         5lHCMcaoE2VoJDoKUD0e0Ddzy00tbiRKBUfgJGKZaFpFNOBvjd1am77qRLzQY+C0Vjal
         hggGeVP9aE+K/pZp1U3OucN30sxBGL1nHRVVzittaIw6cuXiVy/Xs7Y0nyxrsLo9tuN2
         ddnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcZ5yl1HJczSvlUQPeLHZE4rdRSX1XxQJSe9mqKqWLE=;
        b=oplfUbJ7hU//uc98yKx46xPxrgKhb1HECUv9MGf5ZG7rV3DCvEQDAoJD0JdAANCwhE
         CeAb9lXq3MejDqWAXOgO6CNSC/SUMRNRPiQwk3qIobo/TXQnz5DxSkpgDjOR/VstfWDX
         /vAajok9UM0eUg8oflNVLY7ACLHUnkP5CXfzqn0YHlsfazfs0ZmxfLuSP5zlUANjUW5r
         VJDAFk4ia+Ax297av6phR+gRX/xS4RTp7C3kyxortxJ6nrrsyA0jw+4imIis7XW2yJM5
         YZDvB9GPS5eFwErt0WE73c+BXvI8PIpU2G9QbksdJpwJI3kojlwksmNQg6JeJW5+K6YJ
         VvnQ==
X-Gm-Message-State: APjAAAVgKsLhuJIHDJYKOM2b1ZsanJXcA5xdsYeHziRMTFGjEEULKGjy
        QhCpwCk92bQgSjNuQ0v6WQ==
X-Google-Smtp-Source: APXvYqwmvryVoQFolCHH1y73CfNfOjZVo519uxnsmPcop18MJhspkkZy+Uh8TfA39x+qVmHnEfhRog==
X-Received: by 2002:a6b:3e57:: with SMTP id l84mr18420077ioa.164.1559582154794;
        Mon, 03 Jun 2019 10:15:54 -0700 (PDT)
Received: from localhost.localdomain (50-36-175-138.alma.mi.frontiernet.net. [50.36.175.138])
        by smtp.gmail.com with ESMTPSA id b8sm1971375ioj.16.2019.06.03.10.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 10:15:54 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Steve Dickson <SteveD@redhat.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Incremental against [exports] rootdir patchset
Date:   Mon,  3 Jun 2019 13:12:24 -0400
Message-Id: <20190603171227.29148-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These patches fix up a couple of bugs and issues against the [exports]
rootdir patchset for nfs-utils.

Trond Myklebust (3):
  mountd: Fix up incorrect comparison in next_mnt()
  mountd: Ensure nfsd_path_strip_root() uses the canonicalised path
  mountd: Canonicalise the rootdir in exportent_mkrealpath()

 support/export/export.c  | 12 ++++++++++--
 support/misc/nfsd_path.c | 17 +++++++++++++----
 utils/mountd/cache.c     |  2 +-
 3 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.21.0

