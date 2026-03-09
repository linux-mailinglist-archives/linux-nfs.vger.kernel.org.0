Return-Path: <linux-nfs+bounces-19893-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGEaClL8rmkxLQIAu9opvQ
	(envelope-from <linux-nfs+bounces-19893-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 17:58:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A800923D384
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 17:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCB653055F83
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE6C293B75;
	Mon,  9 Mar 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="J+Xuet5h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EBC3CC9E9
	for <linux-nfs@vger.kernel.org>; Mon,  9 Mar 2026 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075034; cv=pass; b=DW9ZMwP0W5aVh2lL42Xew5RpR5GUIXfLh/5GFMxH4W/W7UB5j4Ves/4YP5XSLMn+0yDj5NpLDGCICe22CRL962Q54Wtjw+VSaDGqBxsSFa9o6NCs9Ji2tI0kBGDSW8zs2ZE2bTuvSZuegNeP1mNAaOqS/07NFuw0jsA3CXHHp3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075034; c=relaxed/simple;
	bh=dElGlCWfTDUCaV3zjXVrwEshlrdMTwzM4Mn069fiLm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Peu//1p6xu3KctojSddy9Iu7xTmegeglWqHR/aF6PYWD1ndUhLSBnYvvcx7cGSizgG5X6o0VXL4/UXX8xK65vtyxmG4AcbaGNCWzCazZP+LpnD82baIR332Be2s+hEsPkgcvJItslGHAgUYnof10VmxewvlgvWpI/zJDWidQ8Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=J+Xuet5h; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a1330ac6c3so4700872e87.1
        for <linux-nfs@vger.kernel.org>; Mon, 09 Mar 2026 09:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773075031; cv=none;
        d=google.com; s=arc-20240605;
        b=Mz/XgVO00Li3B89DSlEUPo46vpTRFc0RK+p8y2RxRhBGrIjaWauMtzh/BpUHy1lih6
         R3OKak4qFrsFxuGXbPXnupNtPglfB0JgDuyBN4eAzne5OfQPMRK6QcazpXbIBawxn90k
         iuG4oNhJoyKNzYkfYOvu0G/qpeAeH5/cEOIE+Dla2U3ldIwRnkWLcUZAUVfEpTmqOEFD
         mFWoDuYciL3UB1PMqDrrRFpIgW6tARb7n5hHpCOZIYnYTxZLixg6Xij986P+P6Y8V2pp
         q96eP5go5h1xKnOAyxHY6RGoC/wGnx+jgUlzPf/EVQUmjafGGq0qDQNak3+XaHl91MZi
         /JVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qXi97N/dEOi9sir8d8Z87lcT7PElOkZiITQbx2fwCc=;
        fh=FGCfvw1yW8WuwVcXfGOfKLOow7xSQLG4rjwIYJ5RwK4=;
        b=Cf8c5woVp1py2J0w2UFshpmGOqBq7OxB360HvhSpSqOVjq+C30fJrED/eBZYHm7utd
         RFie/Typ7pdQYOR3Pfg/DKK1In/cJQ6mxR4yTPJw25E5urM0QrzV1c8LKP8K/bdUNJtX
         QFPcVnFirdFd7yoGSiA9rg2GBzGKgihIN5oynfgmfjEF+JRkcRr7wTdOr99AaaYtTiOc
         wzeZxblf8pbo13ll2AY3/mjuNKw4DlnSNxDSCB62ZhJLGzqAsE8EycN1oLPnJV43kVl5
         s+iD+y5+2K2kGBW6E/k/YOFTPjQfnyfCeaiWMMlw3uBijeufnSkShtPAEo9+Fz0VYVdx
         GmCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1773075031; x=1773679831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qXi97N/dEOi9sir8d8Z87lcT7PElOkZiITQbx2fwCc=;
        b=J+Xuet5hbFlie89tCjUFjzDwucKsd4NfrnrH1IlxidGOt/z+KgeLuYLA/G1tJg9YeP
         C1CoxioVNedpRpnH3i2g1e9rvaDLyL/wWFxrMS/dadrG87skwpJ9ll0VXP5/mb7t/tVB
         3nTver45s6YBmiBWLR4SANFDP+bIXXTcsmJ6clYmeEH7meYralZNdoAd1IxF7O6aIkco
         lCWgnoV4P4ikTR0XyXY+GmybQCrbR7LB3OkC8+7VNevH+4CSTtWk0BvwVojn5VB4UwmR
         IhgPtrXLc4SezqZQwBlfIP/+nK2z8AMiJCr0cknaXTC3MvGuBMz8TIpTguJCHWhMt/xS
         SObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075031; x=1773679831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qXi97N/dEOi9sir8d8Z87lcT7PElOkZiITQbx2fwCc=;
        b=kjYWvar+kMQqk2mvgN7OYWzJA+6O8UtWW3f0KOxzoeyNaODSvbZWxNcaXqX7hSVtzK
         nTRL1rV72ZQT5C9YcPv7pvnE7SxJAKLS5pZIyPxBjpYJ2COKcHkwX3nRVhDTZe8bpY4A
         I76mEMX5olHfR1SxpF/L0H+eqLbry0uu8BPpYN2kYGNXF9Elcl5qstpVBHKeKl8fncDl
         nr4d/htrbmbrffPMnR7V66VtHwkViz5KHjR9mEP8G9KskyGMxQRQmU0embUXlekFBp3O
         1iK5dQ6T1oYbU3WcuYG1GC2b99lfdZf0ompbaqFzx/UCgxcmd1wge4mdFbtooVL8YjCi
         P/xw==
X-Forwarded-Encrypted: i=1; AJvYcCUWwghbi/Ito2kwO/99Z6YG6QyJ2aN1KOqgm42Ihhf64Og/GRefExd04IAyGX1EcK5Dt5Rqf5bbmL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6HvBy80ZFu3WNv7rEPCu2JycokQpxJb4qxVdTitrLKKomOcMB
	6k2zD8CvdKo2b3+iyVyrn2ajnSGwdm+SiE+bueiaR+b7I+fu4yzG8AhgRCsyYazCmsZl0EarUby
	9jWQv5pFmoaRnWnw7DNNAonobgkWfJHVGlwsnOd2j
X-Gm-Gg: ATEYQzxF8rWL1Lf0p0Ab9fTLfpfAanSd5Tyv9QTpBRQoJS/KiMYncQGwxgwiGKi/pK+
	TttxD8o1eSbv48AyVuKd/fu6Uk3lG8SSRS4Xgj8acctXBHpemg3qMjy45tLpRVfFU7rXBRWyAfq
	cf3qIi2txtpWKjpVL1PKbxoSUpnQ7Nq3mzfdA+9iKot3zJGI+G4X7/0mIhf8Owaha5XkPrE9Bg9
	wqByeP/D0Yik2o8ju+0O3eGQLZkyTgyT0HE94vas8IC1dF3ujjOwyqBcpD5MfKl0+GaRt6gj23F
	DCzSBjM4riFDw/s=
X-Received: by 2002:a05:6512:33c9:b0:5a1:3d7f:8fbb with SMTP id
 2adb3069b0e04-5a13d7f930amr3518616e87.2.1773075030208; Mon, 09 Mar 2026
 09:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
 <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com> <20260309-umsturz-herfallen-067eb2df7ec2@brauner>
In-Reply-To: <20260309-umsturz-herfallen-067eb2df7ec2@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 9 Mar 2026 09:50:18 -0700
X-Gm-Features: AaiRm50Rb5608a_d1ziKt7e3a5xZPZu4oB7F4zw8iu_Gm1KsPQukeeL-PdrpHz4
Message-ID: <CALCETrWjb+V-zrMT412MtmgDCx9y8simJBQ7+45C9MtdiSMnuw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
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
X-Rspamd-Queue-Id: A800923D384
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19893-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amacapital-net.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,oracle.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amacapital-net.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 1:58=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Sun, Mar 08, 2026 at 10:10:05AM -0700, Andy Lutomirski wrote:
> > On Sun, Mar 8, 2026 at 4:40=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > > > On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy1=
11@gmail.com> wrote:
> > > > >
> > > > > This flag indicates the path should be opened if it's a regular f=
ile.
> > > > > This is useful to write secure programs that want to avoid being
> > > > > tricked into opening device nodes with special semantics while th=
inking
> > > > > they operate on regular files. This is a requested feature from t=
he
> > > > > uapi-group[1].
> > > > >
> > > >
> > > > I think this needs a lot more clarification as to what "regular"
> > > > means.  If it's literally
> > > >
> > > > > A corresponding error code EFTYPE has been introduced. For exampl=
e, if
> > > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the f=
lag
> > > > > param, it will return -EFTYPE. EFTYPE is already used in BSD syst=
ems
> > > > > like FreeBSD, macOS.
> > > >
> > > > I think this needs more clarification as to what "regular" means,
> > > > since S_IFREG may not be sufficient.  The UAPI group page says:
> > > >
> > > > Use-Case: this would be very useful to write secure programs that w=
ant
> > > > to avoid being tricked into opening device nodes with special
> > > > semantics while thinking they operate on regular files. This is
> > > > particularly relevant as many device nodes (or even FIFOs) come wit=
h
> > > > blocking I/O (or even blocking open()!) by default, which is not
> > > > expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I=
/O. Consider
> > > > implementation of a naive web browser which is pointed to
> > > > file://dev/zero, not expecting an endless amount of data to read.
> > > >
> > > > What about procfs?  What about sysfs?  What about /proc/self/fd/17
> > > > where that fd is a memfd?  What about files backed by non-"fast" di=
sk
> > > > I/O like something on a flaky USB stick or a network mount or FUSE?
> > > >
> > > > Are we concerned about blocking open?  (open blocks as a matter of
> > > > course.)  Are we concerned about open having strange side effects?
> > > > Are we concerned about write having strange side effects?  Are we
> > > > concerned about cases where opening the file as root results in
> > > > elevated privilege beyond merely gaining the ability to write to th=
at
> > > > specific path on an ordinary filesystem?
>
> I think this is opening up a barrage of question that I'm not sure are
> all that useful. The ability to only open regular file isn't intended to
> defend against hung FUSE or NFS servers or other random Linux
> special-sauce murder-suicide file descriptor traps. For a lot of those
> we have O_PATH which can easily function with the new extension. A lot
> of the other special-sauce files (most anonymous inode fds) cannot even
> be reopened via e.g., /proc.

On the flip side, /proc itself can certainly be opened.  Should
O_REGULAR be able to open the more magical /proc and /sys files?  Are
there any that are problematic?

--Andy

