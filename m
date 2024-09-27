Return-Path: <linux-nfs+bounces-6674-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 932A19881D5
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Sep 2024 11:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA891F22B37
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Sep 2024 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24DF1BAEC0;
	Fri, 27 Sep 2024 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBsiSQPx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72B1BA886
	for <linux-nfs@vger.kernel.org>; Fri, 27 Sep 2024 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430611; cv=none; b=eLGypE0jP9Fbr0hYnk7pT3A/ZzeyOUzqFz/1XJGCaJGUy09mHLfw4SW1ZxQzrqdJaT/jWjf2Y0+1tX0i/6EYE1h6EOkm8Wjx/f8EmNeRNf8qqWh0N3HDtOGaVvHFNqt7bulcpj66lFwnpEiTd6UeO8Q4bB+nOzUovpZm2yBkik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430611; c=relaxed/simple;
	bh=aDhR9Rxa9gOGP7VnzHLInSo//OZOLYAu6YB3IWE/LKk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=EL9cVxckVuipO4uQf2X4D4kdQDFatq9TEGpKLnz2VXvJTs2OqiGHE+b4GKptqNvncDD11LCOtECtp2hHXl10eS7xHq/IZK4+PKHusIh2dfiGKoZrb9wlGRbX5H8bzJj0VcWe2G43mwTpG3y+BGqxuYFiJxNayTNQNEm6Y8qTla8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBsiSQPx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727430609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aTj7rn5EllJczJVua73nSsgSRQ2asRdlXbguIEEHyh0=;
	b=OBsiSQPx8KiFMFyol4/q1ab5kcQm45nI5qiwwtGQu6VV3edx2R8LHd72iVb9+HIB505rj9
	UbEJTGw+jFZ7/czyt7XwoLwOGPjP6zwig5Y+CVt+jG7qHIuf0ypDM0Yo0khnoNTCYljuz9
	uaYubxx2/FUjVD3DAtVH1HKGyK6I/lE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-8t-Tk97hP4izl8yVSdGmOA-1; Fri, 27 Sep 2024 05:50:07 -0400
X-MC-Unique: 8t-Tk97hP4izl8yVSdGmOA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7acbed1c88dso408591985a.2
        for <linux-nfs@vger.kernel.org>; Fri, 27 Sep 2024 02:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727430602; x=1728035402;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aTj7rn5EllJczJVua73nSsgSRQ2asRdlXbguIEEHyh0=;
        b=E8J7HK2ja35za9Uc2rBFrI6H2Rmno6asyb5AbEZPbIk8U8YCwrig/VPowxkNAFqM8i
         f43SoIWDhjlgGxc+uVwNQHxCILrj1kt6WkFFD+IkXVyjcEPRKgTpDGwnhF1MWqDziYrL
         49ABbI7FyyvRskhTfggeMlNf3JxHppsM8qTcTqvEmH5gpwgowcPU5qSyfsK1EpU98LAB
         dHrqELFhIYku3Yvm0w3etuGDO4/vJojPseixlFmuEmOrSlFgkNaJ+WFNN/CNLfNMu2vW
         Q0o1TPhFIjuXjL9Hiqciehb6xKiBn4f1x/I5hCTATJ4l8/9CCGd86vtaY8TKscna6Zza
         Zbjw==
X-Gm-Message-State: AOJu0Yx2AuHzg2AzsAN7RifahvcfSqq8z5ByTd5nym7MQNfu9CEGufRC
	Snc76qmLHTHUf24CFDfvSvw7jH/60cLZOfw1J71KzgCBiakTcKCpxjCR+4kN0Zhivryphz+bnVh
	5TScEbwlCWgK9HsQ5vCyUnKOmTDkK+uKU6B7orJ5/dyLReZ3lllHU2YaH5qXo+9EN1JK1OEyhhR
	g1gSMFg0y50n6k6jeu7vxkrveeTf7oVuJFTJA62yIi/w==
X-Received: by 2002:a05:6214:5f09:b0:6b0:75bd:7fb with SMTP id 6a1803df08f44-6cb3b68598fmr43193716d6.40.1727430602013;
        Fri, 27 Sep 2024 02:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkdVGOwSJtOFJkDrTbqaZ8D6KOLCBzdCZK0oNZpc9xoxX+l9ufzmWCUi8MzJRYYcgZn9h4cQ==
X-Received: by 2002:a05:6214:5f09:b0:6b0:75bd:7fb with SMTP id 6a1803df08f44-6cb3b68598fmr43193476d6.40.1727430601610;
        Fri, 27 Sep 2024 02:50:01 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.132.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b62d520sm7129176d6.67.2024.09.27.02.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 02:50:00 -0700 (PDT)
Message-ID: <0a951a33-5cf2-49f9-b779-6595fa1355c4@redhat.com>
Date: Fri, 27 Sep 2024 05:49:58 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: Reminder: the Fall 2024 Bakeathon
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>, NFSv4 <nfsv4@ietf.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Just another quick reminder about the upcoming Bake-a-thon]
[Hotel blocks were extended... costs nothing to cancel ]
[The google links are below to sign up locally or remotely ]


Hello,

Red Hat is pleased to announce that we'll be hosting the
Fall 2024 Bakeathon at our Westford office in Massachusetts, US.

The event will be F2F as well as virtual. Hoping to
draw as many participants as possible.

Details, event registration, network info and hotel info are here [1].

Date: Mon Oct 21 to Fri Oct 25
Address: Red Hat, 314 Littleton Rd, Westford, MA
Event Registration: [2]

We have "talks at 2" (EST) [3]  everyday... Please feel
free sign up for a talk if you want to present a topic
the to the community... They are very informal...
Definitely feel free to attended!

Any questions please send them to bakeathon-contact@googlegroups.com

I hope to see you there... One way or the other!

steved.

[1] http://www.nfsv4bat.org/Events/2024/Oct/BAT/index.html

[2] 
https://docs.google.com/spreadsheets/d/1kJfCNeKyQhVRaV8p3X_2THsERegsgTOpkkdgv3X_-Ys/edit?gid=0#gid=0

[3] 
https://docs.google.com/spreadsheets/d/1kJfCNeKyQhVRaV8p3X_2THsERegsgTOpkkdgv3X_-Ys/edit?gid=0#gid=0


