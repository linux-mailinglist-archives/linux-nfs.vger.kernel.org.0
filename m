Return-Path: <linux-nfs+bounces-19027-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF6MO2L2lWkMXgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19027-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 18:26:59 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A38158496
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 18:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0D4D30054DD
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 17:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3642BE04B;
	Wed, 18 Feb 2026 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0Ld+1U2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9nNSR7s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC002FFDF7
	for <linux-nfs@vger.kernel.org>; Wed, 18 Feb 2026 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771435615; cv=none; b=M36fVuCffA+nSpINW/ObeQNzwCCtp4lCEVBO8TRpG1NUGf7lncyu0Se1TOY0oQT7BddE2lFLjU1bpyHpUSkChJ0x97HqBMQ8UXAl33B9ngsaHOldgv1MHRqYY/p5q7B8l2dh7pz4uSasbNUgP/loSpDL7WXEim1m2qSGToo7ndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771435615; c=relaxed/simple;
	bh=pP3kp4H3JIFiK2ILhQgJgnA3/OpCBZlaeXdozqQ2fHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJBTqNSNFttRo4uEX3Thzfa/xjc8oGwL6pca3b+N1McBmN7iExbvq1Iy2CxBpjJyIVA+tqoCC9Xo3zNSIbyRIvPPD32lDAEl7fCm5n2IBHUTFmJ7L/V+A+gLxYsiZXdLDl7jt/p8bSodHrh9CqpgAio+IUsooRrgAJgOgM8gz1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0Ld+1U2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9nNSR7s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771435613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bUD4w4RmKxslbifk1Er1VeTKQ0qlbnC8aOugkWchYfo=;
	b=N0Ld+1U2cKPsekzS5NJP7ZVLnllRqI3psWWsM0kWnD4+s8odXGyanV8mqOLdbdRsbIpuEL
	q5S9A42mUJqkDTr42yqcFsWfmPSVgtMr5nGcqXp26yBuZfXNyU2/I0z6ya7b0GVzDFsJKH
	LQNdGZHu4laNzcl+qlgmN2OMtUpsymQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-fHXJY-JuODmoQy2nzYIt8w-1; Wed, 18 Feb 2026 12:26:52 -0500
X-MC-Unique: fHXJY-JuODmoQy2nzYIt8w-1
X-Mimecast-MFC-AGG-ID: fHXJY-JuODmoQy2nzYIt8w_1771435612
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8966c2b187bso3095256d6.2
        for <linux-nfs@vger.kernel.org>; Wed, 18 Feb 2026 09:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771435612; x=1772040412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUD4w4RmKxslbifk1Er1VeTKQ0qlbnC8aOugkWchYfo=;
        b=g9nNSR7saVs6Cg+IzAokZb2t6Ool6yUD5zzaoy9FF5d9f/wBgrnpZ2b51BZSkECadY
         Zn9kag3A+4JsjOyszeihk3HAm3BFKtd3zSD9kWpNaxq4Bz4Ecg6sSFioXPiF5/k2PCHw
         HVHEaQKZC3kKg6PPx2Afip+7SVRPCuy3Ojqkn5TYNM17t8eyNA+/4n960ZU3KDFQObCF
         3OaocSdtZ3gw/+D8KOvLgS/G0LRGTVrf7yEe4HTMjj5VmjG5R3xgcr/Ua6n55QjCEK4w
         ru1v8Yojjy24g7xpp1oxNP1PLco768YQrpsSs5zwV093O+eiyvUh30OIFdCzdGDj4Pqp
         mloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771435612; x=1772040412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUD4w4RmKxslbifk1Er1VeTKQ0qlbnC8aOugkWchYfo=;
        b=GDxutsmJmUuTCvk5GTqmmXkaK5nrD76uO1WlZu6sFB78v+/PvnkWv8o3Ed3WYUfBjn
         gP2+IJxi6GGQqvFl6k+fvKXHdA1NVrrJtcDQYVAXvP62/siiSxUQhlgAziPmdxmndfiW
         yQBBrjc7d8Y9sD17+sCM83a1+LQtZifUSKd+XLyQNm5MTEmfhh/BRqEl/lL/DlTLhWBC
         yQUUYSMokVZY9QfzwCpN+RfeL95oyvNcgSk7y7B11VAWL3p3HcDsRY1EUd0ayLluXiHH
         d7C+8yWdIdWB+KcN6TqXHwBnnUFD5od5XhNicSXcMSkzDXvHnmiELJXSC+nkISS6yBbQ
         JHiw==
