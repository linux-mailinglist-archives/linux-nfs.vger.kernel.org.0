Return-Path: <linux-nfs+bounces-4509-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9472C91F05D
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 09:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF621F23F20
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 07:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31DF13D8BA;
	Tue,  2 Jul 2024 07:38:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C90133987
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905907; cv=none; b=og05gF5znQg67huWZk1lJnwzQE/fWFOu24k4+Fxr+0LvGN4RNjNXWhzXg9vgSaVczyaF9XXRdDfYdOedf+imQCFq7+L4dHs5skg4EBZDuYJYjd/Jiyu2+ofcW+vouKM5M+84keOWAHcfyCkt+nFSzIBqSAQt0QaWiv2UcTkGc+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905907; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmtpMQuQ7hrP4TQPmQFftqjajUw6sVA72rYC1A/37AlqRTA5JnYLfVCSHHT/lhvJU2oS7FUllWfGl8ra+91nSgwfxbWMDx3SVe5x9JynoDeE4EV7LGADkLfhlu5v96eFdaivZ3GTob0N8qdPR4den4cNF97/TdrkOJIw6ciRAVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ee483284b4so3572341fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jul 2024 00:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719905904; x=1720510704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=eK4OdS166rXBO3LzOT4Sp1MO3YUXf3K7TxFZOgm/eVbkuscc/KhrmimZfp6dQbaeRy
         CqxOmw3WiNQWOe4sWcecIXZWdqd4w/9DCRzeiQbi5P7X5Ck0cUwL/di/lfHBg2nT3th9
         1xN3fPAJBjUX/hRBzxUmOu6okRriga59TNZzswrMu8BnnVUSBGGOT8f2/4UGo2No7IUn
         9qUBe07vB69rJ1XprfW3vuK4j4zUVEYr4R6A6neN24o5YzZZ8fhmWBhyYCqpG/IVrxgv
         uBK43d+p+CMOX7XAxUOo6ltysJB1wpcohA8vA01JkT12SnUqw2AtQw1x+e/Vq93LA6t7
         dVOQ==
X-Gm-Message-State: AOJu0YxA+yfc/XV43L6Efp3RUiUMWyRsHZJHNSf/HjqsiLVAGeqdNwZo
	npagwUuXw11B5v/B8JbDb8XeYbNFXAFOJeS3arpnayDQqR+rPET3MmWftg==
X-Google-Smtp-Source: AGHT+IHHmjuUwh2ggb9/91NGaf78124f8sg+lDZUYLny17Xy/xvz6x29ZBfJNiAWHHdGZji/hb5D2w==
X-Received: by 2002:a2e:b0c8:0:b0:2ec:5258:e89b with SMTP id 38308e7fff4ca-2ee5e6e6098mr40125481fa.3.1719905903783;
        Tue, 02 Jul 2024 00:38:23 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4258014f8b7sm90987555e9.41.2024.07.02.00.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 00:38:23 -0700 (PDT)
Message-ID: <f1f2a6bb-8ebe-4ce0-b31d-e23b4f86e2c8@grimberg.me>
Date: Tue, 2 Jul 2024 10:38:22 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] nfs: remove nfs_folio_private_request
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20240701052707.1246254-1-hch@lst.de>
 <20240701052707.1246254-3-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240701052707.1246254-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

