Return-Path: <linux-nfs+bounces-7157-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBDE99D201
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 17:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FC51F24F07
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F422A1B4F31;
	Mon, 14 Oct 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNlKGJ0i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8781B4F1E
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919128; cv=none; b=gSkzWXiUPJFKKD8c+cECTe7UxNzWw3MzInQwzuB2fo6rIY3Vh58aSd5vw1H6thPCkV8669ru7nGZClcYIomo/Ro2tJsS3PuP90dj39H5tc+AHFiNIbmUr9QH/Z4FuZ6GrPWMV6MTxcMQFkcW/i9PiEB3yFzwsHktcTVn42WiWfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919128; c=relaxed/simple;
	bh=nugUwAzG/tkysKR5S0wMWY3pWgQV5+EkdFmUkjHD8WA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=sPRFd6Hq0Q20lID+PrL+UuwIQVATPtaufczxteeOCpACqfhUCGSmkJFVv9GIxhNfJcKjewcvULqe/E3dDPwk7BCYGSrMJ60KG05Z4CxE/1xVxzdXUxGtdiKYRAKHdj5gx4/RKbBizozXHu7Qc20ZMf1cicvGDDbx0MsS3JnFm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNlKGJ0i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728919126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xKkT3YbT/pvSOJ3cBt6E6HwBaX2ODeLgiVSNFSBcYe0=;
	b=TNlKGJ0i/w2XS53+9xkwDnD03/wOrE/2OmXZx6nfdgp56o8bo+bUQNZassg3zZ4GIaw4Ky
	o8Pa/HTKAvtgD8iIFRB6bhtg40XoOu9bU/RUIRVzJPV1OlRv1fo+plM9mOnKFKgIjapzCC
	6iqB2mILGREiU7QWLLuU05DbiPq1IpY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-ZcviD30vPT2XQPQc6PkC8A-1; Mon, 14 Oct 2024 11:18:44 -0400
X-MC-Unique: ZcviD30vPT2XQPQc6PkC8A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d458087c0so2634283f8f.1
        for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 08:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919122; x=1729523922;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xKkT3YbT/pvSOJ3cBt6E6HwBaX2ODeLgiVSNFSBcYe0=;
        b=s+iiezUoQLkzn7CP4KEUOhzsp8ZefDWaB5jnFYBWhohVC7OfGzepNRUXssHJoj6T3T
         pBSV/A7gT++XGFvwcmVWJ9JU3vArRA7osCYaIqWDjcDyujh6Q/RZ6tPOAmLxvpzEOVrU
         JRinrdqzjaptkmIeQV0D6biCofizm7PES4sJddUucuTKETqpg6G/UEqnOrB8S1c5cTA2
         f6d/n/i5ZCNzXiva+QXJw+/uZBhK+Vm15agrhqpRZteHtl9hCLD/Qk3LA/VUofmlTRIn
         5UU5/P2kRyxBEvxsTXptmu4khiZeoVuqX4/R/iH0AmZ1Z9c0Olw3wUcXYmVURDPfyxfF
         kAJg==
X-Gm-Message-State: AOJu0YwbvAn7dUVrbXlMYSd12kc2f4gDvK03XoaTSTMBR5lJSg+xoIcI
	JpZ68vQWMVEbMjykdXwz+/FSCIz5zgG7iTyICk0ZiMpkAnXwM5Nmk1UYt801uBIVoiyyLyS6x9c
	8jtRgSXtf3a7sXk0dSqUDBhp6LCen54sqLAS0Y3ahPhPupvlDDTPycz4vgzY4wid76GNC9cnx/G
	PPs5AOzqy1MNMRW+dBpM4Qx1mQqY9QDEWiwzCiyg0=
X-Received: by 2002:a5d:4241:0:b0:367:8e57:8 with SMTP id ffacd0b85a97d-37d481c24f2mr13341749f8f.19.1728919122292;
        Mon, 14 Oct 2024 08:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIOXrcvwDfmx5j2t3y9Rw2u/MkBwSG83zusmQ73mCFnDX2N4X7GA9WAT81IhgfLHBWBBPyng==
X-Received: by 2002:a5d:4241:0:b0:367:8e57:8 with SMTP id ffacd0b85a97d-37d481c24f2mr13341712f8f.19.1728919121550;
        Mon, 14 Oct 2024 08:18:41 -0700 (PDT)
Received: from [10.193.23.80] ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7c392f53sm459188f8f.20.2024.10.14.08.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 08:18:40 -0700 (PDT)
Message-ID: <e4b8a364-e81c-4013-8197-f2a34670b514@redhat.com>
Date: Mon, 14 Oct 2024 11:18:37 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: Final Reminder: the Fall 2024 Bakeathon
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>, NFSv4 <nfsv4@ietf.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Bakeathon is a week away... Attendance is
looking pretty good... so far [2]

I'm sure the hotels are still available.

We should have the network up and running
sometime this week...

But we do need some more talks at 2 (EST) talks
So if you are interested in talking with NFS community
about something you are working on...
talks at 2 [3] is the
best avenue.

If interested...  Please reach out to me
and/or bakeathon-contact@googlegroups.com

steved.

____________

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


