Return-Path: <linux-nfs+bounces-4048-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7393690E2BB
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 07:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26FBE284119
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 05:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD38C5588E;
	Wed, 19 Jun 2024 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItZoAyDq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CBD4C635;
	Wed, 19 Jun 2024 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775281; cv=none; b=sWEpjgYcyaXjfny99zaXQSKSypBrzjG7mh9uNx0Bozo8SXFMeNLKkawYqoxVJ0yKdoWWEiiEj5nnoPd7kz5mKLBm6CL7JNdSb2Riov1zO1FL04P8mRY4UXrTSdcyszpMhBUg4VybzFlSxFGZzszBbvzu4AA0NqRXR2e9p+ElYmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775281; c=relaxed/simple;
	bh=+x8K8+jvDeyavKrJ3TJNFrLayuAVvxFB/ZRzxaqejPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wz7dJ0FiMxt6qo+2F6T2bYPWXnhi063UEooNr4OlluUxWwX41G3YhQKchv3p/gxWKZJZwyi2quw+buBh/d6e40C+k8bD0AXl9yFZ92gkodd8sWbeeDjGVsQV4gIXnsEs9As8BzQ0GIBxdMv5SI0H+BxGHXSpkgDKgQtfMG7ZZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItZoAyDq; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4ecf43f5537so275211e0c.0;
        Tue, 18 Jun 2024 22:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718775279; x=1719380079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x8K8+jvDeyavKrJ3TJNFrLayuAVvxFB/ZRzxaqejPk=;
        b=ItZoAyDq1G+/ibq+ubRBG4N8adNK4z7vLEzp3jqvaxaGqroW4utDaCD7RVSEuoyKbg
         e9qoFZkuP3oXbQJKVvmhFSyPWpIbH+5PISmNuaI5efVoy/5YXkPvgTkaUnXPiUl6/8UH
         NWKQQCPbzUWOfB7dXH8GtBPtr0+Mhh+hYqEhp0oRgkXIUwdETazKVlk/5e+3Mv6SrOHy
         jU9SFgI6l1mqBN6yydKqe/vOkE9JnfrRrrc4auOCl++8QRuThXtxg3Dsypa02pzVY+R6
         XJDqTikAo0ZP0wKduJjjTSp6PeVTKqa5je49oFq0R4mZEFXs60dv/I572sihpFBRPw6o
         hJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718775279; x=1719380079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+x8K8+jvDeyavKrJ3TJNFrLayuAVvxFB/ZRzxaqejPk=;
        b=mv7KUoMc0LZcasUzFaQV6H0pGN9sz+fPzIL7Wj6fUtobpYJEujREZoIKp6/VBc8L4+
         kmAp9I0BrgMjkS7KC/FcxpZown6XIgH+t50Pyk5rsaICco/Zl5A50C9DeSGCD5tTrBWj
         9UifwnKpbfpUYVPCsLak5Pk9bxLNQ6K1LeOwVToqcwB5Y8VOE3gmrf/eyIe/N2FK1Bv+
         Tqlybnrdi6UZupD80T5SCVBEfz2D1VldLukv6cRm5lJmnuu9waHrDsKsXwMF11DUu9HC
         xZXjH5HgYkHOQZPhoq3nK2ja8nHG4nWJxpqYlCmROJGm1ld3v2/Zg5DEPhFf+Auzjc49
         Q/9A==
X-Forwarded-Encrypted: i=1; AJvYcCU3xNPJGpnKFLudRMsnRaN/j7CQnF7kcTd/5nl1TjJeCNenH2RP9Koq2MFA1E6nMj+sfz5w0mcbUiPx30snVErI9+a42rd454pCbknZDeveKG6GKTm6GMvfVmQoJJJFGjlYxLjmKoAeXUvxmSn3M0A8uaLx4ctE7Ex3F+BEWw==
X-Gm-Message-State: AOJu0YyPanxx+eE5VYMsH3yTsdPZOmUQpbvmDZsKmXyTWPAktPepX2VH
	+/n8wnv0921hianmg8ShgKgH7mtvFwwaoGiuQSj3TrjLwMQB7o3Wk/rh/AhBjsOsWXSHaX88P2K
	QgjEG3gtFh2TZhlmH3Fwk5HhAd9Q=
X-Google-Smtp-Source: AGHT+IEqTCVFaF3Qw5cbwz5Gug/v23/DYwJI/kOp2bT/pFC7Ukb+UHmO01zJBypiA4srCgLBjMcc1vytH+VF64qDXrU=
X-Received: by 2002:a05:6122:3124:b0:4ec:f3b4:6283 with SMTP id
 71dfb90a1353d-4ef277bedbdmr1929947e0c.6.1718775279172; Tue, 18 Jun 2024
 22:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618065647.21791-1-21cnbao@gmail.com> <20240619052740.GA29159@lst.de>
In-Reply-To: <20240619052740.GA29159@lst.de>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 19 Jun 2024 17:34:27 +1200
Message-ID: <CAGsJ_4yp1u7fbXCSmu-mKhOP9SnCZXrC857LJHpHQOB3yC+MQg@mail.gmail.com>
Subject: Re: [PATCH v2] nfs: drop the incorrect assertion in nfs_swap_rw()
To: Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-nfs@vger.kernel.org, anna@kernel.org, 
	chrisl@kernel.org, hanchuanhua@oppo.com, jlayton@kernel.org, 
	linux-cifs@vger.kernel.org, neilb@suse.de, ryan.roberts@arm.com, 
	sfrench@samba.org, stable@vger.kernel.org, trondmy@kernel.org, 
	v-songbaohua@oppo.com, ying.huang@intel.com, 
	Matthew Wilcox <willy@infradead.org>, Martin Wege <martin.l.wege@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 5:27=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Tue, Jun 18, 2024 at 06:56:47PM +1200, Barry Song wrote:
> > Fixes: 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS swap-sp=
ace")
> > Reported-by: Christoph Hellwig <hch@lst.de>
>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> A reported-by for the credited patch author doesn't make sense.

Andrew, could you help remove the "reported-by" in the commit log?
Alternatively, would you prefer that I send a v3 to drop the "reported-by"?

>

