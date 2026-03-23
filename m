Return-Path: <linux-nfs+bounces-20334-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DBbCEebwWlNUAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20334-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 20:57:59 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 937112FCB6D
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 20:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B34AC3001CF5
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 19:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10F3612F1;
	Mon, 23 Mar 2026 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="oB3gTCWK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DA93AB26E
	for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295871; cv=pass; b=EPhcraqWqhOLOKhPpfvT644wWow3yEuvvIfrpfxRj/x3vvfHXo/nbH9YjEotE57QfKm7L1vGgNtOxb3r9dF35uTBoPBTLoZSRUZkbRF7XXlbM43Lu5ccnu5ZPxAynDU+/bL86yg+hHAX1pFjuWbJDO0OyyJ82z1hCbvl2BwhxZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295871; c=relaxed/simple;
	bh=TWBeDjn+lzuYEF9yLibX1SDg1pcI3iUQTLIq6ga8Qvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Afqb2nkTMps5eQ6kKWzL8Q0hTjFqLFVSyosiMjoJT2fCOV0kEVTAsPOhzTwcSwYrZd8Ec35oS8OBoYb6QkdkxSjqSmIcsGOmaJU+tffSFILGBIaiq+oVoyjL6CU+VgaYNT3LaRxmll8UdiUPE49UuyeQ1coBKC1NPgSFfCh7Zn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=oB3gTCWK; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38be5e86918so4944651fa.3
        for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 12:57:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774295868; cv=none;
        d=google.com; s=arc-20240605;
        b=ESzktxH3vLiu9EFB2ymxpplk0DgSAl4yYF5fAxfKtQsiyghQTimx9X2bm9vYYfN0jC
         UWXJs36cK+UdsPB+FJW6u/d7uO06jzelFbgfwMdQ8mFoouh/qb9UJhmJXm98kAp2yf1M
         OdAVLhMZaIF59qkdc1dv4cF2DNyHW6JlU4fDDWC9fRQ0tFJLy1GVRQWDjtOyZyPbCQAK
         /JttDx5zPDbHOh99gdkMbi9P1YuJ0ymyRoos9O6xstp+RPh59POzYnD5pzNPkWMHpINs
         /LHuyijzbPRk5M20PZvAg2Fmmr/3HtMigmwpQ/PstqKvbcPaooRCGi3lTnZ0rEFYlIt+
         /LZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=27vnSWTXVBaXYK+aCchBr2Jk1LxjFNnhcMVeVG+WbIw=;
        fh=hux8CpYW61vsN8ZHtocYkEoo93vZixSUwfowCAbaSqM=;
        b=iYRJmFn/XZO7exaO6tqyilKDyxlaECjuVPX1Lucet5r7U91psqQdcdKKKGLJ8w+NJZ
         bWWe/Gzxd8f1LQE0qeJajV+OOF8C6k0z8tH/LB30PerA98G6SSedQkKmfplCts8J+8Uo
         iSUWzeWJUEbc0qO3VafHfQ5dJq7CT13IGSEAb4xT7PlUCc9lqxCjFb4uKSSgyLbsafJX
         D6PL3nEaH14+0L426iYDEcWQ6KNS6D6n4Tm8k0vZylkWzVECfeeZBaacsal7JbBY2ASr
         z6JAFmUaczXff/SK5rZlkbESknaZKzZ7A4DdbuZUhHZ0ZDMwYbFiaP+9wGMFsAknnr6i
         wgmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1774295868; x=1774900668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27vnSWTXVBaXYK+aCchBr2Jk1LxjFNnhcMVeVG+WbIw=;
        b=oB3gTCWK+tisk51SkrJ56DLfI3xvGBiU/IRUtruVsSrgmdB7+FfrZ7WYwkGW/4GSGI
         0nCR0IhSJQrjAaoq6Iv546X68inFsgrFQ10EcOA9U/qspWpZ24rYefG/yHjn/pxnphdX
         EFZIjwBoLL/YJWSvVcyBmcr7FDuPfDvycoM5oehQQMqvikTfsCWA95YlUDV5y0lgDmAa
         9xwImmb9gY405sm8+32aEVO9LeLq767Fm8izKKj5i1B3/vAB50zw4mN9WqgOEXyF+huz
         wfIp3uuI0iwrx+mFTbyWvwDqBqjsCAigKPn90TuFaWcnGT3MzPPoYe6udTLuN+6xiRik
         zf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774295868; x=1774900668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=27vnSWTXVBaXYK+aCchBr2Jk1LxjFNnhcMVeVG+WbIw=;
        b=PLekfPpDpBSCx1bzsBMwlz7vInC9cehehgBsb7uiqrmh8TAk2RIKLo1BMmK7FUrNiB
         PbxsHgk4Nztb+BBgqqc4LvxZFXI6UjOQzBmnTWRp9+UQKFfAtbTEUQXWnJcVLdEV5pGZ
         9pD14KNomlflMBI4jlcNw3Y/xD45JpAsdU6CsRAzuCBGIq3n253L53TPeZSP+S0FZD9S
         pNh5Hzh9o5iHC9eZe2y82EziLfzxaL9ONueh0cOz9sdc0RGhRhukDwSesCKD96qEugzr
         2YIflG2HWLawm1L0RmKEzzm+7pXmm8PKl3b+i+jH9+m3yRmN3w0rhuJsyn7V1YTUuI74
         bTmg==
