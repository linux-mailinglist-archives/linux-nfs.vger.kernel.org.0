Return-Path: <linux-nfs+bounces-7314-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEF09A5771
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 01:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065E6280A48
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Oct 2024 23:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862E418EFED;
	Sun, 20 Oct 2024 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByfMJIPg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DB745F4
	for <linux-nfs@vger.kernel.org>; Sun, 20 Oct 2024 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729465783; cv=none; b=m4DZITH0JD4elhiLMnA1qGW6DpM/TU0RfNLpqDMxy/7ClLi2WamDXmhORERt6F9DQP635RSShQMhC5qgWuXXqJ7UwVSRKP/UtSrlvRjHtkxMlCK5WdFJlLP+Nhmej9efG1+1ji/w0tT55lojK9lOreX0ZnpPOAMfDDCcoxhN3xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729465783; c=relaxed/simple;
	bh=Rq9d6NDu0aTgSdUzBdmOdLcL5k1Ar1YjiBbptiHm3D4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eI6WiCqgADqI+8yZMKFxGiaFgcxFw1GudUweNav9gry5GgZRQw0GtBtTMAp/ZjkHsYjEvaFRbpKjXMOSF9TH8Aqa6mxjA7GSCP/FlNS2LzgoOBW38FIi/fxZirMpDr1nurMsovDTqQ73JUjS+kvOztg1Ledd18PL3Wd+FKoRgps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByfMJIPg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so1263703a12.0
        for <linux-nfs@vger.kernel.org>; Sun, 20 Oct 2024 16:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729465779; x=1730070579; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YWTMimHXsYLDAgNP13K22FdpYQ7If7d/WSH0YZRdtsI=;
        b=ByfMJIPgtRi0uDwbIj4auP1OjBMv+46K/aopMiI8iTFVwMIDFfgQCxQOtcex5k1Or7
         8OmiF5fI4rFvMQlPvso6BNWKE8zhwb3ONJqpdMOB4ixeIqxhWDvARunpYj++0BKBbcLC
         Y5HOR6ZVpb0gIujlHfrcDSADDGArQbdQAJyX0mf6sL18HkKmp09vU7/iwhDGrudQ5NRO
         C9iblGxqU5cF6MvYRH8SG14Wbok6jBLgwUQjZVANd6EIB9vyLNmk1KPKLUYe+LSIFXAR
         N/wsNLGFfcpmaH8fwNqq5+QwI7uFokx3HAqW6wzaMJEBQ8fxWhPhWpcSSYPeAO/Vr5bA
         diWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729465779; x=1730070579;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWTMimHXsYLDAgNP13K22FdpYQ7If7d/WSH0YZRdtsI=;
        b=PM6lcKqm0EG74+tQkTrOCHCyJEGXsxzTf6Nu3KVXNjPpNYR89xfuu4Sf4raO22W+vY
         0I9xfu1ybZ05Xgm9DwrAxvcc5gP7QHwzkg5kGlDc9VJjC6MxyerSK7wEeg0Exmuw0egz
         ZMoN1WxjtV1dS/VFSbSQy0/eoNeAqL+ows0aN98+TF7IYGeTjA7F/a9b7uG2i5DcYjAc
         YD+/Bm9GqwiV3VgTxWzLI8d1Ngsr4X8ogWKomoCIEezi0JCT9q14Zfyn60G0fTyfG6TB
         khdmfWJgt1n2r2TAkS0Ibhb8RUMZrmLmHnnoj839SJD7XjkOodiJy44RfNcslyLlHsh6
         lLMg==
X-Gm-Message-State: AOJu0YxYSgLPPumXRfql8uH5JX5dbImX1dn6eQ2JqqD5amvmVSCE1bn6
	H4Uua+DbYtqkK432Jne7Cztr5f+yvtRoPHu/Rw1XeV7w/QeS1Oglduap5yMzvbeP1FkGnDVlA5s
	tlLESlGWiASPSAUGKTCaCWhnxtAkB0XsKzQ==
X-Google-Smtp-Source: AGHT+IFD2yv2kNN9OC9qpKnPlp1eHCD25gBW9mQt2yBLB6G8zF5gE2YKJLSPrhWDC/H4ik7em+BdD6Uu1wENwUy92EY=
X-Received: by 2002:a05:6402:26ce:b0:5c9:87a0:4fcc with SMTP id
 4fb4d7f45d1cf-5ca0ac62747mr8638133a12.16.1729465779192; Sun, 20 Oct 2024
 16:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 20 Oct 2024 16:09:29 -0700
Message-ID: <CAM5tNy4S0O28CcDGV43BWXegSZSPVEYgFKpaLxLSNSgjti_L5Q@mail.gmail.com>
Subject: RFC: Dealing with large POSIX draft ACLs for NFSv4.2
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

As some of you will already know, I have been working on patches
that add support for POSIX draft ACLs to NFSv4.2.
The internet draft can be found here, if you are interested.
https://datatracker.ietf.org/doc/draft-rmacklem-nfsv4-posix-acls/

The patches now basically work, but handling of large POSIX
draft ACLs for the server side is not done yet.

A POSIX draft ACL can have 1024 aces and since a "who" field
can be 128 bytes, a POSIX draft ACL can end up being about 140Kbytes
of XDR. Do both the default and access ACLs for a directory and it
could be 280Kbytes. (Of course, they usually end up much smaller.)

For the client side, to handle large ACLs for SETATTR (which never
sets other attributes in the same SETATTR), I came up with some
simple functions (called nfs_xdr_putpage_bytes(), nfs_xdr_putpage_word()
and nfs_xdr_putpage_cleanup() in the current client.patch) which
fill the large ACL into pages. Then xdr_write_pages() is called to
put them in the xdr stream.
--> Whether this is the right approach is a good question, but at
      least it seems to work.

For the server, the problem is more difficult, since a GETATTR reply
might include encodings of other attributes. (At this time, the proposed
POSIX draft ACL attributes are at the end, since they have the highest
attribute #s, but that will not last long.)

The same technique as for the client could be used, but only if there
are no attributes that come after the POSIX draft ACL ones in the XDR
for GETATTR's reply.

This brings me to one question...
- What do others think w.r.t. restricting the POSIX draft ACLs to only
  GETATTR (and not a READDIR reply) and only with a limited set
  of other attributes, which will all be lower #s, so they come before
  POSIX draft ACL ones?
  --> Since it is only a personal draft at this time, this requirement
        could easily be added and may make sense to limit the size
         of most GETATTRs.
This restriction should be ok for both the LInux and FreeBSD clients,
since they only ask for acl attributes when a getfacl(1) command is
done and do not need a lot of other attributes for the GETATTR.

Alternately, there needs to be a way to build 280Kbytes or more
of XDR for an arbitrary GETATTR/READDIR reply.

Btw, I have not tested to see what happens if a large POSIX draft
ACL is set for a file (locally on the server, for example) and then
a client does a GETATTR of the acl attribute (which replies with
a NFSv4 ACL created by mapping from the POSIX draft ACL).
--> I have a hunch it will fail, but I need to test to be sure?

Thanks in advance for any comments w.r.t. this issue, rick
ps; In particular, I'd like to know what others think about adding
      the restriction on acquisition of the POSIX draft ACLs by GETATTR.

