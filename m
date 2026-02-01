Return-Path: <linux-nfs+bounces-18629-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFmJGlCOf2k9tgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18629-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:33:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C400CC6BD2
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C39D3004638
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Feb 2026 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDE321B9C1;
	Sun,  1 Feb 2026 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPgsO2ZF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uw2shvgc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1B819B5A7
	for <linux-nfs@vger.kernel.org>; Sun,  1 Feb 2026 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769967181; cv=none; b=T0e6v+J8u0dtHmvqDFft7am0J/nlRsnnhuRN9dkC0whl4WEJ8xBsHO6xBrzNgyFm5L91yv2HGn+gsIQSAlfWUx0QT8Vyr+tFOKLjMym8JhmXPzKILlSnfpdBC2V0BIwd6gjVUpUKmM2SgkEzWihkvAKXdxox39cR0qcVTNkIyZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769967181; c=relaxed/simple;
	bh=57g++zJVuyOKNMR8s+wxNvUXvmVLfO4JKTJQuVASiu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gZEkrg06+/bxNkYocjmnhpx97K3RUbqaelO2yhFWUpBJV2bd7Me494HRGJCBhkGpw6me7rrj/I8xDGUPpHGgP/OVadwSUabKySOEMH0SmxiEtdl90SxTK2bUIeb27lM1Uno7BbqzM+P1GdVC9JkVTUPkDVnNpRYKmZbIm69p89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPgsO2ZF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uw2shvgc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769967179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RG7JtzOhsqiZdN1s1QByR9CsJ3uTQiUn81Y94f9h5TI=;
	b=XPgsO2ZFGjdfUTQ23PHISXU5g+0l0zopQFQ9laCnSd09+ZjmofAQghJUzUGAZo/64H7xcS
	EkCVyHvCPSy30G+36uGRl0N4rZxPhZ0Y43m9AX40SLSXx7JnLQ3kvjz+Ngtn1DWaeAR6ZG
	C3e7OyX6/N1QOb9CkBibLn/VPk+ewOg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-g5tZB040MiSDVv9p6feuew-1; Sun, 01 Feb 2026 12:32:57 -0500
X-MC-Unique: g5tZB040MiSDVv9p6feuew-1
X-Mimecast-MFC-AGG-ID: g5tZB040MiSDVv9p6feuew_1769967177
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70a62ca32so1095765085a.2
        for <linux-nfs@vger.kernel.org>; Sun, 01 Feb 2026 09:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769967177; x=1770571977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RG7JtzOhsqiZdN1s1QByR9CsJ3uTQiUn81Y94f9h5TI=;
        b=Uw2shvgcNDBQvtx4S+FXEWhMef0ZjE/8jnU7dE3F/0ZZVrmkoUmT+gZuTSLpLMdyDg
         9iuZJ27Axlsej0RxjnuMvog3nV8biOH79rUco0I2qx0yyEVBOunNOldlmjWp+Wj9OyV7
         zjaotn6xbwBIVevNjVqXG2JgtawrHCOPPS1vdkSbokVKbxNO3eFUBWiG6i2UtfSr4ZP3
         aO17+zsDbNOtQRtvfrRO0yXwVrXEOARenfD22q7p1PhS1tgBmwVqt40K53HucH2gJ/sx
         v1sIlogpTlAY0XHII10PeIY3yrR+KgEZx/fxfCsyZl9AcWO0TKHeIeEkWdrKG1k3QcCq
         fM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769967177; x=1770571977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RG7JtzOhsqiZdN1s1QByR9CsJ3uTQiUn81Y94f9h5TI=;
        b=ObnWzF9+Y0IG+2GUaLIkkr7tUX4HmRcsvWLMaAHcux2LJ0XWKQQawZJzEv+N8eZVgw
         PpTDqZ0xzNfw5d/kcLXvnHEQt7vIf/Xa8ytb4TgquqLlsVUaR6RaA3iFhcSLRDoOxPnp
         AtO0hJTJGJs0+vpckuXpFn7Y1RtKbZLmaVX8DF0pBebvW/RU6oUEA2C5lhm3G/jjohMA
         qj41ZwSZK6AtNp+u+Rdt8korDYF811GOGIZMzeKnWJzSq5uZmpVklqxw6VVx9ZkwyKYp
         eCNFv8fixKRgg3WRt77R4y+3rK/qbdZ6mP05YwPS4mAMNhD88IlQgBpzxkiWMOFji6D9
         Lmbw==
