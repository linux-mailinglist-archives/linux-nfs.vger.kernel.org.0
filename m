Return-Path: <linux-nfs+bounces-14012-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE1FB4270D
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 18:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86447ABDC6
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD9F2BE7B4;
	Wed,  3 Sep 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Pe1S+R/q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540F29827E
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917578; cv=none; b=T45YEfer44N8IWuphw6we8JImcylX+h2QKhhoTN+P8UXsk78TbRdqp6fHMlzTl7u9sG7KDWB3HlTcmU/YQyQI+EK59lpE0+kByclh/0QwI2MN+ea8AcE39Tb+upn+iqSt+uhkMG7ghpLs7kteXuFk2BBE+T+sI1B7qXNAqrKp/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917578; c=relaxed/simple;
	bh=bIAP1VNyzmZj7pIjVilrHBRdarIpGo7CoKzRu+3WgNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfhA9iI1sf+2rMbI0ZdkYQY6gAsF0jbqJ8u/nVRM/2dClH/InxtsGKRyE2z4DFHefO4s7CJYA1Rxd+QinCwF4VY4UUoqRJXMMG98FAdlvdfLcEXcXJdOyt5SPuS8GiH8ZoWJotchzQRUi2g1PzsSRR5knw9V1CjEI00h/gg2Wmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Pe1S+R/q; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-333f901b2d2so503911fa.2
        for <linux-nfs@vger.kernel.org>; Wed, 03 Sep 2025 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1756917574; x=1757522374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoceAUNVNtJENaw7MXRirluImj5CElTHazOJW4wFJQs=;
        b=Pe1S+R/qBu/DcFbA8aTvgm5+4TzPomSLW5ookmJ6MU5M3FMw2bukRtIITjMPI/vH2Q
         4JP2O8mtM/fAU7mQJbEiW5GiYWkHV9FhjuI96wuIMPHYL3b+RpQEvIjHPR3RRVC7T2Ud
         63VU//EyhDVp88yJKxWRLeAAzer7sl/8lpW1ZpZfukRSwIazoVADuHJg3Ty12TNXFq6M
         gOeguA7x2d3bCGS1Lex6f6YF5JwVDy2mO1YkKrrKHAO7zQFQ3cma/+MucXa9Yw4Evbcb
         Zky3fI/vlYxUyeMolfmpBaylkbizkGwHOVjWk9GfmnJTXBiC8f/KZCnNGuNiGUAUILZ6
         Yl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756917574; x=1757522374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoceAUNVNtJENaw7MXRirluImj5CElTHazOJW4wFJQs=;
        b=t06A71f7aqyoCkXYUdKpcoP2uKt91/EvtvDO8M0MfxLYuz2bF+S5loUfVW0DQp7gyo
         0Gsp+W/jsryTbcBBwPccNQRdovpNtjJv8zPrG1QVJaGJQYIiH1HHISaUAAj8WSlI4KcU
         fLSHtKmOHLwScWowx0sam8jYfyOLgqjWcGPfL4S1DJnjPBG9LLj+0D8HhX7Y6kWecSUi
         CH2q/lmNNbCwNEcajKRcnryMf+DNfhpwNPg0iJKuLYcsxJt2lfxiFIMl+BWtAt8FKkLZ
         dcgl+Ou8Tj7ekXtH7BzBh5wbo6EiuQlgQZ9W66RRk2q2TpxmkNpMeKAnfaMzJOQqCylh
         1JSg==
X-Forwarded-Encrypted: i=1; AJvYcCUzlh4DY0SG6BGThP6D+3DmV3pNJ2V1ARlE4qMFYYC3Wdn0HqAlId6ZxQ4cyO4yuRsTq3M+/gbIewo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHeZKRtd2fv8mfV+9cXswQZRqOOY/BYhwnU6E5bvy8rx0xJaiR
	sfip55f0LLlGM65V4H6YS1ir5IF5hwxU4zJdiPs17r8woForgC4Tyep45U6sxAqldizHxyop6+r
	tvHzTr2i49xIBpMrF5Vc2ZLNpR8vUFse1FA==
