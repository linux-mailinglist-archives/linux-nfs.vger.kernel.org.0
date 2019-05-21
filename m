Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 416C0257FC
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 21:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfEUTGN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 15:06:13 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54975 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfEUTGN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 May 2019 15:06:13 -0400
Received: by mail-it1-f196.google.com with SMTP id h20so4389683itk.4
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2019 12:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PpBjOXliPDGKe+n8t3K2GuISil74QwsDit9UFKxUzcI=;
        b=EzaU0sHSV7Zmp+h98JyYb75ABCJIh60ZAAz8wIK6EhmsEA6yY3NNxxTjc69ySxjE9k
         QYS/KHva6TVpu9eqnvklzE7I/2UoNpbwJ9jvYGIoRLB67dQw6OXVeSeujKBovsHJuALl
         qouDj0WJHEwKK2ExCNL7vHngB7Rg+A2rECwT3f8BF8pqcEdhgB0UFXjtyfKzXFV+2ZrT
         WBFQJJaFo9Q2K5YRNXCADTF0NBzUEuB1jpMm2mqK64Ft0NTsj4sIIg2T7r1JlKF1K6HY
         dkTxAuVTGkXQ9vR649kxqMrAhLnLnIoshAp35X3yaDihtTEbYdYFm4VE8qV+ZBbdSdjN
         PdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PpBjOXliPDGKe+n8t3K2GuISil74QwsDit9UFKxUzcI=;
        b=DuWkTsDZ+U+5AFsoS5L9xTULwFREK6A4xoX+1i1cLlZQvQ0nKnY6Hvb0xlvGBgVaR0
         AvB4yinDNMskuh/vNqFZcbbApP+PKFjMyEjSQIDor0alN04DlKlelKRjv8BSA3K6HX43
         1SQyPe8XDTgQJOixmSyqYknbKdYXqk31DYKEY6sTk3k19HFrrPJHLUtwBRuzJq66RwzH
         bcDcWWFFQ1/szsdSXe20YH68O1enkn5/pXRLx5sJchWrcsxCG7kikV6zgrbgisVIRczF
         rY2p1zttQouqk2pKOTyelHJkq+dmJHZFyfnG4zPM/5U/hZFKWeEd1/LfyTZYUrulIRBr
         JEVw==
X-Gm-Message-State: APjAAAV6aLGvMIJ6dczR4ASTzVcTHZbEkv8sxqA1vsQtzYkWJPr2+3qq
        Gp3sSPLIBmQa41qH47W5ocA=
X-Google-Smtp-Source: APXvYqxt79jc8F+zNBYnI9CO+j8xPJUjGRzhGNoXX75USVF0bi6BJ1aT3gCxX82lozrukQvaYToUuA==
X-Received: by 2002:a24:6e90:: with SMTP id w138mr5256692itc.150.1558465572305;
        Tue, 21 May 2019 12:06:12 -0700 (PDT)
Received: from anon-dhcp-171.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p78sm1738563itp.35.2019.05.21.12.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 12:06:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <25ce1d3aa852ecd09ff300233aea60b71e6e69df.camel@hammerspace.com>
Date:   Tue, 21 May 2019 15:06:08 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <SteveD@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BB55244-E893-47A2-B4CB-36CA991A84B0@gmail.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
 <708D03B6-AEE1-42D6-ABDF-FB1AA5FC9A94@gmail.com>
 <25ce1d3aa852ecd09ff300233aea60b71e6e69df.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 21, 2019, at 2:17 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Tue, 2019-05-21 at 13:40 -0400, Chuck Lever wrote:
>> Hi Trond -
>>=20
>>> On May 21, 2019, at 8:46 AM, Trond Myklebust <trondmy@gmail.com>
>>> wrote:
>>>=20
>>> The following patchset adds support for the 'root_dir'
>>> configuration
>>> option for nfsd in nfs.conf. If a user sets this option to a valid
>>> directory path, then nfsd will act as if it is confined to a chroot
>>> jail based on that directory. All paths in /etc/exporfs and from
>>> exportfs are then resolved relative to that directory.
>>=20
>> What about files under /proc that mountd might access? I assume these
>> pathnames are not affected.
>>=20
> That's why we have 2 threads. One thread is root jailed using chroot,
> and is used to talk to knfsd. The other thread is not root jailed (or
> at least not by root_dir) and so has full access to /etc, /proc, /var,
> ...
>=20
>> Aren't there also one or two other files that maintain export state
>> like /var/lib/nfs/rmtab? Are those affected?
>=20
> See above. They are not affected.
>=20
>> IMHO it could be less confusing to administrators to make root_dir an
>> [exportfs] option instead of a [mountd] option, if this is not a true
>> chroot of mountd.
>=20
> It is neither. I made in a [nfsd] option, since it governs the way =
that
> both exportfs and mountd talk to nfsd.

My point is not about implementation, it's about how this functionality
is presented to administrators.

In nfs.conf, [nfsd] looks like it controls what options are passed via
rpc.nfsd. That still seems like a confusing admin interface.

IMO admins won't care about who is talking to whom. They will care about
how the export pathnames are interpreted. That seems like it belongs
squarely with the exportfs interface.


--
Chuck Lever
chucklever@gmail.com



