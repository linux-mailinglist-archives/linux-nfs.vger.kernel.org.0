Return-Path: <linux-nfs+bounces-21633-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MONeELEiB2rasAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21633-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 15:42:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 384C9550A0A
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 15:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AF5830A2D85
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 12:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D7225F98B;
	Fri, 15 May 2026 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QI0JI3gh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2wie1SC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847925A354
	for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849533; cv=none; b=QMkPvVUWe6aiuZ1PcvtpyNcgd1XsCvuzJn/HE4CCKu/doZpb965y93UPJfim5ZPb7O1Bi1pgV353iLUG6XCRaRAhig1LQIbncXmTlG2MPbNNHUV8mZsED9b8fZ1UCvqoItVP2c0tjbWOVbiv7MemUdc6gqMl/DEd4ONmIKtTnVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849533; c=relaxed/simple;
	bh=XYkMoxagrDljc7Htmc62g9oeVP2WzMsEJ1GrBemnywY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lsdEaavgCWkcYZ0inFo9LWW9EEflaiFHw/CPPNKkwXPqdKlTpHKVMhgs4W3aWL1YFKBq2YsxTk4+j0T5aGSWL/JWQNzReMmQzYNMEVIfJl8BiduyGtCYcVpr7HhmWoE/7QizxHL6MgZQpRUE+9O9STQpRtYP2XTFA3sEY1MYLRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QI0JI3gh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2wie1SC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778849530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmIzko02JplLOFNXjejLeaoA3Jjsw/i+lXQXu1xiyU4=;
	b=QI0JI3ghqN/+kKeNnr2ybZn2ywtAdHgEhrWWgDrwzL2poyL3kJj1eowP/BmjE7G5tqUCLc
	W7z7JZQWXzX191ckvLFIdsYhQqqGysLVRxYwOet6G/DrR9IExn+HRvfxv6soMxZwDgT05x
	Ju2YovXdejeiiYojFJpVDPnRa5AlWAo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-ztypnvX-O1-CvQvUYY1OYw-1; Fri, 15 May 2026 08:52:09 -0400
X-MC-Unique: ztypnvX-O1-CvQvUYY1OYw-1
X-Mimecast-MFC-AGG-ID: ztypnvX-O1-CvQvUYY1OYw_1778849528
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8b5ceedb5c1so196938906d6.0
        for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778849527; x=1779454327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmIzko02JplLOFNXjejLeaoA3Jjsw/i+lXQXu1xiyU4=;
        b=L2wie1SC7RFd/hqafw1zT5nLLM3BQBU/2wMZuegHPxjW193CZ2ceI3XXKUBBve8d/e
         MPaNs8RqEUpRNm36qcp1gE79iUWR73+DGlZEGyOmm6pjhdlikuTYbtGHhS9JpCSd4dv1
         UexWxCRU3GCAlq/1E5njqeYpPbi10sH2DzJlfja7PF4h2jX+4A5tiV18mPValDBZrJew
         4QLlEM5pmMGGs/2sIK8K/+8/H56inLlaAGpFDUJqA3H8k1XjjlifBbjcy8iNcxQDVihO
         qKgVWohj0s0N5Z7Vd/oQV1/Ku70PsRfQ13+Qm9wnqaitXItdtXlBHTu7Vp3oej5Ksr9E
         jiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849527; x=1779454327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmIzko02JplLOFNXjejLeaoA3Jjsw/i+lXQXu1xiyU4=;
        b=H7x0ZIMS2W2JSnnltSOe6HRkLFJw4NlW4JJfhKiU5PXeNxbbw7NcyLSiwawxvt1jnl
         aY4oHkN9jV8utpN+1rsixMyT0ueS8Wjds7iYb3LfGKwJ5zhF2Yt/fkIoPvbUzjVjDB06
         KHnnA0/aS1BphRrjVO0mSWAu9+m2GjRKsqdUlH+PwfRUvQberH8fZMgF4hWPI1XZ1A2Z
         OYrZoLTuo4HltBeZee2mPssL5g/LTFo2FrHhj8grsd2qDkrYHs2HOEiaRmCs6h60MzW4
         j/cgo2EAitFI33VPYWD0Q/Z985iBJCf78U5rcOx4qCknQ5PKPZBYu7TqEg+tGvvoLiVX
         U7lw==
X-Forwarded-Encrypted: i=1; AFNElJ+NON7iBsQHQkxmkUpbonO+filJjOHhaOiyavNyhgepnMWkxUaIvVeZOqzXuBZnwRqwaguqKQmcCro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvqlT8an4XJhL5Po8GovS/uuviiuUFfI+xxLcDvtqqRRDVS98X
	bxnrQuYTfxZbgg7BFP+1nCbilBhTLUhgqqTdn5HatCIFIITS8bDF7ekJoCrLYcYQ5niyF7yMWAh
	0CNSeZEsOEwupEI/D06bpxJfK+H8VlnuvGdes8mkOIPTRflKN91tsRfcgkZ1bslwlcnMNAA==