X-Gm-Gg: ASbGnctj8BNp10yTd5NEzL+2VvbH5dEtB9vAB+EJSsvXjc6IveYR2wR5NAW3RQINoMh
	yATQWTWiHiO02e1VPOEBlrNrp0Js3+y8nSwqGeUjJAK0HcJvDOwe4qVjmRjaSkxcFk2K6iINMzK
	MLTAMwmCkwQZzG4Fnw70Fu1B8yreAZW31i0wM3F90OpzlO2rUBplARjsgzKNgsaFVIiap8rm643
	0F/bv/lEVel62z3mG4O0OjkVqJ9dWTLJv3qD3dLK+Xi2RwajAh0
X-Google-Smtp-Source: AGHT+IFgYYIP92d0stSKZZ+ddhbUhCuesniTZDgrqHi+gIVCPdWEPjmKJ1swlez5AI7YXsmi4FeUH8Msv4hZHqp3Kuw=
X-Received: by 2002:a2e:a545:0:b0:336:b387:6fb0 with SMTP id
 38308e7fff4ca-336cab18873mr40135751fa.30.1756917574035; Wed, 03 Sep 2025
 09:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <966f4d30-16f6-4a11-8d6c-1d6102781e71@gmail.com>
 <CAN-5tyGHKCt0KhTt2jKNdx77H3RcgY-xPKwkL4udvciR99=rrw@mail.gmail.com>
 <851ebd04-8f9c-4a17-aa55-654c021f07a5@gmail.com> <CACSpFtDcD7KHTPJjQUOAxyioBwWYhco-xxYD3wHCRohq9C5BQw@mail.gmail.com>
 <39155a1f-0ea8-4498-8601-7dcfc13d09fe@gmail.com>
In-Reply-To: <39155a1f-0ea8-4498-8601-7dcfc13d09fe@gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 3 Sep 2025 12:39:22 -0400
X-Gm-Features: Ac12FXy3Y84YR0DtrH6iYPrl45cqjgcOuPeH_hMshWxYKhoIN0vwXuiaT9M6yas
Message-ID: <CAN-5tyFVSMqgZ=2n+Y4t5oL=Ypz7gaZ=QFOHC_iTd1NU7qnbeg@mail.gmail.com>
Subject: Re: [PATCH] xs_sock_recv_cmsg failing to call xs_sock_process_cmsg
To: Justin Worrell <jworrell@gmail.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, smayhew@redhat.com, 
	trondmy@hammerspace.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 7:06=E2=80=AFPM Justin Worrell <jworrell@gmail.com> =
