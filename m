Return-Path: <linux-nfs+bounces-19857-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC5sCihRq2npcAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19857-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 23:11:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8717422838B
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 23:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CCDC303429F
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 22:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B772527A904;
	Fri,  6 Mar 2026 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dq7Rx/1b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahgZcbgv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E4375F67
	for <linux-nfs@vger.kernel.org>; Fri,  6 Mar 2026 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835067; cv=none; b=raaDMNIAk0aAUyNcAlu3FLCIWAerribTxIrnbFJF/1sypLlbV1AliPR2NTyKulz4OTfMq5qi4hH+n63uZzh6tbTUtroI0WvRdyLaLsOGMYQY+f7EH0ZeTDw3TB66Wtq0NxCjuY9yJ7XD24ZyusoYuZ7svC2XQq0VXxsU9WxWYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835067; c=relaxed/simple;
	bh=QrC4Rp4dvTF8HvBYAFRZ1vgQKpsPyUee4tP5z1GqM/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvCeCBbCK2oB+2B6H1cGEIsMJOzNc1O8ES1RbhScVMcn4B2pqE58TwNSulUEz9uV0ifURCfbibfdPG73Xe7j4r5lRyQeSZ8xpU2H2T1OdS/K0oteSh70wtX57jOJC3bwy54vP4TeFf2snkI69/T4qqa2Cwiw76vm9IZbqnzlsB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dq7Rx/1b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahgZcbgv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772835065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjurH+lN+QuRzoRPe7WmAJw+8thx8HS2eCPWjLqQn7A=;
	b=dq7Rx/1bHlhGPCaQqMbgNgi1lwGA5PZsTK2b5CHhxSuJ0DSog9TgY8JGoPYzNlGQvYlTiN
	v4g/l1QYTkGPLUpPf2D9KM1bvhGpox9wfLd/6CvfL99NhdjuA32hiSK+Pi+FP3P3Uv8XT+
	6c1ADe/j7xFJ3uplhEYVEBWBJw9Dllc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-xH4lBesGM1Wekx1mvUvPUg-1; Fri, 06 Mar 2026 17:11:04 -0500
X-MC-Unique: xH4lBesGM1Wekx1mvUvPUg-1
X-Mimecast-MFC-AGG-ID: xH4lBesGM1Wekx1mvUvPUg_1772835064
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb4e37a796so5320035785a.2
        for <linux-nfs@vger.kernel.org>; Fri, 06 Mar 2026 14:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772835064; x=1773439864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SjurH+lN+QuRzoRPe7WmAJw+8thx8HS2eCPWjLqQn7A=;
        b=ahgZcbgvn80/1Y7NLgRFMddYFvxCAESOjnpD6CfcMkxmrwI8NH+vZ5FlvEhA2Wovof
         txxAjYEEBb14gkDT181WLkJV+lR0itc72UvA23gZ82uzJ196IRlU0TthF4SEhuKJ2MGS
         HJ4GaOZ5hu1I0zM/wOztTuLzACZ78iVdCFmCjS7DLRcIFHfrlHISwbZj2e+Vgxtlsuhw
         vSYL77lYcNfZPNh6EYDuWZ4NRLq0zIXx6pmIDmPRkFwv2fjI4QCa+onh5hgI6lr19poE
         n/sswq6bbrj8wOz7I11JI4PpoaQYUaefFzXPczgDko9NeJl0uFbx3tMlg6sOouMKgFRS
         9Qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835064; x=1773439864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjurH+lN+QuRzoRPe7WmAJw+8thx8HS2eCPWjLqQn7A=;
        b=jpivKCU3sQfayDYhc9Sd4OYctiY7Ymn1kzgZio321n5ci3gjOyvNP/lePSJR6hcKSX
         Y5/RTKBDwi0GjrhcET0Vg80JIHp0Rm4yuYukNPZIdR+qmPT3RDXLfXJ57MoGwOeIJ5Pl
         nEXg4/C0BowqZIW51gaBLPuDbzdJmwoA3RdCOsPksIA8A6r0X5oBJIknV6xAn3wtJ/S5
         xEdOZNvpY9YScXijyXWN6AFpWV09vPFqfg3ywxW9nvcq9dJGdP6YYMcY3lZ2gVE5WQiG
         ED3JTrKyeE23KO2BGYSUi2uj6lix3hoStjFfmInpaN0ziqIBWTT8VofsCbktAXqYyT+8
         yO2A==
