Return-Path: <linux-nfs+bounces-20865-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DeyHajw4Gl4ngAAu9opvQ
	(envelope-from <linux-nfs+bounces-20865-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 16:22:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C73F540F86C
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 16:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7A74306312D
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B5A3DEAFF;
	Thu, 16 Apr 2026 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+O+I06/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40A3DE45D
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349302; cv=pass; b=QZLdtTPfPsso3fzOHZXnQ+orqC6N60+EPbSTdkRn3jjb3Hd3ZjI10EN+5R72pRWHQhPy686OaPUffQsUZD12UQos5a0/36+H/jJmmvSgO7TcynQBS+svglJJy8Q4hQy/yUoEdhvldgjxv+CmWvJ4+ko93cqdIcspgBdhwWLMgEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349302; c=relaxed/simple;
	bh=MPSStrB5WQZXjuD8LVCQJRe2/QVXDyCuUjmphyPyAE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GPqajYoGVz7/Ogw6B89TG6IBSzlzNtwkqZjowSQ4n7+9yjgPEx0ISv8RCP1i4mHSKNf2GJl0Mrd4uTzUbtJsZ1ovMM3zTWFL9UL2V4GqjOwbmThk4y2Y1Q7LDNAigfpdCTu5WeIwAO2pgr4aUVLVd1bD7WeRTZh5lhiMb5EUY44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+O+I06/; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56eee0ba462so417365e0c.1
        for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 07:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776349300; cv=none;
        d=google.com; s=arc-20240605;
        b=imx3o/iXwjgCuE0knZ8EgFzJb1U81LN5mpNpiDAvEQrQr97G+b1Xk/sTyUSrI1fjk0
         BrAz/2TAqXVC9NDmqgvzOHvuf3TFCM7iW80hATwvPgTJYyTq5LAWFI1vgil7D9N+kZ7H
         ovmisXQk/LdaXbbNFG5Idmr/l3zoZtVX9ge5Nv4WxQZAz4YVtjVtCpgVWAKaeMjbAuao
         KXH4YGsSoJ7wVmgzfdnibHhq9wx6bSEGn/n9qJowaSQPmfM3w/E3ohHxW5EtAPUgqOcf
         DVhucGgzH2ladin4UqJFVz5J9J2lzZwE7xMqdiK7CGL/3H1Y4RefQgkeG+3hVrCfmAJD
         u+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        fh=L4PE2oEnoip/YpoC/ONytnqSI3MP4CaIUS/4hZ/CCgg=;
        b=kyUlxcOguyeuChirx6dBLNMLiuI2xJi6J0DfzIAeCpByasrFGvZYswUBIZ7U/g97x/
         Hi2qBhB8pc/z66c7MiNiaIHxUvjhDcwL+qP8GGFkqegGVZdKxQGFMWF34hHxndA1l6vj
         qLDnkuOk521mxq/V7I3sSzJR+Vs+W4cbN95DJkDMzxdJcTdWqT/5lyvdS4FymzV3e6PC
         DvK4hF7XEz6F0gZ9KBXdKjQvRiuppOvQgGD+vkN3ew+yvFRLeJBfDQ4wIpNgSXoDY5/f
         /WJbsXujPTNexpQ1cWhGCeA9x9hxG6m+fEtweudCQroCvYzxWURx1N6+QkwPHUrl5sLs
         riTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776349300; x=1776954100; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        b=S+O+I06/bsndk1ren2sbM0LafnTLke5s/YTY8d+xK85qFvLskc9abtgZQTAAGdHXkW
         gQ8OcqsAvXDSUsE/qTNg9RdNmoee/lFXrdR4ucPesp6PxtFUHBJnk2opxD4WhF7p39fM
         JbLJG4K9nLOk1IWPQT6/9UECkqMXhPWZBwfmOtBlB/tDpW5BKsMpvE9DTyB4a3Knto5N
         O6ngJcs5AXuxkhGkB6nfrl1OMvAfh3fOP4DF0wVQe0Q8EJ96obTWMCn/Ykaj1QnqTfbR
         Y28+pO3WR3EhH13uOiaw9rJINIUVvIgJe+Bk8hsVZpSq8xjX+CnPVc9rKipwxH98+XyE
         eXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776349300; x=1776954100;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        b=JKfPrMWC/aXPVUXOUoFMT7dOIuUyMso2CwscZLSHOtmRH2s63vYUBC4S5XRGlPjxBB
         qHk+34aBjn0Rk8ZBJSbN3swZL4yczHEkPre2NrPnprI0RSQLCpekXztBmwgKbs4QAkjd
         uMtvGyie0l3+AIn9BFYLKwAivJwaeTXqpMWYKNRDPidDXtDNNqIUCyCFcdWQnr0JC3LT
         CeUSciAvpCOWjVTp28lL4VbofeUclxOGVb5SSOoSUHo5dB7DtZ+ri4g0vr+XN0EV/jyi
         SWe+W3KabfgLNXgQ6nMBljRbRYmHM+M2nb28WljK3u+7sZJlmQs5MEj4KpiYO9mt3khM
         ayTA==
X-Forwarded-Encrypted: i=1; AFNElJ/9myVxguhQPg0/wvR5J5iab6bmcjVfiqPxvnqvv6hk3RPSD4Hp8hNmeTa3g8KzhuWGEbXVz2EBLrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSUQxgLgH1oPLsdtKD2/OWQT8NxAuhRxAYLCYbEceeQj19i01/
	/tkNBKzFJfEPJDHsXWUFxjOvKcQQOSeH7fQ7nCTbvy7CgXl8kFIzDPSJLPYdLgMENurgd6tuBAa
	WORknWbwOGr9Mhmn+HLyufe9YoLji65A=
X-Gm-Gg: AeBDiesRN5m4DUyQNv0m0wnfslTyxKu4Aw3lvMeksNgz7JlEVv7xow86OBK7KES9Zzx
	JlXqnJSknBQs2lB4DS1itLj3vfao1bVHGsqx5uO5y5FMNAINw8BBxAyhElHh+lZ+ZfdAklKh32E
	g8Qx8Jpu7pVH1suAm/QA3K+fFOb1a9kTiQxld5IqdxNiSqTKpjPAIIPxDXgwdP22RfWJ5EIxYsN
	cpZ//mdhXKfWMKhTNzdsZoyuPlb0kHFOazHHo1bcTKgcgvpN4AFcy9DwLCMzWSCPf75MsbUQSDc
	NBkt5GSjqUledoJ2XOOYIYYASJXFAu8/Q4Exp8/teQ==
X-Received: by 2002:a05:6122:608f:b0:56a:8f7c:49aa with SMTP id
 71dfb90a1353d-56f94725c32mr1843622e0c.4.1776349300022; Thu, 16 Apr 2026
 07:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
In-Reply-To: <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 20:21:28 +0600
X-Gm-Features: AQROBzCVSNvQ07toCtw3F1sHPLg5Z_-nre3iq90Dw0MflD8nQqdsL_RQ56rFZc0
Message-ID: <CAFfO_h6pkyX=uN5uoXda6toTtT6KsahfBNBLom9i21HdZ7JOmQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jori Koolstra <jkoolstra@xs4all.nl>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20865-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl,gmail.com,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[44];
	FROM_HAS_DN(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xs4all.nl:email]
X-Rspamd-Queue-Id: C73F540F86C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 7:52=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> On Sat, Mar 28, 2026 at 11:22:22PM +0600, Dorjoy Chowdhury wrote:
> > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/u=
api/asm/fcntl.h
> > index 50bdc8e8a271..fe488bf7c18e 100644
> > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > @@ -34,6 +34,7 @@
> >
> >  #define O_PATH               040000000
> >  #define __O_TMPFILE  0100000000
> > +#define OPENAT2_REGULAR      0200000000
> >
>
> I don't quite understand why we are adding OPENAT2_REGULAR inside the
> O_* flag range. Wasn't this supposed to be only supported for openat2()?
> If so, I don't see the need to waste an O_* flag bit. But maybe I am
> missing something.
>

Yes, OPENAT2_REGULAR is only supported for openat2. I am not sure if I
got a specific review to not add OPENAT2_REGULAR in the O_* flag 32
bit range. But as far as I understand, for the old open system calls
we can't easily add new O_* flags as the older codepaths don't strip
off unknown bits which openat2 does. It's not easy to add new O_*
flags for the old open system calls since that could break userspace
programs. So I guess it's okay to add OPENAT2_REGULAR in the 32 bits
range anyway? (Also lots of code paths take 32bit flags param right
now and those would need changing to take uint64_t instead but this is
of course not a reason to not add the new flag outside of the 32
bits).

Regards,
Dorjoy

