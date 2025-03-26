Return-Path: <linux-nfs+bounces-10916-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7228DA7204E
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 22:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86AE93BB964
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 20:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685725E800;
	Wed, 26 Mar 2025 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEGZVwgR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410651F8738
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022775; cv=none; b=hz/ZRoeG5Sn1gyb06fCIpv84gsyozG7cOeaavFpXHgUZI+WLi0nVF7mkZ3w1+wPyITjpaO7K7ef8nyRDw9RVukyE3G47/6+EdAWQskg5PtoE89xpnlz5iZFBD6B+lDO61VC/J8lnyuBcCWJIlNpzObTnngu10XAUoPMFlCFEkMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022775; c=relaxed/simple;
	bh=/gjdsyhWZIGv4CvwFe+S1mE7q2X9cRpM/lOYwfZLd80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3xntlBvaCLrUKo6oHno6Pnk9aRAtoxcLst2mj0XQN0PETqagSrse1xapF8ejOlamvrE42AG5ZejPNvHA2rQn7v10pgJlQf/kA03FqEoqjS2QnYLqB8/UA42tsSWTp4lH4c3OBRMyOW56ztKhtNazgRFQeJ5VRzjyjO9hhWV8/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEGZVwgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8DEC4CEE5;
	Wed, 26 Mar 2025 20:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743022774;
	bh=/gjdsyhWZIGv4CvwFe+S1mE7q2X9cRpM/lOYwfZLd80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEGZVwgRJNyZ9WeQ1MNfj4yAi8tOtklEmy2/Vbslzd2Mkl/suY6ewVqWY7FoDc/o9
	 +tC89oXZG9EqaedaNN3ANf8M7DgBZEngUx4il1K07uw5NhQhbBibptzl5rIhy01L3g
	 1fx0h3qEx5sje7AJyej1G/JboBEtKoVGuS3yYQTBn0Htd4909smiyxCel/PO1xOdaH
	 9aVNUX4Bm0KMPEu8zb7YlAcKGo5kiX9I1ItN94W2FCWyckmfiRXUrhzDA5sO3BF988
	 zfgJlp2vT3UD8cuhrET6omyMyUX7tFgWTEnj2j0H5siC6o8b+uwYnKee89hOLW5Bnv
	 I+09J33gwQRFQ==
Received: by pali.im (Postfix)
	id 4F204818; Wed, 26 Mar 2025 21:59:19 +0100 (CET)
Date: Wed, 26 Mar 2025 21:59:19 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: add dummy definition for nfsd_file
Message-ID: <20250326205919.gdxxtcejde2jpil7@pali>
References: <20250215120054.mfvr2fzs5426bthx@pali>
 <4c790142-7126-413d-a2f3-bb080bb26ce6@oracle.com>
 <20250215163800.v4qdyum6slbzbmts@pali>
 <a8e12721-721e-41d1-9192-940c01e7f0f0@oracle.com>
 <20250215165100.jlibe46qwwdfgau5@pali>
 <20250223182746.do2irr7uxpwhjycd@pali>
 <20250318190520.efwb45jarbyacnw4@pali>
 <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>
 <Z-QYjLJk8_ttf-kW@kernel.org>
 <eedc7b36-6ac1-498e-8e73-1608621d84f7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eedc7b36-6ac1-498e-8e73-1608621d84f7@oss.qualcomm.com>
User-Agent: NeoMutt/20180716

On Wednesday 26 March 2025 08:33:32 Jeff Johnson wrote:
> On 3/26/2025 8:09 AM, Mike Snitzer wrote:
> > Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
> > so older gcc (e.g. EL8's 8.5.0) can be used.  Older gcc causes RCU
> > code (rcu_dereference and rcu_access_pointer) to dereference what
> > should just be an opaque pointer with its use of typeof.
> > 
> > So without the dummy definition compiling with older gcc fails.
> > 
> > Link: https://lore.kernel.org/all/Zsyhco1OrOI_uSbd@kernel.org/
> > Fixes: 55a9742d02eff ("nfs: cache all open LOCALIO nfsd_file(s) in client")

As this change is fixing compile error, should not be there also cc: stable line?

> 
> I saw this issue using crosstools/gcc-13.3.0-nolibc and this patch fixes it.

So maybe the commit message can be adjusted, so it does not say only
"older gcc"?

> Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

I have tested this change and it fixed compilation for me too. So:

Tested-by: Pali Rohár <pali@kernel.org>

> 
> > Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
> 
> note this doesn't match the From: address
> 
> 

