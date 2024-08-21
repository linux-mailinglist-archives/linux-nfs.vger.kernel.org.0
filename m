Return-Path: <linux-nfs+bounces-5532-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 305B495A363
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 19:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCBE284852
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 17:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829B613635B;
	Wed, 21 Aug 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hP1innqI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD41192587
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259728; cv=none; b=iTN5RJCepyPvoMO7IY0H67BzchP2oN6gk7qhaHvLJe83FTEU9PnBf6b/zh6WBGOWtaCpk0PZBytY6hHAI3iRplt8oMiDMqingYNEzaS3b4zv2mCDVY7WaFjVwIZs0nh9otvIShJkFiWLN9m7up14E6JBzP3KVSDj/FJK8FYW4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259728; c=relaxed/simple;
	bh=huuAhWozPlYbTC2md/bttbT13Gnl4tvjhnikaX+WZGU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=A88HTc8jN+q6uvr59HvlzoeokN+eJx6dZhJPXjwFxYGGUXoqj29pChaqLYJU/JTBxrpkJD49r2o5rPOqqi7eBJLQXpHlOhQs2I1jJoPd98HERwSSnlOgoCQDDzISt/ICuVs6xMYkcBFuhjz4dsduKBMjkOPJvSmF9jc78jwXFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hP1innqI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724259725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MKeKXCwsmTK1BKgQlQPiv496r6D3CysEhFtQeKSECUw=;
	b=hP1innqI3BRc0HG4krqdwKYqgqzbp7gh9ddEAyHK3sfdoBpNe+n+WZxQeOETDzOYpzJNSz
	v0t+HMguj5j9DWxTAyxUQDWr9+Qp1cPEwLtarpfCiP+xx1FVTmRFuC5Dq3W0IXcPxbqiWX
	9zyO9vJJfcTaSV6k6nowtvDr4aTEH80=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-R1QrsRXiMReymhTvN8b5lQ-1; Wed, 21 Aug 2024 13:02:04 -0400
X-MC-Unique: R1QrsRXiMReymhTvN8b5lQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-44fdd97e455so81186021cf.2
        for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 10:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724259723; x=1724864523;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MKeKXCwsmTK1BKgQlQPiv496r6D3CysEhFtQeKSECUw=;
        b=dBsG8HJFu7OWNm3xt2rZD4Hh6B2PPyZD7Q84py1YhPjhqTK84sPkNeo/x9esmCrWlp
         pq9POjoUFz53q2uZGrzwrFOHTWz+acFG/NsUP9Ix0MEpIGUQli8HCyAXzEJJ7lf4NNPZ
         e/9xf6zth1nUXHLwmgCcM5fBjtkemm2aQot/QRleOI/lwg5kp5dGJhQdiX0GcsLEiith
         ot1K7LGqh4xIW8ulc4kvVyvOfn8/v+SGzqQXi2YkPtvJTTFHyQYCYUl/l0EBowNDlpYM
         2o5IM4KA8AL1bQ5b1DpJ7Z0FzOUO7QjAo/GCB+VslE6Vp8fUCrxkPIt4UXj1RcH/V7Ci
         HMQQ==
X-Gm-Message-State: AOJu0YwfO5UvGcf0w83XS1HjETrlXllRH8iAnD1ECsP4HR/CI3tzabsJ
	d5vxVBJfWwo/X4eWam6qkhlNFFbJmQTpQsra+cfhdlVeGi8DgcuPqDwXRTh0tpDi21cpIt4z5Jv
	E4QJdwr2b7Dqe0Bl3ybDVji2yifxWrM67MJKCY/o7WGZakhfOy7MOGQs4HS81H7MVGlSbMXx3tx
	Z+TDKHwg/j+4aYzx4E5fvxvwEt7Q5pfqJ9+4VTHms=
X-Received: by 2002:a05:622a:590b:b0:446:41fc:3fb3 with SMTP id d75a77b69052e-454f224c989mr32720621cf.41.1724259723414;
        Wed, 21 Aug 2024 10:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC6y5Hecq6ScaG/sEuWumvwtSnqJRQRxj5VNmNhzR6DyNaAAv/zQLYfmUACd40zIVSbYVPlg==
X-Received: by 2002:a05:622a:590b:b0:446:41fc:3fb3 with SMTP id d75a77b69052e-454f224c989mr32720061cf.41.1724259722868;
        Wed, 21 Aug 2024 10:02:02 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:165d:3a00:4ce9:ee1f? ([2603:6000:d605:db00:165d:3a00:4ce9:ee1f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a00a913sm61036991cf.58.2024.08.21.10.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 10:02:01 -0700 (PDT)
Message-ID: <c8a8f5ca-b9a2-4f5b-9494-0631303866ff@redhat.com>
Date: Wed, 21 Aug 2024 13:02:00 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.7.1 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This is a fairly large bug fix release... Memory leaks,
warnings, typos in both doc and error messages,
improvements to the junction code, etc


The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.7.1/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.7.1

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.7.1/2.7.1-Changelog
or
    http://sourceforge.net/projects/nfs/files/nfs-utils/2.7.1/

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


