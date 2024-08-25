Return-Path: <linux-nfs+bounces-5709-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA45195E5A5
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 01:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B871F214E9
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Aug 2024 23:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001917407A;
	Sun, 25 Aug 2024 23:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLYe/Uv3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCBF2D60C
	for <linux-nfs@vger.kernel.org>; Sun, 25 Aug 2024 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724627580; cv=none; b=Y0vPXMG3ovgjVilRWDChVrsks1UVv1i/ejUPZJh238KGkQYGzSAgwLOzw8Uy4nnAb+gM8IjPRg7PI5dM7YMSQ7wMPKIfkNQ2o7Nsa+b9i/oB9jxvGSi1/JwyHBjjJ/MeuGw4XOExGMP9HqJhgWrjT9GbDwoFjui/Y2GAkyYunnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724627580; c=relaxed/simple;
	bh=s4yUets6fisgIV3mhcuWx9Hgv4TYlqVIkEdFFD/VYhc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DL9Fy1OCIN83lnFg3PJ3jSBzEJwIvzYT2Gf9BDD5u75sqJgQGdH43COGao5yUtkeOf6f0Yz6388Oqz1NBbeo2NkDcEacUzAOvdEcZe3S/+JLjVl1h25zdlSarT+4tOqWBRx0IRGZQv1xgyGjGJwrDPGQdLDFxpOgkPSYFReLK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLYe/Uv3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2025031eb60so31422585ad.3
        for <linux-nfs@vger.kernel.org>; Sun, 25 Aug 2024 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724627579; x=1725232379; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zdvUF3uw6CPf+ICAv8wO0cvl5KJHpMSgSTrYBO2vbnk=;
        b=jLYe/Uv3rGGEfYpoPa7CJ8TTOOZFdfmmHLABoVnOvXEGmbsj3X7l2gsSnwrv+89scZ
         5Ikl6qI4J/oo6t+rldJNg66/ZF9HgyT9WjjleIcSLpXiyCpmu0buYUEYnbbtgi4UeU3S
         I0NkRBRDJq+z6SwBr0IvHbn/4yfgPGeHowtT8gy7REGt020kMOksv7H3gNmeLV4PGkBh
         mSltGLSZqkreCEZTlTbPgQtcPeTWS6g6QvwrA1uHjEqLKjjpUTc8piftvCOyyzYyh3vg
         4cIsCHKVah+sPWjjfKRC7kLSdlzzn9Gi3IrbPVK8kIZee6U6GwnHkCzeFL3al5uIfouO
         oVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724627579; x=1725232379;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdvUF3uw6CPf+ICAv8wO0cvl5KJHpMSgSTrYBO2vbnk=;
        b=MP7eJEtzoHmHQmKjx7GMgO9rHBGKu7cKRs6oDptmVNsehOn4Jmw6SXpO4Fnezs4wUC
         vkFuw8X+lHOyW9klP0tCbIuKHFg52VY8lGildEnqDOGgkGbVEb851RJxO6LFbgcH7xdT
         ZzRo5qG7RdSi03uA/Ll3SiLg2B375I69CB7J4R2ARkAlOaC3T+89RrRSmZqglTAt3aJ8
         esJkfpiKXLNSM8BDFNk4jCjdHpR9cQgqfa249sMFqdA1hMpQwt76nLb0ohd2RSG9V6is
         6Hga11AmEtxSgrVBlWtXtXDgh9p8JSrolgAUs459Xa70ljR0oTq7xChv139AwwIaTbDZ
         Aphw==
X-Gm-Message-State: AOJu0Yw02IpfNFX11mVGCW94yEZpYBUA3kcyhW8JH4h4EA479bNObvOd
	L9xwTI6XAazj0ZxjhrFc7yvIhE1QhU/LU1jzbrc/DYJCAhQBFPBRh9lPSuN0U8q8nJFNjIh4EX4
	omWb6+mImc9CZHWcbWk/AlUiwsyMY3u8=
X-Google-Smtp-Source: AGHT+IFNbHmBDh620vI9SAbD/eRC9JU2GDCVH5174n7UVdto/A4C9RUvzjCM/QuCn9mjrjo8WgUu7yzcVBpdWXdiFWc=
X-Received: by 2002:a17:903:32cf:b0:1fd:927e:7d1e with SMTP id
 d9443c01a7336-2039e48936emr85216555ad.26.1724627578564; Sun, 25 Aug 2024
 16:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 25 Aug 2024 16:12:48 -0700
Message-ID: <CAM5tNy4jHFikM7O2UcZxk_1z9F11=-c31cxhMqbvheLfCi9q=w@mail.gmail.com>
Subject: Linux NFSv4 client patch for testing of the POSIX ACL extension
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Here is a crude patch for the NFS client that can be used for testing the
POSIX ACL extension to NFSv4.2 described in draft-rmacklem-nfsv4-posix-acls.
It is done against a linux-6.3 kernel, but hopefully can be applied
to newer sources fairly easily.

For now, the patch is here:
https://people.freebsd.org/~rmacklem/linux-posixacl.patch

I am hoping this patch will encourage someone to do testing during
the late Oct. NFSv4 Bakeathon.

Since I am not familiar with the Linux NFS client code, there is a
lot left to clean up before it would be useful for more than testing.
Here's a few items:
- The NFSACL protocol code pre-allocates pages for large ACLs. I do not do that.
  Unlike NFSACL (which puts uids/gids on the wire), the NFSv4 extension
  uses "who" strings, which can be up to 128 bytes (IDMAP_NAMESZ).
  As such, a maximum size POSIX ACL with 1024 ACEs can end up over
  140Kbytes on the wire.
  I currently use xdr_stream_XXX() functions to fill out the encoded xdr,
  which seems to work?
  Thought needs to be put into how to handle large POSIX ACLs.
  - I haven't even tested large ACLs yet.
- When I needed functions that were in nfs3acl.c or in nfs_common/nfsacl.c
  but "static", I just copied them into nfs4proc.c.
  (I think they could go in nfs_common/nfsacl.c as non-static and then
   be used by both nfs3 and nfs4 code, but I wasn't sure what the Linux
   tradition was?)
- There's a bunch of dprintk()s in the code I used for debugging.
  Most of them should go away once the code solidifies.
  (Most start at the left margin of the line.)
  --> I don't know how the trace stuff works.  That needs to be added.
- The GETATTR for the POSIX draft ACLs also acquires the acl_trueform
  attribute.  If that attribute is not set to ACL_MODEL_POSIX_DRAFT,
  a -EOPNOTSUPP is returned.  I think that will make getfacl(1) return
  a POSIX draft ACL based on mode, but I am not sure?
- I probably put stuff in the wrong places for a NFSv4.2 extension?
- There doesn't appear to be any bits left for NFS_CAP_xxx, so I
  just used the NFS_CAP_ACLS one. (There probably should be a separate one,
  but this might work ok?)

This one may only be a configuration problem, but even though I think
I have the uid<->name mapping working, nfs_map_uid_to_name() always
returns the "number in the string".
--> To get setfacl to work, I have to configure my test server to use
    "numbers in strings". (nfs_map_name_to_uid() does seem to work?)

Have fun with it, if you have the chance to look at it, rick

