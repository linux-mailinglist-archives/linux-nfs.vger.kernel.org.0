Return-Path: <linux-nfs+bounces-5023-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AF593A843
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 22:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAD71C21BA3
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 20:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EAC13DB9F;
	Tue, 23 Jul 2024 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=trodman.com header.i=@trodman.com header.b="qC4GnJRc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from xklwu-2.xen.prgmr.com (xklwu-2.xen.prgmr.com [71.19.154.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B22E634
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.154.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767532; cv=none; b=keCBa7dyIfIbmLdvu+FOavMFrjFLuSJVVNo57cvzFiZEZ1eVh4cI7zkryDi7La1nWBQsRlr4nJ6tRGZqS9ejyeFzmkshRGj5e+WKldXV7k/rsCWgQVemSYWKHW+f0aiS2bAXKhGRjtuULXVticyLC225l4BygFC0hlWG0BoW/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767532; c=relaxed/simple;
	bh=nHkfhNvR0a3Ra2p3LrQq4apIzMv9izMScgXvPjopMPI=;
	h=Message-Id:From:To:Subject:MIME-Version:Content-Type:Date; b=fl3i8cXrE7btn6HA9zJzq1UP8QVeuVKFKTicw8KOdTcDJm0EkM2JlV/fuXsEl4yPZz0Lr/UEC/W3w7u8MLWwOEN/TXiOXZ4wM0wUye6Z34/fMnJPEuc4KZkSp29vlGrj77LQYM4ixvTvuwWfJycF00IXhNhD13fxaNjF5L9mleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trodman.com; spf=pass smtp.mailfrom=trodman.com; dkim=pass (1024-bit key) header.d=trodman.com header.i=@trodman.com header.b=qC4GnJRc; arc=none smtp.client-ip=71.19.154.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trodman.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trodman.com
Received: from epjdn.zq3q.org (epjdn.zq3q.org [71.19.149.160])
	by xklwu-2.xen.prgmr.com (8.17.1/8.15.2) with ESMTPS id 46NJrpEo047072
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 14:53:51 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 xklwu-2.xen.prgmr.com 46NJrpEo047072
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=trodman.com;
	s=myselector; t=1721764431;
	bh=A1HbTKAfa/jbGNmjzN7inLFbvfgiTSEQPLDOxKENvpk=;
	h=From:To:Subject:Date:From;
	b=qC4GnJRcPPoMQjMAM58XLeH+okaZDEUMfzyzjzUZ2/wKMMvP9gfnoHcVESW60nCpA
	 fxkLPfzPYFXGyx68BaMJ5Wrr5lUIbXb6tZlGWAgoM+mH0ikA8E5uNj6uoQ41Fqv9q0
	 Pc8h2OB7uTJtCV+N0iOX7AX/0r6jLRSwRaSiZ6mg=
Received: from epjdn.zq3q.org (localhost [127.0.0.1])
	by epjdn.zq3q.org (8.17.1/8.15.2) with ESMTP id 46NJrpWr3811115
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 14:53:51 -0500
Message-Id: <202407231953.46NJrpWr3811115@epjdn.zq3q.org>
From: linux-nfs@trodman.com
To: linux-nfs@vger.kernel.org
Subject: recipe/example for nftables supporting Internet nfs4?
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3811110.1721764431.1@epjdn.zq3q.org>
Date: Tue, 23 Jul 2024 14:53:51 -0500

I have a fedora server on Internet sharing out NFS; working ok for 3+years w/firewalld.  I'm going w/pure nftables on a new server. Does anyone have a recipe/example for setting up an NFS server using nftables?

thank-you

