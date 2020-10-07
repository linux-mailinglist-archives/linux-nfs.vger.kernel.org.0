Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED5A28621C
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 17:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgJGP1V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 11:27:21 -0400
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:36496 "EHLO
        elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726854AbgJGP1V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 11:27:21 -0400
X-Greylist: delayed 3170 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2020 11:27:21 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1602084441; bh=mqpTKDCdlvA6+ECKVTivKpO1EznK24Kn0xYQ
        Z2MazRI=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:
         X-Originating-IP; b=EyCtvh+S1h8UxOk7AVsBHLHYfw81M8udmnN8zOCctqBLgA
        VXBwW0599RFxFFZqGFNfqTLxVB7dBm3eFKW0jtThycQcd+NqboSgWBYQChbkVIQJCN1
        Nq4TX5JrxnyCHkz1kx88Y6omUYSj+cvsGEevQpLoIVbn/ZunawT+8OaKjYvMlO5+AHc
        lxJdzZASF83kyqKLvIwLaZjojwEbUrg96BQT+PfkHYchCc9N4NQN33ccFHP5WhNUSca
        uydN3LMpeMIpOyUnyeF6aUB9PJFcS4k8o18EbrVJIPnM7lrzNm+L8D+TPHFjoHoMAxr
        /k/JpUT0GN/D6xK0V/XM3/4SzDlA==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=LziF18vBTOZrV1mNjhONVny7kjuMIefAAsKIzguFgWQx3LgWM3c2FYq+Wef9rI/8g0oak1Re6CF/TGqgBqTfNjN3nxLxHsunNAxmjlHwCwFN1O09p+VLZaEhF+FGpmXz2MF75KSJ56ZGhlupvTLVdzFOrCqzD+Dh6rZOp+FzGv/bcl/diodFcan+qKjgQN89iYHrPjUzJXJj0tRNDsr9IjeQjdQEqFM3DNiVo114joti9X+V+Np+AHHu9ztCxSOuU8FoCMQkbyXF7ixmLLiJTvHOPESm9hplkfd2NaZ5hlCm9gOm1neCwoiGFhKjMpb6Z8zHzDreu0eUGQMYwusSkg==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-mealy.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1kQAWS-000An1-MX; Wed, 07 Oct 2020 10:34:28 -0400
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Kenneth Johansson'" <ken@kenjo.org>
Cc:     "'Patrick Goetz'" <pgoetz@math.utexas.edu>,
        <linux-nfs@vger.kernel.org>
References: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org> <5326b6a3-0222-fc1a-6baa-ae2fbdaf209d@math.utexas.edu> <923003de-7fcf-abee-07a2-0691b25673d8@kenjo.org> <20201006181454.GB32640@fieldses.org> <07f3684e-482e-dc73-5c9a-b7c9329fc410@kenjo.org> <20201007131037.GA23452@fieldses.org>
In-Reply-To: <20201007131037.GA23452@fieldses.org>
Subject: RE: nfs home directory and google chrome.
Date:   Wed, 7 Oct 2020 07:34:27 -0700
Message-ID: <031501d69cb6$f6843a10$e38cae30$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLIQ3s6wHv8ZbLs/sGOp0WaWyTAbgDSaKHBAKEdRl0BxfAQ1wDdQHzFAlI6bMSndZ2bIA==
Content-Language: en-us
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4d1dfd63b734438b519ed8233604749763350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> -----Original Message-----
> From: J. Bruce Fields [mailto:bfields@fieldses.org]
> Maybe I overlooked the obvious: if Chrome holds a lock on that file =
when you
> suspend, and if you stay in suspend for longer than the NFSv4 lease =
time (default
> 90 seconds), then the client will lose its lease, hence any file =
locks.  I think these
> days the client then returns EIO on any further IO to that file =
descriptor.
>=20
> Maybe there's some way to turn off that locking as a workaround.
>=20
> The simplest thing we can do to help might be implementing "courteous =
server"
> behavior: instead of automatically removing locks after a client's =
lease expires,
> it can wait until there's an actual lock conflict.  That might be =
enough for your
> case.
>=20
> There's been a little planning done and it's not a big project, but I =
don't think it's
> actually at the top of anyone's todo list right now, so I'm not sure =
when that will
> get done.

I've had courtesy locks on my back burner for Ganesha though I hadn't =
thought about that there might actually be an important practical issue. =
Does any other server implement them? If we suggest this as a solution =
to the Chrome suspend issue, it might be good to assure that the major =
server vendors implement this.

There is a problem with the courtesy locks for this solution though... =
The clientid is still going to be expired, and the locks are associated =
with the clientid, so unless we allow courtesy re-instatement of expired =
clientids, courtesy locks don't actually solve the problem...

Option - use NFSv3 instead :-) The lack of lock expiry due to AWOL =
client would work in a suspended client's favor... Note also that a =
suspended client could be a VM, for example, VirtualBox allows saving =
and suspending a VM in running state.

Interesting problem...

Frank

