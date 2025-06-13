Return-Path: <linux-nfs+bounces-12437-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A088AD8B83
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 14:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012D33A7D1B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 12:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1E8275B02;
	Fri, 13 Jun 2025 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2Uwe+NV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0721275AEE;
	Fri, 13 Jun 2025 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749816124; cv=none; b=iq8WZ/FwJlztWBneRiJ71jJQKNWu/k0SErVhqwMZ/kV6AqLNw56p9ytS/AFGKv47OoMfvq5ONJWPOOqFELOTovrZ1LLyuckUW2c4j41ts5bDqyydACoVJ3Sop9SdT+97R7/4JrA4h9vJjWjfhF/J6lpjsbF+GuqX5hO00FmI5DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749816124; c=relaxed/simple;
	bh=8qZZcEMlaq3Vypp00BBrhb1qwqZhnJLoqXoQwe+lRtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpguc8hBPCbOa23qqVk1OXndMHDPqFyqDE6eo/etrDiDfV3nM4trHlEFLXfStcgr0xdild4PGUcBJU1eGbtDyU1lv1KLIvb2OrDpx3NQLQnpbcFknrPEK4NJsQodRnJOGErY97EbQKK08QyI6/JmaVHrlBuD8lIyFMCy8pCZVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2Uwe+NV; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so2177407e87.1;
        Fri, 13 Jun 2025 05:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749816121; x=1750420921; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I09yI6md/7rXSeHEhNNEyJMVTDlTe0uyfiH7BsFvjpE=;
        b=k2Uwe+NVjHFJ0gCZL5hDq0drClVfmdsCb2gJb2C5i9ooq2XB8fcrjsFfLGnGXt9OZO
         cHb+XdMjrSy1W/FMfVhhEjjLFh9WvVbcTVbc95EKaD9kHW6Yb8GNSizW6J2MmEH7Btx8
         gbFF9NGzLODJccK001Drr0HGHypxngZJa4PGen5lWh99mtyTw3/2GLY+40pimSxddBrQ
         1c+k72+bUXb5yUZZsbZYjd5UqJySHhu/g5gbuXmURZfH/vbykwuG1RiOj/pmosjMmlaP
         iXhM1ElndZV7NPlF2i1Fu7vy9DdlKx2koU1/X+ZSP4i7m1nXjnYnh82B10RZG9eRbtlZ
         Eqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749816121; x=1750420921;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I09yI6md/7rXSeHEhNNEyJMVTDlTe0uyfiH7BsFvjpE=;
        b=nTJIbj8TCeMeHD2tmTQJeiIMXMkKWkq/jrIiSH73OLZ41pMfSDjrL3DK5FZsbSkoce
         /0P0+Yl4clOxojwbfsZEpJ6jLDqdr3i0UxR4H8Y8RNcLrVnE51tMpdmJiaYsQFRMnVkb
         sHiNqsq9eg3Co/bjcieQbHCNijxfUPmM8f8l5uXrD2e7A5w8AaZsNoqPS41BICg8d/d7
         e5cZC1l1wByk31XqPjZNTdg8KrV0HTwrlxHtxe2HsWYdi1QpKfwZLjqaPjVSTXkxa7Tc
         8IhT/rkxADRFyVuN22Dbfqgh2YeDkiPsrSq6nSI/oRjKpq1MIvj8CU6EKv8rkx62+RHw
         JHBA==
X-Forwarded-Encrypted: i=1; AJvYcCUZBl9+OykSw58vtIo6ymTupKfp7Aw4VRlFJRFe3xfzRc+pzGd/JiKYQ269UegDYr7bBUut7jmEDZQyPlI=@vger.kernel.org, AJvYcCWy2dRy7Po4TProbtYgneT2gn1u5fqpK5a9e16lM5ImzN7/MB5QvSuv42o9HrPrcqtieg1opLH46Ntq@vger.kernel.org
X-Gm-Message-State: AOJu0YzQpBPzUaMy8XYCspe4/pOnRRviDBxxkWzPt5Gxz/LAyWq0qR3i
	lvyb0barG9piEy9o3pPBsABqyEVftgt72BVV8l54ZakySUZVZvAqGaq3
X-Gm-Gg: ASbGncvPxN1S68WHOcS8rZvkiCYxWhbTa203XETuiBtyHKsSpVVHB6gtTUwJxtzLQRr
	nyeEaguCYxXwaWkbIIXdkbjJy56DvKgwvVQ/DUakx+1ow3IJKdAgeTKpgd0YhYk+b2bQ+tS4ksa
	6iXkLzi0lVcIaW0uUmqpdb8cCRREXGVxDY1NkEYGvPXohB5W3T1NeV+Gj/gyErIP8kfYEKOyZAH
	SsQnSsYYFsU8QS3s6ZOio4yo4N9PEeRNT1mtqcUO5b8ImaAxiypuFM6wbwi1hX+qSoRxkDD5Jot
	ChSSZeOSPl/O5I88G1rK4vPQyg3AdZwuWKtwecuBacEapxGi/g7+nRZiyF5ZaRQLiC0ZcTEekWm
	0bbI8ZlCz8KgL95s=
X-Google-Smtp-Source: AGHT+IG2udKV9cM84btHRYB6qtTpXt4G9OM7Ds+sqU9jJDdLi7FlzLyZ425DIsBGa8wvPeGzRnTeyQ==
X-Received: by 2002:a05:6512:6cc:b0:553:a867:8dd6 with SMTP id 2adb3069b0e04-553af8f1d7fmr860842e87.9.1749816119667;
        Fri, 13 Jun 2025 05:01:59 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([178.34.112.253])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1dc630sm425675e87.196.2025.06.13.05.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 05:01:59 -0700 (PDT)
Date: Fri, 13 Jun 2025 15:01:57 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH v2] nfsd: Implement large extent array support in pNFS
Message-ID: <xr7sopuwurexwjcvcm2iaikv7yax45ryqxdpjyipcv7obph62i@xbdkqwznujsn>
References: <20250610011818.3232-1-sergeybashirov@gmail.com>
 <1da1e7db-c091-44b0-b466-cb8aaa6431ff@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1da1e7db-c091-44b0-b466-cb8aaa6431ff@oracle.com>
User-Agent: NeoMutt/20231103

On Tue, Jun 10, 2025 at 02:10:46PM -0400, Chuck Lever wrote:
> On 6/9/25 9:18 PM, Sergey Bashirov wrote:
> > +	xdr_init_decode(&xdr, buf, buf->head[0].iov_base, NULL);
> > +	xdr_set_scratch_buffer(&xdr, scratch, sizeof(scratch));
>
> Consider using svcxdr_init_decode() instead.

I see that svcxdr_init_decode() does the same two steps. What I
concerned about is that it takes the top-level svc_rqst struct
and modifies it. Of course, we can pass rqstp from nfsd4_layoutcommit()
to the layout driver callback. But then we would need to make a backup
of the original xdr buffer and stream position, set up and initialize
the xdr sub-buffer, and at the end restore back the original xdr stream.
All these actions seem somewhat unnecessary and not so elegant to me.

Is it acceptable to keep the current solution in the patch or am I
missing something?

--
Sergey Bashirov

