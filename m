Return-Path: <linux-nfs+bounces-7197-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20839A08A5
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 13:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30D1281387
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92B3206059;
	Wed, 16 Oct 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFJMihhl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E23204F9E
	for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079315; cv=none; b=ZC35jJ6L/001UomBvMzqNdF517b31j22ZPg48xjG08zuGZDn16QZZuVlM5XhYK2w7bfuc92TeigUCPVPCIo3bTO6vjYk5TTWbENhn+EN4JU/JSDqqEOqHOPJd08Rcl8RPez7ypBgeQFD4WPAV5tuLHE/NBOHWqZB84QgaDDJPiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079315; c=relaxed/simple;
	bh=lvpVYFs34PepvjpPlaJ5vM18KiAWkvPGmG7W8BaYVqI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=To8Zm5ZUv9eAOJgATPtStGrewR6OqIKWUfTexa/D2Gp2iCPxb77plV8yUD28s6mCWoP2pb5UPn8oOLCw7X42N0RL3eV5jgajclKeSOH5A+szuoc17bGGNejAMVfRgjifSdr5wM809qXYZ8UyhqVCsjfdrdymR6WSmFzu2IdB0GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFJMihhl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4fd00574so568726f8f.0
        for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729079312; x=1729684112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Y6BqjGpxglIg0aVJLSHzaLYU+Tno0Kqngva9AKJI4k=;
        b=VFJMihhlrSjgoiiD/fBp3hDhLeO/EJD22IHS6Ys85yCH7/cJNpk19kyWs9yBzgqp9K
         tb4/wWvQmp7uTrmNxP2liX07EDtM9Kz8HXuJ8gsy6Mj5/MrOd67BJxia7IcJUehH4kgV
         ALA0uCk+sHJQqk6sFIpjkdsbc0GkuLYmBi0HYl8rEmTlK71gm//8GCPokJdPzjz4CD5f
         yEoTzfyWDojVSLQC7V13TMW/CQONaJFgP1cvvgxPhkKgVIMHOOXTdJJ0zfGef1s6uFf0
         xaAcp1V3MDfTceMXA0+zVFEzkO8fSIDkDSWjxC4XptCM0pMJLVsSM1fxuOfwjqboGfl4
         nbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729079312; x=1729684112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Y6BqjGpxglIg0aVJLSHzaLYU+Tno0Kqngva9AKJI4k=;
        b=kHqdOhGcJFzEZOlZeJRq6QROp0GNUDXdgNs8FoSeHVlM7mHGst/y4cFUygcJJP7r0u
         mzDN8v+sySQwvR1SAvxRr8hHKWA7rWV0rfT9jS8lD09kRs8oHqX5QFzlPrLuhxzt9rzH
         7p4Sv3i1nxLWLLYrQDzySaiRg/aVFpbmF3rDbUBdre7r/Zcm7BZSiML5++wp3MzrKVsF
         kvXKrgbY8doPoYSazXEcA5vAhAd/VJpSTG73EJIpPt3M4If8nmdnSo4+BDHiXI4aVdC4
         ncEByUK+Xm3YZG2UhiM+nVFIQ4yWIVIRpzvumWPWQTvjj6o8dvK5fQMUO69MudEyLkKd
         lb0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPI1LGxTNQeThYSzEU+Da+xssg84gXWUajWUevDdLjqwCsA2vyUh+3UiXDlVnG8ILs9BaVgwfwng0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQEkuNiTbI4KkmjsUECEBRCKsSC+P33Lyy8u0gdMTZbI98VtY
	50dHqSUtuCNIL7UOc6hvf9P88JPlXRU+nwp9SPSv3buLEZ4l7m0hgsblNQ==
X-Google-Smtp-Source: AGHT+IEjj/RBpz7lsVZPxhUp0WJIZvAw877/n52/xi0IVYfvYevKkZpQ7WRhu664t/rQQax0co9H+w==
X-Received: by 2002:a5d:5350:0:b0:37d:2e74:2eea with SMTP id ffacd0b85a97d-37d5519cbd3mr13713854f8f.5.1729079312305;
        Wed, 16 Oct 2024 04:48:32 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc445fesm4109430f8f.113.2024.10.16.04.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 04:48:31 -0700 (PDT)
Message-ID: <a25b8ee2-46c2-4468-8ebd-edbc40fc7417@gmail.com>
Date: Wed, 16 Oct 2024 19:48:30 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-US
To: Trond Myklebust <trondmy@hammerspace.com>,
 Chuck Lever <chuck.lever@oracle.com>
From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [RFC PATCH 5/5] SUNRPC: support get_srcaddr and get_srcport for
 rpcrdma
Cc: kinglongmee@gmail.com, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 net/sunrpc/xprtrdma/transport.c | 51 +++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index fee3b562932b..e2860632102a 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -442,6 +442,55 @@ xprt_rdma_set_port(struct rpc_xprt *xprt, u16 port)
 	xprt->address_strings[RPC_DISPLAY_HEX_PORT] = kstrdup(buf, GFP_KERNEL);
 }
 
+/**
+ * xprt_rdma_get_srcaddr - get the rdma local address, without port
+ * @xprt: controlling RPC transport
+ * @buf: address buffer
+ * @buflen: the buffer length
+ */
+static int
+xprt_rdma_get_srcaddr(struct rpc_xprt *xprt, char *buf, size_t buflen)
+{
+	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
+	struct sockaddr *sap;
+	int ret = -1;
+
+	if (ep && ep->re_id && (ep->re_connect_status == 1)) {
+		sap = (struct sockaddr *)&ep->re_id->route.addr.src_addr;
+		ret = snprintf(buf, buflen, "%pISc", sap);
+	}
+
+	return ret;
+}
+
+/**
+ * xprt_rdma_get_srcaddr - get the rdma local address, without port
+ * @xprt: controlling RPC transport
+ */
+static unsigned short
+xprt_rdma_get_srcport(struct rpc_xprt *xprt)
+{
+	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
+	struct sockaddr *sap;
+	unsigned short ret = 0;
+
+	if (ep && ep->re_id && (ep->re_connect_status == 1)) {
+		sap = (struct sockaddr *)&ep->re_id->route.addr.src_addr;
+		switch (sap->sa_family) {
+		case AF_INET6:
+			ret = ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
+			break;
+		case AF_INET:
+			ret = ntohs(((struct sockaddr_in *)sap)->sin_port);
+			break;
+		}
+	}
+
+	return ret;
+}
+
 /**
  * xprt_rdma_timer - invoked when an RPC times out
  * @xprt: controlling RPC transport
@@ -768,6 +817,8 @@ static const struct rpc_xprt_ops xprt_rdma_procs = {
 	.rpcbind		= rpcb_getport_async,	/* sunrpc/rpcb_clnt.c */
 	.set_port		= xprt_rdma_set_port,
 	.connect		= xprt_rdma_connect,
+	.get_srcaddr		= xprt_rdma_get_srcaddr,
+	.get_srcport		= xprt_rdma_get_srcport,
 	.buf_alloc		= xprt_rdma_allocate,
 	.buf_free		= xprt_rdma_free,
 	.send_request		= xprt_rdma_send_request,
-- 
2.47.0


