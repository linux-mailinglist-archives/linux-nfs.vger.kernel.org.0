Return-Path: <linux-nfs+bounces-1045-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E750F82B638
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 21:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953E228887B
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 20:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730D558110;
	Thu, 11 Jan 2024 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSG8R0r0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4858112
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705006178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aLXbaqKzgiEM3AyKd4IkbOB5j5iihdo8bHAzeBXy2rc=;
	b=jSG8R0r0RBa9qlGBv0tPPfzkfEFw5T8DcnRVnpPpgRgJIa16W8vwGKU/N5M+0y29kNIkFQ
	ZeBlCueeLO7GoQgKXW5/E7P1Sk4pjT0B+RowR7CLm2l4qLw/1zxt29GgKrjx6Wgbu0VZvD
	MQCRBnxSg83EZzT8rGy3gaG4Z4yKgyU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-49wWaz_KMUujtKr4bVqiwQ-1; Thu, 11 Jan 2024 15:49:37 -0500
X-MC-Unique: 49wWaz_KMUujtKr4bVqiwQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d400cb3e80so32776775ad.3
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 12:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705006176; x=1705610976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLXbaqKzgiEM3AyKd4IkbOB5j5iihdo8bHAzeBXy2rc=;
        b=B8Y+k0XaZHn3If/eWg1CUpyjur2bn7H6VB3twGMU+SgUAOqjDPMngTF87vFmpMnW7/
         zyAJe9PWm5BfK8G1MjYFuBNiULDs73LSxz0bviJ4BqJP2dgeDdCkkOhgwmUbQ7K0xSt7
         P5jjO4d5nINNgqJKJIUwduh2cSwT4sL5LFX0paWd0f9tShGmqyg8OJX8G8yBF0Waitpp
         aGVj0FgIg0JfqkmlEhWf3snch32tj7hqNQGj6xiFfIJUv7xpnzitoepy9chHGSDvkqX3
         QmDigTAuVGHMYfp2uFEXDbkOLN2fnqBJHFzr1n4UWzN17VI7iPiPWhCPVMoPVSAXOTmC
         ClGg==
X-Gm-Message-State: AOJu0YwW2G2npsaE2MgtIBzcBbtgbgZT9+5f/CjhIkxnspI7IJpOLTr4
	wQyR7YW6983U7TOk9y99XEiEXWzaQ94500wgQjWikKCUL90Gr7ZHEsz7gAyTzyHBvs3MgOzRHWM
	XvkkxyB9laOHAU0rcNlGRwqG9vG4OZ7kRd8F1uAg=
X-Received: by 2002:a17:902:dccd:b0:1d4:ca51:aa59 with SMTP id t13-20020a170902dccd00b001d4ca51aa59mr255103pll.107.1705006175897;
        Thu, 11 Jan 2024 12:49:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRwOsmJiFqMTn26S5YvKxVZ2DCESV7/gasfhyuksYdY2PSGNjc8GAqi/JSSveMLg1OpzXKtg==
X-Received: by 2002:a17:902:dccd:b0:1d4:ca51:aa59 with SMTP id t13-20020a170902dccd00b001d4ca51aa59mr255093pll.107.1705006175578;
        Thu, 11 Jan 2024 12:49:35 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902740500b001d58ed4c599sm1530046pll.308.2024.01.11.12.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 12:49:35 -0800 (PST)
Date: Fri, 12 Jan 2024 04:49:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Yongcheng Yang <yoyang@redhat.com>, linux-nfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH fstests 2/2] generic/732: don't run it on NFS
Message-ID: <20240111204931.oqbub6crymt2misb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240110-fixes-v1-0-69f5ddd95656@kernel.org>
 <20240110-fixes-v1-2-69f5ddd95656@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110-fixes-v1-2-69f5ddd95656@kernel.org>

On Wed, Jan 10, 2024 at 01:27:28PM -0500, Jeff Layton wrote:
> This test sets up two independent superblocks with the same backend
> server, and then does RENAMES of the same files in the two servers. This
> is basically trying to simulate the case where two clients are competing
> to rename files in the same directory on the same server.
> 
> This test would usually pass vs. an NFSv4 server that doesn't have
> dfdd2630a7398 ("nfsd: fix change_info in NFSv4 RENAME replies"), because
> the client would end up improperly invalidating the dcache for the whole
> dir after most RENAMEs.
> 
> However, this test doesn't (and shouldn't) pass on NFS, because the
> client has no idea that a rename has happened on the second mount. The
> expected behavior for the NFS client is for it to use the cache timeouts
> in this case, which is what it now does with the above server bug fixed.
> 
> Exempt NFS from running this test, since we don't expect it to pass.
> 
> Cc: Yongcheng Yang <yoyang@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

This case is written for a nfs fix at first. If nfs would like to skip this
test, I don't know if it makes sense to keep it in fstests?

Thanks,
Zorro

>  tests/generic/732 | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tests/generic/732 b/tests/generic/732
> index 785aac58f361..5b5087d5accd 100755
> --- a/tests/generic/732
> +++ b/tests/generic/732
> @@ -22,9 +22,7 @@ _cleanup()
>  }
>  
>  # real QA test starts here
> -_supported_fs generic
> -[ "$FSTYP" = "nfs" ] && _fixed_by_kernel_commit fdd2630a739819 \
> -	"nfsd: fix change_info in NFSv4 RENAME replies"
> +_supported_fs ^nfs
>  
>  _require_test
>  _require_scratch
> 
> -- 
> 2.43.0
> 
> 


