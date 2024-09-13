Return-Path: <linux-nfs+bounces-6468-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B89F2978941
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 22:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6327B1F247DB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 20:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39242146D53;
	Fri, 13 Sep 2024 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+EENvJQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1501A126F2A
	for <linux-nfs@vger.kernel.org>; Fri, 13 Sep 2024 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257909; cv=none; b=DCDEIIFXnnq7kHrYTkk+9DX82PNPQKnilJ9I+jVO51LdRge5SmKe14oh4ECyy0J9beMTWZNLBOf8eh1InB6ouTsR9AM8Y+K6khmH3ljccLRUuSczE7qFC9M5UdYt8/FT22m0iZ0gnUc6E5HmZaeWl6cHdCwbsYfdI+1D09bwYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257909; c=relaxed/simple;
	bh=0MqXwAJEnMe3iair5B3Mb7HUs5pUMkyj7wx4DQ6llEw=;
	h=Date:MIME-Version:Content-Type:From:To:Message-ID:In-Reply-To:
	 References:Subject; b=H+e9TLRBQr6KTw3X0JkI7nudMgyE/iZpePlzoOLkNYb6Ps6cnXxM3Yk/PeK0S6cfygJRIXZZC7t9GpYZSrKREiIuxe+jdWidlzQS8AwmWasp0n2158azoAfwM44x/HgVdayX4Fsm5lo3vd63SMBqP9XJ02fP1VZMcgPHfP4KSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+EENvJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF820C4CEC0;
	Fri, 13 Sep 2024 20:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726257908;
	bh=0MqXwAJEnMe3iair5B3Mb7HUs5pUMkyj7wx4DQ6llEw=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=a+EENvJQWz6PG5vh9N/R+2Yh5AqQHrdOdmjXb50XRsOq9e2yJLQE7UPQNR1BU5ubb
	 Ed3fxg5I1oLl34z/ysEZ6HSs3UIPBOJXdEL2JK6H2wRXEGrxFRj9tBl8ZqXaIwLyJH
	 vUu1iIu/Lu0iL6k8oqx8MNW5pLzJdNla8HpVr7bww+h5mSfGWlMmjVA7NCTKXvurAZ
	 X+ugdXC16Nu5s2gD1MqjWvsFkzlly7BGfBna7v42ro/5E5ejS43Da0Z2abMVQSP6Be
	 SULlWx1HSeK4XstwqgT85sWgWq7I6jJFIAmeJdZxGJH19Cv59V5+Ww64Bk3eFbtYJZ
	 0u3LI+FjUbN2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717CF3806655;
	Fri, 13 Sep 2024 20:05:11 +0000 (UTC)
Date: Fri, 13 Sep 2024 20:05:08 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From: Bugspray Bot <bugbot@kernel.org>
To: trondmy@kernel.org, cel@kernel.org, jlayton@kernel.org, 
 linux-nfs@vger.kernel.org, anna@kernel.org
Message-ID: <20240913-b218735c1-b1334cb7375b@bugzilla.kernel.org>
In-Reply-To: <20240913-b218735c0-12465843fe68@bugzilla.kernel.org>
References: <20240913-b218735c0-12465843fe68@bugzilla.kernel.org>
Subject: Re: NFSD callback operations block everything when clients are
 unresponsive
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

cel writes via Kernel.org Bugzilla:

A little code audit:

1 fs/nfsd/nfs4layouts.c  739 static const struct nfsd4_callback_ops nfsd4_cb_layout_ops = { 
2 fs/nfsd/nfs4proc.c     1622 static const struct nfsd4_callback_ops nfsd4_cb_offload_ops = { 
6 fs/nfsd/nfs4state.c    399 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops = { 
7 fs/nfsd/nfs4state.c    3079 static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = { 
8 fs/nfsd/nfs4state.c    3084 static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = { 
9 fs/nfsd/nfs4state.c    5182 static const struct nfsd4_callback_ops nfsd4_cb_recall_ops = { 

We have these five callback operations to deal with.

I think the ->release nfsd4_callback_ops method might be used to schedule retry -- it's invoked by nfsd41_destroy_cb(), which should be able to tell whether a reply has been received.

Now I just need to figure out how to keep a record of needing to resend a callback.

View: https://bugzilla.kernel.org/show_bug.cgi?id=218735#c1
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


