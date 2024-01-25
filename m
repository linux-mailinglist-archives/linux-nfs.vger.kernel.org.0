Return-Path: <linux-nfs+bounces-1416-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A8D83CCE5
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DFD1C23EE4
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4661339B2;
	Thu, 25 Jan 2024 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gDJTfzQ/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816D135A7C
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212425; cv=none; b=WRDO5tdIYRXTMhAO1m66WSHczqHiubcq+wTEVcM/i5hOT+NA0Js+bY2mwTJNKAflZ9NYHaUegIpUxCbG61e7pLRmCvNwL46rmtboV5/4fK5Qq0rOtMZrQyQ5O1ddzuCOQHp+nG/w6y4++ut5JDBn6M3OhpP9J0w3XQt9/RqwCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212425; c=relaxed/simple;
	bh=oPo2HSHbqQg92hg+sIJI4A54+JArwH/DlZtupCaGy64=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzHRYkCD+A66OGz6k6BDQ3bB/EmG3VubFJVsxV1wwcco5WNm4S6miBuUX6tBnVw3in2G+gdi/9BF5zq+7Ez0TJZ7obwWPOlWuHUhOanBfacTMtgV5PSErQVyn0l+amMD6ECgqzVFTrHzjH/9fER0GXizK8BTxZIM7yc1CYIl918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gDJTfzQ/; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4644822276.2
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706212422; x=1706817222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IiehwB2G+Nt2uBxPih15JoYIXyWwYzVUYGRXkPDnck=;
        b=gDJTfzQ/nvntbwA9om9aELW9sFH08NeiFIK2NvcxYDcux3c4hKxVt8TqLra4yiTzGc
         hEG0Mm7NVBlxsSaDm+eUTz8vjC/BoVUOEOKpUxil9Waqw4acP9fmSrqaAbLUnOS3XB+t
         VUo5Xa/OdNhao4E70gkbeH+rfV6rwv+46lILH4uSxMJzbvRbqrAMDcMOAr1gbTY7hLo8
         jZFXvJaAMkrRXV7RhkM4GB8kkNfBuSVTjXqjbxs5gsX2D7eZnb6NYiWan6Z0Oo/x7uw/
         tqWePSoy9Vgrtg7eblcp1mDcT9u8DmKQc6stPDW/Glzuemul+sclHYF03+Iboe69RMKz
         017w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212422; x=1706817222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IiehwB2G+Nt2uBxPih15JoYIXyWwYzVUYGRXkPDnck=;
        b=aWtrE2mak0DrlR1balpRFob1DsVt7fjc6Z9a8AyqldJSB+IZyTYjTIgCgrgi2+yyPJ
         kx3hXr84TIH4rJ696OK2FXcg1oOSCEKgrP9TgtcImVStj83I2U440N1Shi9lt/SijKNy
         drslhs0W89n6K1UBbmRh8ozaZBtqBkSCB5fV+u/weyVO72umUv3oUpKFZM+x47qXL5bh
         dVofc0O8ty1YaA7RAMR0vNQfRk0HRAT02k+Rt60JVinMZG0xWz9g1V2RXhFqXwAuQ8Ij
         bbdD1HjdT1C2/v3mp2CAiZtsXSRn40ztIMqeCyvdNo+2vaadetSK8W/xOaJKe4hjJnls
         n9NQ==
X-Gm-Message-State: AOJu0YyW7LBo/DLKekOrXxz9+I5HJiXVDsoEvyeCheu65f53eQFw/goY
	y8ZMeXRT88tyYFMQxlMjBjFyV0DU9LtrH8BITIdm4Zc9nwCPSABcH9NXPr5lu8wa9hx4tgOQkfi
	A
X-Google-Smtp-Source: AGHT+IFMDlWF03RKSC83l3NeHQobNWKjGoPWLtQAHxdDJBanl1CeAPxc+gStJMVSBWECUNiCTUgslw==
X-Received: by 2002:a25:838f:0:b0:dc2:279f:f7e with SMTP id t15-20020a25838f000000b00dc2279f0f7emr335563ybk.10.1706212422344;
        Thu, 25 Jan 2024 11:53:42 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v14-20020a2583ce000000b00dc25400eda4sm3554187ybm.22.2024.01.25.11.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:53:42 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 06/13] sunrpc: use the struct net as the svc proc private
Date: Thu, 25 Jan 2024 14:53:16 -0500
Message-ID: <eaff30e7254df4b887bee7c57a98437df72e49a1.1706212208.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706212207.git.josef@toxicpanda.com>
References: <cover.1706212207.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfsd is the only thing using this helper, and it doesn't use the private
currently.  When we switch to per-network namespace stats we will need
the struct net * in order to get to the nfsd_net.  Use the net as the
proc private so we can utilize this when we make the switch over.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/sunrpc/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index 65fc1297c6df..383860cb1d5b 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -314,7 +314,7 @@ EXPORT_SYMBOL_GPL(rpc_proc_unregister);
 struct proc_dir_entry *
 svc_proc_register(struct net *net, struct svc_stat *statp, const struct proc_ops *proc_ops)
 {
-	return do_register(net, statp->program->pg_name, statp, proc_ops);
+	return do_register(net, statp->program->pg_name, net, proc_ops);
 }
 EXPORT_SYMBOL_GPL(svc_proc_register);
 
-- 
2.43.0


