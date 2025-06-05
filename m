Return-Path: <linux-nfs+bounces-12126-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B412FACEE1F
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 12:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE533A1B13
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 10:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA003C17;
	Thu,  5 Jun 2025 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ST8OsFnz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C556215062
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120799; cv=none; b=MsfZT/VkA90qja/T1jCKPcMdAb8C4bkx4OVvUfwEoEZgBeoYxbK1g/1h0j5wEqovBlan/hkxqha3zGchkLFvtrmUsjafW9oSQgiTpS2YoR3HRgmIEojbfUkw7hLtofU72zJeSVtnUPgvllHNb26Zb7QMod4R67rzvLxRb5WEmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120799; c=relaxed/simple;
	bh=vbD8OLEHkvKYx04eBMxH8jjdaAv27DrbJvnP3hSyTQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PjXNgZW4tyYVJTygJKxaP7RN6kI7h5U2ZhQpux4s1Scc6fizWjvnehYY0iKySL+yBbkUSpX24SxzBMQS5F6+NBZWBi/wzZ4JBIpfiOVrkgGmOasXM7rohT/0PN4iAGZfOrHkWHMX2YC9dNXpMjKnFmYAqIVy1iOotm8vupF1d/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ST8OsFnz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749120796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdD/WfBJdxY0Jrf0p/P70coEEtIV/Iw9+lY3TTYoOrs=;
	b=ST8OsFnzQ5krvQLNMUZYrK0dcR5bODXV1J9rckX89yn9vC+EvUmNfB0ZIE1+3AcKbx8egk
	NMU2PtFAvhlIbe9X5GcN4s6jEHyFrFlVe8Kdxb65dl42+/PYViCSOT1md3J6EVpeyN2Ctw
	JRAghCq7BF/ykfDtdzRaXSMVZYt15no=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-dpc7Toy4Niukmj5GzJhNWg-1; Thu, 05 Jun 2025 06:53:14 -0400
X-MC-Unique: dpc7Toy4Niukmj5GzJhNWg-1
X-Mimecast-MFC-AGG-ID: dpc7Toy4Niukmj5GzJhNWg_1749120794
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a42d650185so10225991cf.0
        for <linux-nfs@vger.kernel.org>; Thu, 05 Jun 2025 03:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120793; x=1749725593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdD/WfBJdxY0Jrf0p/P70coEEtIV/Iw9+lY3TTYoOrs=;
        b=P4VQU/1pQOlf90HEyk1rwtDhu6yv6rLOWS/AmCt4AXh2XOY6o3S3TneydNPCG6fJ9y
         T8nJOkL9tOj/7VdtX8aj5iu3gmkRb+SiWOx2PczhZjUOdHYy+Ap3W4F7ut16mL8eg+XA
         hPXr4Tl0REX+QyiNOKJJ2atzkkJva8ZrpJgQcIgH5py0x4CLgngeuqpGhxaOcwMB65A3
         d2gSEyndodUtKQNkyt1+jOb8qJwLrpPVSXLpBlJiuxlFW95G/JuUSpORDCAD+9YNAT96
         90fyHjobFtzhTcpV05JKJwe7hozzQxR4Hk3R/cmVzMuvhDqCUC5+82KP8zufFucJDY7x
         RCeg==
X-Forwarded-Encrypted: i=1; AJvYcCUnlusU0bc51kGDytaoSM+asInFoL6bURSQUNI7IcO2ZBz3mzixTq6MHhhJ/LAdAij1NQ7Pv1FpGPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1DJb4pfuw9rmxRd8ohPvbFRn6I5GiP069BcoBfy9Mos+lk+Lm
	cRoR/F97QJ1SyIAvmwNZEntNMrckf57Ivl3YxxKgo7dbP0NTj8ElV+8qJFp9YrpgWm8HK9x1V4L
	6zpJ2yZhEWJ7vspR5aw3DKRtW8l8A8meWP6l7iFgklCRcSXL1A1t6gjYp1TAfPI35ViCiIA==
X-Gm-Gg: ASbGnctuczJPGsu9mDbzAhWFzhqqzQX3nKhdGP1bLl/fKD2Xjabv9aiMhxzu43qTOei
	fcqqMWwh/99O8n2w5W+WJwk1eFbDGfPsupnMR+cykrdnuh0vazhZlGoswfGXjidckfpZZHsO9tO
	1IrOWOnHaEXZsiEKkw6SDmYF/Momuk5e8pkHwRhGvgd6uRkdgih2yQyp68fL9JYpGqu6SBwEJL6
	xM8DCcWEQHnrwFT2M5lNjDoCGhTbx6h9wOvIxzZXYD6gAbrx++wyd/zJ9hp1UWVt52Ja3KF74dY
	ftlZ4fO5JqY=
X-Received: by 2002:a05:622a:1cc5:b0:494:b258:abbf with SMTP id d75a77b69052e-4a5a581a171mr94443891cf.52.1749120792944;
        Thu, 05 Jun 2025 03:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgxyz2DHnZbnNG6WjHcR2aSfS/KTVa3nd8SzcFpYOJLAaxJL0FuaccbR9cv2nuUOih2abLzw==
X-Received: by 2002:a05:622a:1cc5:b0:494:b258:abbf with SMTP id d75a77b69052e-4a5a581a171mr94443651cf.52.1749120792566;
        Thu, 05 Jun 2025 03:53:12 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.242.209])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358d55afsm111815001cf.42.2025.06.05.03.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:53:11 -0700 (PDT)
Message-ID: <495a075b-22ef-446d-97e5-e0f92ae19049@redhat.com>
Date: Thu, 5 Jun 2025 06:53:10 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] systemd: Allow nfs-idmapd.service to be started
 without the server
To: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>,
 linux-nfs@vger.kernel.org
References: <cover.1747753109.git.antonio.feijoo@suse.com>
 <39e5050139e77397037f67705cf9d97fbe6a1520.1747753109.git.antonio.feijoo@suse.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <39e5050139e77397037f67705cf9d97fbe6a1520.1747753109.git.antonio.feijoo@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/22/25 2:59 AM, Antonio Alvarez Feijoo wrote:
> rpc.idmapd may be needed in the client if nfs4_disable_idmapping is
> set to 0. By replacing BindsTo= with PartOf=, nfs-idmapd.service can
> be started independently, and also affected if nfs-server.service is
> started or stopped.
> 
> Signed-off-by: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Committed... (tag: nfs-utils-2-8-4-rc2)

steved.
> ---
>   systemd/nfs-idmapd.service | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/systemd/nfs-idmapd.service b/systemd/nfs-idmapd.service
> index d820f10c..3afdcea0 100644
> --- a/systemd/nfs-idmapd.service
> +++ b/systemd/nfs-idmapd.service
> @@ -6,7 +6,7 @@ Requires=rpc_pipefs.target
>   After=rpc_pipefs.target local-fs.target network-online.target
>   Wants=network-online.target
>   
> -BindsTo=nfs-server.service
> +PartOf=nfs-server.service
>   
>   [Service]
>   Type=forking


