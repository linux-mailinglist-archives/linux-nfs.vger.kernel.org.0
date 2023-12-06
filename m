Return-Path: <linux-nfs+bounces-366-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A923807830
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 19:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21B7B20F0E
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 18:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9444746558;
	Wed,  6 Dec 2023 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="gNkmNqMx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpdh19-1.aruba.it (smtpdh19-1.aruba.it [62.149.155.148])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898C0D44
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 10:54:08 -0800 (PST)
Received: from [192.168.50.221] ([84.33.84.190])
	by Aruba Outgoing Smtp  with ESMTPSA
	id Ax15rHu1J0L7VAx16r2j3E; Wed, 06 Dec 2023 19:53:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1701888784; bh=tJP0vERQR46d4unnwqjcBEC/RBQd7jS8EGhEeNgUoiQ=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=gNkmNqMxA/af1XGiBg95QNVN7GZbl1/XCvS0S0BKC2xiEDPVqBEgCG++DHKkdZZDQ
	 r9DV/VgO6vVHKVGWPTrIOypJ54PQNgxRxBstPfBASTDyPiFTdtOTL2recGbaGaCt6t
	 37vvHWaWhmY9ORNBdlL7v0aKfzLp3C2vaW68kv5JzITLohLN1KRHoH5Pp0jAsu4RQJ
	 FNW3CjeW/0xaFNQxQedPHQ961cPe5sVgcDNEsCZM9spev2fyuvSZV4ENu44q4q5M1G
	 ObvyHESN34iILtyEJVe/7pnXztfJDkZO8OhAHSVg1pgbHRQU/6ge38TKU24cGrprDI
	 KebG4vhlRGTFA==
Message-ID: <e99577a3-b36d-4ef0-a330-88502d3193df@benettiengineering.com>
Date: Wed, 6 Dec 2023 19:53:04 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] reexport/{fsidd,reexport}.c: Re-add missing includes
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc: Steve Dickson <steved@redhat.com>
References: <20231205223543.31443-1-pvorel@suse.cz>
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20231205223543.31443-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJR5VoN5W1TwbplXHIgpZrHOR4kCTl+bZSVIFCiQKRRnM9GTfDnwpFN40E9dHIUgJTy3BywsuK3tIdF+VHm2DJrVFjcAI05nNA62VInEfkcHr69JI25z
 Rwh4sTii4GVLJGYu4TQzWNeuRo/SpD9iffZV97oc5SzcJuTFE4PiZ/XO/jbAAY1mgT9fNKnYbe+PStVNRIRqsBvxjBmspNVogD0Y0kIh1SnIw87q0fvNb9XO
 Q3uGBpLhzBX22wPtaKJXMHrGcBL+YHuj4cnfVUqEbZE=

Hi Petr,

On 05/12/23 23:35, Petr Vorel wrote:
> Older uClibc-ng requires <unistd.h> for close(2), unlink(2) and write(2),
> <sys/un.h> for struct sockaddr_un.
> 
> Fixes: 1a4edb2a ("reexport/fsidd.c: Remove unused headers")
> Fixes: bdc79f02 ("support/reexport.c: Remove unused headers")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas

> ---
> Changes v1->v2:
> * Add also <sys/un.h>
> 
>   support/reexport/fsidd.c    | 2 ++
>   support/reexport/reexport.c | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
> index 8a70b78f..51750ea3 100644
> --- a/support/reexport/fsidd.c
> +++ b/support/reexport/fsidd.c
> @@ -7,6 +7,8 @@
>   #include <dlfcn.h>
>   #endif
>   #include <event2/event.h>
> +#include <sys/un.h>
> +#include <unistd.h>
>   
>   #include "conffile.h"
>   #include "reexport_backend.h"
> diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
> index 0fb49a46..c7bff6a3 100644
> --- a/support/reexport/reexport.c
> +++ b/support/reexport/reexport.c
> @@ -7,6 +7,7 @@
>   #endif
>   #include <sys/types.h>
>   #include <sys/vfs.h>
> +#include <unistd.h>
>   #include <errno.h>
>   
>   #include "nfsd_path.h"


