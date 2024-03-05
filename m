Return-Path: <linux-nfs+bounces-2208-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559AA871F6D
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 13:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83AA31C20D1D
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 12:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8913F58222;
	Tue,  5 Mar 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dKC+KEve"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E68563A
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709642626; cv=none; b=Hnc2J+W0o0Zxp5f+RPHFx+IiPnTBIqrn4z3PfcPOCv/keEJMxSzZarinjF+v9AK8rOrza5SQ6hBpWkZXoQX5IeK/Z4QbH8tf0pv3J9ZhLFbW6EGWMAJ2TLEBpcEaUg8CiA6KKWD1vRsl5Wzp45X8T9iaxJLgWInGTHVEVKF3Sgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709642626; c=relaxed/simple;
	bh=hqXu4Imvd+YZYd3LEDpX+ZnPOXEZjX0E+C7N/22uaKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKmpfLfUzdUhJDMkmN2FuS6/ucTDcWjkIy5xZRoEGVxdz3kN5ad4AFRutdCweYG5blMe1es7QXLU7evo6n7AouyT3bj9NUMQ/OCt82NDMnm4Nd/5lxAK1Ec7IZ61DpxWNMLo4Y/udmGeQekfNV/jYED4OlwTT5mW8ZoLxQh7Yu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dKC+KEve; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51320ca689aso6769731e87.2
        for <linux-nfs@vger.kernel.org>; Tue, 05 Mar 2024 04:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709642623; x=1710247423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hqXu4Imvd+YZYd3LEDpX+ZnPOXEZjX0E+C7N/22uaKY=;
        b=dKC+KEveoMrJox2JYoN1rvvJPEQQ5mCmK3iLWi4q4dPWC+fFRrXaIlNn1m/iKZ10cP
         nZeuPDRqkY+/3JruQ5n7cNfVoY9390s/JhFXC1tW0Qhc1LLfB2JFqWhBMHgPOxs48N93
         WQ+YO514bBN++CfZKG7X0nrtv1qxDtPJMscfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709642623; x=1710247423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqXu4Imvd+YZYd3LEDpX+ZnPOXEZjX0E+C7N/22uaKY=;
        b=gCGGdJs8FJ0Ye4MK0YLieneBsUTUOpsVEM8LITtKo0DqN0O45nHw8OJhXvd3TRvWxk
         m3pVcmdoOCOD2T9LGQxvhkYII3oXACQCz53eA/CI8XMQaq3ZipRaRQboF/I9KWRCPbIF
         rWd5DCJSExwphvctt225XxsaP1FV0eLhCSnHjZYkhhBwo68WA0RTSTJSrl/qRURGHjiu
         gIXqUuEqBdgfXTJhTBGjh4c4lNctsqGOeK+uY/exHzkpoEwKV0EbOkRiODJfteDIpNkM
         WhLIJdBWvLDayn1s3H0kw8GJGiv5JiJnDa+Uo3WxnBQy4XrGhzaxJsC1WCz/MkOU13ka
         Ygnw==
X-Forwarded-Encrypted: i=1; AJvYcCW7xbC+g3CN8ePsWKQjxOKQUvt6XsnOtcwpnH1wftw3tIpceFZwLz7/1Z8VYO/PjhIJ2J9ATB2xrG7aBEcVMPbgVr0o/m7kWWYy
X-Gm-Message-State: AOJu0YwCuArIlllFor6spFXZugTc9ygT607u4UyDz0GYkC4gLAol1zAw
	/p2HNPkBvxRQaKUsVN+EqTLl7tAX0Co96HcXroDDgIngl1JsjNR1jQz/NGUq6whlRFJFzMtdieo
	9aQgYsfvGV9R5Qm26b+mQBgynM5dyB3TZqODP8Q==
X-Google-Smtp-Source: AGHT+IFDaUTfRvZDVguiUspJ8bW9xNWfKoMVLiqWzzQ2oinl9J77SQ70Ly+nbCnni8ZMPAqYVspxryxBQbzNkvrnVDU=
X-Received: by 2002:ac2:5e7c:0:b0:512:f5af:3bdf with SMTP id
 a28-20020ac25e7c000000b00512f5af3bdfmr1088535lfr.68.1709642622758; Tue, 05
 Mar 2024 04:43:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204021436.GH2087318@ZenIV> <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-11-viro@zeniv.linux.org.uk> <20240205-gesponnen-mahnmal-ad1aef11676a@brauner>
 <CAJfpegtJtrCTeRCT3w3qCLWsoDopePwUXmL5O9JtJfSJg17LNg@mail.gmail.com> <CAOQ4uxhBwmZ1LDcWD6jdaheUkDQAQUTeSNNMygRAg3v_0H5sDQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhBwmZ1LDcWD6jdaheUkDQAQUTeSNNMygRAg3v_0H5sDQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 13:43:31 +0100
Message-ID: <CAJfpegtQ5+3Fn8gk_4o3uW6SEotZqy6pPxG3kRh8z-pfiF48ow@mail.gmail.com>
Subject: Re: [PATCH 11/13] fuse: fix UAF in rcu pathwalks
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 15:36, Amir Goldstein <amir73il@gmail.com> wrote:

> Note that fuse_backing_files_free() calls
> fuse_backing_id_free() => fuse_backing_free() => kfree_rcu()
>
> Should we move fuse_backing_files_free() into
> fuse_conn_put() above fuse_dax_conn_free()?
>
> That will avoid the merge conflict and still be correct. no?

Looks like a good cleanup.

Force-pushed to fuse.git#for-next.

Thanks,
Miklos

