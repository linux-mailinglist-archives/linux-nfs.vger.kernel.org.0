Return-Path: <linux-nfs+bounces-11294-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6961A9DC49
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 18:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17236171A8A
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 16:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C871F1F181F;
	Sat, 26 Apr 2025 16:44:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0531A08DB
	for <linux-nfs@vger.kernel.org>; Sat, 26 Apr 2025 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745685899; cv=none; b=i8szsOBGAk9pbOeHq9wPVoFhrRokHmV9pvkCsjP6edhPPJh3wQ569Jmfjy7Zz+q5t0LY5oS2kFo7f2un+kU8EExXbIHim7BN+uIuxAeB6p2C6vJahY0flRnjOa4uXUszO7ulewyM5nkIMJ+HWb9MOh9Iu2v3L4NiUmZnZ0NEjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745685899; c=relaxed/simple;
	bh=fH/ZYvYo0f1GHut97hWbZfO562AtTjFjFXnVMQuplaA=;
	h=Subject:From:To:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lacm5XC/20wVGcnbfrMDQ7QlGeQiFsiAhjGL67bm9ZxKhmAunAcO2TlZX/ljDE9qLqXvKHcp1fXwm93xPyKOdauvLvRo4OggxJ+F0cfoF6CkLyMHA3iU2E05w9fXn46N+hIDI1v/S+l9HWcsDd00xgW9IQrupJfvVYaN13MxIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 4452 invoked from network); 26 Apr 2025 16:44:50 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@62.158.99.252)
  by mailout.selfhost.de with ESMTPA; 26 Apr 2025 16:44:50 -0000
X-Spam-Level: 
X-Spam-Report: 
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -1.7 NICE_REPLY_A Looks like a legit reply (A)
	*  0.0 DMARC_MISSING Missing DMARC policy
	*  0.4 KHOP_HELO_FCRDNS Relay HELO differs from its IP's reverse DNS
Received: from cecil.afaics.de (p200300e31f37680268fdfffffe6f0e76.dip0.t-ipconnect.de [2003:e3:1f37:6802:68fd:ffff:fe6f:e76])
	by marvin.afaics.de (OpenSMTPD) with ESMTP id 8b1acb0c;
	Sat, 26 Apr 2025 18:44:50 +0200 (CEST)
Subject: Re: rpc-statd.service: State 'stop-sigterm' timed out. Killing.
From: Harald Dunkel <harri@afaics.de>
To: linux-nfs@vger.kernel.org
References: <506d5e52-87dd-038e-7a52-7dcc1b8c3427@afaics.de>
Message-ID: <35f8aa38-5f09-312a-86f5-0d07aded4c5c@afaics.de>
Date: Sat, 26 Apr 2025 18:44:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.20
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <506d5e52-87dd-038e-7a52-7dcc1b8c3427@afaics.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

PS: I missed to include the list of restarted services

  systemctl restart avahi-daemon.service mdmonitor.service nfs-blkmap.service nfsdcld.service rpcbind.service rpc-statd.service rsyslog.service smartmontools.service ssh.service systemd-journald.service systemd-timesyncd.service systemd-udevd.service