X-Forwarded-Encrypted: i=1; AJvYcCUb45U25aql5dA8q4+41jwDnFrvJYQBnuGEeocky6Pp5yG4QLmzASj4Loq0QyDiIeLO0MWpGfqd/Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjD4B/kyEAlpgf3Zdk9ZNbW4RX2RfZ/tBrI0yhBzl0ASXlDo56
	IQcjClpzvKw5+kHEogS2LU5KUYL7ocMff2+ToDbGZmk6MPw5tBz4CiX+Kttj3UncrqDtzGYrObL
	dfPcSycJkAOPXI/jgSPV8zUKKQaNe06XQXdIBGFEzYQ2qI8jYEhsmWnm6fmy6Ug==
X-Gm-Gg: AZuq6aJzLTtzhsMG/CmmZq3c/jsS0qqxZnKwDwc7aru9Oqx4JfG2tWFwqQ+NA6VWsPk
	DoABn5lIy+yl+6U2KReDUJx7yiGpR3Mrzv8hrkzXjb9iRjvdIvNwuW56l09USslqSCxaac1nTKu
	Lxk+P/EVKv65cf3c2sA614qrV1zUGSW7TfQHY+dYbs4no0l93oG4hSywfkoyTrUQ6tHX7GJ8AbJ
	gZrbVwqw6ra6Yqkr1y9HcY9p0k/ZeOguJC8J1v9hUpvI55Lq4CEBUhs3aNcvA3qip8uAa5itvfh
	GgtOuXMG8tfTsycc18XQyKzd06FHpZPNHFvE03lndiA7HDJIDs23IXeEml2XVnKxy2VN+tMm6BY
	I2/0osAc3
X-Received: by 2002:a05:620a:4151:b0:8c6:de6f:898e with SMTP id af79cd13be357-8c9eb1fbfe9mr996139685a.9.1769967177436;
        Sun, 01 Feb 2026 09:32:57 -0800 (PST)
X-Received: by 2002:a05:620a:4151:b0:8c6:de6f:898e with SMTP id af79cd13be357-8c9eb1fbfe9mr996137685a.9.1769967177095;
        Sun, 01 Feb 2026 09:32:57 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d2847asm1059095385a.34.2026.02.01.09.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 09:32:55 -0800 (PST)
Message-ID: <114d634a-6908-48d6-b56e-28d36f6127bb@redhat.com>
Date: Sun, 1 Feb 2026 12:32:54 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 01/10] nfs.conf: fix a typo in man page
To: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>,
 "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
References: <OSZPR01MB777284386053189423C1D6C3889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <OSZPR01MB777284386053189423C1D6C3889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18629-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fujitsu.com:email]
X-Rspamd-Queue-Id: C400CC6BD2
X-Rspamd-Action: no action



On 1/29/26 3:50 AM, Seiichi Ikarashi (Fujitsu) wrote:
> Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
Committed... (tag: nfs-utils-2-8-5-rc3)

steved.

> ---
>   systemd/nfs.conf.man | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
> index e6a84a97..3875daa5 100644
> --- a/systemd/nfs.conf.man
> +++ b/systemd/nfs.conf.man
> @@ -301,7 +301,7 @@ Recognized values:
>   
>   See
>   .BR nfsrahead (5)
> -for deatils.
> +for details.
>   
>   .SH FILES
>   .I /usr/etc/nfs.conf


