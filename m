Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7EC96939
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfHTTOz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Aug 2019 15:14:55 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:34454 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfHTTOz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Aug 2019 15:14:55 -0400
Received: by mail-wm1-f50.google.com with SMTP id e8so3095838wme.1
        for <linux-nfs@vger.kernel.org>; Tue, 20 Aug 2019 12:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc-de.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc:message-id:references
         :to:content-transfer-encoding;
        bh=2kU4uk+Z4MiYCrqKdH3XosKCp3vOvIPNJoyu6ecn97k=;
        b=GFlxrjn6nfShheVNX8nxJEqL/5RwxUrYJllNyGEaZTlIITgVDXuxmQJjyh8Qq2BkHc
         1gdqPBd/GC9TkcGgnjDJvi5CLt5mzWwGAd7yA9mQ6g3pn27mBt3q9OZQfItzYXJq3ZvV
         bb1R0hKrgkp/Nt/1XwUhGWsii32wE7yuOnHP692hasWFfX0Axe21sdHsLJpxpYwcLanj
         1VE7gfo5/5rIwhNQ7HUhwojDC/E/iTiKOWWdyKE7aWopUTZAEDJm5WV/HQ0eSizik49V
         dtp9wVIlgXsJnHcZQOzJ1JJtnIvwag16fSm0HgK1ZIVfJedMNMiYa9kKvY26NJsZMlyS
         RazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :message-id:references:to:content-transfer-encoding;
        bh=2kU4uk+Z4MiYCrqKdH3XosKCp3vOvIPNJoyu6ecn97k=;
        b=Y9ZRssCwb+dHALrLQPj6Ui9KO9q08dtxjkQG1jFgfn/Q5Vi2NrUQcuRxXSFOFIXS3f
         0621ILJqabmVARZAVY2UpDTJhaDFU6rLzeNu3w7OFB7qx0UfJXouGGZLP2rLgoEANLtj
         9uTE6+PjNKLHEllbuvGFMgO32FW4MQemqRMh7PnYnus45lfMK9w7hrsBH8fywmphFH2r
         wnZLMfDoJe/jQVf+J/gH4kYAjAk/DHmneuH0anUEXsQetwhjH38jIiOYvptEKW0P7IB2
         8WyQ0AJGM8EgjP9i5497ZeUKj9X5TuT9TGYeAYuAxmPKpTg0/1YeWta34kikJR0Ds+dN
         M6iQ==
X-Gm-Message-State: APjAAAXj9/0NJTm4vgr7hBGvx4Lbnq4sNyFaDo7Nw1v5Juj9ng+BLKRF
        D6eNzEuDkS4DKdwryd/2yTDUPyT3uOshzphjBWMAkLtkA7cFSlkWQESfYyBmO0lL4zcRMXogn0n
        9Je8hx+j9JYmSpzkBy+4=
X-Google-Smtp-Source: APXvYqyJcee7WQEBlB6Msr65sEf3vJrfsD/xmnME8upYWNI4d1FzxydrVmbi4lofzjbr8SWqYLw5Jg==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr1538470wmh.173.1566328492826;
        Tue, 20 Aug 2019 12:14:52 -0700 (PDT)
Received: from ?IPv6:2a02:8070:88af:ff00:90c9:8aa4:8e4c:e414? ([2a02:8070:88af:ff00:90c9:8aa4:8e4c:e414])
        by smtp.gmail.com with ESMTPSA id s64sm2111152wmf.16.2019.08.20.12.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 12:14:51 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Does NFSv4 translate POSIX ACL's?
From:   Daniel Kobras <kobras@puzzle-itc.de>
In-Reply-To: <87bee5fc-5461-01b2-ad9d-9c60e86396c1@math.utexas.edu>
Date:   Tue, 20 Aug 2019 21:14:51 +0200
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-Id: <224D3569-14EA-4533-A5DC-CD4903EF4772@puzzle-itc.de>
References: <87bee5fc-5461-01b2-ad9d-9c60e86396c1@math.utexas.edu>
To:     "Goetz, Patrick G" <pgoetz@math.utexas.edu>
X-Mailer: Apple Mail (2.3445.104.11)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!

> Am 20.08.2019 um 20:35 schrieb Goetz, Patrick G <pgoetz@math.utexas.edu>:
>=20
> I have an NFSv4 exported folder (base filesystem: XFS) which must afford=
=20
> read access to a program on folders which are otherwise hidden from the=
=20
> public.  On the NFS server:
>=20
>   root@kraken:/EM/EMtifs# getfacl pgoetz
>   # file: pgoetz
>   # owner: pgoetz
>   # group: cns-cnsitlabusers
>   user::rwx
>   group::r-x
>   other::---
>   default:user::rwx
>   default:user:cryosparc_user:r-x
>   default:group::r-x
>   default:mask::r-x
>   default:other::---

There=E2=80=99s only a default ACL (which is inherited to new objects), but=
 no proper ACL on the directory itself. Have you tried

  setfacl -m u:cryosparc_user:rx

already?

Kind regards,

Daniel
--=20
Daniel Kobras
Principal Architect
Puzzle ITC Deutschland
+49 7071 14316 0
www.puzzle-itc.de







--=20
Puzzle ITC Deutschland GmbH
Sitz der Gesellschaft: Jurastr. 27/1, 72072=20
T=C3=BCbingen

Eingetragen am Amtsgericht Stuttgart HRB 765802
Gesch=C3=A4ftsf=C3=BChrer:=20
Lukas Kallies, Daniel Kobras, Mark Pr=C3=B6hl

