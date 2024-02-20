Return-Path: <linux-nfs+bounces-2033-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C12E85BF61
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 16:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4481C23F23
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF7F6F51C;
	Tue, 20 Feb 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="L7ZocuMH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4hRYcHo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA55B73195;
	Tue, 20 Feb 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441321; cv=none; b=epJmGfkalyI+/usuqT5nFJAof1a6EsjPwzmB9bIOrp+Odv0EU6+27aP4lv+7OOImtvJMS6qFoIAluKAtUJ1u8KWpCHdmIhF8RqGKgIKkEUreoOS7YXHs2rGRBhTcwveFCf6r1S6NEqmVCZeJJJuyb2grAIqK2821AsI9smP6TJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441321; c=relaxed/simple;
	bh=9GeR/CwHP1RIcgU4N/ypsMlpJSyQy5ZZKFMYAfJ4xbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAkb8pmHpUExaaCLEjPlbwdzxN3WSezPp/25IAKLIeg2dVPCtrO2+TOxqgcOE3uoxuPZ6N+wOQaJLZ6kGC4uOgndqKwI36Ty3gVo7DBC1LHSj644WZi2LLEgYKy2xu7hnKPNcSWhNK/02VqxNGSFMR6BO5WQf5jQQWEL7UoWKRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=L7ZocuMH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c4hRYcHo; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A2DEC5C0069;
	Tue, 20 Feb 2024 10:01:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 20 Feb 2024 10:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708441317; x=1708527717; bh=6b2zo/y42R
	BG9GeiQ6mTYTb92YHND5HvY52dacr6AVQ=; b=L7ZocuMHu8xURJpiHccuq67ZmS
	YNA+9e61mNhcASCrzIw2vLztDSkAdHbMqFlLYREaLbx1quM7480WcDCQ4sULxQTZ
	stQQZGc9Dhz8epl28bLIe3n/+KqHXhH4FyWs5tQ5fRjSPHhGe6oZGn66m1+c4Zd3
	gJlHAfvyxdwPMg8EMmfSJbgeW+bHwAz0XQKqmR60LkHW3JmqO/dTdRjwQGA+GfL6
	RfEQNmnr5Zi1c2RRq9uuzQwmGAct2sF2ppoHkfXan52LjAJCE/uFGpREd72zVUWY
	TbRJl8WuzNzgUYnMF9dSACewIh7OUpi82taqmiwrmVSEcQa+cFPN8iGjLlNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708441317; x=1708527717; bh=6b2zo/y42RBG9GeiQ6mTYTb92YHN
	D5HvY52dacr6AVQ=; b=c4hRYcHojXucaP/GqfHtOVdtvWjhWFRZIqnMvGcDqy0z
	2OloK+nlTmxMMXY1C6+oYfPzeeGWu8RXLIb6tYxgH448ozJjfdMJHQIifT/rDJwB
	TMSSGeGVMgY7rH1Q80E7kP47LSz/vqwtQmhP57GeEGNvhHo6vmY+PjR3h/a+wL/Y
	UYuqZdwk+CprWjdh1SkkRF/Zuc8DVOOjCM5/JwKKpz/uXnIck5C4Z+MnxECV+KtB
	d4v614Ix+7Hs6T8/XE8av7ohrQIQD8s5S5qY4T3EPZWCx+DA8wo4aMkHm/1FaSZP
	CI7eFDshLywEOaM41foRISbHWn7eLXcPLqyle7fHwA==
X-ME-Sender: <xms:5b7UZTxHqHqvZCV3xQiat-6wrUDmw3RGm7INNJx-q-FB_P2U1Ve9Ug>
    <xme:5b7UZbRY7GQQqJAXW7uDFdKlqjCriOzD-8gZ3cx7QQmrXMivyAKIcxHY03nqgiwj1
    ZjvjvBtJ71_cg>
X-ME-Received: <xmr:5b7UZdXUoyWkn-3MVOAUqAq0gSHwWX9rNMBe28k4OKq4D9qD4iH7_CQ34qr3_CF0GkIg9Q6FtAJj30SaVYSUdrNxQ-zFuqqOuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:5b7UZdhoOGeR9caR0NtAyPZBECbIk3WvREhs5FobWWgorcek0dp1Bg>
    <xmx:5b7UZVB4mtR04by5pKj1ac5a7o3DeNCCwCTx8HRPoQG8FWHFR_eXSg>
    <xmx:5b7UZWK2gxhfr45_RPtnf6g3UzOuaBaOPTPlHZIt_v2NZpCv4vs5zA>
    <xmx:5b7UZfB3rRwoGGXeNwqwPtWeCxQiFQITVSyrSoyqaVQVRw1PCVJeSg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 10:01:56 -0500 (EST)
Date: Tue, 20 Feb 2024 16:01:54 +0100
From: Greg KH <greg@kroah.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@redhat.com>
Subject: Re: [GIT PULL] NFSD fixes for v6.1.y
Message-ID: <2024022033-outlet-unable-8932@gregkh>
References: <ZdS8TXWl3QKf0qdk@manet.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdS8TXWl3QKf0qdk@manet.1015granger.net>

On Tue, Feb 20, 2024 at 09:50:53AM -0500, Chuck Lever wrote:
> The following changes since commit 8b4118fabd6eb75fed19483b04dab3a036886489:
> 
>   Linux 6.1.78 (2024-02-16 19:06:32 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git nfsd-6.1.y
> 
> for you to fetch changes up to d432d1006b60bd6b5c38974727bdce78f449eeea:
> 
>   nfsd: don't take fi_lock in nfsd_break_deleg_cb() (2024-02-16 13:58:29 -0500)
> 
> ----------------------------------------------------------------
> NeilBrown (2):
>       nfsd: fix RELEASE_LOCKOWNER
>       nfsd: don't take fi_lock in nfsd_break_deleg_cb()
> 
>  fs/nfsd/nfs4state.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)

Now queued up.  Note, the second commit here also was needed for 6.7.y
and 6.6.y, so I've added it there too.

thanks,

greg k-h

