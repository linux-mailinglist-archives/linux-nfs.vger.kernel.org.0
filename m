Return-Path: <linux-nfs+bounces-13989-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82952B40F0F
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 23:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE9C1A84D9B
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 21:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8B8350828;
	Tue,  2 Sep 2025 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuO7ITQY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDBE2E9EC9
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847478; cv=none; b=CGZ/HN2GBrJH7llAPJgpkve3oBgg1roYJV0dFm64EPwtbG39bC9+3zllLjYx0t+4HvFs5IibewY4s8l1cMXvpzAMP58maxSBCJx/PFkSazlc3313ODwcMWz8zwgXXF8xBPoXHg8OrNXnaxPusVZZ/Ns91uvnPSQzdi0rwkzXNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847478; c=relaxed/simple;
	bh=rAZw2wzN+mNCQwkqKWXSj+Jo8o+3L49KVWHcE7NREP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWxc2jPBsUaYaGHtcou/NFAaxXsQDar4ICITIef5Lesfra+cuBJnmS1VRAvlsOABS+NseHNquPHYwRbbuXuQbVf2shwmnz9XoA5HI5H7br1Fi6liyc8RqqPKsaesoZanWXfj2M7xQ8qomGaNHXBZV+5rZLWTET49c+cA6D2cy+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YuO7ITQY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756847475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/d8Zp1oLnRga1pVqjbYV4B3B+zMvxZJ+PXaIWQ89As=;
	b=YuO7ITQYmsxm9+QD1s+YoCUxR1xAbNm5H3AUqGf80Z9cSgDOiEXwCWt/N35kHhg6wIECj2
	tE6pki6azfa1sGXoURrbwSTwQabxZstQp5EQY3T5qdaO14cS8vOPM0VrPTf/zZwnab2Eis
	UGf2xbY7fetujdPDCHooi808LF93Xv4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-RpSEc2VmOR2GK_fB67r-rg-1; Tue, 02 Sep 2025 17:11:14 -0400
X-MC-Unique: RpSEc2VmOR2GK_fB67r-rg-1
X-Mimecast-MFC-AGG-ID: RpSEc2VmOR2GK_fB67r-rg_1756847473
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-61d2de72644so286825a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Sep 2025 14:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756847473; x=1757452273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/d8Zp1oLnRga1pVqjbYV4B3B+zMvxZJ+PXaIWQ89As=;
        b=jzpG43y8EGwJSyNYcWWYRnLsWzvFVQ4atLPIQ4feGaiM23fzmOPH69SbB1NrEYfPeR
         t/2/RL35/uG8lRGYv0bOe+Dm11L+AtA6vO5Ay+FfrM7yrl4ZWQK+uqVc4crAQwtEdRFQ
         4Q/LrKPIx/C0cvJGGe7H3NIllezww47CWh9s6npB7tCPl4yoz8nivvu+dQNQAq/KxbTC
         0YXKHlXpi+bDARfoi1nI7PkKLdSTWugYOav8fMRuESoUSQmhnu2ORUnNWtPCqSmbkRI2
         e1QAJPnhWxYH1iLIt09QNcrpZbDdFFcaLx0dwL093hlOjPyaJN+kRU/09P5DTJNugP9q
         GAHg==
X-Forwarded-Encrypted: i=1; AJvYcCV0wWAYryBtAjWso3Iqm39l2qme9dCWRboVUjTIfhhF0+2kTUTtZymOW3130Ebz56bSZupoZpFxm7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0suePaX1QFStAm7fx/96ccP+fM6qK/bMJIJ7LgPIhHAlpeJ8
	NnFtu1BnMAfjh52PdxwO3xrLTNcrt67rG+v66UHeNavfoU3ZvFLoKWnMJ2QlS3alO1VAXxGlEHH
	9kutIIK2N+CeRnEpKIGAOvPpT689YLfY91AidrfwIudQYMnny59YW/EFOdG09l4bagqWHOzXfiN
	zCJROaoQ58mKTP7A+Ugp9+IKDEYF3Brab8S4vn
X-Gm-Gg: ASbGncsVhGPDaJIkijOWLpZw8iL3EITLFFDOg7gEDf8CuR2pZIvbOVB7YS4CiohnNsc
	niuaF69lvdBMlZ34fbsXoFTKWem6816Lfc87A3zVJU0Fs2xb8AF+LldhKYDiUmeuk2+iROh8sL5
	mtk76JE3OnfViPgWtf9uRHi/SudgYsDcbcNsV2zHnCIS9V12KoX8gv2Rg=
X-Received: by 2002:a05:6402:504b:b0:618:3521:6842 with SMTP id 4fb4d7f45d1cf-61d26d9c52dmr11739855a12.16.1756847473015;
        Tue, 02 Sep 2025 14:11:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlGR0CJ9QCSMLlB5XabQTgr28x9jmXZCIhwR7cGvA7jMUV00ldw50h41KlmGJhFGdFsMvuYOMZDCjN2riUnsA=
X-Received: by 2002:a05:6402:504b:b0:618:3521:6842 with SMTP id
 4fb4d7f45d1cf-61d26d9c52dmr11739822a12.16.1756847472564; Tue, 02 Sep 2025
 14:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <966f4d30-16f6-4a11-8d6c-1d6102781e71@gmail.com>
 <CAN-5tyGHKCt0KhTt2jKNdx77H3RcgY-xPKwkL4udvciR99=rrw@mail.gmail.com> <851ebd04-8f9c-4a17-aa55-654c021f07a5@gmail.com>