X-Forwarded-Encrypted: i=1; AJvYcCVG5N2LPxA3oJydUu7yIk0JdCffCUgiZvkr4mhvrW5evVvaeAPojUGIWjBMerdNstU5BPC/F+NfRqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ2+fdBYsTSp7KgFI2DuvzogVc2JuStXEcL/IY4f9tMDKEXj+3
	uaxUXynsqktRyhTTe5yKUMbjJAcFOXAjY2O1Et7l162RCCALL85LLF2svHpRQn17KEbf7m1osw9
	1JM1FQOKjL4V9BPeK8spiXTfvCkgAidy33rRZ+qfOhfhzbpc0EZEi2SOd6HrKNg==
X-Gm-Gg: AZuq6aJVzo9cVhdjQiY3Kot99P2/usOCmA9wdrv874jRU0L/6uuBDgM2yxzYNs9UrBS
	6mSMkk24tpeSBikCYqSBWqAzU4/ZAY0QlzeefmXE/Ywmbu6WXt/l7RGfEGDJqex+KiIKFJMgBIA
	13Ng3zI2wlJanz/dr03e0fTbtKkTYwPckWwBvd7HlJpftRgEudZl+8GOn01IFbVI/pBTnDoTdpc
	lABc3aMMySyhUYsPbZqdzhqauZKJ47Y5oxc8Q8sqfT9qKMf4uvTPICrH4snAKCv0xzGZfkqxsVt
	jzpm4UBFZ5AlJG+8Pqtof89bN+3JNTurWXPJtxKvZNcJ8+i9x4mIGfWaS+k8bGnb/edTPACgfAJ
	LBPOrz0++EcNZnL9dCxYv
X-Received: by 2002:a05:6214:27ec:b0:894:6611:bbf4 with SMTP id 6a1803df08f44-89957f49fa7mr35287786d6.14.1771435611936;
        Wed, 18 Feb 2026 09:26:51 -0800 (PST)
X-Received: by 2002:a05:6214:27ec:b0:894:6611:bbf4 with SMTP id 6a1803df08f44-89957f49fa7mr35287466d6.14.1771435611520;
        Wed, 18 Feb 2026 09:26:51 -0800 (PST)
Received: from [172.31.1.12] ([70.105.240.20])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cda78a8sm230608486d6.36.2026.02.18.09.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 09:26:49 -0800 (PST)
Message-ID: <b9b6e79e-d2bb-4817-a41d-942150f2caff@redhat.com>
Date: Wed, 18 Feb 2026 12:26:45 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v2 0/4] nfsdctl: properly handle older kernels
 that don't support min-threads
To: Jeff Layton <jlayton@kernel.org>
Cc: Ben Coddington <bcodding@hammerspace.com>,
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
References: <20260204-minthreads-v2-0-a7eba34201e9@kernel.org>
 <3c9dbad30b43bc02e07d8e2a8af31702eb793366.camel@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <3c9dbad30b43bc02e07d8e2a8af31702eb793366.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19027-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,configure.ac:url]
X-Rspamd-Queue-Id: 91A38158496
X-Rspamd-Action: no action



On 2/18/26 9:19 AM, Jeff Layton wrote:
> On Wed, 2026-02-04 at 11:48 -0500, Jeff Layton wrote:
>> Ben reported a problem with using new userland with old kernel. If he
>> tried to send down a setting that the kernel doesn't support, it returns
>> -EINVAL to the call.
>>
>> This patch series adds a mechanism for nfsdctl to tell what attributes
>> are supported by the "threads" command. If can then use that to
>> determine whether to pass down the min-threads attribute or report an
>> error or warning.
>>
>> This also removes the dependency on the UAPI headers by properly
>> maintaining the private nfsd_netlink.h file.
>>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> Changes in v2:
>> - Add patch to unconditionally compile in min-threads support
>> - Make getpolicy_handler() return NL_SKIP
>> - Link to v1: https://lore.kernel.org/r/20260204-minthreads-v1-0-9f348608f884@kernel.org
>>
>> ---
>> Jeff Layton (4):
>>        nfsdctl: unconditionally enable support for min-threads
>>        nfsdctl: only resolve netlink family names once
>>        nfsdctl: query netlink policy before sending the minthreads attribute to kernel
>>        nfsdctl: remove unneeded newlines from xlog() format strings
>>
>>   configure.ac                 |   6 +-
>>   utils/nfsdctl/nfsd_netlink.h |   2 +
>>   utils/nfsdctl/nfsdctl.c      | 204 ++++++++++++++++++++++++++++++++++---------
>>   3 files changed, 168 insertions(+), 44 deletions(-)
>> ---
>> base-commit: 8f54511aefe1455161a6c4406ed8c770139f61e3
>> change-id: 20260203-minthreads-402ce87096e0
>>
>> Best regards,
> 
> Steve, ping? Can we get this merged?
I'm on it... thanks for the ping!

steved.
> 
> Thanks,


