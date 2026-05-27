Return-Path: <linux-nfs+bounces-22009-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBOaMWcHF2qn1gcAu9opvQ
	(envelope-from <linux-nfs+bounces-22009-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:01:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9A75E6783
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E15033004685
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5AA2EB874;
	Wed, 27 May 2026 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQSJVr+y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJMoaL+g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730CF2F2917
	for <linux-nfs@vger.kernel.org>; Wed, 27 May 2026 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893626; cv=none; b=E/lbRd+EnmqXprf/vk2+yH8obXMvdqg91WvLIEdyZyhgYXSUSmPxNxvXz4dWRwFrhkAveEWNVQd8mRYzVR6aMZ49ay6WrjJzNz+WgOJGwuOlHpQRO1X3Fvb56bXaX8ykXkTOWZmzfRHNM4XoZBlS1j82SSxLLftmGLJrTxs23ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893626; c=relaxed/simple;
	bh=G4CreATvYqb0tfCFZzU+3Qm52cJP1PVX6S/GffXjVmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wzqkuwqa+x2/cl88u+7odpro0j709lnqYaLigvbLBghwxiASBU3h1deD0LY8Oe9RsIU4hD8UoJ/B99/OzaE+PpIIEWS/cm4Y7rs+yhMjZuDhyl9vy0nUjcTHTr0k8tx7ARlG81vIYwWUsu69MxcOcsj1cFANSNLQcy8+WqdQ4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQSJVr+y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJMoaL+g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779893624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EsJjy7Q/gwSyvXGZ5WOnSHSpWfUQY0FmfznK2gk4+O0=;
	b=SQSJVr+yxGQcQ2eA1Y9NKCJuy89pNjwJygen0o9ezfosIKfy4UuduVJYtIOrGIFXqDf1OQ
	EtYFqwRYw4wLOaR4aEwBV7tTFGE3Fn8PR7UibG0IE5wzrihBdfwp6j9pb1tgAY1MgLmM96
	uRrxw2FHplbugj5lvZ58xAXhGdZx+BY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-NBkcz3qeNqOJE0DL3laDWQ-1; Wed, 27 May 2026 10:53:42 -0400
X-MC-Unique: NBkcz3qeNqOJE0DL3laDWQ-1
X-Mimecast-MFC-AGG-ID: NBkcz3qeNqOJE0DL3laDWQ_1779893622
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-514b673c8f1so103990421cf.3
        for <linux-nfs@vger.kernel.org>; Wed, 27 May 2026 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779893622; x=1780498422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EsJjy7Q/gwSyvXGZ5WOnSHSpWfUQY0FmfznK2gk4+O0=;
        b=IJMoaL+gC2/IopHkkArw5EjRvEDmJarlHs7UgugcHLD7bkEpKJrZZv5noXlEHy2z0e
         1/yyUFVR73/6IRXA6O6rz5pPUK5/3Dw8cxbGavDC9jOtpN1TfNfQ+2nEFfXk0HZP6B9P
         uO1Tfescyw19r0Qv8i66Y/QdNBFCm+ZdATtpUU/rAYXC5WGmgHRE4J3AvWAxWWDiytpk
         uo3EE1wcEkAv2MrMPo/lA+5b89rjZJisMUUbpgstGkKTYR/gS3g+uMH1uOC0TLAeOCZz
         cDXIae1qto4CCBWtT+Cr+agFWUyN7H9QpmFbrkXbtYZ6EiCQtMH8HaYiVFmRivVet0sx
         qimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779893622; x=1780498422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsJjy7Q/gwSyvXGZ5WOnSHSpWfUQY0FmfznK2gk4+O0=;
        b=dLG0NX+3701h8yND+G7NOOSt4F/MaVlk2RTwD3I4H33ERT4ViMfv7ppjqmyInoZ+2Z
         Nn+wpwtiPE4HOx04FZPz8wUMW2FlmPIKcysE9Nu2k2hIcKkazynC6LyyNbp+2QjJ8pQy
         MhaGCKShScU/QmF6EY4xYFC3xsLjUpR9qE6DPU03zdbL6OamxWREFoQdyfzC3So59gyy
         eVuRV6j2FW7gJIYW/Q9nj74hQYz4foeuel80Q+7nzNFKPoIvJP9L/AiY+fDKCG4WjVyy
         DWr3z3WkVSJBeLNYCqN4YKLsBenQlHOGTQZYvUX0l12MbJLO0zcHaVO/g345I+WZRGzR
         lA8Q==
X-Gm-Message-State: AOJu0Ywp8ECp13RAk1TTm4F1Y3QZzHGEN7WIwcVC1uNPXftOwsh2jqOB
	Eszr+br9qXcwLGuLgx85ES+nRtyp6JP8Id46lClhbcvOH4WFTQsVpCkpR4/PNU+DRhr/YCzyrSb
	g/bKr0VbefzF+pYg7P/exazBsGS70vUV9uQjs/GVwuOOLQtCurz7Wx8WU1WH6CQ==
X-Gm-Gg: Acq92OG6jvUVkRI2uCjBAKGxM3taboWwVd3cai/JlL5B+dvKUdlq3Ko0K5ctvTrKfna
	KqiC5HwCp8tBmEXTDn0JtxNHxqKun+Bcsk1/fNItwWzlFrK+UfoVlmVP9QfAQQ7W2Z35Sj2XeY/
	PDTwK3afUbJ2KEZKyL2zin7NbuI+qk0XO5FrbtdgRQlXMsZi9jRrxvjNl89Z86dz1feuepqODaz
	g1BSSf/vPhLY4oXPw+aoCnXBrBfpuyDhEuvfMT1YFgnmXTcoEZYmm+PwsCXixXoginL0NJLteb2
	qYrL243PHw05EHBbYyZaVUg2WXW4gO4Gjdg/NIQzfpX1vtAeA/MDX2Mkukow8CwN1GrMKcN7uRu
	MET7Bk1VeLbFBqi8RiqAS0Q==
X-Received: by 2002:ac8:58c9:0:b0:50e:5f71:62c3 with SMTP id d75a77b69052e-516d460cf1cmr289029551cf.42.1779893622242;
        Wed, 27 May 2026 07:53:42 -0700 (PDT)
X-Received: by 2002:ac8:58c9:0:b0:50e:5f71:62c3 with SMTP id d75a77b69052e-516d460cf1cmr289029281cf.42.1779893621791;
        Wed, 27 May 2026 07:53:41 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.241.172])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706b081c7sm44895261cf.28.2026.05.27.07.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 07:53:41 -0700 (PDT)
Message-ID: <b810304f-0e42-4ca3-8746-7d8323e35e70@redhat.com>
Date: Wed, 27 May 2026 10:53:40 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] rpcbind: fix a few memory leaks
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20260521234720.818996-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260521234720.818996-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-22009-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9B9A75E6783
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/21/26 7:47 PM, Scott Mayhew wrote:
> Fix a handful of leaks reported by valgrind.
> 
> Scott Mayhew (3):
>    rpcbind: fix memory leak in init_transport()
>    rpcbind: fix memory leaks in network_init()
>    rpcbind: fix memory leak in read_warmstart()
> 
>   src/rpcbind.c   | 4 ++++
>   src/util.c      | 3 +++
>   src/warmstart.c | 3 +++
>   3 files changed, 10 insertions(+)
> 
Committed...(tag: rpcbind-1_2_9-rc1)'

steved.


