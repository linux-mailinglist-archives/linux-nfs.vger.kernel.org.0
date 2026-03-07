Return-Path: <linux-nfs+bounces-19866-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHfmE+Z0rGlCpwEAu9opvQ
	(envelope-from <linux-nfs+bounces-19866-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 07 Mar 2026 19:56:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D24BF22D49C
	for <lists+linux-nfs@lfdr.de>; Sat, 07 Mar 2026 19:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C473030087EC
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Mar 2026 18:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EADD3921FB;
	Sat,  7 Mar 2026 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="UERqbxJK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC1638F243
	for <linux-nfs@vger.kernel.org>; Sat,  7 Mar 2026 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772909795; cv=pass; b=dve/kUykKaLlFotYRQBhGQN9w/orkY70tws+vcwTheSxYW/I8ngUVfSsJiJ09Wp3CLLQlEOGKp7EdRv0jkWX/GAWxKVaez8S7ouvxkFnBlpjiLco/4IA3yUbCDgreidNG9uc2eKCUiknPrMsSqisb3u6SZvc6XMtIs5T/uFLlkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772909795; c=relaxed/simple;
	bh=ipPnoEwRKGay/Kqh3e72TxDAS0WvWm5QHtGzwkgIhmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKfRkZXV6oS/+Uy8RjTrxUpHNCJZGe43UU6yOBVRZWuZhWl8yzi4IjoCqeEnQqK7Rjrcxwt1rR/R6WjwFp3GIgMOarOyvzlyz+KF0vxI9CpD0AT+pveqgshJxduD6jobE0Lcp8ws+T91GJKoI650NoP9T124pR1Zm9K2Lx4S0qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=UERqbxJK; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-389ff6e5885so88584181fa.0
        for <linux-nfs@vger.kernel.org>; Sat, 07 Mar 2026 10:56:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772909792; cv=none;
        d=google.com; s=arc-20240605;
        b=lTBZOGhCf+ewmgO+5r55SFam3Yr+NoS2bSo3XUMIAzXIj+3oMujwWtCvoJmFbPVPFW
         2VYdRs9PL6ocOGhjT+tXXSaJDWDy3jwupk9z+hQBEVdbUaE/HSS6cHpCwsiCKopTS/ta
         7KT0i3Ge0P7163lDI3oIJhiKq5hDqgInUQmow3LLW7OC3YVzCcINgJHYZHZzPM/VsAYz
         aizwr/jgRtCstEMaHFxXeN6arKXUbIwKN8HAWit0cT/hlswpgdRAgypjpmIkKEt5E2L2
         kNW0bcjD4rQzOLZpx1eJizSp999Axv009LV/lu5IlvPK0bm8h1b8A28MUH0vq/7a6TsL
         +IQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        fh=O9+kwevtcpC3/Nj/7v7cz96I4b6KRIVS9/UaCASHmI4=;
        b=iuUwZ+Om8VqbRmJuQuE0kHo7tjErFlrE2Ok40tIiX7LFR08UVjM/jd4jaa4QF9ZRYv
         aSKV06/+Q/2R5xPwdiifCOFHJ5nJwINqVDqQr6Fx5ASdDpFbvkmHy0/MUzN++k3KX6Mq
         T0m4xbqL4lLGg9nJLLDP+M8LifGvGH4rGlm9UPybiWfzxgViqSg9r0rBwtAXd4baMLTY
         Ac+10njHlBvopk1WTW5hwPpWW9wV84Ha8msrekUATBt62pS82XWm80s/pFf27Oss4hH9
         UnOlO8bbc5HS2MXJIDjEp+ki0Dv4PHpln9jxiS58K3TBd70H5ROIWNosFWVwBji6cT+D
         T+zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1772909792; x=1773514592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        b=UERqbxJKZngkPO2K4yr5YwAFzKHDjj8r0w4oJuzjCO0kMIqLOi33dFigOAK5fZJwBg
         t3vBGotLKf2C2GyPcVqTqi/0bMqWfMRpqQ5rii8Lnt1DIjrG4hklubdBbb0zBjvmrxfm
         0ACUWOD8gJuwgtD1IRPU5MEQjhc5r6adr2y3vMIGiLtTdq4ZL/+TuRATJssUP64XLQ8k
         697wEJo9Gi1YFv8vDxzYYf+i++1UCLQBSHd5HunMVb0RrP2RWyiZRuwnSv/rA/6wMP/v
         6PdybPK88LnePRQ5doBRC2ZH8V1L7CaJDdTOdndxaW4gM9uvjOm57BKxPOmZpQyF5BOo
         dHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772909792; x=1773514592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        b=W9t+gYEEi7DrAlSYVkYEHtZwmGzaT18Jb+1x/dGglllZFoog8fPQuKjMZhdkHjdkv9
         VCurkCv/YycugFqq7soYuCbAW/jQy2ruclI80C3D5RGuJAtry3Sh6KmyPAHaCIu5rZZa
         OShGeCBEvYlp8XzWue7mOXE6ASTswYzuo0sVf2TFxjummW+tXJWAWLA3zdggFCDjjIGm
         SgwEFJqGk7QWHIQ3DksJ1GtUqa6WfxdxPtd9I5Oty8bhA4VBhneOtUVzeQGfHETH5/hF
         HvA7YPIBZGuUgD//qjSDCpIeyju1UertsDRamBiHtdJMsjXLRGaU8GqTdAGNGjhPm/zD
         wYWA==
X-Forwarded-Encrypted: i=1; AJvYcCWvBZsq9W0DKXaeZQOEwolLbamczD49qHTUvfdg2ORJG38/9y01FoVT1E0xe5BMARhAYebk76W8d1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8wzUPuxPmubxr1+ApLJW4F7070LosG6B7tSMlVDzHSI8WKgZF
	VmNwuxn7lMPSQE6UYtKAhZ6eLqEocmaMrJRlT0lkzMQD/Dl69zuzKmqzjMwzEc7Udf6dUs1KsC5
	n9B0ncrxil0amXZiR01wG1RBpLJV5Ty1r7wLcmMTA
X-Gm-Gg: ATEYQzxV4fYPIf1r5bdIyIIVHmv6D92yxJxk2ZiLEG50UsrJctkQqRifoc/WkSxU09d
	vAJ57lkyMbDr82wfK0Sm8XLlNEI6qHcDzADkFl90A52TaXhix0zJINKCcNdvvOUyDkilMYrY1UZ
	dG8k0Hj7yAAYSqf97pmNuagLFaYwfD53HRb5IqGFgbvsan5OIRhGzVp1QtRFfOPC2HZhlkjodhA
	vwb4SNO8DWkb2Nd55cICcbsouRJY41HcBi6uWkuujr1KGqZbtjrjLMuAeqHet8d9qV6G34iTAZY
	1C/LwIhc
X-Received: by 2002:ac2:5694:0:b0:5a1:1de6:bc66 with SMTP id
 2adb3069b0e04-5a13c93d9e3mr2016793e87.18.1772909791880; Sat, 07 Mar 2026
 10:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com> <20260307140726.70219-2-dorjoychy111@gmail.com>
In-Reply-To: <20260307140726.70219-2-dorjoychy111@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 7 Mar 2026 10:56:19 -0800
X-Gm-Features: AaiRm51B7g_JMhlZIdflpWCsx5DmxAmpibsspywnWIGz_sEa1ctulidKDYlHz5s
Message-ID: <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, 
	andreas@gaisler.com, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D24BF22D49C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[amacapital.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19866-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amacapital-net.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@gmail=
.com> wrote:
>
> This flag indicates the path should be opened if it's a regular file.
> This is useful to write secure programs that want to avoid being
> tricked into opening device nodes with special semantics while thinking
> they operate on regular files. This is a requested feature from the
> uapi-group[1].
>

I think this needs a lot more clarification as to what "regular"
means.  If it's literally

> A corresponding error code EFTYPE has been introduced. For example, if
> openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> like FreeBSD, macOS.

I think this needs more clarification as to what "regular" means,
since S_IFREG may not be sufficient.  The UAPI group page says:

Use-Case: this would be very useful to write secure programs that want
to avoid being tricked into opening device nodes with special
semantics while thinking they operate on regular files. This is
particularly relevant as many device nodes (or even FIFOs) come with
blocking I/O (or even blocking open()!) by default, which is not
expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. Cons=
ider
implementation of a naive web browser which is pointed to
file://dev/zero, not expecting an endless amount of data to read.

What about procfs?  What about sysfs?  What about /proc/self/fd/17
where that fd is a memfd?  What about files backed by non-"fast" disk
I/O like something on a flaky USB stick or a network mount or FUSE?

Are we concerned about blocking open?  (open blocks as a matter of
course.)  Are we concerned about open having strange side effects?
Are we concerned about write having strange side effects?  Are we
concerned about cases where opening the file as root results in
elevated privilege beyond merely gaining the ability to write to that
specific path on an ordinary filesystem?

--Andy

