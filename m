Return-Path: <linux-nfs+bounces-1006-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA8982938F
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 07:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A04228882C
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 06:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789FB360AD;
	Wed, 10 Jan 2024 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx7eCAPU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AC536090
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jan 2024 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-557e76e1bd6so2393682a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 09 Jan 2024 22:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704866845; x=1705471645; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5FGfhbdVomeF7O3caWiuug3L2YzSEAcwU9+aiNs9e8=;
        b=lx7eCAPUS5lDGMuPF14l+zp9iZKVyv4ZdCXKfFbtOxVK+PE1kT/RsxgJhCiJoPrm90
         vxLX2IeSZI3voNvaZ4l9yOzaRao0e1uF+gUAvvVXZELZ/k+8SibW9uu4J9YqAwyLmuMM
         WNsqRflafaFItKUfsdzwY1yxn1O7H5LzpDygJzG2VMq/dB7dZt9Ygw1NW6emeId/lr9D
         xJc9tCuwAHA0R+1F9ET0wxKi57SBqo1caD/mmfoMxU7WY8Hgfj6SO53dk2GlpDTLkXtS
         7tfkMUBKp++VilpN3HG1OH3/0j38IPrw163Rw0YYVp78EPjHI1L35o0zjP68O3CVYEcO
         3O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704866845; x=1705471645;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5FGfhbdVomeF7O3caWiuug3L2YzSEAcwU9+aiNs9e8=;
        b=JDGVbwSP28e259FGahErQmJpv9EqD3SqwkVF2qO+q5TlyL+HozNyipoIY0esH1yU3k
         4wTADop7QQaz3ACfwi0qzznSQSdapPXtH1REPgzPYAEyDouV1kZwYaJF3uX8l0quZxhE
         NwZ0+JYwwFP+eaUDep2Yh6YFSpwvmEJq7l6r6Fhf0HE6f0JpxRj4gpwIrsAVWV0+9Bur
         7Ec9cvwne4D2GdVprl/gn9mmzQoZJDZ2c3PwYOYHOjKsaNuqLAw/W11yhz9UfqKxSiUq
         /EypZSBe01Nvv1p6Vysq+rSTINtrDKoyp57B3laq3tGv0UFD76BNYZudsY/aq9CoLoM/
         2XcA==
X-Gm-Message-State: AOJu0YxF2mzmDxzr4Tv0mGvGObigQHn2cH0nspd3uksKTaiZG4D6W9hg
	lmoK8iCztw8zYC/3b7/FFh7HfTyet9aNA2XPtP1rwK+/
X-Google-Smtp-Source: AGHT+IGWcm2q+OGi2RNqwZTFwdxy9e8NStZQLHgLTwGoLBPHuX6A7nuaZ/kyPMHQ3chpyKRQYRiBufMZO+w8x2NB80Q=
X-Received: by 2002:a50:ef0c:0:b0:553:98b5:6816 with SMTP id
 m12-20020a50ef0c000000b0055398b56816mr105429eds.65.1704866844705; Tue, 09 Jan
 2024 22:07:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdFR7Xn51eKFUUi6a68wvDKc-RXz7F4LKyQgDptqfYbgw@mail.gmail.com>
 <CALXu0UfSJ0Qc3HOecf4pQ=VnEVqxRw6OGzNwhh9BUVYaHV7_oQ@mail.gmail.com> <ZZwJLb7j65QXR1+K@tissot.1015granger.net>
In-Reply-To: <ZZwJLb7j65QXR1+K@tissot.1015granger.net>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 10 Jan 2024 07:06:00 +0100
Message-ID: <CALXu0UdJanF-_=3TzgzUskwh1RGPjw+LeZ0Cht+yP1aQgr8v+w@mail.gmail.com>
Subject: Re: nfs-utils&nfsd&autofs not supporting non-2049 TCP port numbers -
 Fwd: showmount -e with custom port number?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 15:39, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> On Sun, Jan 07, 2024 at 11:33:31PM +0100, Cedric Blancher wrote:
> > Could you please make a concentrated effort and allow non-2049 port
> > numbers for NFSv4 mounts, in all of the lifecycle of a NFSv4 mount?
> > From nfsd, nfsd referrals, client mount/umount, autofs
> > mount/umount+LDAP spec
>
> One reason we have not pursued stack-wide NFSv4 support for
> alternate ports is that they are not firewall-friendly. A major
> design point of NFSv4 (and NFSv4.1, with its backchannel) is that
> it is supposed to be more firewall-friendly than NFSv3, its
> auxiliary protocols, and its requirement to deploy rpcbind.

Who came up with THAT argument?!

NFSv4 was designed around the concept of ONE TCP port for everything
(fs, mount, lock daemons, ...), so multiple servers per IPv4 address
can become a reality, but not specifically 2049 - with the clear
assumption that using port 2049 might not be feasible for all
organisations.
If you look at Solaris BUGSTER (remember, we were a big SUN customer
in the 1990/2000, so we had lots of bugs open for this mess), you'll
find lots of reasons why one single port for NFS is not feasible in
all scenarios.

Just some examples, but certainly not limited to:
- Fine-grained HSM, all on one host
- Fine-grained project/resource management, i.e. one nfs server per
project, all on one host
- Competing teams
- Hostile IT department (e.g. port 2049 blocked out of FEAR - not
reason, no further discussion/negotiation possible)
- NFSv4 tunneled via ssh
- NAT, e.g. private IPv4 address range inside, only one IPv4 address outside
- IPv4 address shortage
- Software test deployments in parallel to the production systems, on
the same machine
- ...

In any of these scenarios you'll end up with NFSv4 certainly not using
TCP port 2049.

>
> Also, these days it is relatively easy in Linux to deploy multiple
> NFS services on a single physical host by using containers (or just
> separate network namespaces).

That would assume people want to waste resources on the container
madness. OK, I better stop here, before I start counting how many MB
are wasted on the container/VM cr*p.

> So instead of alternate ports, each
> NFS service is on port 2049, but it has its own IP address.

Not feasible with NAT, or IPv4 address shortage.

> That
> kind of deployment is supposed to be fully supported with NFSD today.
>
> Commercial NFS server implementations also typically make it easy
> to add distinct NFSv4 services at unique IP addresses but all on
> port 2049.

Unfortunately this is just wishful thinking. Please check how NIH or
CERN do their setups - you'll get a nasty surprise in terms of NFSv4
port==2049.

Just the reality, from our side:
Active, per-project nfs servers: 14030. Only 1717 (less than 10%!!)
use TCP port 2049, all others do their duty in the port range of
10000-16999.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

