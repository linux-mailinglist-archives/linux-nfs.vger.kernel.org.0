Return-Path: <linux-nfs+bounces-21730-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFxAOCzEDWql3AUAu9opvQ
	(envelope-from <linux-nfs+bounces-21730-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 16:24:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3442158F895
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 16:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FCEF3015E04
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1593E7179;
	Wed, 20 May 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg-com.20251104.gappssmtp.com header.i=@dneg-com.20251104.gappssmtp.com header.b="mouQ3tGT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1626733A71B
	for <linux-nfs@vger.kernel.org>; Wed, 20 May 2026 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286230; cv=pass; b=UCdAwMTLE0L/FzG/mnUuN0GGXgw+LG3aEe+NCVAhqSxESnHhpsgixn7VO185/MVs9qjM7uuyqH2WW+g3zy3c+oVlA7VrnwPzzmovJzsmaiaS0mg+EhkCax2ROQy/t5YXxm04Cj2S58z7Tqg9sHljDmea9MAPvwF49zbprVL7m6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286230; c=relaxed/simple;
	bh=mqaqPxa1foX0/KeYUYUzSS7a2e6ndq4GafeZ/r4tt0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JScftmEypG0aQ5lBtHSJWiYLAppHeFu3iMX2hIEDqnUht4bCqmvgw/g5BdnH/jb5Cpjxq/nKXVvRPOoBvWz26FTJZwHoDVZ+4TzqmyHah2PvSHWb5Cmkxqq/0Kdtiv7GojqgTDbhdyksNFTvdcLIeG9EFKVwml+FTLgrGGjVjBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brahma.io; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg-com.20251104.gappssmtp.com header.i=@dneg-com.20251104.gappssmtp.com header.b=mouQ3tGT; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brahma.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-95d439bd3a5so1081288241.3
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2026 07:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779286228; cv=none;
        d=google.com; s=arc-20240605;
        b=LahYLSlB+8xAnAkIYWa67ZXf1EkXH3nEw8/BDhsH39L0RtTSMRFqk10aalpFwm77Xh
         Tssp2IGvi3utM2I7kohSZc7zhZ/yaNquIZwLi7iJgQpxEb900pvZ0NSoEecqzCb0gw5n
         bvW7v9QGzoSyYKRy71Y3V2V/vVtdeeH2JdvAoqMJyjmFasVXT4yI90XitltqVPg+4Sly
         KoVsn5lxyd0IZip8B5241bD24sZgWuzlNlYXQLwY5Quqig/FRy+6isW+bctz3twTtXyK
         OtZf1ocBK+6QjU10STr7BFw4zPT4EkkOj1Ba6ggABvP4EThknx3JiR22jAfZVBLwoF7c
         kwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=grGNzNdMPao08e4v1JXkGhfwPCkGoIOA9l8S55NcUNQ=;
        fh=CVgIKUliOIEIejqvfkJpH5MHJs6z7PW01MEcU8aJ29E=;
        b=aNqGF/zFIuP2eGAOi6X0yvlenVNudnOkP2C2wW8oE1zY3C/8DzWOCyTyZ7wPacJk04
         c77mdfZSs67P1se0GW8OuSp4VDMQLt5N9KO5MVPpCK9X1y/n5thLQ71cVYxDWGB5TohY
         OX+HVOeuHJmkTJ22sEPGZQMg1EJ5CEL4jrNd6Z71NYJcSS5GVVvT/ycO2i/VQ59yyY9Q
         hO81+0JmojP4BVhRG4q3XiwBGMdAGOgVpWyPzAkrAxYmVQ9izKuN4jUPkQExugn4VIi6
         i0SbGTSf+wsnto8PrpTZWuBC8WeYF2jHTK5ueSK8YGuzBm7dW2LCmzDl8mq5ZitbYdc6
         eJ8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg-com.20251104.gappssmtp.com; s=20251104; t=1779286228; x=1779891028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grGNzNdMPao08e4v1JXkGhfwPCkGoIOA9l8S55NcUNQ=;
        b=mouQ3tGT8wWsC4L9ozWY4JIGl7FSYw8te92GYyQl+6cGVonBDAPKhubH7r0QtdHlsh
         kWwVdOIvqDnDLmHZItSykjZevzMmIYFkGNzCCwX+A9R12CJTe2R1kpQL3AbkoNBv8GW6
         unpqXIB7t2J2lbGSkVFN0kxYapnGULkbQwzzVXGJoQt86qwgKjWQIIDnfkgemeZPFqPX
         wZHqsJGqHSwJUR6SyraclfJpFMTF3lnZcLPaaJjRY4TnJXtkxF1XZn9+Tvx5H6z+sEoK
         ti1MdLqTQczfaiDMhraEblRjzARZdXejmXakBQUcmV3kAUN80nVVp9tST6BcARl6hlWS
         1Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286228; x=1779891028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=grGNzNdMPao08e4v1JXkGhfwPCkGoIOA9l8S55NcUNQ=;
        b=nNUePSw6wMcFQpdc3ojxmxUKfx2Q8MP7dZiT86fGcOvd+aIN4WhNPTgcmwdnALykK0
         BeZY4pG2lf/At9x5pgZ+K7GrNN353KJn+Pp1CZsdOgvisuz41jnFpVSvblgyF4ZILzz+
         HMNKL6+Q9vRvqDEE+5+x9EMbZIvkToExDuy9+tRmbpw3JeYNHfC0ue8Qw+kB7UR5GrAT
         5b40qcJeTATVza5ll9MRAGa392L2og5NRCg1WksLA9ZaDxcvwC4ZqHQ35NeJaZx6SyYL
         ct6jFP9grYD+Hyv9cVKyzfDdgH68wo0jRuakUWlJlFOsYfkYDolu2X0gTshn5dtBohDU
         q6eg==
X-Forwarded-Encrypted: i=1; AFNElJ+l0bQc9mkOZkUpnteqrSWkasMDAhbkqY+TZTjmCEYYOk15xv6XxMeSkWBwL9GhqDLIAh48sGQyqGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT2KS3Eov7ZiaWjS1d0MSSgTGt81xEK+2u8wv8I/y3uwXJkAhR
	Qb7BW415sQnOyEED184JMB1ub4oldYWTWuGALgXE2SXXxcsTxUFo8c8m4W+9882xXY4P3ka8gJs
	+Vl8Ve5x3XB6sFml8nI+IvCaWsNV4jRKags0nELErJA==
X-Gm-Gg: Acq92OHPgxxjAShNdHwQzPriVTbvwdIlDQsRCjFp1xRNVwNEVljPRrAExjAxytema8x
	2SgvzH/XwiASJ80pF6wVDr1DxRivbH0lemHHErCu1bnQplCEMx2eyZaL5HUrfkkDs2VYR6YUHOq
	xuRgsF5TstU7EsFeRJWPwzmdSRTA+1O7dVidigjpz1pRXBfmOixkIBdri/AaQY5tfvtNFNLR39Z
	qERsxwwrP5SZNLlsWntqzyThfrzqWVeOTjnItB+k2zj8NSF6NaeZFTvoTb546FDxe6gkOPGwiI1
	ckInRg==
X-Received: by 2002:a05:6102:2b99:b0:631:ea6b:23e1 with SMTP id
 ada2fe7eead31-63a3f8897c6mr11496635137.23.1779286226351; Wed, 20 May 2026
 07:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
 <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com> <3AB7EB6A-B207-4B91-A695-66C4704D0E31@hammerspace.com>
 <4c5dbb98-0209-4572-8eac-1578536bbd78@app.fastmail.com> <AED22AED-E97D-40E3-9839-BF8307EF8B65@hammerspace.com>
 <1a5c70d8-e7f4-4671-a29a-023be7c107fc@app.fastmail.com> <D56AF5A6-3419-4164-8FCD-D818500ED0D3@hammerspace.com>
In-Reply-To: <D56AF5A6-3419-4164-8FCD-D818500ED0D3@hammerspace.com>
From: Daire Byrne <daire@brahma.io>
Date: Wed, 20 May 2026 15:09:47 +0100
X-Gm-Features: AVHnY4KaTAnL7Rap7EVUjhaCiT74_U6BawgUek7m8KUdQ41828sT4e2COAovIus
Message-ID: <CAPt2mGPoDF0s0zuFJcyjt7YU-4bZBpzEpEQ1UTFp=_-+rtwkBQ@mail.gmail.com>
Subject: Re: [RFC] knfsd: per-client fair scheduling to prevent single-client starvation
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dneg-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[brahma.io];
	TAGGED_FROM(0.00)[bounces-21730-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dneg-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daire@brahma.io,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,brahma.io:url,hammerspace.com:email]
X-Rspamd-Queue-Id: 3442158F895
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We currently set svc_rpc_per_connection_limit =3D 4 on a lot of our
NFS(v3) servers that get hit by a large farm of 10G clients, just to
try and limit the damage that "greedy" clients can do.

This used to effectively be =3D 1 back in the RHEL7.3 days but it got
added around RHEL7.4 and suddenly our NFS storage servers kept hanging
due to that single change.

Back then it was all 1GigE clients and now they are all 10GigE, so we
use values of 4 or 8 atm. We also have ~512 knfsd threads per server

Daire


On Wed, 20 May 2026 at 01:41, Benjamin Coddington
<ben.coddington@hammerspace.com> wrote:
>
> On 19 May 2026, at 17:29, Chuck Lever wrote:
>
> > On Tue, May 19, 2026, at 6:02 PM, Benjamin Coddington wrote:
> >> On 19 May 2026, at 14:44, Chuck Lever wrote:
> >>
> >>> On Tue, May 19, 2026, at 5:08 PM, Benjamin Coddington wrote:
> >>>> Just to be clear - the issue I'm exploring isn't the same as when al=
l the
> >>>> kNFSD threads are slow due to their workload.  This is very much a
> >>>> multi-client dynamic where one client (or a group of automated clien=
t
> >>>> instances) are able to easily starve another simply because they cre=
ate the
> >>>> most connections.
> >>>>
> >>>> That's different from the other problem that we've discussed a bunch=
 at
> >>>> bakeathon and on the list previously.
> >>>>
> >>>> This is not so much a deadlock issue as it is an issue
> >>>> of per-client fairness.  I think this problem is in a different clas=
s.
> >>>
> >>> Does dynamic svc thread creation have any impact?
> >>
> >> I haven't tested it - I think it would just pin to max-threads for the
> >> workload in question.
> >
> > If the aggregate workload consumes all the threads, then that doesn=E2=
=80=99t
> > sound like xprt scheduling is the bottleneck. But I should look at
> > numbers instead of speculating.
>
> I can synthesize something..
>
>
> > Are you seeing connection loss in these scenarios?
>
> No - its not connection loss - its certain clients that see a
> dramatically-reduced level of service when other clients that have many,
> many more connections start loading the server.
>
> We have a small army of data-moving clients that compete with .. how do I
> say this .. "interactive" clients.  The data-moving clients open as many
> connections as they can and try to push operations very aggressively, but
> they compete with the "interactive" clients unfairly because of extra xpr=
ts.
> I would prefer the "interactive" clients be prioritized, but I don't cont=
rol
> their nconnect, and they can't compete with the connection count of the d=
ata
> moving clients.
>
> >> I'm probably not understanding you here, because for the problem I'm
> >> interested in fair would look like prioritizing each client's request
> >> queue equally, no matter how many xprts each client has.
> >
> > Then for NFSv4.1 and later, NFSD might schedule work on the session, an=
d
> > manage each session=E2=80=99s workload by raising and lowering the numb=
er of slots
> > in its slot table.
>
> Indeed, sounds good.  What about v3?
>
> Ben
>


--=20
Daire Byrne
www.brahma.io
Follow us on: LinkedIn | Twitter | Facebook | Instagram

This email (including attachments) may contain material that is
confidential and/or privileged for the sole use of the intended
recipient. Any review, disclosure, reliance or distribution by others
or forwarding without express permission is strictly prohibited. If
you are not the intended recipient, please contact the sender and
delete all copies including any attachments. Thank you.

