Return-Path: <linux-nfs+bounces-10781-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25894A6E462
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 21:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF543A45E9
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 20:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AE81C8613;
	Mon, 24 Mar 2025 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aasHAbpM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9031C84DD
	for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742848155; cv=none; b=hqg1w73yRfGUiMImK5syP5x9Bv59muynztn13CDHII4teu5aOhct9wGTf5HfmjjPPY5B+MSNIPVVRbq/4n3/OlVkCYKQzK6W61HPzQqLoA/lMU7Npga3eEQYh1b4pB0ViX2WpksXDgQlzm6s7c1WeSoxcZ59UhR2m6+qD4/XWVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742848155; c=relaxed/simple;
	bh=ZvyPOnVFhznFBuJc+c18dzo/Ms1o8uzHZLv97t16KKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAfST7k4Jfk+7cFJ1HH1RznyNVAJ8MD4Az7xxdnziTZeHRpIge4NiGFaoA0M0H9vrWkHOWc0LbXBW6/XxQDvVbevZR2PshylvLzLCiUUkwYToD6jHRaXB5VfntG1mmw0L/H+IldPIywjDQVdyLLlQ9+17HvRAYewwJtLHQPhDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aasHAbpM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742848152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hG7OHoa+hNL/Xeqt2578yEk0EtPbbIlhiEgKko7fcs=;
	b=aasHAbpMsHs++fzgwr9nflhJV4ShsvCVEfp0Q7hhgeBf/yxnHaYJI4CzcwZ/EUwJs9PdIl
	Gc72Oyi20wahxLMINWKL4WF1W+gwDeylKfmBR1Ov6BgJr4erMdgSTUAAFhkiREP2D/gaRd
	lKmpWI38AOgbEIFRoW2Zm2uDiJzCG8E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-mlaYi8ofN5qgW8l8W1O5cw-1; Mon, 24 Mar 2025 16:29:11 -0400
X-MC-Unique: mlaYi8ofN5qgW8l8W1O5cw-1
X-Mimecast-MFC-AGG-ID: mlaYi8ofN5qgW8l8W1O5cw_1742848149
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5cd0f8961so300442285a.1
        for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 13:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742848148; x=1743452948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hG7OHoa+hNL/Xeqt2578yEk0EtPbbIlhiEgKko7fcs=;
        b=dmrOQQK+YwbGi5oO9vcx2bcIP9ayiNo8SK5rFu4qA+5+0vb5xEVRnNFiUCJdAvuMN/
         TMcyLgL2USI6tjzkLaBwL8znuAeuJBsJZ6R6YGAWhrc94buqVKy0xv7+HFxE3YxWv4j4
         vHFW+U+D7ECva09INZWCl9RfGCAF9Bh0RB/ccR8zyZJr9HnLxdX4YdM1cZSswqrVFk0p
         T988/hkwVeDgo5j7NDqZ0ZrtbbC0enpQRLVbVGmxc/FPVrNK1DgYxshnmnx9PxTxbgXs
         Mw4sPA0gKVJ0mZe1L/UsL+FzYAkkuSQ1WvvtkWdDKiZQnNjDLIf2xgXekTo+cGtM+5cu
         6+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXQUnKGOIoyGi7mHh7Dyht53fGMXP0rC3q1uA3t1YB3PMqDmV2TBDjMgZPO9DFA6Gq8eK1bRTvL7/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2zdg5RXW9HHV8Yf7Y/BppQPZ1tnRnayAgw0QiW4QEBMTCwF/P
	s1v0FyXeaslYGrdjUymMTwBQeZz5lexj/lU5Cdn1lbj4a+vQt2AegGybJtdIjguxFYkDYCeatm9
	waYvZXk2T3dOJr0iGigESwj3KHu+qWq9aqPmrvqYzsJL+91upeyEjqQYPZe2ObAcjpXHW
X-Gm-Gg: ASbGncvtA99POyX0tXUn9wPMus4jgb7NsaQ6eCXIxkiMdiXvGGfMrvDlmptik2gK7Km
	JOWvmmED0kwDmkU+s62ENUzvKsuecFK67JHI3lg3aZk2wIoj3Fd7xDdWntEcTyEhQpmOOLklF10
	WNV6jgSgfDqhjYRGkryDYtE7wm57RVruEVwj1w2NdXfWMMSj71dneH1EHngZvTvhVt2eMsEzohE
	cw7pgU9h+3IJszEI/4ukfS4PMPKFJqVMPRXDKFOBfLaxDnbklvOqgm04OEh63UR2p0v8KjcdMs0
	TkWRNrcSSJX5nUs=
X-Received: by 2002:a05:620a:2907:b0:7c5:42c8:ac82 with SMTP id af79cd13be357-7c5ba157edbmr1929937485a.23.1742848148112;
        Mon, 24 Mar 2025 13:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJNayygTyHny/u17kut/a678VKTK8eZO1nWZVCFNvbwH+zFUMVBTnU/wrGLLP+6NwtwIftwQ==
X-Received: by 2002:a05:620a:2907:b0:7c5:42c8:ac82 with SMTP id af79cd13be357-7c5ba157edbmr1929934485a.23.1742848147724;
        Mon, 24 Mar 2025 13:29:07 -0700 (PDT)
Received: from [172.31.1.159] ([70.105.244.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ec688sm551723285a.64.2025.03.24.13.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 13:29:06 -0700 (PDT)
Message-ID: <892715b8-8a43-45fc-bd01-1526b96a3ee2@redhat.com>
Date: Mon, 24 Mar 2025 16:29:05 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH v2] gssd.man: add documentation for
 use-gss-proxy nfs.conf option
To: Scott Mayhew <smayhew@redhat.com>
Cc: romero@fnal.gov, bcodding@redhat.com, linux-nfs@vger.kernel.org
References: <9e7f3d6a-0989-4778-a2c0-ffafdebefa87@redhat.com>
 <20250317132206.1096158-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250317132206.1096158-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/17/25 9:22 AM, Scott Mayhew wrote:
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: nfs-utils-2-8-3-rc8)

steved.
> ---
> 
> v2 - slight phrasing change.
> 
>   utils/gssd/gssd.man | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
> index c735eff6..4a75b056 100644
> --- a/utils/gssd/gssd.man
> +++ b/utils/gssd/gssd.man
> @@ -392,6 +392,17 @@ Setting to
>   is equivalent to providing the
>   .B -H
>   flag.
> +.TP
> +.B use-gss-proxy
> +Setting this to 1 allows
> +.BR gssproxy (8)
> +to intercept GSSAPI calls and service them on behalf of
> +.BR rpc.gssd ,
> +enabling certain features such as keytab-based client initiation.
> +Note that this is unrelated to the functionality that
> +.BR gssproxy (8)
> +provides on behalf of the NFS server.  For more information, see
> +.BR https://github.com/gssapi/gssproxy/blob/main/docs/NFS.md#nfs-client .
>   .P
>   In addtion, the following value is recognized from the
>   .B [general]
> @@ -405,7 +416,8 @@ Equivalent to
>   .BR rpc.svcgssd (8),
>   .BR kerberos (1),
>   .BR kinit (1),
> -.BR krb5.conf (5)
> +.BR krb5.conf (5),
> +.BR gssproxy (8)
>   .SH AUTHORS
>   .br
>   Dug Song <dugsong@umich.edu>


