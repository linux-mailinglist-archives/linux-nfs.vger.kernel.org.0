Return-Path: <linux-nfs+bounces-19478-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDEHGjZZpGn8eQUAu9opvQ
	(envelope-from <linux-nfs+bounces-19478-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 16:20:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EE61D0674
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 16:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BB873017011
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2026 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D98331220;
	Sun,  1 Mar 2026 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4sAIl9E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CAE30B51F
	for <linux-nfs@vger.kernel.org>; Sun,  1 Mar 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378402; cv=pass; b=YdJH1dJGBgMp8ahCQPhkbn7zntasmCVhLnl9bXEC4hoV7j+Vie9eXZOeBJRq2dZweH0sqnUsPqfLXpAxsyCmxRWRxysS+zniIsvRe0SOgFtVv9fZLyVXuv8g0ZZY+cCC+iVW9+06WJ5LICq9Plxk4CFjUNcbv1NW9UD8fhnnEHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378402; c=relaxed/simple;
	bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBSiB7M8JPYf7rX7RieXqaWJaMl/XwvC4J0bbTOMBbzMTB3FIpD/C0Ye/YUsNJDxIMCVVPXjfy3QNhXczN/4ZEzlGOnyyfKteEKN5/sfxgTDKdt9KucoB2CjTicJ6zi98ybO+kK5Aq5GrKtrDPJQhuLjaqg9gnvl6+t/uDG7fMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4sAIl9E; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5fdf3735e14so1800442137.2
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2026 07:20:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772378400; cv=none;
        d=google.com; s=arc-20240605;
        b=INb7NJDlLbEh08tGU0y/9J92dGYzqQlEvcHHRwbCUt22N6lu4MxnGIwXpvcs4y8KNM
         xajUntFg7zz8oHkT2WfzRxK+zhfcI0FjK5TZn/wQjyLhx5Jt15B7EDNdOuvg8ZgtT+J/
         NpdyuurkJ3Y82egi266wzxupIhUWYricie6NHa8xzBpozw7XRdk0mBrpCfawa9VcxUEo
         u3VuwGgWIY3jOFeIzqkVSBOR38Y/VLu/WSYng0hRB5YIRBpC3d/64+Sqh+D/36H/ujFV
         1IlC+XwonChoyeaiNHF7HhKBjqn859Qnj8lk6b0kn9Kc+0rH/S3hMiCV5hurEbHEah4F
         X1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        fh=2F1fy04sZTefCKmDaCCr2xBgWxLvZCJHYoAIy5M4MGI=;
        b=TgMBnAts3v88tCbUBwxK8grTTrxGz7ksK67uXO00oLTh7SAF6VKoVVnJFHKHSCNkyJ
         2tWXwDHXfsyhN70VVN4q3YBF+ETpFw4/cujxwY1UjzBH2YWVyKJ7O6sZWdhGaGg8PZh2
         ofyTCcC6pi/YZ0pBNWRHZZBa6uOcDCFIsK1QXzK9iTvG0zHoD51NSREJe+1Cleadr2RK
         FWhqpmjfMEKaSm4spxKJhu3csjGdhNq9r7sdUTOAdWsmQVFx5bZTL6hilkv0h8pPSgM6
         3mLsy3lBCaKujC1VYBB4dKCY18MDsd/7+XUXGp1wcNOEDbE5NbGHc2bSeZyXtxRYvpIg
         psrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772378400; x=1772983200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        b=H4sAIl9El3DNOjSs6WpoPmMrg64nxdhM2ZU5p6QYdJgq0rtcVMiLtOknYAp3Sg1HnR
         zuEPbTmKD1ahGkEt3CE7W/3H5T9dhJifaqxhoa4FnJIn1ZHEkCrP0KrT0cHSvWzxETnb
         MbQOhGyR7CPg5xgLKg7YKeEJVtdUNLNdy+utBZZbL/Jp+UK/UYfxbYJC/r09iyrQkrq8
         mxKbP0RTNPaULQk5XcC0nqNjCJTCy9r4hOpSX+4eaoRxRsX2lGltWHfOVKOZiO6+5udc
         ZHmxplPmgnjfFEzR/g0/DYxbZ9xUIHWOxlu9NKNyarI58YO2J4A566bqfoxSDFengttt
         GXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772378400; x=1772983200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        b=I9Czti+XEAfuenpm6+iR22kfljDK2W2TuszXDRkoMfLyQA2+OS/eodJBwK5BmX8XFL
         FJJIJhJ7f2zI8t3+G2+BiXcZ4w8B2/HuG4p2+enR0XoBoO9motr34cWowOoAmeiWbZK/
         +ux4icutRAzdzYkKPQVR/K8I5lCbAUiUF1SGFMfthgN6dDu1MX4mTc28IxM0N+YPjiIK
         6SRUHmaLeKDReSM0rObrRWV5oTQ0sJ9t0t+nBjJWGXfSaZx075VxSkLziJWUutlZ5CoU
         /KvVKJKb34q6vIFuhzTCQpvaAdz/vQI+j1/1DMv0DkYEIvFkI5w1m00OCwY1Bpc91CoL
         Ve1g==
X-Forwarded-Encrypted: i=1; AJvYcCU9vwTUmbApr8btS1dFzyVw9kgs3mGd6P6mTkH5tO94QxxEFM+CkGhaEP1kgu4PV6CddBxM/HE33AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKK4JygbH/d94TLSROgSmxuDIt5XdBoKPVGr7TBt92IzRWwLSB
	EqgeGf/zPGyQJ1TpOoEtcVWKOND+i1zRMQSUuyPaxKff0jeyQc9sPnTKDv08jtt4FRqbNf/y6XY
	QCrs/X0hF+Ez2XGcmRk+rv7+8j3xubzs=
X-Gm-Gg: ATEYQzxQuE3DCPmUVscDMwRL89lg3sK8FhBcnUWbhMxDIN/YcsiYhvp1OBQAD0N6fYP
	i9mCScYKaZ+N5wu2NdP5KP1204kHaOTVywG6MqLtb/n1E+mddE0e+6+lTWREhuUf4zJcSnOKG9U
	4NG/lR9xqsV84G8cKJcW7DJejVGwIgloB7Dq/xOlX+OsHE5KrGbcg2plrS3FxftNOCN7nfxxxH0
	HPGmdVsV+wB0vOzvrgc0U5AkzoizUbcYWPvTDPBTL7diIlirEj02DSDEMKCN+kcxtU6WA5D1scY
	IoxlfXeWYcv1vxKuFjR+kUsLD8jzJZbpgFJ3SuzWaA==
X-Received: by 2002:a05:6102:160c:b0:5ff:1981:aba6 with SMTP id
 ada2fe7eead31-5ff31fab9ffmr5005001137.0.1772378400433; Sun, 01 Mar 2026
 07:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
 <20260221145915.81749-2-dorjoychy111@gmail.com> <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
 <CAFfO_h7i86qdKZObdFpWd8Mh+8VXVMFYoGgYBgzomzhGJJFnEQ@mail.gmail.com>
 <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
 <CAFfO_h5za6gV99TQS3pwHnf7zyCeVySn3CdRyV+_jFqjovGBqA@mail.gmail.com>
 <beead8bbff344ddfc279e0fc86db0dd5dd98562b.camel@kernel.org>
 <CAFfO_h4brg90tMNp6VAzs5Lo8Lbu=DK2csjDqr2zspOygKEFCg@mail.gmail.com> <73c8ea54bcda0b64093d84fe047914c0632c2d0c.camel@kernel.org>
In-Reply-To: <73c8ea54bcda0b64093d84fe047914c0632c2d0c.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 21:19:49 +0600
X-Gm-Features: AaiRm51DyMEBRNPI1HVDhCyC4qT7r77uNpEMtKgft97OSaudIMk11BvPwkDJ_3M
Message-ID: <CAFfO_h59LQSjncu_4YE5YB+mt-FL2c1GN-jF_WtoKj1u43DcuA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19478-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B9EE61D0674
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 9:17=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sun, 2026-03-01 at 21:15 +0600, Dorjoy Chowdhury wrote:
> > > >
> > > > I only added a kselftest for the new flag in
> > > > tools/testing/selftests/openat2/openat2_test.c in my second commit =
in
> > > > this patch series. Where are the fstests that I should add tests? I
> > > > think you added the wrong URL above, probably a typo.
> > > >
> > > >
> > >
> > > I did indeed, sorry. They're here:
> > >
> > > https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > >
> >
> > Thanks! This is a separate git repository, so I guess for both
> > manpages and fstests I need to submit separate patch series for
> > O_REGULAR. Do I need to wait first for this patch series to be merged?
> > How does it work?
> >
> >
>
> No, you can submit them in parallel, but they probably won't get merged
> until the kernel patches go in.
>

Alright. I can look into submitting patches in parallel. Thanks for
all the info!

Regards,
Dorjoy

