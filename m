Return-Path: <linux-nfs+bounces-1509-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9C383E43C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 22:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701041C23CD9
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 21:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F1E286B3;
	Fri, 26 Jan 2024 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="mx0UOvfz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7F2869B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305761; cv=none; b=mYKgWvX7sAeVrFoJpoVcF/h7mPKVZv3iDHsdqIDsIJQuMTZDeiDGmqXbPi2+vupjRZ0OqUEN1NaJExSLr3aM51BGDlVwurdT79QPTMU7mR5IsHty5cpIHFPpAWMREFjYYLqXda2GHMVlE7aTLGzmVbCAaoSxFRjHAGYDrcMejzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305761; c=relaxed/simple;
	bh=JTwRVpH32LvDugIqnbnmmczuHqcBxVf4l8C4nly6l+A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IvRSV62H12dM1wz6zS0xTe0f2oHTYaYUaki/QW2LwD/pX+Cxsggo/nEzvTduNNGHTX7bGe3eAODIMwyb++Yagn9nZO5jhinCKBIaySl0gk06ajxUK8dQs8ioe5g2V+HTbskUN+mEp5t3RBR05QjmkECTaYsoNc0eqONMrRPMhmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=mx0UOvfz; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5ffcb478512so6574017b3.0
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 13:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706305758; x=1706910558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c1NTdOJq2VnauEz3p1sI9qvdP85TyqdpLy9SMNqs6yM=;
        b=mx0UOvfzMjV6xc04OjEkCDQu08iXrJvyCk+xTMELWEf8KUP0Ol9jYN/veWepOjoj8P
         PCuhqaJ+NvcNjuMi8CgiX1tKGc+Eojt12ypCn6+FlvXUXqI703fVz2t1hga7zWFBW3ve
         bbHz2DGUnfnfiBZ1VCb7DeyL+Dx6dQNUeiJS5pE/NilkhJOuZORty6eLO1/j4bY/vXyb
         splTLMIQo2blPc2jibJV2B2GlBuNPhrHBga/xyMu1FlRf346LCLkrL4q8WXPEukuXLU+
         NoZZuJtYeT3TJcV6cOUmf0oa2Xh8ompRlI/xCuicRAbtMj9Ib0DdxzgqpBn8nVh4Yzqo
         Lt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305758; x=1706910558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1NTdOJq2VnauEz3p1sI9qvdP85TyqdpLy9SMNqs6yM=;
        b=u4SxT70yMeACUn4SrNYwn6BUWgXcmJMaRKeATnUwWdOJSflFiZSoUp3IczzBHYIzfL
         e+wo1Hv37sekm4ohdz7L1V2naJ9jiXEwi4cNnxyzKZyZzQEkZXNuawR7D358zgSf3fcu
         2XtzG3TmjKSw6MQIXPD4AJ7dHuvnnYkds8DJ05yeQMWgYO8PnziPI5H7dNpEkY9OQMaM
         jC9BeyCGwHjNbZ1tn3IK+8Y0mwNANYlON//BywNkRpdxuGujsW0PlaIkS8XxOENcOcQs
         wGD2gn4ihv1s5IZj/Ahb09+UWfnfRS/j3SPJ/Ih5SKRezSagmVAsm6u2lCMSUO6zquek
         qE5A==
X-Gm-Message-State: AOJu0YzRf0J+0qH3dvaHzwjy7fILCWoO7ilRlw4VfXkIQbbru2H1WoaF
	oFMTv5M6EnMtzEwJp74lwyQIKdfHFs+ZZp1O39m+nctGCPfiP8WCMJIhka2Qq1w=
X-Google-Smtp-Source: AGHT+IGF4floMF2XU6k7Ebc+3Yrbwdii0rDFouw4hb9bLKdb2svvGtePxxtEarB+ke57POuQwaTfpQ==
X-Received: by 2002:a05:690c:c84:b0:602:9ae3:a7c2 with SMTP id cm4-20020a05690c0c8400b006029ae3a7c2mr1346807ywb.17.1706305757858;
        Fri, 26 Jan 2024 13:49:17 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id gt19-20020a05690c451300b005ff7a3cc04dsm649886ywb.129.2024.01.26.13.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:49:17 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 0/3] Make nfs stats visible in network NS
Date: Fri, 26 Jan 2024 16:48:59 -0500
Message-ID: <cover.1706305686.git.josef@toxicpanda.com>
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
v3: https://lore.kernel.org/linux-nfs/cover.1706283674.git.josef@toxicpanda.com/

v3->v4:
- Fix a weird formatting thing that snuck into 1/3.

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


