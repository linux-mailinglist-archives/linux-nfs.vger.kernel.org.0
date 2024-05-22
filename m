Return-Path: <linux-nfs+bounces-3335-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF16C8CC2AF
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 15:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDAF1C22A04
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 13:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B0F1411FF;
	Wed, 22 May 2024 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="mbRv37U+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC291411C5
	for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386275; cv=none; b=h9nwupc7DGYBm69CzspNuhi9Q9dG3lvcbRfdq2PayqB6tXCRPbgaU4hnO2hC/mJtgM0EcKS2mHap9idgsvQOX8m7M13uWNIeL/ajmH677zDTT+41CSpMph6hu4m+kFmbyISEa0VUGV2UeTPQ1zgTpB7QympSa/OQ1iTd3Wegq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386275; c=relaxed/simple;
	bh=INzouDcYfC3xnW4clAealQZb+a6s3HnkPVFSK0UBXzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5Nh1m+T8dQfgwx3NXDtNgI2nwx2jt8S5eAtgF33r9oOaNWNcd4G9tLvD8lfyGN5t+hw0ZCzkQqEV0T9lzD7nqhOEZrB2YamuavdQhPhIPqzP+bzG3IKqTkKm1HniZJi75iHHPeXHcLULKMiJ+OCadhrGvG/qUsVP+Q6114YtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=mbRv37U+; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e381f7c9c4so3510481fa.3
        for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1716386272; x=1716991072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCYIhq+zcwg/F2CjTy+Hnw/tX9gqfpfJ08B5POI0hBs=;
        b=mbRv37U+fawGTFY5o6xlJZIDs2+PZmdrPccMrgz1yIllVHlwMo5Jk0hocD0zxOnZoE
         rYO0Rn55l4qgbT0S3cgiZC3qvcemgE3lM7TXNjEZ9zI9/Xy9kdymvadDUYZKXLZ3CZuN
         DD4GwgZpxH1EhxfKbJTar6Ig19QD6mJkD2J2ClnqD9rGEA2qQGtZ5n0Ixj1LvXOMG1vw
         /07lcmNT7z2cBBJGRtang1Zzqhm2hzFMy7wK/o6nNbwkeicymdh+Nkc3LjraiAVl27bH
         mJow3XEkwr2+OX7PAzmuYyhdU9joUTAISoxYHB3FNb/KG0foTk/r+ojf6g914g87nJi9
         TAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716386272; x=1716991072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCYIhq+zcwg/F2CjTy+Hnw/tX9gqfpfJ08B5POI0hBs=;
        b=pTeM0A7V6T1DoJSapzr0rAI+4EOdXl/3kUdnd9YYIOXTFgsEtRLQwtLUB5pWaPqG94
         D8SZMMUr1Z3AvPFZLjJXDNIPdNSoiwAJ0Zc3rEEEgEYD/1JTGbgqSSFdhwCkT4C6y3QR
         PBeohVEtKWlN4SMwlrnPYyuYtxtiDutaLZR8U22eSOOPXK8SbhSCkM0XfcYceFHgXFCE
         GmA9Yd+swp+o2451DLPxaaRGU2/+ZGg2tK4dBH9JxivehoVDG0J8oEeknyg3xthQBkJs
         yQKWOobq50VfklpfCfUyYn3214G6RVsr60X+1EXvFQUQ9xqf6lhYqNb5lBe9z5V4HHRW
         InKA==
X-Forwarded-Encrypted: i=1; AJvYcCUfLpf14qvdm9GIZ/GP88fL3Undvx013ckDVrL3qVI8KHIUHUaSD7WbX/gq9yYBgtzWAl+pOVBu6I28tKjEotubz0foIjq0zxJ+
X-Gm-Message-State: AOJu0YyGRu+tyvGMHaH6RlFyJZB2lKTwgwp2ZjF5cNqSSi4+HfJCN+MS
	cNL6g/2ax5UNAPfw7iu4OReb7jpYIODaLiiBIQmXwlpEE2PDBw5aiTmwtdMLY+oohdhQoGlO0jn
	JCXbiGyLMymNIb5QuSCqiiJn++Vk=
X-Google-Smtp-Source: AGHT+IHTXHn1kZCnw8yTbno3RhYxpETWBbttqIn5wNOj5cL+4ZfiXrachVteiqPzlDetR2e5D+QjdQ036uBRGXarXAU=
X-Received: by 2002:a2e:92c8:0:b0:2e2:1647:8308 with SMTP id
 38308e7fff4ca-2e9495af3d3mr11821291fa.2.1716386271339; Wed, 22 May 2024
 06:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyFBn3C_CTrsftuYeWJHe7KWxd82YFCyrN9t=az8J4RU0w@mail.gmail.com>
 <2C80B5BC-AAEC-41F8-BEB6-C920F88C89BB@oracle.com> <0b1101daa646$d26a6300$773f2900$@mindspring.com>
 <CAN-5tyGECFmtzFsYNSZicPcH4SMKF0yovk6V20sWJ1LrZKzzyA@mail.gmail.com> <0b1401daa64b$f5831ee0$e0895ca0$@mindspring.com>
