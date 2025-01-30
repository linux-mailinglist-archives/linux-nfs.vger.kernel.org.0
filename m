Return-Path: <linux-nfs+bounces-9787-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9C9A22F50
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8017164C4C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 14:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35001E8855;
	Thu, 30 Jan 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6IzT0Jh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8B1BDA95
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246846; cv=none; b=S8ZO/wwAsg3cd2R62XH/kgDFoEiy3XARU2+IZpQDq1CQyzE5vNRY5r4kmL1eQDA0waFyKqxC7yogVkvExFBbns9a+iM26Q91YOLPe3/y5LDALVfffhl7N2qt8TA7KptkfwJefBSdyn/HJmrd/rKgGRSj/Q2HNvwHOj+o3YrDJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246846; c=relaxed/simple;
	bh=/7U6Syn/HatUzDoNCZXf4vT8AgAt23c1D8lVPVK1duk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHLg5FSIaHdlCkUSEbt0eczxxK46OyfC/nE2W7vepkS8O6E4YQZeeUTb9E7ggGTIAiFrCLddWnKBkN79sueZRDeiob4hYWfY+Mz1mJZD4BYDI+Q10o0vzmG4EEI1fy0BbKTyJf+BMfLPGXjdelj6sMnuSwgjGef1EwijU+c2MHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6IzT0Jh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738246844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuyS+yMqL8dThfY+PMAntJW4ZMfNaFMiOS4pg+12NBw=;
	b=c6IzT0JhWWmV9dxxysZbS4Y2V1trfvgn07ujynFxgJeFHhwaeQmQjC1Wz5pCiS5UfaasyG
	9PWoRkRObDLtQHUQG+e795gqj7u6ZsOUhO1OBtxOK2GrM8CxCrq2QrfxJ65pupnp2EA4x9
	P40wlQH2LkcfMCd5wIG8RFmbq6INiZM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-gsEJcvDHNxmJrI3CnTk23A-1; Thu, 30 Jan 2025 09:20:42 -0500
X-MC-Unique: gsEJcvDHNxmJrI3CnTk23A-1
X-Mimecast-MFC-AGG-ID: gsEJcvDHNxmJrI3CnTk23A
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6ee0af16dso131018385a.3
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 06:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738246841; x=1738851641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuyS+yMqL8dThfY+PMAntJW4ZMfNaFMiOS4pg+12NBw=;
        b=j3cMTQhfewgHZKSjVDbyJIokoDdTCwd2T64muBr1Tf92u/F8c/QuNIc9y2DP0QjNLQ
         rlGv6Pe9rrHP5fdpG3TaJOxxbM6weQm9xWnnmBFEYy5cudUpHtdpmQFv6+JOa+Gg1apS
         Sgq8s5LIZ1EBgYoG0LS+nQjyT2dqQ3cY5wafF8LCngQ0Uo8Q5dLqxwOvKEK6fsT4yOf5
         ADjUFPE2aJy8hHPGrLGBh0aK3Ys5uRvBosg/fXZoP/2VZ51nM+XrXSqJCLeHMtgp9JdZ
         +gWl5kpYqcdIiofefcMx1liAP9w+M4T+CPi82Uwj3SRW4qljzRBAp4quD6S2caQx+8Aa
         9R6Q==
X-Gm-Message-State: AOJu0YwW/y3XYpa+Hj6kmAWBA7A30/9Ht4ovxgFIfondCmt34CNImwzC
	Ng11lLcRVC3ZLKytI1uw+JJQP12uaycBu4SbuUQ1lTQoOXtQ8ZNNZXyBBqs/phPkaLDIBVAn/5X
	w7bO2HCMPkwUa7O+BrIszjjJM4W53CGZMPMAB6FXhwzMAgBsfe44vRy6DVbTKUYExtUTK63zs+E
	H/PaXe8tOW2qqwaY7BcxL2FlzUkV+tWQe5ah3yqSRx0w==
X-Gm-Gg: ASbGncvRF2eG76/eAo1LNU0LIyHKTvWJ0v64s2eFO2jeQt3YbJVtRb6OSvfN4h63i+M
	cY1ejSMC2nSJ/YIysraDXtOtAarPJlURRHAL9RvAPeW2yqIUgvn2xSZGQE1/6n+caA6ulRmJdzX
	SNtZ6oQFe6qP3kOG9CBB7rEStFLupMFJtm+nU8WkDNmkLmSQeE0a1GUpuJ4fY5DJ7nRn30Rc6q6
	6B6qNlqjHJtus2We/qVGO22/xazE9YgqIxz48aWVTKegJ2cQ/+9u0WEUy3R2rK/LLq98HgcX1Rn
	DgMcmEzNu0Y1PU8NtuHyp6sCpLdXn7UogvlaWC2CFz5wcmZgJZ/NgDxbJ7VuD/BR
X-Received: by 2002:a05:620a:2694:b0:7bc:db11:495c with SMTP id af79cd13be357-7bffcd9d416mr1185244385a.51.1738246840918;
        Thu, 30 Jan 2025 06:20:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoN6SRry2Xh+tzw/L1U45ecTXFMCLzFVtDgxeALdvINpYJa4BqrfNN7theN9v1o/S22G/irQ==
X-Received: by 2002:a05:620a:2694:b0:7bc:db11:495c with SMTP id af79cd13be357-7bffcd9d416mr1185240585a.51.1738246840474;
        Thu, 30 Jan 2025 06:20:40 -0800 (PST)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a9205f4sm77449285a.114.2025.01.30.06.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 06:20:40 -0800 (PST)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: steved@redhat.com,
	chuck.lever@oracle.com
Subject: [nfs-utils PATCH 1/8] mountstats/nfsiostat: add a function to return the fstype
Date: Thu, 30 Jan 2025 08:20:00 -0600
Message-ID: <20250130142008.3600334-2-sorenson@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130142008.3600334-1-sorenson@redhat.com>
References: <20250130142008.3600334-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll need to get the DeviceData fstype when printing iostats
with multiple iterations, so we can verify that old and new
mountpoints are the same.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 tools/mountstats/mountstats.py | 5 +++++
 tools/nfs-iostat/nfs-iostat.py | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index 8e129c83..00d1ac7e 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -333,6 +333,11 @@ class DeviceData:
             found = True
             self.__parse_rpc_line(words)
 
+    def fstype(self):
+        """Return the fstype for the mountpoint
+        """
+        return self.__nfs_data['fstype']
+
     def is_nfs_mountpoint(self):
         """Return True if this is an NFS or NFSv4 mountpoint,
         otherwise return False
diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index 31587370..95176a4b 100755
--- a/tools/nfs-iostat/nfs-iostat.py
+++ b/tools/nfs-iostat/nfs-iostat.py
@@ -187,6 +187,11 @@ class DeviceData:
             found = True
             self.__parse_rpc_line(words)
 
+    def fstype(self):
+        """Return the fstype for the mountpoint
+        """
+        return self.__nfs_data['fstype']
+
     def is_nfs_mountpoint(self):
         """Return True if this is an NFS or NFSv4 mountpoint,
         otherwise return False
-- 
2.48.1


