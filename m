Return-Path: <linux-nfs+bounces-11043-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3A3A813A1
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 19:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA8A7B08A0
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E097A22DFA9;
	Tue,  8 Apr 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schmersal.org header.i=@schmersal.org header.b="ja89SvLJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B9237176
	for <linux-nfs@vger.kernel.org>; Tue,  8 Apr 2025 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133298; cv=none; b=LfUx4UK/wEzwGzu5PVNK7fo4iLm/C9do9LG1EMQaJ+pFzSrL+zJWm6y5v9hKmN/vAV+WpW9A6+EsqXD7MuTCdwaWPZvmCU2GNAP3r2JQhpXT9mCJvvzT3q1jLYSTBdtJvd8Vf3iHIKOeG5UJzQC1nvF6uoZibKKZvfAKQK56FQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133298; c=relaxed/simple;
	bh=swUItIfIFc4bzEEZV8B3I26YkUCmjAz4nTjckxo9MqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=emdvWAPqy9G2/huIVoxobS6lD6jDIE1fUeoxRGTqTsu+2t/dLrbkblxGDcmTH1U+E5tpUZI0SZhhqlV5IGGWYznl5a0SVPvh6N2fu91J35KFshqbR18XkYRLeRHrrFPyCcSE9r06g4p/Qlu63q4gx2XmW3MdutKVXSlsJigq37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schmersal.org; spf=pass smtp.mailfrom=schmersal.org; dkim=pass (2048-bit key) header.d=schmersal.org header.i=@schmersal.org header.b=ja89SvLJ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schmersal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmersal.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af19b9f4c8cso3915520a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 08 Apr 2025 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmersal.org; s=google; t=1744133295; x=1744738095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ROXmJWrozi/4w4oRVvow5elLyTvpEXLsmTuziAz1WCU=;
        b=ja89SvLJOxjBR9yFpRwiTQhu60qCiry4GI0fm9p+8F9W6sh1bGCczl1ytxuHdUbo0v
         TdHpEqtAC+pOkQt1xByIINrHO6a7j57kfr+uipt/jPoOEDhrrEgDkLETWt2fLiz8NHIG
         TynMGauliwvWNMV1XY/ybJy9OPrGR0XDyzUcF7UFas0SiCDj2eseykSOeR2X/kI9fw2Q
         vzdnPbLrHrkP/mnjW/6b1Ic94Tu43MqIGfUKtkU77I7e+I9o2AmL9yJN7OTFTqWDEUBv
         QN4RRCX8LYTeq7VRNIfefGJevm67XH4EGd4YfShuHDH6Vh7TUDAyESTKdMff2uD5b3ti
         MG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744133295; x=1744738095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROXmJWrozi/4w4oRVvow5elLyTvpEXLsmTuziAz1WCU=;
        b=ND+cflkwdE4T9sVsOG98hq4vdcFPsQN6T3lsNm8J0o2XwVwXkYINiXDjhX5hl9gfxu
         YUsOAlR2dXRxLnpmTPQrq3gUpfUWKOS+Jb5jSdFzPP8Ux7muEX8uOyDdJJCXbLVwZEeY
         cYV93Yh4Z/1dyG3QEVfUU87NgHEbAi1c76G7AHqjgiQtu/uYzzW9+CFPDg8eFabjk4zE
         yHU04qBcVBIHvLZKdGw4JEL4pldK1EkS8IQ82d5hUEtXYmeElAR6SqYPoR2nXp2d3OqQ
         4SiD0c3zGX2Lx5ctBB1XWriR+MHvBObtKLRK+CZXqm3yf3bHa8/+IPPMiyRznjJEWxgm
         ZynQ==
X-Gm-Message-State: AOJu0Yx0LD67UL9M6DxX3HS5nwXhx2Is9SqGXKTgGPITa/edZJNyZzZ7
	WArZ1rYgbkKvYq82v2P0g00WuKwlirXtQXZ9HrUaJsKVrokvcy1m+mj5+43pt9Q=
X-Gm-Gg: ASbGncuaXzdFiu89Gplt5MgxiZDCOZVwOgcnTvWON0DsReAMClswmuvdbgE9yooQw07
	vc7kslPwoP9mxtGlykif8SQzZnykJ0C1tocieh51IkQf2B1/6LCdCff+dYgQKKGP3xyvr0MWRT/
	4K9bfAJqt94VpV5XT3oytuXwgwlPNHZSuiGqJ/fQt7hfa0LLbFiOMMUj2JqvamlS0hkct/WFbHk
	rxQfNzQ87oxSCwwHYLr+RDzxbnhN+vFTkTvO7iCJKKskvBb3uAxIQwiO4SBCT0wkq44o3GX+vFG
	qfs+lqouxXK7H2Z+eSQxV/SU8neJwToyDlMw1A0UxL41KOFuGIu0hpCAsh1DU3auUzweS2qqDfE
	ocFANxrh8JOYZ6/eNam+IevXe3jmZ8EOujH5tmsuBd9c=
X-Google-Smtp-Source: AGHT+IFYWn052QOgjuwqHkAleMGprZUynfZDzGvaglQ3KaTReXKy8lhNyOLJStlFWVlMn10vjaxSaA==
X-Received: by 2002:a05:6a20:12d4:b0:1f5:8605:9530 with SMTP id adf61e73a8af0-2010818982emr24969279637.28.1744133294804;
        Tue, 08 Apr 2025 10:28:14 -0700 (PDT)
Received: from bryan-ThinkStation-P520.tds.net (h69-129-150-238.mdsnwi.tisp.static.tds.net. [69.129.150.238])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc41a840sm9272914a12.65.2025.04.08.10.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 10:28:14 -0700 (PDT)
From: bryan@schmersal.org
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Bryan Schmersal <bryan.schmersal@bossanova.com>
Subject: [PATCH] Import CHECKADDRINUSE from errno and drop "errno." when it is referenced.  Was causing an exception.
Date: Tue,  8 Apr 2025 10:27:22 -0700
Message-Id: <20250408172722.377963-1-bryan@schmersal.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryan Schmersal <bryan.schmersal@bossanova.com>

---
 rpc/rpc.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rpc/rpc.py b/rpc/rpc.py
index 124e97a..84088f6 100644
--- a/rpc/rpc.py
+++ b/rpc/rpc.py
@@ -6,7 +6,7 @@ import struct
 import threading
 import logging
 from collections import deque as Deque
-from errno import EINPROGRESS, EWOULDBLOCK
+from errno import EINPROGRESS, EWOULDBLOCK, EADDRINUSE
 
 from . import rpc_pack
 from .rpc_const import *
@@ -846,7 +846,7 @@ class ConnectionHandler(object):
                 s.bind(('', using))
                 return
             except OSError as why:
-                if why.errno == errno.EADDRINUSE:
+                if why.errno == EADDRINUSE:
                     using += 1
                     if port < 1024 <= using:
                         # If we ask for a secure port, make sure we don't
-- 
2.34.1


