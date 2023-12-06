Return-Path: <linux-nfs+bounces-365-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986B980782F
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 19:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A259B20E14
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F36246540;
	Wed,  6 Dec 2023 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="ZHLkTAHD"
X-Original-To: linux-nfs@vger.kernel.org
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Dec 2023 10:54:08 PST
Received: from smtpdh19-1.aruba.it (smtpdh19-1.aruba.it [62.149.155.148])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888279A
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 10:54:08 -0800 (PST)
Received: from [192.168.50.221] ([84.33.84.190])
	by Aruba Outgoing Smtp  with ESMTPSA
	id Ax15rHu1J0L7VAx15r2j2h; Wed, 06 Dec 2023 19:53:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1701888784; bh=eEjsohy0jwllNE3iL3sT0+7x8y6IToFvYWym++3J9TU=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=ZHLkTAHD1/J1spNNV71qu2bXPb8IkHtz6pV8z1eG378XCx9SdqMRu9SeJutwcU1Fw
	 xJBQxHJF3VSXD+IdzNiN5tvAVunY/3NLxdVPpCjq64gHOv8HQuOkN5IlH9gX/gGyei
	 pxwpihl+zKdSRN74Kz+ctS2DurNiFhZllClt1m+XpQHah0xYa1DVeZN3jbNbbkzE4F
	 ovvJ2AkuLFMDCQ+YIM84eCTtWf2o2ctoLz1wiz8KuYzPrrEA+qxczd9z0hRFdHMWe0
	 XNoORG7LtOIMKzJHHZzjqm7hWXDAFvoFMtnhA9O/Po/4kXzUj50yyOc+f80Ib0fQ+b
	 pf9oVbQABGt0w==
Message-ID: <be8ead05-1ebd-45c8-84e7-78b6b0e7202b@benettiengineering.com>
Date: Wed, 6 Dec 2023 19:53:03 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] support/backend_sqlite.c: Add missing <sys/syscall.h>
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc: Petr Vorel <petr.vorel@gmail.com>, Steve Dickson <steved@redhat.com>
References: <20231205223543.31443-1-pvorel@suse.cz>
 <20231205223543.31443-2-pvorel@suse.cz>
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20231205223543.31443-2-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJR5VoN5W1TwbplXHIgpZrHOR4kCTl+bZSVIFCiQKRRnM9GTfDnwpFN40E9dHIUgJTy3BywsuK3tIdF+VHm2DJrVFjcAI05nNA62VInEfkcHr69JI25z
 Rwh4sTii4GVLJGYu4TQzWNeuRo/SpD9iffZG8ykni2WTXIkvvsIgUdk85WU2ZBSlTR2pyZyE7RpHHsDvNERgDE01AclOgH/VY0PmMKvgd+2bT3EgAuZZtjqK
 omESHD+BwFd1FLfbxIrP4tOmS/DwmGotrExT91iQvIP9i+vBFxEJOY/4dLTTBSHZxgpccbAAKNmkO0QxN0L5vg==

Hi Petr,

On 05/12/23 23:35, Petr Vorel wrote:
> From: Petr Vorel <petr.vorel@gmail.com>
> 
> This fixes build on systems which actually needs getrandom()
> (to get SYS_getrandom).
> 
> Fixes: f92fd6ca ("support/backend_sqlite.c: Add getrandom() fallback")
> Fixes: http://autobuild.buildroot.net/results/c5fde6099a8b228a8bdc3154d1e47dfa192e94ed/
> Reported-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

thank you for fixing. I've tested this and the other patch with
Buildroot's test-pkg and built fine for many toolchain/arch/libc
combinations.

Reviewed-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas


> ---
> Changes v1->v2:
> * New commit
> 
> I'm sorry for these errors.
> 
>   support/reexport/backend_sqlite.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/support/reexport/backend_sqlite.c b/support/reexport/backend_sqlite.c
> index 0eb5ea37..54dfe447 100644
> --- a/support/reexport/backend_sqlite.c
> +++ b/support/reexport/backend_sqlite.c
> @@ -7,6 +7,7 @@
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <string.h>
> +#include <sys/syscall.h>
>   #include <unistd.h>
>   
>   #ifdef HAVE_GETRANDOM

