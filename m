Return-Path: <linux-nfs+bounces-12989-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF19B00904
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 18:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E453A487D
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 16:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0187274FD0;
	Thu, 10 Jul 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEpL1thZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EED280A3B
	for <linux-nfs@vger.kernel.org>; Thu, 10 Jul 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165598; cv=none; b=W0Z0e3oLUdePQMFnsqsknjtgx+0epZ51mnYJPDvKKKj8s4B3o64nKqZQ2WPSuwNwfLbEWO2ywC4PtaKTf8n0KKLZZ5zbkbP74+2eopSPJipc4Uq4r2zcoiH6srDsj9w9Jq80r1PnyC849Zd2nulFDgrlHk5H7rfuuYnIV1ibugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165598; c=relaxed/simple;
	bh=t8M2FolV7yvUhV6+lgBpEYkTRnTG8jMFOuX1wMrlwS8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=DjmhVoU9kDzZwpmcz91Fo15KsAdnzAUG/dC5XC0CMdRicYUrib9ro6jkIsTJxcxn7IASGKycKikPUdTYWGNSkrbtotAr5rFlMgFSaazq1xrRzSdhJXtApU6XXqhVsRHLC908HLQyLIBvK6bLkliGtd5J3dPr2SBhACYnpUz0CGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEpL1thZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752165595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YTmHTb8/cWPgXdHVosDdv9Y7grM/D5gRJxarBkHWJS4=;
	b=IEpL1thZ+1rktPZAgrbxpzD7qzc12Na82kyajZdHQpm9gWcbfeWeHZF6gmkus79txPMoa7
	bJ2cIX+GPB9PFYIRVUk8jij6KH2sAB1woUl02q4ixwsG7wkV/9vMqcn9Nzf32u62b7sIMP
	NrEUmsgpPZKWnedZOIqV2M/AGgRfJCc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-dGuVdpCFNEKNXbXVHVP_1g-1; Thu, 10 Jul 2025 12:39:49 -0400
X-MC-Unique: dGuVdpCFNEKNXbXVHVP_1g-1
X-Mimecast-MFC-AGG-ID: dGuVdpCFNEKNXbXVHVP_1g_1752165588
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f3796779so457064f8f.1
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jul 2025 09:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752165587; x=1752770387;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YTmHTb8/cWPgXdHVosDdv9Y7grM/D5gRJxarBkHWJS4=;
        b=dN/iBaY/n0fVE+WGCjZcbxdMT5JX3T+6T/t7+h/F4/AF9Xk5cInouwmnwPz+h72Zib
         IU+ke4k4VrFu+Bw5u7xGmeWZyAHHaQpsC5EDwxDZFWK1+seV+NX+M0Laoh1k77/9VFJZ
         QjKWzgf6IPaPHcs774oz8/yyJAj6Rapf8vSsvmUpN3p3q1vhCVXHc7t7kfv6W8zSl3f/
         q7/qCiZ6aeRxaMLVA5bnldRA5bvYWw5Rm7yosO3migMekeHnAD7AVhoZ/rSSClksFVA/
         JeTkw6+ITvMT7P0/reDVv6uGH0jfJ1ErhlfiyOBwnhKiDYmsqa1dqYHLV2GX5l2BpHCY
         juPQ==
X-Gm-Message-State: AOJu0YwqU9+9Tj0hRW55CQipNgAQwDCMzGEVacicoLZDrkCh0+/UOqSz
	//TqYybROwFeotsx7syQerqsYLcLNsq4YtG0e+lTrWcvQ3MOrGxKFkLGLLMEzaneNtCwlEeLST8
	9sIOrhFwPflLnOElapPix6WauyS8X5Fmb3QPuiMZtiVZHlexHFIt5qP7WZe+TYVj0fmtggV0wSk
	jVFGAzOyMRILIDdWYNAeGjRhAbKtxrjq5k6xSrBwucSbI=
X-Gm-Gg: ASbGncu16TW1MLRoo5YYA07FQwMhDYqjjCpg1yW9ffoF0peOxouUn87Su4xq3PzeneR
	/4g1An/CgtUQrsm6kvTlu/Ak8amZntmrCot3lwVMV4fWDmR6CStOksX3ttajiO0LaQzrVTEq3tQ
	H3CPtSqO+4wmc47/6LX4T2kfwy3OiBZv1hMqQ5h58O7kSycQze7UvpQpqOSVsmjAxgA/GYs5spC
	1exkXTnmM8s0k65+z7R8LKH7zf3Bz47VAznrbtlB+u7n7IWnRsnCCB8GmYruRG4QO+zVDtOD6GB
	L8TBWNESRXpQARj3uh/FcPuR
X-Received: by 2002:a05:6000:2a89:b0:3a6:d2ae:1503 with SMTP id ffacd0b85a97d-3b5f188eaefmr216303f8f.34.1752165587145;
        Thu, 10 Jul 2025 09:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4nUsjb1kFyMd0rIiwQy3U4xvCVZpy/eqbDK18UIuTflzqPPd6TZ729DZ9XAzEzIosKLWlKQ==
X-Received: by 2002:a05:6000:2a89:b0:3a6:d2ae:1503 with SMTP id ffacd0b85a97d-3b5f188eaefmr216279f8f.34.1752165586743;
        Thu, 10 Jul 2025 09:39:46 -0700 (PDT)
Received: from [10.193.213.71] ([144.121.52.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd466154sm24022365e9.12.2025.07.10.09.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 09:39:46 -0700 (PDT)
Message-ID: <fb27f565-23c2-4c54-824c-88f9e345c973@redhat.com>
Date: Thu, 10 Jul 2025 12:39:44 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
From: Steve Dickson <steved@redhat.com>
Subject: Announcing the Fall 2025 NFS Bake-a-thon
Cc: bakeathon-announce@googlegroups.com, NFSv4 <nfsv4@ietf.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Red Hat is pleased to sponsor the Fall 2025 NFS Bake-a-thon event, to
be held *Mon Oct 6 - Fri Oct 10* in Raleigh, North Carolina, US
at the Red Hat Towers office.

This is an in-person event that includes secure remote access to the 
test network via VPN, enabling virtual participation.

Event registration and network, hotel, and venue info:

http://www.nfsv4bat.org/Events/2025/Oct/BAT/index.html

Questions? Please send them to bakeathon-contact@googlegroups.com

steved.


