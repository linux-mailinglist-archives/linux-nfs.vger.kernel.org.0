Return-Path: <linux-nfs+bounces-3269-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343C8C7DE3
	for <lists+linux-nfs@lfdr.de>; Thu, 16 May 2024 23:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FAF1F213CE
	for <lists+linux-nfs@lfdr.de>; Thu, 16 May 2024 21:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEA3157A76;
	Thu, 16 May 2024 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW2Blpuc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F4715748B
	for <linux-nfs@vger.kernel.org>; Thu, 16 May 2024 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715893645; cv=none; b=Fxr5KiIvZk1brjlD7YmzpewhlLe0PrzpNpNyx4S8fAdbWrwX2XOYIcoeLUZAhNfzcv11xbWUK3POMtGpikAlZz2uTYddnbdVKiAlXPQ0MiAXKlDmAEmIBIKJnkSca5bOcTfMvOwEj14No8C+lTZbAntOkMi6dshdCRi+DT2QpAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715893645; c=relaxed/simple;
	bh=KM36IjAn8AEUy/2tXSmdtKy67dJl8ZemrMVF4jGTfnk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=h3jFxAg+D6u8TLTTEA4wyHdzDvzujU0Nh+A+9Te839BsfmTAPxJslTCj5HABn/o83uVAJU/KodTXZcqPPdEDYo4Sh24T6CAst0ixjcH77sal0olo1qcfBoZ/n8+a6C1qf1y1mtJLhDIDCKOaffPypevxo5BEU3x/9P5D7rQkFLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HW2Blpuc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59b097b202so300173166b.0
        for <linux-nfs@vger.kernel.org>; Thu, 16 May 2024 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715893642; x=1716498442; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAZHkTra+ty9wOMdWvvDKKQVETkJqlsyAtt7qZtRf18=;
        b=HW2BlpucKlJUqD2NacYwA4JuhSuGOahOnq65pfmIURHTbfFDP5U637jQb85ZWYG+2D
         R/ewBGpVNt1s6WsmM07iylINiZlpCsbHnWu38Gd1I6nTrPMO9tsqihWalgHzUNNqlGrK
         UnB0EzXUvkGnS3bjlqGc196RmjY7it0VnzZrkgckpqQP/uxOqmivXi13JC7r71KbeHg9
         XALrTyHgu0wY3uzKcOq4aF0AwAKbx62HGmJ0G2Wbqy4h5g/mx9dfuoF2o2pakFPKo2J8
         si9qcVGlHDUptKLirfLhwJ5b/4/y8KCy1wvg5pMGChPuiV1jEJZYM22zc/tV1U3FKYdi
         Z4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715893642; x=1716498442;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FAZHkTra+ty9wOMdWvvDKKQVETkJqlsyAtt7qZtRf18=;
        b=UhwQsJQtnqu22n8hIL5A0xdPQQk6m3VhWEfx4jig2SK+rP9DSp6QzffyNcXfLKK+IA
         RQFqJqI24gUkcMgYVthhGjVqmT3z+UZZpinCqp8i6ET+qf0yk/pYX2KfvbOKgZEEt0do
         UriRd0ZhRiq0mQqNIC1rUD4viH07Sp/OPW2lhVG/xXk/WXdjTuvOHDoZf7wPTMYQ16Dw
         44PvH+crLbWw6Cb33BW00TxGPkl3fIH+kMU5K+gFa2mx0yxiIZfoiuWua9/X6TSOKAT1
         Dwf/YCqQfgIZ4hn6A5cJMAl8mujY+IAtTRwIE4t9PXIaVORzpbpfxYB4/fNCFYsiykQC
         4FFQ==
X-Gm-Message-State: AOJu0YxP4+C3Rx3Ubv+Ii7LNZ2Z3+GdMaC9euDcxnH5j2edsK9MMJBVW
	e6qDRzkYVF4/Zior+blWky8fs1u5/lMINyjOTxJqlk6jlWWUQ8zNYnKnsTmJ
X-Google-Smtp-Source: AGHT+IGEzb82NCEPsjUcAdCjDhchtqCr7VbZJmk+1wbMTQrHuZY/GtviqM2DTjvJ0D3VhO1zAEo4IA==
X-Received: by 2002:a17:907:7da3:b0:a59:d063:f5f3 with SMTP id a640c23a62f3a-a5a2d673401mr1749518766b.63.1715893641874;
        Thu, 16 May 2024 14:07:21 -0700 (PDT)
Received: from ?IPV6:2a03:a900:1000:7e9:403e:7c8b:351b:f333? ([2a03:a900:1000:7e9:403e:7c8b:351b:f333])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1789247csm1017518066b.82.2024.05.16.14.07.21
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 14:07:21 -0700 (PDT)
Message-ID: <28702298-1c16-427f-b7df-3fbca3f78e9b@gmail.com>
Date: Thu, 16 May 2024 23:07:20 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, cs
To: linux-nfs@vger.kernel.org
From: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Subject: nfsrahead possible optimization for udev rule
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi


I'm looking at some performance graphs and  udev rule 99-nfs.rules seems to be 
taking some unnecessary CPU time when the system is creating and removing  a 
lot of devices in the system. It looks like  'nfsrahead'  is  always  
'parsing'  something  in mnt_table_parse_line    -  while technically  all 
the  entries in nfs.conf  are simply commented out, so there is nothing 
'nfsrahead' should be doing  and it should just quickly exit.

Also is it really worth this done through udev system ? - when possibly thing 
could be solved via udev monitoring in case something really is needed to 
change these setting for BDI (although this change is substantially harder to 
develop).


Regards


Zdenek


