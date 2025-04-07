Return-Path: <linux-nfs+bounces-11021-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EAAA7DC58
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 13:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B2C18890B4
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433CC23C8C5;
	Mon,  7 Apr 2025 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr7Rg/EC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE74C23C367
	for <linux-nfs@vger.kernel.org>; Mon,  7 Apr 2025 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025698; cv=none; b=AzobG+b2qbiTLfPMJ+SrwNt+dHOe04pI7QY6yTWGYfsNhXC91yLzCE83vuKV+Au9uFbFjoyTtQboAAnWTslZTAXR5Mwx46rvmX6fzxbA+5jcelVaOeD1igQvoyq7q3JFNj3C1U5xL5S2OTbtPW5z51VpW0nQ3RLF4DsW+rcQF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025698; c=relaxed/simple;
	bh=a+3PSzba4tRai6M/BM+U7fPXtuCevnqFwBbvwwLYN4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tkhqJYQp/buFdGeDOqdBXRfSScSI92baXeeI0eg3m6PmS6TWJERAmuVI35D9o3x2csFxXoPPKhXpJThTe1QlpwfLuNuEhpjD6JSgxatMiWGkO42F6jD2Hg9U99KFLUogW/igfraUhP4qKVQJyQrfnrfFTeJzpmLg/FH2+v6Uk7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr7Rg/EC; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso4020431a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 07 Apr 2025 04:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744025694; x=1744630494; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arsJDqhwJfphf2bVaHv3Y91glUqdzFar66XFygWxjaQ=;
        b=Mr7Rg/ECZU0nUQ3rT5RN4f786gGuIMVPSek8pP189qrOhVMy0GCdgWhUQ2r5LzLGHb
         JgmZ8M9rpkk0aspF7QlrtzEdIhP8X/mGf7js+aJiQtEeZEBWzmXZLU9/xusf0AINGbjg
         pPVn9VY+zKvejEczRcj+rumkS+WmPSy9A5Ab41QOZAlQTUuQVyOvysMn1a6Ty0j9ar74
         avYCbe16vqLMoBwoDvCwJoxsFPNMStYLkeCQy/i0TkApopYoaNWnMdE0INd2LRefJAC9
         b1ZEUMpb9U06b4BKKplzH0Pn/U7rwgC3GcIMfLaAMKROK0T6lUP9xDhwGKNPRiiAMARb
         jOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744025694; x=1744630494;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arsJDqhwJfphf2bVaHv3Y91glUqdzFar66XFygWxjaQ=;
        b=P2RRjz5Va7oLG1ExDbawmefQhFCcP4ysJVVy0Jctz+l+19YJWVW9pvUwbVTbQg3XMr
         YKI2oswlM4uCldJp6a5BQI3NzvZb7Z0CGiwmfaakw3d0mCRaKOEhmtVy6pfenD/rKquj
         XhpeFzj+H8BBR15rAV9kzswEoD6daeGVvsq1EM3bZ7qZvZ72qaGpYNVfisATZ+wRcSm+
         EnfzquX2Oq/lgDab4ciS9agYR3bgHS9lgfrRsz6I+EbZ9cRRJAxA3/wCYUi9UzrFFJs7
         pR7xc2YwB0iSi7XDjbkEUBKDuzCvzXMdfEYrX8pJBdiqdRyCbjQ3yx8tf9fJvPyvvXb2
         h20g==
X-Gm-Message-State: AOJu0YwzV1QZVLQxcp6tSDSu1NHLBvVTIAL2SPiSvWHSFsqmhnBPaPUY
	qGgXeMUE+7Fy1svnwxjuraWNcZO8nEDrZCXOfjQ+U4YLjEcav65HGsdN/OFvGbfyLzeFqV2rUYZ
	12VGyAQFbmCYOPkOsljmjAdpdaQaVJjqq
X-Gm-Gg: ASbGnct0BQjVuWUZwGBNjw3fZtFmM0a5Ttx5d2maMX0ZZk3dWNsvXewLPB9r1SnKHqE
	vkjM7tDbQ97ZmW7vD6kRgmzmuWhR0anQz0fPppdBzrKb45JobFnwmyjO/fveWOMoqy3F7Q1PR5d
	ecQW5JgaL9n4iY8ecwiDAjovy30Q==
X-Google-Smtp-Source: AGHT+IGDSJMjZdPlrONRC7uIe9BgfzmrV2nXp/LHsmAMZMyeYsFPr8pb7DApUYRwezrahDnaBSzptrx7zKb3CkGdSP0=
X-Received: by 2002:a17:90b:224d:b0:2ff:4f04:4261 with SMTP id
 98e67ed59e1d1-306a48b308cmr12265815a91.34.1744025694532; Mon, 07 Apr 2025
 04:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdddwbzGUUzKdbxpb-yC-FVMhbdcd-P+OLSDNvjZeByGw@mail.gmail.com>
In-Reply-To: <CALXu0UdddwbzGUUzKdbxpb-yC-FVMhbdcd-P+OLSDNvjZeByGw@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Mon, 7 Apr 2025 13:34:18 +0200
X-Gm-Features: ATxdqUEAjQK_p0ZKjXeaJZ6vASm4XG4S1p1OuyepbWnv72TlhQWptGPiG4FZVGQ
Message-ID: <CALXu0Ueh2uLMJUimG8ngFaW=soxvQj4ZaakmgpGZn5BRSWvMHQ@mail.gmail.com>
Subject: Increase RPCSVC_MAXPAYLOAD to 8M, part DEUX
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Jan 2025 at 11:07, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>
> Good morning!
>
> IMO it might be good to increase RPCSVC_MAXPAYLOAD to at least 8M,
> giving the NFSv4.1 session mechanism some headroom for negotiation.
> For over a decade the default value is 1M (1*1024*1024u), which IMO
> causes problems with anything faster than 2500baseT.

Chuck pointed out that the new /sys/kernel/debug/ subdir could be used
to host "experimental" tunables.

Plan:
Add a /sys/kernel/debug/nfsd/RPCSVC_MAXPAYLOAD tunable file,
RPCSVC_MAXPAYLOAD defaults to 4M, on connection start it copies the
value of /sys/kernel/debug/nfsd/RPCSVC_MAXPAYLOAD into a private
variable to make it unchangeable during connection lifetime, because
Chuck is worried that svc_rqst::rq_pages might blow up in our face.

Would that be a plan?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

