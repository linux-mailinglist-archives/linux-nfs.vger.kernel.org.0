Return-Path: <linux-nfs+bounces-5240-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A22B948504
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2024 23:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FABFB22123
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2024 21:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEC014B078;
	Mon,  5 Aug 2024 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APWWB1ZA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB99149001
	for <linux-nfs@vger.kernel.org>; Mon,  5 Aug 2024 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722894682; cv=none; b=JBEQHrL4LEgoLfUL9L8RxfSjq1+3ixezn+KsVVS24A9AJVlc6cMsKtQeSNHpAMBZxi5mCQNg69BmqmpID9eYSggE0czrIcc/MP4lVD270vtoPBRqC7zcxNg2kl02suZlQIKOCh1WNoEQNuhqDf09ySFeGPRrNjfyBLsoDEwwi6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722894682; c=relaxed/simple;
	bh=VW8XudwBz3lfbxaTGBsfcso1xiNSacllbCpH1BwZ0iI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=gIbozdg/5ZYrPZYxtdizHkCfLgK6IpHk4wiJMTHh+21T3gvsSxESLZhJP19RMT1AJ9q7x8sjqjMcwDJMqfP3IjejBs00SNvspe0JHs5sZVe5sSqrvFxfl2I1TDJna6mfJ6MvAWIrSCsBHE/6IqQUmvj4oe+R/Ahf/E/FsDFxWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APWWB1ZA; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5d5e97b84fbso5061334eaf.1
        for <linux-nfs@vger.kernel.org>; Mon, 05 Aug 2024 14:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722894680; x=1723499480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L68ZHFvgxM4tA1sCCayPVx8dQbJ9Jv8l9OgRLhoD+Cw=;
        b=APWWB1ZAZS70IjBFeCtsmpPzW2qDAngOlnPUU7606IFuXNkyW/qbPzkUtUh/EJRGsl
         1nCHloGU3/qtEx0MHBdP3cxzHpD9SReudlZ/adJclahbNTkP+rt+szrptTG7yUKEFqz+
         Ii7xmW/fAyy69tqswBjyAvQSptixDeiXFff44J3kVgL9QH79WAVGvevXA39bcX31IXpH
         sJ+go/2F9I6O09XddfrsmN8LuZ2oopd1GjEJpKjQgjet4edFEEW292QFBq/3F+WGUNBp
         CdK/j6BHy7/xMck4qbDg0nZ4xY8QIi8mkJl1go8VUF+KpWhglOY3ty/NY3MXnChNktuM
         clQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722894680; x=1723499480;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L68ZHFvgxM4tA1sCCayPVx8dQbJ9Jv8l9OgRLhoD+Cw=;
        b=XM7bN8h+Wyq64xTy0wPKojFOvmUmhTwW4VukXO3ugkLklTKnOI2dCMn3dn3HbxrqGQ
         K/xREBLPaYJqWGKkrzxssQAh52TDGoxZ8NlaxZZoFWM3uJisWkuNcK9e8WJcFh6ayvSl
         vdS2CJzYvIDPK4/TBwl7evUOAMXMN9gsB4l14HiZ6m3JLjYx5jfDT1mttJvAEO8zPrvQ
         ieNf6E/HDjR1pgs9K2g5kJZajDhmxi5kmpWXmpHDbMxGSqn0bTRGGIvNVOWDZvzlfEtN
         B6iYUT/7oNh4csLTMDWAevI0mvOarcJSaRJoaasFpqWgTk8IVe1g5IlhqTt5lXOl8EgP
         OLcw==
X-Gm-Message-State: AOJu0YydWUeJEx7j0hKczbvnvQKy1aNUkrff50g5gZoki+xfXxUMTBV1
	+/zATtI1tJA2vr1GhYtRxTpX9Va9M7DdT2mYcKiIFAjXEL3cfyJsG0BGAA==
X-Google-Smtp-Source: AGHT+IGYFjYCM4sNojmGQqjPO8gUnlbN0UfAwJE8nPEnHaPjQeLIUb6FIAR56ZCEKN+nKLeT6yzUow==
X-Received: by 2002:a05:6820:514:b0:5d5:ca0e:2502 with SMTP id 006d021491bc7-5d67154fde4mr16292447eaf.7.1722894680207;
        Mon, 05 Aug 2024 14:51:20 -0700 (PDT)
Received: from ?IPV6:2620:1f7:948:3001::b5c? ([2620:1f7:948:3001::b5c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70a3a76907fsm3320600a34.71.2024.08.05.14.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 14:51:19 -0700 (PDT)
Message-ID: <e39131ce-1816-49e1-8319-820472892a38@gmail.com>
Date: Mon, 5 Aug 2024 14:51:18 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: NFS client to pNFS DS
Content-Language: en-US
From: marc eshel <eshel.marc@gmail.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 Trond Myklebust <trondmy@hammerspace.com>
References: <c4f1d8bf-745b-4a98-9d38-2da4c355d691@gmail.com>
 <66be75a6-2d3f-4f5b-96da-327556170c4a@gmail.com>
In-Reply-To: <66be75a6-2d3f-4f5b-96da-327556170c4a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Trond,

Will the Linux NFS client try to us krb5i regardless of the MDS 
configuration?

Is there any option to avoid it?

Thanks, Marc.

ul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node 
stripe count  1
Jul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node 
ds_num 1
Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC:       Couldn't create 
auth handle (flavor 390004)


