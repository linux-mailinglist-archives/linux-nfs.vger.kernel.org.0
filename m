Return-Path: <linux-nfs+bounces-10420-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBAAA4C3C0
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 15:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5A23A80DD
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 14:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C56213E89;
	Mon,  3 Mar 2025 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lLccm+L+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD510213E62
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013182; cv=none; b=ng6tZK9yC9I5kkcfKRm2yhIfveO3A8AAxjzrclSENAL3OTznlsJM2yRMxicOySSKNF1aTotXfHT+oZJr5B/EhnDfV5NUGs5Q8qaThYRwrS4OEuEmk0+7ynKN5QCMLhmhoTOjCV6yREj0IlCDNNKvQSVeO5y+vnD5oNIcn64zhMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013182; c=relaxed/simple;
	bh=CSQeGS/UZUc31BUvv23G8CVIkT12nQMGyFgBEwHK2pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCd4cIyhplcHVAnqqBFykkp+lpNbmGbv5dPvnhT46fhu7OGDpT9XyHjRtxIB8u1oMZ5u+LWQ9NBEVI3CTWcVvST7bW07V4dAIoOihbQ022bZjuLYQxBra8/tSYfXBtHhvRnaAfsUn0uALJAQJuqv4YHnUF0CvF2+V4AUKXoJo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=lLccm+L+; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-474d11c7f1cso5972641cf.2
        for <linux-nfs@vger.kernel.org>; Mon, 03 Mar 2025 06:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1741013179; x=1741617979; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qjaplGXAgQys6n43UvZfkCCurGUYwKZfvrBKCJx8kSQ=;
        b=lLccm+L+C5gyQVjYsYDdL1zeNxIZuJZGkpcU6/9jM/EGmEqxoX9VEq8LeF0hguc262
         OrZIVKmCGpEWYzV9XpeB++QZRuh7XVQ12POq2Tyc80nMnleI7zn72I1w46yYtznIxQfb
         g0BdLTnqzhNoiDvBa4YtqzHg1bvB09UzU6OUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741013179; x=1741617979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjaplGXAgQys6n43UvZfkCCurGUYwKZfvrBKCJx8kSQ=;
        b=wWzaD3Bn7puqSPxBqwDW9GHXNWAoo2/LiR1ofp8msUEQklzqOWGMwzQYX0hmTU7zY+
         +4ERB6xOqvSmSgdkxPGfEApJftzj0k8y38H3iOrsO7s/br/iK/ITzGciP8HOpQctTALB
         7iiJwySGWnXZ5NMT3AMo5hk9015bu4Ecgc1+c3QNTxrAms5EpxZeUWSLXx8Z/EqBUGu3
         VCOuFfq/zZeiUGqxc7faz6S0KCngIruFt6SgI/zZZEsjlQc9xDKn6+sA6ak+DBhHpgIy
         APWztaTBYb+0XPKeDMszqhBIKdpUm/LMEOP0/V94X9TDmb9nbkXKdycnVnZ9CPI5SdpE
         VQew==
X-Forwarded-Encrypted: i=1; AJvYcCXSli1kdVoJZqBjJD5P1d9HgZzEdN6FI9Gu2Aebk3iMfFwq0oWW++9pzRLwHK1KRVcE9cQJCqL8pR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZbpjE8+DOmmbGIbwEtDtpe18zqlis5PdcQMK99ytTDyCcIzk9
	h9vNcnlzLvFIALhw48VkLPUTQSXp/qEAY9Rc5wXxGkb02Rwth6Fhx1lxfd2BpzN1GtD0HiEg0zP
	F9Hjb9CJyaujrehLTOoKbOm4/G+qHfwVFa2KBOQ==
X-Gm-Gg: ASbGnct5O+aQrvIEx0D6zuqmDmEXG6fGn2oycWoYaOAKX48MDKNATOIY/Qf5I9pA8l5
	kLqdRlWvWX97JW8b8AjytucGvLpWVD+y4odNWedglLjXEOBB+GltlNyF/Z2SlUUrq4Na2zqjso8
	xoZKAXIIntSU0KBE8+veEgBO30wS8=
X-Google-Smtp-Source: AGHT+IEc70lGyxC8HHKIoOrpie2Jx8XsivN2M9IFYtspzolVa0r9jSj5J487Smay6+rDx9jahhDHL5KyYqxP+yy2+fA=
X-Received: by 2002:ac8:5806:0:b0:474:f484:1b4b with SMTP id
 d75a77b69052e-474f4841d3emr20114471cf.23.1741013178811; Mon, 03 Mar 2025
 06:46:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227013949.536172-1-neilb@suse.de> <20250227013949.536172-5-neilb@suse.de>
In-Reply-To: <20250227013949.536172-5-neilb@suse.de>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 3 Mar 2025 15:46:06 +0100
X-Gm-Features: AQ5f1JoUFcZgsP72xjJitgL04_WZu20xfL4s-mJeajhIk4Eeu4PYIyUzi4H_ijM
Message-ID: <CAJfpegtu1xs-FifNfc2VpQuhBjbniTqUcE+H=uNpdYW=cOSGkw@mail.gmail.com>
Subject: Re: [PATCH 4/6] fuse: return correct dentry for ->mkdir
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 02:40, NeilBrown <neilb@suse.de> wrote:
>
> fuse already uses d_splice_alias() to ensure an appropriate dentry is
> found for a newly created dentry.  Now that ->mkdir can return that
> dentry we do so.
>
> This requires changing create_new_entry() to return a dentry and
> handling that change in all callers.
>
> Note that when create_new_entry() is asked to create anything other than
> a directory we can be sure it will NOT return an alternate dentry as
> d_splice_alias() only returns an alternate dentry for directories.
> So we don't need to check for that case when passing one the result.

Still, I'd create a wrapper for non-dir callers with the above comment.

As is, it's pretty confusing to deal with a "dentry", which is
apparently "leaked" (no dput) but in reality it's just err or NULL.

Thanks,
Miklos

