Return-Path: <linux-nfs+bounces-1485-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CE683DDDF
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5641D1F2450A
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883B11D6A8;
	Fri, 26 Jan 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="sn6iuR0v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1898B1D697
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283861; cv=none; b=ipN6gfhpqDwaMcFpxNqUURLLAiIcuO/PHoh+NA9cFr5LDJNH3j+ZM+H4poG/LZmANcg6fyG2SlKFvMBSXroT2Sg1wbdcTWWR/0q1WU60MfYagmgH6Ui8EKHJfilGzOUHnzWQQC5b+hLWGjavoyVmn2iNNWt1+qS7STBtU6RzIbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283861; c=relaxed/simple;
	bh=u1dHi6mNixi1zGBfCROOYSu8eSvq8Cesu/3w1LhDWZk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4X43qsBn4pyuqJdCL7Xe7GVxhEjH3mHFsz+epNXd+odk35PXR5mwe8OS71/hhxozOWK1A4KoRVBja1VVHblznd/KZ0EEnxPe0PCZEoPmKfx2cQUnypf+cSLLQ6+Pqo6CqRTnT6O6owvWNqDthYGa1QVABivGHWmHnVrWM0SxQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=sn6iuR0v; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc24f395c84so423892276.1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706283859; x=1706888659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Yo0e/Lck+pvwePZ6CWknvlExNBTLSvDrEZMiXn1aeM=;
        b=sn6iuR0vzVGozLxsLg/GxIyPthBpkGDtt3g2XHh181Ki9X1hMQAyrXCq4WE028acXs
         Nnr+eI6ASODIiO+IWMHAlGKqFXQYSeLSE/V3vHoZWeKr6CDBc7kyxjInX//6eHVmWdwz
         fJVSpqEGiJsYrYMwi+0U9Crs5bwsmHwL+bdZSRvhTkTWg+FqPt4PhywcvBeYFwA1izsH
         tcpx/5TXMdMktZGtcmrWDknOvr5SGeR8NtCxfQgfVnx62OFN5fR2W499s919+J14+FnG
         32QO7gIIPOnd4rOHfX2YXjaCnRrGapqsqitmsnkBnIbDqWem834n/hw43wEkaus3XHlE
         Ub5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283859; x=1706888659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Yo0e/Lck+pvwePZ6CWknvlExNBTLSvDrEZMiXn1aeM=;
        b=Ll5MW8skAgyJ3EqKEjFT2lwEf4cqxz0csq81obduS0/hAKyhXTk5kTC+MVxkybnAo8
         c1w1Z2Ufz6qQYm9izllx35fImgLgEVQgAPG4zkehVezFElqDeteYeB5CcBzyCuEF7eng
         8KOP5XYsFauj+GSb8UbFJYOUkHs2+m8hoRfyNCTMgokkPPkPNxsc0Hlz0ZmyPi2G5Ayt
         n75BdtGfNvhnVy8yWFCRAuFQ3ZH2pco2jPV0pfAJ3W/fhVwBQkTyNP1jusOx67XiiupO
         k7CvASmOVSguzjOadRoNxza4P4enAlJK7ZTc9a96tuHSiw/jHlePbNEi5AtkvXA4oCoG
         79fw==
X-Gm-Message-State: AOJu0Yxk52MzPA2wIxlq5ClXxNeTdtqca06FCTjJ5fhV+6JjxMor+BHE
	EGBg6YZaadgpV7epupfL3Ui5WTgjeJrVQMC9wfexvouO6oBI8N/Lw8J50+1M4AY=
X-Google-Smtp-Source: AGHT+IE4Jiq2eE6B+KkQ90NmQ8YS37bgX6oew1nSBIY1ARwwa8fEHanheq9qtztMvqBWtazkEzBNHw==
X-Received: by 2002:a05:6902:230d:b0:dc6:5570:8979 with SMTP id do13-20020a056902230d00b00dc655708979mr278420ybb.26.1706283858889;
        Fri, 26 Jan 2024 07:44:18 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v11-20020a25c50b000000b00dc255105656sm454292ybe.4.2024.01.26.07.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:44:16 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/3] nfs: expose /proc/net/sunrpc/nfs in net namespaces
Date: Fri, 26 Jan 2024 10:43:33 -0500
Message-ID: <3a3a4555368ecd045184d317e3065573a0817e6a.1706283674.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706283674.git.josef@toxicpanda.com>
References: <cover.1706283674.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're using nfs mounts inside of containers in production and noticed
that the nfs stats are not exposed in /proc.  This is a problem for us
as we use these stats for monitoring, and have to do this awkward bind
mount from the main host into the container in order to get to these
states.

Add the rpc_proc_register call to the pernet operations entry and exit
points so these stats can be exposed inside of network namespaces.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfs/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index ebb8d60e1152..e11e9c34aa56 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2427,11 +2427,13 @@ EXPORT_SYMBOL_GPL(nfs_net_id);
 static int nfs_net_init(struct net *net)
 {
 	nfs_clients_init(net);
+	rpc_proc_register(net, &nfs_rpcstat);
 	return nfs_fs_proc_net_init(net);
 }
 
 static void nfs_net_exit(struct net *net)
 {
+	rpc_proc_unregister(net, "nfs");
 	nfs_fs_proc_net_exit(net);
 	nfs_clients_exit(net);
 }
@@ -2486,15 +2488,12 @@ static int __init init_nfs_fs(void)
 	if (err)
 		goto out1;
 
-	rpc_proc_register(&init_net, &nfs_rpcstat);
-
 	err = register_nfs_fs();
 	if (err)
 		goto out0;
 
 	return 0;
 out0:
-	rpc_proc_unregister(&init_net, "nfs");
 	nfs_destroy_directcache();
 out1:
 	nfs_destroy_writepagecache();
@@ -2524,7 +2523,6 @@ static void __exit exit_nfs_fs(void)
 	nfs_destroy_inodecache();
 	nfs_destroy_nfspagecache();
 	unregister_pernet_subsys(&nfs_net_ops);
-	rpc_proc_unregister(&init_net, "nfs");
 	unregister_nfs_fs();
 	nfs_fs_proc_exit();
 	nfsiod_stop();
-- 
2.43.0


