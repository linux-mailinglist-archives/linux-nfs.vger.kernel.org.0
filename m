Return-Path: <linux-nfs+bounces-11048-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FB3A8247E
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7908821F8
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 12:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA1825523F;
	Wed,  9 Apr 2025 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mGbO2iSn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out.smtpout.orange.fr (out-16.smtpout.orange.fr [193.252.22.16])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123652561AA
	for <linux-nfs@vger.kernel.org>; Wed,  9 Apr 2025 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201131; cv=none; b=Fr2lF5jaDMnNf1bffTD74c2a/GNsy0kAdLEfgKu/KNH5wb8FswRE/kBY9ZJs2XV6VaNzCOHDZzo3tC+4f61CJ+GCjo01f53jr7feoy+5/sr5LDVQD93kpKP5nSnBgMp2xbDU+ot2Nddo9pfoifgqsAX0FSjp9KkD0h5KrbfXSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201131; c=relaxed/simple;
	bh=oSyZxbFI15BY4P6SsP8To32LC5P8C7o9Pj4O3on6yp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZVfaEXuHhna3zEKXDG6M7uqnOHcynUDXwKxEOL0ZWO3pvuJdJUOLiWrbocKctEK8GkV3wJ0MlTDi5hHSS//pVPmvj74fNtmmJGK8zSqV6WeIad6e1lwUTJZd+e1ULy2vxD3CfLI3Te4H5JNnENl+OhhoUBi5srvSci9debFA9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mGbO2iSn; arc=none smtp.client-ip=193.252.22.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 2UN2uqXhxgxs72UN6u3iYK; Wed, 09 Apr 2025 14:17:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1744201059;
	bh=bUwZ1IXzDa4ayIH2Zdf2/rb4udXYWiKLEpmJN3fmH4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=mGbO2iSnu/rxa8ARhP1zpaqhxX+ZbuFBgx36uTe686zXYK6BGe93RBv6UMii1GXuA
	 AzCbS/ziTG5NdEWnjSpwuNwOkvoJLlV9sIgrbImhNnA2Cs2kEeyhYK9h6r5+D91oF6
	 2bQ59nw+t9ND52PwQ0K62SiDU9opvOhn/5GMUKI95M1GqsDnF/N9kjTbNKSqPYRAVF
	 SNrU4PWaaOOLBszohcDf9BWmefP67Ry4Ej+eRMOjM/RDAn5mhtwo4oXG5VbWEBjt7Z
	 xiazchK1um5du7xJznvzFoN5ciUSYHoSNYXm+IfZNz4w9IhghZBS5HJ/WT7SXLInru
	 5KjZxf2B2nxwQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 09 Apr 2025 14:17:39 +0200
X-ME-IP: 124.33.176.97
Message-ID: <3911d932-5ad3-4cc9-98c9-408818cdb4cf@wanadoo.fr>
Date: Wed, 9 Apr 2025 21:17:31 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: add dummy definition for nfsd_file
To: Mike Snitzer <snitzer@kernel.org>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250215120054.mfvr2fzs5426bthx@pali>
 <4c790142-7126-413d-a2f3-bb080bb26ce6@oracle.com>
 <20250215163800.v4qdyum6slbzbmts@pali>
 <a8e12721-721e-41d1-9192-940c01e7f0f0@oracle.com>
 <20250215165100.jlibe46qwwdfgau5@pali> <20250223182746.do2irr7uxpwhjycd@pali>
 <20250318190520.efwb45jarbyacnw4@pali>
 <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>
 <Z-QYjLJk8_ttf-kW@kernel.org>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <Z-QYjLJk8_ttf-kW@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2025 at 00:09, Mike Snitzer wrote:
> Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
> so older gcc (e.g. EL8's 8.5.0) can be used.  Older gcc causes RCU
> code (rcu_dereference and rcu_access_pointer) to dereference what
> should just be an opaque pointer with its use of typeof.
> 
> So without the dummy definition compiling with older gcc fails.

Same issue on GCC 9.5.0 and I confirmed that this fixes the issue. So:

Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> Link: https://lore.kernel.org/all/Zsyhco1OrOI_uSbd@kernel.org/
> Fixes: 55a9742d02eff ("nfs: cache all open LOCALIO nfsd_file(s) in client")
> Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>

Results from checkpatch.pl:

  WARNING: Unknown commit id '55a9742d02eff', maybe rebased or not pulled?
  #63:
  Fixes: 55a9742d02eff ("nfs: cache all open LOCALIO nfsd_file(s) in
client")

  WARNING: From:/Signed-off-by: email address mismatch: 'From: Mike
Snitzer <snitzer@kernel.org>' != 'Signed-off-by: Mike Snitzer
<snitzer@hammerspace.com>'

  total: 0 errors, 2 warnings, 28 lines checked


For the first one, I think that the correct commit hash is:

  86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
  Link: https://git.kernel.org/torvalds/c/86e00412254a

Unless someone already picked up the patch, you should probably fix
those and resend.


Yours sincerely,
Vincent Mailhol