In-Reply-To: <0b1401daa64b$f5831ee0$e0895ca0$@mindspring.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 22 May 2024 09:57:39 -0400
Message-ID: <CAN-5tyHWeQykx0cFpOFf2hTBRk9_NaZarzeeAFdSu2NW0zqobA@mail.gmail.com>
Subject: Re: sm notify (nlm) question
To: Frank Filz <ffilzlnx@mindspring.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 6:13=E2=80=AFPM Frank Filz <ffilzlnx@mindspring.com=
> wrote:
>
>
>
> > -----Original Message-----
> > From: Olga Kornievskaia [mailto:aglo@umich.edu]
> > Sent: Tuesday, May 14, 2024 2:50 PM
> > To: Frank Filz <ffilzlnx@mindspring.com>
> > Cc: Chuck Lever III <chuck.lever@oracle.com>; Linux NFS Mailing List <l=
inux-
> > nfs@vger.kernel.org>
> > Subject: Re: sm notify (nlm) question
> >
> > On Tue, May 14, 2024 at 5:36=E2=80=AFPM Frank Filz <ffilzlnx@mindspring=
.com> wrote:
> > >
> > > > > On May 14, 2024, at 2:56=E2=80=AFPM, Olga Kornievskaia <aglo@umic=
h.edu>
> > wrote:
> > > > >
> > > > > Hi folks,
> > > > >
> > > > > Given that not everything for NFSv3 has a specification, I post a
> > > > > question here (as it concerns linux v3 (client) implementation)
> > > > > but I ask a generic question with respect to NOTIFY sent by an NF=
S server.
> > > >
> > > > There is a standard:
> > > >
> > > > https://pubs.opengroup.org/onlinepubs/9629799/chap11.htm
> > > >
> > > >
> > > > > A NOTIFY message that is sent by an NFS server upon reboot has a
> > > > > monitor name and a state. This "state" is an integer and is
> > > > > modified on each server reboot. My question is: what about state
> > > > > value uniqueness? Is there somewhere some notion that this value
> > > > > has to be unique (as in say a random value).
> > > > >
> > > > > Here's a problem. Say a client has 2 mounts to ip1 and ip2 (both
> > > > > representing the same DNS name) and acquires a lock per mount. No=
w
> > > > > say each of those servers reboot. Once up they each send a NOTIFY
> > > > > call and each use a timestamp as basis for their "state" value --
> > > > > which very likely is to produce the same value for 2 servers
> > > > > rebooted at the same time (or for the linux server that looks lik=
e
> > > > > a counter). On the client side, once the client processes the 1st
> > > > > NOTIFY call, it updates the "state" for the monitor name (ie a
> > > > > client monitors based on a DNS name which is the same for ip1 and
> > > > > ip2) and then in the current code, because the 2nd NOTIFY has the
> > > > > same "state" value this NOTIFY call would be ignored. The linux
> > > > > client would never reclaim the 2nd lock (but the application
> > > > > obviously would never know it's missing a lock)
> > > > > --- data corruption.
> > > > >
> > > > > Who is to blame: is the server not allowed to send "non-unique"
> > > > > state value? Or is the client at fault here for some reason?
> > > >
> > > > The state value is supposed to be specific to the monitored host. I=
f
> > > > the client is indeed ignoring the second reboot notification, that'=
s incorrect
> > behavior, IMO.
> > >
> > > If you are using multiple server IP addresses with the same DNS name,=
 you
> > may want to set:
> > >
> > > sysctl fs.nfs.nsm_use_hostnames=3D0
> > >
> > > The NLM will register with statd using the IP address as name instead=
 of host
> > name. Then your two IP addresses will each have a separate monitor entr=
y and
> > state value monitored.
> >
> > In my setup I already have this set to 0. But I'll look around the code=
 to see what
> > it is supposed to do.
>
> Hmm, maybe it doesn't work on the client side. I don't often test NLM cli=
ents with my Ganesha work because I only run one VM and NLM clients can=E2=
=80=99t function on the same host as any server other than knfsd...

I've been staring and tracing the code and here's what I conclude: the
use of nsm_use_hostname toggles nothing that helps. No matter what
statd always stores whatever it is monitoring based on the DSN name
(looks like git blame says it's due to nfs-utils's commit
0da56f7d359475837008ea4b8d3764fe982ef512 "statd - use dnsname to
ensure correct matching of NOTIFY requests". Now what's worse is that
when statd receives a 2nd monitoring request from lockd for something
that maps to the same DNS name, statd overwrites the previous
monitoring information it had. When a NOTIFY arrives from an IP
matching the DNS name, the statd does the downcall and it will send
whatever the last monitoring information lockd gave it. Therefore all
the other locks will never be recovered.

What I struggle with is how to solve this problem. Say ip1 and ip2 run
an NFS server and both are known under the same DNS name: foo.bar.com.
Does it mean that they represent the "same" server? Can we assume that
if one of them "rebooted" then the other rebooted as well?  It seems
like we can't go backwards and go back to monitoring by IP. In that
case I can see that we'll get in trouble if the rebooted server indeed
comes back up with a different IP (same DNS name) and then it would
never match the old entry and the lock would never be recovered (but
then also I think lockd will only send the lock to the IP is stored
previously which in this case would be unreachable). If statd
continues to monitor by DNS name and then matches either ips to the
stored entry, then the problem comes with "state" update. Once statd
processes one NOTIFY which matched the DNS name its state "should" be
updated but then it would leads us back into the problem if ignoring
the 2nd NOTIFY call. If statd were to be changed to store multiple
monitor handles lockd asked to monitor, then when the 1st NOTIFY call
comes we can ask lockd to recover "all" the store handles. But then it
circles back to my question: can we assume that if one IP rebooted
does it imply all IPs rebooted?

Perhaps it's lockd that needs to change in how it keeps track of
servers that hold locks. The behaviour seems to have changed in 2010
(with commit 8ea6ecc8b0759756a766c05dc7c98c51ec90de37 "lockd: Create
client-side nlm_host cache") when nlm_host cache was introduced
written to be based on hash of IP. It seems that before things were
based on a DNS name making it in line with statd.

Anybody has any thoughts as to whether statd or lockd needs to change?

