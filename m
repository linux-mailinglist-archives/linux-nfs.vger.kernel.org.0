Return-Path: <linux-nfs+bounces-2034-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E6D85BFA4
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 16:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73291C2091A
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4EC664CF;
	Tue, 20 Feb 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbQbNCCf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D86745D4
	for <linux-nfs@vger.kernel.org>; Tue, 20 Feb 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442108; cv=none; b=RrKrvo7QhCe0IB9V/iuSxRx9J4bUPw4A7we1QJXEGZUh/2BY6ZOgaMnliLlp1CifNBcNuyT2dtVdUtzrch8A3Qzqmb18aiIpLbATy9rD4IwgX0AhtfRVQRf0H5eO+wQXJIqoGQ7wrN88wKyjpB2Q+3uMm3T/1Gc8MvRmzV44cfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442108; c=relaxed/simple;
	bh=w6/0ifsxltCKcU5AZnWi64sVfjAA6N06JmjP8QyfV+g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=YvDKHauH/NesFalf2DRJK6SZjodFnWdO//nL3hT8rRhxFOwIME+4o6lW2ESWTiRMhIKmSDeuMOAp7CIjmIp+QwF3Nlm/Vk2Md5ofEAhxw1XCFSHsTp7sB2SFKrkegbQzqb+am7y6QieK+xeAi9fn/4xrsz0TmfUjgHEg3QR//o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbQbNCCf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708442102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+Qxy0OW+CkLZGN+WRl0iMJHVfTrpzbbRjvUEZA5h72s=;
	b=SbQbNCCfcLwluNIEhjvW3jQWyrri7ZqwT60krjmDHNlFCJo6z08NPHTZPWmJNtlkWSli7y
	Nb5yD7ON+EORwGzvfxE6fflookHW6nihC4OgSJ/v3seP997rfAjvSACvW1kT+uhD/S9mrt
	ZymUm29dAy5NvIlK06cYhbpxDuumQlk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-DvvUXpbtMmKNAablaNWCvg-1; Tue, 20 Feb 2024 10:15:00 -0500
X-MC-Unique: DvvUXpbtMmKNAablaNWCvg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78315f4f5c2so262661785a.0
        for <linux-nfs@vger.kernel.org>; Tue, 20 Feb 2024 07:14:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708442099; x=1709046899;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Qxy0OW+CkLZGN+WRl0iMJHVfTrpzbbRjvUEZA5h72s=;
        b=Q1WPNhjosePmMoXfJD89AcI+/lInh1YP0KXdOrVaq6kBVaEyIbZZPsYovNnlSPBGII
         fke30ntmLpsKr+Idbru/TAa3GdNEw/BzBbnfI+oTzXdE9jrwEUptsTjy7xWVm2CQo1Bp
         YrsD53Iv38+I9Mz5T2FSnVOqbUfPbcjiwIDbHoBZajqkDZ2ExkariIPQU2xuqZLIstLr
         ipDMtwTd72HofeNdTgFXBlk7FSUbCRkeYJ2PeOI+HnQkwIJjV8BjR81kMnwJBl19wOWU
         vr6sN9iN2QYBuNxr4uaSuA+tqwVzG/a57Jl4CTFprzvwzSVQegQMUntx3EFsPrt6X7zG
         g7TQ==
X-Gm-Message-State: AOJu0YzdsUAcGqaplQrM+zEUm0JEMZcVO7jclsBPQF2eQKXYkj9KsTPd
	UFp1cdp/4gbHUl3bNbYm3gWOUsQdXMpm73+96PHkKO1Frt63KroXcTmVtVExIlQs9s4uG8iB3Oq
	ta7N/qYrsJXvtGQL71RRVDfzdcSmJTaQGIdhF68MorzIZJYOErIPL22I8o728yqJEtOTQv8uvVj
	GiP5R8RiZHq1xwbHWvOABxOloK//B0zsnjGKUtU3Q=
X-Received: by 2002:a05:6214:1941:b0:68f:5729:9adc with SMTP id q1-20020a056214194100b0068f57299adcmr9703376qvk.1.1708442098987;
        Tue, 20 Feb 2024 07:14:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXp0E7RrdaDEpmOU25raqxypFw/RKqiMzMEKCNukOaaStB42BdWTy6AXR2gW4SbZtRAD+pEQ==
X-Received: by 2002:a05:6214:1941:b0:68f:5729:9adc with SMTP id q1-20020a056214194100b0068f57299adcmr9703348qvk.1.1708442098601;
        Tue, 20 Feb 2024 07:14:58 -0800 (PST)
Received: from ?IPV6:2603:6000:d605:db00:165d:3a00:4ce9:ee1f? (2603-6000-d605-db00-165d-3a00-4ce9-ee1f.res6.spectrum.com. [2603:6000:d605:db00:165d:3a00:4ce9:ee1f])
        by smtp.gmail.com with ESMTPSA id pd2-20020a056214490200b0068f59567778sm3382831qvb.127.2024.02.20.07.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 07:14:58 -0800 (PST)
Message-ID: <d8b6ed73-e540-49e5-a6b7-35c46c7199b1@redhat.com>
Date: Tue, 20 Feb 2024 10:14:57 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: Announcing the Spring 2024 NFS bake-a-thon
To: linux-nfs@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I am pleased to announce the Spring 2024 NFS bake-a-thon,
April 22-26 (Last week in April. You can find information
on the nfsvbat.org website [1].

Like last spring, we will be running this event in virtual space.  
Please note the VPN registration and setup instructions so that you can 
punch into the BAT network.

Last year's talks can be found at [2] as well as
other previous talks and presentations

Look forward to seeing you (virtually) at the next BAT.

steved.

[1] http://nfsv4bat.org/Events/2024/Apr/BAT
[2] http://nfsv4bat.org/Documents/BakeAThon/2023


