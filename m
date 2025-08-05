Return-Path: <linux-nfs+bounces-13425-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9747DB1ABD3
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 02:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3316C6220D4
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 00:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F263213B5AE;
	Tue,  5 Aug 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H3rlI24D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E403FE7
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754355003; cv=none; b=iws2CySqfODHlY4mLj4+6b5gRqqDI5lagHoM2fnnu/m2hwFdDp6qSFK0d1jkpUUX2u/enugmEo8VQ1X1b3t2nvNayvP9YCN+Z5shI4QrpCiCs6Y4qzPzPFSoAL1XcW8QpZ9u1TUzJN5CzrnuuwBlB8B9G7xR9IR2AnuMFV+hXew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754355003; c=relaxed/simple;
	bh=tp4LUybg21H6fyW47VZKnfnLBoQoWUkCXDoqquXpH1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqvaQ3aJDbg2KL0eqjzbd5KVDBcH0BZNKACLLRAkh0HK7J7hB7wmcHw5+TSReTM0og2GdfmhSz6YGKxi7HYy8iJKk+UjrNW9G7wCEbAwA94iWMWN1CExsOkduMjOKjuXlxISqZPAPJSUbHy/OJ/+g+Ochghr5FV6jckPLBYbZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H3rlI24D; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615398dc162so8780445a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 04 Aug 2025 17:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754355000; x=1754959800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7SmZnL6VRL7+bBKpNPXZ08UcqiyXXe6UNiZZAKtnzU=;
        b=H3rlI24D1kXwrLXSgg7mD9ozXVrEOM+fs9aOoXv/hxAhddxsREof8faZv11jtGLSEL
         4cGRub/NMz2mj4j2QtMPHeGurUDcpI5yScIttSsIl6crIuw/6Fwq+hyB53TQj5RIhKIA
         /ZKM/XcldbTVNsKiPULdubq3fzqbAXsHlv4EeRhO94/vBGfEiTnG7ly7LoYN4nx+lf0T
         p+IkdkbbhM0HBnygK/sEUhbHhL7B02WsuR9wRUbmbpvpma8rrFyPPgm7zd6efWmQ0Faj
         xKpRFtktIPLwCJfSpvycK4fFK3siOskxk5aEmNSWQ0lexnf8TTRTxh2sGtALivLP3+CP
         VOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754355000; x=1754959800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7SmZnL6VRL7+bBKpNPXZ08UcqiyXXe6UNiZZAKtnzU=;
        b=H0KINVPakVizByzFU+/w9KXK+ZFu+taEWA2moo4JlJRE42ZS98cxOp8tUK+GhDv3MX
         dHQzHqRq8nAzkTRtTHVp4qRc9A4OP2ZGTwy06ZMWfV0vho1RfxFu9pxxKhSp1Lawsy4E
         jg7U521cn/aQfRGewyKpEHNVnAEt730D1QiWLu7ci1e/oTgVEeJvw7O022tKgjGGVuzI
         ykSJE8AX3qtsvx+9s9g+LemqMAnOtTySn0NlEy7ZcdH4PURhCWIuQijj4vb+ClsFDXNK
         UpCTsb3Fcu943kKLpZ4Hd9Nc73I5VHW5lkrkhXZfcuQW1M2IuB20kmW13Wene+WmC1mR
         2j6A==
X-Forwarded-Encrypted: i=1; AJvYcCUgyxu51X6SzBWDQtUPnE0VwqvdCv2vjmRn6Xkz3KC807iMaHnVneYPp6vKJQTMr00HXovxm+Blba8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1RtZGYo7usgDvgZXeKccx2d29B9R/bXV5V0B3SyefdMgDXJtr
	XYCShCPAaQNEWXUOvAtcrvRKU4FyhVCAIa0rcQBfbbRDfnn+AW+nrJl1Yi/ZGLFcVg==
X-Gm-Gg: ASbGncvj6wMmz0ajUn3FYqxv9hUi6xCMYVsWeN1os3aDlCJlW48tD26B/asjj9VyDad
	aQoyclPiorpMwaUNqD+EWEVscXbS2ANcuFY7hFu+pyUrBu9nt6pEVn5DXQv7c/WgTvU2inZaqAc
	BJoZH88HQfoAFWaTlwDEx+SWUKpTUK4FdmT9x0ftQYO29pCOUDtxCxiwWo8wInfBN29FJ330Fgh
	nktVw1iMumuHC1ee9FoOYbB+Pfyzv90hhuM1K5H5V/p5RN4CrRaYin6/GP0uujwGBs/LHvfsw+p
	Ktyp5ESOwJ5B+qWO7efomBR3rGyLCiz0Jf48Rr4fZT1e6s1uaqj/R8ittqdLOtbOybsdXM3nmO4
	jAhjs2HnDuYCbQjMVf/qOKA==
X-Google-Smtp-Source: AGHT+IGIQjCeSDqY/s6JlgToDECfsuhclrMba5m8nVMsSJIXgIMv0OCDtHOftBADr/L00dAGjPOkFQ==
X-Received: by 2002:a05:6402:26c9:b0:612:7439:4190 with SMTP id 4fb4d7f45d1cf-615e6ed02c7mr9869858a12.10.1754354999710;
        Mon, 04 Aug 2025 17:49:59 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f15fa5sm7414342a12.14.2025.08.04.17.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 17:49:59 -0700 (PDT)
Date: Tue, 5 Aug 2025 00:49:57 +0000
From: Wei Gao <wegao@suse.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, libtirpc-devel@lists.sourceforge.net,
	linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
	Ricardo B =?iso-8859-1?Q?=2E_Marli=E8re?= <rbm@suse.com>
Subject: Re: [LTP] [PATCH 1/1] rpc_test.sh: Check for rpcbind remote calls
 support
Message-ID: <aJFVNdvkdfqPFsse@localhost>
References: <20250804184850.313101-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804184850.313101-1-pvorel@suse.cz>

On Mon, Aug 04, 2025 at 08:48:50PM +0200, Petr Vorel wrote:
> client binaries rpc_pmap_rmtcall and tirpc_rpcb_rmtcall require rpcbind
> compiled with remote calls.  rpcbind has disabled remote calls by
> default in 1.2.5. But this was not detectable until 1.2.8, which brought
> this info in -v flag.
> 
> Detect the support and skip on these 2 functions when disabled.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
>  testcases/network/rpc/rpc-tirpc/rpc_test.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> index cadae55203..1a8cf46399 100755
> --- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> +++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> @@ -53,6 +53,11 @@ setup()
>  		fi
>  	fi
>  
> +	if [ "$CLIENT" = 'rpc_pmap_rmtcall' -o "$CLIENT" = 'tirpc_rpcb_rmtcall' ] && \
> +		rpcbind -v 2>/dev/null && rpcbind -v 2>&1 | grep -q 'remote calls: no'; then
> +		tst_brk TCONF "skip due rpcbind compiled without remote calls"
> +	fi
Should we check rpcbind version? Since you mentioned remove call
detectable until 1.2.8.
> +
>  	[ -n "$CLIENT" ] || tst_brk TBROK "client program not set"
>  	tst_check_cmds $CLIENT $SERVER || tst_brk TCONF "LTP compiled without TI-RPC support?"
>  
> -- 
> 2.50.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