X-Gm-Gg: Acq92OE7OicmDjeJYqwnds+uG+pvs/RAnG0egLojZH88Fo+V8cB8bUTH9dH3Fs4vkSX
	musUWc0d/VDX6BLpkyQqdrnKHvIaZOdB+bz4+TM/jvKCLA5skRR18C+NKv4j42OQRrNR5OH6csi
	WxEJld2wVi650uJg8TPwZjwUuuyfekuN9FIv2fMvvQMUTra1YTBrtb4B9/J47lIGWP0/KIh9hne
	yWYDSKMfPm1szctoE0l0EQx+38BDcVPguF3b9ierG+xqyCviKAfPHEXc827PhYbBcNIGSZyrXuS
	XuPWxUVLIwlN7WAv+LVGr/0LE55B4zyJwI/9X0kxpmcyXbnpYHUZYhoeIoVf66ouaItuaJUMTYP
	BdPVmiWNAY+T+QXAUpc9glA==
X-Received: by 2002:a05:6214:4521:b0:8b0:3904:596e with SMTP id 6a1803df08f44-8ca0f69e77fmr64536226d6.25.1778849527463;
        Fri, 15 May 2026 05:52:07 -0700 (PDT)
X-Received: by 2002:a05:6214:4521:b0:8b0:3904:596e with SMTP id 6a1803df08f44-8ca0f69e77fmr64534956d6.25.1778849526161;
        Fri, 15 May 2026 05:52:06 -0700 (PDT)
Received: from [10.17.16.21] ([144.121.52.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c359c74sm51055216d6.45.2026.05.15.05.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 05:52:05 -0700 (PDT)
Message-ID: <f4e9f9ab-794a-4e56-8a52-660a5978f6f7@redhat.com>
Date: Fri, 15 May 2026 08:52:04 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] Introduce compat.h file to deal with old Linux api
 and fix build failure due to missing NETLINK_EXT_ACK
To: Giulio Benetti <giulio.benetti@benettiengineering.com>,
 linux-nfs@vger.kernel.org
References: <20260408173535.3992116-1-giulio.benetti@benettiengineering.com>
 <20260408173535.3992116-2-giulio.benetti@benettiengineering.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260408173535.3992116-2-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 384C9550A0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21633-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,benettiengineering.com:email]
X-Rspamd-Action: no action



On 4/8/26 1:35 PM, Giulio Benetti wrote:
> In "compat.h" check if NETLINK_EXT_ACK exists, otherwise define it to fix
> build failure and where at the moment <linux/netlink.h> is included
> let's include "compat.h"
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Committed (tag: nfs-utils-2-9-2-rc3)

steved
> ---
> V1->V2:
> * include "compat.h" in place of <linux/netlink.h>
> ---
>   support/export/cache.c       |  2 +-
>   support/export/cache_flush.c |  2 ++
>   support/include/compat.h     | 10 ++++++++++
>   utils/nfsdctl/nfsdctl.c      |  1 +
>   4 files changed, 14 insertions(+), 1 deletion(-)
>   create mode 100644 support/include/compat.h
> 
> diff --git a/support/export/cache.c b/support/export/cache.c
> index 2f128d7d..65008f51 100644
> --- a/support/export/cache.c
> +++ b/support/export/cache.c
> @@ -40,7 +40,7 @@
>   #include <netlink/genl/ctrl.h>
>   #include <netlink/msg.h>
>   #include <netlink/attr.h>
> -#include <linux/netlink.h>
> +#include "compat.h"
>   
>   #ifdef USE_SYSTEM_NFSD_NETLINK_H
>   #include <linux/nfsd_netlink.h>
> diff --git a/support/export/cache_flush.c b/support/export/cache_flush.c
> index ed7b964f..2a24dec7 100644
> --- a/support/export/cache_flush.c
> +++ b/support/export/cache_flush.c
> @@ -38,6 +38,8 @@ extern int no_netlink;
>   #include "sunrpc_netlink.h"
>   #endif
>   
> +#include "compat.h"
> +
>   static int nl_send_flush(struct nl_sock *sock, int family, int cmd)
>   {
>   	struct nl_msg *msg;
> diff --git a/support/include/compat.h b/support/include/compat.h
> new file mode 100644
> index 00000000..83229b65
> --- /dev/null
> +++ b/support/include/compat.h
> @@ -0,0 +1,10 @@
> +#ifndef COMPAT_H
> +#define COMPAT_H
> +
> +#include <linux/netlink.h>
> +
> +#ifndef NETLINK_EXT_ACK
> +#define NETLINK_EXT_ACK 11
> +#endif
> +
> +#endif /* COMPAT_H */
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index 016dd2eb..c7126748 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -26,6 +26,7 @@
>   #include <netlink/msg.h>
>   #include <netlink/attr.h>
>   #include <linux/netlink.h>
> +#include "compat.h"
>   
>   #include <readline/readline.h>
>   #include <readline/history.h>


