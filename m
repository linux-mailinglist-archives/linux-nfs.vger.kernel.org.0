Return-Path: <linux-nfs+bounces-8498-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6540D9EB080
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 13:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4992280E67
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C34419D899;
	Tue, 10 Dec 2024 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPalAP+u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C61A2398
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832579; cv=none; b=lxHqFXpqoMPYvVHmkjJmPmHjCG9+EnBLDS+4Q+6cQ5jZ7Dbs44epTveVc8xFm1Q4IB0TFI5RL/+CaABaJ43gdX0UPoe57HNHIML+nkOXF7dlMKFWBecNjzgo3oX/lN3Fw3r1l8IcJYgMcdHwJjm/qhuMxJNfPBd19BG75Bwy3Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832579; c=relaxed/simple;
	bh=FltgA+XV3w898ic2v6uo2W6LJIOJGBHCPheewZ+csIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sc1YaAewohbj9NnNXho0LP1ojon3mBiFThLY+rN2e6PcpAlgmj9jAtIT2H3eBPMvEyovdngJZvPUlF8VzTmZFQfr5sw5zGeS7Famn04HKZPdyUyKEz5hW5ZbwHmx8MQtrNzBWwunC/tPZpIuyg5MtxA1udp81yblt/vspRMhMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPalAP+u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733832576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=An1Uk6MkjvoIToE0CEzdibBOyP3zCqZcidAA/VQt8II=;
	b=aPalAP+uHfLVvUlnjD4wVzNsWy8qXUr5fbND19EAPe0qnNy5duX150VTba+K3g3/kZE081
	VeH9HXl4B+yM1k74agMFXWFHOqtaKsO16vvImev7LGoj9x8FFyihW4lqPNIKv+w1RHMls8
	Oj4UeBdTdV7+L90KviQLWFjWI2iNuHs=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-0e5zX5yDOSuRuzvoN-mWcw-1; Tue, 10 Dec 2024 07:09:35 -0500
X-MC-Unique: 0e5zX5yDOSuRuzvoN-mWcw-1
X-Mimecast-MFC-AGG-ID: 0e5zX5yDOSuRuzvoN-mWcw
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a812f562bbso72117465ab.1
        for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 04:09:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733832575; x=1734437375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=An1Uk6MkjvoIToE0CEzdibBOyP3zCqZcidAA/VQt8II=;
        b=CFu7E05U8iFWi3NhLBJ2XCImYrab+mVUJ9XTAqv4ARBpGxOR/Mqnb9O46OH26j471a
         tBM144LFmbmP9DvvU4Ou0QbXzUKymUgvs/SDKvCKlkXL/8CK43+DBQT+otH1rTi3OGz8
         /9nHzBo1n5CwA6maJnBb/iWxXQeCpEZhmbfNZbo0KuwvJodhpmTaM3l8vUbRzzDe1w4f
         jTyKgqMuYhC4276IbgjMDMlLXvC2yGvK5vRNVoKGQENNneLnKA4Qb7MXBJ+PLewgApRm
         L/e9ZpmMLNrogEgay+8diLqVC7kkdpFQrSEJmkGHywuWQa54cyMYmqNzxO1ykkwlD2Xx
         l5aw==
X-Gm-Message-State: AOJu0Yy9EX1H18GlwTlmbjawozU3x7WHYl+omVcP3zUbwgteoZC6J567
	4bX/wgK9EhynwXu2lMPYgOWh9ZQiyVYMj077AZvCNf/DPZh01dbnbJ4Z++OOJykVZF5FQzH+APe
	pirr47AvF+5UjyCED+oEvLxqjqf/T0S0189mJEoPbHzHxRzMhXh+wTr8/Ig==
X-Gm-Gg: ASbGncv48nMzE8ORRCg0Vk7w72rsVTcQgDh1fWgLdbcgKa/Mi+QBAxU35ER7md5qCIc
	HRdGsehHOLbK6rXDTQrHzPZ1aWuHTzkCpCvLUajNrl7VF+S4toeBPuWB9bMssY0cxBP8ns75oIs
	NuLLv0qPjATGuPaUINTFdVeLtSX5pU8lleSewPM8FtA7ojU0gbFOtjsi/nVNslycTDkwJhBsuAO
	SvW9zfrWCRmRaI59YuZb5P/wlwq6erQpfVwZqRCRdzShU9zP5DDxQ==
X-Received: by 2002:a05:6e02:1a0a:b0:3a7:87f2:b013 with SMTP id e9e14a558f8ab-3a811c7a450mr178983105ab.4.1733832574955;
        Tue, 10 Dec 2024 04:09:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJtrakWI/yHRwVzrrgDVxQRVrpUEbnaQQBzBLN2E1pAXW9M+KwKx4i1/jeLNjiNJeqRGIJaQ==
X-Received: by 2002:a05:6e02:1a0a:b0:3a7:87f2:b013 with SMTP id e9e14a558f8ab-3a811c7a450mr178983025ab.4.1733832574686;
        Tue, 10 Dec 2024 04:09:34 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2c40f1a27sm839547173.119.2024.12.10.04.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 04:09:33 -0800 (PST)
Message-ID: <59c556ce-a8b6-4e36-912d-dfb280b4ba71@redhat.com>
Date: Tue, 10 Dec 2024 07:09:31 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Benjamin Coddington <bcodding@redhat.com>,
 Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
 <CALXu0UfT-M37mTF52BPP+cuFAi+gya=XeyerJgAzqXSs7Lmwcw@mail.gmail.com>
 <FB5D6967-6BB5-43F9-8561-AA8B3D020475@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <FB5D6967-6BB5-43F9-8561-AA8B3D020475@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/10/24 6:46 AM, Benjamin Coddington wrote:
> On 8 Dec 2024, at 2:41, Cedric Blancher wrote:
>>>> - This feature will not be provided for NFSv3
>>>
>>> Why shouldn't mount.nfs also support using an NFS URL to mount an
>>> NFSv3-only server? Isn't this simply a matter of letting mount.nfs
>>> negotiate down to NFSv3 if needed?
>>
>> NFSv3 is obsolete. Redhat support keeps telling us that for almost ten
>> years now.
> 
> Red Hat does not consider NFSv3 to be obsolete.  We've no plans to change
> our current support for it.
Exactly!

Although the one time I did suggest dropping V3 at
one of the Bakeathons talks... It went over like a lead balloon :-)

So V3 is here to stay!

steved.