wrote:
>
>
>
> On 9/2/25 4:11 PM, Olga Kornievskaia wrote:
> > On Tue, Sep 2, 2025 at 4:46=E2=80=AFPM Justin Worrell <jworrell@gmail.c=
om> wrote:
> >>
> >>
> >>
> >> On 9/2/25 11:21 AM, Olga Kornievskaia wrote:
> >>> On Tue, Sep 2, 2025 at 8:27=E2=80=AFAM Justin Worrell <jworrell@gmail=
.com> wrote:
> >>>>
> >>>> xs_sock_recv_cmsg was failing to call xs_sock_process_cmsg for any c=
msg
> >>>> type other than TLS_RECORD_TYPE_ALERT (TLS_RECORD_TYPE_DATA, and oth=
er
> >>>> values not handled.) Based on my reading of the previous commit
> >>>> (cc5d5908: sunrpc: fix client side handling of tls alerts), it looks
> >>>> like only iov_iter_revert should be conditional on TLS_RECORD_TYPE_A=
LERT
> >>>> (but that other cmsg types should still call xs_sock_process_cmsg). =
On
> >>>> my machine, I was unable to connect (over mtls) to an NFS share host=
ed
> >>>> on FreeBSD. With this patch applied, I am able to mount the share ag=
ain.
> >>>
> >>> Thanks for the catch Justin. Indeed, the client fails to return an
> >>> error in case it receives anything other than TLS DATA or TLS ALERT.
> >>> Could you tell what kind of TLS message the FreeBSD server is sending=
?
> >>> Either a network trace or turning on tls_contentype tracepoint should
> >>> show what type the client has been receiving.
> >>
> >> Hi Olga,
> >>
> >> Unfortunately, I don't know much (anything, really) about Kernel
> >> debugging or the SSL protocol. I do have root on both boxes and am hap=
py
> >> to provide whatever information would help with better understanding t=
he
> >> issue. Could you provide some guidance (even if just where to go to
> >> rtfm) to fetch the requested info? I don't imagine just a tcpdump of t=
he
> >> ciphertext is sufficient. If providing this assistance is too spammy f=
or
> >> the list, it is okay to reach out off-list.
> >
> > Hi Justin,
> >
> > If you can do either of the 2 below that should capture the needed info=
rmation.
> >
> > For tracepoints (the following is easiest for me, others might prefer
> > usage of trace-cmd), as root, prior to executing the mount common
> > which I believe was shows (demonstrates the problem),
> > echo 1 > /sys/kernel/debug/tracing/events/handshake/tls_contenttype/ena=
ble
> > cat /sys/kernel/debug/tracing/trace_pipe (this can be redirected to a
> > file if desired)
> > do the mount with TLS
> > ctrl-c the cat. Provide output of cat command. I hope that should show
> > the types of control messages the client received.
> >
> > Tcpdump is useful if there is a corresponding TLS session key
> > included. Tlshd (the user level daemon that handles the TLS handshake
> > for the kernel NFS) will dump session key material to the location of
> > the SSLKEYLOGFILE environmental variable. So easiest (for me), set an
> > environment variable on the command line. SSLKEYLOGFILE=3Dssl.log, then
> > on the same shell run manually /usr/sbin/tlshd -s (assuming you
> > stopped the system's tlshd that was running before). Start tcpdump to
> > capture a network trace. Do the mount. Stop the network trace. Provide
> > ssl.log file and network trace (wireshark can decode TLS traffic
> > provided that log file). If it's not appropriate stopping tlshd and
> > running it by hand, then turning on tracepoints might be the way to
> > go.
> >
> > Thank you for your help.
> >
>
> Hi Olga,
>
> I'm not sure if attachments are allowed on this list, will be stripped,
> or if this email will be rejected. Fingers crossed.

Thank you for all the info. It was very useful.

> The tracepoint option produces the following line (sometimes with .l...,
> sometimes with .....) ~3400 times, which was unexpected to me:
> kworker/u40:2-712     [007] .l...   203.225007: tls_contenttype:
> src=3D192.168.124.204:896 dest=3D10.1.2.9:2049 HANDSHAKE

This is indeed interesting and pointing that something is looping over
'receiving' TLS HANDSHAKE type record past when handshake is done..
Something isn't right with the code (still) possibly.

> I have attached the output from cat'ing tracepoints as well as the
> tcpdump pcap file and tlshd ssl.log.
>
> All of this is from the VM where I have applied my patch (and the mount
> works). I can provide output for a stock kernel (where the mount command
> hangs) as well if required.
>
> >>
> >>>> ---
> >>>> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> >>>> --- a/net/sunrpc/xprtsock.c     (revision
> >>>> b320789d6883cc00ac78ce83bccbfe7ed58afcf0)
> >>>> +++ b/net/sunrpc/xprtsock.c     (date 1756813457481)
> >>>> @@ -407,9 +407,9 @@
> >>>>           iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
> >>>>                         alert_kvec.iov_len);
> >>>>           ret =3D sock_recvmsg(sock, &msg, flags);
> >>>> -       if (ret > 0 &&
> >>>> -           tls_get_record_type(sock->sk, &u.cmsg) =3D=3D TLS_RECORD=
_TYPE_ALERT) {
> >>>> -               iov_iter_revert(&msg.msg_iter, ret);
> >>>> +       if (ret > 0) {
> >>>> +               if (tls_get_record_type(sock->sk, &u.cmsg) =3D=3D TL=
S_RECORD_TYPE_ALERT)
> >>>> +                       iov_iter_revert(&msg.msg_iter, ret);
> >>>>                   ret =3D xs_sock_process_cmsg(sock, &msg, msg_flags=
, &u.cmsg,
> >>>>                                              -EAGAIN);
> >>>>           }
> >>>>
> >>
> >

