Return-Path: <linux-nfs+bounces-2944-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3096C8AE5D1
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 14:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC1B1F24849
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009FF85622;
	Tue, 23 Apr 2024 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZYFSooA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2960C7D3E3
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874602; cv=none; b=HUdOLD/I99ZwILaa+90GlnGGesaKFZWvHLcLyajQ8yGFT+hw5GVfQjzHiWD/YiG+4oxBtYQ6hQdm9QqCRJ3LL3Tl+rCNqsBzWi+5oR6t2LsPtfLyWS0nk58bSSpJlfe7t9fJIb5sTP9ClLfgMsu4DddP1Lny1b97JXQaqlE7DGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874602; c=relaxed/simple;
	bh=PB/4O81cG2OtnhGgNDkEmwFuS6XIQCsjxNvhzEKY8Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type; b=d20y/VheTwewZF/W5ndsB64vRuDUFFEv4ceR0wZsY/8DAiZYzmd1gJekspnJUbd6VNqs1DJNvcsAK/zZtxw+8lCcmzV7TuN2I6pe9+yfRy9/dqsUrBEYUX2A8fSM+A5VpZbB8KAMVGa/o6SJl0sQ84d8GdPgkQv2m1+eGr/i9y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZYFSooA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713874600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cnz90Q1VOlkMVrNMG/GaKm6Vi6bbViOQhgdhsdlyTyQ=;
	b=OZYFSooASVRIVcCCXhEnCmPuH4jGF9HSB5mEashITiFcglgwUfShJuH2CY/PAxkmUuQwmx
	02tgc3i4clUGT/8kcbHj0MdKpRrSo5Z0Hk+p5kjhgxgpOZrwJIjhPokfWemTvhigcsmqg4
	vjzK09SUdUB+KUev6yqb/61veaNOmXc=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-K8pDuDr0MfG2BuRTPBXN_Q-1; Tue, 23 Apr 2024 08:16:38 -0400
X-MC-Unique: K8pDuDr0MfG2BuRTPBXN_Q-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5aa4703e105so366478eaf.0
        for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 05:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713874596; x=1714479396;
        h=content-transfer-encoding:from:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cnz90Q1VOlkMVrNMG/GaKm6Vi6bbViOQhgdhsdlyTyQ=;
        b=ZnknYK+KuqkUl9+MDE3b1Ujhwmy4cajuOJzYhj33n73ezgN550EOHx7PincUk5ZSEV
         aGJCs0V1/aqdQ7rEjGBovSdGIp2A+hluxpr55XKkjpLBqBIPraSCBB8VbSKDtqYQ/OVH
         Nz/Yxp4qjdQcjcTF5M9Duaq//nUZ008eL1IE8FqOHHUd3ElFZCYumzgsECzOPJ7lAx/v
         bRFu7EnZsZjW8o20KAn1DFsVUpQlemrbt/jiGvKTfTafJqHzdQbN9jUSSbESQiiC+kVF
         T+fDOtUOz8et4dNzzRXY1pdWioZLpt1uezj1X9VC2PKJbBulyrBh2Ve8UJYPqbW+Yc6E
         18aQ==
X-Gm-Message-State: AOJu0Yz5ShGlgtx+WTw4aMJIqqNrT5pwDoEQYw69K1g+FQzs7GFRFEdC
	sbI7W+KmYNMPmHjsPmQPv0xBLJOIGdEhZ/aISDYbR+70xMElo95rXpoqrF5oSK6RqapaS3TEDKe
	i0nscMa9DZ2WY+0No0HXpFHHefJUMHCqZDK2UQCF8wKKS+y494tcQ576PWsTD+bk/kF0jbnYXQk
	+pfM3KDa943iduVG96e1JxfpDsezBfNo4l7qQSzLQ=
X-Received: by 2002:a05:6870:e6c8:b0:234:5785:bca with SMTP id s8-20020a056870e6c800b0023457850bcamr15507056oak.3.1713874596454;
        Tue, 23 Apr 2024 05:16:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUIotq0aJ8ADzUNIdHRqv6pG1FJGWw0fGS7e3UxNarsCIFMv4IQZzl8tipsbfT+GMtZiJlLA==
X-Received: by 2002:a05:6870:e6c8:b0:234:5785:bca with SMTP id s8-20020a056870e6c800b0023457850bcamr15507030oak.3.1713874596072;
        Tue, 23 Apr 2024 05:16:36 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.241.15])
        by smtp.gmail.com with ESMTPSA id p9-20020ac84089000000b00437a996ca44sm4771715qtl.21.2024.04.23.05.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 05:16:35 -0700 (PDT)
Message-ID: <88cf691a-0f47-405e-acc8-91b3a05e8940@redhat.com>
Date: Tue, 23 Apr 2024 08:16:33 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Bakeathon: Talks at 2 (EST)
Content-Language: en-US
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
From: Steve Dickson <steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello

Today we are starting "talks at 2" [1] during
the ongoing Bake-a-thon [2]

The talks are open to everyone via google meet [3]

Today: The future of V3 (no slides... very informal) Just looking for 
thoughts

Wed: kdevops BoF: How kdevops is used for testing Linux NFSD, next 
steps, open discussion

Thur: nfstest BoF: Q&A, what's in the pipeline, enhancement requests, 
open discussion

steved.

[1] 
https://docs.google.com/spreadsheets/d/1-wmA_t4fp7X5WvshYPnB-0vHeMpoQMohim2Kb7Gx9z0/edit#gid=1920779269
[2] http://www.nfsv4bat.org/Events/2024/Apr/BAT/index.html
[3] https://meet.google.com/gyu-kmxt-rke