In-Reply-To: <851ebd04-8f9c-4a17-aa55-654c021f07a5@gmail.com>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Tue, 2 Sep 2025 17:11:01 -0400
X-Gm-Features: Ac12FXxvxfv7doCsX_I1qRXeyskeDi6OBBh6PqVMn6gK64fDBpBmo2UMPLHMNuE
Message-ID: <CACSpFtDcD7KHTPJjQUOAxyioBwWYhco-xxYD3wHCRohq9C5BQw@mail.gmail.com>
Subject: Re: [PATCH] xs_sock_recv_cmsg failing to call xs_sock_process_cmsg
To: Justin Worrell <jworrell@gmail.com>
Cc: Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org, smayhew@redhat.com, 
	trondmy@hammerspace.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 4:46=E2=80=AFPM Justin Worrell <jworrell@gmail.com> =
wrote:
>
>
>
> On 9/2/25 11:21 AM, Olga Kornievskaia wrote:
> > On Tue, Sep 2, 2025 at 8:27=E2=80=AFAM Justin Worrell <jworrell@gmail.c=
om> wrote:
> >>
> >> xs_sock_recv_cmsg was failing to call xs_sock_process_cmsg for any cms=
g
> >> type other than TLS_RECORD_TYPE_ALERT (TLS_RECORD_TYPE_DATA, and other
> >> values not handled.) Based on my reading of the previous commit
> >> (cc5d5908: sunrpc: fix client side handling of tls alerts), it looks
> >> like only iov_iter_revert should be conditional on TLS_RECORD_TYPE_ALE=
RT
> >> (but that other cmsg types should still call xs_sock_process_cmsg). On
> >> my machine, I was unable to connect (over mtls) to an NFS share hosted
> >> on FreeBSD. With this patch applied, I am able to mount the share agai=
n.
> >
> > Thanks for the catch Justin. Indeed, the client fails to return an
> > error in case it receives anything other than TLS DATA or TLS ALERT.
> > Could you tell what kind of TLS message the FreeBSD server is sending?
> > Either a network trace or turning on tls_contentype tracepoint should
> > show what type the client has been receiving.
>
> Hi Olga,
>
> Unfortunately, I don't know much (anything, really) about Kernel
> debugging or the SSL protocol. I do have root on both boxes and am happy
> to provide whatever information would help with better understanding the
> issue. Could you provide some guidance (even if just where to go to
> rtfm) to fetch the requested info? I don't imagine just a tcpdump of the
> ciphertext is sufficient. If providing this assistance is too spammy for
> the list, it is okay to reach out off-list.

Hi Justin,

If you can do either of the 2 below that should capture the needed informat=
ion.

For tracepoints (the following is easiest for me, others might prefer
usage of trace-cmd), as root, prior to executing the mount common
which I believe was shows (demonstrates the problem),
echo 1 > /sys/kernel/debug/tracing/events/handshake/tls_contenttype/enable
cat /sys/kernel/debug/tracing/trace_pipe (this can be redirected to a
file if desired)
do the mount with TLS
ctrl-c the cat. Provide output of cat command. I hope that should show
the types of control messages the client received.

Tcpdump is useful if there is a corresponding TLS session key
included. Tlshd (the user level daemon that handles the TLS handshake
for the kernel NFS) will dump session key material to the location of
the SSLKEYLOGFILE environmental variable. So easiest (for me), set an
environment variable on the command line. SSLKEYLOGFILE=3Dssl.log, then
on the same shell run manually /usr/sbin/tlshd -s (assuming you
stopped the system's tlshd that was running before). Start tcpdump to
capture a network trace. Do the mount. Stop the network trace. Provide
ssl.log file and network trace (wireshark can decode TLS traffic
provided that log file). If it's not appropriate stopping tlshd and
running it by hand, then turning on tracepoints might be the way to
go.

Thank you for your help.

>
> >> ---
> >> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> >> --- a/net/sunrpc/xprtsock.c     (revision
> >> b320789d6883cc00ac78ce83bccbfe7ed58afcf0)
> >> +++ b/net/sunrpc/xprtsock.c     (date 1756813457481)
> >> @@ -407,9 +407,9 @@
> >>          iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
> >>                        alert_kvec.iov_len);
> >>          ret =3D sock_recvmsg(sock, &msg, flags);
> >> -       if (ret > 0 &&
> >> -           tls_get_record_type(sock->sk, &u.cmsg) =3D=3D TLS_RECORD_T=
YPE_ALERT) {
> >> -               iov_iter_revert(&msg.msg_iter, ret);
> >> +       if (ret > 0) {
> >> +               if (tls_get_record_type(sock->sk, &u.cmsg) =3D=3D TLS_=
RECORD_TYPE_ALERT)
> >> +                       iov_iter_revert(&msg.msg_iter, ret);
> >>                  ret =3D xs_sock_process_cmsg(sock, &msg, msg_flags, &=
u.cmsg,
> >>                                             -EAGAIN);
> >>          }
> >>
>


