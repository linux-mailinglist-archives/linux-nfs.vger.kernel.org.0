Return-Path: <linux-nfs+bounces-1483-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8045883DDDD
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2005B1F24BBD
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2801D55D;
	Fri, 26 Jan 2024 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XBRAcK6X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8B61D54B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283855; cv=none; b=TyEVizS/B1bIjWjnUrtOtii/GOXHUCykQpa7OZrqxNRMAot2nWuqBrBBG8fOVh9o37ZQTKX75OsrzrO4mUjeSLv+v0jjGu0+pOMXRu7rLeBg20iD8aTuAetgPl1W1JbwaKAcKL7Bs1t1yNd/Cey7Gq/927snDtOz3sMoHQ0+YSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283855; c=relaxed/simple;
	bh=b44TQb5DZswB3h2UbwDjwmWPJS0KwlLE/ahY5yyF73E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bKfTBZpTbS7U3qFaEp6ul2zqJxssoIqE/nVDkKnHuFu4Pr0qJLKrFDmk/4LicZdygqlRZEF/iOs2DHEb4GYIEHDMtM5CMGngY9lb9RK+gOeoK6CU9TvSwjXBU/lP5PXSU5U2iNgWQ/8gq3BYtD7lpHydgJePeOm5PqSaWqMY3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XBRAcK6X; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc221f01302so495082276.2
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706283853; x=1706888653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vUfNxK4q6wUi8JrcWpb8+6Qrm1I3qEvUiSaXRBdMtdw=;
        b=XBRAcK6XHELYIXbJFFFSA4ljd0ymfV016r9gb+ZxK8Qxu/z9uLofrJUfD9Y6U7sFN2
         KNazNJQkv4zNluiH1aqmI2iH1fJBMhJfVxdwynLj+VTb3DtOvW8BUk5nvKwzcmxiaMYD
         j5EcoKZ7k7FEpNu4U36CV70f8PntOUJDAplKIng7MA6qytgCT5Qkl1paBJYhXS/uOifw
         VYb29Yfsehe3aEzBP2u7yqJjVH7VEq4nYslmdg9WcyL8sYEE0IhStrZiQWED/IjmXno+
         fjJWNWoP43wmo0uQ56CgxatCCOSVBFziUm7TF2iV+VXfMklRnEle6265xgingSZQx1RB
         41EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283853; x=1706888653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUfNxK4q6wUi8JrcWpb8+6Qrm1I3qEvUiSaXRBdMtdw=;
        b=JkA2XrQRZXmhnvu5E7Vg4mZKFtsPfXJFIDovnEbYPnxGRUfi2EPjaYyKyLDFP+DQ4C
         rWS0eZzvI7zIcUWoQ22+JxfjPK2uaboryaDACpppFMZO1QkbthtE5xu+1Ut1A+R0f72Y
         4JpJmZOesn78IC/HjWB9FlU0Mm6JqVa2ptxsXoOziW+0VjpgdnQZCodOs83M98MdpG1/
         2qFkbDPUBqu1/dqSl++LRgHku8j4DBCFjFjn4P5eevlMUyEoIbaAzxQSV420OfzmkboR
         2rNyLyGcXJKjzM77LOT+UKJWuGOpVqRJ75IQTu5ifB9zDG2PlRTvUsh3+lUAoUG3oeej
         PTSw==
X-Gm-Message-State: AOJu0Yw5+uEhoziB1nRT12fVyavogFXKqm5gNArqnhDlEKy+xB4eFL86
	590uKH54lny/lEaPOmb//NrCSQC5SR1X7u8dcM6f5jSg/VOjoqdY583a4cU/sIk=
X-Google-Smtp-Source: AGHT+IFRYuR3ZhxRNs7CR7gidu8V6n1b3x1IL8dpECYVHKX4v7EFxfujuniGyiI3GAUCc5GJwGyvUg==
X-Received: by 2002:a25:c514:0:b0:dc2:23f6:15a4 with SMTP id v20-20020a25c514000000b00dc223f615a4mr29571ybe.39.1706283852972;
        Fri, 26 Jan 2024 07:44:12 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a258049000000b00dc227379358sm442624ybn.19.2024.01.26.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:44:10 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/3] Make nfs stats visible in network NS
Date: Fri, 26 Jan 2024 10:43:31 -0500
Message-ID: <cover.1706283674.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-nfs/cover.1706124811.git.josef@toxicpanda.com/
v2: https://lore.kernel.org/linux-nfs/cover.1706212207.git.josef@toxicpanda.com/

This is just the parts necessary for making NFS separate, the patches have not
changed since v2, I simply split them out so they can be taken through the nfs
client tree.

v2->v3:
- Split out the nfs and nfsd related changes into their own patches.
- Dropped the change adding sv_stats throuch svc_create()
- Changed the th_cnt to be global, re-arranged it's location.

v1->v2:
- rework the sunprc service creation to take a pointer to the sv_stats.
- dropped ->pg_stats from the svc_program.
- converted all of the nfsd global stats to per-network namespace.
- added the ability to point at a specific rpc_stat for rpc program creation.
- converted the rpc stats for nfs to per-network namespace.

-- Original email --
Hello,

We're currently deploying NFS internally and have run into some oddities with
our usage of containers.  All of the services that mount and export NFS volumes
run inside of containers, specifically all the namespaces including network
namespaces.  Our monitoring is done on a per-container basis, so we need access
to the nfs and nfsd stats that are under /proc/net/sunrpc.  However these are
only tied to the init_net, which makes them invisible to containers in a
different network namespace.

Fix this so that these files are tied to the network namespace.  This allows us
to avoid the hack of bind mounting the hosts /proc into the container in order
to do proper monitoring.  Thanks,

Josef

Josef Bacik (3):
  sunrpc: add a struct rpc_stats arg to rpc_create_args
  nfs: expose /proc/net/sunrpc/nfs in net namespaces
  nfs: make the rpc_stat per net namespace

 fs/nfs/client.c             | 5 ++++-
 fs/nfs/inode.c              | 8 ++++----
 fs/nfs/internal.h           | 2 --
 fs/nfs/netns.h              | 2 ++
 include/linux/sunrpc/clnt.h | 1 +
 net/sunrpc/clnt.c           | 2 +-
 6 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.43.0


