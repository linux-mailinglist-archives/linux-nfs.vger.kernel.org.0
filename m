Return-Path: <linux-nfs+bounces-1192-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2C9830D93
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 20:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C8B2881D3
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C67E24B23;
	Wed, 17 Jan 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3nWU9IV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55E24B21
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jan 2024 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521556; cv=none; b=fYvsfR/5sM+2DlHeAdWrAGfKhkdzyjBHXneyPMKQWWFMSdhgy6OeYpXmcsGrgm4eOKtT7rMQ9B3DxHqoZjpb3E9LQS1AZsE1uHJ8+/lamM34n/HHCX1fDFlUeASDdJUq1Gcei7RUvPHaheK64dMFzYfut7f46wTJgP9e5PDPLtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521556; c=relaxed/simple;
	bh=ccJcKLIPo3Uoi7CHVGNgda2ZuOhNHH9mZiG83ei00ZY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=GEF/4tNsfLJAYNmBq1qwM2cwiuWu0j8qV6NrplJ7SS3XTLFYAcvhbLZhFg70AGIJ+cwkJvYn2rV1qL3snKluA28TpddIYX9P5kphg9kbsxnOHjFf2d5Zjrf++c3R1IuHOTzR0XsUpblYB+BgK+TXCtWcpuMHV9RJYyMVodNjWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3nWU9IV; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3608ec05dc2so5573645ab.1
        for <linux-nfs@vger.kernel.org>; Wed, 17 Jan 2024 11:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705521554; x=1706126354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECRnpDkJKukiysjlOHduhjkHGU7TDAFWDSIgewEemmA=;
        b=S3nWU9IVHNU0uJ/KUmxyFMZgwKRec6fVFL72SsTMtZOkEaeK3qWzdFt4TLFVahI3Ny
         6foM9vdu+P4zs3XKigDy3YeaqUWCeVHhn7MdBBNGeaCHSJsHccw1zv/YHh0BLUwRHKO5
         goaY2Ge3QcRFCxdn7LmMhlA7jg/8R+SteSLAEXaZOKkXyOm4Ca2HmwIFTeKR4KrQzhpf
         c9wvSFIJMu0LnPoQJEDJXwvJ4NfCwICHiNbOai1f8pG9OR8DbEDI77ZQD7TFVi6A3v1r
         xe2++3dx+XGjEORtmhAyvg0yT4NnYvMxJi++Nc/Qx4pnAidFIMY5K+pxVMRvi3F476tH
         yJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521554; x=1706126354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECRnpDkJKukiysjlOHduhjkHGU7TDAFWDSIgewEemmA=;
        b=JXbUcDfqvXl3s43Ereg8INamvlJl6ZAp62FBXxMsSP7HmuAYsje4vy+Ctr/Fht2Mgd
         hV2of+mDMIEqPWThMaggeYk6pb6f5RvcMhdrn5J5BCiMRXmaeSZQLWbSaS01RudibEWi
         5plLj0+nHQCfR/WlPYa/54GxOdeYOAodhG5K2FtykJSZzw7abjnD0v0lKs1X9IW0ewx2
         YYB02iTdHRUn7WOlIayw4Eju+5giBlgXAjnqGggf8q0MH56yMpTDZKDeuDThrbFBOczm
         zR6jGhNVUzn3wtLTl2ZSE68L+BbzhyCCMhHzF8F9E6GwndOCb5h8kZPzNmQZxDzAeuz5
         VgSw==
X-Gm-Message-State: AOJu0YzoGiRv0wrU1LoEz35XP0guLjtifr3x7qVZGKPZIfWjfUt1oNdA
	bhfzIEmkbwVxUjkPH1bEGy4=
X-Google-Smtp-Source: AGHT+IHoXYxVWvXEJnsmBTD1eshz1WpFPMIb+1JZx0ucOXB9pVyn4hYriv3MV0Ovkl/2CWreLV82tg==
X-Received: by 2002:a05:6e02:1565:b0:361:9667:937f with SMTP id k5-20020a056e02156500b003619667937fmr2927751ilu.1.1705521554205;
        Wed, 17 Jan 2024 11:59:14 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:a4b6:aeb:7c5e:5cc3])
        by smtp.gmail.com with ESMTPSA id j13-20020a056e02220d00b003606da052dcsm4427459ilf.4.2024.01.17.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:59:13 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC: add xrpt id to rpc_stats_latency tracepoint
Date: Wed, 17 Jan 2024 14:59:12 -0500
Message-Id: <20240117195912.19099-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

In order to get the latency per xprt under the same clientid this patch
adds xprt_id to the tracepoint output.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/trace/events/sunrpc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 337c90787fb1..c1d500c3e031 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -639,6 +639,7 @@ TRACE_EVENT(rpc_stats_latency,
 		__field(unsigned long, backlog)
 		__field(unsigned long, rtt)
 		__field(unsigned long, execute)
+		__field(u32, xprt_id)
 	),
 
 	TP_fast_assign(
@@ -651,13 +652,16 @@ TRACE_EVENT(rpc_stats_latency,
 		__entry->backlog = ktime_to_us(backlog);
 		__entry->rtt = ktime_to_us(rtt);
 		__entry->execute = ktime_to_us(execute);
+		__entry->xprt_id = task->tk_xprt->id;
 	),
 
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
-		  " xid=0x%08x %sv%d %s backlog=%lu rtt=%lu execute=%lu",
+		  " xid=0x%08x %sv%d %s backlog=%lu rtt=%lu execute=%lu"
+		  " xprt_id=%d",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__get_str(progname), __entry->version, __get_str(procname),
-		__entry->backlog, __entry->rtt, __entry->execute)
+		__entry->backlog, __entry->rtt, __entry->execute,
+		__entry->xprt_id)
 );
 
 TRACE_EVENT(rpc_xdr_overflow,
-- 
2.39.1


