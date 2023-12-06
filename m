Return-Path: <linux-nfs+bounces-380-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1880807B50
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 23:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787F02822C6
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 22:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2F8563B4;
	Wed,  6 Dec 2023 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="K+tcyyxY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpcmd14162.aruba.it (smtpcmd14162.aruba.it [62.149.156.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B212F
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 14:25:54 -0800 (PST)
Received: from [192.168.50.162] ([84.33.84.190])
	by Aruba Outgoing Smtp  with ESMTPSA
	id B0JvrZw72ieE0B0K6rnPAX; Wed, 06 Dec 2023 23:24:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1701901494; bh=+3tLeUSDV9VJpAFdOMatEDfUwpEKySxv9IGcGY8ZL9c=;
	h=Date:MIME-Version:Subject:From:To:Content-Type;
	b=K+tcyyxYy+jZhHjL7qBFGTLisEbnWt4/Vl0tjZyN92aXbV2XNb3c+JfjcIi86FG4k
	 pFqTN+Sp6FZ1mH0sVSotweyFIzsm5/b4VeZfNyEGjlrDTgbRn+ph8RzR6rwH1AzJQO
	 JYQBvZp3+qYNMO9d//sIFkXeuqFQI0fHdhB+Tg65tZ8lGjB/yS8B29EpRq4aVWwMLx
	 X0tumQJQO42wTlOk+74Rtg+h8paeiz5p0z8Y8e31WZQ8GtEWBcReSEYedNQSnP9ZJo
	 i8erZckfz/oFtpfHA2oWtVK1MNwB1C7DkRHiitb9nQf1yM+RGN+7olo1HNboaFXLAX
	 jx7GhWftfLNPg==
Message-ID: <8f250605-d03c-4274-9d1c-6439996c631b@benettiengineering.com>
Date: Wed, 6 Dec 2023 23:24:54 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] reexport/{fsidd,reexport}.c: Re-add missing includes
Content-Language: en-US
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
To: Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc: Steve Dickson <steved@redhat.com>
References: <20231205223543.31443-1-pvorel@suse.cz>
 <e99577a3-b36d-4ef0-a330-88502d3193df@benettiengineering.com>
In-Reply-To: <e99577a3-b36d-4ef0-a330-88502d3193df@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLXB8vrgobt+BzR+NL1NL3AFZpzkA0ExIVSxZjJHa5wjg+eoIxiMCepQyQhPLlw2g7ZzQ3XRkujrVtKvVWGkKGItbCBto8KMNbaqmGqK9pf0FZuVjV8D
 NG3cZiQ9qs8BGKegYRhZ05/5H0CmLvSaG20pDwEMgaIRShW5CtOOR/KOVUd5eztSJ3qVZMP8pCeP2rvhl9gkDwWJyuYrpy0+zk6XSDCRREYWuFvfMRe65xrj
 V1ToJ+YsLQQqWAsVzN9LdrP61w5Atx5GwyVacg07G3w=

On 06/12/23 19:53, Giulio Benetti wrote:
> Hi Petr,
> 
> On 05/12/23 23:35, Petr Vorel wrote:
>> Older uClibc-ng requires <unistd.h> for close(2), unlink(2) and write(2),
>> <sys/un.h> for struct sockaddr_un.
>>
>> Fixes: 1a4edb2a ("reexport/fsidd.c: Remove unused headers")
>> Fixes: bdc79f02 ("support/reexport.c: Remove unused headers")
>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> 
> Reviewed-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Build tested along with patch "[PATCH v2] support/backend_sqlite.c: Add 
missing <sys/syscall.h>"

Tested-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas

