Return-Path: <linux-nfs+bounces-19815-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEmKCpeyqWkZCwEAu9opvQ
	(envelope-from <linux-nfs+bounces-19815-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 17:43:03 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA41215871
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 17:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF50D3004D3F
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BA2267386;
	Thu,  5 Mar 2026 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAKQE3Kb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMad7Roe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BC93B8D4A
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728979; cv=none; b=OADa0gII8E+2cdCSDcC6FsJCAJxFkPEs9PCX077wY1uNbh1sryyIfhjpbCnvAqhde6I3tTPB/QiM/TfmoSU6YbC17Gw+8BtsUZ+92THnvODsycdHDvw0mDhnSm23i36TgODpvrCw/Jo4DCArHAKX0zx5jL6ubfBSa9y7TB3W18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728979; c=relaxed/simple;
	bh=/X+DT0QxdgyrmEdwEJJpqJxrgrK93/KOaBPFBPLmFtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtoTXZkuoceQSLkh4kqnwGUt4wXKT47A3k7cpcJqKjpARCDRkldOGqMU3MoogxC1K6C/Qad+smVo/7uTEGXYupS/QTpJxfRLZf+OMUEjqstOma0W1FOG5g9Xu32W/kfpcK4+kJG+X7e7wesQiPLZLtzBHRpVA48ysYxdI6GaILo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAKQE3Kb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMad7Roe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772728977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYwdB+cTS9Xc/noYali8OVwHciK80N9WeoEAWNOdRys=;
	b=cAKQE3Kb0mPhLxfJCQGpvrfjNN07zZa5h3xAx42svvns+ibLh7Qj9hYzsPeXgRBD1CnEAg
	wba1zpysRGR20MwqbHZ847OvxTovfbUTMU5gohObkKSs2KGVVSuItAzO55/9sTPTUOM9/J
	kKJ4lpL+V//WI0XRyApN+2ZzKpVkmvI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-Khe5AT1_PkuEWclUe137Nw-1; Thu, 05 Mar 2026 11:42:56 -0500
X-MC-Unique: Khe5AT1_PkuEWclUe137Nw-1
X-Mimecast-MFC-AGG-ID: Khe5AT1_PkuEWclUe137Nw_1772728976
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb0595def4so5955964585a.0
        for <linux-nfs@vger.kernel.org>; Thu, 05 Mar 2026 08:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772728976; x=1773333776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYwdB+cTS9Xc/noYali8OVwHciK80N9WeoEAWNOdRys=;
        b=SMad7Roe1nqsI3MZN8M+0vJnAaVtRpe8DIRnjh0Ajnr6OJ+iHqNQRTw6q5p8VmsxJv
         Uhk4ETPhNTI3f6Mt6h7WGafvtO1wZXFqHZkEmpzRifaLjetJnfwRRXfCELK8J3Go1Qt7
         sCGpMreWPfK+QWklq3mbBafQBKrtpRExrsW7jfWn/FiexgYWGoPUi5SNXhzXoibTvBkS
         1O2z1h5IiSc8+v8atvihuQW7C+u2wnN1bo+H3dRZdLIFsSq2mUhJRhvC7M+FqyqHL6iZ
         +RuJlXRX9fq1B4f05ziPN/IQE1TXF8lU+4MaJoSFU11uvP+eJX3mdB+hEcs5mOyKvtNx
         HKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772728976; x=1773333776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYwdB+cTS9Xc/noYali8OVwHciK80N9WeoEAWNOdRys=;
        b=aFzHEhF6CHbxT5JK2hts0EV8b0MOycbUxCf+oKqP7z8MSNVBJZDsa3OJb4/EbiHnAl
         /AsxBrCoyVzJq9snbC1SMUky6L959sNu9bycGbPixd8idvUTzMcyYbMA6VWtJYj3bA/m
         fboEcnL1QD/nqNoklnWRCCO8VK6iCgGHEZ62H/CgbVHUP48E4BsDUKJ+G8Hb8nTmqDX4
         eTVaDiJY4Tky71/jg0lxLvYCLyNgXZxFDMLex/MVNtyjrsAK0sd18qkkukwUQnkl8ZFu
         HWBjAKNqlOzK+7YI+jd1eNZ0hJpzlpN4Cs3oun2EynykkYKTTmx+XuuMS9QJUE6zITwb
         hNHg==
X-Gm-Message-State: AOJu0YzGb76/2ubGDWnkYaTyjVkez70UpmPnj9ylQ+1MNq6/aCq5ippS
	3T50kJ90ot03VxOvBnQxLFJ1kuUd2YQ3uux4Vu5e4XJXlAnj3IGTs3rH6bODoB6NB+GbcCmP5sy
	EY2Bf3iPZJxO7/MNPN1I36fU5s8DOwTJFR+BGvY8NHB+ygXKc098Y/sXDE02JbA==
X-Gm-Gg: ATEYQzwNKgrusGE7faw9bugrkGb3NDWlquxOdVtDh+VhqOwbmBmF4LrHPNJtEEjI31+
	Nih7+YNvousDlYljT1+A9lnTQV1XFslgwLIdKjF5QM5OF9/SWXWRX9RwuXPP/keRaybrxk5kari
	G39xoeGiYVKXna/T+/bqUAHxjab7nrUmX9kZJtudNcYoSIZPBN8eUnmz5a5sZXLY3rd9BRJs7Eg
	rT6mwg+53zTfUo5qAzI+FrokEPYzkA/RQsd6X7YQiIOj7NdDZOQafkV3DyT6OJp/VbyMzfLpdHA
	raX3qwa/+BtNPKBO9lhDcNqcsLOZWXPpumowH0g/k9YCGHHmNq3Pzfayieo+xVX+OPm2pSiP3De
	DWdJuMn8C/FyMKDQQ4eRyOg==
X-Received: by 2002:a05:620a:29cf:b0:8cb:4c8a:b3ae with SMTP id af79cd13be357-8cd634f23b2mr337623185a.41.1772728975874;
        Thu, 05 Mar 2026 08:42:55 -0800 (PST)
X-Received: by 2002:a05:620a:29cf:b0:8cb:4c8a:b3ae with SMTP id af79cd13be357-8cd634f23b2mr337620585a.41.1772728975410;
        Thu, 05 Mar 2026 08:42:55 -0800 (PST)
Received: from [10.17.16.21] ([144.121.52.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf65921bsm1887508385a.1.2026.03.05.08.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 08:42:54 -0800 (PST)
Message-ID: <a23ea546-96e7-42e0-9249-3a489ef13fe5@redhat.com>
Date: Thu, 5 Mar 2026 11:42:54 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "nfsrahead: enable event-driven mountinfo
 monitoring"
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20260305124221.55407-1-steved@redhat.com>
 <aamQbSl40bG5pjD5@infradead.org>
 <6a213da9-7c4f-4912-8ba4-80104a34ddcf@redhat.com>
 <aamrN6RV9_8RJDuU@infradead.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <aamrN6RV9_8RJDuU@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8BA41215871
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19815-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/5/26 11:11 AM, Christoph Hellwig wrote:
> On Thu, Mar 05, 2026 at 10:31:14AM -0500, Steve Dickson wrote:
>>
>>
>> On 3/5/26 9:17 AM, Christoph Hellwig wrote:
>>> On Thu, Mar 05, 2026 at 07:42:21AM -0500, Steve Dickson wrote:
>>>> This reverts commit 2b62ac4c273a647df07400dc1126fceb76ad96c0.
>>>
>>> Why?
>>>
>>>
>> https://lore.kernel.org/linux-block/CAHj4cs8URj2fJ7KyP9ViAm6npVOaMiAErnw2uFyPYEU2wb7G_w@mail.gmail.com/T/#t
> 
> Please put the reason into the commit log.
> 
Fair enough...

steved.