X-Forwarded-Encrypted: i=1; AJvYcCXrFM2tFxRIzCOmSwaom+5+kddFdGSs4ENQhqnWjQaqaXwObPAmzOHzUPLzjhTHv6P0MWIQeYxXfYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt05AoDEeIHtxDbKZCXqQIKSeeMahwHKJph0DuEKr4M78VodJ/
	ws3JplXUerMQl//MEE02wCSGPwFPA3jNsXDTsc1yQOG8h1ff5TTf2u7hPJIEDNoe9TRwqsHEMUz
	MzsjBn4wLJhAOkkDqL4fbLkOP2MHRJBc=
X-Gm-Gg: ATEYQzwoQ7xCzFf7hbVlLt3440TOkidpiQC1zB4KEccqysGTjJt7R8mMcbo6pYkWAHm
	FSJUL598KYOQsbBU8/UWNgYqF+/cefc21aPEhrA5yavaLnseo48RjlySlEC3TGc8R6+Y5jhdNfB
	DWzeKPnn12lgowGbjyXu8eGe6SyoshX90UhrB4H+KsQMjvGYh1dJS5XH5gz9+0Q6nrRzfYyJ3hP
	QdDvqhgFAfc02N4FFxYz1kMiP/vQBFmpJXoRlhAYYUaLSha8Ec5SrDQ9VW8LBhecYilSjbHEtRX
	Fim3Woi6mIF2uk4ax0k/gWh9JVuE8XLoclnuQeePEQ==
X-Received: by 2002:a2e:a00c:0:20b0:38a:8199:1b60 with SMTP id
 38308e7fff4ca-38bf9616bb4mr36144721fa.6.1774295867604; Mon, 23 Mar 2026
 12:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323182142.79465-1-okorniev@redhat.com> <24a15058d09d238ab627a6359ca9241e6aa499ce.camel@kernel.org>
In-Reply-To: <24a15058d09d238ab627a6359ca9241e6aa499ce.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 23 Mar 2026 15:57:36 -0400
X-Gm-Features: AaiRm515pU2cnEIiiXEiNqHxzrUfwl01XUr6Er6ES0AqZ7M3KDctwUb1rEPS5HE
Message-ID: <CAN-5tyEQe5KrqKNy_HtMfciyrKsxLm8Xu=ugUEBpH+gtf7OYGw@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsdctl: check for listeners before starting threads
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, steved@redhat.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20334-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[umich.edu:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 937112FCB6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 2:52=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2026-03-23 at 14:21 -0400, Olga Kornievskaia wrote:
> > When a thread command is executed and yet no listeners have been
> > added prior to it, instead of failing with EIO error print an
> > informative error. Also, "thread 0" command should not error
> > regardless of the listener status.
> >
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  utils/nfsdctl/nfsdctl.c | 52 ++++++++++++++++++++++++++++++++---------
> >  1 file changed, 41 insertions(+), 11 deletions(-)
> >
> > diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> > index 6a20d180..d03e2c9f 100644
> > --- a/utils/nfsdctl/nfsdctl.c
> > +++ b/utils/nfsdctl/nfsdctl.c
> > @@ -162,6 +162,9 @@ static const char *nfsd4_ops[] =3D {
> >       [OP_REMOVEXATTR]        =3D "OP_REMOVEXATTR",
> >  };
> >
> > +static int fetch_current_listeners(struct nl_sock *sock);
> > +static int print_listeners(int output);
> > +
> >  static int error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err=
,
> >                        void *arg)
> >  {
> > @@ -720,7 +723,7 @@ static int threads_func(struct nl_sock *sock, int a=
rgc, char **argv)
> >       uint8_t cmd =3D NFSD_CMD_THREADS_GET;
> >       int *pool_threads =3D NULL;
> >       int minthreads =3D -1;
> > -     int opt, pools =3D 0;
> > +     int opt, pools =3D 0, zero_threads =3D 0;
> >
> >       optind =3D 1;
> >       while ((opt =3D getopt_long(argc, argv, "hm:", threads_options, N=
ULL)) !=3D -1) {
> > @@ -762,12 +765,31 @@ static int threads_func(struct nl_sock *sock, int=
 argc, char **argv)
> >                       }
> >
> >                       pool_threads[i] =3D strtol(targv[i], &endptr, 0);
> > +                     if (!pool_threads[i])
> > +                             zero_threads++;
> >                       if (!endptr || *endptr !=3D '\0') {
> >                               xlog(L_ERROR, "Invalid threads value %s."=
, argv[1]);
> >                               return 1;
> >                       }
> >               }
> >       }
> > +     /* check if there are listeners added */
> > +     if (fetch_current_listeners(sock)) {
> > +             xlog(L_ERROR, "Unable to determine if listeners were adde=
d\n");
> > +             return 1;
> > +     }
> > +     if (!print_listeners(0)) {
> > +             if (zero_threads && zero_threads =3D=3D pools) {
> > +                     /* Note: we can never have a server with threads =
and no
> > +                      * listeners. If we ever add functionality to rem=
ove
> > +                      * listeners on an active server, we need to revi=
sit this.
> > +                      */
> > +                     return 0;
> > +             }
> > +             xlog(L_ERROR, "No listeners added, not starting threads\n=
");
> > +             return 1;
> > +     }
> > +
> >       return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL, m=
inthreads);
> >  }
> >
> > @@ -1077,9 +1099,9 @@ out:
> >       return ret;
> >  }
> >
> > -static void print_listeners(void)
> > +static int print_listeners(int output)
>
> Maybe instead of adding the "output" parameter, you could just add a
> count_listeners() function?