X-Forwarded-Encrypted: i=1; AJvYcCW9YF/9vdxnUaGqepSRVDXi1NCxNs7lOOP7AW7HoqqOF8Nz+fbP6S9qdhpry9lUtemwX5XvgaSTyM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZwV6U4v0RlKsOA9ad8wutOzBV1sCHqldVnOHNkUEP7sxtXzT1
	nSvdcBipZfvn6ZCyHCfCb31ugqfJNL1P+QTmx2bHve0gMeOwqe/eESrSQBr+D69+C3rVOwzIA6B
	fb7ivH4/V0AJW1rNUvt6nOYXxGu8vGTxOmmoFUuwLL0CVP/cJwR/5Nia/whbXLw==
X-Gm-Gg: ATEYQzzlHnlsa44nbmMHV/1pfXPIn8M7wh8E1ZXf81O3t5pjFim3BzEsyMMOB81HYdx
	iaVoiKhl6gWr7fag5LTqNJAw2Ja9gvQYIQq4dBbmxWFYUqNxR3134q/wJq250WW2B6bDEZsy/ix
	HHgmseg4u2//yG/BcUB8DnudW3Pdm7xQiCExVab5uMv1GyYGuI7iGLCtG6q1o/ZE7FykReJy1j/
	CCnynJSo9dh/VWtSSUdvGx7N+m/QRKwF5UXBrvdd7RAotG5xJYE5ee6RT13XZ0rDahTum/37lPM
	XymYooAKRZ3h3UEVJA0oepjEBpQsr4943nAmvOeCTMSn86ZeTyFARoSbkezSl4qRaFYOfSiNQEv
	l7T73oZvEtkX3O3HNVMuc
X-Received: by 2002:a05:620a:bcd:b0:8c5:3574:90a7 with SMTP id af79cd13be357-8cd6d53be59mr467499685a.80.1772835063785;
        Fri, 06 Mar 2026 14:11:03 -0800 (PST)
X-Received: by 2002:a05:620a:bcd:b0:8c5:3574:90a7 with SMTP id af79cd13be357-8cd6d53be59mr467497085a.80.1772835063394;
        Fri, 06 Mar 2026 14:11:03 -0800 (PST)
Received: from [172.31.1.12] ([70.105.240.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f48427dsm198462985a.8.2026.03.06.14.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 14:11:02 -0800 (PST)
Message-ID: <6d8ebe30-fe56-451a-ba87-7308c0de2cf8@redhat.com>
Date: Fri, 6 Mar 2026 17:11:01 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsdclnts: fix display of stateids where the kernel
 doesn't provide the superblock
To: Frank Sorenson <sorenson@redhat.com>, linux-nfs@vger.kernel.org
Cc: achillesgaikwad@gmail.com, kennethdsouza94@gmail.com
References: <20260227220841.3015642-1-sorenson@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260227220841.3015642-1-sorenson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8717422838B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-19857-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 2/27/26 5:08 PM, Frank Sorenson wrote:
> If the stateid's file can't be found, the kernel will skip printing
> the superblock and filename in the 'states' procfile.  When this
> happens, nfsdclnts crashes trying to reference the non-existent
> superblock key while getting the inode.
> 
> Fix this by setting the inode field to 'N/A' when the superblock
> isn't present, as is done with other fields which may be missing.
> 
> Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Committed... (tag: nfs-utils-2-8-6-rc4)

steved.
> ---
>   tools/nfsdclnts/nfsdclnts.py | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/nfsdclnts/nfsdclnts.py b/tools/nfsdclnts/nfsdclnts.py
> index b7280f2c..183a02ee 100755
> --- a/tools/nfsdclnts/nfsdclnts.py
> +++ b/tools/nfsdclnts/nfsdclnts.py
> @@ -87,7 +87,10 @@ def printer(data_list, argument):
>       client_info = file_to_dict(client_info_path)
>       for i in data_list:
>           for key in i:
> -            inode = i[key]['superblock'].split(':')[-1]
> +            try:
> +                inode = i[key]['superblock'].split(':')[-1]
> +            except:
> +                inode = 'N/A'
>               # The ip address is quoted, so we dequote it.
>               try:
>                   client_ip = client_info['address'][1:-1]


