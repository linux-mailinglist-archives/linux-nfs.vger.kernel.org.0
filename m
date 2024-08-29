Return-Path: <linux-nfs+bounces-5943-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C201B964546
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 14:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B7928B5E0
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 12:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5061AED4B;
	Thu, 29 Aug 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h55UpAcy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4931B6546
	for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935460; cv=none; b=lpuiKZSr1sp56bWZduEEv1iU9M73T2lXIa2aKuZt64kT1f3MLkqZstVNiyEozVq0o0H7O95NGIscWFwiwbhYo/Sl99sUaeIhhSLyRPN3u5trfU7iqMD9SbxNswmwv8AvaN+E54FIv5/AUF1XTXtVIxZwi7HsrSb2vjv86OgEolo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935460; c=relaxed/simple;
	bh=HHuonF1oEe/Y2Ul/uDmcLYg2f+WcagZuJH+MJBEXQGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O53csrJ4O9XCLXpY/VNdFwhYG/l3lxIuIWlBN/dwPE4YcpZk5CcCE9F9sgis7t35jNb34nNNjcD3/kfaWJGYGohmoqreZrZ5li1iosKwp8TdclDLEhUoaSf5rx0cQltuLlfDtWEHUo12OL29ErOEpaFcqypa5kJ25mxlCXaS4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h55UpAcy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724935458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hTIUxF4Rn1qlWGBgMUHpoDR+M8wpqIswnGdRfKuZhF8=;
	b=h55UpAcydMbi2TQsynvpxZ0vRBLNj1agPq3L7nHoJoJe0IMefeUPOXXzDeFzmTfYst7iE7
	j4beF+qx6dwQtfqZwDdwl3RMV76j3gtAYyEnk5/UbIF8/255x13IPzoajFC9I8KTzXQH2V
	C2OMdEMVLYjKhYIwgrTd1zRTkZnJ23o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-UNHfyUA1PyekUOV4evgImw-1; Thu,
 29 Aug 2024 08:44:14 -0400
X-MC-Unique: UNHfyUA1PyekUOV4evgImw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AADF11955D56;
	Thu, 29 Aug 2024 12:44:13 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B871B3001FC3;
	Thu, 29 Aug 2024 12:44:12 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] NFS: Fix missing files in `ls` command output
Date: Thu, 29 Aug 2024 08:44:10 -0400
Message-ID: <D27B60B1-E44E-4A89-BB2E-EF01526CB432@redhat.com>
In-Reply-To: <20240829091340.2043-1-laoar.shao@gmail.com>
References: <20240829091340.2043-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 29 Aug 2024, at 5:13, Yafang Shao wrote:

> In our production environment, we noticed that some files are missing when
> running the ls command in an NFS directory. However, we can still
> successfully cd into the missing directories. This issue can be illustrated
> as follows:
>
>   $ cd nfs
>   $ ls
>   a b c e f            <<<< 'd' is missing
>   $ cd d               <<<< success
>
> I verified the issue with the latest upstream kernel, and it still
> persists. Further analysis reveals that files go missing when the dtsize is
> expanded. The default dtsize was reduced from 1MB to 4KB in commit
> 580f236737d1 ("NFS: Adjust the amount of readahead performed by NFS readdir").
> After restoring the default size to 1MB, the issue disappears. I also tried
> setting the default size to 8KB, and the issue similarly disappears.
>
> Upon further analysis, it appears that there is a bad entry being decoded
> in nfs_readdir_entry_decode(). When a bad entry is encountered, the
> decoding process breaks without handling the error. We should revert the
> bad entry in such cases. After implementing this change, the issue is
> resolved.

It seems like you're trying to handle a server bug of some sort.  Have you
been able to look at a wire capture to determine why there's a bad entry?

Ben


