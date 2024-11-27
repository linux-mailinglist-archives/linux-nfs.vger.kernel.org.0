Return-Path: <linux-nfs+bounces-8239-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B62C39DACF8
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 19:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA34281DD5
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 18:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02DB1411C8;
	Wed, 27 Nov 2024 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cipixia.com header.i=@cipixia.com header.b="F/vbQ0TN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.cipixia.com (mail.cipixia.com [5.78.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F321338DC8
	for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2024 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732731782; cv=none; b=PhYy4auKJz5CTCwItrdBk6FF0qBuUtqTTVT4fmf34JnZfLgR2FjNzOLS3HC/9E82Utau2AaS+PCmwE9J9TGJjCigJUzMFI3CtpJpMf6BARtBUoMwRhGdRw4bLEsdvIgCjij5lGOmbE++o5mAdkzJ2IRYvEOxTwziWFbJtUkUsHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732731782; c=relaxed/simple;
	bh=HTWPNZhucgcb4cwPdBUfaEzGmWm4hkmJcjNs0F6MLKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DuoZcBRO5yVZKOxzOhi7FKEOJI9xe7Vav9gemmxdZLSiuGax7EPzFX093qyVcCdIrc3YxIObp9iiaa2t/hMaUPFUNb0BQIb0SrVASN96MbjQMXCmbKgiBS5oIgSZfIS5HR+i7yOAjHt8gpyR8WoOXeYPAlAMOX7TSD3RQwrp9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cipixia.com; spf=pass smtp.mailfrom=cipixia.com; dkim=pass (2048-bit key) header.d=cipixia.com header.i=@cipixia.com header.b=F/vbQ0TN; arc=none smtp.client-ip=5.78.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cipixia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cipixia.com
Received: from originating.ip.scrubbed
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	(Authenticated sender: matt)
	by mail.cipixia.com (Postfix) with ESMTPSA id 4Xz71h3Fstz10g8;
	Wed, 27 Nov 2024 11:16:40 -0700 (MST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cipixia.com; s=rsa2048;
	t=1732731400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVv3YhlkuYBur3vYeExh8Xyxp8eitJevLqUmbexsgGM=;
	b=F/vbQ0TNrx4Tt9VAN+DEMyeFSGbi5J6JCgKTS+aXOiPJz9eHk2AqykkeHOwvyMWICiY3jw
	WfA/8UvMMkDobOQkuVErPInc6fM3hL66rwHKV/RZu2fZgRK5H8w3EWKLcG/sXOh26XgbKQ
	YIWcoDo2HgsbHs/rs4jkT+S1wZkHyC1+WKyD70xNLQ4Wz1kENNkUnydcPKwEsC7dlvpAdA
	LSlpe00IQXs4zBNS6YIJY+cUHt3UDI+ovlhShUvu1R/rfCja8N+tldHdK+2ZpPg+sDW3mH
	aQD2mIaHLQf0TWUx1xSYQeQU66kzi3g7lu8lv2ctBKLSqcNZ69Yoc1aqitHTkA==
Message-ID: <98f00c1a-8ecc-4d7c-ae42-6c9d6a6edac2@cipixia.com>
Date: Wed, 27 Nov 2024 11:16:39 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SELinux-Support in Linux NFSv4.1 impl?
To: Martin Wege <martin.l.wege@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CANH4o6P-jze6MB8yh3sWxhyHJWdj+JHK3vw58cYwQ0a7eVe_Vg@mail.gmail.com>
 <c397fb11a172be26111e1ad5cb17a92bceb065d3.camel@kernel.org>
 <CANH4o6O-Gcjc3eqiTd-KysZx-bpbzoh=CMTNixJ26cZQuRd=UQ@mail.gmail.com>
Content-Language: en-US
From: Matt Kinni <matt@cipixia.com>
In-Reply-To: <CANH4o6O-Gcjc3eqiTd-KysZx-bpbzoh=CMTNixJ26cZQuRd=UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-17 at 06:37 (-0700), Martin Wege wrote:
> Is there documentation on how to set this up? Will this work if the
> root fs ('/') is NFSv4.2?

> 

Hi Martin,
On your server's /etc/exports add "security_label" like so:

    /srv  *(sec=krb5,security_label,ro,fsid=0)  (example)

On your client, make sure it is mounting with nfsvers=4.2

Run 'mount' on client to confirm "seclabel" is showing in the output,
and you will see the labels coming through with ls -Z


-- 
Matt