Well, I thought would need to do all the work of print_listener(), I
would assume we'd want to do all the checks done by print_listener
before it prints the value or in my case count it as a listener. And
thus I opted for re-using the function but adding the count.

If you think it's sufficient to just check if sock->name is non-empty
and active and do no further checking, I can.

> Ack on the basic idea though!
>
> >  {
> > -     int i;
> > +     int i, count =3D 0;
> >       const char *res;
> >
> >       for (i =3D 0; i < MAX_NFSD_SOCKETS; ++i) {
> > @@ -1098,26 +1120,34 @@ static void print_listeners(void)
> >                       res =3D inet_ntop(AF_INET, &((struct sockaddr_in =
*)(&sock->ss))->sin_addr,
> >                                       addr, INET6_ADDRSTRLEN);
> >                       port =3D ((struct sockaddr_in *)(&sock->ss))->sin=
_port;
> > -                     if (res =3D=3D NULL)
> > +                     if (res =3D=3D NULL && output)
> >                               perror("inet_ntop");
> > -                     else
> > -                             printf("%s:%s:%hu\n", sock->name, addr, n=
tohs(port));
> > +                     else {
> > +                             count++;
> > +                             if (output)
> > +                                     printf("%s:%s:%hu\n", sock->name,=
 addr, ntohs(port));
> > +                     }
> >                       break;
> >               case AF_INET6:
> >                       res =3D inet_ntop(AF_INET6, &((struct sockaddr_in=
6 *)(&sock->ss))->sin6_addr,
> >                                       addr, INET6_ADDRSTRLEN);
> >                       port =3D ((struct sockaddr_in6 *)(&sock->ss))->si=
n6_port;
> > -                     if (res =3D=3D NULL)
> > +                     if (res =3D=3D NULL && output)
> >                               perror("inet_ntop");
> > -                     else
> > -                             printf("%s:[%s]:%hu\n", sock->name, addr,=
 ntohs(port));
> > +                     else {
> > +                             count++;
> > +                             if (output)
> > +                                     printf("%s:[%s]:%hu\n", sock->nam=
e, addr, ntohs(port));
> > +                     }
> >                       break;
> >               default:
> > -                     snprintf(addr, INET6_ADDRSTRLEN, "Unknown address=
 family: %d\n",
> > +                     if (output)
> > +                             snprintf(addr, INET6_ADDRSTRLEN, "Unknown=
 address family: %d\n",
> >                                       sock->ss.ss_family);
> >                       addr[INET6_ADDRSTRLEN - 1] =3D '\0';
> >               }
> >       }
> > +     return count;
> >  }
> >
> >  static bool ipv6_is_enabled(void)
> > @@ -1394,7 +1424,7 @@ static int listener_func(struct nl_sock *sock, in=
t argc, char ** argv)
> >               return set_listeners(sock);
> >       }
> >
> > -     print_listeners();
> > +     print_listeners(1);
> >       return 0;
> >  }
> >
>
> --
> Jeff Layton <jlayton@kernel.org>
>

