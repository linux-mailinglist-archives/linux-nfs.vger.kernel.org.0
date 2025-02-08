Return-Path: <linux-nfs+bounces-9972-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50CA2D90F
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 22:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A936A1885783
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 21:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AB51F3BB2;
	Sat,  8 Feb 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b="i50o0Q7X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from server-598995.kolorio.com (server-598995.kolorio.com [162.241.152.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E41F3B9E
	for <linux-nfs@vger.kernel.org>; Sat,  8 Feb 2025 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.241.152.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739051844; cv=none; b=uvvhmkI7+jq9qfA5YVR9c7v1GnUgtEEMUeeyFhVTOGmyVYC1rdgAUCRmXQc4uaqxZ4ABe2stbBth/Y+VE7ytJHbcTMOCTgxDqlpEw4SjyIdn4eJ8zT5axUyQ9VenPAnMZE6mGebrKY4g06OrplC2894xbVLiqA5KVwh+YNUXNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739051844; c=relaxed/simple;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mi6Ht0DcQVepSQoXxH+wXaUaNp+exSgyro0NhGRKiyPdWUSatNGcrBGLiOkufbRFuaMb9T4LHWSsx35Pd1rhh+/xoRmkgeKJcdmOomcTdqZio/yBgEjWwULTRGhshTHMBre+zfhe32ZfCbf5yLb0W/VuMtoNOdFAgtpH6Yrb3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz; spf=pass smtp.mailfrom=truemaisha.co.tz; dkim=pass (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b=i50o0Q7X; arc=none smtp.client-ip=162.241.152.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truemaisha.co.tz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=truemaisha.co.tz; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=; b=i50o0Q7XFIzu3XA5QE/FZ5gSdk
	g3jtEQG0DmWhMiWs8h/lpGn0GgicaFqBwATxHwQgnPfTNNUEoSAfCBMAu+XeaNDdCscHBvcLSwWsP
	0amPqNmO2gqIZzWhfDzIQiyB2cQdB3YEsUyZyoGGFGh+rEJBoa/6YbXBWemfeKPUhnwN2LdCkcJTL
	57Vt0Gn+yDF0eLrovahXEA0KExGjMk6wcVgawgCAtkuqU/KFa4Iu/M63okbkowsdQ0NF3TMl0hwQd
	4yS6lAIXLwdbGKbV+xMLlW+EJLaAG6tmA1F95OfHMt2kXYUsMEZhpbRsSuEq3LwSnh3qCW29c6ItI
	YbMIouzQ==;
Received: from [74.208.124.33] (port=59301 helo=truemaisha.co.tz)
	by server-598995.kolorio.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <chrispinerick@truemaisha.co.tz>)
	id 1tgspD-0004YN-0O
	for linux-nfs@vger.kernel.org;
	Sat, 08 Feb 2025 15:57:20 -0600
Reply-To: dsong@aa4financialservice.com
From: David Song <chrispinerick@truemaisha.co.tz>
To: linux-nfs@vger.kernel.org
Subject: Re: The business loan- 
Date: 08 Feb 2025 21:57:21 +0000
Message-ID: <20250208210541.D2C89F2F65B33E8E@truemaisha.co.tz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server-598995.kolorio.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - truemaisha.co.tz
X-Get-Message-Sender-Via: server-598995.kolorio.com: authenticated_id: chrispinerick@truemaisha.co.tz
X-Authenticated-Sender: server-598995.kolorio.com: chrispinerick@truemaisha.co.tz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello,

My name is David Song, at AA4 FS, we are a consultancy and
brokerage Firm specializing in Growth Financial Loan and joint
partnership venture. We specialize in investments in all Private
and public sectors in a broad range of areas within our Financial
Investment Services.

 We are experts in financial and operational management, due
diligence and capital planning in all markets and industries. Our
Investors wish to invest in any viable Project presented by your
Management after reviews on your Business Project Presentation
Plan.

 We look forward to your Swift response. We also offer commission
to consultants and brokers for any partnership referrals.

 Regards,
David Song
Senior Broker

AA4 Financial Services
13 Wonersh Way, Cheam,
Sutton, Surrey, SM2 7LX
Email: dsong@aa4financialservice.com


