Return-Path: <linux-nfs+bounces-9531-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C89BEA1A235
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 11:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E7D16D2E6
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0C20E009;
	Thu, 23 Jan 2025 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="U3V3zBmQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442120DD68
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629522; cv=none; b=Gq9Ylvr/TFresZC/bqsbs7NlAbgPEes0/1+mVBsYLJ/IEX8h/szPn8DUpsvaLrVJOn41MBdH4FxIBcOlHtw50GwMe0nzbrlkPs8q4Ne7GPfSFYmVOwWr67X05c5DQjQH0diSL/rjF2++NpTDLjsyoTBjhPNDTwRKG0mhaxLE1lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629522; c=relaxed/simple;
	bh=64ZBKi3fVrhSq4jQLlJiPHRsTHqirJcl7b5Uyt/7Vj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRjItc3760N+UOHEN68VpfRxqAIPEwFYzQJkwUJnrblTZbU3g32mPHGpgMU7XJKSseYtsa6h4lZXFtQODdABynuftwBFJTuD9Lv0kE8pwfPRB7CLLnVNWecmobQe5Bh1nfn+xMuefqmNwteJTbg5dOqQYN82Niirioo9B+xAKtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=U3V3zBmQ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467a3c85e11so5084181cf.2
        for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 02:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1737629518; x=1738234318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=64ZBKi3fVrhSq4jQLlJiPHRsTHqirJcl7b5Uyt/7Vj8=;
        b=U3V3zBmQHOTOpVC7or+WO2kDmdiy1umbmtyf9HzbO9ZB3abrNB9/u9geByO9JgSc2b
         zF7iE4v41JOvOfTkwMpBJDHshs7W+3h0P9qz634hVaxkzP08wB9Q60hGe66gvDlmPDV6
         nL93y/R9E+77hrxXFDiuOmzAIp1rzsH6/LRG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737629518; x=1738234318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64ZBKi3fVrhSq4jQLlJiPHRsTHqirJcl7b5Uyt/7Vj8=;
        b=sbyZZf6ZQhzviy2GTI6J6AxAU8VZykWt28NaBSMae+1MMvZ57GFE0dJ+ZdmCCjysw4
         6Q5KmMHe2j+upXivWwwLFRwh04I42KU5sI3qs3v6G70UB8g6yQIOy6/OH/naw9rzJ4Am
         vaiwODV1MJKXDZgnsgbIvmLBIPFpqL7ITc08pi8ZARVHhMxHIz5ds0nVbrQo2Hm0mnw1
         MMIdD/lZrlSHLYxpvZgpTPZn9Y6rq6zg0AVgBz+tSPSRh64d0vg5Xt6pKRuL7WON0TSh
         QCKVmRgFBfFPdAkJfWVfJ77/5UKgs4dw1FsRUoqpJuqXa7PCMwIowP1ErtpAzpd3I7qC
         DvSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5goXQWGbVJnCW6T5VCsxEcV07IWZNw+cqT9aihUo82F4v/ip8dxlmH+8EvOfPAYwa1hT4GcvUkV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjd+jzo35btB2hhHo9mtfWLxMDZq2LAapxVIc31UxzvtabEicr
	rsiD9MoRKgiePdoK+HUIMRU0UwqbEp/JFbAOF9bf0H3PW6OVZtwZMqEfDx2AF8amC+GsPqHyRMx
	5b90UP4HESk+RbcTxFlLW2amNMa1znmb5Q6K3rw==
X-Gm-Gg: ASbGncvCWCUSYgom7JFE3EIEd88wFmt3JLZPgEr7LL9vjpcmB8pepLXFUZ3vzJofBvx
	S7Z6p0Th5zGrEzPD/q0eeJee7FmPp6QQDcDAcyb/j3/yuZ5fx1L04oXGIwzQF
X-Google-Smtp-Source: AGHT+IFCQv++QsFYdqvxqu76Xx1xUMCKFnqfO8lf/2kvforDl+fXpZU9BR8rgm0yfLlAmV0bkMzjZHDetx/fmDmECiM=
X-Received: by 2002:a05:622a:1986:b0:467:76cc:622d with SMTP id
 d75a77b69052e-46e12a1ca9amr403239251cf.11.1737629518280; Thu, 23 Jan 2025
 02:51:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123014511.GA1962481@ZenIV> <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
 <20250123014643.1964371-14-viro@zeniv.linux.org.uk>
In-Reply-To: <20250123014643.1964371-14-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Jan 2025 11:51:47 +0100
X-Gm-Features: AbW1kvYw7DfXtx9K2u0kuT28cS6RFX0PZCipXj87ydRxCQYYo5Hopzm-X6v7khg
Message-ID: <CAJfpegvCUt3uUbbe4Y_-OHUYxP1xdgEE7F+3ecNFU-o0wh_aUQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/20] fuse_dentry_revalidate(): use stable parent
 inode and name passed by caller
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org, 
	linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jan 2025 at 02:46, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> No need to mess with dget_parent() for the former; for the latter we really should
> not rely upon ->d_name.name remaining stable - it's a real-life UAF.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

