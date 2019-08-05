Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E908214D
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2019 18:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfHEQJD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Aug 2019 12:09:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36976 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbfHEQJD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Aug 2019 12:09:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so7165021pgp.4;
        Mon, 05 Aug 2019 09:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ILZYy/Qkh2SOroGxB401ESLDlG+ppsquN1OQynPyiSU=;
        b=Db+xXkTUSvOFvD9NgxsIuCJ8BpKw+snEQ5dKKMfxRnl2UcqfRQHIQaydo8o8s1mvFB
         v66UcKUVg/yEALyxcosAOPyHpT6fCE3sCLVIHhve57kbTPJpWKZl1ogdvO4ir31v0r1J
         6nolSJsprQ4vgIdeNmQrjY0xnNWUUv0nB83CGKZoVdFlfCH72NCrHsL+9adCE0fFBTyS
         DIzAZZq1B/yJhlJWyXlK+sc08VeCrAK5ZC1T5pXJD+rvlelOR6OJZk6T0AAGWLWZr572
         gaGYL5pPZseljDjpJqTvsgCTtc63AK83Vb5syB/MX8Zc80S9mazO78pTuMOI2EIoqMRg
         oKUA==
X-Gm-Message-State: APjAAAVPE/7m8hE1TJP4gBNJZ6LaqD0yupHQ5qcE5/udYw5lf6qTJpUq
        7hSDlPp4S7O8nqyjZ3vDwAA=
X-Google-Smtp-Source: APXvYqwAxl1pBS8AeJ6EZK9QTwP7S8jW1nhyg9FAGS/zhrgSmhxNmxd6AUEWfED1glvlzd4Q5NiPYA==
X-Received: by 2002:a62:2aca:: with SMTP id q193mr75352974pfq.209.1565021342284;
        Mon, 05 Aug 2019 09:09:02 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b136sm111692066pfb.73.2019.08.05.09.09.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 09:09:01 -0700 (PDT)
Subject: Re: [PATCH v3] rdma: Enable ib_alloc_cq to spread work over a
 device's comp_vectors
To:     Chuck Lever <chuck.lever@oracle.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, v9fs-developer@lists.sourceforge.net
References: <20190729171923.13428.52555.stgit@manet.1015granger.net>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f181b5b6-df7c-d657-4ec6-4a4e56a9b5ff@acm.org>
Date:   Mon, 5 Aug 2019 09:09:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729171923.13428.52555.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7/29/19 10:22 AM, Chuck Lever wrote:
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 1a039f1..e25c70a 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -1767,8 +1767,8 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
>   		goto out;
>   
>   retry:
> -	ch->cq = ib_alloc_cq(sdev->device, ch, ch->rq_size + sq_size,
> -			0 /* XXX: spread CQs */, IB_POLL_WORKQUEUE);
> +	ch->cq = ib_alloc_cq_any(sdev->device, ch, ch->rq_size + sq_size,
> +				 IB_POLL_WORKQUEUE);
>   	if (IS_ERR(ch->cq)) {
>   		ret = PTR_ERR(ch->cq);
>   		pr_err("failed to create CQ cqe= %d ret= %d\n",
Hi Chuck,

Please Cc me for future srp and srpt patches. I think my name appears 
next to both drivers in the MAINTAINERS file.

Thanks,

Bart.
